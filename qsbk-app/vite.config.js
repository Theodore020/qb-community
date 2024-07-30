import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import path from 'path'
// https://vitejs.dev/config/
export default defineConfig({
  plugins: [vue()],
  server: {
    port: 5174
  },
  resolve: {
    alias: [
      {
        find: "@",
        replacement: path.join(__dirname, "src")
      }
    ],
    extensions: ['.js', '.ts', '.vue', ".json"]
  },
})
