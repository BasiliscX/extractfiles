# Cómo colaborar con extractfiles

¡Gracias por tu interés en contribuir a **extractfiles**! Este proyecto está abierto a ideas, mejoras y pull requests.

---

## 💡 Recomendaciones generales

- Hacé un fork del repositorio y creá una rama de desarrollo a partir de `develop`
- Todos los aportes deben apuntar a la rama `develop`
- Usamos GitFlow: nombrá tus ramas como `feature/<nombre>` para nuevas funcionalidades o `fix/<nombre>` para correcciones
- Todos los pull requests deben estar redactados en **inglés**, incluidos los mensajes de commit, comentarios de código y descripciones
- Mantené coherencia con el estilo de código y formato existente

---

## 🛠 Estrategia de ramas

Seguimos un modelo basado en GitFlow:

| Rama         | Propósito                                     |
|--------------|-----------------------------------------------|
| `main`       | Versión en inglés lista para producción       |
| `main-es`    | Versión en español lista para producción      |
| `develop`    | Rama de desarrollo activo (base de los PRs)   |
| `feature/*`  | Nuevas funcionalidades                        |
| `fix/*`      | Corrección de errores                         |

**No hagas commits directamente** en `main` ni `main-es`.

---

## 📁 Estructura de archivos e idioma

- La rama `main` contiene todo en inglés
- La rama `main-es` contiene todo traducido al español
- No mezcles idiomas dentro de una misma rama

---

## ✅ Estilo de commits

Usá mensajes de commit claros y convencionales como estos:

```
feat: add support for multiple output formats
fix: handle binary file detection edge case
docs: update README with example usage
```

---

## 🧪 Pruebas

Probá el script si es posible en distintos entornos:

- Linux (Debian/Ubuntu, Arch, etc.)
- WSL (Windows Subsystem for Linux)
- Bash versión 5 o superior

Si tu cambio se comporta distinto según el sistema, informalo en el PR.

---

## 📝 Licencia

Al contribuir, aceptás que tu código se publica bajo la licencia MIT.

---

## 🤝 ¿Necesitás ayuda?

Podés abrir un [issue](https://github.com/BasiliscX/extractfiles/issues) para hacer preguntas, reportar errores o proponer mejoras.
