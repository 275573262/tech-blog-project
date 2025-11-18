<template>
  <div class="post-detail">
    <div v-if="loading" class="loading">加载中...</div>
    
    <div v-else-if="post" class="card">
      <button 
        @click="$router.back()" 
        class="btn" 
        style="margin-bottom: 1rem; background: #6c757d;"
      >
        ← 返回
      </button>
      
      <h1 style="font-size: 2rem; margin-bottom: 1rem; color: #ffd700; text-shadow: 2px 2px 4px rgba(0,0,0,0.5);">{{ post.title }}</h1>
      
      <div class="post-meta" style="margin-bottom: 2rem;">
        <span>分类: {{ post.categories?.name || '未分类' }}</span>
        <span style="margin: 0 1rem;">|</span>
        <span>发布时间: {{ formatDate(post.created_at) }}</span>
      </div>
      
      <div class="post-content" style="line-height: 1.8; margin-bottom: 2rem; color: #f0e6ff; font-size: 1.1rem;">
        <p v-for="(paragraph, index) in post.content.split('\n')" :key="index" style="margin-bottom: 1rem; text-shadow: 1px 1px 2px rgba(0,0,0,0.3);">
          {{ paragraph }}
        </p>
      </div>
      
      <!-- 评论区域 -->
      <div class="comments-section">
        <h3 style="margin-bottom: 1rem; color: #ffd700; text-shadow: 1px 1px 3px rgba(0,0,0,0.5);">评论 ({{ post.comments?.length || 0 }})</h3>
        
        <div v-if="post.comments && post.comments.length > 0" class="comments-list">
          <div 
            v-for="comment in post.comments" 
            :key="comment.id" 
            class="comment-item"
            style="border-left: 3px solid #ffd700; padding-left: 1rem; margin-bottom: 1rem;"
          >
            <div class="comment-author">{{ comment.author || '匿名用户' }}</div>
            <div class="comment-content">{{ comment.content }}</div>
            <div class="comment-time">{{ formatDate(comment.created_at) }}</div>
          </div>
        </div>
        
        <div v-else style="text-align: center; color: #d4af37; padding: 2rem; font-style: italic;">
          暂无评论，快来发表第一条评论吧！
        </div>
        
        <!-- 添加评论表单 -->
        <div class="add-comment comment-form" style="margin-top: 2rem;">
          <h4 style="color: #ffd700; text-shadow: 1px 1px 2px rgba(0,0,0,0.3); margin-bottom: 1.5rem;">发表评论</h4>
          <form @submit.prevent="submitComment">
            <div style="margin-bottom: 1rem;">
              <input 
                v-model="newComment.author" 
                type="text" 
                placeholder="您的姓名（可选）"
                class="comment-input"
              >
            </div>
            <div style="margin-bottom: 1rem;">
              <textarea 
                v-model="newComment.content" 
                placeholder="请输入评论内容"
                rows="4"
                required
                class="comment-input"
              ></textarea>
            </div>
            <button type="submit" class="btn">发表评论</button>
          </form>
        </div>
      </div>
    </div>
    
    <div v-else class="card" style="text-align: center;">
      <p>文章不存在</p>
    </div>
  </div>
</template>

<script>
import { blogAPI } from '../supabase'

export default {
  name: 'PostDetail',
  data() {
    return {
      post: null,
      loading: true,
      newComment: {
        author: '',
        content: ''
      }
    }
  },
  async mounted() {
    await this.fetchPost()
  },
  methods: {
    async fetchPost() {
      try {
        const postId = this.$route.params.id
        
        // 使用真实的Supabase API获取文章数据
        this.post = await blogAPI.getPost(postId)
      } catch (error) {
        console.error('获取文章详情失败:', error)
        // 如果获取失败，显示错误信息
        this.post = null
      } finally {
        this.loading = false
      }
    },
    
    async submitComment() {
      try {
        // 使用真实的Supabase API添加评论
        await blogAPI.addComment(this.post.id, this.newComment.content, this.newComment.author)
        
        // 重新获取文章数据以显示最新评论
        await this.fetchPost()
        
        // 清空表单
        this.newComment = { author: '', content: '' }
        
        alert('评论发表成功！')
      } catch (error) {
        console.error('发表评论失败:', error)
        alert('评论发表失败，请重试')
      }
    },
    
    formatDate(dateString) {
      return new Date(dateString).toLocaleString('zh-CN')
    }
  }
}
</script>