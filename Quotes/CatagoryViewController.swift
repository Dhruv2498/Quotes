//
//  CatagoryViewController.swift
//  Quotes
//
//  Created by Dear D on 11/01/24.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
class CatagoryViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
   
    

    @IBOutlet weak var CatagoryTableView: UITableView!
    var arr_Catagory_id = [String]()
    var arr_Catagory_name = [String]()
    var arr_Catagoty_image = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_Catagory_id.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatCell") as! CategoryTableViewCell
        cell.lbId.text = arr_Catagory_id[indexPath.row]
        cell.lblName.text = arr_Catagory_name[indexPath.row]
        let url = URL(string: arr_Catagoty_image[indexPath.row])
        cell.CatImageview.af.setImage(withURL : url!)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let main = storyboard?.instantiateViewController(identifier: "ProductVC") as! ProductViewController
        main.catId = arr_Catagory_id[indexPath.row]
        self.navigationController?.pushViewController(main, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        CatAPI()
        self.CatagoryTableView.delegate = self
        self.CatagoryTableView.dataSource = self
        
        /*let backButton = UIBarButtonItem()
                   backButton.title = "Home"
                   self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton*/
        
    }
    
    func CatAPI(){
        let CatURL = "https://D3.in/myapi/at-quotes/api/api-list-category.php"
        AF.request(CatURL).responseJSON{(response) in
            switch response.result{
            case .success:
                print(response.result)
                let myresult = try? JSON(data: response.data!)
                let resultArray = myresult!["category_list"]
                
                self.arr_Catagory_id.removeAll()
                self.arr_Catagory_name.removeAll()
                self.arr_Catagoty_image.removeAll()
                
                for i in resultArray.arrayValue{
                    let CatId = i["category_id"].stringValue
                    self.arr_Catagory_id.append(CatId)
                    
                    let CatName = i["category_name"].stringValue
                    self.arr_Catagory_name.append(CatName)
                    
                    let CatImage = i["category_image"].stringValue
                    self.arr_Catagoty_image.append(CatImage)
                    
                    print(CatName)
                    
                    
                }
                self.CatagoryTableView.reloadData()
                break
            case .failure:
                break
            }
        }
    }

}
