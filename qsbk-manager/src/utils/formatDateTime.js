import { dayjs } from "element-plus"
/**
 * 格式化日期
 * @param {string|Date|number} date 
 * @param {string} split 
 */
const formatDateTime = (date, split = "YYYY-MM-DD HH:mm:ss") => {
    let d = dayjs(date);
    if (d.isValid()) {
        return d.format(split);
    }
    else {
        return "";
    }
}

export default formatDateTime;