const functions = require('firebase-functions')
const admin = require('firebase-admin')
const { indexDocument } = require('../../helper/index')
const db = admin.firestore()

exports.indexCourse = functions.runWith({ memory: '8GB' }).pubsub.schedule('0 * * * *').onRun(async () => {
    const coursesQuery = await db.collection('courses').where('indexed', '==', false).get()

    for (let i = 0; i < coursesQuery.size; i++) {
        const doc = coursesQuery.docs[i];
        const { name, about } = doc.data()
        const index = indexDocument(name, about)

        await doc.ref.update({ index, indexed: true })
    }

    return null;
})

exports.enrollCourse = functions.runWith({ memory: '8GB' }).firestore.document('courses/{courseId}/enrolled/{enrollId}').onCreate(async (snap, context) => {
    const courseDoc = snap.ref.parent.parent
    const courseData = await courseDoc.get()
    const { enrolledUids } = courseData

    const ids = [context.params.enrollId, ...enrolledUids]

    return courseDoc.update({
        enrolled: admin.firestore.FieldValue.increment(1),
        enrolledUids: ids
    })
})