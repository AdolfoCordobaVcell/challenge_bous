-- Función que sirve para filtrar las fechas y validarlas.
CREATE OR REPLACE FUNCTION date(d varchar) RETURNS boolean AS $$
BEGIN

perform d::date;
  return true;
exception when others then
  return false;

END;
$$ LANGUAGE plpgsql;

-- Insertar a la tabla "validos" las filas de la tabla "tabla_de_trabajo" que hayan cumplido con las validaciones.
INSERT INTO validos (cliente, contrato, fecha_de_compra, ciudad, empresa, valor_adeudado)
SELECT cliente, contrato, fecha_de_compra, ciudad, empresa, valor_adeudado 
FROM tabla_de_trabajo 
WHERE (cliente ~* '[a-z]' AND contrato ~* '[0-9a-z]' AND "fecha_de_compra" = (SELECT date(fecha_de_compra)) 
AND ciudad ~* '[a-z]' AND empresa ~* '[0-9a-z]') IS true;

-- Insertar a la tabla "invalidos" las filas de la tabla "tabla_de_trabajo" que no hayan cumplido con las validaciones.
INSERT INTO invalidos (cliente, contrato, fecha_de_compra, ciudad, empresa, valor_adeudado)
SELECT cliente, contrato, fecha_de_compra, ciudad, empresa, valor_adeudado 
FROM tabla_de_trabajo 
WHERE (cliente ~* '[a-z]' AND contrato ~* '[0-9a-z]' AND "fecha_de_compra" = (SELECT date(fecha_de_compra)) 
AND ciudad ~* '[a-z]' AND empresa ~* '[0-9a-z]') is not true;


-- Insertar en la tabla "procesados" el numero total de registros y el adeudo total que contenga la tabla "validos".
INSERT INTO procesados (numero_de_registros, adeudo_total)
SELECT COUNT(*),
SUM(valor_adeudado)
FROM validos;

-- Insertar en la tabla "adeudo_y_porcentaje_por_ciudad" los adeudos y porcentajes por ciudad de la tabla validos.
INSERT INTO adeudo_y_porcentaje_por_ciudad (ciudad, adeudo, porcentaje, folio_procesados)
SELECT ciudad,
SUM(valor_adeudado),
(SUM((valor_adeudado)::float * (100)) / (SELECT SUM(valor_adeudado) FROM validos)::float)::float,
currval('procesados_folio_seq')
FROM validos
GROUP BY ciudad;

-- Insertar en la tabla "adeudo_y_porcentaje_por_empresa" los adeudos y porcentajes por empresa de la tabla validos.
INSERT INTO adeudo_y_porcentaje_por_empresa (empresa, adeudo, porcentaje, folio_procesados)
SELECT empresa,
SUM(valor_adeudado),
(SUM((valor_adeudado)::float * (100)) / (SELECT SUM(valor_adeudado) FROM validos)::float)::float,
currval('procesados_folio_seq')
FROM validos
GROUP BY empresa;

-- Imprimir el folio.
SELECT folio FROM procesados;