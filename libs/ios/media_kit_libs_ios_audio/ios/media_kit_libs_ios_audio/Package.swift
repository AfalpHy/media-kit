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

let libmpvArtifactBase = "https://github.com/AfalpHy/libmpv-darwin-build/releases/download/v0.36.0/libmpv-xcframeworks_v0.36.0_ios-universal-audio-default"
let libmpvChecksums = [
    "Ass": "77cb4c8644fe4c5c14fb2c04e3b0dd96b0434b533c4785102691831553aa5954",
    "Avcodec": "b108177561cd04d871a9a27fe131d78c5f4fce11aacb015a921355ff47821ee2",
    "Avfilter": "0dffab83148822b176142636134b5ffd67cc63478c660ff294f60bfc063e9912",
    "Avformat": "f26e9569cebe6aa1d57acab24b4287e23d83cea47aa4792cf17d988b43a9f58c",
    "Avutil": "5a10c9cc06b1745edb240687108cf22196c69c577da7e8f82b740bcab089ecae",
    "Freetype": "4660ac41c9e0f9ada0bdfb7d633a033fa139c78df2a8c32dbed360b3d3f4f676",
    "Fribidi": "5c017cef0adf558bbc019bfe357b15e5f8ba995eaaf2b3f50baa5b4828487a24",
    "Harfbuzz": "c167497ff735a055efcc6a859279330b4c0d3b3019ba140775bec59e3616a149",
    "Mpv": "2fbd85900e00e305697e46e2a0c134e96d302a38bcd6adb0448a1548192a0301",
    "Swresample": "a3ef27a5f918f357dd136adef1698f0d105d55ce1bca5d8bfb541e234838b43f",
    "Swscale": "0da04a5251e21bf2a111522dac3a92ba6b69497c2f0122a367c4818ec8d7b362"
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
