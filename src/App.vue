<template>
  <div id="app">
    <nav class="navbar">
      <div class="container">
        <div class="logo">
          <router-link to="/" style="color: white; text-decoration: none;">
            ✦ 帝王博客 ✦
          </router-link>
        </div>
        <ul class="nav-links">
          <li><router-link to="/">🏛️ 首页</router-link></li>
          <li><router-link to="/about">👑 关于</router-link></li>
        </ul>
      </div>
    </nav>
    
    <main class="main-content">
      <div class="container">
        <router-view />
      </div>
    </main>
    
    <footer class="imperial-footer">
      <div class="container">
        <div class="footer-content">
          <div class="footer-logo">
            <span>✦ 帝王博客 ✦</span>
            <p>紫金配色，帝王风范</p>
          </div>
          <div class="footer-info">
            <p>🏛️ 尊贵体验，奢华视觉</p>
            <p>👑 2025 帝王技术博客平台</p>
          </div>
        </div>
        <div class="footer-bottom">
          <p>&copy; 2025 帝王博客 - 紫金配色，帝王风范</p>
        </div>
      </div>
    </footer>
  </div>
</template>

<script>
export default {
  name: 'App'
}
</script>

<style scoped>
.imperial-footer {
  background: linear-gradient(135deg, #4a1c6b 0%, #2d1b69 100%);
  color: #ffd700;
  text-align: center;
  padding: 2rem 0 1rem;
  border-top: 3px solid #ffd700;
  margin-top: 3rem;
  position: relative;
}

.imperial-footer::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 2px;
  background: linear-gradient(90deg, transparent, #ffd700, transparent);
}

.footer-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1.5rem;
  flex-wrap: wrap;
  gap: 2rem;
}

.footer-logo span {
  font-size: 1.5rem;
  font-weight: bold;
  background: linear-gradient(45deg, #ffd700, #ffed4e);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
}

.footer-logo p {
  color: #d4af37;
  margin-top: 0.5rem;
  font-size: 0.9rem;
}

.footer-info p {
  margin: 0.3rem 0;
  font-size: 1rem;
  color: #ffd700;
}

.footer-bottom {
  border-top: 1px solid rgba(255, 215, 0, 0.3);
  padding-top: 1rem;
}

.footer-bottom p {
  margin: 0;
  font-size: 0.9rem;
  color: #d4af37;
}

@media (max-width: 768px) {
  .footer-content {
    flex-direction: column;
    text-align: center;
    gap: 1.5rem;
  }
  
  .footer-logo span {
    font-size: 1.3rem;
  }
}
</style>