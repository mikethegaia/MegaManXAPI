# MegaMan X API

RESTful API diseñada con fines académicos que servirá de herramienta de asistencia para el gameplay de los juegos de la saga de MegaMan X.

# Tecnologías usadas

- MySQL como manejador de bases de datos relacionales
- Node.js como entorno de ejecución de JavaScript
- Express.js como infraestructura web

# Dependencias utilizadas

- blue-bird : *Uso de promesas*
- body-parser : *Obtiene el contenido de las peticiones*
- dotenv : *Establece variables de entorno para la aplicación*
- express : *Infraestructura de aplicaciones web*
- multer : *Manejador de requests tipo* `multipart/form-data`
- nodemon : *Reinicia la aplicación automáticamente cuando se implementan cambios durante la ejecución*
- promise-mysql : *Wrapper de MySQL que trabaja con promesas*
- pug: *Engine de vistas. POR IMPLEMENTAR.*

# Correr el proyecto

1. Cargar la estructura de `megamanx.sql` a MySQL
2. Acceder al directorio raíz del proyecto e instalar las dependencias con `npm install`.
3. Crear archivo .env para configurar las variables de entorno para la conexión con la base de datos (*MYSQLHOST*, *MYSQLPORT*, *MYSQLUSER*, *MYSQLPASS*, *MYSQLDB*)
4. Iniciar el proyecto con el comando `npm run devstart`.