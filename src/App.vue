<template>
  <div id="app">
    <nav class="navbar">
      <div class="container">
        <div class="logo">
          <router-link to="/" style="color: white; text-decoration: none;">
            TechBlog
          </router-link>
        </div>
        <ul class="nav-links">
          <li><router-link to="/">首页</router-link></li>
          <li><router-link to="/about">关于</router-link></li>
        </ul>
      </div>
    </nav>
    
    <main class="main-content">
      <div class="container">
        <router-view />
      </div>
    </main>
    
    <footer style="background: #333; color: white; text-align: center; padding: 1rem; margin-top: 2rem;">
      <div class="container">
        <p>&copy; 2025 TechBlog - 个人技术博客平台</p>
      </div>
    </footer>
  </div>
</template>

<script>
export default {
  name: 'App'
}
</script>