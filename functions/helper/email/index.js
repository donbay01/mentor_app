const nodemailer = require("nodemailer")

let transporter = nodemailer.createTransport({
    service: "gmail",
    host: "smtp.gmail.com",
    port: 587,
    secure: false,
    auth: {
        user: 'communications@careerpaddy.co',
        pass: '@1u1aLearning1',
    },
});

exports.sendEmail = (email, subject, text) => transporter.sendMail({
    from: '"Career Paddy" <communications@careerpaddy.co>',
    to: email,
    subject,
    text,
    // html: "<b>Hello world?</b>",
})