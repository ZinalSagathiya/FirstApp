//
//  NSString+DES.h
//  DESEncryption

//

#import <Foundation/Foundation.h>
#import "NSData+DES.h"


@interface NSString (DES)
- (NSString *)DES3EncryptWithKey;
- (NSString *)DES3DecryptWithKey;
@end
