const functions = require('firebase-functions')
const admin = require('firebase-admin')

const db = admin.firestore()

exports.newReview = functions.runWith({ memory: '8GB' }).firestore.document('users/{uid}/reviews/{reviewId}').onCreate(async (snap, context) => {
    const { stars, sessionId, review } = snap.data()

    return db.collection('sessions').doc(sessionId).update({ stars, review })
})