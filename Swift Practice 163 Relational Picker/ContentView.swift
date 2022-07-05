//
//  ContentView.swift
//  Swift Practice 163 Relational Picker
//
//  Created by Dogpa's MBAir M1 on 2022/7/4.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = CityDistrictViewModel()
    @StateObject var vmTwo = CityDistrictTwoViewModel()
    var body: some View {
        GeometryReader { geo in
            VStack {
                VStack{
                    HStack{
                        Picker(selection: $vm.citySelectIndex,label: Text("")) {
                            ForEach(0..<vm.cityArray.count, id: \.self) { name in
                                Text("\(vm.cityArray[name])")
                            }
                        }
                        .frame(width: geo.size.width/2, height: 300)
                        .pickerStyle(.wheel)
                        .clipped()
                        
                        Picker(selection: $vm.districtSelectIndex, label: Text("")) {
                            ForEach(0..<vm.districtArray.count, id: \.self) { name in
                                Text("\(vm.districtArray[name])").tag(name)
                            }
                        }
                        .frame(width: geo.size.width/2, height: 300)
                        .pickerStyle(.wheel)
                        .clipped()
                    }
                    HStack{
                        if vm.cityArray.count != 0 {
                            Text("\(vm.cityArray[vm.citySelectIndex])")
                                .frame(width: geo.size.width/2, height: 50)
                        }
                        if vm.districtArray.count != 0 {
                            Text("\(vm.districtArray[vm.districtSelectIndex])")
                                .frame(width: geo.size.width/2, height: 50)
                        }
                    }
                }
                
                Divider()
                
                VStack{
                    HStack{
                        Picker(selection: $vmTwo.citySelectIndex,label: Text("")) {
                            ForEach(0..<$vmTwo.cityArray.count, id: \.self) { name in
                                Text("\(vmTwo.cityArray[name])")
                            }
                        }
                        .frame(width: geo.size.width/2, height: 300)
                        .pickerStyle(.wheel)
                        .clipped()
                        
                        Picker(selection: $vmTwo.districtSelectIndex, label: Text("")) {
                            ForEach(0..<$vmTwo.districtArray.count, id: \.self) { name in
                                Text("\(vmTwo.districtArray[name])").tag(name)
                            }
                            
                        }
                        
                        .frame(width: geo.size.width/2, height: 300)
                        .pickerStyle(.wheel)
                        .clipped()
 
                    }
                    HStack{
                        if $vmTwo.cityArray.count != 0 {
                            Text("\(vmTwo.cityArray[vmTwo.citySelectIndex])")
                                .frame(width: geo.size.width/2, height: 50)
                        }
                        if $vmTwo.districtArray.count != 0 {
                            Text("\(vmTwo.districtArray[vmTwo.districtSelectIndex])")
                                .frame(width: geo.size.width/2, height: 50)
                        }
                        
                    }
                }
                
            }
        }            .onAppear {
            vm.decodeJSON()
            vmTwo.decodeJSON()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
