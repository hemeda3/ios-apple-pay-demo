
import Foundation

struct PaymentRequestV2: Codable {
    let country: String
    let firstName: String
    let lastName: String
    let postalCode: String
    let state: String
    let city: String
    let street1: String
    let region: String
    let purchaseTotals_currency: String
    let purchaseTotals_grandTotalAmount: String
    let email: String
    let creditCardType: String
    let walletType: String
    let token: String
}
class PaymentServiceV2 {
    
    
    func authorizePaymentForSelectedMerchant(paymentToken: String, selectedMerchant: String) -> Result<String, Error> {
            if selectedMerchant == "globalpayments" {
                return authorizePaymentGlobalPay(paymentToken: paymentToken)
            } else if selectedMerchant == "cybersource" {
                return authorizePayment(paymentToken: paymentToken)
            } else {
                return .failure(NSError(domain: "Unknown merchant", code: 0, userInfo: nil))
            }
        }
    
    func authorizePayment(paymentToken: String) -> Result<String, Error> {
        let url = URL(string: "https://d143-70-54-145-52.ngrok-free.app/digitalwallet/cybersource/authorize")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let paymentRequest = PaymentRequestV2(
            country: "US",
            firstName: "US",
            lastName: "US",
            postalCode: "94043",
            state: "CA",
            city: "Mountain View",
            street1: "1600 Amphitheatre Parkway",
            region: "CA",
            purchaseTotals_currency: "USD",
            purchaseTotals_grandTotalAmount: "10",
            email: "ahmed@gmail.com",
            creditCardType: "VISA",
            walletType: "APPLE",
            token: paymentToken
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

    
    func authorizePaymentGlobalPay(paymentToken: String) -> Result<String, Error> {
        
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
