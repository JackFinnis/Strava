//
//  StravaAuthenticator.swift
//  Strava
//
//  Created by Finnis, Jack (PGW) on 12/05/2021.
//

import Foundation
import AuthenticationServices

class StravaAuthenticator: NSObject {
    
    private var authSession: ASWebAuthenticationSession?
    
    private let clientId: String = "65556"
    private let urlScheme: String = "www.jackfinnis.com"
    private let fallbackUrl: String = "yourFallbackUrl"
    private let clientSecret: String = "yourClientSecret"
    
    func presentStravaAuthentication() {
        let url: String = "https://www.strava.com/oauth/mobile/authorize?client_id=\(clientId)&redirect_uri=\(urlScheme)%3A%2F%2F\(fallbackUrl)&response_type=code&approval_prompt=auto&scope=read"
        guard let authenticationUrl = URL(string: url) else { return }
        
        authSession = ASWebAuthenticationSession(url: authenticationUrl, callbackURLScheme: "\(urlScheme)://") { [weak self] url, error in
            if let error = error {
                print(error)
            } else {
                if let code = self?.getCode(from: url) {
                    print(code)
                }
            }
        }

        authSession?.presentationContextProvider = self
        authSession?.start()
    }
    
    func getCode(from url: URL?) -> String? {
        guard let url = url?.absoluteString else { return nil }
        
        let urlComponents: URLComponents? = URLComponents(string: url)
        let code: String? = urlComponents?.queryItems?.filter { $0.name == "code" }.first?.value
        
        return code
    }

    func requestStravaTokens(with code: String) {
        let parameters: [String: Any] = ["client_id": clientId, "client_secret": clientSecret, "code": code, "grant_type": "authorization_code"]

//        AF.request("https://www.strava.com/oauth/token", method: .post, parameters: parameters).response { response in
//            guard let data = response.data else { return }
//
//            if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
//                print(json)
//            }
//        }
    }
}

extension StravaAuthenticator: ASWebAuthenticationPresentationContextProviding {

    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        UIApplication.shared.windows[0]
    }

}
