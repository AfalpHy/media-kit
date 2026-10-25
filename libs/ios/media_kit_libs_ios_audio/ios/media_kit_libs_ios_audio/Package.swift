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

let libmpvArtifactBase = "https://github.com/AfalpHy/libmpv-darwin-build/releases/download/v0.41.0/libmpv-xcframeworks_v0.41.0_ios-universal-audio-default"
let libmpvChecksums = [
    "Ass": "4850988805ae87ae048ce36e84724348ad6a1ffd9c7e69ceeb3fa49218492f82",
    "Avcodec": "ac9cc569770b3ab6ebf01924fc7d7a7b4456d9f5cda212489c6de1d0b64ffeb0",
    "Avfilter": "bf7f332ae47cda16aa8df07c99292bc55edd7ece99d632720c3ed9dc2f4b7450",
    "Avformat": "960d4678fdb1c53123aef078b71bc783ab612f54701eee886eae98794f8478a9",
    "Avutil": "57cd656e5b299e13bcf6d46c8576e833b59826b3f8bb9af5ad0e7b9ea2584caa",
    "Freetype": "35a4e300916c6e2313f62a619b048ac6f74539a876f515f0c43837356ba00205",
    "Fribidi": "ffe4a9004c4c0a64920bc54e0071833be99713ed701724679efe0d6f48cb9c76",
    "Harfbuzz": "3b75700842f26b0d244170ca079cd22c97069fa9d8e133b88b3c1331a2debd1d",
    "Mpv": "2ba2c20f0fb9ac10b6f7e9382d777b5c5d5bf552336ed248b140ce4e2c09284b",
    "Swresample": "221f1d07cc26bc1a1b6dee667306556e58024f6193a7a31b48e9f55bff5b9896",
    "Swscale": "b74706a55a9f010feb3ad092bca66410f518e2f83044c931560c98a9b880afda"
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
