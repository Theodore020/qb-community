import axios from "axios";
import userInfoStore from "@/store/userInfoStore";

const axiosInstance = axios.create({
    baseURL: "http://127.0.0.1:3000/api",
    timeout: 60000,
    timeoutErrorMessage: "请求服务器超时",
});

//请求拦截
axiosInstance.interceptors.request.use(req => {
    let _userInfoStore = userInfoStore();
    let token = _userInfoStore.token
    if (token) {
        req.headers["Authorization"] = token
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
    return Promise.reject(error);
})

export default axiosInstance;