const functions = require('firebase-functions')
const admin = require('firebase-admin')

const messagin = admin.messaging()

const { UNAUTHENTICATED } = require('../../constants/error')
const { MENTOR } = require('../../constants/roles')
const { getUserData } = require('../../helper/user')

exports.joinedNotification = functions.runWith({ memory: '8GB' }).https.onCall(async (data, context) => {
    if (context.auth == undefined) {
        throw new functions.https.HttpsError('unauthenticated', UNAUTHENTICATED)
    }

    const { mentorUid, menteeUid } = data
    const isMentor = context.auth.token.role == MENTOR

    const { token, first_name, last_name } = await getUserData(isMentor ? menteeUid : mentorUid)

    return messagin.send({
        token,
        notification: {
            title: 'Video Call session',
            body: `${first_name} ${last_name} just joined`
        }
    })
})