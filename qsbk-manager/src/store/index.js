import {createStore} from "vuex";
// 引入插件
import createPersistedState from "vuex-persistedstate";
import WebStorageCache from "web-storage-cache";

let wsCache = new WebStorageCache({
    storage: window.localStorage,
    exp: 1 * 60 * 60 * 24
});


const store = createStore({
    state: {
        userInfo: {},
        isCollapseMenu:false
    },
    mutations: {
        setUserInfo(state, userInfo) {
            state.userInfo = userInfo;
        },
        toggleCollapseMenu(state){
            state.isCollapseMenu = !state.isCollapseMenu;
        }
    },
    actions: {
        setUserInfo({commit}, userInfo) {
            commit("setUserInfo", userInfo);
        },
        logOut({commit}) {
            commit("setUserInfo", {});
        },
        toggleCollapseMenu({commit}){
            commit("toggleCollapseMenu")
        }
    },
    getters: {
        token(state) {
            return state.userInfo.token || "";
        },
        nick_name(state) {
            return state.userInfo.nick_name;
        },
        avatar(state) {
            return state.userInfo.avatar || "";
        },
        permissionList(state) {
            return state.userInfo.permissionList || [];
        },
        allPermissionKeyList: (state) => {
            let result = [];
            //你给我一个数组，我帮你遍历，返回permission_key的集合
            const eachPermissioniKey = list => {
                let arr = [];
                list.forEach(item => {
                    arr.push(item.permission_key);
                    if (item.children && Array.isArray(item.children)) {
                        arr.push(...eachPermissioniKey(item.children));
                    }
                })
                return arr;
            };
            if (state.userInfo) {
                let arr = eachPermissioniKey(state.userInfo.permissionList);
                return arr;
            } else {
                return [];
            }
        },
        isCollapseMenu(state){
            return state.isCollapseMenu
        }
    },
    plugins: [
        createPersistedState({
            storage: {
                getItem(key) {
                    return wsCache.get(key);
                },
                setItem(key, value) {
                    return wsCache.set(key, value);
                },
                removeItem(key) {
                    return wsCache.delete(key)
                }
            }
        })
    ]
});

export default store;