//
//  FetchApi.swift
//  DrinkRacks
//
//  Created by Lea W. Leonard on 8/26/21.
//  Copyright © 2021 Lea W. Leonard. All rights reserved.
/* : PURPOSE
   
    Create a shared URLSession for fetching data from API:https://the-cocktail-db.p.rapidapi.com/popular.php

*/
import Foundation

class FetchApi {
     
    private let apiURL = "https://the-cocktail-db.p.rapidapi.com/popular.php"
    private let session = URLSession.shared
    var drinksData = [Drinks]()
    
    init(){
        fetchApi()
        print("Fetching data")
    }
    
    func fetchApi () -> Void {
        print("Inside fetchApi()")
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
                print("Inside dispatch queue")
                let vcDrinks = DrinksViewController()
                vcDrinks.drinks = self.drinksData
                print("Num of collection = \(vcDrinks.drinks.count)")
                
            }
            
        }) // end fetchTask
        
        fetchTask.resume()
        
    }// end fetchApi()
    
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
                self.drinksData.append(tempData)
                print("\(tempData.name ?? "no data")")
            }
            
            print("Number of records: \(drinksData.count)")
            
            
        }catch {
            print("************** ERROR IN CLASS FETCH API *****************")
        }
    }
    
}// end class
