import dayjs from "dayjs"
const formatDateTime = (str, split = "YYYY-MM-DD HH:mm:ss") => {
    let d = dayjs(str);
    if (d.isValid()) {
        return d.format(split);
    }
    else {
        return "";
    }
}

export default formatDateTime;