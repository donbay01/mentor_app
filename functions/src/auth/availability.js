const functions = require('firebase-functions')

exports.newSchedule = functions.runWith({ memory: '8GB' }).firestore.document('users/{userId}/availables/{shiftId}').onCreate((snap, context) => {
    return snap.ref.update({ shiftId: snap.id })
})