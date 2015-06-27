//
//  Person.h
//  
//
//  Created by Paul Sweeney Jr on 6/4/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@import UIKit;

@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * sex;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) UIColor * colorLabel;


@end
