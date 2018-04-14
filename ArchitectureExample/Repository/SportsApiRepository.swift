import RxSwift

class SportsApiRepository {
    
    private let apiClient: ApiClientType
    private let baseURL: URL = URL(string: URLConstants.baseURL)!
    
    required public init(apiClient: ApiClientType) {
        self.apiClient = apiClient
    }
    
    public func getSportList() -> Observable<SportsListEntity?> {
        
        let url = baseURL.appendingPathComponent(ApiPaths.sports.rawValue)
        
        let resource = Resource(url: url, parameters: nil)
        
        return apiClient.getEntity(forResource: resource)
    }
}


