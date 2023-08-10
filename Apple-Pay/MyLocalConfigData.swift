import Foundation
import PassKit

struct MyLocalConfigData {
    static func merchantInfo() -> String {
        if let viewController = UIApplication.shared.keyWindow?.rootViewController as? ViewController {
            let selectedMerchant = viewController.selectedMerchant
            if selectedMerchant == "globalpayments" {
                print("Returning merchant identifier for globalpayments")
                return "merchant.com.loblaw.dev.globalpay1"
            } else if selectedMerchant == "cybersource" {
                print("Returning merchant identifier for cybersource")
                return "merchant.com.mapledoum.cybersource1"
            }
        }
        print("Defaulting to merchant identifier for globalpayments")
        return "merchant.com.mapledoum.globalpay1" // Default value if the view controller is not accessible or selectedMerchant is not recognized
    }

    
    static func currencyInfo() -> Currency {
        return Currency(country: "US",
                        id: "USD")
    }
    
    static func shippingInfo() -> Contact {
        let contact = Contact(email: "kingstonsdn@gmail.com",
                              name: "John Doe",
                              cap: "M4M 2G3",
                              street: "231 Broadview Ave",
                              country: "Canada",
                              countryCode: "CA",
                              city: "Toronto",
                              state: "ON",
                              phone: "555-123-4567",
                              requiredFields: [.postalAddress, .emailAddress, .name])
        return contact
    }
    
    static func shippingMethodInfo() -> [PKShippingMethod] {
        let shipping = Shipping(id: "fast",
                                detail: "1 day shipping",
                                title: "Fast shipping",
                                amount: 0.00)
        return [shipping.method]
    }
    static func summaryInfo() -> [PKPaymentSummaryItem] {
        let tshirt = Item(label: "Subtotal", amount: 1.00).summary
        let shipping = Item(label: "Shipping", amount: 1.00).summary
        let tax = Item(label: "Sales Tax", amount: 0.00).summary
        let total = Item(label: "Total", amount: 10.00).summary
        return [tshirt, shipping, tax, total]
    }

    static func paymentInfo() -> [PKPaymentNetwork] {
        return [.amex, .masterCard, .visa]
    }

    static func fakeError() -> Error {
        return PKPaymentRequest.paymentShippingAddressUnserviceableError(withLocalizedDescription: "!Fatal error!")
    }
}

