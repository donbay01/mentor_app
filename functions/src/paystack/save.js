const functions = require('firebase-functions')
const Cryptr = require('cryptr')

const { UNAUTHENTICATED } = require('../../constants/error')
const { saveDetails } = require('../../helper/paystack/banks')
const { SECRET } = require('../../constants')

const cryptr = new Cryptr(SECRET)

exports.saveInformation = functions.runWith({ memory: '8GB' }).https.onCall(async (data, context) => {
    if (context.auth == undefined) {
        throw new functions.https.HttpsError('unauthenticated', UNAUTHENTICATED)
    }

    const { acc_name, acc_no, password } = data

    const hash = cryptr.encrypt(password)

    return saveDetails(context.auth.uid, { hash, acc_name, acc_no })
})