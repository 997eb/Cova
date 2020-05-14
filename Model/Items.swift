


import Foundation

class Items:NSObject{
    
    
    
    var id:Int = 0
    var total: Int = 0 // total of one item ..
    var quantity:Int = 0
    var itemConfarmed:Bool = false
    var items = [Int]() // i'tt add the id's here, send to the api's
    var itemsQuantitiy:[Any] = [] // i'tt add the id's with the quantnty here, then send to the api's
    
    var collectPrices:[Int] = [] // i'tt add the id's
    
    override init(){
        
    }
    
    
    func saveItems(storeId:Int, total: Int,quantity:Array<Int>,itemsName:Array<String>,itemArr:Array<Int> , totalPrices:Array<Int>){
        let def = UserDefaults.standard
        
        def.set(storeId, forKey: "storeID_Menu")
        def.set(itemsName, forKey: "itemName")
        def.set(itemArr, forKey: "items")
        def.set(total , forKey: "itemPrice")
        def.set(quantity,forKey: "quantity")
        def.set(totalPrices,forKey: "prices")
        
        def.synchronize()
    }
    
    
    func getMenuStoreID() -> Int {
        let def = UserDefaults.standard
        return def.object(forKey: "storeID_Menu") as? Int ?? 0
    }
    
    
    func getItemsNames() -> Array<String>{
        let def = UserDefaults.standard
        return def.object(forKey: "itemName") as? Array<String> ?? []
    }
    
    func getItems() -> Array<Int>{
        let def = UserDefaults.standard
        return def.object(forKey: "items") as? Array<Int> ?? []
    }
    
    // here is the prices
    func getRricesArray() -> Array<Int>{
        let def = UserDefaults.standard
        return def.object(forKey: "prices") as? Array<Int> ?? []
    }
    
    func getTotalItemPrices() -> Int{
        let def = UserDefaults.standard
        return def.object(forKey: "total") as? Int ?? 0
        
    }
    
    
    // this is the total price
    func saveTotalItemPrices(total:Int){
        let def = UserDefaults.standard
        def.set(total, forKey: "total")
        def.synchronize()
    }
    
    func getquantity() -> Array<Int>{
        let def = UserDefaults.standard
        return def.object(forKey: "quantity")  as? Array<Int> ?? []
    }
    
    
    func saveOrder(order: [Order.items]){
        
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()
            
            // Encode Note
            let data = try encoder.encode(order)
            
            // Write/Set Data
            UserDefaults.standard.set(data, forKey: "order")

            
        } catch {
            print("Unable to Encode Array of Notes (\(error))")
        }
        
        
    }
    
    
    func getOrder()->[Order.items]{
        
        guard let data = UserDefaults.standard.data(forKey: "order") else { return [] }
        let decoder = JSONDecoder()
        let order = (try? decoder.decode([Order.items].self, from: data)) ?? []
        
        return order 
        }
    
    func saveIndexPath(indexPath:IndexPath){
        
        do {
                  // Create JSON Encoder
                  let encoder = JSONEncoder()
                  
                  // Encode Note
                  let data = try encoder.encode(indexPath)
                  
                  // Write/Set Data
                  UserDefaults.standard.set(data, forKey: "indexPath")

                  
              } catch {
                  print("Unable to Encode Array of Notes (\(error))")
              }
              
    }
       
    func getIndexPath() -> IndexPath{
                 guard let data = UserDefaults.standard.data(forKey: "indexPath") else { return [] }
        
                        let decoder = JSONDecoder()
        let indexPath = (try? decoder.decode(IndexPath.self, from: data)) ?? []
                        
                        return indexPath
              }
 
}
