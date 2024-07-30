import axiosInstance from "@/utils/axiosInstance";


const userInfo = {
    getListByPage({ account, telephone, pageIndex }) {
        return axiosInstance.get(`/userInfo/getListByPage`, {
            params: {
                account, telephone, pageIndex
            }
        })
    },
    deleteById(id) {
        return axiosInstance.delete(`/userInfo/deleteById/${id}`);
    },
    uploadAvatar(base64) {
        return axiosInstance.post(`/userInfo/uploadAvatar`, {
            base64
        })
    },
    add({ account, password, nick_name, avatar, telephone, email }) {
        return axiosInstance.post(`/userInfo/add`, {
            account, password, nick_name, avatar, telephone, email
        })
    },
    findById(id) {
        return axiosInstance.get(`/userInfo/findById/${id}`);
    },
    update({ account, nick_name, telephone, email, avatar, id }) {
        return axiosInstance.put(`/userInfo/update/${id}`, {
            account, nick_name, telephone, email, avatar, id
        })
    },
    checkLogin({ account, password }) {
        return axiosInstance.post(`/userInfo/checkLogin`, {
            account, password
        })
    },
    register({ account, password, nick_name, avatar, telephone, email }) {
        return axiosInstance.post(`/userInfo/register`, {
            account, password, nick_name, avatar, telephone, email
        })
    },
}

export default userInfo;