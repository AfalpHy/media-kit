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

let libmpvArtifactBase = "https://github.com/AfalpHy/libmpv-darwin-build/releases/download/v0.41.0/libmpv-xcframeworks_v0.41.0_macos-universal-audio-default"
let libmpvChecksums = [
    "Ass": "bc4bbe6b7397da48e3fbc0bc32b38741cd76b725bab48419f6a1ae1a02b57c3e",
    "Avcodec": "25f9c7ca2ba5522d175a0afd0478e4a03c7b8fb6f0a0e6cdac9be4cdeaa6de64",
    "Avfilter": "6601df32552656be92e567d2753d111d4d920185cfcb0c28ba62a74e69c5ed0a",
    "Avformat": "985441b8dfa191c74e338dec044a9372c6711e2d318aef535f0825c806bea76a",
    "Avutil": "00d0e49b1305595e3f4eff269929bf9ed237588aa52ca8a75910a6fb1d55a92d",
    "Freetype": "751a83adfa3bc03b6c2c44bacd619d380722399be696b9ad09c354528943f041",
    "Fribidi": "cbdabe47830968b48389345002ca69f60aff7763d8ec32034160ca3fa515570b",
    "Harfbuzz": "eea707b034964d5774c768ceaddc1eb5381e6a119cbc98065faa5a04b082a40e",
    "Mpv": "09f73a2261a6b6fa0803cac555b3792404e053f34e740778cba4dcbf7ee80247",
    "Swresample": "eb6dcb6d8fa45d469e85fc73c3915c8c1433af0b0df0cb8f43d7f81b15ab10d0",
    "Swscale": "b5ddb781fae16fbb36ca5355e7b1738e0ad5ca016ce44665d0dd9f4d737433d7"
]

let package = Package(
    name: "media_kit_libs_macos_audio",
    platforms: [
        .macOS("10.12")
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
