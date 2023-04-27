const functions = require('firebase-functions')
const admin = require('firebase-admin')

const db = admin.firestore()
const { getUserData } = require('../../helper/user')
const { MENTEE } = require('../../constants/roles')

exports.completedProfile = functions.runWith({ memory: '8GB' }).https.onCall(async (data, context) => {
    const { uid } = context.auth
    const { has_collected, role } = await getUserData(uid)

    if (has_collected == true) {
        return null;
    }

    const increment = admin.firestore.FieldValue.increment(1)
    const d = {
        sessions: increment,
        has_collected: true,
    }

    const payload = role == MENTEE ? d : { has_collected: true }

    return db.collection('users').doc(uid).update(payload)
})