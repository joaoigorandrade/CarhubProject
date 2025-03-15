import ProjectDescription

let project = Project(
    name: "Carhub",
    packages: [
        .local(path: "vendor/Navigation")
    ],
    targets: [
        .target(
            name: "Carhub",
            destinations: .iOS,
            product: .app,
            bundleId: "com.joaoigor.Carhub",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["Carhub/Sources/**"],
            resources: ["Carhub/Resources/**"],
            dependencies: [
                .package(product: "Navigation")
            ]
        )
    ]
)
