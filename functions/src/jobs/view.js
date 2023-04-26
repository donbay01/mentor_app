const functions = require('firebase-functions')
const admin = require('firebase-admin')
const db = admin.firestore()

const { UNAUTHENTICATED } = require('../../constants/error')

exports.addViews = functions.runWith({ memory: '8GB' }).https.onCall(async (data, context) => {
    if (context.auth == undefined) {
        throw new functions.https.HttpsError('unauthenticated', UNAUTHENTICATED)
    }

    const { jobId } = data
    const ref = db.collection('posts').doc(jobId)
    const viewRef = await ref.collection('views').doc(context.auth.uid).get()

    if (viewRef.exists) {
        return null;
    }

    await viewRef.ref.set({ uid: context.auth.uid, timestamp: admin.firestore.FieldValue.serverTimestamp() })
    return ref.update({
        viewers: admin.firestore.FieldValue.increment(1)
    })
})
