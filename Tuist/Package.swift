// swift-tools-version: 6.0
@preconcurrency import PackageDescription

#if TUIST
    import struct ProjectDescription.PackageSettings

    let packageSettings = PackageSettings(
        productTypes: [:]
    )
#endif

let package = Package(
    name: "Carhub",
    dependencies: [
        .package(path: "../vendor/Navigation")
    ],
    targets: [
        .target(
            name: "Carhub",
            dependencies: [
                .target(name: "Navigation")
            ]
        )
    ]
)
