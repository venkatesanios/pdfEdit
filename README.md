# pdfEdit
PDF File Edit and Resave
//
//  ViewController.swift
//   
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
        
        
        //Local Pdf file import your projects
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
            // Pdf file data send to activity controller in swift
             let vc = UIActivityViewController(activityItems: [pdfData], applicationActivities: [])
           present(vc, animated: true, completion: nil)
             
 
        }
        
 


}







//MARK:- PDF Another Using image capture in ScreenShot

    func captureScreen() -> UIImage
    {

        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, false, 0);

        self.view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)

        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!

        UIGraphicsEndImageContext()
        print("\nimage\n",image)
        return image
    }
      
      @objc func pdfformatconverAction()
      {
        let Image = captureScreen()
         let myImage = UIImageView(image: Image)
 
           createPDFfromUIViews(myImage, saveToDocumentsWithFileName: "PDF Name")
          
      }
       func createPDFfromUIViews(_ myImage: UIView?, saveToDocumentsWithFileName string: String?)
      {
          let pdfData = NSMutableData()

          UIGraphicsBeginPDFContextToData(pdfData , myImage!.bounds, nil)
          UIGraphicsBeginPDFPage()
          let pdfContext = UIGraphicsGetCurrentContext()
 

          if let pdfContext = pdfContext {
              myImage?.layer.render(in: pdfContext)
          }

          // remove PDF rendering context
          UIGraphicsEndPDFContext()
          
          var docURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
          docURL = docURL.appendingPathComponent("Reports.pdf")
          pdfData.write(to: docURL as URL, atomically: true)
          savePdf(urlString:docURL)
      }
       func savePdf(urlString:URL)
      {
              DispatchQueue.main.async
              {
                  self.viewurl = urlString
                  let pdfData = try? Data.init(contentsOf: urlString)
                  let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
                  let pdfNameFromUrl = "Reports.pdf"
                  let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
                  do
                  {
                      try pdfData?.write(to: actualPath, options: .atomic)
                     let urlStr : String = urlString.absoluteString
                    if(urlStr != "" && urlStr != " ")
                    {
                    let vc = pdfViewController()
                    print("urlstr",urlString)
                    vc.urlstr =  urlString
                    self.navigationController?.pushViewController(vc, animated: true)
                    }
                    else
                    {
                        let alertcontrol = UIAlertController(title : "Warning", message : "Pdf could not be viewed", preferredStyle: .alert)
                                   let okbtn = UIAlertAction(title: "OK", style: .default, handler: nil)
                                   alertcontrol.addAction(okbtn)
                                   self.present(alertcontrol,animated : true,completion: nil)
                       
                    }
                  }
                  catch
                  {
                      print("Pdf could not be saved")
                  }
              }
          }

