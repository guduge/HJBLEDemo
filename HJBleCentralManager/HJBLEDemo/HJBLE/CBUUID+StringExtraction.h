//
//  CBUUID+StringExtraction.h
//  HJBLEDemo
//
//  Created by 赵优路 on 2020/4/25.
//  Copyright © 2020 thj. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>

@interface CBUUID (StringExtraction)
 
- (NSString *)representativeString;
 
@end
 
@implementation CBUUID (StringExtraction)
- (NSString *)representativeString;
{
    NSData *data = [self data];
 
    NSUInteger bytesToConvert = [data length];
    const unsigned char *uuidBytes = [data bytes];
    NSMutableString *outputString = [NSMutableString stringWithCapacity:16];
 
    for (NSUInteger currentByteIndex = 0; currentByteIndex < bytesToConvert; currentByteIndex++)
    {
        switch (currentByteIndex)
        {
            case 3:
            case 5:
            case 7:
            case 9:[outputString appendFormat:@"%02x-", uuidBytes[currentByteIndex]]; break;
            default:[outputString appendFormat:@"%02x", uuidBytes[currentByteIndex]];
        }
 
    }

        return outputString;
    }
     
    @end

