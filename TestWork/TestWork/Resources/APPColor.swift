//
//  APPColor.swift
//  TestWork
//
//  Created by Vlad Kulakovsky  on 4.09.23.
//

import UIKit

struct APPColor {
    static var labelThemeColor: UIColor = {
        UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
                case .dark:
                    return UIColor.white
                default: return UIColor.black
            }
        }
    }()
    
    static var backgroundViewThemeColor: UIColor = {
        UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
                case .dark:
                    return UIColor(hue: 0.01, saturation: 0.02, brightness: 0.09, alpha: 1.0) // #171717
                default: return UIColor.white.withAlphaComponent(0.9)
            }
        }
    }()
    
    static var cellContentViewThemeColor: UIColor = {
        UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
                case .dark:
                    return UIColor(hue: 0.01, saturation: 0.02, brightness: 0.24, alpha: 1.0) // #3c3b3b
                default: return UIColor.white.withAlphaComponent(0.7)
            }
        }
    }()
    
    static var activityIndicatorThemeColor: UIColor = {
        UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
                case .dark:
                    return UIColor(hue: 0, saturation: 0, brightness: 0.89, alpha: 1.0) // #e2e2e2
                default: return UIColor(hue: 0, saturation: 0, brightness: 0.15, alpha: 1.0) // #272727
            }
        }
    }()
}
