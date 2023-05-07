const { default: axios } = require('axios')
const admin = require('firebase-admin')

const db = admin.firestore()

var headers = {
    'Authorization': `Bearer ${process.env.PAYSTACK_SECRET}`
}

exports.getBanks = async () => {
    const uri = 'https://api.paystack.co/bank'
    const res = await axios.get(uri, { headers })
    return res.data
}

exports.saveDetails = (uid, data) => {
    const ref = db.collection('users').doc(uid).collection('bank').doc(uid)
    return ref.set(data)
}