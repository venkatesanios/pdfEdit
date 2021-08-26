# pdfEdit
PDF File Edit and Resave
//
//  ViewController.swift
//  Excelway
//
//  Created by VenkatesanMACBook on 17/08/21.
//

import UIKit
import PDFKit
 import PencilKit

class ViewController: UIViewController {
    var pdfView = PDFView()
     var btn = UIButton()
    var pdfimage = UIImage()
    @IBOutlet weak var backgroundView : UIView! = UIView()
     var pdfData = Data()
    var Pdfstr = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        backgroundView?.frame = CGRect(x: 0, y: 50, width: view.frame.size.width, height: view.frame.size.height)
        backgroundView?.translatesAutoresizingMaskIntoConstraints = true
         backgroundView?.backgroundColor = .red
         self.view.addSubview(backgroundView)
 
        pdfView.frame = CGRect(x: 0, y: 0, width: backgroundView .frame.size.width, height: backgroundView .frame.size.height)
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addSubview(pdfView)
 
          setupPDF()
     }
 
    
       
    func setupPDF() {
        
        let path = Bundle.main.path(forResource: "sample", ofType: "pdf")!
        
        let pdfURL = NSURL(fileURLWithPath: path)

        let pdfDocument = PDFDocument(url: pdfURL as URL)
 
        pdfData = try! Data.init(contentsOf: pdfURL as URL)

        
        Pdfstr = (pdfDocument?.string)!
        
         pdfView.document = pdfDocument
        
         btn.frame = CGRect(x: 10, y: 100, width: 50, height: 50)
        btn.layer.cornerRadius = 25
        btn.clipsToBounds = true
        btn.settiltleImage(
         btn.addTarget(self, action: #selector(shareAction(sender:)), for: .touchUpInside)
        btn.setTitleColor(.darkGray, for: .normal)
        btn.backgroundColor = .red
        pdfView.addSubview(btn)
         self.view.addSubview(pdfView)
        
     
    }
          @objc func shareAction(sender: UIButton) {
            
             let vc = UIActivityViewController(activityItems: [pdfData], applicationActivities: [])
           present(vc, animated: true, completion: nil)
             
 
        }
        
 


}
