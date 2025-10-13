# Footer 分割线样式文档

## 概述
本文档包含了各种 footer 分割线的 CSS 和 HTML 实现方式，适用于不同场景和设计需求。

## 1. 基础分割线样式

### 1.1 完整宽度分割线
```css
.footer-divider {
  border-top: 1px solid #e5e5e5;
  margin: 24px 0;
}
```

```html
<div class="footer-divider"></div>
```

### 1.2 居中固定宽度分割线
```css
.footer-divider {
  width: 85%;
  height: 1px;
  background: #e5e5e5;
  margin: 24px auto;
}
```

```html
<div class="footer-divider"></div>
```

## 2. 渐变分割线样式

### 2.1 两端渐变分割线（当前使用）
```css
.footer-divider {
  position: relative;
  padding: 24px 0;
}

.footer-divider::before {
  content: '';
  position: absolute;
  top: 0;
  left: 50%;
  transform: translateX(-50%);
  width: 85%;
  height: 1px;
  background: linear-gradient(to right, transparent 0%, #e5e5e5 20%, #e5e5e5 80%, transparent 100%);
}
```

```html
<div class="footer-divider">
  <!-- footer 内容 -->
</div>
```

### 2.2 中间渐变分割线
```css
.footer-divider {
  width: 85%;
  height: 1px;
  background: linear-gradient(to right, #e5e5e5 0%, transparent 50%, #e5e5e5 100%);
  margin: 24px auto;
}
```

### 2.3 多色渐变分割线
```css
.footer-divider {
  width: 85%;
  height: 2px;
  background: linear-gradient(to right, transparent 0%, #e5e5e5 25%, #d0d0d0 50%, #e5e5e5 75%, transparent 100%);
  margin: 24px auto;
}
```

## 3. 虚线分割线样式

### 3.1 基础虚线
```css
.footer-divider {
  border-top: 1px dashed #e5e5e5;
  margin: 24px 0;
}
```

### 3.2 居中虚线
```css
.footer-divider {
  width: 85%;
  border-top: 1px dashed #e5e5e5;
  margin: 24px auto;
}
```

### 3.3 自定义虚线样式
```css
.footer-divider {
  width: 85%;
  height: 1px;
  background: repeating-linear-gradient(to right, #e5e5e5 0px, #e5e5e5 10px, transparent 10px, transparent 20px);
  margin: 24px auto;
}
```

## 4. 点状分割线样式

### 4.1 基础点状线
```css
.footer-divider {
  width: 85%;
  height: 1px;
  background: repeating-linear-gradient(to right, #e5e5e5 0px, #e5e5e5 2px, transparent 2px, transparent 8px);
  margin: 24px auto;
}
```

### 4.2 圆形点状线
```css
.footer-divider {
  width: 85%;
  height: 20px;
  background: radial-gradient(circle, #e5e5e5 1px, transparent 1px);
  background-size: 20px 20px;
  background-position: 0 10px;
  margin: 24px auto;
}
```

## 5. 阴影分割线样式

### 5.1 内阴影分割线
```css
.footer-divider {
  width: 85%;
  height: 1px;
  background: #e5e5e5;
  box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1);
  margin: 24px auto;
}
```

### 5.2 外阴影分割线
```css
.footer-divider {
  width: 85%;
  height: 1px;
  background: #e5e5e5;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  margin: 24px auto;
}
```

## 6. 动画分割线样式

### 6.1 渐变动画分割线
```css
.footer-divider {
  width: 85%;
  height: 2px;
  background: linear-gradient(90deg, transparent, #e5e5e5, transparent);
  background-size: 200% 100%;
  animation: shimmer 2s infinite;
  margin: 24px auto;
}

@keyframes shimmer {
  0% { background-position: -200% 0; }
  100% { background-position: 200% 0; }
}
```

### 6.2 脉冲动画分割线
```css
.footer-divider {
  width: 85%;
  height: 1px;
  background: #e5e5e5;
  animation: pulse 2s infinite;
  margin: 24px auto;
}

@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.5; }
}
```

## 7. 深色模式适配

### 7.1 基础深色模式
```css
.footer-divider {
  border-top: 1px solid #e5e5e5;
  margin: 24px 0;
}

.dark-mode .footer-divider {
  border-top-color: #404040;
}
```

### 7.2 渐变深色模式
```css
.footer-divider::before {
  background: linear-gradient(to right, transparent 0%, #e5e5e5 20%, #e5e5e5 80%, transparent 100%);
}

.dark-mode .footer-divider::before {
  background: linear-gradient(to right, transparent 0%, #404040 20%, #404040 80%, transparent 100%);
}
```

## 8. 响应式分割线

### 8.1 移动端适配
```css
.footer-divider {
  width: 85%;
  height: 1px;
  background: #e5e5e5;
  margin: 24px auto;
}

@media (max-width: 768px) {
  .footer-divider {
    width: 90%;
    margin: 16px auto;
  }
}

@media (max-width: 480px) {
  .footer-divider {
    width: 95%;
    margin: 12px auto;
  }
}
```

## 9. 当前项目使用的样式

### 9.1 Vue 3 组件样式
```vue
<template>
  <footer class="app-footer">
    <div class="footer-content">
      <!-- footer 内容 -->
    </div>
  </footer>
</template>

<style scoped>
.app-footer {
  background: transparent;
  padding: 24px 0;
  margin-top: auto;
  position: relative;
}

.app-footer::before {
  content: '';
  position: absolute;
  top: 0;
  left: 50%;
  transform: translateX(-50%);
  width: 85%;
  height: 1px;
  background: linear-gradient(to right, transparent 0%, #e5e5e5 20%, #e5e5e5 80%, transparent 100%);
}

.footer-content {
  max-width: 80vw;
  margin: 0 auto;
  padding: 0 24px;
  text-align: center;
  font-size: 0.85rem;
}

/* 深色模式 */
:global(.dark-mode) .app-footer {
  background: transparent;
}

:global(.dark-mode) .app-footer::before {
  background: linear-gradient(to right, transparent 0%, #404040 20%, #404040 80%, transparent 100%);
}
</style>
```

## 10. 使用建议

### 10.1 选择原则
- **简洁设计**：使用基础分割线或渐变分割线
- **现代设计**：使用渐变或动画分割线
- **传统设计**：使用虚线或点状分割线
- **移动端**：考虑响应式设计和触摸友好性

### 10.2 颜色搭配
- **浅色背景**：使用 `#e5e5e5` 或 `#d0d0d0`
- **深色背景**：使用 `#404040` 或 `#606060`
- **彩色背景**：使用对比度较高的颜色

### 10.3 性能考虑
- 避免使用复杂的动画效果
- 使用 CSS 渐变而非图片
- 考虑浏览器兼容性

## 11. 浏览器兼容性

| 样式类型 | Chrome | Firefox | Safari | Edge |
|---------|--------|---------|--------|------|
| 基础分割线 | ✅ | ✅ | ✅ | ✅ |
| 渐变分割线 | ✅ | ✅ | ✅ | ✅ |
| 虚线分割线 | ✅ | ✅ | ✅ | ✅ |
| 动画分割线 | ✅ | ✅ | ✅ | ✅ |

## 12. 总结

本文档提供了多种 footer 分割线的实现方式，从基础的实线到复杂的动画效果。根据项目需求选择合适的样式，并考虑深色模式和响应式设计。

当前项目使用的是两端渐变的透明分割线，既美观又不会过于抢眼，适合现代网页设计。
