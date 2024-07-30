<template>
    <el-card>
        <template #header>权限列表</template>
        <div>
            <el-button type="primary" icon="refresh" @click="getPermissionTreeData()" :loading="isLoading">刷新权限列表
            </el-button>
            <el-button v-permission-check="'permissionInfo:add'" type="success" icon="plus" @click="isShowAddPermissionInfoDialog = true">新增权限</el-button>
        </div>
        <el-table
            stripe
            size="small"
            :data="listData" row-key="id">
            <el-table-column label="权限名称" prop="permission_name" width="150"></el-table-column>
            <el-table-column label="权限类型">
                <template #default="{ row }">
                    <el-tag effect="dark" type="danger" v-if="row.permission_type == 0">目录</el-tag>
                    <el-tag effect="dark" type="success" v-else-if="row.permission_type == 1">页面</el-tag>
                    <el-tag effect="dark" type="warning" v-else-if="row.permission_type == 2">按钮</el-tag>
                </template>
            </el-table-column>
            <el-table-column label="权限标识" prop="permission_key"></el-table-column>
            <el-table-column label="图标" prop="icon"></el-table-column>
            <el-table-column label="路由路径" prop="route_path" width="200"></el-table-column>
            <el-table-column label="组件路径" prop="component_path" width="200"></el-table-column>
            <el-table-column label="排序" prop="sort"></el-table-column>
            <el-table-column label="权限说明" prop="marks" width="180"></el-table-column>
            <el-table-column label="操作" width="200">
                <template #default="{ row }">
                    <el-button v-permission-check="'permissionInfo:update'" size="small" type="primary" icon="edit" @click="editCurrent(row.id)">编辑</el-button>
                    <el-button v-permission-check="'permissionInfo:deleteById'" size="small" type="danger" icon="delete" @click="deleteCurrent(row.id)">删除</el-button>
                </template>
            </el-table-column>
        </el-table>
    </el-card>
    <!--  新增的模态框   -->
    <el-dialog
        width="900"
        v-model="isShowAddPermissionInfoDialog"
        :close-on-click-modal="false"
        :close-on-press-escape="false"
        :destroy-on-close="true">
        <template #header>
            <h2 class=" text-[22px] text-gray-600 italic">新增权限</h2>
        </template>
        <add-permission-info @close-dialog="isShowAddPermissionInfoDialog = false" />
    </el-dialog>
    <!--编辑-->
    <el-dialog
        width="900"
        v-model="isShowEditPermissionInfoDialog"
        :close-on-click-modal="false"
        :close-on-press-escape="false"
        :destroy-on-close="true">
        <template #header>
            <h2 class=" text-[22px] text-gray-600 italic">编辑权限</h2>
        </template>
        <edit-permission-info :current-edit-id="currentEditId" @close-dialog="isShowEditPermissionInfoDialog = false" />
    </el-dialog>
</template>

<script>
import AddPermissionInfo from "./AddpermissionInfo.vue";
import EditPermissionInfo from "./EditPermissionInfo.vue";
import API from "@/API/index.js";
export default {
    name: "PermissionInfoList",
    data() {
        return {
            isShowAddPermissionInfoDialog: false,
            listData: [],
            isLoading: false,
            isShowEditPermissionInfoDialog: false,
            currentEditId: null
        }
    },
    created() {
        this.getPermissionTreeData();
    },
    methods: {
        getPermissionTreeData() {
            this.isLoading = true;
            API.permissionInfo.getPermissionTreeData()
                .then(result => {
                    this.listData = result.data;
                }).finally(() => {
                    this.isLoading = false;
                });
        },
        deleteCurrent(id) {
            ElMessageBox.confirm('确定删除该用户吗？', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                API.permissionInfo.deleteById(id).then(result => {
                    ElMessage.success('删除成功');
                    this.getPermissionTreeData();
                })
            }).catch(() => {
            });
        },
        editCurrent(id) {
            this.currentEditId = id;
            this.isShowEditPermissionInfoDialog = true;
        },
    },
    components: {
        AddPermissionInfo,
        EditPermissionInfo
    }
}
</script>
<style scoped></style>