import axiosInstance from "@/utils/axiosInstance";

const userRoleInfo = {
    getUserRoleListByUserId(user_id) {
        return axiosInstance.get(`/userRoleInfo/getUserRoleListByUserId/${user_id}`);
    },
    saveRoleData(user_id, roleIdList) {
        return axiosInstance.put(`/userRoleInfo/saveRoleData/${user_id}`, {
            roleIdList
        })
    }
}

export default userRoleInfo;