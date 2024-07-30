<template>
    <page-view class="bg-gray-200">
        <div class="bg-white flex justify-between py-[20px] px-[15px] border border-b mb-[5px]">
            <div class="flex flex-col">
                <span class="font-bold text-[20px]">欢迎来到糗事百科</span>
                <div v-if="!_userInfoStore.nick_name">
                    <span class="text-[#A0A0A0] text-[13px]">马上登录跟大家一起糗</span>
                    <Button class="w-[120px] h-[40px] my-[10px] bg-primaryColor text-white font-bold"
                        type="default" @click="$router.push({ name: 'login' })">登录/注册</Button>
                </div>
                <div v-else>
                    <p>欢迎登录：{{ _userInfoStore.nick_name }}</p>
                    <div>
                        <Button class="w-[120px] h-[40px] my-[10px] bg-primaryColor text-white font-bold"
                        type="default" @click="exitLogin">退出登录</Button>
                    </div>
                </div>
            </div>
            <img v-if="!_userInfoStore.avatar" src="@/assets/img/dijia.jpg" alt="" class="w-[100px] h-[100px] ">
            <img v-else :src="BASE_URL+_userInfoStore.avatar" alt="" class="w-[100px] h-[100px] ">
        </div>
        <div class="bg-white mb-[5px]">
            <div class="p-[10px] box-border">
                <Swipe class="my-swipe box-border" indicator-color="white" loop autoplay="2000">
                    <SwipeItem><img src="../assets/img/swiper1.jpg" alt="" class="swipe-img"></SwipeItem>
                    <SwipeItem><img src="../assets/img/swiper2.jpg" alt="" class="swipe-img"></SwipeItem>
                </Swipe>
                <div class="flex justify-between items-center h-[30px] mt-[10px]">
                    <div class="text-[14px]">历史记录</div>
                    <div class="text-[#A0A0A0] text-[14px]">
                        <Icon name="arrow" />
                    </div>
                </div>
            </div>
        </div>
        <div class="bg-white mb-[5px]">
            <div class="p-[10px] box-border">
                <div class="flex justify-between items-center h-[20px] mt-[10px]">
                    <div class="text-[14px]">金币</div>
                    <div class="text-[#A0A0A0] text-[14px]">
                        <Icon name="arrow" />
                    </div>
                </div>
            </div>
        </div>
        <div class="bg-white mb-[5px]">
            <div class="p-[10px] box-border">
                <div class="flex justify-between items-center h-[20px] mt-[10px]">
                    <div class="text-[14px]">创作中心</div>
                    <div class="text-[#A0A0A0] text-[14px]">
                        <Icon name="arrow" />
                    </div>
                </div>
            </div>
            <div class="p-[10px] box-border">
                <div class="flex justify-between items-center h-[20px] mt-[10px]">
                    <div class="text-[14px]">原创特权</div>
                    <div class="text-[#A0A0A0] text-[14px]">
                        <Icon name="arrow" />
                    </div>
                </div>
            </div>
        </div>
        <div class="bg-white mb-[5px]">
            <div class="p-[10px] box-border">
                <div class="mt-[10px]">
                    <div class="text-[14px]">
                        <div>更多功能</div>
                        <div class="grid grid-cols-4 gap-5 pt-[10px]">
                            <div class="flex flex-col justify-center items-center">
                                <Icon name="location-o" />
                                <span>定位</span>
                            </div>
                            <div class="flex flex-col justify-center items-center">
                                <Icon name="like-o" />
                                <span>喜好</span>
                            </div>
                            <div class="flex flex-col justify-center items-center">
                                <Icon name="cart-o" />
                                <span>购物车</span>
                            </div>
                            <div class="flex flex-col justify-center items-center">
                                <Icon name="friends-o" />
                                <span>朋友</span>
                            </div>
                            <div class="flex flex-col justify-center items-center">
                                <Icon name="service-o" />
                                <span>客服</span>
                            </div>
                            <div class="flex flex-col justify-center items-center">
                                <Icon name="gift-o" />
                                <span>特惠</span>
                            </div>
                            <div class="flex flex-col justify-center items-center">
                                <Icon name="share-o" />
                                <span>分享</span>
                            </div>
                            <div class="flex flex-col justify-center items-center">
                                <Icon name="setting-o" />
                                <span>设置</span>
                            </div>
                            <div class="flex flex-col justify-center items-center">
                                <Icon name="scan" />
                                <span>扫码</span>
                            </div>
                            <div class="flex flex-col justify-center items-center">
                                <Icon name="paid" />
                                <span>钱包</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </page-view>
</template>

<script setup>
import { Button, Swipe, SwipeItem, Icon } from 'vant';
import userInfoStore from "@/store/userInfoStore";
import { inject } from "vue"
const _userInfoStore = userInfoStore();
const BASE_URL = inject('BASE_URL')

const exitLogin=()=>{
    _userInfoStore.removeUserInfo()
}
</script>
<style scoped>
.swipe-img {
    height: 100px;
    width: 100%;
}
</style>