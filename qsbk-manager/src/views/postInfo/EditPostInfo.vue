<template>
    <el-skeleton :rows="8" animated :loading="isLoading">
        <el-form label-width="120" :model="formData" :rules="formRules" ref="form" v-loading="isSubmitForm"
            element-loading-text="正在提交表单">
            
            <el-input
                v-model="formData.post_content"
                :rows="4"
                type="textarea"
                placeholder="请输入帖子内容" />
            <el-form-item class="mt-[10px]">
                <el-button type="primary" @click="submitForm">保存数据</el-button>
                <el-button type="warning" @click="resetForm">重置表单</el-button>
            </el-form-item>
        </el-form>
    </el-skeleton>
</template>
<script>
import API from '@/API';
import { ElMessage } from "element-plus";

export default {
    name: "EditPostInfo",
    emits: ["close-dialog"],
    props: {
        currentEditId: {
            type: Number,
            required: true
        }
    },
    data() {
        return {
            formData: {
                id: "",
                post_content: ""
            },
            //表单验证的规则 
            formRules: {
                post_content: [
                    { required: true, message: "请输入分类名称", trigger: "blur" }
                ],

            },
            isSubmitForm: false,
            isLoading: true
        }
    },
    created() {
        API.postInfo.findById(this.currentEditId)
            .then(result => {
                this.formData = result.data;
                this.isLoading = false;
            })
    },
    methods: {
        submitForm() {
            //提交表单之前，先做一次表单验证
            this.$refs.form.validate(valid => {
                if (valid) {
                    //表单验证成功
                    this.editPostInfo();
                }
                else {
                    //表单验证不成功
                }
            });
        },
        editPostInfo() {
            this.isSubmitForm = true;
            API.postInfo.update(this.formData)
                .then(result => {
                    ElMessage.success("修改成功");
                    this.$emit("close-dialog");
                }).finally(() => {
                    this.isSubmitForm = false;
                })
        },
        //重置表单
        resetForm() {
            this.$refs.form.resetFields();
        },
    },

}
</script>
<style scoped></style>