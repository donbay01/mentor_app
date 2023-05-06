const functions = require('firebase-functions')
const admin = require('firebase-admin')

const messaging = admin.messaging()

const { getSessionsByTime } = require('../../helper/sessions')
const { Timestamp } = require('firebase-admin/firestore')
const { getUserData } = require('../../helper/user')

exports.callStarted = functions.runWith({ memory: '8GB', timeoutSeconds: 540 }).pubsub.schedule('*/10 * * * *').onRun(async () => {
    const now = new Date()
    now.setMinutes(now.getMinutes(), 0, 0)

    const sessions = await getSessionsByTime(Timestamp.fromDate(now))

    for (let i = 0; i < sessions.size; i++) {
        var session = sessions.docs[i]
        const { mentorUid, menteeUid, meetingType } = session.data()

        const mentor = await getUserData(mentorUid)
        const mentee = await getUserData(menteeUid)

        const notification = {
            title: meetingType,
            body: 'video session just started',
        }

        await messaging.sendAll([
            { token: mentor.token, notification },
            { token: mentee.token, notification }
        ])
    }

    return null
})
