import { createApp } from 'vue'
import App from './App.vue'
import "vant/lib/index.css"
import "@/assets/css/index.css"
import "animate.css"
import router from '@/router'
import { createPinia } from "pinia";
//pinia的持久化插件
import PiniaPluginPersistedState from "pinia-plugin-persistedstate"
const pinia = createPinia();
//加载持久化插件
pinia.use(PiniaPluginPersistedState);
const app = createApp(App);

import PageView from "@/components/PageView";
app.component("page-view", PageView);

import { Lazyload } from "vant"

app.use(pinia).use(router).use(Lazyload,{
    lazyComponent:true
}).mount('#app');
