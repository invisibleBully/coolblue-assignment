//
//  CoolBlueChallengeTests.swift
//  CoolBlueChallengeTests
//
//  Created by Jude on 10/08/2022.
//

import XCTest
@testable import CoolBlueChallenge

class CoolBlueChallengeTests: XCTestCase {
    
    var sut: ProductResponse!
    var product: Product!
    
    override func setUp() {
        super.setUp()
        
        let reviewSummary = ReviewSummary(reviewAverage: 9.700000000000000,
                                          reviewCount: 100)
        let reviewInformation = ReviewInformation(reviews: [],
                                                  reviewSummary: reviewSummary)
        
        product = Product(id: 1,
                          productName: "iPhone XR",
                          reviewInformation: reviewInformation,
                          uSPs: ["Wifi","GPS"],
                          availabilityState: 2,
                          salesPriceIncVat: 100.50000000,
                          productImage: "https://image.coolblue.nl/300x750/products/422838",
                          coolbluesChoiceInformationTitle: nil,
                          promoIcon: nil,
                          nextDayDelivery: true)
        
        let data = try! getData(fromJSON: "products")
        sut = try! JSONDecoder().decode(ProductResponse.self, from: data)
    }
    
    override func tearDown() {
        product = nil
        sut = nil
        super.tearDown()
    }
    
    
    func testJSONMapping(){
        XCTAssertEqual(sut.products?.count, 24)
        XCTAssertEqual(sut.pageCount, 3)
    }
    
    func testCreatingProduct(){
        XCTAssertNotNil(product)
    }
    
    func testFormmatingSalesPriceWith(){
        XCTAssertEqual(Product.formatAmount(product.salesPriceIncVat!),"100.5")
    }
    
    func testFormatRatingValue(){
        print(product.reviewInformation!.reviewSummary!.reviewAverage!.formatAverageRating())
        XCTAssertEqual((product.reviewInformation!.reviewSummary!.reviewAverage!).formatAverageRating(),"9.7")
    }
    
    
}
