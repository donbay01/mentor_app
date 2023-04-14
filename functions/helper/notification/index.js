const admin = require('firebase-admin')

const db = admin.firestore()
const messaging = admin.messaging()

exports.sendNotification = async (token, uid, title, body) => {
    await db.collection('users').doc(uid).collection('notifications').add({
        title,
        body,
        timestamp: admin.firestore.FieldValue.serverTimestamp(),
    })

    return messaging.send({
        token,
        notification: {
            title,
            body
        }
    })
}