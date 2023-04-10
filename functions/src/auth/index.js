const admin = require('firebase-admin')
const functions = require('firebase-functions')
const { indexDocument } = require('../../helper/index')

const auth = admin.auth()

admin.initializeApp()

exports.newUser = functions.runWith({ memory: '8GB' }).firestore.document('users/{userId}').onCreate(async (snap, context) => {
    const { role, uid, first_name, last_name } = snap.data()
    await auth.setCustomUserClaims(uid, { role })

    const index = indexDocument(`${first_name} ${last_name}`, role)
    return snap.ref.update({ index })
})