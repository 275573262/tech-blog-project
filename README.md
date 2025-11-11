# TechBlog - 个人技术博客平台

一个基于Vue 3 + Supabase + Netlify构建的现代化个人技术博客平台。

## 项目特色

- 🚀 **现代技术栈**: Vue 3 + Vite + Supabase
- 📱 **响应式设计**: 完美支持移动端和桌面端
- 💬 **实时评论**: 基于Supabase的实时数据库功能
- 🌐 **自动部署**: 使用Netlify实现持续集成部署
- 🎨 **美观界面**: 现代化的UI设计，优秀的用户体验

## 功能特性

### 页面结构
1. **首页** - 博客文章列表展示
2. **文章详情页** - 单篇文章内容及评论功能
3. **关于页面** - 项目介绍和技术栈说明

### 数据库设计
Supabase中设计了3张数据表：

#### 1. posts表 (博客文章)
- id: 主键
- title: 文章标题
- content: 文章内容
- excerpt: 文章摘要
- category_id: 分类ID
- created_at: 创建时间
- updated_at: 更新时间

#### 2. categories表 (文章分类)
- id: 主键
- name: 分类名称
- description: 分类描述
- created_at: 创建时间

#### 3. comments表 (文章评论)
- id: 主键
- post_id: 关联文章ID
- author: 评论作者
- content: 评论内容
- created_at: 创建时间

## 快速开始

### 环境要求
- Node.js 16+
- npm 或 yarn

### 安装依赖
```bash
npm install
```

### 开发模式
```bash
npm run dev
```

### 构建生产版本
```bash
npm run build
```

## Supabase配置

1. 访问 [Supabase官网](https://supabase.com) 创建新项目
2. 获取项目URL和anon key
3. 修改 `src/supabase.js` 中的配置：

```javascript
const supabaseUrl = 'https://your-project.supabase.co'
const supabaseKey = 'your-anon-key'
```

4. 在Supabase控制台执行以下SQL创建数据表：

```sql
-- 创建分类表
CREATE TABLE categories (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

-- 创建文章表
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title VARCHAR(200) NOT NULL,
  content TEXT NOT NULL,
  excerpt TEXT,
  category_id INTEGER REFERENCES categories(id),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- 创建评论表
CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  post_id INTEGER REFERENCES posts(id),
  author VARCHAR(100) DEFAULT '匿名用户',
  content TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

-- 插入示例数据
INSERT INTO categories (name, description) VALUES 
('前端开发', '前端技术相关文章'),
('后端开发', '后端技术相关文章'),
('DevOps', '部署和运维相关文章');
```

## Netlify部署

### 自动部署
1. 将代码推送到GitHub仓库
2. 登录 [Netlify](https://netlify.com)
3. 连接GitHub仓库
4. 配置构建设置：
   - Build Command: `npm run build`
   - Publish Directory: `dist`

### 环境变量配置
在Netlify的Environment Variables中设置：
- `VITE_SUPABASE_URL`: 你的Supabase项目URL
- `VITE_SUPABASE_ANON_KEY`: 你的Supabase anon key

## 项目结构

```
src/
├── components/          # 可复用组件
├── views/              # 页面组件
│   ├── Home.vue        # 首页
│   ├── PostDetail.vue  # 文章详情页
│   └── About.vue       # 关于页面
├── router/             # 路由配置
├── supabase.js         # Supabase配置
├── style.css           # 全局样式
├── main.js             # 入口文件
└── App.vue             # 根组件
```

## 开发计划

- [ ] 用户认证系统
- [ ] 文章搜索功能
- [ ] 标签系统
- [ ] 文章点赞功能
- [ ] 管理员后台
- [ ] 数据统计面板

## 贡献指南

欢迎提交Issue和Pull Request来改进这个项目！

## 许可证

MIT License

## 联系方式

如有问题或建议，欢迎联系项目维护者。