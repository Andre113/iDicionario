//
//  DictionaryManager.h
//  Navigation
//
//  Created by Andre Lucas Ota on 16/03/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DictionaryManager : NSObject{

}

//@property (nonatomic, strong) NSArray *palavras;
//@property (nonatomic, strong) NSArray *imagens;
//@property (nonatomic, strong) NSArray *letras;

+ (DictionaryManager *)sharedInstance;

//- (Boolean)checkView;
- (void) setCont:(int)cont;
- (int) getCont;
- (NSArray *) iniciaLetras;
- (NSArray *) iniciaImagens;
- (NSArray *) iniciaPalavras;
- (void) incrementa;
- (void) decrementa;
@end
