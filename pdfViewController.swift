//
//  pdfViewController.swift
//  Niagara
//
//  Created by VenkatesanMacbookPro on 19/11/19.
//  Copyright © 2019 Venkatesan. All rights reserved.
//

import UIKit
import SVGKit
import PDFKit

class pdfViewController: UIViewController,PDFViewDelegate {
    var pdfVw : PDFView = PDFView()
    var urlstr : URL!
    var pdflbl = UILabel()
    var back : UIButton = UIButton()
     var share : UIButton = UIButton()
    var documentInteractionController = UIDocumentInteractionController()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = colorcode.bgcolor
        
        let header : UILabel = UILabel()
        header.backgroundColor = colorcode.headerbgcolor
        view.addSubview(header)
        header.translatesAutoresizingMaskIntoConstraints = false
        
        let lbltopConstraint = NSLayoutConstraint(item: header, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        
        let lblleadConstraint = NSLayoutConstraint(item: header, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
        
        let lbltrailConstraint = NSLayoutConstraint(item: header, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
        
        let lblheightConstraint = NSLayoutConstraint(item: header, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 60)
        
        NSLayoutConstraint.activate([lbltopConstraint,lblleadConstraint, lbltrailConstraint, lblheightConstraint])
        
        // image in SVG Image
        let namSvgImgVar: SVGKImage = SVGKImage(named: "logo small")
        let namImjVar: UIImage = namSvgImgVar.uiImage
        let logoimageView = UIImageView(image: namImjVar)
        logoimageView.backgroundColor = .clear
        logoimageView.contentMode = .center
        logoimageView.contentMode = .scaleAspectFit
        logoimageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoimageView)
        if #available(iOS 11.0, *)
        {
            let guide = self.view.safeAreaLayoutGuide
            logoimageView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
            logoimageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
        else
        {
            NSLayoutConstraint(item: logoimageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
            logoimageView.heightAnchor.constraint(equalToConstant: 55).isActive = true
        }
        
        let leadConstraint = NSLayoutConstraint(item: logoimageView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
        
        let trailConstraint = NSLayoutConstraint(item: logoimageView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([leadConstraint, trailConstraint])
        
        let backimg = UIImage(named: "backward-arrow.png") as UIImage?
        back.setBackgroundImage(backimg, for: .normal)
        back.translatesAutoresizingMaskIntoConstraints = false
        back.addTarget(self, action: #selector(backaction(sender:)), for: .touchUpInside)
        view.addSubview(back)
        let backtopConstraint = NSLayoutConstraint(item: back, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: header, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 15)
        
        let backleadConstraint = NSLayoutConstraint(item: back, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
        
        let backtrailConstraint = NSLayoutConstraint(item: back, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 30)
        
        let backheightConstraint = NSLayoutConstraint(item: back, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 30)
        
        NSLayoutConstraint.activate([backtopConstraint,backleadConstraint, backtrailConstraint, backheightConstraint])
        
        
        let shareimg = UIImage(named: "share.png") as UIImage?
        share.setBackgroundImage(shareimg, for: .normal)
        share.translatesAutoresizingMaskIntoConstraints = false
        share.addTarget(self, action: #selector(showOptionsTapped(sender:)), for: .touchUpInside)
        view.addSubview(share)
        let sharetopConstraint = NSLayoutConstraint(item: share, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: header, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 15)
        
        let shareleadConstraint = NSLayoutConstraint(item: share, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
        
        let sharetrailConstraint = NSLayoutConstraint(item: share, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 30)
        
        let shareheightConstraint = NSLayoutConstraint(item: share, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 30)
        
        NSLayoutConstraint.activate([sharetopConstraint,shareleadConstraint, sharetrailConstraint, shareheightConstraint])
        
        pdflbl.frame = CGRect(x: 0, y: 50, width: self.view.frame.size.width, height: 50)
        pdflbl.text = "PDF VIEWER"
        pdflbl.font =  Font.headerFont
        pdflbl.textColor = .systemTeal
        pdflbl.textAlignment = .center
        pdflbl.backgroundColor = .darkGray
        view.addSubview(pdflbl)
         
        documentInteractionController.delegate = self
        showSavedPdf(url:urlstr)
    }
    
    
    override var prefersStatusBarHidden: Bool
    {
        return false
    }

    //MARK:- ButtonAction
    @objc func backaction(sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
   @objc  func showOptionsTapped(sender: UIButton) {
           storeAndShare(url:urlstr)
       }
    //MARK:- PDF Format
    
    func showSavedPdf(url:URL)
    {
        if let pdfDocument = PDFDocument(url: url)
        {
          //  pdfVw.frame = CGRect(x: 10, y: 100, width: self.view.frame.size.width - 20, height: self.view.frame.size.height - 110)
            pdfVw.autoScales = true
            pdfVw.displayMode = .singlePageContinuous
            pdfVw.displayDirection = .vertical
            pdfVw.document = pdfDocument
            pdfVw.usePageViewController(true)
            pdfVw.delegate = self
            pdfVw.maxScaleFactor = 1.0
            pdfVw.minScaleFactor = pdfVw.scaleFactorForSizeToFit
           
            pdfVw.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(pdfVw)
            
            let pdfVwtopConstraint = NSLayoutConstraint(item: pdfVw, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: pdflbl, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 50)
            
            let pdfVwleadConstraint = NSLayoutConstraint(item: pdfVw, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 10)
            
            let pdfVwtrailConstraint = NSLayoutConstraint(item: pdfVw, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -10)
            
            let pdfVwheightConstraint = NSLayoutConstraint(item: pdfVw, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: -10)
            
            NSLayoutConstraint.activate([pdfVwtopConstraint,pdfVwleadConstraint, pdfVwtrailConstraint, pdfVwheightConstraint])
            
            }
        }
    
    func getDocument(path: String) -> PDFDocument? {
        let pdfURL = URL(fileURLWithPath: path)
        let document = PDFDocument(url: pdfURL)
        return document
    }
             
    }

extension pdfViewController {
    func share(url: URL) {
        documentInteractionController.url = url
        documentInteractionController.uti = url.typeIdentifier ?? "public.data, public.content"
        documentInteractionController.name = url.localizedName ?? url.lastPathComponent
        documentInteractionController.presentPreview(animated: true)
    }
    func storeAndShare(url:URL) {
       
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            let tmpURL = FileManager.default.temporaryDirectory
                .appendingPathComponent(response?.suggestedFilename ?? "fileName.png")
            do {
                try data.write(to: tmpURL)
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                self.share(url: tmpURL)
            }
            }.resume()
    }
}
extension pdfViewController: UIDocumentInteractionControllerDelegate {
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        guard let navVC = self.navigationController else {
            return self
        }
        return navVC
    }
}
extension URL {
    var typeIdentifier: String? {
        return (try? resourceValues(forKeys: [.typeIdentifierKey]))?.typeIdentifier
    }
    var localizedName: String? {
        return (try? resourceValues(forKeys: [.localizedNameKey]))?.localizedName
    }
}
