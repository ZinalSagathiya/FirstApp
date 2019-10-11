//
//  NSString+DES.m
//  DESEncryption
//

//

#import "NSString+DES.h"

@implementation NSString (DES)

- (NSString *)DES3EncryptWithKey
{
    NSString *key = @"61220121";
    NSData *plainData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptedData = [plainData DES3EncryptWithKey:key];
    NSString *encryptedString = [encryptedData base64Encoding];
    return encryptedString;
}

- (NSString *)DES3DecryptWithKey
{
    NSString *key = @"61220121";
    NSData *encryptedData = [NSData dataWithBase64EncodedString:self];
    NSData *plainData = [encryptedData DES3DecryptWithKey:key];
    NSString *plainString = [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];
    return plainString;
}
@end
