const functions = require('firebase-functions')
const { UNAUTHENTICATED } = require('../../constants/error')
const { getUserData, updateUser } = require('../../helper/user')
const { MENTOR } = require('../../constants/roles')
const { sendEmail } = require('../../helper/email')

exports.switchRole = functions.runWith({ memory: '8GB' }).https.onCall(async (data, context) => {
    if (context.auth == undefined) {
        throw new functions.https.HttpsError('unauthenticated', UNAUTHENTICATED)
    }

    const { newRole } = data
    const { role, first_name, last_name, reviewed } = await getUserData(context.auth.uid)

    if (role == newRole) {
        throw new functions.https.HttpsError('already-exists', `Already a ${newRole}`)
    }

    if (newRole == MENTOR && !reviewed) {
        const text = `${first_name} ${last_name} wants to request for a Paddy account`
        return sendEmail(
            context.auth.token.email,
            'Account Toggle',
            text,
        )
    }

    return updateUser(context.auth.uid, { role: newRole })
})