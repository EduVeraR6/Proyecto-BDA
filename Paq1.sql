--Paquete para manejar las donaciones
/*
Este paquete se encarga de manejar las donaciones realizadas a los proyectos. 
Contiene dos procedimientos y dos funciones que utilizan un parámetro tipo cursor.
*/

CREATE OR REPLACE PACKAGE manejo_donaciones AS

  TYPE cur_t IS REF CURSOR;

  PROCEDURE agregar_donacion(p_id_proyecto IN NUMBER, p_cantidad IN NUMBER);
  PROCEDURE eliminar_donacion(p_id_donacion IN NUMBER);
  FUNCTION obtener_total_donado_proyecto(p_id_proyecto IN NUMBER) RETURN NUMBER;
  FUNCTION obtener_donaciones_proyecto(p_id_proyecto IN NUMBER) RETURN cur_t;

END manejo_donaciones;

--El primer procedimiento, agregar_donacion,
--agrega una nueva donación a la tabla de donaciones. Toma como entrada el ID del proyecto y la cantidad donada.

PROCEDURE agregar_donacion(p_id_proyecto IN NUMBER, p_cantidad IN NUMBER) IS
BEGIN
  UPDATE proyectos
  SET total_donaciones = total_donaciones + p_cantidad
  WHERE id_proyecto = p_id_proyecto;
  
  COMMIT;
END agregar_donacion;


--El segundo procedimiento, eliminar_donacion, elimina una donación de la tabla de donaciones. Toma como entrada el ID de la donación.El segundo procedimiento, eliminar_donacion, 
--elimina una donación de la tabla de donaciones. Toma como entrada el ID de la donación.

PROCEDURE eliminar_donacion(p_id_donacion IN NUMBER) IS
  v_cantidad_donacion NUMBER;
  v_id_proyecto NUMBER;
BEGIN
  SELECT cantidad_donacion, id_proyecto
  INTO v_cantidad_donacion, v_id_proyecto
  FROM donaciones
  WHERE id_donacion = p_id_donacion;
  
  DELETE FROM donaciones
  WHERE id_donacion = p_id_donacion;
  
  UPDATE proyectos
  SET total_donaciones = total_donaciones - v_cantidad_donacion
  WHERE id_proyecto = v_id_proyecto;
  
  COMMIT;
END eliminar_donacion;



--La primera función, obtener_total_donado_proyecto, 
--devuelve el monto total donado a un proyecto específico en la tabla de donaciones. Toma como entrada el ID del proyecto.

FUNCTION obtener_total_donado_proyecto(p_id_proyecto IN NUMBER) RETURN NUMBER IS
  v_total_donado NUMBER;
BEGIN
  SELECT total_donaciones
  INTO v_total_donado
  FROM proyectos
  WHERE id_proyecto = p_id_proyecto;
  
  RETURN v_total_donado;
END obtener_total_donado_proyecto;



--La segunda función, obtener_donaciones_proyecto, devuelve un cursor que contiene todas las donaciones
--realizadas a un proyecto específico en la tabla de donaciones. Toma como entrada el ID del proyecto.

FUNCTION obtener_donaciones_proyecto(p_id_proyecto IN NUMBER) RETURN cur_t IS
  v_cursor cur_t;
BEGIN
  OPEN v_cursor FOR
    SELECT *
    FROM donaciones
    WHERE id_proyecto = p_id_proyecto;
    
  RETURN v_cursor;
END obtener_donaciones_proyecto;










