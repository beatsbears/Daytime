// swift-tools-version:4.0
//
//  Package.swift
//  Daytime
//
//  Created by Andrew Scott on 9/10/18.
//
import PackageDescription

let package = Package(
    name: "Daytime",

    dependencies: [
        .package(url: "https://github.com/apple/swift-nio.git", 
                 from: "1.9.4"),
    ],

    targets: [
        .target(name: "Daytime", 
                dependencies: [
                  "NIO"
                ])
    ]
)
