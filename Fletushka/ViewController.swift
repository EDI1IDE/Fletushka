//
//  ViewController.swift
//  Fletushka
//
//  Created by Muhamed Zahiri on 05.02.22.
//

import UIKit
import Alamofire
import Kingfisher


class ViewController: UIViewController {
    
    @IBOutlet weak var collection_view_1: UICollectionView!
    @IBOutlet weak var collection_view_2: UICollectionView!
    @IBOutlet weak var collection_view_2_height: NSLayoutConstraint!
    
    var items = [ModelFletushka]()

    var imageArr:[String] = ["https://cjfc.com.au/wp-content/uploads/2021/11/CJFC-Logo-02.png",
                             "https://static.wixstatic.com/media/29c778_b2ac2675fc4040f683b5aa5ad76c1025~mv2.png/v1/fill/w_500,h_500,al_c,q_90/file.jpg",
                             "https://a.espncdn.com/i/teamlogos/soccer/500-dark/19340.png",
                             "https://a.espncdn.com/i/teamlogos/soccer/500/2595.png",
                             "https://alchetron.com/cdn/kf-sknderbeu-kor-82a80ee0-c1bd-4d98-98ca-f7945395b6c-resize-750.png",
                             "https://keepercms.s3.amazonaws.com/teams/team/b458efd1c2634efcb817093c7f7bde14/logos/cfc-logo-20160303231951.png",
                             "https://llapifc.com/wp-content/uploads/2017/05/logooo-2.png",
                             "https://static.wixstatic.com/media/f1fa5a_7e03a762ab4e49bc8b6c13a096e7a664~mv2.png",
                             "https://logoeps.com/wp-content/uploads/2013/09/ks-teuta-durres-old-vector-logo.png",
                             "https://tuploads.s3.eu-west-1.amazonaws.com/production/uploads/branding/header_logo_image/2806/FC.png",
                             "https://images.squarespace-cdn.com/content/v1/5537b01fe4b04fa840f1c26f/1563183485395-DBFUQ05KJVSVSN2PSX1B/Wythenshawe+Town.png?format=1500w",
                             "https://cdn.shopify.com/s/files/1/0044/9983/2918/articles/113201-627bebfc75b1a99a59d8010d53b993158f8b5929.png?v=1572486808",
                             "https://edmontonwildcats.com/wp-content/uploads/sites/22/2021/05/logo-border.png",
                             "https://fairfordtownfc.co.uk/wp-content/uploads/2016/07/FTFC-logo.png",
                             "https://images.squarespace-cdn.com/content/v1/61889ec7e8b21a2cd26211bc/1e7e9f85-c671-4baf-9014-c02641759d23/Untitled+design+%2851%29.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Parso()
        
//      DispatchQueue.main.asyncAfter(deadline: .now() + 2) { print("\n\(self.items[0].name) [Me vonesë]") }
        
        
        collection_view_1.register( UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemCollectionViewCell")
        
        collection_view_2.register( UINib(nibName: "Item2CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Item2CollectionViewCell")
        
        self.view.layoutIfNeeded()
    }
    
    override func viewDidLayoutSubviews() {
        self.changeCollectionHeight()
    }
}


//MARK: - CollectionView
extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func changeCollectionHeight(){
        self.collection_view_2_height.constant =  self.collection_view_2.contentSize.height
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //MARK: - CollectionView 1
        if (collectionView == self.collection_view_1) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "ItemCollectionViewCell", for: indexPath) as!  ItemCollectionViewCell
            
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date1 = dateFormatter.string(from: date)
            
            
            //TODO: - Pasi që te gjitha datat e serverit janë të skaduara nuk shfaqet asnjë nga fletushkat horizontale për këtë e kam lënë veq me featured e jo datë. Nese doni mundeni me ja shtu një "!" para kllapës poshtë para "date1" edhe vlen kushti!
            
            if (date1.compare(self.items[indexPath.row].date) == ComparisonResult.orderedDescending) && (self.items[indexPath.row].featured == true){
                // Ato që kanë (featured = true)
                cell.container_image.kf.setImage(with:URL(string:"https://static.wikia.nocookie.net/brawlhalla_gamepedia/images/f/fa/Task_Force_Isaiah.png/revision/latest/scale-to-width-down/250?cb=20200513170852"))

            } else {
                //Ato që kanë (featured = false)
                cell.container_image.kf.setImage(with:URL(string:"https://static.wikia.nocookie.net/brawlhalla_gamepedia/images/0/09/Shadow_Ops_Isaiah.png/revision/latest/scale-to-width-down/250?cb=20200813154416"))
            }
            
            //cell.container_image.backgroundColor = .red
            return cell
            
        }
        //MARK: - CollectionView 2
        else if (collectionView == self.collection_view_2) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "Item2CollectionViewCell", for: indexPath) as!  Item2CollectionViewCell
            
            cell.image_cell_2.kf.setImage(with: URL(string: self.imageArr[indexPath.row]))
            cell.title_cell_2.text = self.items[indexPath.row].name
            
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date1 = dateFormatter.string(from: date)
            
            let dataeSotit = dateFormatter.date(from: date1)
            let dataeDhene = dateFormatter.date(from: self.items[indexPath.row].date)
            
            if date1.compare(self.items[indexPath.row].date) == ComparisonResult.orderedDescending{
                print("Data është në të shkuarën")
                
                //Ndryshimi i diteve te datave ku data e dhene < data e tanishme
                let diffSeconds = dataeSotit!.timeIntervalSinceReferenceDate - dataeDhene!.timeIntervalSinceReferenceDate
                let diffDays:Int = Int(diffSeconds/86400)
                let daychange = String(diffDays)
                
                cell.subtitle_cell_2.text = "Ka skaduar para \(daychange) dite"
            }
            else if date1.compare(self.items[indexPath.row].date) == ComparisonResult.orderedAscending {
                print("Data është në të ardhmen")
                
                //Ndryshimi i diteve te datave ku data e dhene > data e tanishme
                let diffSeconds = dataeDhene!.timeIntervalSinceReferenceDate - dataeSotit!.timeIntervalSinceReferenceDate
                let diffDays:Int = Int(diffSeconds/86400)
                let daychange = String(diffDays)
                
                cell.subtitle_cell_2.text = "Fillon pas \(daychange) dite"
            }
            else if date1.compare(self.items[indexPath.row].date) == ComparisonResult.orderedSame{
                print("Data është e tanishme")
                
                cell.subtitle_cell_2.text = "Vetëm Sot!"
            }
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "ItemCollectionViewCell", for: indexPath) as!  ItemCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == self.collection_view_1) {
            return CGSize(width: (collectionView.frame.width-4)/1.2 , height:400)
        }
        else if (collectionView == self.collection_view_2) {
            return CGSize(width: (collectionView.frame.width-4)/2 , height: 300)
        }
        
        return CGSize(width: (collectionView.frame.width-4)/2 , height: 160)
        
    }
    
    
    //MARK: - Parsimi i JSON
    func Parso(){
        
        //Metoda e vjetër - Njëjtë vetëm që ka dal nga përdorimi prej Alamofire verz.6
        //AF.request("https://www.mocky.io/v2/5d1689260e00000b41a1196a").responseJSON {response in print(response)
        
        //Metoda e re
        AF.request("https://www.mocky.io/v2/5d1689260e00000b41a1196a").responseDecodable(of: Fletushka.self) {response in
            
            guard let data = response.data else{return}
            do{
                let fletushka = try JSONDecoder().decode(Fletushka.self, from: data)
                
                print("\n\(fletushka)")
                print(fletushka[0].name)
                print("Good Decoding \n")
                
                self.items = fletushka
                self.reloadData()
                
                //                for item in fletushka {
                //
                //                    let url = item.url
                //                    print("URL: \(url)")
                //
                //                    let featured = item.featured
                //                    print("Featured: \(featured)")
                //
                //                    let order = item.order
                //                    print("Order: \(order)")
                //
                //                    let name = item.name
                //                    print("Name: \(name)")
                //
                //                    let date = item.date
                //                    print("Date: \(date)")  }
                
            } catch { print("Error decoding == \(error )") }
        }
    }
    
    
    //MARK: - Sortimi
    func reloadData() {
        self.items = self.items.sorted(by: {$0.order.rawValue > $1.order.rawValue})
        DispatchQueue.main.async {
            self.collection_view_1.reloadData()
            self.collection_view_2.reloadData()
        }
    }
    
}
