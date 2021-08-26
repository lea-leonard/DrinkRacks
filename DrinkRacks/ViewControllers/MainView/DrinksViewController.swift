//
//  DrinksViewController.swift
//  DrinkRacks
//
//  Created by Lea W. Leonard on 8/26/21.
//  Copyright © 2021 Lea W. Leonard. All rights reserved.
//

import UIKit

class DrinksViewController: UIViewController {

    // -- OUTLETS
    @IBOutlet weak var drinksCollection: UICollectionView!
    
    // -- INSTANCE VARIABLES
    //let sampleData = Array(repeating: "Drink Name", count: 20)
    var drinks = [Drinks]()
    private let apiURL = "https://the-cocktail-db.p.rapidapi.com/popular.php"


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - USER INTERFACE DESIGN
        // self.drinksCollection.layer.cornerRadius = drinksCollection.frame.width / 2
        self.drinksCollection.layer.cornerRadius = CGFloat(integerLiteral: 50)
        self.drinksCollection.layer.borderWidth = 3
        self.drinksCollection.layer.borderColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        // fetch data from api
        getFetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        drinksCollection.reloadData()
    }
    
    private func getFetchData()-> Void {
        
        let session = URLSession.shared
        let url = URL(string: apiURL)
         // create in options for the URLRequest
        let headers = [
                "x-rapidapi-key": "8f8cfaed89mshf9c4ae748ffc27bp167241jsnf39e05de9810",
                "x-rapidapi-host": "the-cocktail-db.p.rapidapi.com",
                "httpMethod" : "GET"
            ]
        // load the URL into the Request
        var request = URLRequest(url: url!)
        
        //: type of request
        // request.httpMethod = "GET"
        
        //: URLRequest methods
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.allHTTPHeaderFields = headers
        
        // start fetch session
        let fetchTask = session.dataTask(with: request, completionHandler:{
            (data, response, error) in
            
            // check for any errors
            if let err = error {
                print("Error has occured in fetch: \(err)")
            }
            
            // validate any responses
            guard let resp = response as? HTTPURLResponse, (200...299).contains(resp.statusCode), resp.mimeType == "application/json" else {
                print("******** ERROR IN RESPONSE ****************")
                return
            }
            
            // IF resp validates - decode data into json format
            if resp.statusCode == 200{
                if let responseData = data{
                    self.decodeData(data: responseData)
                } else {
                    print("********* ERROR IN DATA ********* ")
                }
            }
            DispatchQueue.main.async {
                self.drinksCollection.reloadData()
            }
            
            print("SUCCESS WITH FETCH API with status \(resp.statusCode)")
            
        }) // end fetchTask
        
        fetchTask.resume()
    }
    
   private func decodeData(data: Data)->Void {
       // temporary collection for json data
       var tempData: Drinks
       
       // create instance of the JSONDeserializton object
       // NOT using jsonDecode, jsonEncode
       do{
           guard let formatData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary else {
               print("************* ERROR IN DECODEDATA() ***************")
               return
           }
           
           //: if serializtion is complete with no errors convert data into data model
           // get top level key of api
           guard let topKey = formatData["drinks"] as? [AnyObject] else {
               // if topy key in incorrect with API
               return
           }
           // set the data to the model: Drinks.swift
           for drink in topKey {
               tempData = Drinks()
               
               //NOTE string literal in brackets is from API structure
               tempData.name = drink["strDrink"] as? String
               tempData.category = drink["strCategory"] as? String
               tempData.glassType = drink["strGlass"] as? String
               tempData.instructions = drink["strInstructions"] as? String
               tempData.dateModified = drink["dataModified"] as? Date
               tempData.img = drink["strDrinkThumb"] as? String
               tempData.favorite = false
               self.drinks.append(tempData)
               
           }
           
           print("Number of records: \(drinks.count)")
           
           
       }catch {
           print("************** ERROR IN CLASS FETCH API *****************")
       }
   }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
  // MARK: - UICOLLECTION DATASOURCE FUNCS
extension DrinksViewController: UICollectionViewDataSource {
   
       func numberOfSections(in collectionView: UICollectionView) -> Int {
           return 1
       }
       
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            print("datasource execute")
           return drinks.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = drinksCollection.dequeueReusableCell(withReuseIdentifier: "cellDrinks", for: indexPath) as! DrinksCellController
       
            cell.lblDrinkName.text = drinks[indexPath.row].name
            let imgUrl = URL(string: drinks[indexPath.row].img!)!
            if let imgData = try? Data(contentsOf: imgUrl){
                cell.imgDrink.layer.cornerRadius = 20
                cell.imgDrink.layer.borderWidth = 2
                cell.imgDrink.layer.borderColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
                cell.imgDrink.image = UIImage(data: imgData)
            }
           return cell
           
       
       }
    
}// end DataSource
