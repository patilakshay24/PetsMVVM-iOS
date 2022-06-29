//
//  DetailedViewController.swift
//  Dummy
//
//  Created by Akshay Patil on 28/06/22.
//

import Foundation
import UIKit
import WebKit

class DetailedViewController: UIViewController {
    
    var petViewModel : PetViewModel!
    
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: petViewModel.pet.content_url) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
