<template>
    <div class=" text-white flex flex-row h-[55px] bg-[#222E3D] items-center justify-center">
      <el-icon size="30" class="mr-[5px] is-loading">
        <Loading/>
      </el-icon>
      <span class="italic font-bold" v-if="!isCollapseMenu">糗事百科·后台管理</span>
    </div>
    <!-- 菜单 -->
    <el-menu
        active-text-color="#ffd04b"
        background-color="#304156"
        :router="true"
        :default-active="$route.path"
        text-color="#fff"
        :collapse="isCollapseMenu"
        unique-opened>
      <el-sub-menu v-for="(item,index) in permissionList" :key="index" :index="String(index)">
        <template #title>
          <el-icon>
            <component :is="item.icon"></component>
          </el-icon>
          <span>{{ item.permission_name }}</span>
        </template>
        <el-menu-item v-for="(subItem,subIndex) in item.children" :index="subItem.route_path" :key="subIndex">
          <span>{{ subItem.permission_name }}</span>
        </el-menu-item>
      </el-sub-menu>
    </el-menu>
  </template>
  <script>
  import {mapGetters} from "vuex";
  
  export default {
    name: "LeftMenu",
    computed: {
      ...mapGetters(["permissionList","isCollapseMenu"])
    }
  }
  </script>
  <style scoped>
  .el-menu {
    border-right: none;
  }
  </style>