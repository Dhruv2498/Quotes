//
//  ProductViewController.swift
//  Quotes
//
//  Created by Dear D on 12/01/24.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON


class ProductViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var ProductTableView: UITableView!
    
    var catId = ""
    
    var arr_Product_id = [String]()
    var arr_product_title = [String]()
    var arr_product_image = [String]()
    var arr_catagory_id = [String]()
    var arr_catagory_name = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_product_title.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Procell = tableView.dequeueReusableCell(withIdentifier: "ProCell") as! ProductTableViewCell
        Procell.lblTitle.text = arr_product_title[indexPath.row]
        Procell.lblName.text = arr_catagory_name[indexPath.row]
        
        let url = URL(string: arr_product_image[indexPath.row])
        Procell.ProImageview.af.setImage(withURL: url!)
        return Procell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let main = storyboard?.instantiateViewController(identifier: "DetailsVC") as! DetailsViewController
        main.PDETAIL = arr_catagory_name[indexPath.row]
       // main.MyDetailsImageView = arr_product_image[indexPath.row]
        self.navigationController?.pushViewController(main, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Pro_API()
        ProductTableView.delegate = self
        ProductTableView.dataSource = self
        /*let backButton = UIBarButtonItem()
                   backButton.title = "Catagory"
                   self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton*/
       
    }
    
    func Pro_API(){
        let url = "https://akashsir.in/myapi/at-quotes/api/api-list-product.php?categoty_id=\(catId)"
        AF.request(url,method: .get).responseJSON{(response) in
            switch response.result{
                
                
            case .success:
                print(response.result)
                let myResult = try?JSON(data: response.data!)
                let ResultArray = myResult!["product_list"]
                print(ResultArray)
                
                self.arr_Product_id.removeAll()
                self.arr_catagory_id.removeAll()
                self.arr_catagory_name.removeAll()
                self.arr_product_image.removeAll()
                self.arr_product_title.removeAll()
                
            
                for i in ResultArray.arrayValue{
                    
                    let Pro_Id = i["product_id"].stringValue
                    self.arr_Product_id.append(Pro_Id)
                    
                    let Pro_Title = i["product_title"].stringValue
                    self.arr_product_title.append(Pro_Title)
                    
                    let pro_Image = i["product_image"].stringValue
                    self.arr_product_image.append(pro_Image)
                    
                    let Cat_Id = i["category_id"].stringValue
                    self.arr_catagory_id.append(Cat_Id)
                    
                    let Cat_Name = i["category_name"].stringValue
                    self.arr_catagory_name.append(Cat_Name)
                    
                    print(Pro_Id)
                    print(Pro_Title)
                    print(pro_Image)
                    print(Cat_Id)
                    print(Cat_Name)
                    
                }
                self.ProductTableView.reloadData()
            case .failure:
                break
            }
        }
        
    }

}
