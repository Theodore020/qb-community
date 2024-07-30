<template>
    <el-card header="评论列表">
        <el-form inline>
            <el-form-item label="开始时间">
                <el-date-picker
                    v-model="searchParams.startTime"
                    type="datetime"
                    placeholder="请输入选择时间" />
            </el-form-item>
            <el-form-item label="结束时间">
                <el-date-picker
                    v-model="searchParams.endTime"
                    type="datetime"
                    placeholder="请输入结束时间" />
            </el-form-item>
            <el-form-item>
                <el-button type="primary" icon="search" @click="queryData" :loading="isLoading">查询</el-button>
               
            </el-form-item>
        </el-form>
        <div v-loading="isLoading" element-loading-text="正在加载中.....">
            <!-- 显示表格 -->
            <el-table border stripe :data="listData" height="500">
                <el-table-column label="ID" prop="id" width="90" align="center"></el-table-column>
                <el-table-column label="用户账号" prop="account" ></el-table-column>
                <el-table-column label="用户昵称" prop="nick_name"></el-table-column>
                <el-table-column label="评论内容" prop="comment_text" width="350"></el-table-column>
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
                <el-table-column label="操作" align="center">
                    <template #default="{ row }">
                        <el-button size="small" v-permission-check="'commentInfo:deleteById'" type="danger" icon="delete"
                            @click="deleteCurrent(row.id)">删除</el-button>
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


</template>
<script>
import formarDateTime from "@/utils/formatDateTime";
import API from "@/API";
import { ElMessageBox, ElMessage } from "element-plus";
export default {
    name: "CommentInfoList",
    data() {
        return {
            listData: [],
            pageCount: 0,
            totalCount: 0,
            isLoading: true,
            searchParams: {
                pageIndex: 1,
                startTime: "",
                endTime: ""
            },
            isShowEditPostInfoDialog: false,
            currentEditId: null
        }
    },
    created() {
        this.getListByPage();
    },
    methods: {
        getListByPage() {
            this.isLoading = true;
            API.commentInfo.getListByPage(this.searchParams)
                .then(result => {
                    console.log(result.data);
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
                API.commentInfo.deleteById(id).then(result => {
                    ElMessage.success('删除成功');
                    this.getListByPage();
                })
            }).catch(() => { });
        },
        pageChange(newPageIndex) {
            this.searchParams.pageIndex = newPageIndex;
            this.getListByPage();
        },
    },
}
</script>
<style scoped></style>