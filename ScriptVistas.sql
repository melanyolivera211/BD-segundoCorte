SELECT DISTINCT
    A.Numero_Matricula,
    A.Nombre AS Nombre_Alumno,
    ASIG.Codigo_Asignatura,
    ASIG.Nombre AS Nombre_Asignatura,
    P.Cedula,
    P.Nombre AS Nombre_Profesor,
    E.ID_Evaluacion,
    E.Tipo,
    AE.Nota
FROM Alumno A
JOIN Inscripcion I ON A.Numero_Matricula = I.Numero_Matricula
JOIN Asignatura ASIG ON I.Codigo_Asignatura = ASIG.Codigo_Asignatura
JOIN Profesor_Asignatura PA ON ASIG.Codigo_Asignatura = PA.Codigo_Asignatura
JOIN Profesor P ON PA.Cedula = P.Cedula
LEFT JOIN Alumno_Evaluacion AE ON A.Numero_Matricula = AE.Numero_Matricula
LEFT JOIN Evaluacion E ON AE.ID_Evaluacion = E.ID_Evaluacion;

CREATE VIEW Vista_Alumnos_Profesores_Evaluaciones AS
SELECT DISTINCT
    A.Numero_Matricula,
    A.Nombre AS Nombre_Alumno,
    ASIG.Codigo_Asignatura,
    ASIG.Nombre AS Nombre_Asignatura,
    P.Cedula,
    P.Nombre AS Nombre_Profesor,
    E.ID_Evaluacion,
    E.Tipo,
    AE.Nota
FROM Alumno A
JOIN Inscripcion I ON A.Numero_Matricula = I.Numero_Matricula
JOIN Asignatura ASIG ON I.Codigo_Asignatura = ASIG.Codigo_Asignatura
JOIN Profesor_Asignatura PA ON ASIG.Codigo_Asignatura = PA.Codigo_Asignatura
JOIN Profesor P ON PA.Cedula = P.Cedula
LEFT JOIN Alumno_Evaluacion AE ON A.Numero_Matricula = AE.Numero_Matricula
LEFT JOIN Evaluacion E ON AE.ID_Evaluacion = E.ID_Evaluacion;

SELECT * FROM Vista_Alumnos_Profesores_Evaluaciones;

CREATE OR REPLACE VIEW Vista_Alumnos_Profesores_Evaluaciones AS
SELECT DISTINCT
    A.Numero_Matricula,
    A.Nombre AS Nombre_Alumno,
    ASIG.Codigo_Asignatura,
    ASIG.Nombre AS Nombre_Asignatura,
    P.Cedula,
    P.Nombre AS Nombre_Profesor,
    AE.Nota
FROM Alumno A
JOIN Inscripcion I ON A.Numero_Matricula = I.Numero_Matricula
JOIN Asignatura ASIG ON I.Codigo_Asignatura = ASIG.Codigo_Asignatura
JOIN Profesor_Asignatura PA ON ASIG.Codigo_Asignatura = PA.Codigo_Asignatura
JOIN Profesor P ON PA.Cedula = P.Cedula
LEFT JOIN Alumno_Evaluacion AE ON A.Numero_Matricula = AE.Numero_Matricula;

