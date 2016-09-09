# lugares
Base de datos con todas as comunidades autónomas, concellos e provincias de España.

Estructura:

```
- autonomia
  - name

- provincia
  - name
  - autonomia_id

- municipio
  - name
  - code
  - provincia_id

- isla
  - name
  - provincia_id
```
