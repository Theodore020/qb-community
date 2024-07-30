/**
 * 数据表admin_info的操作
 */
const BaseService = require('./BaseService');
const md5 = require("md5");
const APPConfig = require("../config/APPConfig");
const PageList = require("../model/PageList");

class RoleInfoService extends BaseService {
    constructor() {
        super();
        this.currentTable = this.tableMap.role_info;
    }
    async getListByPage({ role_name, pageIndex = 1 }) {
        let [listData, total_count] = await this.createQuery(this.currentTable)
            .like("role_name", role_name)
            .setPageIndex(pageIndex)
            .getPageAndCount();
        return new PageList(pageIndex, total_count, listData);
    }
}

module.exports = RoleInfoService;