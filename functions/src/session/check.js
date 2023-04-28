const functions = require('firebase-functions')
const admin = require('firebase-admin')

const db = admin.firestore()

exports.checkAvailability = functions.runWith({ memory: '8GB', timeoutSeconds: 540 }).pubsub.schedule('*/15 * * * *').onRun(async () => {
    var time = admin.firestore.Timestamp.now()

    const sess = await db.collection('sessions').where('endTimestamp', '<', time).get()
    for (let i = 0; i < sess.size; i++) {
        const session = sess.docs[i]
        const { shiftId, mentorUid, menteeUid, meetingType, stars } = session.data()

        const increment = (val) => admin.firestore.FieldValue.increment(val)

        const mentorRef = db.collection('users').doc(mentorUid)
        const menteeRef = db.collection('users').doc(menteeUid)

        await mentorRef.update({
            paddy_points: increment(500),
            sessions: increment(1),
            rating: increment(stars)
        })

        const field = meetingType == 'Career Session' ? 'sessions' : 'interviews'

        await menteeRef.update({ [field]: increment(-1) })

        const shiftDoc = await mentorRef.collection('availables').where('shiftId', '==', shiftId).get()
        await shiftDoc.docs[0].ref.update({ isAvailable: true })

        await mentorRef.collection('history').add(session.data())
        await menteeRef.collection('history').add(session.data())

        await session.ref.delete()
    }

    return null;
})