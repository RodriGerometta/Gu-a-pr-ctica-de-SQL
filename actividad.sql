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