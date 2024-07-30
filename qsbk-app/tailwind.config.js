/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{vue,js,ts,jsx,tsx}",
    "./src/*.{vue,js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        primaryColor: "#FE6479"
      }
    },
  },
  plugins: [],
  corePlugins: {
    //是否使用tailwind.css的初始化操作，也就是margin:0,padding:0
    preflight: true,
  }
}

