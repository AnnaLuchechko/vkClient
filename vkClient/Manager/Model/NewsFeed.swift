// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let newsPost = try? newJSONDecoder().decode(NewsPost.self, from: jsonData)

import Foundation

struct NewsFeed: Codable {
    let response: Response
    
    struct Response: Codable {
        let items: [ResponseItem]
        let profiles: [Profile]
        let groups: [Group]
        let nextFrom: String

        enum CodingKeys: String, CodingKey {
            case items, profiles, groups
            case nextFrom = "next_from"
        }
    }

    struct Group: Codable {
        let id: Int
        let name, screenName: String
        let isClosed: Int
        let type: GroupType
        let isAdmin, isMember, isAdvertiser: Int?
        let photo50, photo100, photo200: String

        enum CodingKeys: String, CodingKey {
            case id, name
            case screenName = "screen_name"
            case isClosed = "is_closed"
            case type
            case isAdmin = "is_admin"
            case isMember = "is_member"
            case isAdvertiser = "is_advertiser"
            case photo50 = "photo_50"
            case photo100 = "photo_100"
            case photo200 = "photo_200"
        }
    }

    enum GroupType: String, Codable {
        case group = "group"
        case page = "page"
    }

    struct ResponseItem: Codable {
        let sourceID, date: Int
        let canDoubtCategory, canSetCategory: Bool?
        let postType: PostTypeEnum?
        let text: String?
        let copyHistory: [CopyHistory]?
        let markedAsAds: Int?
        let postSource: PostSource?
        let comments: Comments?
        let likes: PurpleLikes?
        let reposts: Reposts?
        let views: Views?
        //let isFavorite: Bool?
        let postID: Int
        let type: PostTypeEnum
        let photos: Photos?
        let attachments: [ItemAttachment]?
        let signerID: Int?
        //let copyright: Copyright?

        enum CodingKeys: String, CodingKey {
            case sourceID = "source_id"
            case date
            case canDoubtCategory = "can_doubt_category"
            case canSetCategory = "can_set_category"
            case postType = "post_type"
            case text
            case copyHistory = "copy_history"
            case markedAsAds = "marked_as_ads"
            case postSource = "post_source"
            case comments, likes, reposts, views
            //case isFavorite = "is_favorite"
            case postID = "post_id"
            case type, photos, attachments
            case signerID = "signer_id"
            //case copyright
        }
    }

    struct ItemAttachment: Codable {
        let type: AttachmentType?
        let photo: LinkPhoto?
        let video: AttachmentVideo?
        let link: Link?
        let doc: Doc?
        let audio: Audio?
    }

    struct Audio: Codable {
        let artist: String
        let id, ownerID: Int
        let title: String
        let duration: Int
        let isExplicit, isFocusTrack: Bool
        let trackCode: String
        let url: String
        let date: Int
        let albumID: Int?
        let contentRestricted: Int?
        let mainArtists: [MainArtist]?
        let shortVideosAllowed, storiesAllowed, storiesCoverAllowed: Bool
        let genreID: Int?

        enum CodingKeys: String, CodingKey {
            case artist, id
            case ownerID = "owner_id"
            case title, duration
            case isExplicit = "is_explicit"
            case isFocusTrack = "is_focus_track"
            case trackCode = "track_code"
            case url, date
            case albumID = "album_id"
            case contentRestricted = "content_restricted"
            case mainArtists = "main_artists"
            case shortVideosAllowed = "short_videos_allowed"
            case storiesAllowed = "stories_allowed"
            case storiesCoverAllowed = "stories_cover_allowed"
            case genreID = "genre_id"
        }
    }

    struct MainArtist: Codable {
        let name, domain, id: String
    }

    struct Doc: Codable {
        let id, ownerID: Int
        let title: String
        let size: Int
        let ext: String
        let date, type: Int
        let url: String
        let preview: Preview
        let accessKey: String

        enum CodingKeys: String, CodingKey {
            case id
            case ownerID = "owner_id"
            case title, size, ext, date, type, url, preview
            case accessKey = "access_key"
        }
    }

    struct Preview: Codable {
        let photo: PreviewPhoto
        let video: VideoElement
    }

    struct PreviewPhoto: Codable {
        let sizes: [VideoElement]
    }

    struct VideoElement: Codable {
        let src: String?
        let width, height: Int
        let type: SizeType?
        let fileSize: Int?
        let url: String?
        let withPadding: Int?

        enum CodingKeys: String, CodingKey {
            case src, width, height, type
            case fileSize = "file_size"
            case url
            case withPadding = "with_padding"
        }
    }

    enum SizeType: String, Codable {
        case a = "a"
        case b = "b"
        case c = "c"
        case d = "d"
        case e = "e"
        case i = "i"
        case k = "k"
        case l = "l"
        case m = "m"
        case o = "o"
        case p = "p"
        case q = "q"
        case r = "r"
        case s = "s"
        case w = "w"
        case x = "x"
        case y = "y"
        case z = "z"
        case temp = "temp"
    }

    struct Link: Codable {
        let url: String
        let title, linkDescription: String
        let buttonText, buttonAction, target: String?
        let photo: LinkPhoto?
        //let isFavorite: Bool
        let caption: String?

        enum CodingKeys: String, CodingKey {
            case url, title
            case linkDescription = "description"
            case buttonText = "button_text"
            case buttonAction = "button_action"
            case target, photo
            //case isFavorite = "is_favorite"
            case caption
        }
    }

    struct LinkPhoto: Codable {
        let albumID, date, id, ownerID: Int?
        let hasTags: Bool
        let sizes: [VideoElement]
        let text: String
        let userID: Int?
        let accessKey: String?
        let postID: Int?

        enum CodingKeys: String, CodingKey {
            case albumID = "album_id"
            case date, id
            case ownerID = "owner_id"
            case hasTags = "has_tags"
            case sizes, text
            case userID = "user_id"
            case accessKey = "access_key"
            case postID = "post_id"
        }
    }

    enum AttachmentType: String, Codable {
        case audio = "audio"
        case doc = "doc"
        case link = "link"
        case photo = "photo"
        case video = "video"
    }

    struct AttachmentVideo: Codable {
        let accessKey: String
        let canComment, canLike, canRepost, canSubscribe: Int
        let canAddToFaves, canAdd, date: Int
        let videoDescription: String
        let duration: Int
        let image: [VideoElement]
        let firstFrame: [VideoElement]?
        let width, height: Int?
        let id, ownerID: Int
        let title: String
        //let isFavorite: Bool
        let trackCode: String
        let videoRepeat: Int?
        let type: AttachmentType?
        let views: Int
        let comments, live, spectators, localViews: Int?
        let platform: String?

        enum CodingKeys: String, CodingKey {
            case accessKey = "access_key"
            case canComment = "can_comment"
            case canLike = "can_like"
            case canRepost = "can_repost"
            case canSubscribe = "can_subscribe"
            case canAddToFaves = "can_add_to_faves"
            case canAdd = "can_add"
            case date
            case videoDescription = "description"
            case duration, image
            case firstFrame = "first_frame"
            case width, height, id
            case ownerID = "owner_id"
            case title
            //case isFavorite = "is_favorite"
            case trackCode = "track_code"
            case videoRepeat = "repeat"
            case type, views, comments, live, spectators
            case localViews = "local_views"
            case platform
        }
    }

    struct Comments: Codable {
        let count, canPost: Int
        let groupsCanPost: Bool?

        enum CodingKeys: String, CodingKey {
            case count
            case canPost = "can_post"
            case groupsCanPost = "groups_can_post"
        }
    }

    struct CopyHistory: Codable {
        let id, ownerID, fromID, date: Int
        let postType: PostTypeEnum
        let text: String
        let postSource: PostSource?
        let attachments: [CopyHistoryAttachment]?

        enum CodingKeys: String, CodingKey {
            case id
            case ownerID = "owner_id"
            case fromID = "from_id"
            case date
            case postType = "post_type"
            case text
            case postSource = "post_source"
            case attachments
        }
    }

    struct CopyHistoryAttachment: Codable {
        let type: AttachmentType?
        let photo: LinkPhoto?
    }

    struct PostSource: Codable {
        let type: PostSourceType?
        let platform: Platform?
    }

    enum Platform: String, Codable {
        case android = "android"
        case iphone = "iphone"
    }

    enum PostSourceType: String, Codable {
        case api = "api"
        case vk = "vk"
        case rss = "rss"
    }

    enum PostTypeEnum: String, Codable {
        case photo = "photo"
        case post = "post"
        case rss = "rss"
    }

//    struct Copyright: Codable {
//        //let link: String
//        let type, name: String
//        let id: Int?
//    }

    struct PurpleLikes: Codable {
        let count, userLikes, canLike, canPublish: Int

        enum CodingKeys: String, CodingKey {
            case count
            case userLikes = "user_likes"
            case canLike = "can_like"
            case canPublish = "can_publish"
        }
    }

    struct Photos: Codable {
        let count: Int
        let items: [PhotosItem]
    }

    struct PhotosItem: Codable {
        let albumID, date, id, ownerID: Int?
        let hasTags: Bool
        let accessKey: String
        let sizes: [VideoElement]
        let text: String
        let userID: Int
        let likes: FluffyLikes
        let reposts: Reposts
        let comments: Views
        let canComment, canRepost: Int

        enum CodingKeys: String, CodingKey {
            case albumID = "album_id"
            case date, id
            case ownerID = "owner_id"
            case hasTags = "has_tags"
            case accessKey = "access_key"
            case sizes, text
            case userID = "user_id"
            case likes, reposts, comments
            case canComment = "can_comment"
            case canRepost = "can_repost"
        }
    }

    struct Views: Codable {
        let count: Int
    }

    struct FluffyLikes: Codable {
        let userLikes, count: Int

        enum CodingKeys: String, CodingKey {
            case userLikes = "user_likes"
            case count
        }
    }

    struct Reposts: Codable {
        let count, userReposted: Int

        enum CodingKeys: String, CodingKey {
            case count
            case userReposted = "user_reposted"
        }
    }

    struct Profile: Codable {
        let id: Int
        let firstName, lastName: String
        let isClosed, canAccessClosed: Bool?
        let sex: Int
        let screenName: String?
        let photo50, photo100: String
        let online: Int
        let onlineInfo: OnlineInfo
        let deactivated: String?

        enum CodingKeys: String, CodingKey {
            case id
            case firstName = "first_name"
            case lastName = "last_name"
            case isClosed = "is_closed"
            case canAccessClosed = "can_access_closed"
            case sex
            case screenName = "screen_name"
            case photo50 = "photo_50"
            case photo100 = "photo_100"
            case online
            case onlineInfo = "online_info"
            case deactivated
        }
    }

    struct OnlineInfo: Codable {
        let visible, isOnline, isMobile: Bool
        let lastSeen, appID: Int?

        enum CodingKeys: String, CodingKey {
            case visible
            case isOnline = "is_online"
            case isMobile = "is_mobile"
            case lastSeen = "last_seen"
            case appID = "app_id"
        }
    }

}
