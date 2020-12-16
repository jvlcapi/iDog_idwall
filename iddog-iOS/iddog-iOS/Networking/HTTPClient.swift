import Alamofire

enum HTTPClient {
    @discardableResult
    static func request<T: Decodable>(
        path: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding,
        headers: HTTPHeaders? = nil,
        onComplete: @escaping (Swift.Result<T, APIError>) -> (Void)
    ) -> DataRequest {
        return Session.default.request(
            url(path: path),
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: headers
        )
        .validate()
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case let .success(decoded):
                onComplete(.success(decoded))
            case let .failure(error):
                onComplete(.failure(APIError.requestFailed(error)))
            }
        }
    }

    private static func url(path: String) -> URLConvertible {
        return "http://iddog-nrizncxqba-uc.a.run.app/\(path)"
    }
}
