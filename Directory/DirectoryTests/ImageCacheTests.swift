//
//  ImageCacheTests.swift
//  DirectoryTests
//
//  Created by Kesh Gurung on 10/09/2022.
//

import XCTest
@testable import Directory

class ImageCacheTests: XCTestCase {
    
    var imageCache: ImageCache?

    override func setUpWithError() throws {
        try super.setUpWithError()
        self.imageCache = ImageCache.shared
         }

    override func tearDownWithError() throws {
        self.imageCache = nil
        try super.tearDownWithError()
    }

    func testCacheKeyNotFound() {
        
        let key = "SampleKey"
        
        let imageData = self.imageCache?.getImageData(key: key)
        
        XCTAssertNil(imageData)
    }
    
    func testCacheReadsAndWritesData(){
        // Arrange
        let key = "SampleKey"
        let sampleImage = UIImage(named: "dir")?.jpegData(compressionQuality: 1.0) ?? Data()
        
        // Act
        self.imageCache?.setImageData(data: sampleImage, key: key)
        let pulledImageData = self.imageCache?.getImageData(key: key)
        
        // Assert
        XCTAssertEqual(pulledImageData, sampleImage)
    }
}


