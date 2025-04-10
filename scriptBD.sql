CREATE TABLE Alumno (
    Numero_Matricula INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Grupo VARCHAR(50)
)ENGINE=InnoDB;

CREATE TABLE Profesor (
    Cedula INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Correo_Electronico VARCHAR(100),
    Telefono VARCHAR(20),
    Cargo VARCHAR(50),
    Departamento_Academico VARCHAR(100),
    Fecha_Inicio_Contrato DATE,
    Fecha_Fin_Contrato DATE NULL
)ENGINE=InnoDB;

CREATE TABLE Asignatura (
    Codigo_Asignatura INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Descripcion TEXT,
    Anio_Academico INT,
    Semestre INT,
    Creditos_Academicos INT,
    Horario VARCHAR(100)
)ENGINE=InnoDB;

CREATE TABLE Inscripcion (
    ID_Inscripcion INT PRIMARY KEY AUTO_INCREMENT,
    Numero_Matricula INT,
    Codigo_Asignatura INT,
    Anio_Academico INT,
    Semestre INT,
    FOREIGN KEY (Numero_Matricula) REFERENCES Alumno(Numero_Matricula) 
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (Codigo_Asignatura) REFERENCES Asignatura(Codigo_Asignatura) 
        ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE=InnoDB;

CREATE TABLE Evaluacion (
    ID_Evaluacion INT PRIMARY KEY AUTO_INCREMENT,
    Tipo ENUM('Escrito', 'Práctico', 'Oral'),
    Fecha DATE
)ENGINE=InnoDB;

CREATE TABLE Alumno_Evaluacion (
    ID_Alumno_Evaluacion INT PRIMARY KEY AUTO_INCREMENT,
    Numero_Matricula INT,
    ID_Evaluacion INT,
    Nota DECIMAL(5,2),
    FOREIGN KEY (Numero_Matricula) REFERENCES Alumno(Numero_Matricula) 
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (ID_Evaluacion) REFERENCES Evaluacion(ID_Evaluacion) 
        ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE=InnoDB;

CREATE TABLE Control_Escrito (
    ID_Control INT PRIMARY KEY AUTO_INCREMENT,
    ID_Evaluacion INT,
    Numero_Control INT,
    Numero_Preguntas INT,
    Ponderacion_Teorica_Conceptual DECIMAL(5,2),
    Ponderacion_Redaccion_Ortografia DECIMAL(5,2),
    FOREIGN KEY (ID_Evaluacion) REFERENCES Evaluacion(ID_Evaluacion) 
        ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE=InnoDB;

CREATE TABLE Examen_Practico (
    ID_Examen INT PRIMARY KEY AUTO_INCREMENT,
    ID_Evaluacion INT,
    Ponderacion_Eficiencia_Tiempo DECIMAL(5,2),
    Ponderacion_Componente_Laboratorio DECIMAL(5,2),
    FOREIGN KEY (ID_Evaluacion) REFERENCES Evaluacion(ID_Evaluacion) 
        ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE=InnoDB;

CREATE TABLE Tema (
    ID_Tema INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100),
    Descripcion TEXT,
    Nivel_Dificultad ENUM('Bajo', 'Medio', 'Alto'),
    Recursos_Asociados TEXT NULL
)ENGINE=InnoDB;

CREATE TABLE Evaluacion_Tema (
    ID_Evaluacion INT,
    ID_Tema INT,
    PRIMARY KEY (ID_Evaluacion, ID_Tema),
    FOREIGN KEY (ID_Evaluacion) REFERENCES Evaluacion(ID_Evaluacion) 
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (ID_Tema) REFERENCES Tema(ID_Tema) 
        ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE=InnoDB;

CREATE TABLE Asignatura_Tema (
    Codigo_Asignatura INT,
    ID_Tema INT,
    PRIMARY KEY (Codigo_Asignatura, ID_Tema),
    FOREIGN KEY (Codigo_Asignatura) REFERENCES Asignatura(Codigo_Asignatura) 
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (ID_Tema) REFERENCES Tema(ID_Tema) 
        ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE=InnoDB;

CREATE TABLE Practica (
    Codigo_Practica INT PRIMARY KEY,
    Titulo VARCHAR(150),
    Nivel_Dificultad ENUM('Bajo', 'Medio', 'Alto'),
    Tipo_Practica ENUM('Individual', 'Grupo'),
    Fecha_Diseno DATE
)ENGINE=InnoDB;

CREATE TABLE Profesor_Practica (
    Cedula INT,
    Codigo_Practica INT,
    PRIMARY KEY (Cedula, Codigo_Practica),
    FOREIGN KEY (Cedula) REFERENCES Profesor(Cedula) 
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (Codigo_Practica) REFERENCES Practica(Codigo_Practica) 
        ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE=InnoDB;

CREATE TABLE Realiza_Practica (
    ID_Realiza_Practica INT PRIMARY KEY AUTO_INCREMENT,
    Numero_Matricula INT,
    Codigo_Practica INT,
    Fecha DATE,
    Nota DECIMAL(5,2),
    FOREIGN KEY (Numero_Matricula) REFERENCES Alumno(Numero_Matricula) 
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (Codigo_Practica) REFERENCES Practica(Codigo_Practica) 
        ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE=InnoDB;

CREATE TABLE Profesor_Asignatura (
    Cedula INT,
    Codigo_Asignatura INT,
    PRIMARY KEY (Cedula, Codigo_Asignatura),
    FOREIGN KEY (Cedula) REFERENCES Profesor(Cedula) 
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (Codigo_Asignatura) REFERENCES Asignatura(Codigo_Asignatura) 
        ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE=InnoDB;
