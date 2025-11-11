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
      
      <h1 style="font-size: 2rem; margin-bottom: 1rem; color: #333;">{{ post.title }}</h1>
      
      <div class="post-meta" style="margin-bottom: 2rem;">
        <span>分类: {{ post.categories?.name || '未分类' }}</span>
        <span style="margin: 0 1rem;">|</span>
        <span>发布时间: {{ formatDate(post.created_at) }}</span>
      </div>
      
      <div class="post-content" style="line-height: 1.8; margin-bottom: 2rem;">
        <p v-for="(paragraph, index) in post.content.split('\n')" :key="index">
          {{ paragraph }}
        </p>
      </div>
      
      <!-- 评论区域 -->
      <div class="comments-section">
        <h3 style="margin-bottom: 1rem;">评论 ({{ post.comments?.length || 0 }})</h3>
        
        <div v-if="post.comments && post.comments.length > 0" class="comments-list">
          <div 
            v-for="comment in post.comments" 
            :key="comment.id" 
            class="comment-item"
            style="border-left: 3px solid #667eea; padding-left: 1rem; margin-bottom: 1rem;"
          >
            <div style="font-weight: bold; margin-bottom: 0.5rem;">{{ comment.author }}</div>
            <div style="color: #555;">{{ comment.content }}</div>
            <div style="font-size: 0.8rem; color: #888; margin-top: 0.5rem;">
              {{ formatDate(comment.created_at) }}
            </div>
          </div>
        </div>
        
        <div v-else style="text-align: center; color: #666; padding: 2rem;">
          暂无评论，快来发表第一条评论吧！
        </div>
        
        <!-- 添加评论表单 -->
        <div class="add-comment" style="margin-top: 2rem;">
          <h4>发表评论</h4>
          <form @submit.prevent="submitComment">
            <div style="margin-bottom: 1rem;">
              <input 
                v-model="newComment.author" 
                type="text" 
                placeholder="您的姓名（可选）"
                style="width: 100%; padding: 0.5rem; border: 1px solid #ddd; border-radius: 4px;"
              >
            </div>
            <div style="margin-bottom: 1rem;">
              <textarea 
                v-model="newComment.content" 
                placeholder="请输入评论内容"
                rows="4"
                required
                style="width: 100%; padding: 0.5rem; border: 1px solid #ddd; border-radius: 4px;"
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