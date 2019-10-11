//
//  NSData+DES.h
//  DESEncryption
//

//

#import <Foundation/Foundation.h>

@interface NSData (DES)
- (NSData *)DES3EncryptWithKey:(NSString *)key;
- (NSData *)DES3DecryptWithKey:(NSString *)key;

+ (NSData *)dataWithBase64EncodedString:(NSString *)string;
- (id)initWithBase64EncodedString:(NSString *)string;

- (NSString *)base64Encoding;
- (NSString *)base64EncodingWithLineLength:(NSUInteger)lineLength;

- (BOOL)hasPrefixBytes:(const void *)prefix length:(NSUInteger)length;
- (BOOL)hasSuffixBytes:(const void *)suffix length:(NSUInteger)length;

@end
