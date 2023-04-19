const functions = require('firebase-functions')
const admin = require('firebase-admin')

const db = admin.firestore()
const { getUserData } = require('../../helper/user')

exports.completedProfile = functions.runWith({ memory: '8GB' }).https.onCall(async (data, context) => {
    const { uid } = context.auth
    const { has_collected } = await getUserData(uid)

    if (has_collected == true) {
        return null;
    }

    const increment = admin.firestore.FieldValue.increment(1)
    return db.collection('users').doc(uid).update({
        courses: increment,
        paddy_points: increment,
        sessions: increment,
        has_collected: true,
    })
})