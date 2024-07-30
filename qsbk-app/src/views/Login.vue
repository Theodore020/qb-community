<template>
    <page-view class="flex flex-col">
        <NavBar title="登录" left-arrow @click="$router.back()"></NavBar>
        <div class="flex-1 overflow-auto">
            <h2 class="ml-[20px]">密码登录</h2>
            <Form ref="loginForm">
                <CellGroup inset>
                    <Field
                        label="账号"
                        placeholder="请输入账号"
                        v-model="formData.account"
                        :rules="[{ required: true, message: '请输入账号' }]"></Field>
                    <div class="flex flex-row items-center">
                        <Field
                            label="密码"
                            placeholder="请输入密码"
                            type="password"
                            v-model="formData.password"
                            :rules="[{ required: true, message: '请输入密码' }]"></Field>
                        <a href="#" class="text-[12px] w-[100px] text-[#607DA0]">忘记密码</a>
                    </div>
                </CellGroup>
            </Form>
        </div>
        <div>
            <div class="text-[12px] flex flex-row justify-center">
                <Checkbox icon-size="14" v-model="isAgree">
                    已阅读并同意
                    <a href="#" class="text-[12px] w-[100px] text-[#607DA0]">糗事百科用户协议</a>
                    和
                    <a href="#" class="text-[12px] w-[100px] text-[#607DA0]">隐私政策</a>
                </Checkbox>
            </div>
            <Button @click="checkLogin" :disabled="!isAgree" type="primary" class="w-full mt-[12px] text-black">登录</Button>
        </div>
    </page-view>
</template>
<script setup>
import { NavBar, Form, Field, CellGroup, Checkbox, Button, showNotify, showToast } from "vant";
import { reactive, ref } from "vue";
import API from "@/API";
import userInfoStore from "@/store/userInfoStore";
import { useRouter } from "vue-router";

//得到路由管理对象
const router = useRouter();

const _userInfoStore = userInfoStore();
const formData = reactive({
    account: "",
    password: ""
})
const isAgree = ref(false);


const loginForm = ref(null);
const checkLogin = () => {
    //第一步：表单验证
    loginForm.value.validate()
        .then(() => {
            API.userInfo.checkLogin(formData)
                .then(result => {
                    showToast({ type: "success", message: "登录成功" });
                    // 登录的状态要全局控控制
                    _userInfoStore.setUserInfo(result.data);
                    router.replace({
                        name: "listPage"
                    })
                })

        })
        .catch(() => {
            showNotify({ type: "warning", message: "表单验证失败" })
        })
}
</script>
<style scoped></style>