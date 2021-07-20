//
//  ContentView.swift
//  Wearther
//
//  Created by cmStudent on 2021/07/19.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var contentViewModel = ContentViewModel()
    
    var image: UIImage {
        if let urlString = contentViewModel.tnqlData?.results.a.first?.image,
           let url = URL(string: urlString),
           let data = try? Data(contentsOf: url),
           let image = UIImage(data: data) {
            return image
        }
        else {
            return UIImage(named: "NoImage")!
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack{
                Color("back")
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    Spacer()
                        .frame(height: 40)
                    
                    //天気
                    Text("今日の天気")
                        .padding(.trailing, 200)
                        .font(.title)
                        .foregroundColor(Color("title"))
                    
                    VStack{
                        
                        // 場所
                        Text(contentViewModel.weatherData?.name ?? "")
                            .font(.largeTitle)
                            .padding(.top)
                            .foregroundColor(Color("title2"))
                        
                        HStack{
                            
                            // 天気の画像
                            Image(contentViewModel.weatherData?.weather.first?.icon ?? "NoImage")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 90)
                            
                            // 天候
                            Text(contentViewModel.weatherData?.weather.first?.description ?? "")
                                .font(.title2)
                                .foregroundColor(Color("font"))
                        }
                        
                        HStack{
                            
                            Spacer()
                            
                            // 気温の表示
                            Text("気温：")
                            Text(String(contentViewModel.weatherData?.main.temp ?? 0.0))
                            
                            Spacer()
                            
                            // 湿度の表示
                            Text("湿度：")
                            Text(String(contentViewModel.weatherData?.main.humidity ?? 0.0))
                            Spacer()
                        }
                        .foregroundColor(Color("font"))
                        .padding()
                        
                    }
                    
                    // 囲枠
                    .frame(width: geometry.size.width - 20)
                    .overlay(
                        RoundedRectangle(cornerSize: CGSize(width: 7.0, height: 7.0))
                            .stroke(Color("line"), lineWidth: 1.0)
                    )
                    .padding(.bottom)
                    
                    Spacer()
                    
                    // 服装
                    Text("今日のおすすめコーデ")
                        .padding(.trailing,130)
                        .font(.title2)
                        .foregroundColor(Color("title"))
                    
                    // コーデ例の画像
                    HStack{
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200.0, height: 250.0, alignment: .leading)
                        
                        // コーデの説明
                        VStack{
                            Text(contentViewModel.tnqlData?.results.b.first?.description2 ?? "")
                            Text(contentViewModel.tnqlData?.results.c.first?.description3 ?? "")
                        }
                        .foregroundColor(Color("font2"))
                        .padding()
                    }
                    
                    // 囲線
                    .frame(width: geometry.size.width - 20)
                    .overlay(
                        RoundedRectangle(cornerSize: CGSize(width: 7.0, height: 7.0))
                            .stroke(Color("line"), lineWidth: 1.0)
                        //.padding(-8.0)
                    )
                    Spacer()
                    
                }
            }
            
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            
            
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
