set serveroutput on;
DECLARE
   CURSOR c_objects IS
      SELECT owner, object_name, object_type
      FROM dba_objects
      WHERE status = 'INVALID';

   v_compile_errors BOOLEAN := FALSE;
BEGIN
   -- Recorre todos los objetos inválidos y los compila
   FOR obj IN c_objects LOOP
      BEGIN
         IF obj.object_type IN ('PACKAGE', 'PACKAGE BODY') THEN
            EXECUTE IMMEDIATE 'ALTER ' || obj.object_type || ' ' || obj.owner || '.' || obj.object_name || ' COMPILE';
         ELSIF obj.object_type = 'TRIGGER' THEN
            EXECUTE IMMEDIATE 'ALTER TRIGGER ' || obj.owner || '.' || obj.object_name || ' COMPILE';
         ELSE
            EXECUTE IMMEDIATE 'ALTER ' || obj.object_type || ' ' || obj.owner || '.' || obj.object_name || ' COMPILE ' || obj.object_type;
         END IF;
      EXCEPTION
         WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al compilar el objeto: ' || obj.owner || '.' || obj.object_name || ' - ' || SQLERRM);
            v_compile_errors := TRUE;
      END;
   END LOOP;

   -- Verifica si hubo errores durante la compilación
   IF v_compile_errors THEN
      DBMS_OUTPUT.PUT_LINE('Se encontraron errores durante la compilación de objetos inválidos.');
   ELSE
      DBMS_OUTPUT.PUT_LINE('Todos los objetos inválidos han sido compilados correctamente.');
   END IF;
END;
/

