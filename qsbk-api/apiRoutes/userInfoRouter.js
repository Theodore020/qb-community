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

router.currentService = ServiceFactory.createUserInfoService();



router.post("/checkLogin", async (req, resp) => {
    let result = await ServiceFactory.createUserInfoService().userCheckLogin(req.body);
    let flag = Boolean(result);
    if (flag) {
        //登录成功
        //后期的token也要像之前学习RBAC一样，去把加权也放进去
        let token = `Bearer ` + jwt.sign(result, APPConfig.privateKey, {
            expiresIn: "1d"
        });

        resp.json(new ResultJson(true, "登录成功", {
            ...result,
            token
        }))
    }
    else {
        resp.json(new ResultJson(false, "登录失败，用户名密码不正确，或不具备登录的权限"));
    }
});




module.exports = router;

