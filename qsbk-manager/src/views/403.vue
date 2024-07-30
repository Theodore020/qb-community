<template>
    <el-result
        icon="error"
        title="无权限"
        sub-title="你当前无权限进入此页面，请返回">
        <template #extra>
            <el-button type="primary" @click="$router.back()">返回</el-button>
        </template>
    </el-result>
</template>
<script>
export default {

}
</script>
<style scoped></style>