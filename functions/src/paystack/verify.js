const functions = require('firebase-functions')
const { UNAUTHENTICATED } = require('../../constants/error')
const { verify, transferReciepient } = require('../../helper/paystack/verify')

exports.verifyBankInformation = functions.runWith({ memory: '8GB' }).https.onCall(async (data, context) => {
    if (context.auth == undefined) {
        throw new functions.https.HttpsError('unauthenticated', UNAUTHENTICATED)
    }

    const { acct_num, bank_code, type, currency } = data
    const details = await verify(acct_num, bank_code)

    // const { recipient_code } = await transferReciepient(
    //     type,
    //     details.data.account_name,
    //     details.data.account_number,
    //     bank_code, currency,
    // )

    // console.log(recipient_code)

    return details
})