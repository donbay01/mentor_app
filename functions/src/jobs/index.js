const functions = require('firebase-functions')
const admin = require('firebase-admin')
const { indexDocument } = require('../../helper/index')
const db = admin.firestore()

exports.indexJobs = functions.runWith({ memory: '8GB' }).pubsub.schedule('0 * * * *').onRun(async () => {
    const coursesQuery = await db.collection('jobs').where('indexed', '==', false).get()

    for (let i = 0; i < coursesQuery.size; i++) {
        const doc = coursesQuery.docs[i];
        const { role, intro, title, description } = doc.data()
        const a = role ?? title
        const b = intro ?? description

        const index = indexDocument(a, b)

        await doc.ref.update({ index, indexed: true })
    }

    return null;
})
