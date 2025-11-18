<template>
  <div class="home">
    <div class="hero-section" style="text-align: center; margin-bottom: 3rem;">
      <h1 style="font-size: 3rem; margin-bottom: 1rem; color: #ffd700; text-shadow: 2px 2px 4px rgba(0,0,0,0.5);">🏛️ 欢迎来到帝王博客 🏛️</h1>
      <p style="font-size: 1.5rem; color: #d4af37; font-style: italic;">紫金配色，帝王风范 - 尊贵的技术分享平台</p>
      <div style="margin-top: 1rem; font-size: 1.2rem; color: #e6d8ff;">
        <span>✦ 奢华体验 ✦ 尊贵视觉 ✦ 帝王品质 ✦</span>
      </div>
    </div>
    
    <div v-if="loading" class="loading">加载中...</div>
    
    <div v-else class="post-list">
      <div 
        v-for="post in posts" 
        :key="post.id" 
        class="card post-item"
        @click="goToPost(post.id)"
        style="cursor: pointer;"
      >
        <h2 class="post-title">{{ post.title }}</h2>
        <div class="post-meta">
          <span style="color: #ffd700;">分类:</span> {{ post.categories?.name || '未分类' }}
          <span style="margin: 0 1rem;">|</span>
          <span style="color: #ffd700;">发布时间:</span> {{ formatDate(post.created_at) }}
          <span style="margin: 0 1rem;">|</span>
          <span style="color: #ffd700;">评论数:</span> {{ post.comments?.[0]?.count || 0 }}
        </div>
        <p class="post-excerpt">{{ post.excerpt || post.content?.substring(0, 150) + '...' }}</p>
      </div>
    </div>
    
    <div v-if="!loading && posts.length === 0" class="card" style="text-align: center;">
      <p style="color: #ffd700; font-size: 1.2rem; text-shadow: 1px 1px 2px rgba(0,0,0,0.3);">暂无文章，请先配置Supabase数据库</p>
    </div>
  </div>
</template>

<script>
import { blogAPI } from '../supabase'

export default {
  name: 'Home',
  data() {
    return {
      posts: [],
      loading: true
    }
  },
  async mounted() {
    await this.fetchPosts()
  },
  methods: {
    async fetchPosts() {
      try {
        // 使用真实的Supabase API获取文章列表
        this.posts = await blogAPI.getPosts()
      } catch (error) {
        console.error('获取文章列表失败:', error)
        // 如果获取失败，显示空列表
        this.posts = []
      } finally {
        this.loading = false
      }
    },
    
    goToPost(id) {
      this.$router.push(`/post/${id}`)
    },
    
    formatDate(dateString) {
      return new Date(dateString).toLocaleDateString('zh-CN')
    }
  }
}
</script>