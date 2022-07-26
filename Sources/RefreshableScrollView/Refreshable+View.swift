//
//  SwiftUIView.swift
//  
//
//  Created by qihoo on 2022/7/26.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension View {
    func pullToRefresh(_ isRefreshing: Binding<Bool>, action: (() -> Void)? = nil) -> some View {
        self.background(
            RefreshableScrollView(isRefreshing: isRefreshing, action: action)
                .background(Color.clear)
        )
    }
}
