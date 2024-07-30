const express = require('express');
const router = express.Router();
const ResultJson = require("../model/ResultJson");
const ServiceFactory = require("../factory/ServiceFactory");
const path = require("path");
const { v4: uuidv4 } = require("uuid");
const ExcelUtils = require("../utils/ExcelUtils");
const jwt = require("jsonwebtoken");
const APPConfig = require("../config/APPConfig");
const permissionCheck = require("../utils/permissionCheck");
const fs = require("fs");

router.currentService = ServiceFactory.createUserInfoService();
router.routerName="userInfo";


router.get("/getListByPage", permissionCheck("userInfo:getListByPage"),async (req, resp) => {
    let pageList = await ServiceFactory.createUserInfoService().getListByPage(req.query);
    resp.json(new ResultJson(true, "数据获取成功", pageList));
});
router.post("/register",async (req, resp) => {
    let flag = await ServiceFactory.createUserInfoService().register(req.body);
    resp.json(new ResultJson(flag, flag ? "注册成功" : "账号已存在"));
});

router.post("/uploadAvatar", async (req, resp) => {
    //这个时候接收到的值是base64格式
    const { base64 } = req.body;
    //这里一定要将base64进行裁剪 ，nodejs里面是不需要前在的东西的
    let base64Str = base64.replace(/^data:image\/\w+;base64,/, "");
    let fileName = uuidv4() + ".png";
    fs.writeFileSync(path.join(__dirname, "../upload/avatar", fileName), base64Str, "base64");
    resp.json(new ResultJson(true, "上传成功", `/upload/avatar/${fileName}`));
});


router.post("/checkLogin", async (req, resp) => {
    let result = await ServiceFactory.createUserInfoService().checkLogin(req.body);
    let flag = Boolean(result);
    if (flag) {
        Reflect.deleteProperty(result, "password");
        //登录成功

        //得到当前用户的权限
        let permissionList = await ServiceFactory.createPermissionInfoService().getPermissionListByUserId(result.id);
        //只希望得到权限的所有的permission_key
        const eachPermissioniKey = list => {
            let arr = [];
            list.forEach(item => {
                arr.push(item.permission_key);
                if (item.children && Array.isArray(item.children)) {
                    arr.push(...eachPermissioniKey(item.children));
                }
            })
            return arr;
        };
        let allPermissionKey = eachPermissioniKey(permissionList);
        //将得到的permission_key的集合放在result的对象上面
        result.allPermissionKey = allPermissionKey;

        //生成jwt的token
        let token = `Bearer ` + jwt.sign(result, APPConfig.privateKey, {
            expiresIn: "1d"
        });

        resp.json(new ResultJson(true, "登录成功", {
            ...result,
            permissionList,
            token
        }));
    }
    else {
        //登录失败
        resp.json(new ResultJson(false, "用户名和密码错误，登录失败"));
    }
});



module.exports = router;