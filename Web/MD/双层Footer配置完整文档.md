# Footer 配置完整文档

> 适用于各种网站项目的 Footer 配置和实现代码
> 
> 创建时间：2025-10-14

---

## 📋 目录

1. [配置概览](#配置概览)
2. [配置文件](#配置文件)
3. [Vue.js 实现](#vuejs-实现)
4. [React 实现](#react-实现)
5. [纯 HTML + CSS 实现](#纯-html--css-实现)
6. [字体配置](#字体配置)
7. [响应式设计](#响应式设计)

---

## 配置概览

### Footer 结构
- **第一行**：版权信息 + 网站链接 + 作者链接
- **第二行**：社交媒体/联系方式链接（可选）
- **分割线**：渐变分割线
- **自适应颜色**：根据背景自动切换黑白文字

### 配置特点
- ✅ 统一配置源（`public/footer-links.json`）
- ✅ 支持 Font Awesome 图标
- ✅ 自定义字体（中英文分离）
- ✅ 响应式设计
- ✅ 悬停动画效果

---

## 配置文件

### 1. Footer 链接配置 (`public/footer-links.json`)

```json
{
  "links": [
    {
      "name": "Github",
      "icon": "fa-github",
      "url": "https://github.com/GWen124"
    },
    {
      "name": "Blog",
      "icon": "fa-rss",
      "url": "https://blog.gw124.top/"
    },
    {
      "name": "Email",
      "icon": "fa-envelope",
      "url": "mailto:9708281@gmail.com"
    },
    {
      "name": "Telegram",
      "icon": "fa-paper-plane",
      "url": "https://t.me/WenGe124_Bot"
    }
  ]
}
```

### 2. 主配置文件 (`config.yml`)

```yaml
# Footer 信息配置
footer:
  websiteText: "WEBSITE.GW124.TOP"
  websiteUrl: "https://website.gw124.top/"
  
  # 第二行链接配置
  secondLine:
    enabled: true
    # 所有链接配置在 public/footer-links.json 中管理

# 版权信息配置
copyright:
  startDate: "2025-10-01"
  autoRange: true  # 自动计算年份范围

# Footer 字体配置
fonts:
  footer:
    fontA: "fonts/brand.ttf"  # 中文字体
    fontB: ""  # 英文字体
    size: "14px"
    weight: "400"
    
    # 第二行链接字体
    secondLine:
      size: "16px"
      weight: "400"

# 颜色配置
colors:
  autoColor: true  # 自动根据背景切换黑白
  manual:
    footer: "#000000"  # 手动设置颜色（autoColor: false 时生效）
```

---

## Vue.js 实现

### 1. 模板部分

```vue
<template>
  <footer class="app-footer">
    <div class="footer-content">
      <!-- 第一行：版权信息 -->
      <div class="footer-first-line">
        Copyright © {{ copyrightYear }} 
        <a :href="config.footer.websiteUrl" target="_blank" class="footer-link">
          {{ config.footer.websiteText }}
        </a> 
        • Powered by 
        <a :href="config.footer.authorUrl" target="_blank" class="footer-link">
          {{ config.footer.authorText }}
        </a>
      </div>
      
      <!-- 第二行：社交链接 -->
      <div v-if="config.footer.secondLine?.enabled && footerLinks" class="footer-second-line">
        <a 
          v-for="link in footerLinks" 
          :key="link.name"
          :href="link.url" 
          target="_blank" 
          class="footer-link"
          :title="link.name"
        >
          <i :class="`fa ${link.icon}`" class="footer-icon"></i>
          {{ link.name }}
        </a>
      </div>
    </div>
  </footer>
</template>
```

### 2. 脚本部分

```vue
<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'

interface FooterLink {
  name: string
  icon: string
  url: string
}

// 配置
const config = ref({
  footer: {
    websiteText: 'WEBSITE.GW124.TOP',
    websiteUrl: 'https://website.gw124.top/',
    authorText: 'Wen',
    authorUrl: 'https://gw124.top/',
    secondLine: {
      enabled: true
    }
  },
  copyright: {
    startDate: '2025-10-01',
    autoRange: true
  }
})

// Footer 链接
const footerLinks = ref<FooterLink[]>([])

// 加载 Footer 链接
onMounted(async () => {
  try {
    const response = await fetch('./footer-links.json')
    if (response.ok) {
      const data = await response.json()
      footerLinks.value = data.links
    }
  } catch (error) {
    console.error('加载 footer 链接失败:', error)
  }
})

// 计算版权年份
const copyrightYear = computed(() => {
  const startYear = new Date(config.value.copyright.startDate).getFullYear()
  const currentYear = new Date().getFullYear()
  
  if (config.value.copyright.autoRange && startYear < currentYear) {
    return `${startYear}-${currentYear}`
  }
  return startYear.toString()
})
</script>
```

### 3. 样式部分

```vue
<style scoped>
.app-footer {
  background: transparent;
  padding: 8px 0;
  margin-top: auto;
  position: relative;
}

/* 分割线 */
.app-footer::before {
  content: '';
  position: absolute;
  top: 0;
  left: 50%;
  transform: translateX(-50%);
  width: 85%;
  height: 1px;
  background: linear-gradient(
    to right, 
    transparent 0%, 
    var(--footer-color, #000000) 20%, 
    var(--footer-color, #000000) 80%, 
    transparent 100%
  );
}

.footer-content {
  max-width: 80vw;
  margin: 0 auto;
  padding: 0 24px;
  text-align: center;
  color: var(--footer-color, #000000);
  font-family: var(--footer-font-family, inherit);
  font-size: var(--footer-font-size, 14px);
  font-weight: var(--footer-font-weight, 400);
}

.footer-first-line {
  margin-bottom: 1px;
}

.footer-second-line {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 32px;
  flex-wrap: wrap;
}

/* 第二行链接使用独立字体大小 */
.footer-second-line .footer-link {
  font-size: 16px !important;
  font-weight: 400 !important;
}

.footer-link {
  color: var(--footer-color, #000000);
  text-decoration: none;
  position: relative;
  transition: color 0.2s ease;
  font-weight: 600;
}

/* 悬停下划线动画 */
.footer-link::after {
  content: '';
  position: absolute;
  bottom: -2px;
  left: 50%;
  width: 0;
  height: 1px;
  background-color: currentColor;
  transition: all 0.3s ease;
  transform: translateX(-50%);
}

.footer-link:hover::after {
  width: 100%;
}

/* 图标样式 */
.footer-icon {
  font-size: 14px;
  width: 14px;
  height: 14px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  margin-right: 4px;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .footer-content {
    padding: 0 16px;
  }
  
  .footer-second-line {
    gap: 20px;
  }
  
  .footer-second-line .footer-link {
    font-size: 14px !important;
  }
  
  .footer-icon {
    font-size: 12px;
    width: 12px;
    height: 12px;
  }
}

@media (max-width: 480px) {
  .footer-second-line {
    gap: 16px;
  }
  
  .footer-second-line .footer-link {
    font-size: 12px !important;
  }
  
  .footer-icon {
    font-size: 11px;
    width: 11px;
    height: 11px;
  }
}
</style>
```

---

## React 实现

### 1. 组件代码

```tsx
import React, { useState, useEffect, useMemo } from 'react';
import './Footer.css';

interface FooterLink {
  name: string;
  icon: string;
  url: string;
}

interface FooterProps {
  websiteText?: string;
  websiteUrl?: string;
  authorText?: string;
  authorUrl?: string;
  copyrightStartDate?: string;
  autoRange?: boolean;
  showSecondLine?: boolean;
}

const Footer: React.FC<FooterProps> = ({
  websiteText = 'WEBSITE.GW124.TOP',
  websiteUrl = 'https://website.gw124.top/',
  authorText = 'Wen',
  authorUrl = 'https://gw124.top/',
  copyrightStartDate = '2025-10-01',
  autoRange = true,
  showSecondLine = true,
}) => {
  const [footerLinks, setFooterLinks] = useState<FooterLink[]>([]);

  // 加载 Footer 链接
  useEffect(() => {
    const loadFooterLinks = async () => {
      try {
        const response = await fetch('./footer-links.json');
        if (response.ok) {
          const data = await response.json();
          setFooterLinks(data.links);
        }
      } catch (error) {
        console.error('加载 footer 链接失败:', error);
      }
    };

    loadFooterLinks();
  }, []);

  // 计算版权年份
  const copyrightYear = useMemo(() => {
    const startYear = new Date(copyrightStartDate).getFullYear();
    const currentYear = new Date().getFullYear();

    if (autoRange && startYear < currentYear) {
      return `${startYear}-${currentYear}`;
    }
    return startYear.toString();
  }, [copyrightStartDate, autoRange]);

  return (
    <footer className="app-footer">
      <div className="footer-content">
        {/* 第一行：版权信息 */}
        <div className="footer-first-line">
          Copyright © {copyrightYear}{' '}
          <a href={websiteUrl} target="_blank" rel="noopener noreferrer" className="footer-link">
            {websiteText}
          </a>{' '}
          • Powered by{' '}
          <a href={authorUrl} target="_blank" rel="noopener noreferrer" className="footer-link">
            {authorText}
          </a>
        </div>

        {/* 第二行：社交链接 */}
        {showSecondLine && footerLinks.length > 0 && (
          <div className="footer-second-line">
            {footerLinks.map((link) => (
              <a
                key={link.name}
                href={link.url}
                target="_blank"
                rel="noopener noreferrer"
                className="footer-link"
                title={link.name}
              >
                <i className={`fa ${link.icon} footer-icon`}></i>
                {link.name}
              </a>
            ))}
          </div>
        )}
      </div>
    </footer>
  );
};

export default Footer;
```

### 2. 使用示例

```tsx
import Footer from './components/Footer';

function App() {
  return (
    <div className="app">
      {/* 其他内容 */}
      
      <Footer
        websiteText="WEBSITE.GW124.TOP"
        websiteUrl="https://website.gw124.top/"
        authorText="Wen"
        authorUrl="https://gw124.top/"
        copyrightStartDate="2025-10-01"
        autoRange={true}
        showSecondLine={true}
      />
    </div>
  );
}
```

---

## 纯 HTML + CSS 实现

### 1. HTML 结构

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Footer 示例</title>
  
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  
  <link rel="stylesheet" href="footer.css">
</head>
<body>
  <!-- 页面内容 -->
  
  <footer class="app-footer">
    <div class="footer-content">
      <!-- 第一行：版权信息 -->
      <div class="footer-first-line">
        Copyright © <span id="copyright-year">2025</span> 
        <a href="https://website.gw124.top/" target="_blank" class="footer-link">WEBSITE.GW124.TOP</a> 
        • Powered by 
        <a href="https://gw124.top/" target="_blank" class="footer-link">Wen</a>
      </div>
      
      <!-- 第二行：社交链接 -->
      <div class="footer-second-line" id="footer-links">
        <!-- 动态加载 -->
      </div>
    </div>
  </footer>

  <script src="footer.js"></script>
</body>
</html>
```

### 2. CSS 样式 (`footer.css`)

```css
:root {
  --footer-color: #000000;
  --footer-font-size: 14px;
  --footer-font-weight: 400;
}

.app-footer {
  background: transparent;
  padding: 8px 0;
  margin-top: auto;
  position: relative;
}

/* 分割线 */
.app-footer::before {
  content: '';
  position: absolute;
  top: 0;
  left: 50%;
  transform: translateX(-50%);
  width: 85%;
  height: 1px;
  background: linear-gradient(
    to right, 
    transparent 0%, 
    var(--footer-color) 20%, 
    var(--footer-color) 80%, 
    transparent 100%
  );
}

.footer-content {
  max-width: 80vw;
  margin: 0 auto;
  padding: 0 24px;
  text-align: center;
  color: var(--footer-color);
  font-size: var(--footer-font-size);
  font-weight: var(--footer-font-weight);
}

.footer-first-line {
  margin-bottom: 1px;
}

.footer-second-line {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 32px;
  flex-wrap: wrap;
}

.footer-second-line .footer-link {
  font-size: 16px !important;
  font-weight: 400 !important;
}

.footer-link {
  color: var(--footer-color);
  text-decoration: none;
  position: relative;
  transition: color 0.2s ease;
  font-weight: 600;
}

.footer-link::after {
  content: '';
  position: absolute;
  bottom: -2px;
  left: 50%;
  width: 0;
  height: 1px;
  background-color: currentColor;
  transition: all 0.3s ease;
  transform: translateX(-50%);
}

.footer-link:hover::after {
  width: 100%;
}

.footer-icon {
  font-size: 14px;
  width: 14px;
  height: 14px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  margin-right: 4px;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .footer-content {
    padding: 0 16px;
  }
  
  .footer-second-line {
    gap: 20px;
  }
  
  .footer-second-line .footer-link {
    font-size: 14px !important;
  }
  
  .footer-icon {
    font-size: 12px;
    width: 12px;
    height: 12px;
  }
}

@media (max-width: 480px) {
  .footer-second-line {
    gap: 16px;
  }
  
  .footer-second-line .footer-link {
    font-size: 12px !important;
  }
  
  .footer-icon {
    font-size: 11px;
    width: 11px;
    height: 11px;
  }
}
```

### 3. JavaScript 逻辑 (`footer.js`)

```javascript
// 配置
const config = {
  copyright: {
    startDate: '2025-10-01',
    autoRange: true
  }
};

// 计算版权年份
function calculateCopyrightYear() {
  const startYear = new Date(config.copyright.startDate).getFullYear();
  const currentYear = new Date().getFullYear();
  
  if (config.copyright.autoRange && startYear < currentYear) {
    return `${startYear}-${currentYear}`;
  }
  return startYear.toString();
}

// 更新版权年份
document.addEventListener('DOMContentLoaded', () => {
  const yearElement = document.getElementById('copyright-year');
  if (yearElement) {
    yearElement.textContent = calculateCopyrightYear();
  }
  
  // 加载 Footer 链接
  loadFooterLinks();
});

// 加载 Footer 链接
async function loadFooterLinks() {
  try {
    const response = await fetch('./footer-links.json');
    if (!response.ok) {
      throw new Error('加载失败');
    }
    
    const data = await response.json();
    const container = document.getElementById('footer-links');
    
    if (!container) return;
    
    data.links.forEach(link => {
      const a = document.createElement('a');
      a.href = link.url;
      a.target = '_blank';
      a.className = 'footer-link';
      a.title = link.name;
      
      const icon = document.createElement('i');
      icon.className = `fa ${link.icon} footer-icon`;
      
      a.appendChild(icon);
      a.appendChild(document.createTextNode(link.name));
      
      container.appendChild(a);
    });
  } catch (error) {
    console.error('加载 footer 链接失败:', error);
  }
}

// 自动检测背景亮度并切换文字颜色（可选）
function detectBackgroundBrightness() {
  const bgElement = document.querySelector('body');
  const bgColor = window.getComputedStyle(bgElement).backgroundColor;
  
  // 解析 RGB 值
  const rgb = bgColor.match(/\d+/g);
  if (!rgb) return;
  
  const [r, g, b] = rgb.map(Number);
  const brightness = (r * 299 + g * 587 + b * 114) / 1000;
  
  // 根据亮度设置文字颜色
  const textColor = brightness > 128 ? '#000000' : '#ffffff';
  document.documentElement.style.setProperty('--footer-color', textColor);
}

// 页面加载后检测背景亮度
window.addEventListener('load', () => {
  detectBackgroundBrightness();
});
```

---

## 字体配置

### 1. 字体文件结构

```
public/fonts/
├── AnJingChenXinShouJinTi.ttf    # 中文标题字体
├── brand.ttf                     # 英文数字字体
├── SanJiZhengYaHei-ZhongCu.ttf  # 中文加粗字体
└── SanJiZhengYaHei-Xi.ttf       # 中文细字体
```

### 2. CSS 字体加载

```css
/* 加载自定义字体 */
@font-face {
  font-family: 'AnJingChenXinShouJinTi';
  src: url('../fonts/AnJingChenXinShouJinTi.ttf') format('truetype');
  font-weight: normal;
  font-style: normal;
}

@font-face {
  font-family: 'Brand';
  src: url('../fonts/brand.ttf') format('truetype');
  font-weight: normal;
  font-style: normal;
}

/* 应用字体 */
.footer-content {
  font-family: 'Brand', 'AnJingChenXinShouJinTi', system-ui, sans-serif;
}
```

### 3. 动态字体加载（JavaScript）

```javascript
// 动态加载字体
function loadCustomFonts(config) {
  const fonts = config.fonts?.footer;
  if (!fonts) return;
  
  const root = document.documentElement;
  
  // 设置字体族
  if (fonts.fontA || fonts.fontB) {
    const fontFamily = [];
    if (fonts.fontB) fontFamily.push(`'${fonts.fontB}'`);
    if (fonts.fontA) fontFamily.push(`'${fonts.fontA}'`);
    fontFamily.push('system-ui', 'sans-serif');
    
    root.style.setProperty('--footer-font-family', fontFamily.join(', '));
  }
  
  // 设置字体大小
  if (fonts.size) {
    root.style.setProperty('--footer-font-size', fonts.size);
  }
  
  // 设置字体粗细
  if (fonts.weight) {
    root.style.setProperty('--footer-font-weight', fonts.weight);
  }
}
```

---

## 响应式设计

### 断点说明

| 屏幕尺寸 | 断点 | Footer 调整 |
|---------|------|------------|
| 桌面端 | > 768px | 标准布局，间距 32px |
| 平板 | ≤ 768px | 间距缩小为 20px，字体 14px |
| 手机 | ≤ 480px | 间距 16px，字体 12px |

### 响应式 CSS

```css
/* 桌面端（默认） */
.footer-second-line {
  gap: 32px;
}

.footer-second-line .footer-link {
  font-size: 16px !important;
}

/* 平板端 */
@media (max-width: 768px) {
  .footer-second-line {
    gap: 20px;
  }
  
  .footer-second-line .footer-link {
    font-size: 14px !important;
  }
}

/* 手机端 */
@media (max-width: 480px) {
  .footer-second-line {
    gap: 16px;
    flex-wrap: wrap;
  }
  
  .footer-second-line .footer-link {
    font-size: 12px !important;
  }
}
```

---

## 图标配置

### Font Awesome 图标

#### 1. 引入 Font Awesome

```html
<!-- CDN 方式 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
```

#### 2. 常用图标列表

| 名称 | 图标类名 | 用途 |
|-----|---------|------|
| GitHub | `fa-github` | GitHub 链接 |
| 博客 | `fa-rss` | 博客/RSS |
| 邮件 | `fa-envelope` | 邮箱 |
| Telegram | `fa-paper-plane` | Telegram |
| Twitter/X | `fa-twitter` 或 `fa-x-twitter` | Twitter |
| 微信 | `fa-weixin` | 微信 |
| QQ | `fa-qq` | QQ |
| 知乎 | `fa-zhihu` | 知乎 |
| 微博 | `fa-weibo` | 微博 |
| LinkedIn | `fa-linkedin` | LinkedIn |
| Instagram | `fa-instagram` | Instagram |
| YouTube | `fa-youtube` | YouTube |
| Facebook | `fa-facebook` | Facebook |

#### 3. 图标使用示例

```html
<!-- 实心图标 -->
<i class="fa fa-github"></i>

<!-- 实心图标（使用 solid） -->
<i class="fa-solid fa-envelope"></i>

<!-- 品牌图标（使用 brands） -->
<i class="fa-brands fa-github"></i>
```

---

## 自动变色功能

### 背景亮度检测

```javascript
// 检测背景亮度并自动切换文字颜色
function detectBackgroundBrightness() {
  const bgElement = document.getElementById('background') || document.querySelector('video');
  
  if (!bgElement) {
    // 没有背景元素，使用默认黑色
    setFooterColor('#000000');
    return;
  }
  
  // 创建 canvas 分析图片/视频
  const canvas = document.createElement('canvas');
  const ctx = canvas.getContext('2d');
  
  canvas.width = 100;
  canvas.height = 100;
  
  try {
    ctx.drawImage(bgElement, 0, 0, 100, 100);
    const imageData = ctx.getImageData(0, 0, 100, 100);
    const data = imageData.data;
    
    let totalBrightness = 0;
    
    // 计算平均亮度（采样）
    for (let i = 0; i < data.length; i += 16) {
      const r = data[i] || 0;
      const g = data[i + 1] || 0;
      const b = data[i + 2] || 0;
      // 使用感知亮度公式
      totalBrightness += (r * 0.299 + g * 0.587 + b * 0.114);
    }
    
    const avgBrightness = totalBrightness / (data.length / 16);
    
    // 根据亮度设置文字颜色
    const textColor = avgBrightness > 128 ? '#000000' : '#ffffff';
    setFooterColor(textColor);
  } catch (error) {
    // 分析失败，使用默认黑色
    setFooterColor('#000000');
  }
}

// 设置 Footer 颜色
function setFooterColor(color) {
  document.documentElement.style.setProperty('--footer-color', color);
}

// 定期检测背景亮度（应对视频或动态背景）
setInterval(detectBackgroundBrightness, 3000);
```

---

## 使用说明

### 快速开始

1. **复制配置文件**
   ```bash
   # 复制 footer-links.json 到项目的 public 目录
   cp footer-links.json public/
   ```

2. **引入 Font Awesome**
   ```html
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
   ```

3. **选择实现方式**
   - Vue.js：复制 Vue 组件代码
   - React：复制 React 组件代码
   - 纯 HTML：复制 HTML + CSS + JS 代码

4. **自定义配置**
   - 修改 `footer-links.json` 更改链接
   - 修改 CSS 变量调整样式
   - 修改字体配置更换字体

### 配置项说明

#### 必需配置
- `websiteText`: 网站名称
- `websiteUrl`: 网站链接
- `authorText`: 作者名称
- `authorUrl`: 作者链接

#### 可选配置
- `copyrightStartDate`: 版权起始日期
- `autoRange`: 是否自动计算年份范围
- `showSecondLine`: 是否显示第二行链接
- `footerLinks`: 社交/联系链接配置

---

## 常见问题

### 1. 图标不显示？
**解决方案**：
- 检查 Font Awesome 是否正确引入
- 确认图标类名正确（例如 `fa-github` 而不是 `github`）
- 检查网络连接（CDN 是否可访问）

### 2. 链接加载失败？
**解决方案**：
- 确认 `footer-links.json` 在正确的路径
- 检查 JSON 格式是否正确
- 查看浏览器控制台错误信息

### 3. 样式不生效？
**解决方案**：
- 检查 CSS 是否正确引入
- 确认 CSS 变量是否被其他样式覆盖
- 使用浏览器开发者工具检查元素样式

### 4. 响应式布局异常？
**解决方案**：
- 确认视口元标签正确设置
  ```html
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  ```
- 检查媒体查询断点是否合适
- 测试不同设备尺寸

---

## 更新日志

### v1.0.0 (2025-10-14)
- ✅ 初始版本
- ✅ 支持 Vue.js、React、纯 HTML 三种实现
- ✅ 完整的配置文件和样式
- ✅ 响应式设计
- ✅ 自动背景亮度检测
- ✅ Font Awesome 图标支持
- ✅ 自定义字体配置

---

## 许可证

MIT License

---

## 联系方式

- GitHub: https://github.com/GWen124
- Blog: https://blog.gw124.top/
- Email: 9708281@gmail.com
- Telegram: https://t.me/WenGe124_Bot

---

**📌 提示**：本文档包含完整的 Footer 配置和实现代码，可直接复制使用。建议根据实际项目需求进行调整和优化。

