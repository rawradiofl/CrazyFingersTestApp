//
//  Album.swift
//  CrazyFingersTestApp
//
//  Created by Scott Martin on 9/20/14.
//  Copyright (c) 2014 Scott Martin. All rights reserved.
//

import Foundation

class Album {
    var name: String
    var artist: String
    var id: String
    var duration: String?
    var songCount: String?
    var created: String?
    var artistId: String?
    
    init(name: String, artist: String, id: String, duration: String?, created: String?, artistId: String?, songCount: String?) {
        self.name = name
        self.id = id
        self.artist = artist
        self.duration = duration
        self.created = created
        self.artistId = artistId
        self.songCount = songCount
    }
    
    class func albumsWithJSON(allResults: NSArray) -> [Album] {
        var albums = [Album]()
        
        if allResults.count > 0 {
            for result in allResults {
                let name = result["name"] as? String ?? ""
                let artist = result["artist"] as? String ?? ""
                var id = result["id"] as Int
                var idString = String(id)
                var newAlbum = Album(name: name, artist: artist, id: idString, duration: nil, created: nil, artistId: nil, songCount: nil)
                albums.append(newAlbum)
            }
        }
        return albums
    }
}