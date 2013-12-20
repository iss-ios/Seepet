//
//  Common.m
//  Seepet
//
//  Created by mac on 13-11-21.
//
//

#import "Common.h"
@implementation Common

+(NSMutableDictionary *)getKeyChainQuery:(NSString *)service
{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge id)kSecClassGenericPassword,(__bridge id)kSecClass,
            service, (__bridge id)kSecAttrService,
            service, (__bridge id)kSecAttrAccount,
            (__bridge id)kSecAttrAccessibleAfterFirstUnlock,(__bridge id)kSecAttrAccessible,
            nil];
}

+(void)saveIdentifier:(NSString *)identifier identifierService:(NSString *)identifierService
{
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:identifierService];
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:identifier] forKey:(__bridge id)kSecValueData];
    SecItemAdd((__bridge CFDictionaryRef)keychainQuery, NULL);
}

+(void)deleteIdentifier:(NSString *)identifierService
{
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:identifierService];
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
}

+(NSString *)getIdentifier:(NSString *)identifierService
{
    NSString *ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:identifierService];
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    [keychainQuery setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr)
    {
        @try
        {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        }
        @catch (NSException *e)
        {
            NSLog(@"Unarchive of %@ failed: %@", identifierService, e);
        }
        @finally
        {
            
        }
    }
    if (keyData)
    {
        CFRelease(keyData);
    }
    
    if ([ret isEqualToString:@""] || ret == nil)
    {
        NSString *uuid = [[NSUUID UUID] UUIDString];
        [self saveIdentifier:uuid identifierService:IdentifierService];
        return uuid;
    }
    else
    {
        return ret;
    }
}

+(BOOL)checkUserLogin	
{
    NSData *userMap = [[NSUserDefaults standardUserDefaults] objectForKey:ENGINE_USER_INFO_KEY];
    BTEUserBean* bean = (BTEUserBean *)[NSKeyedUnarchiver unarchiveObjectWithData:userMap];
    if (bean == nil) {
        [self showLoginPage];
        return NO;
    }else{
        return YES;
    }
}

+(void)setUserInfomation:(NSMutableDictionary *)dictionary
{
    for (NSString *key in [dictionary allKeys]) {
        [[NSUserDefaults standardUserDefaults] setValue:[dictionary valueForKey:key] forKey:key];
    }
}

+(void)showLoginPage
{
    LoginViewController *loginPage = [[LoginViewController alloc] init];
    AppDelegate *_AppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [_AppDelegate.appNavigation pushViewController:loginPage animated:NO];
}

+(void)showRegisterPage
{
    RegisterViewController *registerPage = [[RegisterViewController alloc] init];
    AppDelegate *_AppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [_AppDelegate.appNavigation pushViewController:registerPage animated:YES];
}

+(void)showForgotPasswordPage
{
    ForgotPassWordViewController *forgotPassWordPage = [[ForgotPassWordViewController alloc] init];
    AppDelegate *_AppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [_AppDelegate.appNavigation pushViewController:forgotPassWordPage animated:YES];
}

+(void)hiddenLoginPage
{
    AppDelegate *_AppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [_AppDelegate.appNavigation popToRootViewControllerAnimated:YES];
    SWRevealViewController* swReveal = (SWRevealViewController*)[_AppDelegate.appNavigation topViewController];
    [swReveal.navigationController popToRootViewControllerAnimated:NO];
    swReveal.frontViewPosition = FrontViewPositionLeft;
}

+(void)showAnimationMenuButton:(BOOL)_bool
{
    AppDelegate *_AppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (_bool) {
        [_AppDelegate._QuadCurveMenu setHidden:NO];
    }else{
        [_AppDelegate._QuadCurveMenu setHidden:YES];
    }

}

+(NSString *)setCorrectURL:(NSString *)url
{
    NSString *urlString = [[url stringByReplacingOccurrencesOfString:@"\\" withString:@"/"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
//    urlString = [[urlString stringByReplacingOccurrencesOfString:@"\"" withString:@"/"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return urlString;
}
+(UIImage *)fitSmallImage:(UIImage *)image
{
    if (nil == image)
    {
        return nil;
    }
    if (image.size.width<Screen_Width && image.size.height<Screen_Height)
    {
        return image;
    }
    
    CGSize size = [Common fitsize:image.size];
    
    UIGraphicsBeginImageContext(size);
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    [image drawInRect:rect];
    
    UIImage *newing = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newing;
    
}
+ (CGSize)fitsize:(CGSize)thisSize
{
    
    if(thisSize.width == 0 && thisSize.height ==0)
        
        return CGSizeMake(0, 0);
    
    CGFloat wscale = thisSize.width/Screen_Width;
    
    CGFloat hscale = thisSize.height/Screen_Height;
    
    CGFloat scale = (wscale>hscale)?wscale:hscale;

    CGSize newSize = CGSizeMake(thisSize.width/scale, thisSize.height/scale);
    
    return newSize;
    
}

+(NSString *)checkFormatWithString:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    string = [string stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"'" withString:@""];
    
    return string;
}

+(NSInteger)getCountOf:(NSString *)string1 from:(NSString *)string2
{
    return [[string2 componentsSeparatedByString:string1] count] - 1;
}
+(BOOL)compareDateA:(NSString *)dateA isLaterThanDateB:(NSString *)dateB
{
    //<Dtime>2013-10-09</Dtime>
        
    
    //年-月-日array
    NSArray *aarray = [dateA componentsSeparatedByString:@"-"];
    NSArray *barray = [dateB componentsSeparatedByString:@"-"];
    //年
    NSString *ayear = [aarray objectAtIndex:0];
    NSString *byear = [barray objectAtIndex:0];
    //月
    NSString *amon = [aarray objectAtIndex:1];
    NSString *bmon = [barray objectAtIndex:1];
    //日
    NSString *aday = [aarray objectAtIndex:2];
    NSString *bday = [barray objectAtIndex:2];
    
        
    if ([ayear integerValue]>=[byear integerValue] && [amon integerValue]>=[bmon integerValue] && [aday integerValue]>=[bday integerValue]) {
        
        return YES;
    }
    return NO;
}

@end
