const functions = require('firebase-functions')
const admin = require('firebase-admin')

const db = admin.firestore()

exports.newReview = functions.runWith({ memory: '8GB' }).firestore.document('users/{uid}/reviews/{reviewId}').onCreate((snap, context) => {
    const { stars } = snap.data()

    return db.collection('users').doc(context.params.uid).update({ rating: admin.firestore.FieldValue.increment(stars) })
})