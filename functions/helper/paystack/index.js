const admin = require('firebase-admin')
const db = admin.firestore()

exports.handlePay = async (uid, paystackId) => {
    const res = await db.collection('plans').where('paystackId', '==', paystackId).get()
    const { name, interviews, sessions } = res.docs[0].data()

    const userRef = db.collection('users').doc(uid)
    return userRef.update({
        interviews: admin.firestore.FieldValue.increment(interviews),
        sessions: admin.firestore.FieldValue.increment(sessions),
        plan: name,
    })
}