const functions = require('firebase-functions')
var crypto = require('crypto')
const { handlePay, saveAuthorisation } = require('../../helper/paystack')
var secret = process.env.PAYSTACK_SECRET

exports.webhook = functions.runWith({ memory: '8GB' }).https.onRequest(async (req, res) => {
    const hash = crypto.createHmac('sha512', secret).update(JSON.stringify(req.body)).digest('hex')

    if (hash == req.headers['x-paystack-signature']) {
        const { event, data } = req.body

        if (event == 'charge.success') {
            const { metadata, plan, authorization, customer } = data
            await handlePay(metadata.uid, plan.plan_code)
            await saveAuthorisation(customer.email, metadata.uid, authorization, plan.plan_code)
        }
    }

    return res.sendStatus(200)
})