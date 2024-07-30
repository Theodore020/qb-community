<template>
  <el-config-provider :locale="locale">
    <router-view></router-view>
  </el-config-provider>
</template>
<script>
import { ElConfigProvider } from 'element-plus'

import zhCn from 'element-plus/dist/locale/zh-cn.mjs'

export default {
  data() {
    return {
      locale: zhCn
    }
  },
  components: {
    ElConfigProvider,
  },
}
</script>
<style scoped lang="scss"></style>