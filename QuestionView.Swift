//
//  QuestionView.swift
//  SeikoFestaiOSApp63rd
//
//  Created by 付聖宣 on 2022/04/27.
//

import SwiftUI
import UIKit

import Foundation
import SwiftUI
import AVFoundation


//func Appear(count:Int, isCountDown:Bool) {
//    // 1.0秒おきに{}内を繰り返す
//    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {timer in
//        count -= 1
//        if count == 0 {
//            // 現在のカウントが0になったらtimerを終了させ、カントダウン終了状態に更新
//            timer.invalidate()
//            isCountDown = false
//        }
//    }
//}

struct QuestionView: View {
    
    @State private var show: Bool = false
    //@Binding var Correct: String
    // カウントダウンする秒数
    @State private var count = 10
    @State private var isCountDown = false
    // true:カウントダウン中　false:カウントダウン終了
    
    @State private var isShowingView: Bool = false
    
    func Appear() {
        // 1.0秒おきに{}内を繰り返す
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {timer in
            count -= 1
            if count == 0 {
                // 現在のカウントが0になったらtimerを終了させ、カントダウン終了状態に更新
                timer.invalidate()
                isCountDown = true
            }
        }
    }//onappearおわり
    
    var body: some View {
//        ScannerQRCodeView()

            
            VStack {
                Text("はじめに").font(.title)
                
                Text("30分間で校内に貼ってあるQRコードを読み取ってポイントを稼ごう！ポイントを稼ぐとポイントに応じて景品がもらえるよ。※景品交換は制限時間後です").frame(width: 300).font(.subheadline)
                    .padding()
//                Button(action: { self.show.toggle() }) {
//                        Text("はじめよう!").fontWeight(.bold).font(.largeTitle)
//                    }
                    Button(action: {
                        Appear()
                        self.show.toggle()
                    }) {  //buttonactionここまで
                    Text("Let's Start!").fontWeight(.bold).font(.largeTitle)
                    }
                    .sheet(isPresented: self.$show) {
                        
                        //SecondView(Correct: $Correct)
                        ScannerQRCodeView()
                        // trueになれば下からふわっと表示
                        //ThirdView(isCountDown: $isCountDown, count: $count)
//                        if !self.isCountDown {
//                            Text("Hello, world!")
                    }
                
                    .sheet(isPresented: $isCountDown){
                        ThirdView()
                    }
            } //VStackおわり
             //本来はTextViewではなく画面ごとに別fileを作成
    }
}//contentviewここまで

struct SecondView:View{
    //@Binding var isCounted:Bool
    @Binding var Correct:String
    @State var Answer:String = ""
    @State var isPresent = false
    
    func plusTotal(n:Int, Correct:String, Answer:String) -> Void{
        if Correct == Answer{
            QuizDataBase.Total += n
        }
    }
    
    var body: some View{
        List{
            Button("A"){
                Answer = "A"
                isPresent = true
                plusTotal(n: 3, Correct: Correct, Answer: Answer)
            }
            
            Button("B"){
                Answer = "B"
                isPresent = true
                plusTotal(n: 3, Correct: Correct, Answer: Answer)
            }
            
            Button("C"){
                Answer = "C"
                isPresent = true
                plusTotal(n: 3, Correct: Correct, Answer: Answer)
            }
            
            Button("D"){
                Answer = "D"
                isPresent = true
                plusTotal(n: 3, Correct: Correct, Answer: Answer)
            }
        }
        
        .sheet(isPresented: $isPresent){
            AnswerView(Correct: $Correct, Answer: $Answer)
        }
    }
}

struct AnswerView:View{
    //@Binding var isCounted:Bool
    @Binding var Correct:String
    @Binding var Answer:String
    @State var ispre = false
    
    var body: some View{
        if(Correct == Answer){
            Text("3ポイント獲得です")
            Text(String(QuizDataBase.Total))
        }else{
            Text("残念、ポイント獲得ならず")
            Text(String(QuizDataBase.Total))
        }
        
        Button("次の問題"){
            ispre = true
        }
        
        .sheet(isPresented: $ispre){
            ScannerQRCodeView()
        }
}
}


struct ThirdView:View{
    @State private var show: Bool = false
    //@Binding var isCountDown: Bool
    //@Binding var count: Int
    var body: some View {
        
        VStack {
            
//            if !self.isCountDown {
//                Button(action: { self.show.toggle() }) {
//                                Text("最終問題!").fontWeight(.bold).font(.largeTitle)
//                            }
//                            .sheet(isPresented: self.$show) {
//                                // trueになれば下からふわっと表示
//                                SaishuView()
//                            }
//            }

//            Button(action: { self.show.toggle() }) {
//                            Text("qrこーど").fontWeight(.bold).font(.largeTitle)
//                        }
//                        .sheet(isPresented: self.$show) {
//                            // trueになれば下からふわっと表示
//                            ScanView()
//                        }
        }
    }
    
}


struct LastView:View{
    @Binding var Correct:String
    @State var Answer:String = ""
    @State var isPresent = false
    
    func plusTotal(n:Int, Correct:String, Answer:String) -> Void{
        if Correct == Answer{
            QuizDataBase.Total += n
        }
    }
    var body: some View {
        Text("ゲーム終了")
        Text("獲得ポイントは\(QuizDataBase.Total)ポイントです")
        Text("景品交換所で景品と交換しよう!")
    }
   
}


//
//struct QuestionView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionView()
//    }
//}
//}


