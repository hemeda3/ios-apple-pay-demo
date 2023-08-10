import Foundation

struct PaymentRequest: Codable {
    let amount: String
    let authCode: String
    let currency: String
    let digitalPaymentToken: String?
    let orderId: String
    let transactionId: String
    let walletType: String
}

class PaymentService {
    
     
    func authorizePayment(paymentToken: String) -> Result<String, Error> {
        
        let url = URL(string: "https://d143-70-54-145-52.ngrok-free.app/digitalwallet/globalpay/authorize")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
   
     
        let paymentRequest = PaymentRequest(
            amount: "10",
            authCode: "authCode",
            currency: "USD",
            digitalPaymentToken: paymentToken,
            orderId: "orderId11111",
            transactionId: "transaction111",
            walletType: "APPLE"
        )
        
        print ("step A 🔑")
        do {
            let jsonData = try JSONEncoder().encode(paymentRequest)
            urlRequest.httpBody = jsonData
            print ("step AA 🔑")
        } catch {
            return .failure(error)
        }
        
        
        print ("step B 🔑")
        var result: Result<String, Error>?
        let group = DispatchGroup()
        group.enter()
        print ("step c 🔑")
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                result = .failure(error)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    result = .success("Authorization successful")
                } else {
                    if let data = data {
                        do {
                            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                               let errorMessage = json["message"] as? String {
                                result = .failure(NSError(domain: errorMessage, code: httpResponse.statusCode, userInfo: nil))
                            } else {
                                result = .failure(NSError(domain: "Authorization failed with status code: \(httpResponse.statusCode)", code: httpResponse.statusCode, userInfo: nil))
                            }
                        } catch {
                            result = .failure(error)
                        }
                    } else {
                        result = .failure(NSError(domain: "Authorization failed with status code: \(httpResponse.statusCode)", code: httpResponse.statusCode, userInfo: nil))
                    }
                }
            } else {
                result = .failure(NSError(domain: "Invalid response", code: 0, userInfo: nil))
            }
            group.leave()
        }

        
        task.resume()
        group.wait()
        
        return result ?? .failure(NSError(domain: "Unknown error", code: 0, userInfo: nil))
    }
}
