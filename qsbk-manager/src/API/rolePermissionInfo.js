import axiosInstance from "@/utils/axiosInstance.js";

const rolePermissionInfo = {
    /**
     * 根据角色id获取权限列表
     * @param role_id
     */
    getPermissionListByRoleId(role_id) {
        return axiosInstance.get(`/rolePermissionInfo/getPermissionListByRoleId/${role_id}`);
    },
    /**
     * 保存角色的权限
     * @param {number} role_id
     * @param {Array<Number>>} permissionIdList
     */
    savePermission(role_id,permissionIdList){
        return axiosInstance.put(`/rolePermissionInfo/savePermission/${role_id}`,{
            permissionIdList
        })
    }
}

export default rolePermissionInfo;