const functions = require('firebase-functions')
const admin = require('firebase-admin')
const { indexDocument } = require('../../helper/index')
const db = admin.firestore()

exports.indexJobs = functions.runWith({ memory: '8GB', timeoutSeconds: 540 }).pubsub.schedule('0 * * * *').onRun(async () => {
    const jobsQuery = await db.collection('jobs').where('indexed', '==', false).get()
    const postsQuery = await db.collection('posts').where('indexed', '==', false).get()

    for (let i = 0; i < jobsQuery.size; i++) {
        const doc = jobsQuery.docs[i];
        const { role, intro, title, description } = doc.data()
        const a = role ?? title
        const b = intro ?? description

        const index = indexDocument(a, b)

        await doc.ref.update({ index, indexed: true })
    }

    for (let i = 0; i < postsQuery.size; i++) {
        const doc = postsQuery.docs[i];
        const { role, intro, title, description } = doc.data()
        const a = role ?? title
        const b = intro ?? description

        const index = indexDocument(a, b)

        await doc.ref.update({ index, indexed: true })
    }


    return null;
})
