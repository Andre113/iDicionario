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
    NSMutableArray *views;
    
    UILabel *palavra;
    UIImageView *imagem;
    UIButton *botao;
}

@end

@implementation LetrasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Inicia o dictionaryManager
    DictionaryManager *dictionary = [DictionaryManager sharedInstance];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.960 green:0.960 blue:0.862 alpha:0.5];
    
    //Inicia os arrays e pega o valor do contador
    letras = [dictionary iniciaLetras];
    int cont = [dictionary getCont];
    
    //Inicia as labels e botões
    palavra = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, super.view.bounds.size.width, 80)];
    palavra.textAlignment = NSTextAlignmentCenter;
    palavra.center = self.view.center;
    [palavra setTextColor: [UIColor blackColor]];
    [palavra setHidden:YES];
    
    imagem = [[UIImageView alloc] initWithFrame:CGRectMake(30, 400, 260, 180)];
    [imagem.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [imagem.layer setBorderWidth: 4.0];
    [imagem setHidden:YES];
    
    botao = [UIButton
                       buttonWithType:UIButtonTypeSystem];
    [botao addTarget:self action:@selector(mostrar:) forControlEvents:UIControlEventTouchUpInside];
    [botao
     setTitle:@"Mostre"
     forState:UIControlStateNormal];
    [botao sizeToFit];
    botao.center = self.view.center;
    
//    if(cont > 0){
        UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target: self action:@selector(back:)];
        self.navigationItem.leftBarButtonItem=back;
//    }
    
//    if(cont <25){
        UIBarButtonItem *next = [[UIBarButtonItem alloc]
                                 initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(next:)];
        self.navigationItem.rightBarButtonItem=next;
        

//    }
    
    //        [UIView animateWithDuration: 3 delay: 0 options:UIViewAnimationCurveEaseIn animations:^{
    //            self.view.backgroundColor = [self getRandomColor];
    //        }
    //                         completion:^(BOOL finished) {
    //                         }
    //         ];
    
    
    [self.view addSubview:botao];
    [self.view addSubview:palavra];
    [self.view addSubview:imagem];
    NSLog (@"%d", cont);
    NSLog (@"%d", views.count);
    
    //Atribui o valor das labels e título
    self.title = [letras objectAtIndex:cont];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Método chamado ao apertar o botão de passar a view
-(void)next:(id)sender {
    //Inicia o dictionaryManager
    DictionaryManager *dictionary = [DictionaryManager sharedInstance];
    
    [dictionary incrementa];
    
    if([dictionary getCont] > 25){
        [dictionary setCont:0];
    }
    
    LetrasViewController *proximo = [[LetrasViewController alloc] initWithNibName:nil bundle:NULL];
    [self.navigationController setViewControllers:[NSArray arrayWithObjects: self, nil]];
    [self.navigationController pushViewController:proximo animated:NO];
}

//Método chamado ao apertar o botão de voltar
-(void)back:(id)sender {
    //Inicia o dictionaryManager
    DictionaryManager *dictionary = [DictionaryManager sharedInstance];
    
    //Decrementa o contador
    [dictionary decrementa];
    
    if([dictionary getCont] < 0){
        [dictionary setCont: 25];
    }
    
    LetrasViewController *last = [[LetrasViewController alloc] initWithNibName:nil bundle:NULL];

    [self.navigationController setViewControllers:[NSArray arrayWithObjects: last, self, nil]];
    [self.navigationController popViewControllerAnimated:NO];
}

//Método chamado ao apertar o botão de mostrar
-(void)mostrar:(id)sender{
    [botao setHidden:YES];
    DictionaryManager *dictionary = [DictionaryManager sharedInstance];
    
//    UILabel *palavra = [[UILabel alloc]initWithFrame:CGRectMake(200, 200, 200, 200)];
//    UIImageView *imagem = [[UIImageView alloc]init];
//    
    imagens = [dictionary iniciaImagens];
    palavras = [dictionary iniciaPalavras];
    int cont = [dictionary getCont];
    
    [palavra setText:[palavras objectAtIndex:cont]];
    [palavra setHidden:NO];
    
    NSString *img = [imagens objectAtIndex:cont];
    [imagem setImage: [UIImage imageNamed:img]];
    [imagem setHidden:NO];
    
    [self animacao];
}


//Método de animação
-(void) animacao{
    [UIView animateWithDuration: 1 delay: 0 options:UIViewAnimationCurveEaseIn animations:^{
        palavra.transform= CGAffineTransformMakeTranslation(0, -180);
        imagem.transform= CGAffineTransformMakeTranslation(0, -180);
    }
                     completion:^(BOOL finished) {
                     }
     ];
}

//Método para pegar uma cor aleatória
//-(UIColor *)getRandomColor{
//    CGFloat rand = ( arc4random() % 256 / 256.0 ); // 0.0 to 1.0
//    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0, away from white
//    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0, away from black
//    UIColor *cor = [UIColor colorWithHue:rand saturation:saturation brightness:brightness alpha:1];
//    
//    return cor;
//}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

