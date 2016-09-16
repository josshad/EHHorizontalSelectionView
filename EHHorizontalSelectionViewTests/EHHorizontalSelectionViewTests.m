//
//  EHHorizontalSelectionViewTests.m
//  EHHorizontalSelectionViewTests
//
//  Created by Danila Gusev on 30/08/2016.
//  Copyright © 2016 josshad. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EHHorizontalSelectionView.h"

@interface EHHorizontalSelectionViewTests : XCTestCase

@end

@implementation EHHorizontalSelectionViewTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCreation {
    EHHorizontalSelectionView * sw = [EHHorizontalSelectionView new];
    XCTAssertNotNil(sw);
    [sw registerCellWithClass:[EHHorizontalLineViewCell class]];
}

- (void)testColor
{
    UIColor * color = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:arc4random()%255/255.0];
    [EHHorizontalLineViewCell updateTintColor:color];
    XCTAssertEqual(color, [EHHorizontalLineViewCell tintColor]);
    [EHRoundedHorizontalViewCell updateTintColor:color];
    XCTAssertEqual(color, [EHRoundedHorizontalViewCell tintColor]);
}


- (void)testFont
{
    UIFont * f = [UIFont systemFontOfSize:12];
    [EHHorizontalLineViewCell updateFont:f];
    XCTAssertEqual(f, [EHHorizontalLineViewCell font]);
    [EHHorizontalLineViewCell updateFontMedium:f];
    XCTAssertEqual(f, [EHHorizontalLineViewCell fontMedium]);
    [EHRoundedHorizontalViewCell updateFont:f];
    XCTAssertEqual(f, [EHRoundedHorizontalViewCell font]);
    [EHRoundedHorizontalViewCell updateFontMedium:f];
    XCTAssertEqual(f, [EHRoundedHorizontalViewCell fontMedium]);
}


- (void)testGap
{
    float f = 11.55;
    [EHHorizontalLineViewCell updateCellGap:f];
    XCTAssertEqual(f, [EHHorizontalLineViewCell cellGap]);
    [EHRoundedHorizontalViewCell updateCellGap:f];
    XCTAssertEqual(f, [EHRoundedHorizontalViewCell cellGap]);
}


- (void)testColorHeight
{
    float h = 1.55;
    [EHHorizontalLineViewCell updateColorHeight:h];
    XCTAssertEqual(h, [EHHorizontalLineViewCell colorHeight]);
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
