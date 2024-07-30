<template>
    <router-view #default="{ Component }">
        <keep-alive include="Home">
            <component :is="Component" ></component>
        </keep-alive>
    </router-view>
</template>

<script setup>
import { provide } from "vue"
provide("BASE_URL", "http://127.0.0.1:3000")
</script>
<style scoped></style>