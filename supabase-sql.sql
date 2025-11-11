-- TechBlog Supabase 数据库初始化脚本
-- 请在Supabase控制台的SQL Editor中执行此脚本

-- 1. 创建分类表
CREATE TABLE IF NOT EXISTS categories (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW())
);

-- 2. 创建文章表
CREATE TABLE IF NOT EXISTS posts (
  id SERIAL PRIMARY KEY,
  title VARCHAR(200) NOT NULL,
  content TEXT NOT NULL,
  excerpt TEXT,
  category_id INTEGER REFERENCES categories(id),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW())
);

-- 3. 创建评论表
CREATE TABLE IF NOT EXISTS comments (
  id SERIAL PRIMARY KEY,
  post_id INTEGER REFERENCES posts(id),
  author VARCHAR(100) DEFAULT '匿名用户',
  content TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW())
);

-- 4. 插入示例分类数据
INSERT INTO categories (name, description) VALUES 
('前端开发', '前端技术相关文章'),
('后端开发', '后端技术相关文章'),
('DevOps', '部署和运维相关文章');

-- 5. 插入示例文章数据
INSERT INTO posts (title, content, excerpt, category_id) VALUES 
('Vue 3 组合式API入门指南', 'Vue 3引入了组合式API，这是一种更灵活的组织组件逻辑的方式。本文将介绍如何使用setup函数、ref、reactive等核心概念。

## 什么是组合式API？

组合式API是Vue 3的核心特性之一，它允许我们使用函数式的方式来组织组件逻辑。与选项式API相比，组合式API提供了更好的逻辑复用和类型推断支持。

## 基本用法

使用组合式API时，我们需要在setup函数中定义响应式数据和逻辑。例如：

```javascript
import { ref, reactive } from ''vue''

export default {
  setup() {
    const count = ref(0)
    const state = reactive({
      message: ''Hello Vue 3''
    })
    
    const increment = () => {
      count.value++
    }
    
    return {
      count,
      state,
      increment
    }
  }
}
```

## 优势

1. 更好的逻辑复用
2. 更灵活的类型支持
3. 更清晰的代码组织

组合式API是Vue 3开发的重要技能，建议深入学习并实践。', 'Vue 3引入了组合式API，这是一种更灵活的组织组件逻辑的方式。', 1),

('Supabase实时数据库使用实践', 'Supabase提供了强大的实时数据库功能，支持PostgreSQL和实时订阅。本文将介绍如何配置Supabase项目并实现实时数据同步。

## Supabase简介

Supabase是一个开源的Firebase替代品，基于PostgreSQL构建。它提供了实时数据库、身份验证、存储等服务。

## 配置项目

1. 创建Supabase项目
2. 获取API密钥
3. 配置客户端

## 实时功能

Supabase的实时功能基于PostgreSQL的复制功能，可以监听数据库的变化并实时推送到客户端。

```javascript
const subscription = supabase
  .from(''posts'')
  .on(''INSERT'', payload => {
    console.log(''新文章:'', payload.new)
  })
  .subscribe()
```

## 最佳实践

- 合理使用索引
- 注意数据安全
- 优化查询性能', 'Supabase提供了强大的实时数据库功能，支持PostgreSQL和实时订阅。', 2),

('Netlify自动化部署最佳实践', 'Netlify让前端部署变得简单高效。本文将分享如何配置持续集成、环境变量管理和性能优化等最佳实践。

## Netlify优势

- 自动部署Git分支
- 支持自定义域名
- 内置CDN加速

## 部署流程

1. 连接Git仓库
2. 配置构建命令
3. 设置环境变量

## 性能优化

- 使用缓存策略
- 优化资源加载
- 监控性能指标', 'Netlify让前端部署变得简单高效。本文将分享如何配置持续集成。', 3);

-- 6. 插入示例评论数据
INSERT INTO comments (post_id, author, content) VALUES 
(1, '张三', '很好的入门教程！'),
(1, '李四', '组合式API确实比选项式更灵活'),
(2, '王五', 'Supabase的实时功能很强大');

-- 7. 启用行级安全策略
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE posts ENABLE ROW LEVEL SECURITY;
ALTER TABLE comments ENABLE ROW LEVEL SECURITY;

-- 8. 创建读取策略（允许所有人读取）
CREATE POLICY "允许所有人读取分类" ON categories FOR SELECT USING (true);
CREATE POLICY "允许所有人读取文章" ON posts FOR SELECT USING (true);
CREATE POLICY "允许所有人读取评论" ON comments FOR SELECT USING (true);

-- 9. 创建插入策略（允许所有人插入评论）
CREATE POLICY "允许所有人插入评论" ON comments FOR INSERT WITH CHECK (true);

-- 10. 创建更新策略（可选，如果需要编辑功能）
-- CREATE POLICY "允许所有人更新文章" ON posts FOR UPDATE USING (true);

-- 11. 创建索引以提高查询性能
CREATE INDEX IF NOT EXISTS idx_posts_category_id ON posts(category_id);
CREATE INDEX IF NOT EXISTS idx_posts_created_at ON posts(created_at);
CREATE INDEX IF NOT EXISTS idx_comments_post_id ON comments(post_id);
CREATE INDEX IF NOT EXISTS idx_comments_created_at ON comments(created_at);

-- 12. 创建触发器自动更新updated_at字段
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = TIMEZONE('utc'::text, NOW());
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_posts_updated_at BEFORE UPDATE ON posts
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- 完成提示
SELECT '数据库初始化完成！' as message;