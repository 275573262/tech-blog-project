# Supabase 数据库配置指南

## 1. 创建Supabase项目

1. 访问 [Supabase官网](https://supabase.com)
2. 注册账号并登录
3. 点击 "New Project" 创建新项目
4. 填写项目信息：
   - Name: `tech-blog`
   - Database Password: 设置一个安全的密码
   - Region: 选择离你最近的区域（如ap-southeast-1）
5. 点击 "Create new project"

## 2. 获取API配置

项目创建完成后，在项目设置页面找到：
- **URL**: 类似 `https://your-project.supabase.co`
- **anon public key**: 类似 `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...`

## 3. 配置项目文件

修改 `src/supabase.js` 文件：

```javascript
const supabaseUrl = 'https://your-actual-project.supabase.co'
const supabaseKey = 'your-actual-anon-key'
```

## 4. 执行SQL脚本

在Supabase控制台的SQL Editor中执行以下SQL：

```sql
-- 创建分类表
CREATE TABLE categories (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW())
);

-- 创建文章表
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title VARCHAR(200) NOT NULL,
  content TEXT NOT NULL,
  excerpt TEXT,
  category_id INTEGER REFERENCES categories(id),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW())
);

-- 创建评论表
CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  post_id INTEGER REFERENCES posts(id),
  author VARCHAR(100) DEFAULT '匿名用户',
  content TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW())
);

-- 插入示例分类数据
INSERT INTO categories (name, description) VALUES 
('前端开发', '前端技术相关文章'),
('后端开发', '后端技术相关文章'),
('DevOps', '部署和运维相关文章');

-- 插入示例文章数据
INSERT INTO posts (title, content, excerpt, category_id) VALUES 
('Vue 3 组合式API入门指南', 'Vue 3引入了组合式API，这是一种更灵活的组织组件逻辑的方式...', 'Vue 3引入了组合式API，这是一种更灵活的组织组件逻辑的方式。', 1),
('Supabase实时数据库使用实践', 'Supabase提供了强大的实时数据库功能，支持PostgreSQL和实时订阅...', 'Supabase提供了强大的实时数据库功能，支持PostgreSQL和实时订阅。', 2),
('Netlify自动化部署最佳实践', 'Netlify让前端部署变得简单高效。本文将分享如何配置持续集成...', 'Netlify让前端部署变得简单高效。本文将分享如何配置持续集成。', 3);

-- 设置表权限（允许匿名访问）
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE posts ENABLE ROW LEVEL SECURITY;
ALTER TABLE comments ENABLE ROW LEVEL SECURITY;

-- 创建策略（允许所有人读取）
CREATE POLICY "允许所有人读取分类" ON categories FOR SELECT USING (true);
CREATE POLICY "允许所有人读取文章" ON posts FOR SELECT USING (true);
CREATE POLICY "允许所有人读取评论" ON comments FOR SELECT USING (true);

-- 创建策略（允许所有人插入评论）
CREATE POLICY "允许所有人插入评论" ON comments FOR INSERT WITH CHECK (true);
```

## 5. 测试连接

在浏览器中打开项目，如果配置正确，应该能看到文章列表和评论功能正常工作。

## 6. 环境变量配置（Netlify部署）

在Netlify部署时，需要设置以下环境变量：
- `VITE_SUPABASE_URL`: 你的Supabase项目URL
- `VITE_SUPABASE_ANON_KEY`: 你的Supabase anon key

修改 `src/supabase.js` 以支持环境变量：

```javascript
const supabaseUrl = import.meta.env.VITE_SUPABASE_URL || 'https://your-project.supabase.co'
const supabaseKey = import.meta.env.VITE_SUPABASE_ANON_KEY || 'your-anon-key'
```

## 注意事项

1. **安全设置**: 生产环境中建议启用身份验证，限制数据访问权限
2. **备份**: 定期备份数据库
3. **监控**: 关注API使用量和性能指标
4. **优化**: 根据使用情况调整数据库配置