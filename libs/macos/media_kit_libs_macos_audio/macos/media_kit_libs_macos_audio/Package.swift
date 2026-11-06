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

let libmpvArtifactBase = "https://github.com/AfalpHy/libmpv-darwin-build/releases/download/v0.42.0/libmpv-xcframeworks_v0.42.0_macos-universal-audio-default"
let libmpvChecksums = [
    "Ass": "e7ab4142335aabcba57b62869be3413a3b3e8872fc8aeb1d031fd99a9f4f2a4c",
    "Avcodec": "8ec1a9f5690c448c758a3c2426b412006d5a504d39c3aebc161fd4232b3625a9",
    "Avfilter": "2f590ea0b4f240a30e0a1ba9372066e32f6a3881754d266caaffcf14279a85b8",
    "Avformat": "f008e51b64d8601401ff3a98bee6491e12ba592ef9118c7d3a5af87b41ca256b",
    "Avutil": "7533769c753117d836b923907d0e393b3f3c40979a7232ff2323ede158aafed7",
    "Crypto": "d6a05587cd782a222ed28fbce15f221949d1501249cb7888bd7a3eae509e7706",
    "Freetype": "e5ebe44262642f8a1a3967d55cf905f3c8c2d41f81fdf38b4314b715175e707e",
    "Fribidi": "913504d6681d905305916247f8d7f57ac59ee5099e8b38213dbdc9ba72398788",
    "Harfbuzz": "8666ff4bd54cc9b557bd7f9d30cb3e2a333c3ba3d45c8e2689d991f7911fa6b0",
    "Mpv": "06454427312b1f512680387f01b51fa83c58e8500d6468602a51bdc1b2931764",
    "Ssl": "699e6a307dfe8506870ab5bd7029bb41459f643995e8af8171a6696cb6951dec",
    "Swresample": "0802d25915ae1f959c4615d9a4db4469de16c1bd31efd6193326d600407acc6b",
    "Swscale": "c25fd4be9e5a34929f491b3bba0cf1cb6d26c46df086843961ef660705934673"
]

let package = Package(
    name: "media_kit_libs_macos_audio",
    platforms: [
        .macOS("13.0")
    ],
    products: [
        .library(name: "media-kit-libs-macos-audio", targets: ["media_kit_libs_macos_audio"] + libmpvTargets),
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
