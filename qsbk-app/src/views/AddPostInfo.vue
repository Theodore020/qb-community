<template>
    <page-view class="flex flex-col">
        <NavBar title="发贴啦"></NavBar>
        <Skeleton :loading="isLoading" :row="4">
            <div class="flex-1 overflow-auto">
                <div class="box-border p-[8px]">
                    <textarea v-model="post_content"
                        class="w-full border-none bg-gray-100 h-[150px] resize-none box-border p-[8px]"></textarea>
                </div>
                <Field
                    v-model="choosedCategory.text"
                    label="帖子类别"
                    is-link
                    placeholder="点击选择帖子类别"
                    readonly @click="isShowPicker = true">
                </Field>
                <Popup v-model:show="isShowPicker" round position="bottom">
                    <Picker
                        :columns="allCategoryInfoList"
                        @cancel="isShowPicker = false"
                        @confirm="onChooseCateogry">
                    </Picker>
                </Popup>
                <div class="box-border p-[8px]">
                    <Uploader v-model="postImgList" multiple :max-count="9"></Uploader>
                </div>
            </div>
            <Button
                :disabled="!isFormValidate"
                :loading="isLoading"
                loading-text="正在提交"
                class=" bg-primaryColor text-white"
                @click="submitPostInfo">发贴</Button>
        </Skeleton>
    </page-view>
</template>
<script setup>
import API from "@/API";
import { NavBar, Field, Popup, Picker, Skeleton, Uploader, Button,showToast } from "vant";
import { reactive, ref, computed,defineEmits } from "vue";

const emit = defineEmits(["close-popup"]);

//变量，帖子的内容
const post_content = ref("");

const allCategoryInfoList = ref([]);
const isLoading = ref(false);
const initData = () => {
    isLoading.value = true;
    API.categoryInfo.getAllList()
        .then(result => {
            allCategoryInfoList.value = result.data.map(item => {
                return {
                    text: item.category_name,
                    value: item.id
                }
            })
        }).finally(() => {
            isLoading.value = false;
        })
}
initData();



const isShowPicker = ref(false);
const choosedCategory = reactive({
    text: "",
    value: ""
})

/**
 * 选择某一个分类以后
 */
const onChooseCateogry = ({ selectedOptions }) => {
    isShowPicker.value = false;
    choosedCategory.text = selectedOptions[0].text;
    choosedCategory.value = selectedOptions[0].value;
}


//已经上传的图片列表
const postImgList = ref([]);

/**
 * 提交帖子的信息
 */
const isSubmit = ref(false);
/**
 * 通过计算属性，手动的实现表单验证的功能
 */
const isFormValidate = computed(() => {
    if (!post_content.value) {
        return false;
    }
    if (!choosedCategory.value) {
        return false;
    }
    return true;
});
const submitPostInfo = () => {
    isSubmit.value = true;
    //现在开始构建数据,还要把图片弄过去
    let formData = new FormData();
    formData.append("post_content",post_content.value);
    formData.append("category_id",choosedCategory.value);
    postImgList.value.forEach(item=>{
        formData.append("post_img",item.file);
    });
    //现在只需要把formData提交 到后端接口就可以了
    API.postInfo.add(formData)
    .then(result=>{
        showToast({type:"success",message:"发贴成功"});
        emit("close-popup");
    })
}

</script>
<style scoped></style>