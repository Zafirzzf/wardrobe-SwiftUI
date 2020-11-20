//
//  Request.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/16.
//

import Foundation
import Combine
import Alamofire

enum RequestMethod {
    case get
    case post
}

protocol Request {
    var path: String { get }
    var method: RequestMethod { get }
    var parame: [String: Any] { get }
    var headers: [String: String] { get }
}

extension Request {
    var method: RequestMethod { .get }
    var headers: [String: String] { [:] }
}


extension Request {
    func requestModel<T: Decodable>(_ model: T.Type) -> Future<T, Error> {
        Future { promise in
            Alamofire.AF.request(path, method: method == .get ? .get : .post,
                                 parameters: parame,
                                 encoding: URLEncoding.default,
                                 headers: HTTPHeaders(headers),
                                 interceptor: nil,
                                 requestModifier: nil).responseDecodable(of: T.self) { reponse in
                                    switch reponse.result {
                                    case .success(let model):
                                        promise(.success(model))
                                    case .failure(let error):
                                        promise(.failure(RequestError.other))
                                    }
                                 }
        }
    }
    func requestJSON() -> Future<[String: Any], Error> {
        Future { promise in
            Alamofire.AF.request(path, method: method == .get ? .get : .post,
                                 parameters: parame,
                                 encoding: URLEncoding.default,
                                 headers: HTTPHeaders(headers),
                                 interceptor: nil,
                                 requestModifier: nil).responseJSON { response in
                                    switch response.result {
                                    case .success(let resultAny):
                                        if let json = resultAny as? [String: Any] {
                                            promise(.success(json))
                                        } else {
                                            promise(.failure(RequestError.other))
                                        }
                                    case .failure(let error):
                                        promise(.failure(RequestError.other))
                                    }
                                 }
        }
    }
}
