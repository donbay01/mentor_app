const admin = require('firebase-admin')
const db = admin.firestore()

exports.getPlan = async (paystackId) => {
    const res = await db.collection('plans').where('paystackId', '==', paystackId).get()
    return res.docs[0].data()
}

exports.creditUser = (uid, planData) => {
    const { name, interviews, sessions } = planData
    const userRef = db.collection('users').doc(uid)
    return userRef.update({
        interviews: admin.firestore.FieldValue.increment(interviews),
        sessions: admin.firestore.FieldValue.increment(sessions),
        plan: name,
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