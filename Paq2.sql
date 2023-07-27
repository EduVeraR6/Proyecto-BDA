--Paquete para manejar los usuarios

/*
Este paquete se encarga de manejar los usuarios que se registran en la plataforma de crowdfunding.
Contiene dos procedimientos y dos funciones que utilizan un parámetro tipo cursor.
*/

CREATE OR REPLACE PACKAGE manejo_usuarios AS

  TYPE cur_t IS REF CURSOR;

  PROCEDURE registrar_usuario(p_nombre IN VARCHAR2, p_correo IN VARCHAR2, p_contrasena IN VARCHAR2);
  PROCEDURE eliminar_usuario(p_id_usuario IN NUMBER);
  FUNCTION obtener_informacion_usuario(p_id_usuario IN NUMBER) RETURN cur_t;
  FUNCTION validar_credenciales(p_correo IN VARCHAR2, p_contrasena IN VARCHAR2) RETURN NUMBER;

END manejo_usuarios;

--El primer procedimiento, registrar_usuario, agrega un nuevo usuario a la tabla de usuarios. 
--Toma como entrada el nombre, correo y contraseña del usuario.

PROCEDURE registrar_usuario(p_nombre IN VARCHAR2, p_correo IN VARCHAR2, p_contrasena IN VARCHAR2) IS
BEGIN
  INSERT INTO usuarios(nombre, correo, contrasena)
  VALUES(p_nombre, p_correo, p_contrasena);
  
  COMMIT;
END registrar_usuario;



--El segundo procedimiento, eliminar_usuario, elimina un usuario de la tabla de usuarios. Toma como entrada el ID del usuario.

PROCEDURE eliminar_usuario(p_id_usuario IN NUMBER) IS
BEGIN
  DELETE FROM usuarios
  WHERE id_usuario = p_id_usuario;
  
  COMMIT;
END eliminar_usuario;



--La primera función, obtener_informacion_usuario, devuelve un cursor que contiene la información de 
--un usuario específico en la tabla de usuarios. Toma como entrada el ID del usuario.

FUNCTION obtener_informacion_usuario(p_id_usuario IN NUMBER) RETURN cur_t IS
  v_cursor cur_t;
BEGIN
  OPEN v_cursor FOR
    SELECT *
    FROM usuarios
    WHERE id_usuario = p_id_usuario;
  
  RETURN v_cursor;
END obtener_informacion_usuario;



--Esta función toma como entrada el correo y la contraseña de un usuario, y devuelve el ID del usuario si las credenciales son válidas, o 0 si no lo son.

FUNCTION validar_credenciales(p_correo IN VARCHAR2, p_contrasena IN VARCHAR2) RETURN NUMBER IS
  v_id_usuario NUMBER;
BEGIN
  SELECT id_usuario INTO v_id_usuario
  FROM usuarios
  WHERE correo = p_correo AND contrasena = p_contrasena;
  
  RETURN v_id_usuario;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 0;
END validar_credenciales;



