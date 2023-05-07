const functions = require('firebase-functions')
const { getBanks } = require('../../helper/paystack/banks')

exports.getAllBanks = functions.runWith({ memory: '8GB' }).https.onCall(async (data, context) => {
    const banks = await getBanks()

    return banks
})