// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let libmpvTargets = [
    "Ass",
    "Avcodec",
    "Avfilter",
    "Avformat",
    "Avutil",
    "Crypto",
    "Freetype",
    "Fribidi",
    "Harfbuzz",
    "Mpv",
    "Ssl",
    "Swresample",
    "Swscale"
]

let libmpvArtifactBase = "https://github.com/AfalpHy/libmpv-darwin-build/releases/download/v0.42.0/libmpv-xcframeworks_v0.42.0_ios-universal-audio-default"
let libmpvChecksums = [
    "Ass": "8a5ef1e999d3bd808e6472f868207d2f2ec2565f11ecd421f5064110ad8437f1",
    "Avcodec": "70cf23448c327692ae53e45e38aa5ff7eb34b388e2a8310cc35b30595de04c3d",
    "Avfilter": "4a1d1cdb6b0977310fdfd5067def2dad90ab4d2e4cd4bcd0443c9dcaed302b5f",
    "Avformat": "5124f00e615567e1981af5f614a9355c5c22cc1d8bd7938c22452af471c3d282",
    "Avutil": "5cc6b128c88a62779151dae2e41ef5de1a43560c6e82247721495ceef335495f",
    "Crypto": "76fc84617abbc3816d0bb4ec8e7f6ed71583e51da369ad01ed5796351993c4d6",
    "Freetype": "03b7e1fba9796c0be32c2d4e81808c6fa9f001e2f1f29f1383f5f3be1a178152",
    "Fribidi": "982b462da97dc6748f57da9e1b1f3ea20a11b01235ff363b940f37923ba00156",
    "Harfbuzz": "5ed47d1e7cdafe06036c63751fc8ed670b757528fa3284056935ce07b576f7dc",
    "Mpv": "7328665aeba45c37ebe57a8c51adf215ad48a2e265f7074385d81930f307db99",
    "Ssl": "eecc633b297e32ecbd33e3b255d7faf2337b828ba6f6bbe2b6f1e15c8fed8db6",
    "Swresample": "7f29dffed55786ca8183b9d0afc27b7758447eb0da98f2f63adb2563de0c0da3",
    "Swscale": "e53d4ff90ac41c42105e57104f816876ea1e2189540e46885fba0e04987f0022"
]

let package = Package(
    name: "media_kit_libs_ios_audio",
    platforms: [
        .iOS("14.0")
    ],
    products: [
        .library(name: "media-kit-libs-ios-audio", targets: ["media_kit_libs_ios_audio"] + libmpvTargets),
        .library(name: "Mpv", targets: ["Mpv"])
    ],
    dependencies: [],
    targets: libmpvTargets.map { framework in
        .binaryTarget(
            name: framework,
            url: "\(libmpvArtifactBase)_\(framework).zip",
            checksum: libmpvChecksums[framework]!
        )
    } + [
        .target(
            name: "media_kit_libs_ios_audio",
            dependencies: libmpvTargets.map { framework in .target(name: framework) },
            resources: [
                .process("PrivacyInfo.xcprivacy")
            ]
        )
    ]
)
