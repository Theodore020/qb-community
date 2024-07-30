<template>
    <el-form label-width="120" :model="formData" :rules="formRules" ref="form" v-loading="isSubmitForm" element-loading-text="正在提交表单">
        <el-form-item label="角色名称" prop="role_name">
            <el-input placeholder="请输入角色名称" v-model="formData.role_name" />
        </el-form-item>
        <el-form-item>
            <el-button type="primary" @click="submitForm">保存数据</el-button>
            <el-button type="warning" @click="resetForm">重置表单</el-button>
        </el-form-item>
    </el-form>
</template>
<script>
import API from '@/API';
import { ElMessage } from "element-plus";

export default {
    name: "AddRoleInfo",
    emits:["close-dialog"],
    data() {
        return {
            formData: {
               role_name:""
            },
            //表单验证的规则 
            formRules: {
                role_name: [
                    { required: true, message: "请输入角色名称", trigger: "blur" }
                ],
               
            },
            isSubmitForm:false
        }
    },
    methods: {
        submitForm() {
            //提交表单之前，先做一次表单验证
            this.$refs.form.validate(valid => {
                if (valid) {
                    //表单验证成功
                    this.addRoleInfo();
                }
                else {
                    //表单验证不成功
                }
            });
        },
        addRoleInfo(){
            this.isSubmitForm = true;
            API.roleInfo.add(this.formData)
            .then(result=>{
                ElMessage.success("添加成功");
                this.$emit("close-dialog");
            }).finally(()=>{
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