const functions = require('firebase-functions')
const admin = require('firebase-admin')
const db = admin.firestore()

const { UNAUTHENTICATED, NOT_MENTOR } = require('../../constants/error')
const { MENTOR } = require('../../constants/roles')
const { customNotification } = require('../../helper/notification')
const { Timestamp } = require('firebase-admin/firestore')

exports.sessionAction = functions.runWith({ memory: '8GB' }).https.onCall(async (data, context) => {
    if (context.auth == undefined) {
        throw new functions.https.HttpsError('unauthenticated', UNAUTHENTICATED)
    }

    var now = Timestamp.now()

    const { action, reason, sessionId, notificationId } = data
    const { uid } = context.auth

    const sessDoc = await db.collection('sessions').doc(sessionId).get()
    const { shiftId, menteeUid, start, end, meetingType, mentor, timestamp, endTimestamp, mentorUid } = sessDoc.data()

    const mentorDoc = db.collection('users').doc(mentorUid)

    if (notificationId != null) {
        await mentorDoc.collection('notifications').doc(notificationId).delete()
    }

    await mentorDoc.update({
        notifications: admin.firestore.FieldValue.increment(-1)
    })

    const menteeDoc = await db.collection('users').doc(menteeUid).get()
    const { token, first_name, free_paddy_points } = menteeDoc.data()

    let text = ''

    if (now.toDate() > endTimestamp.toDate()) {
        await mentorDoc.collection('availables').doc(shiftId).update({ isAvailable: true })
        await sessDoc.ref.delete()

        throw new functions.https.HttpsError('unavailable', 'Session has expired')
    }

    if (action == 'decline') {
        const field = meetingType == 'Career Session' ? 'sessions' : 'interviews'
        const menteeRef = db.collection('users').doc(menteeUid)

        if (free_paddy_points > 0) {
            await menteeRef.update({ free_paddy_points: admin.firestore.FieldValue.increment(-1) })
        } else {
            await menteeRef.update({ [field]: admin.firestore.FieldValue.increment(1) })
        }

        await mentorDoc.collection('availables').doc(shiftId).update({ isAvailable: true })
        await sessDoc.ref.delete()
        text = `${mentor} just declined your request for a ${meetingType}`
    } else {
        text = `${mentor} just accepted your request for a ${meetingType}`
        await mentorDoc.collection('availables').doc(shiftId).update({ isAvailable: false })
        await db.collection('sessions').doc(sessionId).update({ isAccepted: true })
    }

    return customNotification(
        token,
        menteeUid,
        text,
        reason != null && reason != undefined ? reason : text,
        start,
        end,
        timestamp,
        meetingType,
        mentor,
        first_name
    )
})