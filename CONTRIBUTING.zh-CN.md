# 贡献说明

感谢你一起完善这个仓库。

## 基本原则

- 面向新手的文档要尽量好读
- 与其放空壳，不如放实用的 starter 资源
- skill 要保持精炼、可搜索
- 插件清单和 manifest 要保持清晰、容易改造

## 仓库约定

- `skills/` 用来放 skills
- `plugins/` 用来放 plugins
- `.agents/plugins/` 用来放仓库级 marketplace 元数据
- `assets/` 用来放共享视觉资源

## 修改 Skill 时

- `SKILL.md` 重点写清“什么时候用”和“怎么执行”
- 条件允许时先做结构校验再发布
- 只有在确实能减少重复或提升稳定性时再加 references

## 修改 Plugin 时

- 保留 `.codex-plugin/plugin.json`
- 路径统一使用以 `./` 开头的相对路径
- starter 模板要易于 fork，不要过度定制化

## Pull Request 建议

- 说明改了什么
- 标明主要影响 skills、plugins、docs 还是页面展示
- 如果 README 视觉变化比较明显，建议附截图
