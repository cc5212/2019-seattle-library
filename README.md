# 2019-seattle-library
Obtención de resultados notables sobre los pedidos de libros en la biblioteca de Seattle para mejorar la calidad de este proceso en base a datos estadísticos

## Objetivos

Analizar datos de arriendos de libros de la biblioteca de Seattle, a partir de los datos provistos por esta ciudad de Seattle, Estados Unidos, que buscar, en base a estadísticas obtenibles a partir de esta información, mejorar la calidad de vida de sus ciudadanos.

Utilizar una herramienta de procesamiento masivo de datos para obtener resultados notables sobre un conjunto de datos que tenga una gran cantidad de datos.

Dentro de las preguntas que se quieren responder se encuentran las siguientes:

* Que se lee en Seattle

* ¿Cuáles son los libros más pedidos mensualmente desde el inicio de los registros de los datos hasta el final de estos?

* ¿Cuáles son los géneros de los libros más solicitados, los autores más leídos y las editoriales más populares?


## Dataset

Como se mencionó anteriormente se trabaja con datos de la iniciativa de datos abiertos de la ciudad de Seattle ( https://data.seattle.gov/ ), en este caso se trabajo con 3 dataset de la biblioteca pública de Seattle:

### Seattle Library Collection Inventory
Este conjunto de datos contiene la información del catálogo que posee la Biblioteca de Seattle, este fue inventariado entre los años 2017 y 2019.

 Extraído de Kaggle: https://www.kaggle.com/city-of-seattle/seattle-library-collection-inventory 

Contiene 

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

Este conjunto contiene la información de la nomenclatura utilizada en el inventario provisto por la biblioteca de Seattle.
Extraído de : https://www.kaggle.com/city-of-seattle/seattle-integrated-library-system-ils-dictionary


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
Este dataset contiene la información de los checkouts (solicitudes de préstamo) de los items de la biblioteca entre abril del 2005 y octubre 2017.

https://www.kaggle.com/seattle-public-library/seattle-library-checkout-records

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

Una de las complicaciones notables fue notar después de una larga espera de los resultados de una consulta, notar que muchos de las entradas de las base de datos estaban duplicadas o mal formateadas generando resultados extraños, por eso tuvimos que pasar por una etapa grande de filtrados de datos. 

Nuestro trabajo consistió en realizar joins y agrupaciones entre las tablas de checkouts y el inventario, para poder obtener los elementos/libros más solicitados para préstamos, con esto realizamos diferentes filtros, y agrupaciones, a diferentes niveles para poder obtener estadísticas interesantes de los préstamos, como que es 


En primer lugar, se trabajo agrupando los préstamos por mes y año, obteniendo cuantas veces fue pedido cierto libro en cierto mes y año, de esta manera se reduce la cantidad de datos sobre los que trabajar. Además de esto también se cálculo la cantidad de préstamos de cada libro para cada año, y para todo el período.

Luego con esto, se obtuvieron los Top 100 libros para cada mes y año respectivo. Con los cuales se realiza un Join con la tabla de inventario, de modo de conocer sus autores, géneros, colección  y editorial. Para luego hacer agrupaciones por autores, y obtener un ranking de autores, al igual que contar los géneros y editorial.


## Resultados

//Detail* the results of the project. Different projects will have different types of results; e.g., run-times or result sizes, evaluation of the methods you're comparing, the interface of the system you've built, and/or some of the results of the data analysis you conducted.//

// Mostrar tamaño de cada tabla y ejemplos de los resultados importantes
## Conclusión

// explicar que es díficil ser creativo :/  trabajar con grandes datos requiere mucho tiempo e importante preocuparse del buen formato de los datos


//Summarise main lessons learnt. What was easy? What was difficult? What could have been done better or more efficiently?//


## Apéndice

// You can use this for key code snippets that you don't want to clutter the main text. //

