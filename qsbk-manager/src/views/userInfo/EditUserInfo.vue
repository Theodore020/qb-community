<template>
    <el-skeleton :rows="8" animated :loading="isLoading">
        <el-form label-width="120" :model="formData" :rules="formRules" ref="form" v-loading="isSubmitForm"
            element-loading-text="正在提交表单">
            <el-form-item label="账号" prop="account">
                <el-input placeholder="请输入账号" v-model="formData.account" />
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
                        <input type="file" ref="chooseFile" hidden accept="image/*" @change="fileChange($event)">
                        <el-button type="primary" @click="$refs.chooseFile.click()">选择图片</el-button>
                        <span></span>
                        <el-button type="success" @click="cropperAvatar">裁剪上传</el-button>
                    </div>
                </div>
            </el-form-item>
            <el-form-item>
                <el-button type="primary" @click="submitForm">保存数据</el-button>
                <el-button type="warning" @click="resetForm">重置表单</el-button>
            </el-form-item>
        </el-form>
    </el-skeleton>
</template>
<script>
import { validateRegExp, regConstant } from "@/utils/customValidate";
import 'vue-cropper/dist/index.css'
import { VueCropper } from "vue-cropper";
import API from '@/API';
import { ElMessage } from "element-plus";
export default {
    name: "EditUserInfo",
    emits:["close-dialog"],
    props: {
        currentEditId: {
            type: Number,
            required: true
        }
    },
    data() {
        return {
            formData: {
                account: "",
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
                img: 'https://avatars2.githubusercontent.com/u/15681693?s=460&v=4',
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
            isSubmitForm: false,
            isLoading:true
        }
    },

    created() {

        API.userInfo.findById(this.currentEditId)
            .then(result => {
                this.formData = result.data;
                this.option.img = this.baseURL + result.data.avatar;
                this.isLoading = false;
            })
    },
    methods: {
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
        },
        submitForm() {
            //提交表单之前，先做一次表单验证
            this.$refs.form.validate(valid => {
                if (valid) {
                    //表单验证成功
                    this.updateUserInfo();
                }
                else {
                    //表单验证不成功
                }
            });
        },
        updateUserInfo() {
            this.isSubmitForm = true;
            API.userInfo.update(this.formData)
                .then(result => {
                    ElMessage.success("修改成功");
                    this.$emit("close-dialog")
                }).finally(() => {
                    this.isSubmitForm = false;
                })
        },
        //重置表单
        resetForm() {
            this.$refs.form.resetFields();
        },
    },
    components: {
        VueCropper
    }
}
</script>
<style scoped></style>