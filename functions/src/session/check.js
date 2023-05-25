const functions = require('firebase-functions')
const admin = require('firebase-admin')

const db = admin.firestore()

exports.checkAvailability = functions.runWith({ memory: '8GB', timeoutSeconds: 540 }).pubsub.schedule('*/9 * * * *').onRun(async () => {
    var time = admin.firestore.Timestamp.now()

    const sess = await db.collection('sessions').where('endTimestamp', '<', time).get()
    for (let i = 0; i < sess.size; i++) {
        const session = sess.docs[i]
        const { shiftId, mentorUid, menteeUid, meetingType, stars, Mentor_joined, Mentee_joined } = session.data()

        const increment = (val) => admin.firestore.FieldValue.increment(val)

        const mentorRef = db.collection('users').doc(mentorUid)
        const mentorData = (await mentorRef.get()).data()

        const menteeRef = db.collection('users').doc(menteeUid)

        if (Mentor_joined == true && mentorData.free_paddy_points == 0) {
            await mentorRef.update({
                paddy_points: increment(500),
                sessions: increment(1),
                rating: increment(stars)
            })

            await mentorRef.collection('history').add(session.data())
        }

        if (Mentor_joined == true && mentorData.free_paddy_points > 0) {
            await mentorRef.update({
                free_paddy_points: increment(-1),
                // sessions: increment(1),
                // rating: increment(stars)
            })
        }

        if (Mentee_joined == true && mentorData.free_paddy_points == 0) {
            await menteeRef.collection('history').add(session.data())
        }

        // const field = meetingType == 'Career Session' ? 'sessions' : 'interviews'

        // await menteeRef.update({ [field]: increment(-1) })

        // const shiftDoc = await mentorRef.collection('availables').where('shiftId', '==', shiftId).get()
        // await shiftDoc.docs[0].ref.update({ isAvailable: true })

        await session.ref.delete()
    }

    const notis = await db.collectionGroup('notifications').where('endTimestamp', '<', time).get()
    for (let i = 0; i < notis.size; i++) {
        var notification = notis.docs[i];
        await notification.ref.delete();
    }

    return null;
})