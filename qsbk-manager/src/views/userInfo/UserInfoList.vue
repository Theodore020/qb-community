<template>
    <el-card header="用户信息">
        <el-form inline>
            <el-form-item label="账号">
                <el-input placeholder="输入账号查询" v-model="searchParams.account" />
            </el-form-item>
            <el-form-item label="手机号">
                <el-input placeholder="输入手机号查询" v-model="searchParams.telephone" />
            </el-form-item>
            <el-form-item>
                <el-button v-permission-check="'userInfo:getListByPage'" type="primary" icon="search" @click="queryData" :loading="isLoading">查询</el-button>
                <el-button v-permission-check="'userInfo:add'" type="success" icon="plus" @click="isShowAddUserInfoDialog = true">新增用户</el-button>
            </el-form-item>
        </el-form>
        <div v-loading="isLoading" element-loading-text="正在加载中.....">
            <!-- 显示表格 -->
            <el-table border stripe :data="listData" height="500">
                <el-table-column label="ID" prop="id" width="90" align="center"></el-table-column>
                <el-table-column label="账号" prop="account" width="120"></el-table-column>
                <el-table-column label="昵称" prop="nick_name" width="100"></el-table-column>
                <el-table-column label="头像" width="120" align="center">
                    <template #default="{ row }">
                        <el-image :preview-teleported="true" :z-index="9999" :src="baseURL + row.avatar"
                            :preview-src-list="[baseURL + row.avatar]" class="w-[60px] h-[60px]"></el-image>
                    </template>
                </el-table-column>
                <el-table-column label="手机号" prop="telephone" align="center" width="120"></el-table-column>
                <el-table-column label="邮箱" prop="email" width="200"></el-table-column>
                <el-table-column label="角色" align="center" width="120">
                    <template #default="{ row }">
                        <el-tag v-for="(item, index) in row.roles" :key="index">{{ item.role_name }}</el-tag>
                    </template>
                </el-table-column>
                <el-table-column label="创建时间" width="200" align="center">
                    <template #default="{ row }">
                        {{ formarDateTime(row.create_at) }}
                    </template>
                </el-table-column>
                <el-table-column label="修改时间" width="200" align="center">
                    <template #default="{ row }">
                        {{ formarDateTime(row.update_at) }}
                    </template>
                </el-table-column>
                <el-table-column label="操作" align="center" width="270" fixed="right">
                    <template #default="{ row }">
                        <el-button v-permission-check="'userInfo:update'" type="primary" size="small" icon="edit" @click="editCurrent(row.id)">编辑</el-button>
                        <el-button v-permission-check="'userInfo:deleteById'" type="danger"  size="small" icon="delete" @click="deleteCurrent(row.id)">删除</el-button>
                        <el-button v-permission-check="'userRoleInfo:saveRoleData'" type="success" size="small" icon="stamp" @click="startAuthRole(row.id)">分配角色</el-button>
                    </template>
                </el-table-column>
            </el-table>
            <div class="flex flex-row justify-between items-center mt-[10px]">
                <p class="text-[12px]">当前第{{ searchParams.pageIndex }}页，共{{ pageCount }}页，共{{ totalCount }}条</p>
                <el-pagination :total="totalCount" @current-change="pageChange" :current-page="searchParams.pageIndex"
                    background layout="prev,pager,next"></el-pagination>
            </div>
        </div>
    </el-card>
    <!-- 弹出一个模态框 -->
    <el-dialog
        width="900"
        v-model="isShowAddUserInfoDialog"
        :close-on-click-modal="false"
        :close-on-press-escape="false"
        :destroy-on-close="true">
        <template #header>
            <h2 class=" text-[22px] text-gray-600 italic">新增用户信息</h2>
        </template>
        <add-user-info @close-dialog="isShowAddUserInfoDialog = false" />
    </el-dialog>
    <!-- 编辑的模块框 -->
    <el-dialog
        width="900"
        v-model="isShowEditUserInfoDialog"
        :close-on-click-modal="false"
        :close-on-press-escape="false"
        :destroy-on-close="true">
        <template #header>
            <h2 class=" text-[22px] text-gray-600 italic">编辑用户信息</h2>
        </template>
        <edit-user-info :current-edit-id="currentEditId" @close-dialog="isShowEditUserInfoDialog = false" />
    </el-dialog>
    <!-- 开始授权 -->
    <el-dialog
        width="900"
        v-model="isShowAuthRoleDialog"
        :close-on-click-modal="false"
        :close-on-press-escape="false"
        :destroy-on-close="true">
        <template #header>
            <h2 class=" text-[22px] text-gray-600 italic">用户授权</h2>
        </template>
        <auth-role :user_id="currentAuthUserId" @close-dialog="isShowAuthRoleDialog = false" />
    </el-dialog>
</template>
<script>
import formarDateTime from "@/utils/formatDateTime";
import API from "@/API";
import { ElMessageBox, ElMessage } from "element-plus";
import AddUserInfo from "./AddUserInfo.vue";
import EditUserInfo from './EditUserInfo.vue';
import AuthRole from './AuthRole.vue';
export default {
    name: "UserInfoList",
    data() {
        return {
            searchParams: {
                account: "",
                telephone: "",
                pageIndex: 1
            },
            listData: [],
            pageCount: 0,
            totalCount: 0,
            isLoading: false,
            isShowAddUserInfoDialog: false,
            isShowEditUserInfoDialog: false,
            currentEditId: null,
            isShowAuthRoleDialog:false,
            // 正在授权的用户的id
            currentAuthUserId:null
        }
    },
    created() {
        this.getListByPage();
    },
    methods: {
        getListByPage() {
            this.isLoading = true;
            API.userInfo.getListByPage(this.searchParams)
                .then(result => {
                    this.listData = result.data.listData;
                    this.totalCount = result.data.totalCount;
                    this.pageCount = result.data.pageCount;
                }).finally(() => {
                    this.isLoading = false;
                })
        },
        formarDateTime,
        pageChange(newPageIndex) {
            this.searchParams.pageIndex = newPageIndex;
            this.getListByPage();
        },
        queryData() {
            this.searchParams.pageIndex = 1;
            this.getListByPage();
        },
        deleteCurrent(id) {
            ElMessageBox.confirm('确定删除该用户吗？', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                API.userInfo.deleteById(id).then(result => {
                    ElMessage.success('删除成功');
                    this.getListByPage();
                })
            }).catch(() => { });
        },
        editCurrent(id) {
            this.currentEditId = id;
            this.isShowEditUserInfoDialog = true;

        },
        //开始授权
        startAuthRole(id) {
            this.currentAuthUserId = id;
            this.isShowAuthRoleDialog = true;
        }   
    },
    components: {
        AddUserInfo,
        EditUserInfo,
        AuthRole
    }
}
</script>
<style scoped></style>