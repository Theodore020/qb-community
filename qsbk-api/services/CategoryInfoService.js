/**
 * 数据表admin_info的操作
 */
const BaseService = require('./BaseService');
const md5 = require("md5");
const APPConfig = require("../config/APPConfig");
const PageList = require("../model/PageList");

class CategoryInfoService extends BaseService {
    constructor() {
        super();
        this.currentTable = this.tableMap.category_info;
    }

    async getListByPage({ category_name, pageIndex = 1 }) {
        let [listData, total_count] = await this.createQuery(this.currentTable)
            .like("category_name", category_name)
            .setPageIndex(pageIndex)
            .getPageAndCount();
        return new PageList(pageIndex, total_count, listData);
    }

}

module.exports = CategoryInfoService;