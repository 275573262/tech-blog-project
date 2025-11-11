import { createClient } from '@supabase/supabase-js'

// Supabase配置 - 使用你的实际配置
const supabaseUrl = 'https://wjxcexxefxexlcminycd.supabase.co'
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndqeGNleHhlZnhleGxjbWlueWNkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI4MjU5MDYsImV4cCI6MjA3ODQwMTkwNn0.2fsJ3cz6ppb9L69XOZIAX60QDoaiXWwlz5MrlCHWBwI'

export const supabase = createClient(supabaseUrl, supabaseKey)

// 数据表操作函数
export const blogAPI = {
  // 获取文章列表
  async getPosts() {
    const { data, error } = await supabase
      .from('posts')
      .select(`
        *,
        categories(name)
      `)
      .order('created_at', { ascending: false })
    
    if (error) throw error
    
    // 为每篇文章获取评论数量
    const postsWithCommentCount = await Promise.all(
      data.map(async (post) => {
        const { count, error } = await supabase
          .from('comments')
          .select('*', { count: 'exact', head: true })
          .eq('post_id', post.id)
        
        if (error) {
          console.error('获取评论数量失败:', error)
          return { ...post, comments: [{ count: 0 }] }
        }
        
        return { ...post, comments: [{ count: count || 0 }] }
      })
    )
    
    return postsWithCommentCount
  },

  // 获取单篇文章
  async getPost(id) {
    // 获取文章基本信息
    const { data: postData, error: postError } = await supabase
      .from('posts')
      .select(`
        *,
        categories(name)
      `)
      .eq('id', id)
      .single()
    
    if (postError) throw postError
    
    // 获取文章的评论
    const { data: commentsData, error: commentsError } = await supabase
      .from('comments')
      .select('*')
      .eq('post_id', id)
      .order('created_at', { ascending: true })
    
    if (commentsError) {
      console.error('获取评论失败:', commentsError)
      return { ...postData, comments: [] }
    }
    
    return { ...postData, comments: commentsData || [] }
  },

  // 获取分类列表
  async getCategories() {
    const { data, error } = await supabase
      .from('categories')
      .select('*')
    
    if (error) throw error
    return data
  },

  // 添加评论
  async addComment(postId, content, author) {
    const { data, error } = await supabase
      .from('comments')
      .insert([
        { 
          post_id: postId, 
          content: content, 
          author: author || '匿名用户'
        }
      ])
      .select()
    
    if (error) throw error
    return data
  }
}