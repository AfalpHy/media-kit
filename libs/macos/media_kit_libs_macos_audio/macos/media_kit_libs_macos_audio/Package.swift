// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let libmpvTargets = [
    "Ass",
    "Avcodec",
    "Avfilter",
    "Avformat",
    "Avutil",
    "Freetype",
    "Fribidi",
    "Harfbuzz",
    "Mpv",
    "Swresample",
    "Swscale"
]

let libmpvArtifactBase = "https://github.com/AfalpHy/libmpv-darwin-build/releases/download/v0.36.0/libmpv-xcframeworks_v0.36.0_macos-universal-audio-default"
let libmpvChecksums = [
    "Ass": "b3590fef954322f037cbba586d066d621381a843741511d6dc84d572bf1f8fa4",
    "Avcodec": "8ae22e5158abce63b848cb8363068310a4ff0730d55d59152fdf2344f167dba3",
    "Avfilter": "35ea58f184950373ea8d3f4ab55eca48315bb16a554c93d383d5593ac464721d",
    "Avformat": "8c198619f95ee88136b06430d51e78d42a94a62392d0dbcb04536b8f01cf2e5c",
    "Avutil": "e8bd17f846a89e7d56f0d76bb82bae00316da4ba0af9c8c3d5cc931a33766e2a",
    "Freetype": "111512abb2188a08415d69dadfd0f217625fbe43a48e9c5e880b447222cef733",
    "Fribidi": "e080a316f16c61ba7ddcbc74b68888f64fdc83c9b2901758f1e5d5372de05af9",
    "Harfbuzz": "20c8c2c4770b3a979d341680008129677a515f50f63e2a5929e9fdbccd094df3",
    "Mpv": "c230bfa4349ebb9b9c00c7dd57b946cbde475f3301a24659b880f8c2c1829b99",
    "Swresample": "5a9f6c6fbe2736bb50cc5d426d90072b555944ec985aa30f55f870abf1a8636e",
    "Swscale": "3123c336124a1d8d3de7464474b5b4a1284cbe79039f0d4151dad5bc1c3bc923"
]

let package = Package(
    name: "media_kit_libs_macos_audio",
    platforms: [
        .macOS("10.12")
    ],
    products: [
        .library(name: "media-kit-libs-macos-audio", targets: ["media_kit_libs_macos_audio"] + libmpvTargets)
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
            name: "media_kit_libs_macos_audio",
            dependencies: libmpvTargets.map { framework in .target(name: framework) },
            resources: [
                .process("PrivacyInfo.xcprivacy")
            ]
        )
    ]
)
