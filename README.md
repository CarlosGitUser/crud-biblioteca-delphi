# CRUD_Biblioteca

## Descripción del Proyecto
Este proyecto es una aplicación de escritorio desarrollada en Delphi para la gestión de una biblioteca. Permite realizar operaciones CRUD (Crear, Leer, Actualizar, Eliminar) sobre libros, usuarios y préstamos. El sistema está diseñado para facilitar la administración básica de una biblioteca.

## Funcionalidades
El sistema `CRUD_Biblioteca` ofrece las siguientes funcionalidades principales:

### Gestión de Libros
-   **Alta de Libros**: Permite añadir nuevos libros al inventario de la biblioteca (`UAltaLibro.pas`).
-   **Consulta de Libros**: Visualización y búsqueda de libros existentes (`ULibros.pas`).
-   **Modificación de Libros**: Edición de la información de libros previamente registrados (`UModificarLibros.pas`).

### Gestión de Usuarios
-   **Alta de Usuarios**: Permite registrar nuevos usuarios de la biblioteca (`UAltaUsuario.pas`).
-   **Consulta de Usuarios**: Visualización y búsqueda de usuarios existentes (`UUsuarios.pas`).
-   **Modificación de Usuarios**: Edición de la información de usuarios registrados (`UModificarUsuario.pas`).

### Gestión de Préstamos
-   **Alta de Préstamos**: Registro de nuevos préstamos de libros a usuarios (`UAltaPrestamo.pas`).
-   **Consulta de Préstamos**: Visualización de los préstamos activos y su estado (`UPrestamos.pas`).

## Alcance del Proyecto
El alcance de este proyecto se centra en proporcionar una herramienta fundamental para la administración interna de una biblioteca, cubriendo las necesidades básicas de gestión de inventario (libros), miembros (usuarios) y transacciones (préstamos).

### Tecnologías Utilizadas
-   **Delphi**: Lenguaje de programación y entorno de desarrollo.
-   **Archivos DFM**: Archivos de definición de formularios visuales para la interfaz de usuario.
-   **Módulos de Datos**: Gestión de la conexión y acceso a la base de datos (`dmData.pas`).
