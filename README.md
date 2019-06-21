# 2019-seattle-library

Obtención de resultados notables sobre los pedidos de libros en la biblioteca de Seattle para mejorar la calidad de este proceso en base a datos estadísticos

## Objetivos

Analizar datos de arriendos de libros de la biblioteca de Seattle, a partir de los datos provistos por esta ciudad de Estados Unidos, que para mejorar en base a estadísticas obtenibles a partir de esta información busca mejorar la calidad de vida de sus ciudadanos.

Utilizar una herramienta de procesamiento masivo de datos para obtener resultados notables sobre un conjunto de datos que tenga una gran cantidad de datos.

Dentro de las preguntas que se quieren responder se encuentran las siguientes:

* ¿Cuáles son los libros más pedidos mensualmente desde el inicio de los registros de los datos hasta el final de estos?
* ¿Cuáles son los géneros de los libros más solicitados?

## Dataset
### Seattle Library Collection Inventory
Este conjunto de datos contiene la información del inventario que provee la Biblioteca de Seattle
#### Atributos del dataset

| Columna               | Tipo    |
| --------------------- | ------- |
| Bibnum                | numeric |
| Title                 | String  |                           
| Author                | String  |                           
| ISBN                  | String  |                           
| PublicationYear       | String  |                           
| Publisher             | String  |                           
| Subjects              | String  |                           
| ItemType              | String  |                           
| ItemCollection        | String  |                           
| FloatingItem          | String  |                           
| ItemLocation          | String  |                           
| ReportDate            | Date    |                           
| ItemCount             | numeric |

### Seattle Integrated Library System (ILS) Dictionary
Este conjunto contiene la información de la nomenclatura utilizada en el inventario provisto por la biblioteca de Seattle
#### Atributos del dataset

| Columna               | Tipo    |
| --------------------- | ------- |
| Code                  | String  |
| Description           | String  |                           
| Code Type             | String  |                           
| Format Group          | String  |                           
| Format Subgroup       | String  |                           
| Category Group        | String  |                           
| Category Subgroup     | String  |        

### Seattle Library Checkouts Records
Este dataset contiene la información de los checkouts de los items de la biblioteca
#### Atributos del dataset

| Columna               | Tipo    |
| --------------------- | ------- |
| UsageClass            | String  |
| CheckoutType          | String  |                           
| MaterialType          | String  |                           
| CheckoutYear          | numeric |                           
| CheckoutMonth         | numeric |                           
| Checkouts             | numeric |                           
| Title                 | String  |
| Creator               | String  |                           
| Subjects              | String  |                           
| Publisher             | String  |                           
| PublicationYear       | String  | 


## Metodología

Primero se concibieron las consultas a realizar al conjunto de datos, de acuerdo a la complejidad de la consulta y al manejo de la herramienta se escogió dentro del equipo la herramienta de manejo masivo de datos Apache Pig.

Trabajando con el conjunto de datos, se tuvo que investigar sobre la lectura de csv en PIG, pues al abrirlos de la forma tradicional los datos no tenían la cantidad correcta de columnas.

Una de las complicaciones notables fue notar después de una larga espera de los resultados de una consulta, notar que tenía resultados duplicados.

## Resultados

//Detail the results of the project. Different projects will have different types of results; e.g., run-times or result sizes, evaluation of the methods you're comparing, the interface of the system you've built, and/or some of the results of the data analysis you conducted.//


### Un resultado

|Cri|Cri|Cri|Cri|Cri||
|----|------|----|---|----------|
|1|1|1|1|1|

## Conclusión

//Summarise main lessons learnt. What was easy? What was difficult? What could have been done better or more efficiently?//


## Apéndice

// You can use this for key code snippets that you don't want to clutter the main text. //
