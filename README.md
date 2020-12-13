# LUG @ USTC 新版网站

中国科学技术大学 Linux 用户协会的官方网站。（于 2020 年 8 月启用，所以称为“新版”）

本仓库为源代码，所有推送到 master 分支的修改会使用 GitHub Actions 自动编译和部署。

## 添加与修改页面

本网站采用 [Minimal Mistakes 主题](https://mmistakes.github.io/minimal-mistakes/)，各自定义项目参见主题的文档。

添加新页面（Wiki / News / Planet）请分别在 `pages/_wiki`，`pages/_news`，`pages/_planet` 中参考 `_template.md`。

设置文章作者请在 [`_data/authors.yml`](_data/authors.yml) 中添加作者信息（参考已有内容），然后在页面中指定 `author: key`（只支持一个作者）。

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

## Markdown 格式化

请在提交前使用 `prettier` 进行格式化。

1. 安装 Node.js 开发环境（略）
2. 运行 `npm install` 以安装 prettier
3. 使用 `npm run fix` 自动格式化。可以将不希望 prettier 处理的文件加入 `.prettierignore`，未来可能会加上 YAML 和 SCSS 格式文件的处理
4. 使用 `npm run check` 验证格式无问题

## 许可

本仓库及本网站以 [CC BY-NC-SA 4.0](LICENSE.md) 许可协议开源。
