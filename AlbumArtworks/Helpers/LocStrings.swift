//
//  LocStrings.swift
//  AlbumArtworks
//
//  Created by Roman Trekhlebov on 08.12.2020.
//

import Foundation

struct LocStrings {
    //MainView UI
    struct main {
        static let mainTitle = NSLocalizedString("Main", comment: "")
        static let searchPlaceholder = NSLocalizedString("Placeholder", comment: "")
        static let cancelBtn = NSLocalizedString("cancel", comment: "")
    }

    //DetailView UI
    struct detail {
        static let langLbl = NSLocalizedString("album", comment: "")
        static let langPlaceholder = NSLocalizedString("price", comment: "")
        static let curencyLbl = NSLocalizedString("artist", comment: "")
        static let currPlaceholder = NSLocalizedString("track", comment: "")
    }

    //Error Strings
    struct err {
        static let errorTitle = NSLocalizedString("Error", comment: "")
        static let returnAction = NSLocalizedString("Return", comment: "")
        static let againAction = NSLocalizedString("Again", comment: "")
    }
}
