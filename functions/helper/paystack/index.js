const admin = require('firebase-admin')
const { getUserData } = require('../user')
const db = admin.firestore()

exports.getPlan = async (paystackId) => {
    const res = await db.collection('plans').where('paystackId', '==', paystackId).get()
    return res.docs[0].data()
}

exports.creditUser = async (uid, planData) => {
    const { expiredInterviews, expiredSessions } = await getUserData(uid)
    const { name, interviews, sessions } = planData
    const userRef = db.collection('users').doc(uid)

    const i = expiredInterviews ?? 0
    const s = expiredSessions ?? 0

    return userRef.update({
        interviews: admin.firestore.FieldValue.increment(interviews + i),
        sessions: admin.firestore.FieldValue.increment(sessions + s),
        plan: name,
        expiredInterviews: 0,
        expiredSessions: 0,
    })
}

exports.handlePay = async (uid, paystackId) => {
    const data = await this.getPlan(paystackId)
    return this.creditUser(uid, data)
}

exports.saveAuthorisation = (email, uid, authorisation, planId) => {
    const currentDate = new Date()
    currentDate.setMonth(currentDate.getMonth() + 1)
    currentDate.setHours(0, 0, 0, 0)

    var nextCharge = admin.firestore.Timestamp.fromDate(currentDate)

    return db.collection('authorisation').doc(uid).set({ ...authorisation, email, nextCharge, planId })
}