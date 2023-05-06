const admin = require('firebase-admin')
const db = admin.firestore()

exports.getSessionsByTime = (timestamp) => {
    const ref = db.collection('sessions').where('startTimestamp', '==', timestamp)
    return ref.get()
}