// エラーの定義

struct ErrorMessage {
    var title: String
    var description: String
}

enum ErrorType: Error {

    case offline
    case invalidParams
    case unauthorized
    case forbidden
    case notFound
    case serverError
    case unKnown
    case decode

    var message: ErrorMessage {
        switch self {
        case .offline:
            return ErrorMessage(title: "オフラインエラー", description: "ネットワークの接続状況を確認してください")
        
        case .invalidParams:
            return ErrorMessage(title: "400エラー", description: "無効なリクエストです")

        case .unauthorized:
            return ErrorMessage(title: "401エラー", description: "認証されていません")

        case .forbidden:
            return ErrorMessage(title: "403エラー", description: "アクセスが禁止されています")

        case .notFound:
            return ErrorMessage(title: "404エラー", description: "お探しの情報が見つかりませんでした")

        case .serverError:
            return ErrorMessage(title: "500エラー", description: "システムに問題が発生しました")

        case .unKnown:
            return ErrorMessage(title: "不明なエラー", description: "不明なエラーが発生しました")

        case .decode:
            return ErrorMessage(title: "デコードエラー", description: "レスポンスを確認してください")
        }
        
    }
}
