const admin = require('firebase-admin')
const { getUserData } = require('../user')
const { Timestamp } = require('firebase-admin/firestore')
const db = admin.firestore()

exports.getPlan = async (paystackId) => {
    const res = await db.collection('plans').where('paystackId', '==', paystackId).get()
    return res.docs[0].data()
}

exports.creditUser = async (uid, planData) => {
    const { expiredInterviews, expiredSessions } = await getUserData(uid)
    const { name, interviews, sessions, duration } = planData
    const userRef = db.collection('users').doc(uid)

    var today = new Date()
    var mod = today.setMonth(today.getMonth() + duration)
    var payDate = new Date(mod).setMinutes(0, 0, 0)

    const i = expiredInterviews ?? 0
    const s = expiredSessions ?? 0

    return userRef.update({
        interviews: admin.firestore.FieldValue.increment(interviews + i),
        sessions: admin.firestore.FieldValue.increment(sessions + s),
        plan: name,
        expiredInterviews: 0,
        expiredSessions: 0,
        payDate: Timestamp.fromDate(new Date(payDate))
    })
}

exports.handlePay = async (uid, paystackId) => {
    const data = await this.getPlan(paystackId)
    return this.creditUser(uid, data)
}

exports.saveAuthorisation = (email, uid, authorisation, planId) => {
    return db.collection('authorisation').doc(uid).set({ ...authorisation, email, planId })
}