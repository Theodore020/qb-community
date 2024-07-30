/**
 * 数据表post_info的操作
 */
const BaseService = require('./BaseService');
const md5 = require("md5");
const APPConfig = require("../config/APPConfig");
const PageList = require("../model/PageList");
const ServiceFactory = require("../factory/ServiceFactory");
class PostInfoService extends BaseService {
    constructor() {
        super();
        this.currentTable = this.tableMap.post_info;
    }
    async getListByPage({ startTime, endTime, pageIndex = 1 }) {
        let [listData, total_count] = await this.createQuery(this.currentTable)
            .gte("post_info.create_at", startTime)
            .lte("post_info.create_at", endTime)
            .innerJoin(this.tableMap.user_info, `${this.currentTable}.user_id=${this.tableMap.user_info}.id`)
            .addField(`${this.tableMap.user_info}.nick_name`)
            .addField(`${this.tableMap.user_info}.account`)
            .innerJoin(this.tableMap.category_info, `${this.currentTable}.category_id=${this.tableMap.category_info}.id`)
            .addField(`${this.tableMap.category_info}.category_name`)
            .setPageIndex(pageIndex)
            .getPageAndCount();

        return new PageList(pageIndex, total_count, listData);
    }

    async getListByPageForCategory({ category_id, pageIndex = 1 }) {
        let [listData, total_count] = await this.createQuery(this.currentTable)
            .innerJoin(this.tableMap.user_info, `${this.currentTable}.user_id=${this.tableMap.user_info}.id`)
            .addField(`${this.tableMap.user_info}.nick_name`)
            .addField(`${this.tableMap.user_info}.account`)
            .addField("user_info.avatar")
            .innerJoin(this.tableMap.category_info, `${this.currentTable}.category_id=${this.tableMap.category_info}.id`)
            .addField(`${this.tableMap.category_info}.category_name`)
            .equal("post_info.category_id", category_id)
            .orderBy("post_info.create_at", "desc")
            .setPageIndex(pageIndex)
            .getPageAndCount();
        listData.forEach(item => {
            if (item.praise) {
                item.praise_count = item.praise.split(",").length;
            } else {
                item.praise_count = 0;
            };
            if (item.hate) {
                item.hate_count = item.hate.split(",").length;
            } else {
                item.hate_count = 0;
            }
        });
        let idList = listData.map(item => item.id);
        if (idList.length > 0) {
            let sql = `select * from ${this.tableMap.post_img_info} where is_del = false and post_id in (${idList.toString()})`
            let imgList = await this.executeSql(sql);
            listData.forEach(item => {
                item.postImgList = imgList.filter(_item => _item.post_id === item.id);
            })
        }
        //准备评论数
        if (idList.length > 0) {
            let sql = `select post_id,count(*) total_count from comment_info
            where is_del = false and post_id in (${idList.toString()})
            group by post_id `;
            let totalCountList = await this.executeSql(sql);
            listData.forEach(item => {
                let currentPostComment = totalCountList.find(_item => _item.post_id === item.id);
                if (currentPostComment) {
                    item.comment_count = currentPostComment.total_count;
                }
                else {
                    item.comment_count = 0;
                }
            })
        }

        return new PageList(pageIndex, total_count, listData);
    }

    async findById(id) {
        //第一种方法,重写SQL语句
        // let sql = `select post_info.*,user_info.nick_name,user_info.avatar from post_info 
        // inner join user_info on post_info.user_id = user_info.id
        // where post_info.is_del = false and post_info.id = ?`;
        // let result = await this.executeSql(sql, [id]);
        // return result[0];

        //第二种方法
        //先获取postInfo
        let postInfo = await super.findById(id);
        if (postInfo) {
            let userInfo = await ServiceFactory.createUserInfoService().findById(postInfo.user_id);
            postInfo.userInfo = userInfo;

            let sql = `select * from ${this.tableMap.post_img_info} where is_del=false and post_id = ?`
            let postImgList = await this.executeSql(sql, [id])
            postInfo.postImgList = postImgList
        }

        return postInfo;
    }

    /**
    * 给帖子赞
    * @param {{user_id:number,post_id:number}} param0 
    * @returns 
    */
    async setPraised({ user_id, post_id }) {
        //第一步：根据id找到当前的帖子
        let currentPostItem = await super.findById(post_id);
        console.log(currentPostItem);
        if (currentPostItem) {
            if (currentPostItem.praise) {
                //如果自己已经赞过了，就不用操作
                let arr = currentPostItem.praise.toString().split(',');
                if (arr.findIndex(item, index => item == user_id) == -1) {
                    currentPostItem.praise += "," + user_id;
                }
            }
            else {
                currentPostItem.praise = user_id;
            }
            await super.update(currentPostItem);

            return currentPostItem.praise.toString().split(',').length;
        }
        else {
            return 0;
        }
    }

    /**
    * 给帖子踩
    * @param {{user_id:number,post_id:number}} param0 
    * @returns 
    */
    async setHate({ user_id, post_id }) {
        //第一步：根据id找到当前的帖子
        let currentPostItem = await super.findById(post_id);
        if (currentPostItem) {
            if (currentPostItem.hate) {
                //如果自己已经踩过了，就不用操作
                let arr = currentPostItem.hate.toString().split(',');
                if (arr.findIndex(item => item == user_id) == -1) {
                    currentPostItem.hate += "," + user_id;
                }
            }
            else {
                currentPostItem.hate = user_id;
            }
            await super.update(currentPostItem);

            return currentPostItem.hate.toString().split(',').length;
        }
        else {
            return 0;
        }
    }
    add({ post_content, category_id, user_id, postImgList }) {
        return new Promise((resolve, reject) => {
            let conn = this.getConn();
            conn.beginTransaction(async error => {
                if (error) {
                    return;
                }
                try {
                    //先保存帖子信息，得到帖子的id
                    let sql1 = `insert into ${this.currentTable} (post_content,category_id,user_id,create_at) values (?,?,?,?)`;
                    let params1 = [post_content, category_id, user_id, new Date()];
                    let result1 = await this.executeSql(sql1, params1, conn);
                    let post_id = result1.insertId;
                    //再去保存帖子图片
                    for (let item of postImgList) {
                        let sql = `insert into ${this.tableMap.post_img_info} (post_id,img_url,create_at) values (?,?,?)`;
                        let param = [post_id, item, new Date()];
                        await this.executeSql(sql, param, conn);
                    }
                    conn.commit();
                    conn.end();
                    resolve(true)
                } catch (error) {
                    conn.rollback();
                    conn.end();
                    reject(false);
                }
            })
        })

    }
}

module.exports = PostInfoService;