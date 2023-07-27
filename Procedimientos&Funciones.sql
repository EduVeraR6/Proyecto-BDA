--Punto numero 1

--Procedimiento para agregar un nuevo proyecto:
/*
Nombre: agregar_proyecto
Parámetros:
  - p_nombre (IN): Nombre del proyecto (VARCHAR2)
  - p_descripcion (IN): Descripción del proyecto (VARCHAR2)
  - p_objetivo (IN): Objetivo de financiamiento del proyecto (NUMBER)
Descripción: Agrega un nuevo proyecto a la tabla de proyectos.
*/
CREATE OR REPLACE PROCEDURE agregar_proyecto(p_nombre IN VARCHAR2, p_descripcion IN VARCHAR2, p_objetivo IN NUMBER) AS
BEGIN
  INSERT INTO proyectos (nombre, descripcion, objetivo, total_recaudado, estado) VALUES (p_nombre, p_descripcion, p_objetivo, 0, 'activo');
  COMMIT;
END;

/*
Nombre: desactivar_proyecto
Parámetros:
  - p_id (IN): ID del proyecto a desactivar (NUMBER)
Descripción: Actualiza el estado de un proyecto a 'inactivo' en la tabla de proyectos.
*/

CREATE OR REPLACE PROCEDURE desactivar_proyecto(p_id IN NUMBER) AS
BEGIN
  UPDATE proyectos SET estado = 'inactivo' WHERE proyecto_id = p_id;
  COMMIT;
END;

/*
Nombre: obtener_informacion_proyecto
Parámetros:
  - p_id (IN): ID del proyecto a obtener información (NUMBER)
  - p_info (OUT): Cursor que contiene la información del proyecto (SYS_REFCURSOR)
Descripción: Obtiene la información de un proyecto específico en la tabla de proyectos y devuelve un cursor.
*/

CREATE OR REPLACE PROCEDURE obtener_informacion_proyecto(p_id IN NUMBER, p_info OUT SYS_REFCURSOR) AS
BEGIN
  OPEN p_info FOR SELECT * FROM proyectos WHERE proyecto_id = p_id;
END;

--Funciones

/*
    Nombre: obtener_total_proyectos_activos
Parámetros: Ninguno
Descripción: Devuelve el número total de proyectos que tienen el estado 'activo' en la tabla de proyectos.   
*/

CREATE OR REPLACE FUNCTION obtener_total_proyectos_activos RETURN NUMBER AS
  total_proyectos NUMBER;
BEGIN
  SELECT COUNT(*) INTO total_proyectos FROM proyectos WHERE estado = 'activo';
  RETURN total_proyectos;
END;



/*
Nombre: obtener_total_recaudado_proyecto
Parámetros:
  - p_id (IN): ID del proyecto a obtener el monto total recaudado (NUMBER)
Descripción: Devuelve el monto total recaudado por un proyecto específico en la tabla de proyectos.
*/

CREATE OR REPLACE FUNCTION obtener_total_recaudado_proyecto(p_id IN NUMBER) RETURN NUMBER AS
  total_recaudado NUMBER;
BEGIN
  SELECT total_recaudado INTO total_recaudado FROM proyectos WHERE proyecto_id = p_id;
  RETURN total_recaudado;
END;

