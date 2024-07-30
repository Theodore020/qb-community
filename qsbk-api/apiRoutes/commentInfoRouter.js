const express = require('express');
const router = express.Router();
const ResultJson = require("../model/ResultJson");
const ServiceFactory = require("../factory/ServiceFactory");
const path = require("path");
const { v4: uuidv4 } = require("uuid");
const ExcelUtils = require("../utils/ExcelUtils");
const jwt = require("jsonwebtoken");
const APPConfig = require("../config/APPConfig");
const apiPermissionCheck = require("../utils/apiPermissionCheck");

router.currentService = ServiceFactory.createCommentInfoService();

router.get("/getListByPage", async (req, resp) => {
    let pageList = await ServiceFactory.createCommentInfoService().getListByPage(req.query);
    resp.json(new ResultJson(true, "数据获取成功", pageList));
})

router.post("/add", apiPermissionCheck(), async (req, resp) => {
    let user_id = req.user.user_id;
    const { post_id, comment_text } = req.body;
    let result = await ServiceFactory.createCommentInfoService().add({
        post_id,
        comment_text,
        user_id
    });
    resp.json(new ResultJson(true, "评论成功", result));
})




module.exports = router;