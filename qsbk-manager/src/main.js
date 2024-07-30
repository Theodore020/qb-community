import { createApp } from 'vue'
import App from './App.vue'
import "@/assets/css/index.css";
import router from '@/router';

//导入element-plus里面的css
import 'element-plus/dist/index.css'

// 加载element-plus的全局图标
import * as ElementPlusIconsVue from '@element-plus/icons-vue'

import store from '@/store';
import buildRouter from './utils/buildRouter';

const app = createApp(App);
for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
    app.component(key, component)
}


//定义全局混合器
app.mixin({
    data() {
        return {
            baseURL: "http://127.0.0.1:3000"
        }
    }
});

//注册一个鉴权的自定义指令
app.directive("permission-check", (el, binding, vnode) => {
    //这是后面跟的值 ，如v-permission-check="'categoryInfo:add'"
    let value = binding.value;
    //我要在我的权限里面，找有没有这个权限
    let flag = store.getters.allPermissionKeyList.includes(value);
    if (!flag) {
        //如果没有这个权限，直接把这个元素移除掉
        el.remove();
    }

})

const bootstrap = () => {
    //在启动之前，先构建一下路由
    let permissionList = store.getters.permissionList.map(item => item.children).flat(Infinity);
    buildRouter(permissionList);
    //先看一下有没有缓存
    app.use(router)
        .use(store)
        .mount("#app");
}

bootstrap();
