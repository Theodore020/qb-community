import axiosInstance from "@/utils/axiosInstance";

const postInfo = {
    getListByPage({ startTime,endTime, pageIndex }) {
        return axiosInstance.get(`/postInfo/getListByPage`, {
            params: {
                startTime,endTime, pageIndex
            }
        })
    },
    deleteById(id) {
        return axiosInstance.delete(`/postInfo/deleteById/${id}`);
    },
    update({ post_content, id }) {
        return axiosInstance.put(`/postInfo/update/${id}`, {
            post_content, id
        })
    },
    findById(id) {
        return axiosInstance.get(`/postInfo/findById/${id}`);
    },
    add({ post_content }) {
        return axiosInstance.post(`/postInfo/add`, {
            post_content
        })
    },
}

export default postInfo;