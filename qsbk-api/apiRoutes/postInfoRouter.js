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
const multer = require("multer");
const upload = multer({
    dest: path.join(__dirname, "../upload/postImg")
})
const fs = require("fs");
router.currentService = ServiceFactory.createPostInfoService()

router.get("/getListByPageForCategory", async (req, resp) => {

    let pageList = await ServiceFactory.createPostInfoService().getListByPageForCategory(req.query);
    let token = req.headers["authorization"];
    if (token) {
        try {
            let decode = jwt.decode(token.replace("Bearer ", ""), APPConfig.privateKey);
            //解码成功,
            let user_id = decode.user_id;
            pageList.listData.forEach(item => {
                if (item.praise) {
                    let arr1 = item.praise.split(",");
                    if (arr1.findIndex(item => item == user_id) > -1) {
                        item.isPraise = true;
                    }
                }
                if (item.hate) {
                    let arr2 = item.hate.split(",");
                    if (arr2.findIndex(item => item == user_id) > -1) {
                        item.isHate = true;
                    }
                }
            })
            resp.json(new ResultJson(true, "数据获取成功", pageList));
        } catch (error) {
            resp.json(new ResultJson(true, "数据获取成功", pageList));
        }
    }
    else {
        resp.json(new ResultJson(true, "数据获取成功", pageList));
    }
});

router.get("/findById/:id", async (req, resp) => {
    let result = await ServiceFactory.createPostInfoService().findById(req.params.id)
    resp.json(new ResultJson(Boolean(result), result ? "获取数据成功" : "获取数据失败", result))
})

router.put("/setPraised/:post_id", apiPermissionCheck(), async (req, resp) => {
    let user_id = req.user.user_id;
    let praise_count = await ServiceFactory.createPostInfoService().setPraised({
        post_id: req.params.post_id,
        user_id
    });
    resp.json(new ResultJson(true, "点赞成功", { praise_count }));
});

router.put("/setHate/:post_id", apiPermissionCheck(), async (req, resp) => {
    let user_id = req.user.user_id;
    let hate_count = await ServiceFactory.createPostInfoService().setHate({
        post_id: req.params.post_id,
        user_id
    });
    resp.json(new ResultJson(true, "踩成功", { hate_count }));
});


router.post("/add", [apiPermissionCheck(), upload.array("post_img")], async (req, resp) => {
    //关闭问题是新增的时候可能会保存图片
    let postImgList = [];
    if (req.files) {
        req.files.forEach(file => {
            let newFileName = uuidv4() + file.originalname;
            fs.renameSync(file.path, path.join(file.destination, newFileName))
            postImgList.push(`/upload/postImg/${newFileName}`);
        })
    }
    let user_id = req.user.user_id;

    let flag = await ServiceFactory.createPostInfoService().add({
        ...req.body,
        user_id,
        postImgList
    })

    resp.json(new ResultJson(flag, flag ? "发贴成功" : "发贴失败"));
});
module.exports = router;