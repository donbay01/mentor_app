const functions = require('firebase-functions')
const { getUserData } = require('../../helper/user')
const { sendNotification } = require('../../helper/notification')

exports.newSessionRequest = functions.runWith({ memory: '8GB' }).firestore.document('sessions/{sessionId}').onCreate(async (snap, context) => {
    const { menteeUid, mentorUid, meetingType, start, end, timestamp } = snap.data()

    const mentorData = await getUserData(mentorUid)
    const menteeData = await getUserData(menteeUid)

    return sendNotification(
        snap.id,
        mentorData.token,
        mentorUid,
        `${menteeData.first_name} sent you a ${meetingType} request`,
        `Please accept or decline`,
        menteeData.photoURL,
        mentorData.photoURL,
        start,
        end,
        timestamp,
        meetingType,
        mentorData.first_name,
        menteeData.first_name,
    )
})