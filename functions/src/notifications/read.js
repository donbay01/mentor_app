const functions = require('firebase-functions')
const admin = require('firebase-admin')

const db = admin.firestore()

const { UNAUTHENTICATED } = require('../../constants/error')

exports.readDecline = functions.runWith({ memory: '8GB' }).https.onCall(async (data, context) => {
    if (context.auth == undefined) {
        throw new functions.https.HttpsError('unauthenticated', UNAUTHENTICATED)
    }

    const { notificationId } = data
    const userRef = db.collection('users').doc(context.auth.uid)
    const ref = userRef.collection('notifications').doc(notificationId)
    const n = await ref.get()

    const { isRead } = n.data()

    if (isRead == true) {
        return null
    }

    await ref.update({ isRead: true })
    return userRef.update({
        notifications: admin.firestore.FieldValue.increment(-1)
    })
})