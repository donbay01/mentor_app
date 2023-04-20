const admin = require('firebase-admin')

const db = admin.firestore()
const messaging = admin.messaging()

exports.sendNotification = async (sessionId, token, uid, title, body, image, other_image, start, end, shift_date, meetingType, mentor, mentee) => {
    await db.collection('users').doc(uid).collection('notifications').add({
        title,
        body,
        timestamp: admin.firestore.FieldValue.serverTimestamp(),
        image,
        other_image,
        start,
        end,
        shift_date,
        meetingType,
        mentor,
        mentee,
        sessionId
    })

    return messaging.send({
        token,
        notification: {
            title,
            body
        }
    })
}

exports.customNotification = async (token, uid, title, body, start, end, shift_date, meetingType, mentor, mentee) => {
    await db.collection('users').doc(uid).collection('notifications').add({
        title,
        body,
        timestamp: admin.firestore.FieldValue.serverTimestamp(),
        start,
        end,
        shift_date,
        meetingType,
        mentor,
        mentee,
    })

    return messaging.send({
        token,
        notification: {
            title,
            body
        }
    })
}