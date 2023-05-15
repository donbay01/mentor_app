const functions = require('firebase-functions')
const admin = require('firebase-admin')

const db = admin.firestore()
const messagin = admin.messaging()

const { UNAUTHENTICATED } = require('../../constants/error')
const { MENTOR, MENTEE } = require('../../constants/roles')
const { getUserData } = require('../../helper/user')

exports.joinedNotification = functions.runWith({ memory: '8GB' }).https.onCall(async (data, context) => {
    if (context.auth == undefined) {
        throw new functions.https.HttpsError('unauthenticated', UNAUTHENTICATED)
    }

    const { mentorUid, menteeUid, sessionId } = data
    const role = context.auth.token.role
    const isMentor = role == MENTOR

    const { token } = await getUserData(isMentor ? menteeUid : mentorUid)

    await db.collection('sessions').doc(sessionId).update({
        [`${role}_joined`]: true
    })

    return messagin.send({
        token,
        notification: {
            title: 'Video Call session',
            body: `${isMentor ? 'Paddy' : 'Buddy'} just joined`
        }
    })
})