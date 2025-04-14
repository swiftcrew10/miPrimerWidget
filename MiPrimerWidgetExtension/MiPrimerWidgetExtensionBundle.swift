//
//  MiPrimerWidgetExtensionBundle.swift
//  MiPrimerWidgetExtension
//
//  Created by UwU on 14/04/25.
//

import WidgetKit
import SwiftUI

struct MiPrimerWidgetExtensionBundle: WidgetBundle {
    var body: some Widget {
        MiPrimerWidgetExtension()
        MiPrimerWidgetExtensionControl()
        MiPrimerWidgetExtensionLiveActivity()
    }
}
