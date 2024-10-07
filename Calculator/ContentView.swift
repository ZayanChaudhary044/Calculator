//
//  ContentView.swift
//  Calculator
//
//  Created by Zayan Chaudhary on 06/08/2024.
//

import SwiftUI

enum CalcButton : String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case mult = "x"
    case div = "/"
    case equal = "="
    case clr = "AC"
    case dec = "."
    case perc = "%"
    case neg = "-/+"
    
    var buttcolor: Color{
        switch self{
        case .add, .subtract, .mult, .div:
            return .orange
        case .clr, .neg, .perc:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1.0))
        }
    }
}

enum Operations
{
    case add, subtract, multiply, divide, none
}

struct ContentView: View {
    
    @State var val = "0"
    @State var prevops = 0
    @State var currentops: Operations = .none
    
    let buttons: [[CalcButton]] = [
        [.clr, .neg, .perc, .div],
        [.seven, .eight, .nine, .mult],
        [.five, .six, .seven, .subtract],
        [.one, .two, .three, .add],
        [.zero, .dec, .equal]
    ]
    var body: some View {
        
        ZStack{
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack{
                
                // Calculation display
                HStack{
                    Spacer()
                    Text(val)
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                        .padding()
                }
                
                //Buttons
                
                ForEach(buttons, id : \.self){row in
                    HStack(spacing: 12){
                        ForEach(row, id : \.self) {item in
                            Button( action: {
                                self.Tapped(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .frame(
                                        width: self.buttonwid(item: item),
                                        height: self.buttonhid()
                                    )
                                    .background(item.buttcolor)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(self.buttonwid(item: item) / 2)
                                    .font(.system(size: 35))
                                
                                
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
    
    func Tapped(button: CalcButton)
    {
        switch button{
        case .add, .subtract, .mult, .div, .equal:
            if button == .add{
                self.currentops = .add
                self.prevops = Int(self.val) ?? 0
                self.val = "0"
            }
            else if button == .subtract{
                self.currentops = .subtract
                self.prevops = Int(self.val) ?? 0
            }
            else if button == .mult{
                self.currentops = .multiply
                self.prevops = Int(self.val) ?? 0
            }
            else if button == .div{
                self.currentops = .divide
                self.prevops = Int(self.val) ?? 0
            }
            else if button == .equal{
     
                let run = self.prevops
                let curr = Int(self.val) ?? 0
            
                switch self.currentops {
                case .add:
                    self.val = "\(run + curr)"
                case .subtract:
                    self.val = "\(run - curr)"
                case .multiply:
                    self.val = "\(run * curr)"
                case .divide:
                    self.val = "\(run / curr)"
                case .none:
                    break
                }
            }
            
            if button != .equal{
                self.val = "0"
            }
        case .clr:
            self.val = "0"
        case .dec, .neg, .perc:
            break
        default:
            
            let num = button.rawValue
            if self.val == "0"
            {
                val = num
            }
            else
            {
                self.val = "\(self.val)\(num)"
            }
            
                
        }
    }
    
    func buttonwid(item: CalcButton) -> CGFloat{
        if item == .zero
        {
            return((UIScreen.main.bounds.width - (4*12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func buttonhid() -> CGFloat{
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}

#Preview {
    ContentView()
}
