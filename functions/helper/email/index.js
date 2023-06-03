const nodemailer = require("nodemailer")

const EMAIL = 'mycareerpaddy@gmail.com'
const PASSWORD = 'pzigvynawluurcgj'

let transporter = nodemailer.createTransport({
    service: "gmail",
    host: "smtp.gmail.com",
    port: 587,
    secure: false,
    auth: {
        user: EMAIL,
        pass: PASSWORD,
    },
});

exports.sendEmail = (email, subject, text) => transporter.sendMail({
    from: `"Career Paddy" <${EMAIL}>`,
    to: email,
    subject,
    text,
})