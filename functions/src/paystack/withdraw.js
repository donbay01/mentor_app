const functions = require('firebase-functions')
const admin = require('firebase-admin')
const Cryptr = require('cryptr')

const db = admin.firestore()
const { UNAUTHENTICATED } = require('../../constants/error')

const { SECRET } = require('../../constants')
const { sendEmail } = require('../../helper/email')
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
    const { paddy_points, first_name, last_name, email } = c.data()
    const bankRef = await userRef.collection('bank').doc(context.auth.uid).get()

    if (!bankRef.exists) {
        throw new functions.https.HttpsError('failed-precondition', 'No bank information has been setup')
    }

    const { hash, acc_name, acc_no } = bankRef.data()

    const decryptedString = cryptr.decrypt(hash)

    if (amount < 2000) {
        throw new functions.https.HttpsError('failed-precondition', 'Min amount is 2000 points')
    }

    if (amount > paddy_points) {
        throw new functions.https.HttpsError('failed-precondition', 'Insufficient paddy points')
    }

    if (password != decryptedString) {
        throw new functions.https.HttpsError('failed-precondition', 'Wrong password')
    }

    // return userRef.update({
    //     paddy_points: admin.firestore.FieldValue.increment(-amount)
    // })

    const text = `
    Hi Career Paddy,\n
    I would like to withdraw (${amount}) points from my paddy account,

    User information:
    Full Name: ${first_name} ${last_name} \n
    Email: ${email} \n
    \n
    Regards
    `

    return sendEmail(
        'Communications@careerpaddy.co',
        'Withdrawal request',
        text,
    )
})