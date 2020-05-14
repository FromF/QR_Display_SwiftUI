//
//  ContentView.swift
//  QRDisplay
//
//  Created by 藤 治仁 on 2020/05/14.
//  Copyright © 2020 F-Works. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var message:String = ""
    @State var correctionLevel = 0
    @State var qrImage:UIImage?
    private var _QRCodeMaker = QRCodeMaker()

    var body: some View {
        VStack {
            TextField("Text", text: $message)
                .padding(.all)
            
            Picker(selection: $correctionLevel, label: Text("Correction Level")) {
                ForEach(0 ..< self._QRCodeMaker.getCorrectionCount()) { index in
                    Text("\(self._QRCodeMaker.getCorrectionText(index: index))").tag(index)
                }
            }
                .pickerStyle(SegmentedPickerStyle())
            
            Spacer()
            
            if qrImage != nil {
                Image(uiImage: qrImage!)
            }
            
            Spacer()

            Button(action: {
                self.qrImage = self._QRCodeMaker.make(message: self.message, level: self.correctionLevel)
            }) {
                Text("Make")
                    .frame(maxWidth: .infinity)
                    .frame(height: 80)
                    .font(.title)
                    .background(Color(UIColor.systemBlue))
                    .foregroundColor(Color(UIColor.systemBackground))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
