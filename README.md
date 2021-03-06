# MegaMan X API

RESTful API diseñada con fines académicos que servirá de herramienta de asistencia para el gameplay de los juegos de la saga de MegaMan X.

# Tecnologías utilizadas

- MySQL como manejador de bases de datos relacionales
- Node.js como entorno de ejecución de JavaScript
- Express.js como infraestructura web

# Dependencias utilizadas

- blue-bird : *Uso de promesas*
- body-parser : *Obtiene el contenido de las peticiones*
- dotenv : *Establece variables de entorno para la aplicación*
- express : *Infraestructura de aplicaciones web*
- fs : *Manejador de archivos*
- multer : *Manejador de requests tipo* `multipart/form-data`
- nodemon : *Reinicia la aplicación automáticamente cuando se implementan cambios durante la ejecución*
- promise-mysql : *Wrapper de MySQL que trabaja con promesas*
- pug: *Engine de vistas. POR IMPLEMENTAR.*

# Correr el proyecto

1. Cargar la estructura de `megamanx.sql` a MySQL
2. Acceder al directorio raíz del proyecto e instalar las dependencias con `npm install`.
3. Crear archivo .env para configurar las variables de entorno para la conexión con la base de datos (*MYSQLHOST*, *MYSQLPORT*, *MYSQLUSER*, *MYSQLPASS*, *MYSQLDB*)
4. Iniciar el proyecto con el comando `npm run devstart`.
5. Cargar la siguiente colección en Postman para la inserción y consulta de registros en la base de datos: https://drive.google.com/file/d/1295Gor_wKYKb7--Khf50ktWGrOe6Elnm/view?usp=sharing

# Pendientes

1. Actualización y eliminación de registros (PUT y DELETE)
2. Autenticación mediante JWT para las operaciones de inserción, actualización y eliminación de registros
3. Validación del formato de las peticiones POST y PUT
4. Mejoras en las respuestas (evitar revelar información sobre la estructura de la base de datos)
5. Aplicación de seguridad (XSS, SQL Injection, etc.)
6. Implementación de front-end