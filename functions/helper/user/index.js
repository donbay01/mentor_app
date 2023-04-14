const admin = require('firebase-admin')
const db = admin.firestore()

exports.getUserData = async (uid) => {
    const doc = await db.collection('users').doc(uid).get()
    return doc.data()
}