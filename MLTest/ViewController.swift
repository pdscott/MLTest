//
//  ViewController.swift
//  MLTest
//
//  Created by Preston Scott on 6/7/17.
//  Copyright © 2017 Preston Scott. All rights reserved.
//

import UIKit
import Vision

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    guard let model = try? VNCoreMLModel(for: GoogLeNetPlaces().model) else {
      fatalError("Couldn't initialize Model")
      
    }
    
    let request = VNCoreMLRequest(model: model, completionHandler: myResultsMethod)
    let handler = VNImageRequestHandler(url: Bundle.main.url(forResource: "ocean", withExtension: "jpg")!)
    
    guard (try? handler.perform([request])) != nil else {
      fatalError("Error on model")
    }
  }
  
  func myResultsMethod(request: VNRequest, error: Error?) {
    guard let results = request.results as? [VNClassificationObservation] else {
      fatalError("Results Error")
    }
    
    for classification in results {
      print(classification.identifier, classification.confidence)
    }
    
  }
}

