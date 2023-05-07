const functions = require('firebase-functions')
const { UNAUTHENTICATED } = require('../../constants/error')
const { verify } = require('../../helper/paystack/verify')

exports.verifyBankInformation = functions.runWith({ memory: '8GB' }).https.onCall(async (data, context) => {
    if (context.auth == undefined) {
        throw new functions.https.HttpsError('unauthenticated', UNAUTHENTICATED)
    }

    const { acct_num, bank_code } = data
    const details = await verify(acct_num, bank_code)

    return details
})