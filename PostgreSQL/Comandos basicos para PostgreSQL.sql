 sudo -i -u postgres //para entrar al usuario de postgresql desde linux
 psql para entrar 
 
jhon=# SELECT name, setting FROM pg_settings WHERE category = 'File Locations'; //para ver a donde estan los archivos de instalacion



 * postgresql.conf.- Es el archivo de configuraci�n general, aca puedo cambiar la cambiar la cantidad de memoria que puedo utilizar.
        * max_connections=100 #requiere que se reinicie y cada uno gasta 400 bytes por conexi�n.

    * pg_hba.conf.- Se aceptan conexiones solo de LAN o de conexiones cifradas o de solo usuarios del sistema operativo
        * Cuando tengo en METHOD trust no requiere autenticaci�n.
            * TRUST: Si estamos en el mismo servidor. Menos segura, no requiere password.
            * PASSWORD: Requiere password, lo manda en simple texto.
            * MD5: Requiere password, est� cifrado con hash MD5.
            * IDENT: Utiliza el archivo pg_ident.conf, si estamos autenticados con el usuario del sistema operativo podremos ingresar sin autenticaci�n. Debes agregarlo en pg_ident.conf y pg_hba.conf

    * pg_ident.conf.- Sirve para poder autom�ticamente logeo asociando el usuario de postgree al del sistema operativo.
    * data_directory.- Donde se encuentran los tablespaces.
    * �D�nde estan? Normalmente estan /usr/local/postgree o en otro sitio. Tambien lo puedes encontrar con la query: "SELECT name, setting FROM pg_settings WHERE category = 'File Locations';"
    * En psql puedes hacer "\h" para ayuda
    * En psql puedes hacer "\q" para salir
    * �C�mo se modifica? .- Lo m�s seguro es modificar por query.
        * SELECT name, context, unit, setting, boot_val, reset_val FROM pg_settings WHERE name IN ('listen_addresses', 'max_connections', 'shared_buffers', 'effective_cache_size', 'work_mem', 'maintenance_work_mem') ORDER BY context, name; --�C�mo mirar los par�metros de la instancia de base de datos.?
        * Los par�metros que estan con postmaster se pueden cambiar con necesidad de reinicio.
        * Los par�metros user se pueden cambiar en caliente.
        * ALTER SYSTEM set work_mem=8192; --Actualizar la cantidad de memoria. Se guardan en el archivo postgresql.auto.conf, para que se actualicen cuando reinicies el servidor.
        * SELECT pg_reload_conf(); --funci�n que ayuda a recargar a configuraci�n de PostreSQL.

    * SELECT * FROM pg_stat_activity; --�Qui�n tiene actividad en nuestro servidor?
    * SELECT pg_cancel_backend(proc id); --�C�mo terminar la operaci�n de una query?
    * SELECT pg_terminate_backend(proc id); --�C�mo cerrar una session?

    ALTER SYSTEM set work_mem = 8192;//para alterar valores del sistema como work_mem


    SELECT pg_reload_conf();//actualizar las conf


    SELECT * FROM pg_stat_activity;//usuarios conectados


    CREATE ROLE video LOGIN PASSWORD 'bogota'; #para crear un rol

    SELECT * FROM pg_roles;

    DROP ROLE video;#borrar rol

    CREATE ROLE video LOGIN ENCRYPTED PASSWORD 'bogota'; #para crear un rol con contrase�a encriptada
    =
    CREATE ROLE video LOGIN ENCRYPTED PASSWORD 'bogota' VALID UNTIL 'infinity';

    CREATE ROLE video LOGIN ENCRYPTED PASSWORD 'bogota' VALID UNTIL '2016-3-1 00:00';

    CREATE ROLE video LOGIN ENCRYPTED PASSWORD 'bogota' CREATEDB VALID UNTIL '2016-3-1 00:00';

    CREATE ROLE platzi INHERIT; #ES UN ROL GRUPAL 

    GRANT video TO platzi;


    SET ROLE platzi; #impersonar un role para otorgar permisos


    CREATE DATABASE curso_pg; #crear DB

    UPDATE pg_databese SET datistemplate = true WHERE datname = 'curso_pg'; #promover una DB a plantilla


