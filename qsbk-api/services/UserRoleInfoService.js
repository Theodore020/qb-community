/**
 * 数据表admin_info的操作
 */
const BaseService = require('./BaseService');
const md5 = require("md5");
const APPConfig = require("../config/APPConfig");
const PageList = require("../model/PageList");

class UserRoleInfoService extends BaseService {
    constructor() {
        super();
        this.currentTable = this.tableMap.user_role_info;
    }

    /**
     * 通过用户的id获取用户的角色
     * @param {number} user_id 
     * @returns  {Promise<Array>}
     */
    getUserRoleListByUserId(user_id) {
        let sql = `select * from ${this.currentTable} where is_del = false and user_id = ?`;
        return this.executeSql(sql, [user_id]);
    }

    //数据库事务
    saveRoleData(user_id, roleIdList) {
        //第一步:删除原有的角色
        let sql1 = `update ${this.currentTable} set is_del = true,update_at = ? where user_id =?`;
        let params1 = [new Date(), user_id];
        let arr = [
            {
                sql: sql1,
                params: params1
            }
        ];
        //第二步:新增用户的角色权限 
        for (let role_id of roleIdList) {
            arr.push({
                sql: `insert into ${this.currentTable} (user_id,role_id,create_at) values (?,?,?)`,
                params: [user_id, role_id, new Date()]

            })
        }
        return this.executeTransaction(arr);
    }

}

module.exports = UserRoleInfoService;