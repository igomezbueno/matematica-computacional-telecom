# Matemática computacional para telecomunicaciones

**Un enfoque práctico con Octave y MATLAB**

Material complementario del libro de **Irene Gómez Bueno** y **Pablo Guerrero García** (Departamento de Matemática Aplicada, Universidad de Málaga).

Este repositorio contiene todas las recetas de Octave del libro, listas para ejecutarse, junto con las rutinas auxiliares y los ficheros de datos necesarios. Así puedes reproducir cada resultado sin copiar el código desde el texto.

## Contenido

| Carpeta | Capítulo del libro |
|---|---|
| `capitulo1/` | 1. Introducción a Octave mediante el análisis de señales |
| `capitulo2/` | 2. Métodos iterativos y análisis DC de circuitos |
| `capitulo3/` | 3. Estadística descriptiva y calibración de medidas en telecomunicaciones |
| `capitulo4/` | 4. Modelos probabilísticos, simulación y cadenas de Markov en telecomunicaciones |
| `capitulo5/` | 5. Métodos numéricos y modelado geométrico en telecomunicaciones |
| `rutinas/` | Rutinas auxiliares comunes (Apéndice B del libro) |

Dentro de la carpeta de cada capítulo `N`:

- `capituloN.m`: el código del desarrollo del capítulo, en el mismo orden en que aparece en el libro.
- `problema_N_k.m`: la solución del Problema N.k.
- `ejercicio_N_k.m`: la solución del Ejercicio propuesto N.k (Apéndice A del libro).

Algunos capítulos incluyen, además, funciones en ficheros propios (`suavizadoF1.m` y `suavizado5.m` en el capítulo 1) o datos (`datos.mat` en el capítulo 3).

## Requisitos

- [GNU Octave](https://octave.org) (versión 8 o posterior). Las recetas se han comprobado con Octave 10.3.
- El paquete `symbolic` de Octave, que necesita Python con la biblioteca SymPy.
- El paquete `statistics` de Octave.

Los paquetes se instalan una sola vez desde la ventana de comandos de Octave:

```octave
pkg install -forge symbolic
pkg install -forge statistics
```

Si la última versión de `statistics` pide una versión de Octave más reciente que la tuya, instala una versión anterior del paquete; consulta <https://gnu-octave.github.io/packages/statistics/>.

## Uso

1. Descarga el repositorio (botón **Code → Download ZIP**) o clónalo:

   ```
   git clone https://github.com/igomezbueno/matematica-computacional-telecom.git
   ```

2. Abre Octave, sitúate en la carpeta del repositorio y ejecuta `iniciar`. Así se añaden las rutinas auxiliares a la ruta de búsqueda:

   ```octave
   >> iniciar
   ```

3. Entra en la carpeta del capítulo y ejecuta la receta que quieras, por ejemplo:

   ```octave
   >> cd capitulo4
   >> problema_4_3
   ```

Muchas recetas usan números aleatorios (ruido, método de Montecarlo, simulación de cadenas de Markov), así que los valores obtenidos cambian ligeramente en cada ejecución.

## Uso con MATLAB

La mayor parte del código funciona también en MATLAB con cambios mínimos:

- sustituir `endfunction` por `end`;
- colocar las funciones locales al final de la receta;
- eliminar las instrucciones `pkg load`.

El cálculo simbólico y las funciones estadísticas requieren, respectivamente, la *Symbolic Math Toolbox* y la *Statistics and Machine Learning Toolbox*.

## Autoría y licencia

Todo el material se distribuye bajo la licencia MIT (véase [LICENSE](LICENSE)). Cada rutina de la carpeta `rutinas/` incluye una cabecera de ayuda, que se consulta con `help nombre_rutina`.

Si utilizas este material, cita el libro:

> Gómez Bueno, I. y Guerrero García, P. *Matemática computacional para telecomunicaciones. Un enfoque práctico con Octave y MATLAB*. 2026.
