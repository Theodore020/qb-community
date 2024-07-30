<template>
  <el-form :model="formData" label-width="120" :rules="formRules" ref="form" v-loading="isLoading"
           element-loading-text="正在加载数据...">
    <el-form-item label="上级菜单" prop="parent_id">
      <el-tree-select
          v-model="formData.parent_id"
          :data="permissionTreeData"
          check-strictly
          :render-after-expand="false"
      />
    </el-form-item>
    <el-form-item label="菜单类型" prop="permission_type">
      <el-radio-group v-model="formData.permission_type">
        <el-radio :label="0">目录</el-radio>
        <el-radio :label="1">页面</el-radio>
        <el-radio :label="2">按钮</el-radio>
      </el-radio-group>
    </el-form-item>
    <el-form-item label="权限名称" prop="permission_name">
      <el-input v-model="formData.permission_name" placeholder="请输入权限名称"></el-input>
    </el-form-item>
    <el-form-item label="权限标识" prop="permission_key">
      <el-input v-model="formData.permission_key" placeholder="请输入权限标识"></el-input>
    </el-form-item>
    <el-form-item label="图标" prop="icon" v-if="formData.permission_type==0">
      <el-input v-model="formData.icon" placeholder="请输入图标名称"></el-input>
    </el-form-item>
    <el-form-item label="路由路径" prop="route_path" v-if="formData.permission_type==1">
      <el-input v-model="formData.route_path" placeholder="请输入路由路径"></el-input>
    </el-form-item>
    <el-form-item label="组件路径" prop="component_path" v-if="formData.permission_type==1">
      <el-input v-model="formData.component_path" placeholder="请输入组件路径"></el-input>
    </el-form-item>
    <el-form-item label="排序" prop="sort">
      <el-input-number v-model="formData.sort"></el-input-number>
    </el-form-item>
    <el-form-item label="权限说明">
      <el-input type="textarea" v-model="formData.marks" placeholder="请输入权限描述信息"></el-input>
    </el-form-item>
    <el-form-item>
      <el-button type="primary" @click="submitForm" :loading="isSubmit">保存数据</el-button>
      <el-button type="warning">重置表单</el-button>
    </el-form-item>
  </el-form>
</template>
<script>
import {ElMessage} from "element-plus";
import API from "@/API";

export default {
  name: "EditPermissionInfo",
  emits: ["close-dialog"],
  props: {
    currentEditId: {
      type: Number,
      required: true
    }
  },
  data() {
    return {
      formData: {
        parent_id: 0,
        permission_type: 0,
        icon: "",
        permission_name: "",
        permission_key: "",
        route_path: "",
        component_path: "",
        sort: 0,
        marks: ""
      },
      isSubmit: false,
      permissionTreeData: [{
        label: "全局",
        value: 0,
        children: []
      }],
      isLoading: true
    }
  },
  computed: {
    formRules() {
      return {
        parent_id: [
          {required: true, message: "请选择上级菜单", trigger: "blur"}
        ],
        permission_type: [
          {required: true, message: "请选择菜单类型", trigger: "blur"}
        ],
        permission_name: [
          {required: true, message: "请输入权限名称", trigger: "blur"}
        ],
        permission_key: [
          {required: true, message: "请输入权限标识", trigger: "blur"}
        ],
        sort: [
          {required: true, message: "请输入排序", trigger: "blur"}
        ],
        icon: [
          {required: this.formData.permission_type == 0, message: "请输入排序", trigger: "blur"}
        ],
        route_path: [
          {required: this.formData.permission_type == 1, message: "请输入路由路径", trigger: "blur"}
        ],
        component_path: [
          {required: this.formData.permission_type == 1, message: "请输入组件路径", trigger: "blur"}
        ]
      }
    }
  },
  created() {
    this.initData();
  },
  methods: {
    submitForm() {
      this.$refs.form.validate(valid => {
        if (valid) {
          this.updatePermission();
        } else {
          ElMessage.error("请将表单信息输入完整");
        }
      })
    },
    updatePermission() {
      this.isSubmit = true;
      API.permissionInfo.update(this.formData)
          .then(result => {
            ElMessage.success("保存成功");
            this.$emit("close-dialog");
          }).finally(() => {
        this.isSubmit = false;
      })
    },

    getPermissionTreeData() {
      return API.permissionInfo.getPermissionTreeData()
          .then(result => {
            this.permissionTreeData[0].children = result.data;
            return Promise.resolve();
          })
    },
    findById(id) {
      return API.permissionInfo.findById(id)
          .then(result => {
            this.formData = result.data;
            return Promise.resolve();
          })
    },
    initData() {
      this.isLoading = true;
      Promise.all([this.getPermissionTreeData(), this.findById(this.currentEditId)])
          .finally(() => {
            this.isLoading = false;
          })
    }
  }
}
</script>
<style scoped></style>