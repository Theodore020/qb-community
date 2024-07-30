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

router.currentService = ServiceFactory.createRolePermissionInfoService();
router.routerName="rolePermissionInfo"
router.get(`/getPermissionListByRoleId/:role_id`, permissionCheck("rolePermissionInfo:savePermission"),async (req, resp) => {
    let result = await ServiceFactory.createRolePermissionInfoService().getPermissionListByRoleId(req.params.role_id);
    resp.json(new ResultJson(true, "获取数据成功", result));
});

router.put(`/savePermission/:role_id`,permissionCheck("rolePermissionInfo:savePermission") ,async (req, resp) => {
    let { permissionIdList } = req.body;
    let result = await ServiceFactory.createRolePermissionInfoService().savePermission(req.params.role_id, permissionIdList);
    resp.json(new ResultJson(true, "保存成功"));
})

module.exports = router;