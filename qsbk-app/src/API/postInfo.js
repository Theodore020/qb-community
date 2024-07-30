import axiosInstance from "@/utils/axiosInstance";


const postInfo = {
    getListByPageForCategory({ category_id, pageIndex }) {
        return axiosInstance.get(`/postInfo/getListByPageForCategory`, {
            params: {
                category_id,
                pageIndex
            }
        })
    },
    findById(id) {
        return axiosInstance.get(`/postInfo/findById/${id}`);
    },
    setPraised(post_id){
        return axiosInstance.put(`/postInfo/setPraised/${post_id}`);
    },
    add(formData){
        return axiosInstance.post(`/postInfo/add`,formData);
    },
    setHate(post_id){
        return axiosInstance.put(`/postInfo/setHate/${post_id}`);
    },
}

export default postInfo;