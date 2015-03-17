//
//  LetrasViewController.m
//  Navigation
//
//  Created by Vinicius Miana on 2/23/14.
//  Copyright (c) 2014 Vinicius Miana. All rights reserved.
//

#import "LetrasViewController.h"
#import "DictionaryManager.h"

@interface LetrasViewController (){
    NSArray *letras;
    NSArray *imagens;
    NSArray *palavras;
    
    UILabel *palavra;
    UIImageView *imagem;
}

@end

@implementation LetrasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Inicia o dictionaryManager
    DictionaryManager *dictionary = [DictionaryManager sharedInstance];
    
    //Inicia os arrays e pega o valor do contador
    letras = [dictionary iniciaLetras];
    int cont = [dictionary getCont];
    
    //Inicia as labels e botões
    palavra = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, 300, 50)];
    [palavra setTextColor: [UIColor blackColor]];
    [palavra setHidden:YES];
    
    imagem = [[UIImageView alloc] initWithFrame:CGRectMake(300, 300, 100, 100)];
    [imagem setHidden:YES];
    
    UIButton *botao = [UIButton
                       buttonWithType:UIButtonTypeSystem];
    [botao addTarget:self action:@selector(mostrar:) forControlEvents:UIControlEventTouchUpInside];
    [botao
     setTitle:@"Mostre"
     forState:UIControlStateNormal];
    [botao sizeToFit];
    botao.center = self.view.center;
    
    if(cont > 0){
        UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target: self action:@selector(back:)];
        self.navigationItem.leftBarButtonItem=back;
    }
    
    if(cont <25){
        UIBarButtonItem *next = [[UIBarButtonItem alloc]
                                 initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(next:)];
        self.navigationItem.rightBarButtonItem=next;
    }
                             
    
    [self.view addSubview:botao];
    [self.view addSubview:palavra];
    NSLog (@"%d", cont);
    
    //Atribui o valor das labels e título
    self.title = [letras objectAtIndex:cont];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)next:(id)sender {
    //Inicia o dictionaryManager
    DictionaryManager *dictionary = [DictionaryManager sharedInstance];
    
    [dictionary incrementa];
    LetrasViewController *proximo = [[LetrasViewController alloc]
                                    initWithNibName:nil
                                    bundle:NULL];
    [self.navigationController pushViewController:proximo
                                         animated:YES];
}

-(void)back:(id)sender {
    //Inicia o dictionaryManager
    DictionaryManager *dictionary = [DictionaryManager sharedInstance];
    
    //Decrementa o contador
    [dictionary decrementa];
    
    //Volta para view anterior
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)mostrar:(id)sender{
    DictionaryManager *dictionary = [DictionaryManager sharedInstance];
    
//    UILabel *palavra = [[UILabel alloc]initWithFrame:CGRectMake(200, 200, 200, 200)];
//    UIImageView *imagem = [[UIImageView alloc]init];
//    
    imagens = [dictionary iniciaImagens];
    palavras = [dictionary iniciaPalavras];
    int cont = [dictionary getCont];
    
    [palavra setText:[palavras objectAtIndex:cont]];
    [palavra setHidden:NO];
//    UIImage *img = [imagens objectAtIndex:cont];
//    [imagem setImage:img];
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

