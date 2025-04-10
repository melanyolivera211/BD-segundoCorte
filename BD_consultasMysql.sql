SELECT * FROM Alumno;
SELECT * FROM Profesor;
SELECT * FROM Asignatura;

SELECT Numero_Matricula, Nombre FROM Alumno;
SELECT Nombre, Correo_Electronico FROM Profesor;

SELECT Numero_Matricula AS Columna1, Nombre AS Columna2 FROM Alumno;

SELECT COUNT(*) AS Total_Registros FROM alumno;

SELECT * FROM Alumno ORDER BY Nombre DESC;

SELECT COUNT(*) AS EL_CONTEO
FROM alumno;

SELECT SUM(Nota) AS La_Sumatoria FROM Alumno_Evaluacion; 

SELECT AVG(Nota) AS El_PROMEDIO FROM Alumno_Evaluacion;

SELECT MAX(Nota) AS El_MAXIMO FROM Alumno_Evaluacion;

SELECT MIN(Nota) AS El_MINiMO FROM Alumno_Evaluacion;

SELECT Codigo_Asignatura || ' - ' || Nombre AS VALORES_UNIDOS
FROM Asignatura;

SELECT UPPER(Profesor.Nombre) AS EN_MAYUSCULAS FROM Profesor;

SELECT LOWER(Profesor.Nombre) AS EN_MINISCULAS FROM Profesor;

SELECT EXTRACT(YEAR FROM Fecha_Diseno) AS EL_AÑO
FROM Practica;

SELECT EXTRACT(MONTH FROM Fecha_Diseno) AS EL_MES
FROM Practica;

SELECT EXTRACT(DAY FROM Fecha_Diseno) AS EL_DIA
FROM Practica;

SELECT TO_CHAR(Fecha_Diseno, 'DD@MM@YYYY') AS FECHA_RARA
FROM Practica;

SELECT TRUNC(SYSDATE) AS FECHA_ACTUAL FROM DUAL;

SELECT 
  Creditos_Academicos,
	Semestre,
  (Creditos_Academicos + semestre) AS LA_SUMA,
  (Creditos_Academicos - Semestre) AS LA_RESTA,
  (Creditos_Academicos * Semestre) AS LA_MULTIPLICACION
FROM asignatura;

SELECT DISTINCT Anio_Academico FROM asignatura;

SELECT * FROM alumno WHERE Numero_Matricula = 1001;

SELECT * FROM asignatura WHERE Semestre = 1;

SELECT * FROM asignatura WHERE Semestre <> 1;

SELECT * FROM asignatura WHERE Creditos_Academicos < 4;

SELECT * FROM asignatura WHERE Creditos_Academicos > 3;

SELECT * FROM asignatura WHERE Creditos_Academicos BETWEEN 2 AND 4;

SELECT * FROM profesor WHERE Fecha_Fin_Contrato IS NULL;

SELECT * FROM profesor WHERE Fecha_Fin_Contrato IS NOT NULL;

SELECT * FROM asignatura WHERE LOWER(Nombre) LIKE '%datos%'

SELECT * FROM asignatura WHERE LOWER(Nombre) LIKE 'algoritmo%';

SELECT * FROM asignatura WHERE LOWER(Nombre) LIKE '%s';

SELECT * FROM Asignatura WHERE Semestre IN (1, 2);

SELECT DISTINCT a.*
FROM alumno a
INNER JOIN inscripcion i ON a.Numero_Matricula = i.Numero_Matricula;

SELECT a.*
FROM alumno a
LEFT JOIN inscripcion i ON a.Numero_Matricula = i.Numero_Matricula
WHERE i.Numero_Matricula IS NULL;

SELECT i.*
FROM inscripcion i
INNER JOIN alumno a ON i.Numero_Matricula = a.Numero_Matricula;

SELECT i.*
FROM inscripcion i
LEFT JOIN alumno a ON i.Numero_Matricula = a.Numero_Matricula
WHERE a.Numero_Matricula IS NULL;

SELECT DISTINCT a.*
FROM alumno a
INNER JOIN inscripcion i ON a.Numero_Matricula = i.Numero_Matricula
INNER JOIN asignatura s ON i.Codigo_Asignatura = s.Codigo_Asignatura;

SELECT s.* FROM alumno a
INNER JOIN inscripcion i ON a.Numero_Matricula = i.Numero_Matricula
INNER JOIN asignatura s ON i.Codigo_Asignatura = s.Codigo_Asignatura
WHERE a.Numero_Matricula = 1003;




