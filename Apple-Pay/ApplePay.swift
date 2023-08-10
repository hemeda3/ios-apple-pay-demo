//import Foundation
//import PassKit
//
//class ApplePay: NSObject {
//    
//    // MARK: - Properties
//    
//    private let paymentNetworks: [PKPaymentNetwork]
//    private let merchantID: String
//    private let currency: Currency
//    private let shippingMethods: [PKShippingMethod]?
//    private let paymentSummaryItems: [PKPaymentSummaryItem]
//    private let shippingContact: Contact?
//    private let delegate: PKPaymentAuthorizationViewControllerDelegate
//    private let viewController: UIViewController
//    
//    private var paymentTokenCompletion: ((PKPaymentToken?, Error?) -> Void)?
//    private var paymentAuthorizationCompletion: ((PKPaymentAuthorizationResult) -> Void)?
//    
//    // MARK: - Initializers
//    
//    init(paymentNetworks: [PKPaymentNetwork],
//         merchantID: String,
//         currency: Currency,
//         paymentSummaryItems: [PKPaymentSummaryItem],
//         shippingMethods: [PKShippingMethod]? = nil,
//         shippingContact: Contact? = nil,
//         delegate: PKPaymentAuthorizationViewControllerDelegate,
//         viewController: UIViewController) {
//        self.paymentNetworks = paymentNetworks
//        self.merchantID = merchantID
//        self.currency = currency
//        self.shippingMethods = shippingMethods
//        self.paymentSummaryItems = paymentSummaryItems
//        self.shippingContact = shippingContact
//        self.delegate = delegate
//        self.viewController = viewController
//    }
//    
//    // MARK: - Public Methods
//    
//    func startPayment(completion: @escaping (PKPaymentToken?, Error?) -> Void) {
//        paymentTokenCompletion = completion
//        let paymentRequest = createPaymentRequest()
//        let paymentAuthorizationVC = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest)
//        paymentAuthorizationVC?.delegate = delegate
//        viewController.present(paymentAuthorizationVC!, animated: true, completion: nil)
//    }
//    
//    // MARK: - Private Methods
//    
//    private func createPaymentRequest() -> PKPaymentRequest {
//        let paymentRequest = PKPaymentRequest()
//        paymentRequest.merchantIdentifier = merchantID
//        paymentRequest.countryCode = currency.country
//        paymentRequest.currencyCode = currency.id
//        paymentRequest.supportedNetworks = paymentNetworks
//        paymentRequest.merchantCapabilities = .capability3DS
//        paymentRequest.requiredShippingContactFields = [.emailAddress, .name, .postalAddress, .phone]
//        paymentRequest.requiredBillingContactFields = [.emailAddress, .name, .postalAddress, .phone]
//        paymentRequest.paymentSummaryItems = paymentSummaryItems
//        if let shippingMethods = shippingMethods {
//            paymentRequest.shippingMethods = shippingMethods
//        }
//        if let shippingContact = shippingContact {
//            paymentRequest.shippingContact = shippingContact.asPKContact()
//            paymentRequest.billingContact = shippingContact.asPKContact()
//        }
//        return paymentRequest
//    }
//}
//
//// MARK: - PKPaymentAuthorizationViewControllerDelegate
//
//extension ApplePay: PKPaymentAuthorizationViewControllerDelegate {
//    
//    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
//        controller.dismiss(animated: true, completion: nil)
//    }
//    
//    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController,
//                                            didAuthorizePayment payment: PKPayment,
//                                            handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
//        let paymentToken = payment.token
//        let paymentResult = PKPaymentAuthorizationResult(status: .success, errors: nil)
//        paymentAuthorizationCompletion = completion
//        paymentTokenCompletion?(paymentToken, nil)
//    }
//}
