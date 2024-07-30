import axios from "axios";
import { ElNotification } from "element-plus";
import store from "@/store";
import router from "@/router";

const axiosInstance = axios.create({
    baseURL: "http://127.0.0.1:3000",
    timeout: 60000,
    timeoutErrorMessage: "请求服务器超时",
});

//请求拦截
axiosInstance.interceptors.request.use(req => {
    let token = store.getters.token;
    if (token) {
        req.headers.authorization = token;
    }

    return req;
});


//响应拦截
axiosInstance.interceptors.response.use(resp => {
    if (resp.data.code === 1) {
        return Promise.resolve(resp.data);
    }
    else {
        return Promise.reject(resp.data);
    }
}, error => {
    //后期肯定是会根据不同的错误处理不同的操作
    // 一律弹窗
    ElNotification.error({
        title: '错误提示',
        message: error
    });
    if (error.response.status === 401) {
        //去登录页
        router.replace({
            name: "login"
        })
    }
    else if (error.response.status === 403) {
        //跳403
        router.replace({
            name: "403"
        })
    }
    return Promise.reject(error);
})

export default axiosInstance;