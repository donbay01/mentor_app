const admin = require('firebase-admin')
const functions = require('firebase-functions')
const { indexDocument, indexInterests } = require('../../helper/index')
const { MENTEE } = require('../../constants/roles')
const { sendEmail } = require('../../helper/email')

admin.initializeApp()
const auth = admin.auth()
const db = admin.firestore()
const rdb = admin.database()
const messaging = admin.messaging()

var userPath = 'users/{userId}'

exports.newUser = functions.runWith({ memory: '8GB' }).firestore.document(userPath).onCreate(async (snap, context) => {
    const { role, uid, first_name, last_name, email } = snap.data()
    var reviewed = role == MENTEE
    await auth.setCustomUserClaims(uid, { role, reviewed })
    // await auth.revokeRefreshTokens(uid)

    await rdb.ref().child('emails').push(email)

    const index = indexDocument(`${first_name} ${last_name}`, role)
    return snap.ref.update({
        index,
        reviewed,
        paddy_points: 0,
        sessions: 0,
        courses: 0,
        free_paddy_points: role == MENTEE ? 0 : 1,
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

exports.updatedAccount = functions.runWith({ memory: '8GB' }).firestore.document(userPath).onUpdate(async (change, context) => {
    const prev = change.before.data()
    const current = change.after.data()

    let title = 'Paddy account'

    if (prev.reviewed != current.reviewed && current.reviewed) {
        await messaging.send({
            token: current.token,
            notification: {
                title,
                body: 'Your account has been reviewed. You are free to access all the features available.',
            },
        })
        await sendEmail(
            current.email,
            title,
            'Your account has been reviewed. You are free to access all the features available.'
        )
    }

    return null
})