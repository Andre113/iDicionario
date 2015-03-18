//
//  InicioViewController.m
//  Navigation
//
//  Created by Andre Lucas Ota on 17/03/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "InicioViewController.h"
#import "DictionaryManager.h"

@interface InicioViewController (){
 
    UITextField *textoBusca;
    UIButton *botao;
}
@end

@implementation InicioViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    TextField e opções
    textoBusca = [[UITextField alloc]init];
    
//    Botão e opções
    botao = [UIButton buttonWithType:UIButtonTypeSystem];
    [botao addTarget:self action:@selector(busca:)forControlEvents: UIControlEventTouchUpInside];
    [botao setTitle:@"Busca" forState: UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)busca: (id)sender{
    NSString *texto = textoBusca.text;
    
    if(texto != nil){
        DictionaryManager *dictionary = [DictionaryManager sharedInstance];
        NSString *p;
        Boolean find = false;
        NSArray *palavras = [dictionary iniciaPalavras];
    
        for (int i=0; i<25 && find==false; i++){
            p=[palavras objectAtIndex:i];
            if ([p isEqualToString:texto]){
                find = true;
            }
        }
        
        if (find == false){
            
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
