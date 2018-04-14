import RxSwift

protocol ApiClientType {
    func getEntity<T:Decodable>(forResource resource: ResourceType) -> Observable<T?>
    func getEntitiyList<T:Decodable>(forResource resource: ResourceType) -> Observable<[T]>
}
