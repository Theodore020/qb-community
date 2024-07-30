/**
 * 随机插入帖子的图片
 */
const DBUtils = require("../utils/DBUtils");
const db = new DBUtils();
const fs = require("fs");
const path = require("path");

//第一步：读postImg文件夹
let imgList = fs.readdirSync(path.join(__dirname, "../upload/postImg"));

let post_id = 1;

let arr = [];

//第二步：事务插入，但是要随机平均分页
while (imgList.length) {
    let num = parseInt(Math.random() * 3);
    for (let i = 0; i < num; i++) {
        let imgPath = imgList.pop();

        let sql = `insert into post_img_info (post_id,img_url,create_at) values (?,?,?)`;
        let params = [post_id, "/upload/postImg/" + imgPath, new Date()];

        arr.push({
            sql, params
        })
    }
    post_id++;
    if (post_id > 69) {
        post_id = 1;
    }
}

db.executeTransaction(arr)
.then(result=>{
    console.log("ok");
}).catch(error=>{
    console.log(error);
})