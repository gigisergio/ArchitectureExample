# Librerias
- Alamofire: networking

- AlamofireImage: gestíon de obtención de imágenes

- Swinject: inyección de dependencias

- RxSwift: transmision reactiva de datos

- RxCocoa: añade “reactividad” a las clases de Cocoa

- RxDataSource: implementacion de RxSwift para tablas y coleccione


# Estructura de archivos + arquitectura

- Common: Archivos de uso común

  - DependencyInjection: Se declaran las clases que usan inyeccion de dependencias. Se us Swinject

  - NavigableProtocol: Define los protocolos que permiten navegar a diferentes escenas

  - Extensiones: extensiones de clases para sumar funcionalidad a ciertas clases

  - Style: Definición de los estilos y su aplicación a cada tipo de vista

- General: Clases padre de clas clases de las escenas

- Screen: Grupos de clases que definen cada escena

  - XRouter:
    - Reponsable de la creación de la escena, usando Swinject.
    - Encapsula la navegación a otras escenas.

  - XViewModel:
    - Responsable de obtener datos y formatearlos para la vista.
    - Recibe acciones en vista y actua en consecuencia.
    - Se le inyectan casos de uso y routers.

  - XViewController:
    - Responsable de la composición de las vistas.
    - Obtiene los datos del ViewModel para presentarlos
    - Se le inyecta un viewModel.

- UseCase:
  - Define y entrega datos concretos recibiendo los parametros necesarios.
  - Se le inyectan los servicios necesarios.

- Service:
  - NO existe en este ejemplo, pero se podría insertar entre useCase y Repository para gestionar el uso entre datos de api y base de datos (por ejemplo, para guardar datos que llegan de un servicio en una base de datos)

- Repository:
  - Define las llamadas a un api externo, una base de datos, una cache…
  - Se le inyectan los clientes de servicio o de base de datos necesarios

- Client:
  - Cliente genérico que encapsula el mecanismo de peticiones a red

- Model:
  - Definición de entidades y protocolos

- Resources:
  - Agrupa recursos “físicos” necesarios

- Support:
  - todo lo demás…
