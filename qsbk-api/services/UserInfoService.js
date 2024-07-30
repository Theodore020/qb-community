/**
 * 数据表admin_info的操作
 */
const BaseService = require('./BaseService');
const md5 = require("md5");
const APPConfig = require("../config/APPConfig");
const PageList = require("../model/PageList");

class UserInfoService extends BaseService {
    constructor() {
        super();
        this.currentTable = this.tableMap.user_info;
    }

    add({ account, password, nick_name, avatar, telephone, email }) {
        password = md5(password + APPConfig.md5Salt);
        return new Promise((resolve, reject) => {
            let conn = this.getConn();
            conn.beginTransaction(async error => {
                if (error) {
                    reject(error);
                    return;
                }
                try {
                    //第一步：添加用户，获取自增ID
                    let sql1 = `insert into ${this.currentTable} (account,password,nick_name,avatar,telephone,email,create_at) values (?,?,?,?,?,?,?)`;
                    let params1 = [account, password, nick_name, avatar, telephone, email, new Date()];
                    let result = await this.executeSql(sql1, params1, conn);
                    let user_id = result.insertId;
                    //第二步：获取用户的自增id以后，再添加user_role_info表
                    let sql2 = `insert into ${this.tableMap.user_role_info} (user_id,role_id,create_at) values (?,?,?)`;
                    let params2 = [user_id, 2, new Date()];
                    let result2 = await this.executeSql(sql2, params2, conn);
                    conn.commit();
                    resolve(true);
                } catch (error) {
                    conn.rollback();
                    reject(false);
                }
                finally {
                    conn.end();
                }
            })
        })
    }
    //注册
    async existsAccount(account) {
        let sql = `select * from ${this.currentTable} where is_del = false and account = ?`;
        let result = await this.executeSql(sql, [account]);
        return result.length > 0;
    }
    async register({ account, password, nick_name, avatar, telephone, email }) {
        let flag = await this.existsAccount(account);
        if (flag) {
            throw new Error("该账号已存在");
        }
        else {
            password = md5(password + APPConfig.md5Salt);
            return new Promise((resolve, reject) => {
                let conn = this.getConn();
                conn.beginTransaction(async error => {
                    if (error) {
                        reject(error);
                        return;
                    }
                    try {
                        //第一步：添加用户，获取自增ID
                        let sql1 = `insert into ${this.currentTable} (account,password,nick_name,avatar,telephone,email,create_at) values (?,?,?,?,?,?,?)`;
                        let params1 = [account, password, nick_name, avatar, telephone, email, new Date()];
                        let result = await this.executeSql(sql1, params1, conn);
                        let user_id = result.insertId;
            //第二步：获取用户的自增id以后，再添加user_role_info表
                        let sql2 = `insert into ${this.tableMap.user_role_info} (user_id,role_id,create_at) values (?,?,?)`;
                        let params2 = [user_id, 2, new Date()];
                        let result2 = await this.executeSql(sql2, params2, conn);
                        conn.commit();
                        resolve(true);
                    } catch (error) {
                        conn.rollback();
                        reject(false);
                    }
                    finally {
                        conn.end();
                    }
                })
            })
        }
}


    /**
         * 判断账号是否存在
         * @param {string} account 
         * @returns {Promise<boolean>} true存在,false不存在
    */
    async existsAccount(account) {
        let sql = `select * from ${this.currentTable} where is_del  = false and account = ?`;
        let result = await this.executeSql(sql, [account]);
        return result.length > 0;
    }





    //重写add的方法
    add_old({ account, password, nick_name, avatar, telephone, email }) {
        password = md5(password + APPConfig.md5Salt);
        //需要使用事务，添加完当前的用户以后，还要在用户的角色表里面添加用户为普通 角色
        return new Promise((resolve, reject) => {
            let conn = this.getConn();
            conn.beginTransaction(error => {
                if (error) {
                    reject(error);
                    return;
                }
                //第一步：添加用户，获取自增ID
                let sql1 = `insert into ${this.currentTable} (account,password,nick_name,avatar,telephone,email,create_at) values (?,?,?,?,?,?,?)`;
                let params1 = [account, password, nick_name, avatar, telephone, email, new Date()]
                conn.query(sql1, params1, (err, result) => {
                    if (err) {
                        reject(err);
                        conn.rollback();
                        conn.end();
                    }
                    else {
                        let user_id = result.insertId;
                        //第二步：获取用户的自增id以后，再添加user_role_info表
                        let sql2 = `insert into ${this.tableMap.user_role_info} (user_id,role_id,create_at) values (?,?,?)`;
                        let params2 = [user_id, 2, new Date()];
                        conn.query(sql2, params2, (err, result) => {
                            if (err) {
                                reject(err);
                                conn.rollback();
                                conn.end();
                            }
                            else {
                                resolve(true);
                                conn.commit();
                                conn.end();
                            }
                        })
                    }
                })
            })
        })


    }

    async getListByPage({ account, telephone, pageIndex = 1 }) {
        let [listData, total_count] = await this.createQuery(this.currentTable)
            .like("account", account)
            .like("telephone", telephone)
            .setPageIndex(pageIndex)
            .getPageAndCount();
        //得么所有的id
        let user_id_list = listData.map(item => item.id);
        let sql = `select user_role_info.*,role_info.role_name from user_role_info 
            inner join role_info on user_role_info.role_id = role_info.id
            where user_role_info.is_del = false  and  user_id in (${user_id_list.toString()})
        `;
        let result = await this.executeSql(sql);
        //构建map
        let map = new Map();
        for (let item of result) {
            let current = map.get(item.user_id);
            if (current) {
                current.roles.push({ role_id: item.role_id, role_name: item.role_name })
            }
            else {
                map.set(item.user_id, {
                    user_id: item.user_id,
                    roles: [{ role_id: item.role_id, role_name: item.role_name }]
                })
            }
        }
        //构建roles的属性
        for (let item of listData) {
            if (map.has(item.id)) {
                item.roles = map.get(item.id).roles;
            }
            else {
                item.roles = [];
            }
        }
        return new PageList(pageIndex, total_count, listData);
    }

    /**
     * 后台用户登录
     * @param {{account:string,password:string}} param0 
     * @returns {Promise<Object | undefined>} 
     */
    async checkLogin({ account, password }) {
        password = md5(password + APPConfig.md5Salt);
        let sql = `select * from ${this.currentTable} where account =? and password =? and is_del = false`;
        let result = await this.executeSql(sql, [account, password]);
        return result[0];
    }

    /**
     * 用户登录
     * @param {{account:string,password:string}} param0 
     * @returns {Promise<Object | undefined>} 
     */
    async userCheckLogin({ account, password }) {
        password = md5(password + APPConfig.md5Salt);
        let sql = `select * from user_info
        inner join user_role_info on user_info.id = user_role_info.user_id
        where user_role_info.role_id = 2 and user_info.is_del = false
        and user_info.account = ? and user_info.password = ?`;
        let result = await this.executeSql(sql, [account, password]);
        return result[0];
    }


}

module.exports = UserInfoService;