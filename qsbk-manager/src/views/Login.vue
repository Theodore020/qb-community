<template>
    <div class="w-full h-full relative flow-root">
        <img src="../assets/img/login_bg.jpg" class="w-full h-full fixed -z-10" alt="">
        <div class="w-[900px] bg-white h-[280-px] overflow-hidden rounded-[5px] mx-auto mt-[100px] flex flex-row">
            <div class="flex-1">
                <div class="flex flex-row items-center justify-center py-[20px]">
                    <el-icon size="36" class="mr-[10px] is-loading">
                        <Loading />
                    </el-icon>
                    <h2 class="text-[22px]">糗事百科后台管理</h2>
                </div>
                <!-- 表单 -->
                <el-form class="box-border px-[30px]" ref="form" :model="formData" :rules="formRules">
                    <el-form-item prop="account">
                        <el-input placeholder="请输入账号" v-model="formData.account" autocomplete="false" />
                    </el-form-item>
                    <el-form-item prop="password">
                        <el-input placeholder="请输入账号" v-model="formData.password" show-password autocomplete="false" />
                    </el-form-item>
                    <el-form-item>
                        <el-button type="primary" class="w-full" @click="submitForm" :loading="isSubmit">登录</el-button>
                    </el-form-item>
                    <el-form-item>
                        <el-button type="primary" class="w-full" @click="registerForm">注册</el-button>
                    </el-form-item>
                </el-form>
            </div>
            <div class="flex-1">
                <img src="../assets/img/login2.jpg" class="w-full h-full" alt="">
            </div>
        </div>
        <p class="text-gray-100 text-[14px] text-center fixed bottom-[20px] w-full">Theodore的版权所有@copy 2022-2023</p>
    </div>
</template>
<script>
import { ElMessage, ElNotification } from 'element-plus'
import API from '@/API';
import { mapActions } from "vuex";
import buildRouter from "@/utils/buildRouter";
export default {
    name: "Login",
    data() {
        return {
            formData: {
                account: "",
                password: ""
            },
            formRules: {
                account: [
                    { required: true, message: "请输入账号", trigger: "blur" },
                ],
                password: [
                    { required: true, message: "请输入密码", trigger: "blur" },
                ]
            },
            isSubmit: false,
            isRegister: false
        }
    },
    methods: {
        ...mapActions(["setUserInfo"]),
        submitForm() {
            this.$refs.form.validate(valid => {
                if (valid) {
                    this.checkLogin();
                }
                else {
                    ElMessage.error("请检查表单填写是否正确")
                }
            })
        },
        registerForm() {
            this.$router.replace({
                name: "register"
            })
        },
        checkLogin() {
            this.isSubmit = true;
            API.userInfo.checkLogin(this.formData)
                .then(result => {
                    // 旧方法
                    // this.$store.dispatch("setUserInfo", result.data);
                    this.setUserInfo(result.data);
                    ElNotification.success({
                        title: "登录成功",
                        message: "欢迎回来",
                        type: "success"
                    });

                    //先把你的路由生成了，如果没有路由，你是进不去的
                    let pagePermissionList = result.data.permissionList.map(item => item.children).flat(Infinity);
                    this.$router.replace({
                        name: "manager"
                    })
                    //接下来，动态添加路由
                    buildRouter(pagePermissionList);


                }).catch(error => {
                    ElMessage.error(error.msg);
                }).finally(() => {
                    this.isSubmit = false;
                });
        }
    }
}
</script>
<style scoped></style>