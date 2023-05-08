const functions = require('firebase-functions')
const admin = require('firebase-admin')
const { UNAUTHENTICATED } = require('../../constants/error')

const db = admin.firestore()

exports.nextLesson = functions.runWith({ memory: '8GB' }).https.onCall(async (data, context) => {
    if (context.auth == undefined) {
        throw new functions.https.HttpsError('unauthenticated', UNAUTHENTICATED)
    }

    const { courseId, lessonId } = data
    const ref = db.collection('users').doc(context.auth.uid).collection('courses').doc(courseId).collection('logs').doc(lessonId)

    const { exists } = await ref.get()
    if (!exists) {
        await ref.set({
            courseId,
            lessonId
        })
    }

    const courseRef = db.collection('courses').doc(courseId)

    const cr = courseRef.collection('lessons').orderBy('lessonId').startAfter(lessonId)
    const next = await cr.limit(1).get()

    if (next.size == 0) {
        const r = await courseRef.get()
        const { finishedUids } = r.data()

        let a = finishedUids
        if (!a.includes(context.auth.uid)) {
            a.push(context.auth.uid)
        }

        await courseRef.update({ finishedUids: a })
        return null
    }

    const nextLesson = next.docs[0].data()
    return nextLesson;
})
