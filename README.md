# extractfiles

Una herramienta de línea de comandos liviana para escanear recursivamente archivos en un directorio, filtrar por coincidencia exacta de texto y exportar sus rutas y contenidos a un archivo `.txt`.

---

## 🔧 Funcionalidades

- ✅ Escaneo recursivo de todos los subdirectorios
- ✅ Extrae rutas y contenido de archivos de texto plano
- ✅ Soporta búsqueda exacta (sensible a mayúsculas y espacios)
- ✅ Permite múltiples patrones de búsqueda usando ` | ` (espacio-pipe-espacio)
- ✅ Ignora archivos binarios y ocultos
- ✅ Genera un archivo `.txt` personalizado con los resultados
- ✅ Opcional: registro detallado en consola con colores

---

## 🚀 Instalación

Cloná este repositorio y ejecutá el instalador:

```bash
git clone https://github.com/BasiliscX/extractfiles.git
cd extractfiles
bash install.sh
```

Se te pedirá elegir entre:

- [1] Instalación local (solo para tu usuario)
- [2] Instalación para todo el sistema (requiere `sudo`)

---

## 🧹 Desinstalación

Para desinstalar el comando:

```bash
bash uninstall.sh
```

El sistema detectará automáticamente la ubicación de instalación y te pedirá confirmación antes de eliminarlo.

## 💻 Uso

```bash
extractfiles <ruta> [cadena_busqueda] [--output nombre.txt] [--logs]
```

## 📌 Parámetros

| Parámetro             | Descripción                                                                              |
| --------------------- | ---------------------------------------------------------------------------------------- |
| `<ruta>`              | Ruta absoluta a escanear. Si incluye barras invertidas (\), ponla entre comillas.        |
| `[cadena_busqueda]`   | (Opcional) Cadena exacta a buscar. Usa <code>|</code> para separar múltiples patrones.   |
| `--output nombre.txt` | (Opcional) Nombre del archivo de salida. Por defecto es extracted_output.txt.            |
| `--logs`              | (Opcional) Muestra logs detallados con colores.                                         |

## 📚 Ejemplos

```bash
extractfiles /mnt/project
extractfiles "/mnt/project\src\module" "DTO"
extractfiles /mnt/project "error | UpdateService" --logs
extractfiles /mnt/project "MyDTO" --output filtered_results
```

## ⚠️ Notas

- La coincidencia distingue entre mayúsculas y minúsculas, y es sensible a espacios

- Los archivos binarios se omiten automáticamente

- Los archivos ocultos (que comienzan con .) no se procesan

- Si no se encuentran coincidencias, no se creará ningún archivo de salida

## 🤝 Contribuciones

¿Sugerencias? ¿Errores? ¿Querés colaborar?
Podés abrir un issue o hacer un pull request.

Para conocer las pautas de contribución, consultá la [guía de contribución](https://github.com/BasiliscX/extractfiles/blob/main-es/CONTRIBUTING.md).


[Repositorio GitHub: github.com/BasiliscX/extractfiles](https://github.com/BasiliscX/extractfiles)

## 📄 Licencia

[Licencia MIT](https://opensource.org/licenses/MIT).
