const functions = require('firebase-functions')
const admin = require('firebase-admin')
const { Timestamp } = require('firebase-admin/firestore')

const db = admin.firestore()
const messaging = admin.messaging()

exports.reminder = functions.runWith({ memory: '8GB', timeoutSeconds: 540 }).pubsub.schedule('*/5 * * * *').onRun(async () => {
    let now = new Date();
    now.setMinutes(now.getMinutes() + 5);

    const ref = await db.collection('sessions').where('startTimestamp', '==', Timestamp.fromDate(now)).get()
    if (ref.size == 0) {
        return null;
    }

    const notification = { title: 'Session Reminder', body: 'Your session is about to start in 5mins' }

    for (let i = 0; i < ref.size; i++) {
        var sess = ref.docs[i]
        const { mentorUid, menteeUid } = sess.data()

        const mentor = await db.collection('users').doc(mentorUid).get()
        const mentee = await db.collection('users').doc(menteeUid).get()

        await messaging.sendAll([
            { token: mentor.data().token, notification },
            { token: mentee.data().token, notification }
        ])

        return null
    }
})