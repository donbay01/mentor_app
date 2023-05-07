const { default: axios } = require('axios')

var headers = {
    'Authorization': `Bearer ${process.env.PAYSTACK_SECRET}`
}

exports.verify = async (acct_num, bank_code) => {
    const uri = `https://api.paystack.co/bank/resolve?account_number=${acct_num}&bank_code=${bank_code}`
    const res = await axios.get(uri, { headers })
    return res.data
}