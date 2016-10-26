//
//  FlickrAPI.swift
//  Flickr Usage Example
//
//  Created by Rene Hexel on 29/04/2015.
//  Copyright (c) 2015-2016 Rene Hexel. All rights reserved.
//
import Darwin
import Foundation

/// API key your requested from Flickr.
/// WARNING: YOUR PROGRAM WILL CRASH IF NOT SET
public var FlickrAPIKey: String!

/// Selector for the photo format to use
public enum FlickrPhotoFormat: String {
    /// original photo as uploaded
    case Original  = "o"

    /// square version of a photo (i.e. width == height)
    case Square    = "s"

    /// big version of a photo (but not as big as the original)
    case Big       = "b"

    /// small version of a photo, suitable for on-screen display
    case Small     = "m"

    /// thumbnail version of a photo, suitable for overviews
    case Thumbnail = "t"

    /// 500 pixel version of a photo
    case Format500 = "-"

    /// 640 pixel version of a photo, e.g. for a 640x480 VGA or phone screen
    case Format640 = "z"
}

/// by default, return 50 results maximum to avoid excessive downloads
public let FlickrDefaultMaximumResults = 50

/// Photo data structure containing the most important elements of
/// a Flickr photo reference
public struct FlickrPhoto {
    let id: String
    let secret: String
    let owner: String
    let title: String
    let farm: Int
    let server: String
    let originalSecret: String?
    let originalFormat: String?
}


/// download a list of the latest photos on Flickr
///
public func latestFlickrPhotos(_ maximumResults: Int = FlickrDefaultMaximumResults) -> Array<FlickrPhoto>? {
    guard let response = fetch("https://api.flickr.com/services/rest/?method=flickr.photos.search&license=1,2,4,5,7&per_page=\(maximumResults)&has_geo=1&extras=original_format,tags,description,geo,date_upload,owner_name,place_url") else {
        return nil
    }
    return photosForFlickrJSONResponse(response)
}


/// download a list of photos for the given user
///
/// - parameter `user`: the flickr user name to download the photo list for
/// - parameter `maximumResults`: the maximum number of results to return
public func photosForUser(_ user: String, maximumResults: Int = FlickrDefaultMaximumResults) -> Array<FlickrPhoto>? {
    guard let nsid = idForUser(user) else { return nil }
    return photosForNSID(nsid, maximumResults: maximumResults)
}


/// download a list of photos for a given Flickr nsid
///
/// - parameter `nsid`: the flickr user name to download the photo list for
/// - parameter `maximumResults`: the maximum number of results to return
public func photosForNSID(_ nsid: String, maximumResults: Int = FlickrDefaultMaximumResults) -> Array<FlickrPhoto>? {
    guard let response = fetch("https://api.flickr.com/services/rest/?method=flickr.photos.search&per_page=\(maximumResults)&has_geo=1&user_id=\(nsid)&extras=original_format,tags,description,geo,date_upload,owner_name,place_url") else {
        return nil
    }
    return photosForFlickrJSONResponse(response)
}


/// get the ID for a given user
///
/// - parameter `user`: the flickr user name to get the ID for
public func idForUser(_ user: String) -> String? {
    guard let response = fetch("https://api.flickr.com/services/rest/?method=flickr.people.findByUsername&username=\(user)") else {
        return nil
    }
    return response.value(forKeyPath: "user.nsid") as? String
}


/// get photos out of a Flickr response
///
/// - parameter `response`: JSON dictionary as a response for a photos REST request
public func photosForFlickrJSONResponse(_ response: NSDictionary) -> Array<FlickrPhoto>? {
    guard let photoArray = response.value(forKeyPath: "photos.photo") as? Array<NSDictionary> else {
        return nil
    }
    return photoArray.reduce([FlickrPhoto]()) { array, dict in
        guard let photo = photo(dict) else { return array }
        return array + [photo]
    }
}


/// convert a photo JSON dictionary to a `FlickrPhoto`
///
/// - parameter `json`: JSON dictionary to interpret as a JSON encoded Flickr photo
public func photo(_ json: NSDictionary) -> FlickrPhoto? {
    guard let id = json["id"]     as? String,
              let sc = json["secret"] as? String,
              let ow = json["owner"]  as? String,
              let ti = json["title"]  as? String,
              let fa = json["farm"]   as? Int,
              let se = json["server"] as? String else { return nil }
    return FlickrPhoto(id: id, secret: sc, owner: ow, title: ti, farm: fa, server: se, originalSecret: json["originalsecret"] as? String, originalFormat: json["originalformat"] as? String)
}


/// get the URL for a photo
///
/// - parameter `photo`:  flickr photo to the the access URL string for
/// - parameter `format`: image format to download
public func url(_ photo: FlickrPhoto, format: FlickrPhotoFormat = .Original) -> URL? {
    guard let s = urlString(photo, format: format) else { return nil }
    return URL(string: s)
}


/// get the URL string for a photo
///
/// - parameter `photo`:  flickr photo to the the access URL string for
/// - parameter `format`: image format to download
public func urlString(_ photo: FlickrPhoto, format: FlickrPhotoFormat = .Original) -> String? {
    let kind: String
    let secret: String
    if format == .Original {
        guard let s = photo.originalFormat, let f = photo.originalFormat else { return nil }
        secret = s
        kind = f
    } else {
        kind = "jpg"
        secret = photo.secret
    }
    return "https://farm\(photo.farm).static.flickr.com/\(photo.server)/\(photo.id)_\(secret)_\(format.rawValue).\(kind)"
}



/// This is the function that actually fetches data from Flickr.
/// Don't invoke directly (unless you want to extend this Flickr API),
/// use one of the public functions instead!
///
/// - parameter `requestString`: string containing the REST request URL
func fetch(_ requestString: String) -> NSDictionary? {
    do {
        guard let url = URL(string: "\(requestString)&api_key=\(FlickrAPIKey)&format=json&nojsoncallback=1"),
                 let data = try? Data(contentsOf: url) else { return nil }
        return try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
    } catch {
        fputs("Error deserialising JSON Data: \(error) for request \(requestString)", stderr)
    }
    return nil
}

