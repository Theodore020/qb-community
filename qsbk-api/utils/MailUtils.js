/**
 * 用于发送邮件的对象
 */

const nodemailer = require('nodemailer');

const MailUtils = {
    getTransport() {
        const transport = nodemailer.createTransport({
            host: "smtp.126.com",
            port: 25,
            secure: false,
            auth: {
                user: "Theodore020@126.com",
                pass: "VRZGNXIPXRDYBKJT"			//这里是授权码
            }
        })
        return transport;
    },
    send(to, subject, text) {
        let transport = this.getTransport();
        return transport.sendMail({
            from:"智慧校园<Theodore020@126.com>",
            to,
            subject,
            html:text
        })
    }
}

module.exports = MailUtils;