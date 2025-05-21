# extractfiles

A lightweight CLI utility to recursively scan files in a given directory, filter them by exact string match, and export their paths and contents to a `.txt` file.

---

## 🔧 Features

- ✅ Recursively scans all subdirectories
- ✅ Extracts paths and contents of plain text files
- ✅ Supports exact string search (space- and case-sensitive)
- ✅ Supports multiple search patterns using `|` (space-pipe-space)
- ✅ Skips binary and hidden files
- ✅ Outputs to a customizable `.txt` file
- ✅ Optional colored logs for detailed process tracking

---

## 🚀 Installation

Clone this repository and run the installer:

```bash
git clone https://github.com/BasiliscX/extractfiles.git
cd extractfiles
bash install.sh
```

You will be prompted to choose between:

- [1] Local installation (just for your user)
- [2] System-wide installation (requires `sudo`)

---

## 🧹 Uninstallation

To uninstall the command:

```bash
bash uninstall.sh
```

It will detect the installation location and confirm before removing.

## 💻 Usage

```bash
extractfiles <path> [search_string] [--output name.txt] [--logs]
```

## 📌 Parameters

| Parameter           | Description                                                                           |
| ------------------- | ------------------------------------------------------------------------------------- |
| `<path>`            | Absolute path to scan. If it includes backslashes (\\), wrap it in quotes.            |
| `[search_string]`   | (Optional) Exact string to search. Use <code>\|</code> to separate multiple patterns. |
| `--output name.txt` | (Optional) Output file name. Defaults to extracted_output.txt.                        |
| `--logs`            | (Optional) Show detailed log output with colors.                                      |

## 📚 Examples

```bash
extractfiles /mnt/project
extractfiles "/mnt/project\\src\\module" "DTO"
extractfiles /mnt/project "error | UpdateService" --logs
extractfiles /mnt/project "MyDTO" --output filtered_results
```

## ⚠️ Notes

- Matching is case-sensitive and space-sensitive

- Binary files are automatically skipped

- Hidden files (starting with .) are not processed

- If no matches are found, no output file will be created

## 🤝 Contributing

Suggestions? Feedback? Want to contribute?
Feel free to open an issue or pull request!

[GitHub repository: github.com/BasiliscX/extractfiles](https://github.com/BasiliscX/extractfiles)

## 📄 License

[MIT License](https://opensource.org/licenses/MIT).
