# Contributing to extractfiles

Thanks for your interest in contributing to **extractfiles**! This project welcomes ideas, improvements, and pull requests.

---

## 💡 General Guidelines

- Fork this repository and create a feature branch from `develop`
- All contributions must target the `develop` branch
- Use GitFlow: feature branches must be named `feature/<name>`, bugfixes as `fix/<name>`, etc.
- Pull requests must be written in **English** — including commit messages, code comments, and descriptions
- Your changes should follow the existing code and formatting style

---

## 🛠 Branching Strategy

We use a GitFlow-inspired model:

| Branch       | Purpose                                 |
|--------------|-----------------------------------------|
| `main`       | Production-ready English version        |
| `main-es`         | Production-ready Spanish version        |
| `develop`    | Active development (base for PRs)       |
| `feature/*`  | New features                            |
| `fix/*`      | Bug fixes                               |

Please **do not commit directly** to `main` or `main-es`.

---

## 📁 File structure and language

- The `main` branch must contain all documentation and scripts in English
- The `main-es` branch is fully localized in Spanish
- Do not mix languages in the same branch

---

## ✅ Commit Guidelines

Please use clear and conventional commit messages:

```
feat: add support for multiple output formats
fix: handle binary file detection edge case
docs: update README with example usage
```


---

## 🧪 Testing

If possible, test your script in multiple environments:

- Linux (Debian/Ubuntu, Arch, etc.)
- WSL (Windows Subsystem for Linux)
- Bash versions >= 5

Let us know if your feature behaves differently on certain platforms.

---

## 📝 License

By contributing, you agree that your code will be released under the MIT License.

---

## 🤝 Need Help?

Feel free to open an [issue](https://github.com/BasiliscX/extractfiles/issues) to ask questions, report bugs, or suggest ideas.
