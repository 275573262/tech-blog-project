<template>
  <div class="about">
    <div class="card">
      <h1 style="font-size: 2.5rem; margin-bottom: 1rem; color: #ffd700; text-align: center; text-shadow: 1px 1px 3px rgba(0,0,0,0.5);">👑 关于帝王博客 👑</h1>
      
      <div class="about-content" style="line-height: 1.8;">
        <p style="margin-bottom: 1rem; color: #e6d8ff; font-size: 1.1rem; text-align: center; font-style: italic;">
          ✦ 帝王博客是一个基于紫金配色设计的奢华技术分享平台，融合帝王风范与现代技术 ✦
        </p>
        
        <h2 style="margin: 2rem 0 1rem 0; color: #ffd700; border-left: 4px solid #ffd700; padding-left: 1rem;">🏛️ 帝王技术栈</h2>
        <ul style="margin-left: 2rem; margin-bottom: 2rem;">
          <li><strong>前端:</strong> Vue 3 + Vue Router</li>
          <li><strong>后端:</strong> Supabase (PostgreSQL + 实时API)</li>
          <li><strong>部署:</strong> Netlify</li>
          <li><strong>构建工具:</strong> Vite</li>
        </ul>
        
        <h2 style="margin: 2rem 0 1rem 0; color: #ffd700; border-left: 4px solid #ffd700; padding-left: 1rem;">👑 帝王特性</h2>
        <ul style="margin-left: 2rem; margin-bottom: 2rem;">
          <li>响应式设计，支持移动端和桌面端</li>
          <li>文章分类管理</li>
          <li>实时评论系统</li>
          <li>现代化的用户界面</li>
          <li>快速的内容加载</li>
        </ul>
        
        <h2 style="margin: 2rem 0 1rem 0; color: #ffd700; border-left: 4px solid #ffd700; padding-left: 1rem;">💎 帝王数据库</h2>
        <div style="background: #f8f9fa; padding: 1rem; border-radius: 5px; margin-bottom: 2rem;">
          <h3 style="color: #333; margin-bottom: 0.5rem;">posts表 (博客文章)</h3>
          <p style="margin-bottom: 1rem;">存储博客文章的基本信息</p>
          
          <h3 style="color: #333; margin-bottom: 0.5rem;">categories表 (文章分类)</h3>
          <p style="margin-bottom: 1rem;">管理文章的分类信息</p>
          
          <h3 style="color: #333; margin-bottom: 0.5rem;">comments表 (文章评论)</h3>
          <p style="margin-bottom: 1rem;">存储用户对文章的评论</p>
        </div>
        
        <div style="text-align: center; padding: 2rem; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border-radius: 10px;">
          <h3 style="margin-bottom: 1rem;">开源项目</h3>
          <p>本项目采用MIT开源协议，欢迎贡献代码和提出建议！</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'About'
}
</script>