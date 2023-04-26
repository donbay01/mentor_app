const functions = require('firebase-functions')
const admin = require('firebase-admin')

const db = admin.firestore()

const { UNAUTHENTICATED } = require('../../constants/error')

exports.clearNotifications = functions.runWith({ memory: '8GB', timeoutSeconds: 540 }).https.onCall(async (data, context) => {
    if (context.auth == undefined) {
        throw new functions.https.HttpsError('unauthenticated', UNAUTHENTICATED)
    }

    const userRef = db.collection('users').doc(context.auth.uid)
    await userRef.update({
        notifications: 0,
    })

    const ref = userRef.collection('notifications')
    return db.recursiveDelete(ref)
})