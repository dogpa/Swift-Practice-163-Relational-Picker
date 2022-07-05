//
//  CItyDictrictTwoViewModel.swift
//  Swift Practice 163 Relational Picker
//
//  Created by Dogpa's MBAir M1 on 2022/7/5.
//

import Foundation
final class CityDistrictTwoViewModel : ObservableObject {
    
    //接收JSON解析的台灣行政區Array
    @Published var taiwanCityAndDistArray: [TaiwanDist] = []
    
    //從taiwanCityAndDistArray過濾出台灣城市名稱加入到cityArray
    @Published var cityArray: [String] = []
    
    //接收依照使用者選擇的城市，指定城市內的行政區名稱
    @Published var districtArray: [String] = []
    
    @Published var cityDistDict:[String:[String]] = [:]
    
    //與城市名稱picker binding的值
    //若是發生改變，代表使用者選了指定的城市
    //將districtSelectIndex設定為0以防止使用者的下一個行政區數量小於目前的值造成閃退
    //執行fetchDistrict將districtArray更換為新選擇的城市的行政區
    @Published var citySelectIndex = 0 {
        didSet {
            districtSelectIndex = 0
            districtArray = fetchDistrict(selectIndex: self.citySelectIndex)
        }
    }
    
    //與行政區名稱picker binding的值
    @Published var districtSelectIndex = 0
    
    //解析JSON
    //透過迴圈將所有縣市名稱加入到cityArray
    //並在透過巢狀迴圈加入先將對應回圈內的縣市名稱中的行政區加入到filterDistrictArray
    //接著將其轉換成字典的類別
    //並透過自定義的fetchDistrict將districtArray的值取得對應該字典內縣市的名稱
    func decodeJSON() {
        
        taiwanCityAndDistArray = load("taiwan_districts.json")
                   
        cityArray = []
        
        for i in 0..<taiwanCityAndDistArray.count {
            
            cityArray.append(taiwanCityAndDistArray[i].name)
            var filterDistrictArray = [String]()
            for x in 0 ..< taiwanCityAndDistArray[i].districts.count {
                filterDistrictArray.append(taiwanCityAndDistArray[i].districts[x].name)
            }
            cityDistDict["\(taiwanCityAndDistArray[i].name)"] = filterDistrictArray
            print(cityDistDict, "字典\n")
        }
        districtArray = fetchDistrict(selectIndex: 0)
        
        
    }
    
    /// 透過指定參數回傳指定taiwanCityAndDistArray縣市內的行政區字典的value
    ///  - Parameters:
    ///   - selectIndex: 對應taiwanCityAndDistArray內指定的位置的縣市名稱
    ///
    ///  - Returns:  相對應的字典value
    func fetchDistrict (selectIndex: Int) -> [String] {
        return cityDistDict["\(taiwanCityAndDistArray[selectIndex].name)"] ?? [""]
    }
}
