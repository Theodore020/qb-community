/**
 * 数据表admin_info的操作
 */
const BaseService = require('./BaseService');
const md5 = require("md5");
const APPConfig = require("../config/APPConfig");
const PageList = require("../model/PageList");

class RolePermissionInfoService extends BaseService {
    constructor() {
        super();
        this.currentTable = this.tableMap.role_permission_info;
    }

    /**
     * 根据角色id查询它具备的权限
     * @param {number} role_id 
     * @returns 
     */
    getPermissionListByRoleId(role_id) {
        let sql = `select * from ${this.currentTable} where is_del = false and role_id = ?`;
        return this.executeSql(sql, [role_id]);
    }

    /**
     * 保存用户权限
     * @param {number} role_id 
     * @param {Array<number>} permissionIdList 
     * @returns 
     */
    savePermission(role_id, permissionIdList) {
        let arr = [];
        //第一步：删之前的权限
        arr.push({
            sql: `update ${this.currentTable} set is_del = true ,update_at = ? where role_id =?`,
            params: [new Date(), role_id]
        })
        //第二步：添加现在的权限 
        for (let permission_id of permissionIdList) {
            arr.push({
                sql: `insert into ${this.currentTable} (role_id,permission_id,create_at) values (?,?,?)`,
                params: [role_id, permission_id, new Date()]
            })
        }
        return this.executeTransaction(arr);
    }

}

module.exports = RolePermissionInfoService;