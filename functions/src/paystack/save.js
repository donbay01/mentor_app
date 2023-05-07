const functions = require('firebase-functions')
const crypto = require('crypto')

const { UNAUTHENTICATED } = require('../../constants/error')
const { saveDetails } = require('../../helper/paystack/banks')

exports.saveInformation = functions.runWith({ memory: '8GB' }).https.onCall(async (data, context) => {
    if (context.auth == undefined) {
        throw new functions.https.HttpsError('unauthenticated', UNAUTHENTICATED)
    }

    const { acc_name, acc_no, password } = data


    var hash = crypto.createCipher('aes-128-cbc', password)
    var hash = hash.update('abc', 'utf8', 'hex')
    // hash += hash.final('hex')

    return saveDetails(context.auth.uid, { ...data, hash })
})