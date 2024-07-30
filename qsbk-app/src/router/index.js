import { createRouter, createWebHashHistory } from "vue-router";
import Home from "@/views/Home";
import ListPage from "@/views/ListPage";
import Message from "@/views/Message";
import FriendMoment from "@/views/FriendMoment";
import My from "@/views/My";

const router = createRouter({
    history: createWebHashHistory(),
    routes: [
        {
            path: "/",
            redirect: {
                name: "listPage"
            }

        },
        {
            path: "/home",
            name: "home",
            component: Home,
            children: [
                {
                    path: "listPage",
                    name: "listPage",
                    component: ListPage
                }, {
                    path: "message",
                    name: "message",
                    component: Message
                }, {
                    path: "friendMoment",
                    name: "friendMoment",
                    component: FriendMoment
                }, {
                    path: "my",
                    name: "my",
                    component: My
                }
            ]
        },
        {
            path:"/login",
            name:"login",
            component:()=>import("@/views/Login")
        },
        {
            path:"/postDetail/:id",
            name:"postDetail",
            component:()=>import("@/views/PostDetail")
        }
    ]
});

export default router;
