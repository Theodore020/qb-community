<template>
  <div v-loading="isLoading" element-loading-text="正在加载数据...">
    <el-tree
        ref="elTree"
        :data="permissionTreeData"
        node-key="id"
        show-checkbox
        default-expand-all
        check-strictly
        :default-checked-keys="defaultCheckedKeys"
    />
    <div class="mt-[10px]">
      <el-button type="primary" :loading="isSubmit" @click="savePermission">保存数据</el-button>
      <el-button type="warning" @click="$emit('close-dialog')">关闭</el-button>
    </div>
  </div>
</template>

<script>
import API from "@/API/index.js";
import {ElMessage} from "element-plus";

export default {
  name: "AssignPermission",
  emits: ["close-dialog"],
  props: {
    currentAssignRoleId: {
      required: true,
      type: Number
    }
  },
  data() {
    return {
      permissionTreeData: [],
      defaultCheckedKeys: [],
      isLoading: true,
      isSubmit: false,
    }
  },
  created() {
    this.initData();
  },
  methods: {
    getPermissionTreeData() {
      return API.permissionInfo.getPermissionTreeData()
          .then(result => {
            this.permissionTreeData = result.data;
            return Promise.resolve();
          })
    },
    getPermissionListByRoleId(role_id) {
      return API.rolePermissionInfo.getPermissionListByRoleId(role_id)
          .then(result => {
            this.defaultCheckedKeys = result.data.map(item => item.permission_id);
            return Promise.resolve();
          })
    },
    initData() {
      this.isLoading = true;
      Promise.all([this.getPermissionTreeData(), this.getPermissionListByRoleId(this.currentAssignRoleId)])
          .finally(() => {
            this.isLoading = false;
          })
    },
    //保存权限
    savePermission() {
      let keys = this.$refs.elTree.getCheckedKeys();
      //这里的keys就是选中的权限id,也就是permission_key
      this.isSubmit = true;
      API.rolePermissionInfo.savePermission(this.currentAssignRoleId, keys)
          .then(result => {
            ElMessage.success("保存成功");
            this.$emit("close-dialog");
          }).finally(() => {
        this.isSubmit = false;
      })
    }
  }
}
</script>

<style scoped>

</style>