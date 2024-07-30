/**
 * 正则表达式验证
 * @param {RegExp} reg 
 * @returns 
 */
export const validateRegExp = (reg) => {
    return function (rules, value, callback) {
        if (value === "") {
            callback(new Error("当前值不能为空"))
        }
        else {
            if (reg.test(value)) {
                callback()
            }
            else {
                callback(new Error("当前值不符合要求"))
            }
        }
    }
}





export const regConstant = {
    phone: /^(0|86|17951)?(13[0-9]|15[012356789]|166|17[3678]|18[0-9]|14[57])[0-9]{8}$/,
    email: /\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/
}
