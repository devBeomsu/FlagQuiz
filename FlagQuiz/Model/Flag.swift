//
//  Flag.swift
//  FlagQuiz
//
//  Created by Raphael Shim on 2023/03/27.
//

import Foundation

struct Flag {
    var name: String
    var image: String
}

extension Flag {
    static let flags: [Flag] = [
        Flag(name: "한국", image: "southKorea"),
        Flag(name: "미국", image: "usa"),
        Flag(name: "캐나다", image: "canada"),
        Flag(name: "멕시코", image: "mexico"),
        Flag(name: "베네수엘라", image: "venezuela"),
        Flag(name: "브라질", image: "brazil"),
        Flag(name: "일본", image: "japan"),
        Flag(name: "북한", image: "northKorea"),
        Flag(name: "뉴질랜드", image: "newZealand"),
        Flag(name: "인도", image: "india"),
    ]
}
