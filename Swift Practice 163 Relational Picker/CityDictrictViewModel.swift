//
//  CityDictrictViewModel.swift
//  Swift Practice 163 Relational Picker
//
//  Created by Dogpa's MBAir M1 on 2022/7/4.
//

import Foundation

final class CityDistrictViewModel : ObservableObject {
    
    //接收JSON解析的台灣行政區Array
    @Published var taiwanCityAndDistArray: [TaiwanDist] = []
    
    //從taiwanCityAndDistArray過濾出台灣城市名稱加入到cityArray
    @Published var cityArray: [String] = []
    
    //接收依照使用者選擇的城市，指定城市內的行政區名稱
    @Published var districtArray: [String] = []
    
    //與城市名稱picker binding的值
    //若是發生改變，代表使用者選了指定的城市
    //將districtSelectIndex設定為0以防止使用者的下一個行政區數量小於目前的值造成閃退
    //執行fetchDistrict將districtArray更換為新選擇的城市的行政區
    @Published var citySelectIndex = 0 {
        didSet {
            districtSelectIndex = 0
            fetchDistrict(selectIndex: self.citySelectIndex)
        }
    }
    
    //與行政區名稱picker binding的值
    @Published var districtSelectIndex = 0
    
    //解析JSON
    //透過迴圈將城市名稱加入到districtArray
    //透過自定義fetchDistrict取得cityArray第0個值相對應的行政區名稱
    func decodeJSON() {
        
        taiwanCityAndDistArray = load("taiwan_districts.json")
                   
        cityArray = []
        districtArray = []
        for i in 0..<taiwanCityAndDistArray.count {
            cityArray.append(taiwanCityAndDistArray[i].name)
        }
        fetchDistrict(selectIndex: 0)
    }
    
    
    /// 將對應的行政區名稱透過迴圈加入到districtArray
    /// - Parameters:
    ///   - selectIndex:taiwanCityAndDistArray的值
    func fetchDistrict (selectIndex: Int) {
        districtArray = []
        for i in 0..<taiwanCityAndDistArray[selectIndex].districts.count {
            districtArray.append(taiwanCityAndDistArray[selectIndex].districts[i].name)
        }
    }
}
