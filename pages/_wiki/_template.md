---
---

# LUG 网站 Wiki 页面模板

复制本文件至你想要的路径（注意应当在 `_wiki` 目录树中），使用 Markdown 内容替换掉本说明文字即可。当你将复制的文件命名为 `some/path/name.md` 的时候，它将自动渲染为 `/wiki/some/path/name/` 页面。格式样例请参考附近的其他文件。

本网站使用了 [jekyll-titles-from-headings][1] 插件，页面标题将自动使用开头的 H1，因此 Front Matter 后面必须紧跟页面标题且使用 H1 标题。

由于上游软件的一些 bug，若你将本文件复制为 `some/path/index.md` ，最终的 URL 并不是 `/wiki/some/path/` ，而是 `/wiki/some/path/index/` ，此时你可以在文件顶部的 Front Matter 中指定 `permalink` 参数，例如：

``` yaml
---
permalink: /wiki/some/path/
---
```

除此之外你不需要填写 Front Matter。

左侧导航栏在 Git 仓库目录下的 `_data/navigation.yml` 文件中查看与修改。

  [1]: https://github.com/benbalter/jekyll-titles-from-headings
