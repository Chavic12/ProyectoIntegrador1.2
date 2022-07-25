SELECT nombrePais FROM Comerciales.Paises
WHERE nombrePais = 'Perú';

SELECT idProvincia, p.nombreProvincia, v.ventaTotal
FROM Provincias p, Ventas v;

-- AND p.idProvincia = v.idProvincia

SELECT  Count(idComercial)
FROM Comerciales;

SELECT  Count(idComercial)
FROM Comerciales
WHERE web = '';

SELECT idProvincia, sum(ventaTotal)
FROM Ventas
WHERE anio = 2019
GROUP BY 1
ORDER BY 2 DESC;

SELECT p.nombreProvincia, v.ventaTotal, v.recaudaciones
FROM Ventas v, Provincias p
WHERE v.idProvincia = p.idProvincia
AND v.anio = 2019
ORDER BY 2 DESC
LIMIT 5;

use comerciales;
SELECT *
FROM Paises;

SELECT DISTINCT idParroquia, COUNT(idComercial)
FROM Comerciales
WHERE clasificacion = "BAR"
GROUP BY 1
ORDER BY  2 DESC;
