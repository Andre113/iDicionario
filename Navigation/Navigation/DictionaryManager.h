//
//  DictionaryManager.h
//  Navigation
//
//  Created by Andre Lucas Ota on 16/03/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DictionaryManager : NSObject


+ (DictionaryManager *)sharedInstance;

- (int) getCont;
- (NSArray *) iniciaLetras;
- (NSArray *) iniciaImagens;
- (NSArray *) iniciaPalavras;
- (void) incrementa;
- (void) decrementa;
@end
