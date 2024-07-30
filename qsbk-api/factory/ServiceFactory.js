
        class ServiceFactory {
            static createBaseService(){ 
                    return Reflect.construct(require("../services/BaseService.js"), []);
                }
static createCategoryInfoService(){ 
                    return Reflect.construct(require("../services/CategoryInfoService.js"), []);
                }
static createCommentInfoService(){ 
                    return Reflect.construct(require("../services/CommentInfoService.js"), []);
                }
static createPermissionInfoService(){ 
                    return Reflect.construct(require("../services/PermissionInfoService.js"), []);
                }
static createPostImgInfoService(){ 
                    return Reflect.construct(require("../services/PostImgInfoService.js"), []);
                }
static createPostInfoService(){ 
                    return Reflect.construct(require("../services/PostInfoService.js"), []);
                }
static createRoleInfoService(){ 
                    return Reflect.construct(require("../services/RoleInfoService.js"), []);
                }
static createRolePermissionInfoService(){ 
                    return Reflect.construct(require("../services/RolePermissionInfoService.js"), []);
                }
static createUserInfoService(){ 
                    return Reflect.construct(require("../services/UserInfoService.js"), []);
                }
static createUserRoleInfoService(){ 
                    return Reflect.construct(require("../services/UserRoleInfoService.js"), []);
                }
        }

        module.exports = ServiceFactory;
    