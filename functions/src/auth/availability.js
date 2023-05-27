const functions = require('firebase-functions')
const admin = require('firebase-admin')
const { Timestamp } = require('firebase-admin/firestore')
const { addWeekMidNight, newWeek } = require('../../helper/date')
const { getAllMentees } = require('../../helper/user')
const moment = require('moment')
const { UNAUTHENTICATED } = require('../../constants/error')

const db = admin.firestore()
const messaging = admin.messaging()

exports.newSchedule = functions.runWith({ memory: '8GB' }).firestore.document('users/{userId}/availables/{shiftId}').onCreate(async (snap, context) => {
    await snap.ref.update({ shiftId: snap.id })
    return snap.ref.parent.parent.update({ isAvailabilitySet: true })

    // const { startTimestamp, endTimestamp, start, end, timestamp } = snap.data()

    // return snap.ref.parent.add({
    //     start,
    //     end,
    //     isAvailable: true,
    //     timestamp: addWeekMidNight(timestamp.toDate()),
    //     startTimestamp: newWeek(startTimestamp.toDate()),
    //     endTimestamp: newWeek(endTimestamp.toDate())
    // })
})

exports.createSchedule = functions.runWith({ memory: '8GB' }).https.onCall(async (data, context) => {
    if (context.auth == undefined) {
        throw new functions.https.HttpsError('unauthenticated', UNAUTHENTICATED)
    }

    const { startTimestamp, endTimestamp, start, end, timestamp } = data
    const { uid } = context.auth

    const ref = db.collection('users').doc(uid).collection('availables')
    await ref.add({
        startTimestamp,
        endTimestamp,
        start,
        end,
        timestamp,
        isAvailable: true,
    })

    return ref.add({
        start,
        end,
        isAvailable: true,
        timestamp: addWeekMidNight(timestamp.toDate()),
        startTimestamp: newWeek(startTimestamp.toDate()),
        endTimestamp: newWeek(endTimestamp.toDate())
    })
})

exports.monthlyRemdinder = functions.runWith({ memory: '8GB', timeoutSeconds: 540 }).pubsub.schedule('0 0 1 * *').onRun(async () => {
    await messaging.sendToTopic('monthlyReminder', {
        notification: {
            title: 'Monthly reminder',
            body: 'Kindly remember to setup your schedule next month'
        },
    })

    var today = Timestamp.now().toDate()

    const menteesRef = await getAllMentees()
    for (let i = 0; i < menteesRef.size; i++) {
        var mentee = menteesRef.docs[i]
        var last_updated = mentee.updateTime.toDate()
        const { sessions, interviews } = mentee.data()

        const date1 = moment(last_updated)
        const date2 = moment(today)

        const diffInMonths = date2.diff(date1, 'months')
        if (diffInMonths >= 1) {
            await mentee.ref.update({
                interviews: 0,
                sessions: 0,
                expiredInterviews: interviews,
                expiredSessions: sessions,
            })
        }
    }

    return null
})