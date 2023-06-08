const functions = require('firebase-functions')
const admin = require('firebase-admin')
const { getPlan } = require('../../helper/paystack')
const { default: axios } = require('axios')

const db = admin.firestore()

var headers = {
    "Authorization": `Bearer ${process.env.PAYSTACK_SECRET}`,
    'Content-Type': 'application/json'
}

exports.recurringCharges = functions.runWith({ memory: '8GB', timeoutSeconds: 540 }).pubsub.schedule('0 0 * * *').onRun(async () => {
    const currentDate = new Date()
    currentDate.setMinutes(0, 0, 0, 0)

    var nextCharge = admin.firestore.Timestamp.fromDate(currentDate)

    const ref = await db.collection('users').where('payDate', '==', nextCharge).get()

    for (let i = 0; i < ref.size; i++) {
        var user = ref.docs[i]
        var { email } = user.data()
        const auth = await db.collection('authorisation').doc(user.id).get()
        var { planId, authorization_code } = auth
        const { amount } = await getPlan(planId)

        try {
            const payload = {
                authorization_code,
                email,
                amount: amount.toString(),
            }

            const res = await axios.post('https://api.paystack.co/transaction/charge_authorization', payload, { headers })
            const { message, data } = res.data

            if (message == "Please, redirect your customer to the authorization url provided") {
                const { authorization_url } = data
                console.log(authorization_url)
            }

        } catch (e) {
            continue;
        }
    }

    return null
})