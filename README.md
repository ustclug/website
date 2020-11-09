# LUG @ USTC 新版网站

**前方施工**

## 添加与修改页面

本网站采用 [Minimal Mistakes 主题](https://mmistakes.github.io/minimal-mistakes/)，各自定义项目参见主题的文档。

添加新页面（Wiki / News / Planet）请分别在 `pages/_wiki`，`pages/_news`，`pages/_planet` 中参考 `_template.md`。

请将图片上传至 [website-static 仓库](https://github.com/ustclug/website-static)，并使用如下格式引用：

```markdown
![图片的 alt 文字]({{ site.static_url }}/path/to/image.jpg)
```

## 本地预览与构建

1. 安装 Ruby 开发环境（略）
2. 运行 `bundle install --path=vendor/bundle` 以安装依赖的软件包
3. 运行 `bundle exec jekyll serve`，此时即可在 <http://localhost:4000/> 预览网站
4. 编译整个网站的命令为

   ```shell
   bundle exec jekyll build
   ```

   在命令行末尾添加 `--profile` 可以查看编译性能分析（每个源文件耗时），添加 `--trace` 可以在出错时输出 stack trace

   正式部署时需要添加环境变量 `JEKYLL_ENV=production`，详情请见 GitHub Actions 的 workflow 配置

## 许可

本仓库及本网站以 [CC BY-NC-SA 4.0](LICENSE.md) 许可协议开源。
