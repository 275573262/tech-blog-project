<template>
  <div class="home">
    <div class="hero-section" style="text-align: center; margin-bottom: 3rem;">
      <h1 style="font-size: 2.5rem; margin-bottom: 1rem; color: #333;">欢迎来到TechBlog</h1>
      <p style="font-size: 1.2rem; color: #666;">分享技术，记录成长</p>
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
          <span>分类: {{ post.categories?.name || '未分类' }}</span>
          <span style="margin: 0 1rem;">|</span>
          <span>发布时间: {{ formatDate(post.created_at) }}</span>
          <span style="margin: 0 1rem;">|</span>
          <span>评论数: {{ post.comments?.[0]?.count || 0 }}</span>
        </div>
        <p class="post-excerpt">{{ post.excerpt || post.content?.substring(0, 150) + '...' }}</p>
      </div>
    </div>
    
    <div v-if="!loading && posts.length === 0" class="card" style="text-align: center;">
      <p>暂无文章，请先配置Supabase数据库</p>
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