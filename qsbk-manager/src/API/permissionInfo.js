import axiosInstance from "@/utils/axiosInstance.js";

const permissionInfo = {
    /**
     * 新增权限
     */
    add({permission_name, permission_type, permission_key, icon, route_path, component_path, parent_id, sort, marks}) {
        return axiosInstance.post(`/permissionInfo/add`, {
            permission_name,
            permission_type,
            permission_key,
            icon,
            route_path,
            component_path,
            parent_id,
            sort,
            marks
        })
    },
    /**
     * 获取树形结构数据
     */
    getPermissionTreeData() {
        return axiosInstance.get(`/permissionInfo/getPermissionTreeData`);
    },
    /**
     * 删除
     * @param id
     */
    deleteById(id) {
        return axiosInstance.delete(`/permissionInfo/deleteById/${id}`);
    },
    /**
     * 查询
     * @param id
     */
    findById(id) {
        return axiosInstance.get(`/permissionInfo/findById/${id}`);
    },
    /**
     * 更新
     */
    update({id,permission_name, permission_type, permission_key, icon, route_path, component_path, parent_id, sort, marks}){
        return axiosInstance.put(`/permissionInfo/update/${id}`,{
            permission_name,
            permission_type,
            permission_key,
            icon,
            route_path,
            component_path,
            parent_id,
            sort,
            marks
        })
    }
}

export default permissionInfo;