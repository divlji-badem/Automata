//
//  Created by Jelena Tasic on 12.12.21.
//

public extension FixedWidthInteger {

    static func random() -> Self {
        random(in: .min ... .max)
    }
}
