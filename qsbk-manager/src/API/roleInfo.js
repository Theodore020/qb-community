import axiosInstance from "@/utils/axiosInstance";
const roleInfo = {
    getListByPage({ role_name, pageIndex }) {
        return axiosInstance.get(`/roleInfo/getListByPage`, {
            params: {
                role_name, pageIndex
            }
        })
    },
    deleteById(id) {
        return axiosInstance.delete(`/roleInfo/deleteById/${id}`);
    },
    add({ role_name }) {
        return axiosInstance.post(`/roleInfo/add`, {
            role_name
        })
    },
    findById(id) {
        return axiosInstance.get(`/roleInfo/findById/${id}`);
    },
    update({ role_name, id }) {
        return axiosInstance.put(`/roleInfo/update/${id}`, {
            role_name, id
        })
    },
    getAllList() {
        return axiosInstance.get(`/roleInfo/getAllList`);
    }
}

export default roleInfo;