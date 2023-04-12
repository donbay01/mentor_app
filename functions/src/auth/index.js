const admin = require('firebase-admin')
const functions = require('firebase-functions')
const { indexDocument } = require('../../helper/index')
const { MENTEE } = require('../../constants/roles')

const auth = admin.auth()

admin.initializeApp()

exports.newUser = functions.runWith({ memory: '8GB' }).firestore.document('users/{userId}').onCreate(async (snap, context) => {
    const { role, uid, first_name, last_name } = snap.data()
    var reviewed = role == MENTEE
    await auth.setCustomUserClaims(uid, { role, reviewed })

    const index = indexDocument(`${first_name} ${last_name}`, role)
    return snap.ref.update({ index, reviewed })
})