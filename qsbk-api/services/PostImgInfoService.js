/**
 * 数据表admin_info的操作
 */
const BaseService = require('./BaseService');
const md5 = require("md5");
const APPConfig = require("../config/APPConfig");
const PageList = require("../model/PageList");

class PostImgInfoService extends BaseService {
    constructor() {
        super();
        this.currentTable = this.tableMap.post_img_info;
    }

}

module.exports = PostImgInfoService;