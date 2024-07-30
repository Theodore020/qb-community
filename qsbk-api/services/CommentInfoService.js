/**
 * 数据表admin_info的操作
 */
const BaseService = require('./BaseService');
const APPConfig = require("../config/APPConfig");
const PageList = require("../model/PageList");

class CommentInfoService extends BaseService {
    constructor() {
        super();
        this.currentTable = this.tableMap.comment_info;
    }
    async getListByPage({ post_id, pageIndex = 1 ,startTime, endTime}) {
        let [listData, total_count] = await this.createQuery(this.currentTable)
        .gte("comment_info.create_at", startTime)
        .lte("comment_info.create_at", endTime)
            .equal("comment_info.post_id", post_id)
            .setPageIndex(pageIndex)
            .innerJoin("user_info", "user_info.id=comment_info.user_id")
            .addField("user_info.nick_name")
            .addField("user_info.avatar")
            .addField(`${this.tableMap.user_info}.account`)
            .orderBy("comment_info.create_at", "desc")
            .getPageAndCount();

        return new PageList(pageIndex, total_count, listData);
    }
    // async getListByPage({ startTime, endTime, pageIndex = 1 }) {
    //     let [listData, total_count] = await this.createQuery(this.currentTable)
    //         .gte("comment_info.create_at", startTime)
    //         .lte("comment_info.create_at", endTime)
    //         .innerJoin(this.tableMap.user_info, `${this.currentTable}.user_id=${this.tableMap.user_info}.id`)
    //         .addField(`${this.tableMap.user_info}.nick_name`)
    //         .addField(`${this.tableMap.user_info}.account`)
    //         .setPageIndex(pageIndex)
    //         .getPageAndCount();

    //     return new PageList(pageIndex, total_count, listData);
    // }
}

module.exports = CommentInfoService;