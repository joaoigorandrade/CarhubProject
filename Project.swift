import ProjectDescription

let project = Project(
    name: "Carhub",
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
            dependencies: []
        )
    ]
)
