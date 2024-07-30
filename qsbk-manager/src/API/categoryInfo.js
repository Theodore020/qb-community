import axiosInstance from "@/utils/axiosInstance";
const categoryInfo = {
    getListByPage({ category_name, pageIndex }) {
        return axiosInstance.get(`/categoryInfo/getListByPage`, {
            params: {
                category_name, pageIndex
            }
        })
    },
    deleteById(id) {
        return axiosInstance.delete(`/categoryInfo/deleteById/${id}`);
    },
    add({ category_name }) {
        return axiosInstance.post(`/categoryInfo/add`, {
            category_name
        })
    },
    findById(id) {
        return axiosInstance.get(`/categoryInfo/findById/${id}`);
    },
    update({ category_name, id }) {
        return axiosInstance.put(`/categoryInfo/update/${id}`, {
            category_name, id
        })
    }
}

export default categoryInfo;