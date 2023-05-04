const functions = require('firebase-functions')
const admin = require('firebase-admin')
const { Timestamp } = require('firebase-admin/firestore')
const { addWeekMidNight, newWeek } = require('../../helper/date')

const db = admin.firestore()
const messaging = admin.messaging()

exports.newSchedule = functions.runWith({ memory: '8GB' }).firestore.document('users/{userId}/availables/{shiftId}').onCreate((snap, context) => {
    return snap.ref.update({ shiftId: snap.id })
})

exports.weeklyRecurrence = functions.runWith({ memory: '8GB', timeoutSeconds: 540 }).pubsub.schedule('0 0 * * 0').onRun(async () => {
    const now = Timestamp.now()

    const today = new Date()
    const aWeekAgo = new Date(today.getTime() - (7 * 24 * 60 * 60 * 1000))
    aWeekAgo.setHours(0, 0, 0, 0)

    const q = await db.collectionGroup('availables').where('timestamp', '>=', Timestamp.fromDate(aWeekAgo)).where('endTimestamp', '<', now).get()
    console.log(q.size)

    for (let i = 0; i < q.size; i++) {
        var shifts = q.docs[i]
        const { startTimestamp, endTimestamp, start, end, timestamp } = shifts.data()

        const doc = await shifts.ref.parent.add({
            start,
            end,
            isAvailable: true,
            timestamp: addWeekMidNight(timestamp.toDate()),
            startTimestamp: newWeek(startTimestamp.toDate()),
            endTimestamp: newWeek(endTimestamp.toDate())
        })

        await doc.update({ shiftId: doc.id })
    }

    return null
})

exports.monthlyRemdinder = functions.runWith({ memory: '8GB', timeoutSeconds: 540 }).pubsub.schedule('0 0 0 ? * SUNL').onRun(() => {
    return messaging.sendToTopic('monthlyReminder', {
        notification: {
            title: 'Monthly reminder',
            body: 'Kindly remember to setup your schedule next month'
        },
    })
})