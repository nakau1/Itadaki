// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import CoreGraphics

extension CGFloat {
    
    /// パーセンテージ (0未満は0, 1以上は1を返す)
    var percentage: CGFloat {
        if self <= 0 {
            return 0
        } else if 1 <= self {
            return 1
        } else {
            return self
        }
    }
}

extension CGPoint {
    
    init(_ x: CGFloat, _ y: CGFloat) {
        self.init(x: x, y: y)
    }
    
    static func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(lhs.x + rhs.x, lhs.y + rhs.y)
    }
    
    static func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(lhs.x - rhs.x, lhs.y - rhs.y)
    }
    
    static func *(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return CGPoint(lhs.x * rhs, lhs.y * rhs)
    }
    
    static func /(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return CGPoint(lhs.x / rhs, lhs.y / rhs)
    }
}

extension CGSize {
    
    init(_ width: CGFloat, _ height: CGFloat) {
        self.init(width: width, height: height)
    }
    
    var horizontalHalfSize: CGSize {
        return CGSize(width / 2, height)
    }
    
    var horizontalHalfPoint: CGPoint {
        return CGPoint(width / 2, 0)
    }
    
    func horizontalCenterFrame(of parentSize: CGSize) -> CGRect {
        return CGRect((parentSize.width - self.width) / 2, 0, self.width, self.height)
    }
    
    func centerFrame(of parentSize: CGSize) -> CGRect {
        return CGRect((parentSize.width - self.width) / 2,
                      (parentSize.height - self.height) / 2,
                      self.width,
                      self.height
        )
    }
    
    static func *(lhs: CGSize, rhs: CGFloat) -> CGSize {
        return CGSize(lhs.width * rhs, lhs.height * rhs)
    }
    
    static func /(lhs: CGSize, rhs: CGFloat) -> CGSize {
        return CGSize(lhs.width / rhs, lhs.height / rhs)
    }
}

extension CGRect {
    
    init(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        self.init(x: x, y: y, width: width, height: height)
    }
    
    init(_ origin: CGPoint, _ size: CGSize) {
        self.init(origin: origin, size: size)
    }
    
    init(_ size: CGSize) {
        self.init(origin: .zero, size: size)
    }
}

extension Int {
    
    var f: CGFloat {
        return CGFloat(self)
    }
}

extension Double {
    
    var f: CGFloat {
        return CGFloat(self)
    }
}

extension Float {
    
    var f: CGFloat {
        return CGFloat(self)
    }
}
