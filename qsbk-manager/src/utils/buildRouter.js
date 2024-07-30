import router from "@/router";
const buildRouter = (pagePermissionList) => {
    const routerModules = import.meta.glob("../views/**/*.vue");
    for (let item of pagePermissionList) {
        router.addRoute("manager", {
            path: item.route_path,
            // component: () => import("@/views/permissionInfo/PermissionInfoList"),
            component: routerModules[`..${item.component_path}.vue`],
            name: item.component_path.split("/").pop().replace(/^[A-Z]/, a => a.toLowerCase()),
        });
    }

}

export default buildRouter;