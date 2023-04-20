const functions = require('firebase-functions')
const admin = require('firebase-admin')

const db = admin.firestore()

exports.checkAvailability = functions.runWith({ memory: '8GB' }).pubsub.schedule('0 * * * *').onRun(async () => {
    var time = admin.firestore.Timestamp.now()

    const sess = await db.collection('sessions').where('endTimestamp', '<', time).get()
    for (let i = 0; i < sess.size; i++) {
        const session = sess.docs[i]
        const { shiftId, mentorUid } = session.data()

        const shiftDoc = await db.collection('users').doc(mentorUid).collection('availables').where('shiftId', '==', shiftId).get()
        await shiftDoc.docs[0].ref.update({ isAvailable: true })

        await session.ref.delete()
    }

    return null;
})