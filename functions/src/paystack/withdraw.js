const functions = require('firebase-functions')
const admin = require('firebase-admin')
const Cryptr = require('cryptr')

const db = admin.firestore()
const { UNAUTHENTICATED } = require('../../constants/error')

const { SECRET } = require('../../constants')
const cryptr = new Cryptr(SECRET)

exports.withdrawPoints = functions.runWith({ memory: '8GB' }).https.onCall(async (data, context) => {
    if (context.auth == undefined) {
        throw new functions.https.HttpsError('unauthenticated', UNAUTHENTICATED)
    }

    const { password, amount } = data

    if (password == undefined || password == null) {
        throw new functions.https.HttpsError('failed-precondition', 'No password entered')
    }

    const userRef = db.collection('users').doc(context.auth.uid)
    const c = await userRef.get()
    const { paddy_points } = c.data()
    const bankRef = await userRef.collection('bank').doc(context.auth.uid).get()

    if (!bankRef.exists) {
        throw new functions.https.HttpsError('failed-precondition', 'No bank information has been setup')
    }

    const { hash, acc_name, acc_no } = bankRef.data()

    const decryptedString = cryptr.decrypt(hash)
    if (password != decryptedString) {
        throw new functions.https.HttpsError('failed-precondition', 'Wrong password')
    }

    if (amount < 2000) {
        throw new functions.https.HttpsError('failed-precondition', 'Min amount is 2000 points')
    }

    if (amount > paddy_points) {
        throw new functions.https.HttpsError('failed-precondition', 'Insufficient paddy points')
    }

    // debit bank account and credit user 

    return userRef.update({
        paddy_points: admin.firestore.FieldValue.increment(-amount)
    })
})