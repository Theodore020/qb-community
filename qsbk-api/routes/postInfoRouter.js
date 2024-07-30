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

router.currentService = ServiceFactory.createPostInfoService();
router.routerName="postInfo";
router.get("/getListByPage", permissionCheck("postInfo:getListByPage"),async (req, resp) => {
    let pageList = await ServiceFactory.createPostInfoService().getListByPage(req.query);
    resp.json(new ResultJson(true, "数据获取成功", pageList));
});
module.exports = router;