# Footer 样式文档

## HTML 结构

```html
<footer class="footer">
    <p>Copyright © 2025 <a href="https://website.gw124.top" target="_blank">WEBSITE.GW124.TOP</a> • Powered by <a href="https://gw124.top/" target="_blank">Wen</a></p>
</footer>
```

## CSS 样式

### 基础样式

```css
/* 页脚容器 */
.footer {
    text-align: center;
    padding: 24px;
    margin-top: 32px;
    color: #000000;
    font-size: 0.85rem;
}

/* 页脚链接基础样式 */
.footer a {
    color: inherit;
    text-decoration: none;
    position: relative;
    transition: color 0.2s ease;
    font-weight: 600;
}

/* 下划线动画效果 */
.footer a::after {
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

/* 悬停时下划线扩张 */
.footer a:hover::after {
    width: 100%;
}
```

### 深色模式样式

```css
/* 深色模式下的页脚 */
.dark-mode .footer {
    color: #ffffff;
}
```

## 样式说明

### 文字内容
- **格式**：`Copyright © 2025 WEBSITE.GW124.TOP • Powered by Wen`
- **包含**：Copyright 文字、版权符号、年份、网站链接、作者信息

### 颜色
- **浅色模式**：`#000000`
- **深色模式**：`#ffffff`
- **链接颜色**：继承父元素

### 字体
- **大小**：`0.85rem`
- **权重**：链接 `font-weight: 600`
- **对齐**：`text-align: center`

### 下划线动画
- **方式**：`::after` 伪元素
- **位置**：`bottom: -2px`
- **高度**：`1px`
- **颜色**：`currentColor`
- **过渡**：`transition: all 0.3s ease`
- **效果**：从中心向两侧扩张

### 布局
- **内边距**：`padding: 24px`
- **外边距**：`margin-top: 32px`
- **定位**：`position: relative`

## 完整示例

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Website Panel</title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: #f0f2f5;
            margin: 0;
            padding: 0;
        }
        
        .footer {
            text-align: center;
            padding: 24px;
            margin-top: 32px;
            color: #000000;
            font-size: 0.85rem;
        }
        
        .footer a {
            color: inherit;
            text-decoration: none;
            position: relative;
            transition: color 0.2s ease;
            font-weight: 600;
        }
        
        .footer a::after {
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
        
        .footer a:hover::after {
            width: 100%;
        }
        
        .dark-mode .footer {
            color: #ffffff;
        }
    </style>
</head>
<body>
    <footer class="footer">
        <p>Copyright © 2025 <a href="https://website.gw124.top" target="_blank">WEBSITE.GW124.TOP</a> • Powered by <a href="https://gw124.top/" target="_blank">Wen</a></p>
    </footer>
</body>
</html>
```

## 使用说明

1. **HTML 结构**：将 HTML 结构放入页面底部
2. **CSS 样式**：将 CSS 样式加入样式表
3. **深色模式**：需要 `.dark-mode` 类
4. **链接行为**：链接在新窗口打开（`target="_blank"`）

## 自定义

- **颜色**：修改 `color`
- **字体大小**：修改 `font-size`
- **动画时长**：修改 `transition`
- **下划线高度**：修改 `height`
- **文字内容**：修改 HTML 中的文本

## 更新内容

- ✅ 添加 "Copyright" 文字
- ✅ 完整格式：`Copyright © 2025 WEBSITE.GW124.TOP • Powered by Wen`
- ✅ 保留原有样式与动画
- ✅ 支持深色模式
- ✅ 链接加粗突出
- ✅ 下划线动画效果

## 文件信息

- **文件名**：`footer-documentation.md`
- **创建时间**：2025年
- **版本**：1.0
- **作者**：Wen
- **项目**：Website Panel
