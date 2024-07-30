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

router.currentService = ServiceFactory.createPermissionInfoService();
router.routerName="permissionInfo";

router.get("/getPermissionTreeData", permissionCheck("permissionInfo:getPermissionTreeData"),async (req, resp) => {
    let result = await ServiceFactory.createPermissionInfoService().getPermissionTreeData();

    resp.json(new ResultJson(true, "获取数据成功", result));
});


module.exports = router;