<template>
    <div v-loading="isLoading" element-loading-text="正在加载中.....">
        <el-checkbox-group v-model="selectedRoleIds">
            <el-checkbox v-for="(item) in allRoles" :key="item.id" :label="item.id">{{ item.role_name }}</el-checkbox>
        </el-checkbox-group>
        <el-space class="mt-[20px]">
            <el-button type="primary" @click="saveData" :loading="isSubmit">保存数据</el-button>
            <el-button type="warning" @click="$emit('close-dialog')">关闭</el-button>
        </el-space>
    </div>
</template>
<script>
import API from '@/API'
import { ElMessage } from 'element-plus';
export default {
    name: "AuthRole",
    emits: ["close-dialog"],
    props: {
        user_id: {
            type: Number,
            required: true
        }
    },
    data() {
        return {
            allRoles: [],
            selectedRoleIds: [],
            isLoading: true,
            isSubmit: false
        }
    },
    created() {
        // this.getAllRoleList();
        // this.getUserRoleInfoByUserId(this.user_id);
        this.initData();
    },
    methods: {
        getAllRoleList() {
            return API.roleInfo.getAllList()
                .then(result => {
                    this.allRoles = result.data;
                    return Promise.resolve();
                })

            //还可以写成下面的方法
            // return new Promise((resolve, reject) => {
            //     API.roleInfo.getAllList()
            //         .then(result => {
            //             this.allRoles = result.data;
            //             resolve()
            //         })
            // })
        },
        getUserRoleInfoByUserId(user_id) {
            return API.userRoleInfo.getUserRoleListByUserId(user_id)
                .then(result => {
                    this.selectedRoleIds = result.data.map(item => item.role_id);
                    return Promise.resolve();
                })
        },
        initData() {
            Promise.all([this.getAllRoleList(), this.getUserRoleInfoByUserId(this.user_id)])
                .then(() => {
                    console.log("成功");
                })
                .finally(() => {
                    this.isLoading = false;
                })
        },
        saveData() {
            this.isSubmit = true;
            API.userRoleInfo.saveRoleData(this.user_id, this.selectedRoleIds)
                .then(result => {
                    ElMessage.success("保存成功");
                    this.$emit("close-dialog");
                }).finally(() => {
                    this.isSubmit = false;
                })
        }
    }
}
</script>
<style scoped></style>