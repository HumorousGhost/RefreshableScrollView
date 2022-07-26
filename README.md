# RefreshableScrollView

This project is only for SwiftUI

Pull-to-refresh functionality for List and ScrollView controls

Encapsulated `UITableView`, `UIScrollView`, `UICollectionView` can also be used

## Demo

```swift
    let array = ["text1", "text2", "text3"]
    @State private var isResresh: Bool = false
    
    var body: some View {
        ScrollViewReader { proxy in
            List {
                ForEach(0..<array.count) { index in
                    let text = array[index]
                    HStack {
                        Text(text)
                    }
                }
            }
            .pullToRefresh($isResresh) {
                // refresh done
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    isResresh = false
                }
            }
        }
    }
```

## Installation

You can add RefreshableScrollView to an Xcode project by adding it as a package dependency.

1. From the File menu, select Swift Packages › Add Package Dependency…
2. Enter https://github.com/HumorousGhost/KeyboardHost into the package repository URL text field
3. Link RefreshableScrollView to your application target

