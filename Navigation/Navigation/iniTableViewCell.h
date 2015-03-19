//
//  iniTableViewCell.h
//  Navigation
//
//  Created by Andre Lucas Ota on 19/03/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iniTableViewCell : UITableViewCell{
    UIImageView *imagem;
    UILabel *nome;
}

@property (nonatomic, retain) UIImageView *imagem;
@property (nonatomic, retain) UILabel *nome;

@end
