<template>
    <el-card header="角色信息">
        <el-form inline>
            <el-form-item label="分类名称">
                <el-input placeholder="输入分类名称查询" v-model="searchParams.category_name" />
            </el-form-item>
            <el-form-item>
                <el-button v-permission-check="'categoryInfo:getListByPage'" type="primary" icon="search" @click="queryData" :loading="isLoading">查询</el-button>
                <el-button v-permission-check="'categoryInfo:add'" type="success" icon="plus"  @click="isShowAddCategoryInfoDialog = true">新增分类</el-button>
            </el-form-item>
        </el-form>
        <div v-loading="isLoading" element-loading-text="正在加载中.....">
            <!-- 显示表格 -->
            <el-table border stripe :data="listData" height="600">
                <el-table-column label="ID" prop="id" width="90" align="center"></el-table-column>
                <el-table-column label="分类名称" prop="category_name"></el-table-column>
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
                <el-table-column label="操作" align="center" width="200">
                    <template #default="{ row }">
                        <el-button size="small" v-permission-check="'categoryInfo:update'" type="primary" icon="edit" @click="editCurrent(row.id)">编辑</el-button>
                        <el-button size="small" v-permission-check="'categoryInfo:deleteById'" type="danger" icon="delete" @click="deleteCurrent(row.id)">删除</el-button>
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
        v-model="isShowAddCategoryInfoDialog"
        :close-on-click-modal="false"
        :close-on-press-escape="false"
        :destroy-on-close="true">
        <template #header>
            <h2 class=" text-[22px] text-gray-600 italic">新增分类</h2>
        </template>
        <add-category-info @close-dialog="isShowAddCategoryInfoDialog = false" @query-data="queryData"/>
    </el-dialog>
    <!-- 编辑 -->
    <el-dialog
        width="900"
        v-model="isShowEditCategoryInfoDialog"
        :close-on-click-modal="false"
        :close-on-press-escape="false"
        :destroy-on-close="true">
        <template #header>
            <h2 class=" text-[22px] text-gray-600 italic">编辑分类</h2>
        </template>
        <edit-category-info :current-edit-id="currentEditId" @close-dialog="isShowEditCategoryInfoDialog = false" />
    </el-dialog>
</template>
<script>
import formarDateTime from "@/utils/formatDateTime";
import API from "@/API";
import { ElMessageBox, ElMessage } from "element-plus";
import AddCategoryInfo from "./AddCategoryInfo.vue";
import EditCategoryInfo from "./EditCategoryInfo.vue";
export default {
    name: "RoleInfoList",
    data() {
        return {
            listData: [],
            pageCount: 0,
            totalCount: 0,
            isLoading: true,
            searchParams: {
                pageIndex: 1,
                category_name: ""
            },
            isShowAddCategoryInfoDialog: false,
            isShowEditCategoryInfoDialog: false,
            currentEditId: null
        }
    },
    created() {
        this.getListByPage();
    },
    methods: {
        getListByPage() {
            this.isLoading = true;
            API.categoryInfo.getListByPage(this.searchParams)
                .then(result => {
                    this.listData = result.data.listData;
                    this.totalCount = result.data.totalCount;
                    this.pageCount = result.data.pageCount;
                }).finally(() => {
                    this.isLoading = false;
                })
        },
        formarDateTime,
        queryData() {
            this.searchParams.pageIndex = 1;
            this.getListByPage();
        },
        deleteCurrent(id) {
            ElMessageBox.confirm('确定删除该分类吗？', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                API.categoryInfo.deleteById(id).then(result => {
                    ElMessage.success('删除成功');
                    this.getListByPage();
                })
            }).catch(() => { });
        },
        editCurrent(id) {
            this.currentEditId = id;
            this.isShowEditCategoryInfoDialog = true;
        },
        pageChange(newPageIndex) {
            this.searchParams.pageIndex = newPageIndex;
            this.getListByPage();
        },
    },
    components: {
        AddCategoryInfo,
        EditCategoryInfo
    }
}
</script>
<style scoped></style>