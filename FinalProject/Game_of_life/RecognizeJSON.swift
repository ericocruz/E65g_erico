
import UIKit

class RecognizeJSON: NSObject {
    static func parceJSON(urlSting: String) -> [String: [[Int]]]
    {
        var dict = [String: [[Int]]]()
        if let url = NSURL(string: urlSting) as? URL // create url
        {
            if let data = try? Data(contentsOf: url) // get data from url
            {
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as? [AnyObject] // parce json
                {
                    for index in 0...(parsedData?.count)! - 1
                    {
                        let title = parsedData?[index].value(forKey: "title") as? String ?? "" // get title from json
                        let contents = parsedData?[index].value(forKey: "contents") as? [[Int]] ?? [[]]
                        dict[title] = contents
                    }
                }
            }
        }
        
        return dict
    }

}
