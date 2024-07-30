import axiosInstance from "@/utils/axiosInstance";


const commentInfo = {
    getListByPage({post_id,pageIndex}){
        return axiosInstance.get(`/commentInfo/getListByPage`,{
            params:{
                post_id,
                pageIndex
            }
        })
    },
    add({post_id,comment_text}){
        return axiosInstance.post(`/commentInfo/add`,{
            post_id,
            comment_text
        })
    }
}

export default commentInfo;