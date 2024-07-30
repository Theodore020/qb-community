import { defineStore } from "pinia";
import WebStorageCache from "web-storage-cache";
const cache = new WebStorageCache({
    storage: window.localStorage,
    exp: 1 * 60 * 60 * 24
})


const userInfoStore = defineStore("userInfoStore", {
    state() {
        return {
            userInfo: {}
        }
    },
    actions: {
        setUserInfo(userInfo) {
            this.userInfo = userInfo;
        },
        removeUserInfo() {
            this.userInfo = {};
        }
    },
    getters: {
        // getters里面的函数会自动的注入一个参数叫state,也就是我们的状态
        nick_name(state) {
            return state.userInfo.nick_name || "";
        },
        avatar(state) {
            return state.userInfo.avatar || "";
        },
        token(state){
            return state.userInfo.token || "";
        }
    },
    // 持久化，如果想让这个属性产生使用，必须要加载第三方的持久化插件，我们刚刚在main.js里面已经加载了
    persist: {
        key: "userInfoStore",
        storage: {
            getItem(key) {
                return cache.get(key);
            },
            setItem(key, value) {
                return cache.set(key, value);
            },
            removeItem(key) {
                return cache.delete(key);
            },
            clear() {
                return cache.clear();
            }
        }
    }
});


export default userInfoStore;