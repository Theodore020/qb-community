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

router.currentService = ServiceFactory.createUserRoleInfoService();
router.routerName="userRoleInfo"
router.get("/getUserRoleListByUserId/:user_id", permissionCheck("userRoleInfo:saveRoleData"),async (req, resp) => {
    let result = await ServiceFactory.createUserRoleInfoService().getUserRoleListByUserId(req.params.user_id);
    resp.json(new ResultJson(true, "数据获取成功", result));
})

/**
 * 对某一个用户的角色数据进行保存
 */
router.put("/saveRoleData/:user_id",permissionCheck("userRoleInfo:saveRoleData"), async (req, resp) => {
    let user_id = req.params.user_id;
    let { roleIdList } = req.body;
    let result = await ServiceFactory.createUserRoleInfoService().saveRoleData(user_id, roleIdList);
    resp.json(new ResultJson(true, "保存成功"));
});
module.exports = router;