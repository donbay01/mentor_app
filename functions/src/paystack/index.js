const functions = require('firebase-functions')
const { default: axios } = require('axios')
const { UNAUTHENTICATED } = require('../../constants/error')

var header = {
    "Authorization": `Bearer ${process.env.PAYSTACK_SECRET}`,
    'Content-Type': 'application/json'
}

exports.genPayLink = functions.runWith({ memory: '8GB' }).https.onCall(async (data, context) => {
    if (context.auth == undefined) {
        throw new functions.https.HttpsError('unauthenticated', UNAUTHENTICATED)
    }

    const { amount, paystackId } = data
    const payload = JSON.stringify({
        amount,
        email: context.auth.token.email,
        plan: paystackId,
        metadata: {
            uid: context.auth.uid,
        },
        callback_url: 'https://careerpaddy.page.link',
        channels: ['card', 'bank', 'ussd', 'qr', 'bank_transfer']
    })

    const res = await axios.post('https://api.paystack.co/transaction/initialize', payload, { headers: header })

    return res.data
})