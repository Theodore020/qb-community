<template>
    <PullRefresh v-model="refreshing" @refresh="onRefresh" class="h-full overflow-auto" ref="currentList">
        <List v-model:loading="isLoading"
            :finished="resultData.pageCount <= pageIndex"
            finished-text="没有更多数据了"
            @load="loadNextPage"
            class="bg-[#F4F4F4]  h-full">
            <post-item v-for="item in resultData.listData" :key="item.id" :item="item"></post-item>
            <Empty description="暂无帖子,快来发贴吧" v-if="resultData.listData.length === 0 && isLoading === false"></Empty>
        </List>
    </PullRefresh>
</template>
<script setup>
import API from "@/API";
import { defineProps, reactive, ref, onActivated, onDeactivated, onMounted } from "vue";
import PostItem from "./PostItem.vue";
import { Empty, List, PullRefresh } from 'vant';
import {onBeforeRouteLeave} from "vue-router"
import debounce from "@/utils/debounce";
const props = defineProps({
    categoryId: {
        type: Number,
        required: true
    }
});
const pageIndex = ref(1);
const resultData = reactive({
    listData: [],
    totalCount: 0,
    pageCount: 0,
});

const isLoading = ref(true);
const queryData = () => {
    isLoading.value = true;
    return API.postInfo.getListByPageForCategory({ category_id: props.categoryId, pageIndex: pageIndex.value })
        .then(result => {
            resultData.listData = result.data.listData;
            resultData.pageCount = result.data.pageCount;
            resultData.totalCount = result.data.totalCount;
            pageIndex.value = result.data.pageIndex;
            return Promise.resolve();
        }).finally(() => {
            isLoading.value = false;

        })
}

queryData();

/**
 * 加载下一页
 */
const loadNextPage = () => {
    API.postInfo.getListByPageForCategory({ category_id: props.categoryId, pageIndex: pageIndex.value + 1 })
        .then(result => {
            resultData.listData.push(...result.data.listData);
            resultData.pageCount = result.data.pageCount;
            resultData.totalCount = result.data.totalCount;
            pageIndex.value = result.data.pageIndex;
        }).finally(() => {
            isLoading.value = false;
        });
}


//下拉刷新
const refreshing = ref(false);

const onRefresh = () => {
    pageIndex.value = 1;
    queryData().then(() => {
        refreshing.value = false;
    });

}

//keep-alive以后的组件，它的生命周期是有变化的，这个activated代表的是元素被激活以后
const currentList = ref(null);
onActivated(() => {
    currentList.value.$el.scrollTop = scrollTop;
});

let scrollTop = 0;

onMounted(() => {
    currentList.value.$el.addEventListener("scroll", debounce(event => {
        scrollTop = event.target.scrollTop;
    }, 200))
})



</script>
<style scoped></style>