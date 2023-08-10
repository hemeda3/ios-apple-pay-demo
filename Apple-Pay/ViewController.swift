import UIKit
import PassKit

class ViewController: UIViewController {
    private var textView: UITextView!
    var dropdownPicker: UIPickerView!
    public var selectedMerchant: String = "globalpayments" // Default selected merchant

    override func viewDidLoad() {
        super.viewDidLoad()
     
        

        payButton()
        buyButton()
        donateButton()
        checkoutButton()
        setupTextView()
        setupDropDownPayments()
    }
     

    private func addHelloLabel() {
        let helloLabel = UILabel()
        helloLabel.translatesAutoresizingMaskIntoConstraints = false
        helloLabel.font = UIFont.systemFont(ofSize: 24)
        helloLabel.text = "Hello to my app"
        view.addSubview(helloLabel)

        view.addConstraint(NSLayoutConstraint(item: helloLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: helloLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1.0, constant: 50))
    }
    
    private func payButton() {
        let paymentButton = PKPaymentButton(paymentButtonType: .inStore, paymentButtonStyle: .black)
        paymentButton.translatesAutoresizingMaskIntoConstraints = false
        paymentButton.addTarget(self, action: #selector(applePayButtonTapped(sender:)), for: .touchUpInside)
        view.addSubview(paymentButton)

        view.addConstraint(NSLayoutConstraint(item: paymentButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: paymentButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1.0, constant: 100))
    }
    
    private func buyButton() {
        let paymentButton = PKPaymentButton(paymentButtonType: .buy, paymentButtonStyle: .black)
        paymentButton.translatesAutoresizingMaskIntoConstraints = false
        paymentButton.addTarget(self, action: #selector(applePayButtonTapped(sender:)), for: .touchUpInside)
        view.addSubview(paymentButton)

        view.addConstraint(NSLayoutConstraint(item: paymentButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: paymentButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1.0, constant: 150))
    }

   

    private func donateButton() {
        let paymentButton = PKPaymentButton(paymentButtonType: .donate, paymentButtonStyle: .black)
        paymentButton.translatesAutoresizingMaskIntoConstraints = false
        paymentButton.addTarget(self, action: #selector(applePayButtonTapped2(sender:)), for: .touchUpInside)
        view.addSubview(paymentButton)

        view.addConstraint(NSLayoutConstraint(item: paymentButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: paymentButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1.0, constant: 200))
    }
   

    private func checkoutButton() {
        let paymentButton = PKPaymentButton(paymentButtonType: .checkout, paymentButtonStyle: .black)
        paymentButton.translatesAutoresizingMaskIntoConstraints = false
        paymentButton.addTarget(self, action: #selector(applePayButtonTapped(sender:)), for: .touchUpInside)
        view.addSubview(paymentButton)

        view.addConstraint(NSLayoutConstraint(item: paymentButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: paymentButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1.0, constant: 250))
    }

    private func setupDropDownPayments() {
           dropdownPicker = UIPickerView()
           dropdownPicker.translatesAutoresizingMaskIntoConstraints = false
           dropdownPicker.dataSource = self
           dropdownPicker.delegate = self
           view.addSubview(dropdownPicker)

           let margin: CGFloat = 16.0

           NSLayoutConstraint.activate([
               dropdownPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
               dropdownPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
               dropdownPicker.bottomAnchor.constraint(equalTo: textView.topAnchor, constant: -margin),
               dropdownPicker.heightAnchor.constraint(equalToConstant: 100)
           ])
       }
    private func setupTextView() {
        textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Payment result details"
        textView.textAlignment = .center
        textView.font = UIFont.systemFont(ofSize: 16) // Adjust the font size as needed
        textView.backgroundColor = .lightGray
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = true // Enable scrolling for displaying larger error details
        textView.layer.cornerRadius = 8.0
        view.addSubview(textView)

        let margin: CGFloat = 16.0
        let height: CGFloat = 200.0 // Increase the height for a larger text area

        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -margin),
            textView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    

    @objc private func applePayButtonTapped(sender: UIButton) {
        payNow()
    }

    @objc private func applePayButtonTapped2(sender: UIButton) {
        payNow2()
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
       // Number of components in the picker (columns)
       func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }

       // Number of rows in the picker
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return 2
       }

       // Title for each row in the picker
       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           if row == 0 {
               return "globalpayments"
           } else {
               return "cybersource"
           }
       }

       // Handle the selection of a row in the picker
       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           if row == 0 {
                           selectedMerchant = "globalpayments"
                       } else {
                           selectedMerchant = "cybersource"
                       }
       }
   }

extension ViewController {
    func payNow() {
        
        print("paynow")
        if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: MyLocalConfigData.paymentInfo()) {
            let request = Payment(id: MyLocalConfigData.merchantInfo(),
                                  currency: MyLocalConfigData.currencyInfo(),
                                  networks: MyLocalConfigData.paymentInfo(),
                                  shipping: nil,
                                  billing: MyLocalConfigData.shippingInfo().address,
                                  methods: MyLocalConfigData.shippingMethodInfo(),
                                  summary: MyLocalConfigData.summaryInfo(),
                                  requiredFields: MyLocalConfigData.shippingInfo().requiredFields).request
            
            
            let authorizationViewController = PKPaymentAuthorizationViewController(paymentRequest: request)

            if let viewController = authorizationViewController {
                viewController.delegate = self
                present(viewController, animated: true, completion: nil)
            }
        }
    }

    func payNow2() {
//        print("paynow2")
//        if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: MyLocalConfigData.paymentInfo()) {
//            let request = Payment(id: MyLocalConfigData.merchantInfo(),
//                                  currency: MyLocalConfigData.currencyInfo(),
//                                  networks: MyLocalConfigData.paymentInfo(),
//                                  shipping: nil,
//                                  billing: nil,
//                                  methods: nil,
//                                  summary: MyLocalConfigData.summaryInfo(),
//                                  requiredFields: []).request
//
//            let authorizationViewController = PKPaymentAuthorizationViewController(paymentRequest: request)
//
//            if let viewController = authorizationViewController {
//                viewController.delegate = self
//                present(viewController, animated: true, completion: nil)
//            }
//        }
    }
    
}


extension ViewController: PKPaymentAuthorizationViewControllerDelegate {
    public func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        dismiss(animated: true, completion: nil)
    }
    public func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
      
        let paymentServicev2 = PaymentServiceV2()
        print (" try 1 start 🔑")
        let token = String(data: payment.token.paymentData, encoding: .utf8)
        let utf8str = token!.data(using: .utf8)
        
        if let base64Encoded = utf8str?.base64EncodedString()
        {
            print("Encoded :  \(base64Encoded)")
            print ("step2 🔑 selectedMerchant \(selectedMerchant)")
            let result = paymentServicev2.authorizePaymentForSelectedMerchant(paymentToken: base64Encoded, selectedMerchant: selectedMerchant)
//            let result = paymentServicev2.authorizePayment(paymentToken: base64Encoded)
                    switch result {
                    case .success(let message):
                             let authorizationText = """
                             Authorization successful:
                             - Merchant ID: \(MyLocalConfigData.merchantInfo())
                             - Selected Merchant: \(selectedMerchant)
                             - Message: \(message)
                             """
                             textView.text = authorizationText
                         case .failure(let error):
                             let errorText = "Authorization failed: \(selectedMerchant) \(error)"
                             textView.text = errorText
                    }
        }
        
//    print(" try5 start 🔑")
//        if let paymentToken = payment.token.paymentData.base64EncodedString() as String? {
//            print("Payment Token: \(paymentToken)")
//            let result = paymentServicev2.authorizePayment(paymentToken: paymentToken)
//            print ("step3 🔑")
//            switch result {
//            case .success(let message):
//                print("Authorization successful: \(message)")
//            case .failure(let error):
//                print("Authorization failed: \(error)")
//            }
            // send paymentToken to backend server for further processing
//        }

//        print(" try6 start 🔑")
//        let paymentDataString = String(data: payment.token.paymentData, encoding: .utf8)!
//        print("Payment Data String: \(paymentDataString)")
        
        // send paymentDataString to backend server for further processing

//        print(" try7 start 🔑")
//        let paymentTokenDict = try? JSONSerialization.jsonObject(with: payment.token.paymentData, options: []) as? [String: Any]
//        print("Payment Token Dictionary: \(String(describing: paymentTokenDict))")
//        // send paymentTokenDict to backend server for further processing
//
//        print(" try8 start 🔑")
//        let paymentTokenJSON = String(data: payment.token.paymentData, encoding: .utf8)!
//        print("Payment Token JSON: \(paymentTokenJSON)")
//        // send paymentTokenJSON to backend server for further processing
//
//        print(" try9 start 🔑")
//        if let paymentToken = payment.token.paymentData.base64EncodedString() as String?,
//           let paymentDataString = String(data: payment.token.paymentData, encoding: .utf8),
//           let paymentTokenDict = try? JSONSerialization.jsonObject(with: payment.token.paymentData, options: []) as? [String: Any],
//           let paymentTokenJSON = String(data: payment.token.paymentData, encoding: .utf8) {
//
//            print("Payment Token: \(paymentToken)")
//            print("Payment Data String: \(paymentDataString)")
//            print("Payment Token Dictionary: \(String(describing: paymentTokenDict))")
//            print("Payment Token JSON: \(paymentTokenJSON)")
//            // send all information to backend server for further processing
//        }
//
//        print(" try10 start 🔑")
//        for index in 1...2 {
//            print("♲ waiting time ... \(index*20)% ♲")
//            sleep(1)
//        }
        
        print("✅ SUCCESS ✅\n")
        return completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
    
    public func paymentAuthorizationViewControllerWillAuthorizePayment(_ controller: PKPaymentAuthorizationViewController) {
        print("🔓 User authenticated")
    }
    
}
