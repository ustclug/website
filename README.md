# LUG @ USTC 新版网站

**前方施工**

## 本地预览与构建

1. 安装 Ruby 开发环境（略）
2. 运行 `bundle install --path=vendor/bundle`
3. 如果需要预览，运行 `bundle exec jekyll serve`，此时即可在 <http://localhost:4000/> 预览网站
4. 正式构建的命令为

    ```shell
    JEKYLL_ENV=production bundle exec jekyll build
    ```

    在命令行末尾添加 `--profile` 可以查看编译性能分析（每个源文件耗时），添加 `--trace` 可以在出错时输出 stack trace

## 许可

本仓库以 [CC BY-NC-SA 4.0](LICENSE.md) 许可协议开源。
