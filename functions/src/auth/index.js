const admin = require('firebase-admin')
const functions = require('firebase-functions')
const { indexDocument, indexInterests } = require('../../helper/index')
const { MENTEE } = require('../../constants/roles')

admin.initializeApp()
const auth = admin.auth()
const db = admin.firestore()

exports.newUser = functions.runWith({ memory: '8GB' }).firestore.document('users/{userId}').onCreate(async (snap, context) => {
    const { role, uid, first_name, last_name } = snap.data()
    var reviewed = role == MENTEE
    await auth.setCustomUserClaims(uid, { role, reviewed })

    const index = indexDocument(`${first_name} ${last_name}`, role)
    return snap.ref.update({
        index,
        reviewed,
        paddy_points: 0,
        sessions: 0,
        courses: 0,
    })
})

exports.updateUser = functions.runWith({ memory: '8GB' }).https.onCall(async (data, context) => {
    const { uid } = context.auth

    const userDoc = await db.collection('users').doc(uid).get()
    const { interests, first_name, last_name } = userDoc.data()

    if (interests == null) {
        return null
    }

    const index = indexInterests([`${first_name} ${last_name}`, ...interests])
    return userDoc.ref.update({ index })
})