import axiosInstance from "@/utils/axiosInstance";

const commentInfo={
    getListByPage({ startTime,endTime, pageIndex }) {
        return axiosInstance.get(`/commentInfo/getListByPage`, {
            params: {
                startTime,endTime, pageIndex
            }
        })
    },
    deleteById(id) {
        return axiosInstance.delete(`/commentInfo/deleteById/${id}`);
    },
}

export default commentInfo;