/*
 配列の範囲内になかった場合にnilを返す

 使用例
 let array = ["hoge", "fuga"]

 array[safe: 0] // Optional("hoge")
 array[safe: 1] // Optional("fuga")
 array[safe: 2] // nil

 */
extension Array {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
