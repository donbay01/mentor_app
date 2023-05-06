const functions = require('firebase-functions')
const admin = require('firebase-admin')

const { getUserData, updateUser } = require('../../helper/user')
const { sendNotification } = require('../../helper/notification')
const { CAREER_SESSION } = require('../../constants/roles')

exports.newSessionRequest = functions.runWith({ memory: '8GB' }).firestore.document('sessions/{sessionId}').onCreate(async (snap, context) => {
    const { menteeUid, mentorUid, meetingType, start, end, timestamp, note } = snap.data()

    const mentorData = await getUserData(mentorUid)
    const menteeData = await getUserData(menteeUid)

    const field = meetingType == CAREER_SESSION ? 'sessions' : 'interviews'
    const val = menteeData[field]

    await updateUser(menteeUid, { [field]: admin.firestore.FieldValue.increment(-1) })

    return sendNotification(
        snap.id,
        mentorData.token,
        mentorUid,
        `${menteeData.first_name} sent you a ${meetingType} request`,
        note,
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