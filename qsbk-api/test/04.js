const peotryList = require("./poet.song.2000");
const DBUtils = require("../utils/DBUtils");
const db = new DBUtils();

let arr = [];
peotryList.forEach(item => {
    arr.push({
        sql: `insert into comment_info (comment_text,user_id,post_id,is_show,create_at) values (?,?,?,?,?)`,
        params: [item.paragraphs.toString(), ~~(Math.random() * 100) + 1, ~~(Math.random() * 69) + 1, 1, new Date()]
    })
})

db.executeTransaction(arr)
    .then(result => {
        console.log("成功");
    }).catch(error => {
        console.log(error);
        console.log("失败");
    })