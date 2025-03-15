import ProjectDescription

let dependencies = Dependencies(
    // Example for Swift Package Manager
    swiftPackageManager: [
        .remote(
            url: "https://github.com/Alamofire/Alamofire.git",
            requirement: .upToNextMajor(from: "5.6.0")
        )
    ],
    platforms: [.iOS]
)
