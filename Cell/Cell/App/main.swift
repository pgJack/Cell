//
//  Main.swift
//  Beem
//
//  Created by Noah on 2021/8/17.
//

import UIKit

autoreleasepool {
    #if DEBUG
    #else
    disable_gdb()
    #endif
    UIApplicationMain(
        CommandLine.argc, CommandLine.unsafeArgv,
        nil, NSStringFromClass(AppManager.self)
    )
}
