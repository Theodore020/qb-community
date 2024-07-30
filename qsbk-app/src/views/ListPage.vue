<template>
    <page-view class="flex flex-col">
        <Tabs class="h-[45px]" v-model:active="tabActive">
            <Tab v-for="(item) in allCategoryInfoList" :key="item.id" :title="item.category_name"></Tab>
        </Tabs>
        <div class="flex-1 overflow-auto">
            <template v-for="(item, index) in allCategoryInfoList" :key="item.id">
                <keep-alive>
                    <post-list v-if="tabActive === index" :category-id="item.id"></post-list>
                </keep-alive>

            </template>
        </div>
    </page-view>
</template>
<script setup>
import { Tab, Tabs, Icon } from 'vant';
import { reactive, ref, watch, onActivated, onDeactivated } from "vue";
import PostList from '@/components/PostList';
import API from "@/API";
const tabActive = ref(-1);
const pageIndex = ref(1);
watch(tabActive, (newValue, oldValue) => {

});

onActivated(() => {

})


const allCategoryInfoList = ref([]);
const getAllCategoryInfoList = () => {
    API.categoryInfo.getAllList()
        .then(result => {
            allCategoryInfoList.value = result.data;
            tabActive.value = 0;
        })
}
getAllCategoryInfoList();







</script>
<style scoped lang="scss">
:deep(.van-tab--active) {
    .van-tab__text {
        @apply text-primaryColor text-[16px];
    }
}


:deep(.van-tabs__nav) {
    .van-tabs__line {
        @apply bg-primaryColor;
    }

}
</style>