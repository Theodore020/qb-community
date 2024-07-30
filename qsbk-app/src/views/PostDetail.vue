<template>
    <page-view class="flex flex-col">
        <NavBar title="帖子详细" left-arrow @click-left="$router.back()">
            <template #right>
                <Icon name="weapp-nav" size="18" />
            </template>
        </NavBar>
        <Skeleton title avatar :row="3" :loading="isLoading">
            <div class="flex-1 overflow-auto bg-[#F9F9F9]">
                <div ref="contentBox">
                    <!-- 帖子信息 -->
                    <div class="box-border p-[10px] bg-white">
                        <div class="user-info-box flex flex-row box-border">
                            <img :src="BASE_URL + postDetail.userInfo.avatar" class="w-[35px] h-[35px] rounded-full" />
                            <div class="text-[12px] ml-[10px]">
                                <div class="font-bold">{{ postDetail.userInfo.nick_name }}</div>
                                <div class="mt-[4px] text-gray-500">
                                    <span>{{ formatDateTime(postDetail.create_at) }}</span>
                                    <span class="ml-[10px]">1.6万次阅读</span>
                                </div>
                            </div>
                        </div>
                        <div class="post-content">
                            <p class="leading-[1.7] text-[14px]">
                                {{ postDetail.post_content }}
                            </p>
                            <img v-for="item in postDetail.postImgList" :key="item.id"
                                v-lazy="BASE_URL + item.img_url" class="max-w-full mt-[4px]">
                        </div>
                    </div>

                    <!-- 帖子评论 -->
                    <div class="bg-white mt-[10px]">
                        <div
                            class="font-bold h-[45px] flex flex-row items-center px-[10px] box-border border-0 border-b border-solid border-gray-200">
                            评论</div>
                        <!-- 每一个回复 -->
                        <div class="flex flex-row box-border p-[10px] border-b border-dotted border-gray-300 border-0"
                            v-for="item in commentInfoResultData.listData" :key="item.id">
                            <img crossorigin="anonymous" :src="BASE_URL + item.avatar"
                                class="w-[35px] h-[35px] rounded-full"
                                alt="">
                            <div class="flex-1 ml-[10px]">
                                <div class="h-[35px] flex flex-row items-center text-[14px]">
                                    <span class="font-bold text-gray-600">{{ item.nick_name }}</span>
                                    <span class="text-gray-400 ml-[4px]">{{ formatDateTime(item.create_at) }}</span>
                                </div>
                                <div class="text-[14px] leading-[1.7]">
                                    {{ item.comment_text }}
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="flex flex-row justify-center py-[10px] bg-gray-100 text-[12px]"
                        v-if="pageIndex < commentInfoResultData.pageCount"
                        @click="getNextPageComment">加载下一页
                    </div>
                </div>
            </div>
            <div class="h-[40px] py-[5px] px-[10px] border-t border-solid border-gray-300 border-0 flex flex-row">
                <div class="w-[180px] h-full bg-[#F4F4F4] flex flex-row items-center px-[5px] box-border rounded-[6px]">
                    <input @keydown.enter="sendComment" v-model="comment_text" type="text" placeholder="说点什么"
                        class="text-[14px] w-full h-full border-none bg-transparent">
                    <Icon name="smile-o" size="22" @click.stop="isShowEmojiPopup = !isShowEmojiPopup"></Icon>
                </div>
                <div class="flex flex-row justify-around flex-1">
                    <div class="flex flex-col items-center justify-evenly">
                        <Icon name="good-job-o" size="22px"></Icon>
                        <span class="text-[12px]">10</span>
                    </div>
                    <div class="flex flex-col items-center justify-evenly">
                        <Icon name="comment-o" size="22px"></Icon>
                        <span class="text-[12px]">13</span>
                    </div>
                    <div class="flex flex-col items-center justify-evenly">
                        <Icon name="star-o" size="22px"> </Icon>
                        <span class="text-[12px]">10</span>
                    </div>
                    <div class="flex flex-col items-center justify-evenly " @click="isShowShare = true">
                        <Icon name="share-o" size="22px"></Icon>
                        <span class="text-[12px]">分享</span>
                    </div>

                </div>
            </div>
        </Skeleton>
        <transition enter-active-class="animate__animated animate__fadeInUp"
            leave-active-class="animate__animated animate__fadeOutDown"
            :duration="300">
            <Emoji @choose="chooseEmoji" v-if="isShowEmojiPopup"></Emoji>
        </transition>
    </page-view>
    <ShareSheet v-model:show="isShowShare"
        title="立即分享给好友"
        :options="shareOption"
        @select="onShareSelect"></ShareSheet>
</template>
<script setup>
import API from "@/API";
import {
    NavBar, Icon, Skeleton, showLoadingToast, closeToast, showNotify,
    ShareSheet, showSuccessToast, showImagePreview, showConfirmDialog, Popup
} from "vant";
import { ref, inject, reactive } from "vue";
import { useRoute } from "vue-router";
import formatDateTime from "@/utils/formatDateTime";
import useClipboard from 'vue-clipboard3';
import QRCode from "qrcode";
import html2canvas from "html2canvas";
import Emoji from "@/components/Emoji.vue";
const { toClipboard } = useClipboard();
const route = useRoute();
const BASE_URL = inject("BASE_URL");
//得到路由单体对象,就可以得到参数
const isLoading = ref(false);
const postDetail = ref(null);
//获取帖子信息的方法
const getPostDetail = () => {
    return API.postInfo.findById(route.params.id)
        .then(result => {
            console.log(result.data);
            postDetail.value = result.data;
            return Promise.resolve();
        })
}
const pageIndex = ref(1);
const commentInfoResultData = reactive({
    pageCount: 0,
    totalCount: 0,
    listData: []
})
//获取当前帖子评论的方法
const getCommentInfoList = () => {
    return API.commentInfo.getListByPage({
        post_id: route.params.id,
        pageIndex: pageIndex.value
    }).then(result => {
        commentInfoResultData.pageCount = result.data.pageCount;
        commentInfoResultData.totalCount = result.data.totalCount;
        commentInfoResultData.listData = result.data.listData;
        return Promise.resolve();
    })
}

//初始化请求
const initData = () => {
    isLoading.value = true;
    Promise.all([getPostDetail(), getCommentInfoList()])
        .then(result => {
            isLoading.value = false;
        })
}

//获取下一页的评论
const getNextPageComment = () => {
    showLoadingToast({
        type: "loading",
        message: "正在加载下一页评论",
        forbidClick: true
    })
    API.commentInfo.getListByPage({
        post_id: route.params.id,
        pageIndex: pageIndex.value + 1
    }).then(result => {
        commentInfoResultData.pageCount = result.data.pageCount;
        commentInfoResultData.totalCount = result.data.totalCount;
        commentInfoResultData.listData.push(...result.data.listData);
        pageIndex.value = result.data.pageIndex;
    }).finally(() => {
        closeToast(true);
    })
}
initData();

const comment_text = ref("");
const sendComment = () => {
    //第一步：检查有没有输入内容
    if (comment_text.value.trim().length === 0) {
        showToast({
            type: "fail",
            message: "请输入内容"
        });
    }
    else {
        showLoadingToast({
            type: "loading",
            message: "正在发送评论",
            forbidClick: true
        })
        API.commentInfo.add({
            post_id: route.params.id,
            comment_text: comment_text.value
        }).then(() => {
            showNotify({
                type: "success",
                message: "评论成功"
            });
            pageIndex.value = 1;
            getCommentInfoList();
            comment_text.value = "";
        }).finally(() => {
            closeToast(true);
        })
    }
}

const isShowShare = ref(false);
const shareOption = [
    { name: '微信', icon: 'wechat' },
    { name: '复制链接', icon: 'link' },
    { name: '分享海报', icon: 'poster' },
    { name: '二维码', icon: 'qrcode' },
]
const contentBox = ref(null);
const onShareSelect = option => {
    isShowShare.value = false;
    if (option.name === "微信") {

    }
    else if (option.name === "复制链接") {
        let str = `我发现了一个非常好看的帖子，现在分享给你看一下，快打开后面的连接 ${location.href}`;
        toClipboard(str).then(() => {
            showSuccessToast("链接已复制，快去发给你的小伙伴吧");
        })
    }
    else if (option.name === "分享海报") {
        let audio = document.createElement("audio");
        audio.src = new URL("../assets/audio/camera.mp3", import.meta.url).href;
        audio.play();
        //通过html2canvas来实现网页截屏
        html2canvas(contentBox.value, {
            useCORS: true,
            scale: 1
        }).then(canvas => {
            //这里已经得到了canvas
            let ctx = canvas.getContext("2d");
            ctx.save();
            ctx.translate(canvas.width / 2, 300);
            ctx.rotate(-Math.PI * 2 / 8);
            ctx.textAlign = "center";
            ctx.fillStyle = "#f7504d";
            ctx.font = "56px 微软雅黑";
            ctx.fillText("H2302·糗事百科", 0, 0);
            ctx.restore();

            showImagePreview({
                className: "animate__animated  animate__fadeInDown",
                images: [canvas.toDataURL("image/png")],
                onClose() {
                    showConfirmDialog({
                        title: "请确定",
                        message: "您要保存这个分享的二维码吗？"
                    }).then(() => {
                        let a = document.createElement("a");
                        a.href = canvas.toDataURL("image/png");
                        a.download = "帖子分享.png";
                        a.click();
                    }).catch(() => {
                    })
                }
            })
        })
    }
    else if (option.name === "二维码") {
        QRCode.toDataURL(location.href, {}, (error, url) => {
            if (error) {
            }
            else {
                //这个时候得到的url是一个base64
                showImagePreview({
                    images: [url],
                    onClose() {
                        showConfirmDialog({
                            title: "请确定",
                            message: "您要保存这个分享的二维码吗？"
                        }).then(() => {
                            let a = document.createElement("a");
                            a.href = url;
                            a.download = "二维码.png";
                            a.click();
                        }).catch(() => {
                        })
                    }
                });
            }
        })
    }

}
// 是否显示表包情
const isShowEmojiPopup = ref(false);

const chooseEmoji = (emoji) => {
    comment_text.value += emoji;
}
</script>
<style scoped></style>