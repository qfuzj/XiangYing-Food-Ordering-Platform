'use strict'
const path = require('path')
// 引入 defineConfig，便于 IDE 提供类型检查和智能提示
const { defineConfig } = require('@vue/cli-service')

function resolve(dir) {
  return path.join(__dirname, dir)
}

// ------------------------------------------------
// 顶部常量定义区域
// ------------------------------------------------

// 网页标题
const name = process.env.VUE_APP_TITLE || '想应生活订餐平台'

// 后端接口地址 - 使用常量定义，方便维护
const baseUrl = 'http://localhost:8080'

// 端口（使用默认的 8081，或从环境变量/npm配置中获取）
const port = process.env.port || process.env.npm_config_port || 8081

// ------------------------------------------------
// Vue CLI 核心配置
// ------------------------------------------------

// 使用 defineConfig 包装导出配置，保持与您原配置的兼容
module.exports = defineConfig({

  // 基础配置
  transpileDependencies: true,
  productionSourceMap: false, // 生产环境不生成 Source Map

  // webpack-dev-server 相关配置
  devServer: {
    host: '0.0.0.0',
    port: port, // 引用顶部的 port 变量
    open: true,
    // 代理配置
    proxy: {
      // 代理规则 1：处理 /login 开头的请求
      '^/login': {
        // 引用顶部的 baseUrl 变量
        target: baseUrl,
        changeOrigin: true
        // 注意：这里没有 pathRewrite，所以 /login 会被保留并转发
      },
      // 代理规则 2：处理 /a 开头的请求
      '^/a': {
        // 引用顶部的 baseUrl 变量
        target: baseUrl,
        changeOrigin: true
        // 注意：这里没有 pathRewrite，所以 /a 会被保留并转发
      },

      /*
      // 如果您想使用更统一的 API 前缀（例如 /api），可以参考以下模式：

      '^/api': {
        target: baseUrl,
        changeOrigin: true,
        pathRewrite: {
          '^/api': '' // 转发给后端时去除 /api 前缀
        }
      }
      */
    },
  },

  // Webpack 基础配置 (用于配置别名和插件等)
  configureWebpack: {
    name: name,
    resolve: {
      alias: {
        // 配置 @ 别名，指向 src 目录
        '@': resolve('src')
      }
    },
    // 您可以根据需要在这里添加像 CompressionPlugin 这样的插件
    // plugins: [
    //   new CompressionPlugin({ /* ... */ })
    // ],
  },

  // Chain Webpack 配置（用于高级定制，如 SVG 优化、分包等）
  chainWebpack(config) {
    // 默认可以先不写，需要时再添加
  }
})