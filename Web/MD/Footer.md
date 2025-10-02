## Footer 模块（HTML + CSS）

以下为本项目页脚的独立文档与可复用代码。

### 现用实现（代码引用，纯文本样式）

HTML 结构：

        <!-- 页脚 -->
        <footer class="footer">
            <div class="footer-line">© 2020 <a href="https://icons.gw124.top/" target="_blank" rel="noopener noreferrer" class="link-green">ICONS.GW124.TOP</a>｜By <a href="https://gw124.top/" target="_blank" rel="noopener noreferrer" class="link-green">Wen</a></div>
        </footer>

```

样式（SCSS，纯文本样式，无背景/边框/毛玻璃）：

.footer {
    margin-top: auto;
    padding: 1.5rem;
    text-align: center;

    // 字体与排版
    font-family: -apple-system, BlinkMacSystemFont, "SF Pro SC", "PingFang SC", "Segoe UI", Roboto, "Helvetica Neue", "Noto Sans SC", "Microsoft YaHei", Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    font-weight: 500;
    letter-spacing: 0.2px;

    .footer-line {
        color: #94a3b8;
        font-size: 0.9rem;
        margin: 0;
        letter-spacing: 0.5px;
        line-height: 1.5;
        font-feature-settings: "liga", "kern";
        text-shadow: 0 1px 0 rgba(255, 255, 255, 0.5);
    }

    .link-green {
        color: #94a3b8;
        text-decoration: none;
        transition: color 0.2s ease;
        font-weight: 600;
        text-underline-offset: 2px;
        position: relative;

        &::after {
            content: "";
            position: absolute;
            left: 0;
            right: 0;
            bottom: -2px;
            height: 2px;
            background-color: currentColor;
            transform: scaleX(0);
            transform-origin: center;
            transition: transform 0.25s ease;
            border-radius: 2px;
        }

        &:hover {
            color: #94a3b8;
            &::after { transform: scaleX(1); }
        }

        &:visited { color: #94a3b8; }
    }

    .footer-line .link-green:first-of-type {
        color: #94a3b8;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.4px;
    }
    .footer-line .link-green:first-of-type:hover { color: #94a3b8; }

    .footer-line .link-green:last-of-type {
        color: #94a3b8;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.4px;
    }
    .footer-line .link-green:last-of-type:hover { color: #94a3b8; }
}
```

### 可独立拷贝的纯 HTML/CSS 版本（仅文字样式）

```html
<footer class="footer">
  <div class="footer-line">© 2020 <a href="https://icons.gw124.top/" target="_blank" rel="noopener noreferrer" class="link-green">ICONS.GW124.TOP</a>｜By <a href="https://gw124.top/" target="_blank" rel="noopener noreferrer" class="link-green">Wen</a></div>
  <style>
    .footer {
      margin-top: auto;
      padding: 1.5rem;
      text-align: center;
      font-family: -apple-system, BlinkMacSystemFont, "SF Pro SC", "PingFang SC", "Segoe UI", Roboto, "Helvetica Neue", "Noto Sans SC", "Microsoft YaHei", Arial, sans-serif;
      -webkit-font-smoothing: antialiased;
      -moz-osx-font-smoothing: grayscale;
      font-weight: 500;
      letter-spacing: 0.2px;
      position: relative;
    }
    .footer .footer-line {
      color: #94a3b8;
      font-size: 0.9rem;
      margin: 0;
      letter-spacing: 0.5px;
      line-height: 1.5;
      text-shadow: 0 1px 0 rgba(255, 255, 255, 0.5);
    }
    .footer .link-green {
      color: #94a3b8;
      text-decoration: none;
      transition: color .2s ease;
      font-weight: 500;
      text-underline-offset: 2px;
      position: relative;
    }
    .footer .link-green::after {
      content: "";
      position: absolute;
      left: 0; right: 0; bottom: -1px;
      height: 1px; border-radius: 2px;
      background-color: currentColor;
      transform: scaleX(0);
      transform-origin: center;
      transition: transform .25s ease;
    }
    .footer .link-green:hover::after { transform: scaleX(1); }
    .footer .link-green:first-of-type,
    .footer .link-green:last-of-type {
      font-weight: 600; text-transform: uppercase; letter-spacing: .4px;
    }
  </style>
  <!-- 提示：仅包含文字相关样式，无背景/边框/毛玻璃 -->
  </footer>
```


