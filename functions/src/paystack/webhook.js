const functions = require('firebase-functions')
var crypto = require('crypto')
var secret = process.env.PAYSTACK_SECRET

exports.webhook = functions.runWith({ memory: '8GB' }).https.onRequest((req, res) => {
    const hash = crypto.createHmac('sha512', secret).update(JSON.stringify(req.body)).digest('hex')

    if (hash == req.headers['x-paystack-signature']) {
        const event = req.body;

        // charge.success
    }

    return res.send(200);
})