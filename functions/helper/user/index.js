const admin = require('firebase-admin')
const { MENTEE } = require('../../constants/roles')
const db = admin.firestore()

exports.getUserData = async (uid) => {
    const doc = await db.collection('users').doc(uid).get()
    return doc.data()
}

exports.getAllMentees = async () => {
    const ref = await db.collection('users').where('role', '==', MENTEE).get()
    return ref
}

exports.updateUser = (uid, data) => {
    const doc = db.collection('users').doc(uid)
    return doc.update(data)
}