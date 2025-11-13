<template>
  <div id="app">
    <h2>Vue 登录测试（/login -> 获取 JWT）</h2>
    <form @submit.prevent="login">
      <label>用户名: <input v-model="username" required></label><br>
      <label>密码: <input type="password" v-model="password" required></label><br>
      <button type="submit">登录</button>
    </form>
    <button @click="callProtected">调用受保护接口 /a</button>
    <div>{{ message }}</div>
  </div>
</template>

<script>
export default {
  name: 'App',
  data() {
    return {
      username: '',
      password: '',
      message: ''
    };
  },
  methods: {
    async login() {
      try {
        const res = await fetch('/login', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ username: this.username, password: this.password })
        });
        if (!res.ok) {
          this.message = '登录失败';
          return;
        }
        const json = await res.json();
        localStorage.setItem('token', json.token);
        localStorage.setItem('tokenType', json.tokenType || 'Bearer');
        this.message = '登录成功，token 已保存';
      } catch (e) {
        this.message = '请求错误';
      }
    },
    async callProtected() {
      const token = localStorage.getItem('token');
      const type = localStorage.getItem('tokenType') || 'Bearer';
      try {
        const res = await fetch('/a', {
          headers: { Authorization: token ? (type + ' ' + token) : '' }
        });
        const text = await res.text();
        this.message = `状态: ${res.status}，返回: ${text}`;
      } catch (e) {
        this.message = '请求错误';
      }
    }
  }
};
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>