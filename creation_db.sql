CREATE TABLE if NOT EXISTS Usuario (id serial, email varchar unique, activo boolean);
CREATE TABLE if NOT EXISTS Prioridad (id serial, nombre varchar, descripcion varchar);
CREATE TABLE if NOT EXISTS Tarea (id serial, titulo varchar, prioridad_id int, usuario_id int, completado boolean);


ALTER TABLE Prioridad ADD CONSTRAINT llave_Prioridad PRIMARY KEY (id);
ALTER TABLE Tarea
ADD CONSTRAINT llave_TareaPrim FOREIGN KEY (prioridad_id) REFERENCES Prioridad(id);

ALTER TABLE Usuario ADD CONSTRAINT llave_Usuario PRIMARY KEY (id);
ALTER TABLE Tarea
ADD CONSTRAINT llave_UsuarioPrim FOREIGN KEY (usuario_id) REFERENCES Usuario(id);

--@block
INSERT INTO prioridad (nombre, descripcion) VALUES ('ALTA', 'ASAP'), ('MEDIA', 'BYEOD'), ('BAJA','BYEOW');

--@block
INSERT INTO Usuario (email, activo) VALUES ('alumno01@sempaimail.com', 'TRUE'), ('alumno02@sempaimail.com', 'TRUE'), ('alumno03@sempaimail.com', 'FALSE'), ('alumno04@sempaimail.com', 'FALSE'), ('alumno05@sempaimail.com', 'TRUE');

--@block
INSERT INTO Tarea (titulo, prioridad_id, usuario_id, completado ) VALUES ('Realizar Sprint', 1, 1, TRUE), ('Realizar Proyecto Integrador', 1, 2, FALSE), ('Presentar Sprint', 3, 3, FALSE), ('Despejar duda de CSS', 3, 4, TRUE), ('Aprender SQL', 2, 5, TRUE);

--@block
SELECT * FROM tarea;

--@block
SELECT titulo, usuario_id FROM tarea;

--@block
SELECT titulo, usuario_id FROM tarea WHERE completado = FALSE;

--@block
DELETE FROM tarea WHERE titulo = 'Aprender SQL';

--Si se ingresa un email repetido, el sistema da un error porque al crear la tabla agregamos UNIQUE al email.

--No me es posible eliminar una prioridad referenciada a una tarea, ya que para esto debemos configurar esa opcion previamente al crear el FOREING KEY.


--Experimento cambio de tarea
UPDATE tarea
SET completado = TRUE
WHERE id= 2;


--Ultima consigna
UPDATE Tarea
SET completado = CASE WHEN completado = TRUE THEN FALSE ELSE TRUE END 
WHERE id=(SELECT MAX (id) FROM Tarea);