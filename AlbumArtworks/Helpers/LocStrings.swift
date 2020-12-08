//
//  LocStrings.swift
//  AlbumArtworks
//
//  Created by Roman Trekhlebov on 08.12.2020.
//

import Foundation

struct LocStrings {
    //MainView UI
    struct Main {
        static let mainTitle = NSLocalizedString("Main", comment: "")
        static let searchPlaceholder = NSLocalizedString("Placeholder", comment: "")

        //states
        static let intState = NSLocalizedString("initState", comment: "")
        static let loadingState = NSLocalizedString("loadingState", comment: "")

    }

    //DetailView UI
    struct Detail {
        static let album = NSLocalizedString("album", comment: "")
        static let price = NSLocalizedString("price", comment: "")
        static let artist = NSLocalizedString("artist", comment: "")
        static let track = NSLocalizedString("track", comment: "")
        static let notSetString = NSLocalizedString("notSetString", comment: "")
    }

    //Error Strings
    struct Err {
        static let errorTitle = NSLocalizedString("Error", comment: "")
        static let returnAction = NSLocalizedString("Return", comment: "")
        static let againAction = NSLocalizedString("Again", comment: "")
    }
}
