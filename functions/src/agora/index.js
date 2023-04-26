const functions = require('firebase-functions')
const { RtcTokenBuilder, RtcRole } = require('agora-token')
const { UNAUTHENTICATED } = require('../../constants/error')

exports.createToken = functions.runWith({ memory: '8GB' }).https.onCall((data, context) => {
    if (context.auth == undefined) {
        throw new functions.https.HttpsError('unauthenticated', UNAUTHENTICATED)
    }

    const { channelName, uid } = data

    const appId = process.env.AGORA_APP_ID;
    const appCertificate = process.env.AGORA_APP_CERTIFICATE;
    const role = RtcRole.PUBLISHER;

    const expirationTimeInSeconds = 3600

    const currentTimestamp = Math.floor(Date.now() / 1000)

    const privilegeExpiredTs = currentTimestamp + expirationTimeInSeconds

    const tokenA = RtcTokenBuilder.buildTokenWithUid(appId, appCertificate, channelName, uid, role, privilegeExpiredTs);
    return tokenA;
})
