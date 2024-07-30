<template>
    <div class="w-full h-full relative flow-root">
        <img src="../assets/img/login_bg.jpg" class="w-full h-full fixed -z-10" alt="">
        <div class="w-[900px] bg-white  overflow-hidden rounded-[5px] mx-auto mt-[100px] flex flex-row">
            <div class="flex-1">
                <div class="flex flex-row items-center justify-center py-[10px]">
                    <el-icon size="36" class="mr-[10px] is-loading">
                        <Loading />
                    </el-icon>
                    <h2 class="text-[22px]">糗事百科后台管理--注册</h2>
                </div>
                <!-- 表单 -->
                <el-form class="box-border px-[30px]" ref="form" :model="formData" :rules="formRules"
                    element-loading-text="正在提交表单" v-loading="isSubmitForm" label-width="120">
                    <el-form-item label="账号" prop="account">
                        <el-input placeholder="请输入账号" v-model="formData.account" />
                    </el-form-item>
                    <el-form-item label="密码" prop="password">
                        <el-input placeholder="请输入密码" show-password v-model="formData.password" />
                    </el-form-item>
                    <el-form-item label="确认密码" prop="confirmPassword">
                        <el-input placeholder="请输入确认密码" show-password v-model="formData.confirmPassword" />
                    </el-form-item>
                    <el-form-item label="昵称" prop="nick_name">
                        <el-input placeholder="请输入昵称" v-model="formData.nick_name" />
                    </el-form-item>
                    <el-form-item label="手机号" prop="telephone">
                        <el-input placeholder="请输入手机号" v-model="formData.telephone" />
                    </el-form-item>
                    <el-form-item label="邮箱" prop="email">
                        <el-input placeholder="请输入邮箱" v-model="formData.email" />
                    </el-form-item>
                    <el-form-item label="头像" prop="avatar" v-loading="isUploadAvatar" element-loading-text="正在上传图片...">
                        <div class="flex flex-row">
                            <div class="w-[200px] h-[200px] border border-gray-300 border-dotted">
                                <vue-cropper ref="cropper"
                                    :img="option.img"
                                    :output-size="option.size"
                                    :output-type="option.outputType"
                                    :info="true"
                                    :full="option.full"
                                    :can-move="option.canMove"
                                    :can-move-box="option.canMoveBox"
                                    :fixed-box="option.fixedBox"
                                    :original="option.original"
                                    :auto-crop="option.autoCrop"
                                    :auto-crop-width="option.autoCropWidth"
                                    :auto-crop-height="option.autoCropHeight"
                                    :center-box="option.centerBox"
                                    :high="option.high"
                                    mode="contain"
                                    :max-img-size="option.max"></vue-cropper>
                            </div>
                            <div class="flex flex-col items-center justify-evenly ml-[20px]">
                                <input type="file" ref="chooseFile" hidden accept="image/*"
                                    @change="fileChange($event)">
                                <el-button type="primary" @click="$refs.chooseFile.click()">选择图片</el-button>
                                <span></span>
                                <el-button type="success" @click="cropperAvatar">裁剪上传</el-button>
                            </div>
                        </div>
                    </el-form-item>
                    <el-form-item>
                        <el-button type="primary" @click="submitForm">保存数据</el-button>
                        <el-button type="warning" @click="resetForm">重置表单</el-button>
                        <el-button type="success" @click="returnLogin">返回登录</el-button>
                    </el-form-item>
                </el-form>
            </div>
        </div>
        <p class="text-gray-100 text-[14px] text-center fixed bottom-[20px] w-full">Theodore的版权所有@copy 2022-2023</p>
    </div>
</template>
<script>
import { validateRegExp, regConstant } from "@/utils/customValidate";
import 'vue-cropper/dist/index.css'
import { VueCropper } from "vue-cropper";
import API from '@/API';
import { ElMessage } from "element-plus";


export default {
    name: "Register",
    data() {
        return {
            formData: {
                account: "",
                password: "",
                confirmPassword: "",
                nick_name: "",
                telephone: "",
                email: "",
                avatar: ""
            },
            //表单验证的规则 
            formRules: {
                account: [
                    { required: true, message: "请输入账号", trigger: "blur" }
                ],
                password: [
                    { required: true, message: "请输入密码", trigger: "blur" }
                ],
                confirmPassword: [
                    { required: true, message: "请再次输入密码", trigger: "blur" },
                    // validator自定义验证方法
                    { validator: this.checkConfirmPassword, trigger: "blur" }
                ],
                nick_name: [
                    { required: true, message: "请输入昵称", trigger: "blur" }
                ],
                email: [
                    { required: true, message: "请输入邮箱", trigger: "blur" },
                    { validator: validateRegExp(regConstant.email), trigger: "blur" }
                ],
                telephone: [
                    { required: true, message: "请输入手机号", trigger: "blur" },
                    { validator: validateRegExp(regConstant.phone), trigger: "blur" }
                ],
                avatar: [
                    { required: true, message: "请上传头像", trigger: "change" }
                ]
            },
            option: {
                img: new URL("@/assets/img/dijia.jpg", import.meta.url).href,
                size: 1,
                full: false,
                outputType: 'png',
                canMove: true,
                fixedBox: false,
                original: false,
                canMoveBox: true,
                autoCrop: true,
                // 只有自动截图开启 宽度高度才生效
                autoCropWidth: 750,
                autoCropHeight: 340,
                centerBox: true,
                high: true,
                max: 99999,
            },
            isUploadAvatar: false,
            isSubmitForm: false
        }
    },
    methods: {
        checkConfirmPassword(rules, value, callback) {
            if (value === "") {
                callback(new Error("请再次输入密码"));
            }
            else if (value != this.formData.password) {
                callback(new Error("两次输入密码不一致"));
            }
            else {
                callback();
            }
        },
        submitForm() {
            //提交表单之前，先做一次表单验证
            this.$refs.form.validate(valid => {
                if (valid) {
                    //表单验证成功
                    this.register();
                }
                else {
                    //表单验证不成功
                }
            });
        },
        register() {
            this.isSubmitForm = true;
            API.userInfo.register(this.formData)
                .then(result => {
                    ElMessage.success("注册成功");
                    //注册成功后，跳转到登录页面
                    this.$router.replace({
                        name:"login"
                    });
                }).catch((result)=>{
                    ElNotification.error({
                        title: "注册失败",
                        message: result.response.data.msg,
                        type: "danger"
                    });
                })
                .finally(() => {
                    this.isSubmitForm = false;
                })
        },
        //重置表单
        resetForm() {
            this.$refs.form.resetFields();
        },
        fileChange(event) {
            let file = event.currentTarget.files[0];
            if (file) {
                let reg = /^image/;
                if (reg.test(file.type)) {
                    //是图片
                    this.option.img = URL.createObjectURL(file);
                }
            }
        },
        returnLogin(){
            this.$router.replace({
                name:"login"
            });
        },
        //裁剪上传图片
        cropperAvatar() {
            //第一步：获取裁剪的图片
            this.$refs.cropper.getCropData(data => {
                this.isUploadAvatar = true;
                //上传这个base64的图片
                API.userInfo.uploadAvatar(data).then(result => {
                    this.formData.avatar = result.data;
                    ElMessage.success("头像上传成功");

                }).finally(() => {
                    this.isUploadAvatar = false;
                });
            });
        }
    },
    components: {
        VueCropper
    }
}
</script>
<style scoped></style>