USE WORLD;

/*Selección. Unicidad. Alias. Columnas calculadas*/

/*1. Listar código, nombre, continente y población de todos los países. 
 (Se esperan 4 columnas y 239 registros).*/

SELECT code, Name, Continent, population FROM country;

/*2. Listar solo el nombre de todos los lenguajes distintos que existan. 
 (Se espera 1 columna y 457 registros).*/

SELECT DISTINCT Language FROM countrylanguage;

/*3. Listar nombre y población de cada ciudad, con los nombres de las columnas en castellano. 
 (Se esperan 2 columnas y 4079 registros)*/

SELECT name as Nombre, Population as Poblacion FROM city;

/*4. Listar el nombre, el GNP como 'Producto Bruto Nacional', el GNPOld como 'Producto Bruto Nacional Anterior' y la diferencia entre estos como 'Diferencia', para todos los países. 
 (Se esperan 4 columnas y 239 registros).*/

SELECT
    name as Nombre,
    GNP as Producto_Bruto_Nacional,
    GNPOld as Producto_Bruto_Nacional_Anterior, (gnp - gnpold) as Diferencia
FROM country;

/*5. Listar el nombre, la cantidad de habitantes, la superficie y una columna llamada 'Densidad' con el resultado de la densidad poblacional de todos los países. 
 (Se esperan 4 columnas y 239 registros).*/

SELECT
    name as Nombre,
    Population as Poblacion,
    SurfaceArea as Superficie, (Population / SurfaceArea) as Densidad
FROM country;

/* Límites. Ordenamiento*/

/*6. Listar toda la información de los países, ordenados por población de manera ascendente. 
 (Se esperan 15 columnas y 239 registros).*/

SELECT * FROM country ORDER BY population ASC;

/*7. Listar nombre de los lenguajes en orden alfabético. 
 (Se espera 1 columna y 984 registros).*/

SELECT LANGUAGE FROM countrylanguage ORDER BY Language ASC;

/*8. Listar nombre y cantidad de habitantes de las veinte ciudades menos pobladas.
 (Se esperan 2 columnas y 20 registros).*/

SELECT
    name as Nombre,
    population as Poblacion
from city
ORDER BY Poblacion ASC
LIMIT 20;

/*9. Listar código, nombre y año de independencia de todos los países, ordenados por antigüedad descendente.
 (Se esperan 3 columnas y 239 registros).*/

SELECT
    code as Codigo,
    name as Nombre,
    indepyear as Año_de_independencia
FROM country
ORDER BY
    Año_de_independencia DESC;

/*10. Listar nombre y continente de los cien países con mayor expectativa de vida. Si hubiera países que tengan la misma expectativa de vida, mostrar primero a los de menor superficie. 
 (Se esperan 2 columnas y 100 registros).*/

SELECT
    name as Nombre,
    continent as Continente
FROM country
order by
    lifeexpectancy,
    surfacearea DESC
limit 100;

/*Filtrado de registros. Operadores relacionales y lógicos. Operadores IN y BETWEEN.*/

/*11. Listar todos los datos de los países que no cuenten con habitantes. 
 (Se esperan 15 columnas y 7 registros).*/

SELECT * FROM country where population = 0;

/*12. Listar todos los datos de los países cuya expectativa de vida supere los setenta y cinco años, ordenados bajo este concepto de forma ascendente. 
 (Se esperan 15 columnas y 62 registros).*/

SELECT *
FROM country
WHERE lifeexpectancy > 75
ORDER BY lifeexpectancy ASC;

/*13. Listar todos los datos de los países cuya independencia haya ocurrido a partir de la segunda mitad del siglo XIX y su forma de gobierno sea una monarquía constitucional. 
 (Se esperan 15 columnas y 20 registros).*/

SELECT *
FROM country
WHERE
    indepyear >= 1851
    and GovernmentForm = "Constitutional Monarchy";

/*14. Listar todos los datos de los diez países europeos de mayor PBN. 
 (Se esperan 15 columnas y 10 registros).*/

SELECT *
FROM country
WHERE continent = "Europe"
ORDER BY gnp desc
LIMIT 10;

/*15. Listar todos los datos de los países cuyo nombre registrado coincida con su nombre local. 
 (Se esperan 15 columnas y 104 registros).*/

SELECT * FROM country WHERE name = localname;

/*16. Listar todos los datos de los países cuya independencia se haya dado a partir de la segunda mitad del siglo XX. 
 (Se esperan 15 columnas y 110 registros).*/

SELECT * FROM country WHERE indepyear >=1951;

/*17. Listar todos los datos de los países situados en Europa, Asia o Sudamérica. 
 (Se esperan 15 columnas y 111 registros).*/

SELECT *
FROM country
where
    continent in (
        "Europe",
        "asia",
        "South America"
    );

/*18. Listar todos los datos de todos los países, excepto los africanos. 
 (Se esperan 15 columnas y 181 registros).*/

SELECT * FROM country WHERE continent <> "africa";

SELECT* FROM world.country WHERE NOT country.Continent='Africa';

/*19. Listar todos los datos de las ciudades argentinas fuera de la provincia de Buenos Aires. 
 (Se esperan 5 columnas y 26 registros).*/

SELECT *
FROM city
where
    name <> "Buenos Aires"
    and district <> "Buenos Aires"
    and countrycode in (
        SELECT code
        FROM country
        where
            name = "Argentina"
    );

/*20. Listar todos los datos de las ciudades de entre 125 mil y 130 mil habitantes. 
 (Se esperan 5 columnas y 138 registros).*/

SELECT * FROM city WHERE population BETWEEN 125000 AND 130000;

/*Manejo de valores nulos. Operador LIKE. Comodines.*/

/*21. Listar todos los datos de los países donde no se cuente con datos acerca de su independencia. 
 (Se esperan 15 columnas y 47 registros).*/

SELECT * FROM country WHERE indepyear is NULL;

/*22. Listar todos los datos de los países donde no se tengan datos acerca del PBN anterior ni de la expectativa de vida. 
 (Se esperan 15 columnas y 17 registros).*/

SELECT *
FROM country
WHERE
    gnpold is null
    and lifeexpectancy is null;

/*23. Listar todos los datos de los países cuyo nombre comience y termine con 'A'.
 (Se esperan 15 columnas y 13 registros).*/

SELECT * FROM country WHERE name LIKE 'a%a';

/*24. Listar todos los datos de los países cuyo nombre sea compuesto (más de una palabra). 
 (Se esperan 15 columnas y 66 registros)*/

SELECT * FROM country WHERE name LIKE '% %';

/*25. Listar todos los datos de las ciudades cuyo nombre o distrito contengan un '-' (guión medio). 
 (Se esperan 5 columnas y 372 registros).*/

SELECT * FROM city WHERE name LIKE '%-%' or district LIKE '%-%';

/*Unión de tablas*/

/*26. Listar los nombres de los países sudamericanos junto a los nombres (alias'Capital') de sus capitales. 
 (Se esperan 2 columnas y 14 registros).*/

SELECT
    country.name as Pais,
    city.name as Capital
FROM country
    INNER JOIN city on country.`Capital` = city.id
WHERE
    continent = "south America";

SELECT
    country.name as Pais,
    city.name as Capital
FROM country
    LEFT JOIN city on country.`Capital` = city.id
WHERE Region = "south America";

/*27. Listar el código de país, junto a los nombres de las ciudades y su cantidad de habitantes, de aquellos cuya expectativa de vida sea mayor a 80. 
 (Se esperan 3 columnas y 253 registros).*/

SELECT
    country.code as "Codigo de pais",
    city.name as "Ciudad",
    city.Population as "Poblacion"
FROM country
    INNER JOIN city on Country.Code = city.CountryCode
WHERE
    country.LifeExpectancy > 80;

/*28. Listar las capitales de los países cuya forma de gobierno sea una República Federal. 
 (Se esperan 2 columnas y 15 registros).*/

SELECT
    city.name as "Capital",
    country.governmentform as "Forma de gobierno"
FROM country
    INNER JOIN city on country.code = city.countrycode
WHERE
    country.governmentform = "federal republic"
    and country.capital = city.id;

/*29. Listar los lenguajes oficiales, junto al nombre de sus respectivos países, donde la cantidad de habitantes de dicho país esté entre un millón y tres millones. 
 (Se esperan 2 columnas y 14 registros).*/

SELECT
    country.name as "Pais",
    countrylanguage.language as "Lenguaje"
FROM country
    INNER JOIN countrylanguage on country.code = countrylanguage.countrycode
WHERE
    country.population BETWEEN 1000000 AND 3000000
    AND countrylanguage.IsOfficial = "T";

/*30. Listar los códigos, los nombres locales y la región a la que pertenecen aquellos países donde se hable español. 
 (Se esperan 3 columnas y 28 registros).*/

SELECT
    country.code as "Codigo pais",
    country.localname as "Nombre local",
    country.region as "Region"
FROM country
    INNER JOIN countrylanguage on country.code = countrylanguage.countrycode
WHERE
    countrylanguage.language = "Spanish";

/*31. Listar los nombres y las capitales de los países en cuya capital se concentre más de la mitad de su población total. 
 (Se esperan 2 columnas y 14 registros).*/

SELECT
    country.name as "Nombre",
    city.name as "Capital"
FROM country
    INNER JOIN city on country.code = city.countrycode
WHERE
    city.population / country.population > 0.5;

SELECT
    country.name as "Nombre",
    city.name as "Capital"
FROM country
    INNER JOIN city on country.code = city.countrycode
WHERE
    city.population > (country.population / 2);

/*32. Listar los nombres y la superficie de los países africanos cuya capital coincida con el nombre del distrito a la que pertenece. 
 (Se esperan 2 columnas y 32 registros).*/

SELECT
    country.name as "Pais",
    country.SurfaceArea as "Superficie"
FROM country
    INNER JOIN city on country.capital = city.id
WHERE
    country.continent = "africa"
    and city.name = city.district;

/*33. Listar los nombres, las capitales y el año de independencia (sin nulos) de los 20 países más antiguos. 
 (Se esperan 3 columnas y 20 registros).*/

SELECT
    country.name as "Pais",
    city.name as "Capital",
    country.IndepYear
FROM country
    INNER JOIN city on country.capital = city.id
WHERE
    country.IndepYear IS NOT NULL
ORDER BY country.IndepYear ASC
LIMIT 20;

/*34. Listar las ciudades junto a sus idiomas oficiales, donde no se hable español, inglés, portugués, italiano, francés o alemán de manera oficial. 
 (Se esperan 2 columnas y 2694 registros).*/

SELECT
    city.name as "Ciudad",
    countrylanguage.language as "Idioma oficial"
from city
    INNER JOIN countrylanguage on city.CountryCode = countrylanguage.CountryCode
WHERE
    countrylanguage.isofficial not IN(
        "Spanish",
        "English",
        "portuguese",
        "italian",
        "french",
        "german"
    );

/*35. Listar nombre, población y país de las diez ciudades europeas de habla inglesa más pobladas. 
 (Se esperan 3 columnas y 10 registros).*/

SELECT
    city.name as "Ciudad",
    city.population as "Poblacion",
    country.name as "Pais"
FROM city
    INNER JOIN country on city.countrycode = country.code
    INNER JOIN countrylanguage ON countrylanguage.countrycode = country.code
WHERE
    country.continent in ("Europe")
    and countrylanguage.language = "english"
ORDER BY city.population desc
LIMIT 10;

/*Funciones de agregación. Agrupamiento.*/

/*36. Mostrar según la tabla de países, la cantidad total de población, la población máxima, la población mínima, el promedio de población y con cuántos registros de población se cuenta. 
 (Se esperan 5 columnas y 1 registro).*/

SELECT
    SUM(country.population) as "Poblacion total",
    MAX(country.population) as "Poblacion maxima",
    MIN(country.population) as "Poblacion minima",
    AVG(country.population) as "Poblacion promedio",
    COUNT(country.population) as "Registro de poblacion"
FROM country;

/*37. Mostrar según la tabla de países, la cantidad total de población, la población máxima, la población mínima y el promedio de población, por cada continente.
 (Se esperan 5 columnas y 7 registros).*/

SELECT
    country.continent as "Continente",
    SUM(country.population) as "Poblacion total",
    MAX(country.population) as "Poblacion maxima",
    MIN(country.population) as "Poblacion minima",
    AVG(country.population) as "Poblacion promedio"
FROM country
GROUP BY country.continent;

/*38. Agrupar a todos los países según el continente al que pertenecen. Mostrar los continentes junto a la cantidad de naciones que pertenecen a cada uno. 
 (Se esperan 2 columnas y 7 registros).*/

SELECT
    country.continent as "Continente",
    count(country.code) as "Cantidad de paises"
FROM country
GROUP BY country.continent;

/*39. Agrupar a todas las ciudades según el país al que pertenecen. Mostrar los códigos de países junto a la sumatoria total de habitantes de cada uno. 
 (Se esperan 2 columnas y 232 registros).*/

SELECT
    country.code as "Codigo pais",
    SUM(country.population) as "Total de habitantes"
FROM country
    INNER JOIN city on country.code = city.countrycode
GROUP BY country.code;

/*40. Agrupar a todos los lenguajes según su nombre. Mostrar los nombres de los lenguajes junto al porcentaje de habla mínimo registrado para cada uno. 
 (Se esperan 2 columnas y 457 registros).*/

SELECT
    countrylanguage.language as "Nombre lenguaje",
    MIN(countrylanguage.percentage) as "% habla min"
FROM countrylanguage
GROUP BY
    countrylanguage.language;

/*41. Mostrar las distintas formas de gobierno posibles de los países europeos junto a su correspondiente promedio de población que vive bajo estas circunstancias.
 (Se esperan 2 columnas y 10 registros).*/

SELECT
    country.GovernmentForm as "Forma de gobierno",
    AVG(country.population) as "Promedio de poblacion"
FROM country
WHERE
    country.continent = "Europe"
GROUP BY
    country.GovernmentForm;

/*42. Mostrar las diez regiones de mayor expectativa de vida promedio.
 (Se esperan 2 columnas y 10 registros).*/

SELECT
    country.region as "Regiones",
    AVG(country.LifeExpectancy) as "Expectativa_de_vida_promedio"
FROM country
GROUP BY country.region
ORDER BY
    Expectativa_de_vida_promedio DESC
LIMIT 10;

/*43. Mostrar los nombres de los diez distritos de mayor cantidad de ciudades con cantidad de habitantes mayor al medio millón, junto a la cantidad de ciudades.
 (Se esperan 3 columnas y 10 registros).*/

SELECT
    city.district as "Districto",
    SUM(city.population) as "Cant_habitantes",
    count(city.name) as "Cant_ciudades"
FROM city
WHERE city.population > 500000
GROUP BY city.district
ORDER BY Cant_ciudades DESC
LIMIT 10;

/*44. Mostrar los nombres de los países que tengan ciudades en el Caribe, junto al número de las mismas por país. 
 (Se esperan 2 columnas y 24 registros).*/

SELECT
    country.name as "Pais",
    COUNT(city.name)
FROM country
    INNER JOIN city on country.code = city.countrycode
WHERE
    country.region = "caribbean"
GROUP BY country.name;

/*45. Mostrar los lenguajes existentes junto a la cantidad de países que lo hablan de manera oficial. 
 (Se esperan 2 columnas y 102 registros).*/

SELECT
    countrylanguage.language as "Lenguajes",
    COUNT(countrylanguage.language) as "Paises_que_lo_hablan"
FROM countrylanguage
WHERE
    countrylanguage.IsOfficial = "T"
GROUP BY
    countrylanguage.language;

/*Filtrado de grupos.*/

/*46. Mostrar listados los años de independencia (sin nulos) junto a la cantidad de países que la hayan conseguido en ese año. Se desea visualizar aquellos años donde más de un país se haya independizado. 
 (Se esperan 2 columnas y 39 registros).*/

SELECT
    country.indepyear as "Año indep",
    COUNT(country.name) as "Cant paises"
FROM country
WHERE
    country.indepyear IS NOT NULL
GROUP BY country.indepyear
HAVING COUNT(country.name) > 1;

/*HAVING Cuando tengo que filtrar sobre funciones agregadas*/

/*47. Listar los países junto a la cantidad de idiomas diferentes hablados, pero solo aquellos donde se hablen entre tres y cinco idiomas diferentes. 
 (Se esperan 2 columnas y 80 registros).*/

SELECT
    country.name as "Pais",
    COUNT(countrylanguage.language) as "Cant_idiomas"
FROM country
    INNER JOIN countrylanguage on country.code = countrylanguage.countrycode
GROUP BY country.name
HAVING
    COUNT(countrylanguage.language) BETWEEN 3 and 5;

/*48. Mostrar los distritos, junto al nombre del país al que pertenecen, cuya población total (también listada) no supere los diez mil habitantes. 
 (Se esperan 3 columnas y 35 registros).*/

SELECT
    city.district as "Distrito",
    country.name as "Pais",
    SUM(city.population) as "Poblacion_total"
FROM city
    INNER JOIN country on country.code = city.countrycode
GROUP BY Distrito, Pais
HAVING Poblacion_total <= 10000;

/*49. Mostrar las regiones junto a su densidad poblacional promedio, donde ésta supere a la mitad de la densidad poblacional máxima. 
 (Se esperan 2 columnas y 3 registros).*/

SELECT
    country.region as "Region",
    AVG(
        country.Population / country.SurfaceArea
    ) as "Densidad_promedio"
FROM country
GROUP BY country.region
HAVING
    Densidad_promedio > (
        MAX(
            country.Population / country.SurfaceArea
        )
    ) / 2;

/*50. Mostrar los lenguajes oficiales junto a su porcentaje promedio de habla, cuyo promedio no supere un dígito entero. 
 (Se esperan 2 columnas y 7 registros).*/

SELECT
    countrylanguage.language as "Lenguajes_oficiales",
    AVG(countrylanguage.percentage) as "% promedio de habla"
FROM countrylanguage
WHERE
    countrylanguage.isofficial = "T"
GROUP BY
    countrylanguage.language
HAVING
    AVG(countrylanguage.percentage) < 10;