<template>
    <div class="post-item bg-white mb-[6px] py-[10px]"
        @click="$router.push({ name: 'postDetail', params: { id: props.item.id } })">
        <!-- 用户信息 -->
        <div
            class="user-info-box flex flex-row items-center p-[10px] box-border border-0 border-b border-solid border-gray-200">
            <img v-lazy="BASE_URL + props.item.avatar" class="w-[30px] h-[30px] rounded-full" alt="">
            <span class="ml-[10px] font-bold text-[14px]">{{ props.item.nick_name }}</span>
        </div>
        <!-- 内容 -->
        <div class="post-content leading-[1.7] text-[14px] indent-[2em] box-border p-[10px]">
            <div>{{ props.item.post_content }}</div>
            <div class="img-grid-box"
                :style="{ '--grid-count': props.item.postImgList.length > 3 ? 3 : props.item.postImgList.length }">
                <img v-for="(imgItem,imgIndex) in props.item.postImgList " :key="imgItem.id" v-lazy="BASE_URL + imgItem.img_url"
                    @click.stop="previewCurrentImg(props.item.postImgList,imgIndex)">
            </div>
        </div>
        <!-- 评论 -->
        <!-- 点赞,收藏,回复,转发 -->
        <div class="flex flex-row justify-around text-[12px]" >
            <div class="flex flex-row items-center" @click.stop="setPraised">
                <Icon name="good-job" size="20px" class="mr-[5px]" v-if="item.isPraise == true" color="#FF0000" />
                <Icon name="good-job-o" size="20px" class="mr-[5px]" v-else />
                {{ props.item.praise_count }}
            </div>
            <div class="flex flex-row items-center" @click.stop="setHate">
                <Icon name="good-job-o" style="transform: rotateZ(180deg);" size="20px" class="mr-[5px]"
                    v-if="item.isHate == true" color="#E5E7EB" />
                <Icon name="good-job-o" style="transform: rotateZ(180deg);" size="20px" class="mr-[5px]" v-else />
                {{ props.item.hate_count }}
            </div>
            <div class="flex flex-row items-center">
                <Icon name="comment-o" size="20px" class="mr-[5px]" />
                {{ props.item.comment_count }}
            </div>
            <!-- <div class="flex flex-row items-center">
                <Icon name="share-o" size="20px" class="mr-[5px]" />
                18
            </div> -->
        </div>
    </div>
</template>
<script setup>
import { Icon, showToast, showImagePreview } from 'vant';
import { defineProps, inject } from "vue";
import userInfoStore from '@/store/userInfoStore';
import { useRouter,onBeforeRouteLeave } from "vue-router";
import API from '@/API';
const props = defineProps(["item"]);
const BASE_URL = inject("BASE_URL")
const _userInfoStore = userInfoStore();
const router = useRouter();
const setPraised = () => {
    if (_userInfoStore.token) {
        //登录过了
        if (props.item.isPraise != true) {
            API.postInfo.setPraised(props.item.id)
                .then(result => {
                    props.item.praise_count = result.data.praise_count;
                    props.item.isPraise = true;
                });
        }
    }
    else {
        showToast("你还没有登录，请先登录");
        router.push({
            name: "login"
        })
    }
}

const setHate = () => {
    if (_userInfoStore.token) {
        //登录过了
        if (props.item.isHate != true) {
            API.postInfo.setHate(props.item.id)
                .then(result => {
                    props.item.hate_count = result.data.hate_count;
                    props.item.isHate = true;
                });
        }
    }
    else {
        showToast("你还没有登录，请先登录");
        router.push({
            name: "login"
        })
    }
}
const previewCurrentImg = (list,imgIndex) => {
    let imgList = list.map(item => BASE_URL + item.img_url);
    showImagePreview({
        images: imgList,
        startPosition:imgIndex
    })
}


</script>
<style scoped lang="scss">
.img-grid-box {
    margin-top: 6px;
    display: grid;
    grid-template-columns: repeat(var(--grid-count), 1fr);
    grid-gap: 6px;

    img {
        widows: 100%;
        aspect-ratio: 1/1;
        object-fit: cover;
    }
}
</style>