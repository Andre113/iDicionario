//
//  DictionaryManager.m
//  Navigation
//
//  Created by Andre Lucas Ota on 16/03/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "DictionaryManager.h"

@implementation DictionaryManager{
//    NSMutableArray *views;
}

static DictionaryManager *SINGLETON = nil;
static int cont = 0;
static bool isFirst = YES;

#pragma mark - Public Method

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirst = NO;
        SINGLETON = [[super allocWithZone:NULL] init];
    });
    
    return SINGLETON;
}


- (NSArray *) iniciaLetras{
    NSArray *letras = [@"A B C D E F G H I J K L M N O P Q R S T U V W X Y Z" componentsSeparatedByString:@" "];
    
    return letras;
}

- (NSMutableArray *) iniciaImagens{
    NSMutableArray *imagens = [[NSMutableArray alloc]init];
    
    for (char i ='a'; i<='z'; i++){
//        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"img%c.jpg", i]];
//        [imagens addObject:img];
        
        NSString *img = [NSString stringWithFormat:@"img%c.jpg", i];
        [imagens addObject:img];
    }
    
    return imagens;
}

- (NSArray *) iniciaPalavras{
    NSArray *palavras;
    palavras = @[@"Ahri", @"Bardo", @"Corki", @"Darius", @"Ezreal", @"Fizz", @"Gnar", @"Hecarim", @"Irelia", @"Jarvan IV", @"Kalista", @"LeBlanc", @"Morgana", @"Nunu", @"Orianna", @"Pantheon", @"Quinn", @"Rengar", @"Syndra", @"Twisted Fate", @"Udyr", @"Vel`Koz", @"Wukong", @"Xerath", @"Yasuo", @"Zilean"];
    return palavras;
}

- (int)getCont{
    return cont;
}

- (void)setCont: (int)novo{
    cont = novo;
}

- (void) incrementa{
    cont = cont+1;
}

- (void) decrementa{
    cont = cont-1;
}

@end


