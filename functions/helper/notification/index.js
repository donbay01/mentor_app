const admin = require('firebase-admin')

const db = admin.firestore()
const messaging = admin.messaging()

exports.sendNotification = async (sessionId, token, uid, title, body, image, other_image, start, end, shift_date, meetingType, mentor, mentee, startTimestamp, endTimestamp) => {
    const userRef = db.collection('users').doc(uid)
    await userRef.collection('notifications').add({
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
        sessionId,
        startTimestamp,
        endTimestamp,
    })

    await userRef.update({
        notifications: admin.firestore.FieldValue.increment(1)
    })

    try {
        return messaging.send({
            token,
            notification: {
                title,
                body
            }
        })
    } catch (e) {
        return userRef.update({
            token: null,
        })
    }
}

exports.customNotification = async (token, uid, title, body, start, end, shift_date, meetingType, mentor, mentee) => {
    const userRef = db.collection('users').doc(uid)

    await userRef.collection('notifications').add({
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

    await userRef.update({
        notifications: admin.firestore.FieldValue.increment(1)
    })

    try {
        return messaging.send({
            token,
            notification: {
                title,
                body
            }
        })
    } catch (e) {
        return userRef.update({
            token: null,
        })
    }
}