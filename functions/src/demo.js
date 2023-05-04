const { sendEmail } = require("../helper/email")

try {
    sendEmail(
        'samsonudo@yahoo.com',
        'Test',
        'Hy'
    )
} catch (e) {
    console.log(e)
}