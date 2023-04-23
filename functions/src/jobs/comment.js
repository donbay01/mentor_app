const functions = require('firebase-functions')
const admin = require('firebase-admin')

var path = 'jobs/{jobId}/comments/{commentId}'

exports.newComment = functions.runWith({ memory: '8GB' }).firestore.document(path).onCreate((snap, context) => {
    return snap.ref.parent.parent.update({ comments: admin.firestore.FieldValue.increment(1) })
})

exports.deleteComment = functions.runWith({ memory: '8GB' }).firestore.document(path).onDelete((snap, context) => {
    return snap.ref.parent.parent.update({ comments: admin.firestore.FieldValue.increment(-1) })
})