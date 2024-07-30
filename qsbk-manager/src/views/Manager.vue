<template>
    <el-container class="h-full">
        <el-aside width="200px" class="bg-[#304156]" :style="{ width: isCollapseMenu ? 'unset' : '200px' }">
            <left-menu></left-menu>
        </el-aside>
        <el-container>
            <el-header class="border-b border-solid border-gray-300 flex flex-row items-center" height="50px">
                <el-icon class="cursor-pointer hover:text-blue-500" @click="toggleCollapseMenu">
                    <Fold />
                </el-icon>
                <div class="flex-1">中间的部分</div>
                <div class="flex flex-row items-center">
                    <el-avatar :size="35" :src="baseURL + avatar"></el-avatar>
                    <el-dropdown trigger="click" class="ml-[10px]" @command="handleCommand">
                        <span class="el-dropdown-link">
                            欢迎登录：{{ nick_name }}
                            <el-icon class="el-icon--right">
                                <arrow-down />
                            </el-icon>
                        </span>
                        <template #dropdown>
                            <el-dropdown-menu>
                                <el-dropdown-item>我的信息</el-dropdown-item>
                                <el-dropdown-item>修改密码</el-dropdown-item>
                                <el-dropdown-item divided command="logOut">退出登录</el-dropdown-item>
                            </el-dropdown-menu>
                        </template>
                    </el-dropdown>
                </div>
            </el-header>
            <el-main class="bg-[#F5F7F9]" style="padding: 8px;">
                <router-view></router-view>
            </el-main>
        </el-container>
    </el-container>
</template>
<script>
import LeftMenu from '@/components/LeftMenu.vue';
import { mapState, mapGetters, mapActions } from "vuex";
import { ElMessageBox } from 'element-plus';
export default {
    computed: {
        ...mapGetters(["avatar", "nick_name", "isCollapseMenu"])
    },
    methods: {
        ...mapActions(["logOut", "toggleCollapseMenu"]),
        handleCommand(command) {
            if (command === "logOut") {
                ElMessageBox.confirm("确定要退出登录吗？", "提示", {
                    confirmButtonText: "确定",
                    cancelButtonText: "取消",
                    type: "warning"
                }).then(() => {
                    this.logOut();
                    this.$router.replace({
                        name: "login"
                    })
                }).catch(() => {

                });
            }
        }
    },
    components: {
        LeftMenu
    }
}
</script>
<style scoped></style>