import { createRouter, createWebHashHistory } from "vue-router";
import Login from "@/views/Login";
import Manager from "@/views/Manager";
import store from "@/store";
import Register from "@/views/Register";

const router = createRouter({
    history: createWebHashHistory(),
    routes: [
        {
            path: "/",
            redirect: {
                name: "login"
            }
        },
        {
            path: "/login",
            name: "login",
            component: Login,
            meta: {
                title: "登录"
            }
        },
        {
            path: "/register",
            name: "register",
            component: Register,
            meta: {
                title: "注册"
            }
        },
        {
            path: "/manager",
            name: "manager",
            component: Manager,
            meta: {
                title: "后台管理"
            },
            children: [
                {
                    path: "403",
                    name: "403",
                    component: () => import("@/views/403"),
                }
            ]
        }
    ]
});




//跳转路由之前
router.beforeEach((to, from, next) => {
    // from从哪来
    // to到哪去
    // next放行
    if (to.matched.length === 0) {
        next({
            name: "403"
        })
    }
    else {
        if (to.name === "login") {
            next();
        }
        else if (to.name === "register") {
            next();
        }
        else {
            //你去的不是登录页面,那我就要看一下,你有没有token
            let token = store.getters.token;
            if (token) {
                next();
            }
            else {
                next({
                    name: "login"
                })
            }
        }
    }

});

//进入路由之后
router.afterEach((to, from) => {
    let title = to.meta.title;
    if (title) {
        document.title = "糗事百科后台管理-" + title;
    }
    else {
        document.title = "糗事百科后台管理"
    }
});


export default router;