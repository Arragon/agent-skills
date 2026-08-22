# Agent Skills

面向 Codex、Claude Code、Cursor 及兼容 Agent Skills 标准的个人 Skill 仓库。

仓库只在 `skills/` 中维护一份权威 Skill 源文件。安装脚本根据目标工具把 Skill 复制到其用户级或项目级目录，避免为不同 IDE 长期维护多份容易漂移的副本。

## 已收录 Skill

| Skill | 用途 |
| --- | --- |
| `write-architecture-roadmap` | 将产品想法、既有讨论、代码审查或整改结论收敛为两个独立但双向追踪的 Markdown 文件：技术架构设计书与开发路线图。 |

## 仓库结构

```text
agent-skills/
├── skills/                         # Skill 唯一权威源
│   └── write-architecture-roadmap/
│       ├── SKILL.md
│       ├── agents/                 # OpenAI 产品界面元数据
│       ├── assets/
│       └── references/
├── scripts/
│   ├── install.sh                  # macOS / Linux 安装器
│   ├── install.ps1                 # Windows PowerShell 安装器
│   └── validate_skills.py          # 结构与引用校验
├── .github/workflows/validate.yml
├── AGENTS.md
└── skills.json                     # 机器可读 Skill 索引
```

## 快速安装

先克隆仓库：

```bash
git clone https://github.com/Arragon/agent-skills.git
cd agent-skills
```

macOS 或 Linux 用户级安装：

```bash
bash scripts/install.sh
```

Windows PowerShell 用户级安装：

```powershell
.\scripts\install.ps1
```

默认的 `all` 目标会安装到 `~/.agents/skills/` 和 `~/.claude/skills/`。Codex 从前者读取，Claude Code 从后者读取，Cursor 同时兼容 `.agents/skills/`，因此无需再生成一份 Cursor 副本。

只为某个工具安装：

```bash
bash scripts/install.sh --target codex
bash scripts/install.sh --target claude
bash scripts/install.sh --target cursor
```

```powershell
.\scripts\install.ps1 -Target codex
.\scripts\install.ps1 -Target claude
.\scripts\install.ps1 -Target cursor
```

`cursor` 目标会显式安装到 `~/.cursor/skills/`。一般情况下使用默认 `all` 即可。

安装到某个项目：

```bash
bash scripts/install.sh --scope project --project-dir /path/to/project
```

```powershell
.\scripts\install.ps1 -SkillScope project -ProjectDir C:\path\to\project
```

只安装指定 Skill 时，把名称放在命令末尾：

```bash
bash scripts/install.sh write-architecture-roadmap
```

再次运行安装器会先把旧版本重命名为带时间戳的备份，再安装新版本。更新仓库后执行 `git pull` 并重新运行安装器即可。

Cursor 也支持从 GitHub URL 导入远程 Skill；仓库保持标准 `SKILL.md`、`scripts/`、`references/`、`assets/` 结构，便于直接识别。

## 校验

本地执行：

```bash
python scripts/validate_skills.py
```

每次推送和 Pull Request 也会自动运行相同检查，验证 Skill 文件夹名称、YAML frontmatter、`skills.json` 索引以及本地 Markdown 引用。

## 添加新 Skill

把新 Skill 放入 `skills/<skill-name>/`，确保 `SKILL.md` 中的 `name` 与目录名完全一致，并在 `skills.json` 中登记。提交前运行校验脚本。

本仓库使用 MIT 许可证。
