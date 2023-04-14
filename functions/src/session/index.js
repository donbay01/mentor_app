const admin = require('firebase-admin')
const functions = require('firebase-functions')
const { getUserData } = require('../../helper/user')
const { sendNotification } = require('../../helper/notification')

exports.newSessionRequest = functions.runWith({ memory: '8GB' }).firestore.document('sessions/{sessionId}').onCreate(async (snap, context) => {
    const { menteeUid, mentorUid } = snap.data()

    const mentorData = await getUserData(mentorUid)
    const menteeData = await getUserData(menteeUid)

    // send notification to mentee
    await sendNotification(
        menteeData.token,
        menteeUid,
        `Your request for a session has been sent to ${mentorData.first_name} ${mentorData.last_name}`,
        `Please wait for ${mentorData.first_name}'s response.`,
    )

    return sendNotification(
        mentorData.token,
        mentorUid,
        `Your have been invited for a session by ${menteeData.first_name} ${menteeData.last_name}`,
        `Please accept or decline`,
    )
})