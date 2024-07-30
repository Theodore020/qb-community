<template>
    <page-view class="flex flex-col">
        <div class="flex-1 overflow-auto">
            <router-view #default="{Component}">
                <keep-alive>
                    <component :is="Component"></component>
                </keep-alive>
            </router-view>
        </div>
        <Tabbar class="static tab-bar-shadow" route>
            <Tabbar-item icon="home-o" :to="$router.resolve({ name: 'listPage' }).path">主页</Tabbar-item>
            <Tabbar-item icon="friends-o" :to="$router.resolve({ name: 'friendMoment' }).path">朋友圈</Tabbar-item>
            <Tabbar-item class="tab-bar-item" @click="addNewPostItem">
                <template #icon >
                    <div class="bg-[#FE6479] px-[8px] py-[5px] rounded-[5px] text-white">
                        <Icon name="plus" />
                    </div>

                </template>
            </Tabbar-item>
            <Tabbar-item icon="chat-o" :to="$router.resolve({ name: 'message' }).path">消息</Tabbar-item>
            <Tabbar-item icon="contact-o" :to="$router.resolve({ name: 'my' }).path">我的</Tabbar-item>
        </Tabbar>


    </page-view>
    <Popup
        v-model:show="isShowPopup"
        position="bottom"
        style="height:90%"
        round
        closeable>
        <add-post-info v-if="isShowPopup" @close-popup="isShowPopup=false"></add-post-info>
    </Popup>
</template>

<script setup>
import { Tabbar, TabbarItem, Icon,showToast, Popup  } from 'vant';
import userInfoStore from '@/store/userInfoStore';
import { useRouter } from "vue-router";
import { ref } from 'vue';
import AddPostInfo from './AddPostInfo.vue';
const router = useRouter();
const _userInfoStore = userInfoStore();
const isShowPopup = ref(false);
const addNewPostItem = () => {
    //第一步：判断当前的用户有没有登录
    if (_userInfoStore.token) {
        isShowPopup.value = true;
    }
    else {
        showToast({
            type: "fail",
            message: "你还没有登录，请登录"
        });

        router.push({
            name: "login"
        });
    }
}
</script>
<script>
export default{
    name:"Home"
}
</script>
<style scoped lang="scss">
.tab-bar-item {
    :deep(.van-tabbar-item__icon) {
        margin-bottom: 0;
    }
}

.tab-bar-shadow {
    box-shadow: 0 -5px 15px lightgray;
}
</style>