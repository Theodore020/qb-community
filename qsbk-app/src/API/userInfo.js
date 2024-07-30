import axiosInstance from "@/utils/axiosInstance";


const userInfo = {
    checkLogin({ account, password }) {
        return axiosInstance.post(`/userInfo/checkLogin`, {
            account, password
        })
    }
}

export default userInfo;