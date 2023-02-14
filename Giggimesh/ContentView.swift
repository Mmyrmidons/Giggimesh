//
//  ContentView.swift
//  Giggimesh
//
//  Created by Duncan Davidson on 2/14/23.
//

import SwiftUI

struct ContentView: View {
	var body: some View {
		VStack {
			Image(systemName: "globe").imageScale(.large).foregroundColor(.accentColor)
			Text(hymn)
		}.padding().onAppear() {
			DispatchQueue.global(qos: .userInitiated).async {
				hymn = hiGiggi()
			}
		}
	}
	@State private var hymn = ""
}

func hiGiggi() -> String {
	if let cUrl = URL(string: "http://urtheaters.com/things/c.4.07.3.xml") {
		do {
			let cXml = try XMLDocument(contentsOf: cUrl, options: .nodePreserveAll)
			
			if let tUrl = URL(string: "http://urtheaters.com/things/title.xsl") {
				do {
					if let cData = try cXml.objectByApplyingXSLT(at: tUrl, arguments: nil) as? Data {
						let cHtml = String(decoding: cData, as: UTF8.self)
						
						return cHtml
					}
				} catch {}
			}
		} catch {}
	}
	
	return "Hi Birdi Jr!"
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
