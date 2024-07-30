const express = require('express');
const router = express.Router();
const fs = require('fs');
const path = require('path');

/**
 * 加载路由
 * @param {import("express").Express} app 
 */
const loadRoutes = app => {
    let arr = fs.readdirSync(path.join(__dirname, "../apiroutes"));
    for (let item of arr) {
        let router = require(path.join(__dirname, "../apiroutes", item));
        app.use(`/${item.replace("Router.js", "")}`, router);
    }
}

loadRoutes(router);
module.exports = router;