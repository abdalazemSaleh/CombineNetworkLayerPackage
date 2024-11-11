# Combine based Network Layer

A simple network layer to handle network calls throughout the app, featuring a logger system to track requests, responses, and other details.
## Installation

### Swift Package Manager (SPM)

You can add this package to your project using Swift Package Manager, either through Xcode’s package integration or directly in your `Package.swift` file.

#### Method 1: Xcode Integration

- In Xcode, go to **File > Add Packages…**.
- Enter the repository URL for this package:

```plaintext
https://github.com/yourusername/your-repo.git
```

#### Method 2: Package.swift

If you manage dependencies using a `Package.swift` file, add this package as a dependency:

```swift
dependencies: [
    .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.10.0"))
]
```
