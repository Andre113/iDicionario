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
    UIToolbar *tool;
    UITextField *texto;

    DictionaryManager *dictionary;
    int cont;
}

@end

@implementation LetrasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dictionary = [[DictionaryManager alloc]init];
    
    //Inicia os arrays e pega o valor do contador
    letras = [dictionary iniciaLetras];
    imagens = [dictionary iniciaImagens];
    palavras = [dictionary iniciaPalavras];
    cont = [dictionary getCont];
    
    //Palavra
    palavra = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, super.view.bounds.size.width, 80)];
    palavra.textAlignment = NSTextAlignmentCenter;
    palavra.center = self.view.center;
    [palavra setTextColor: [UIColor blackColor]];
    [palavra setHidden:YES];
    
    //Imagem
    imagem = [[UIImageView alloc] initWithFrame:CGRectMake(30, 380, 260, 180)];
    [imagem.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [imagem.layer setBorderWidth: 4.0];
    [imagem setHidden:YES];
    
    //Botão
    botao = [UIButton buttonWithType:UIButtonTypeSystem];
    [botao addTarget:self action:@selector(mostrar:) forControlEvents:UIControlEventTouchUpInside];
    [botao setTitle:@"Mostre" forState:UIControlStateNormal];
    [botao sizeToFit];
    botao.center = self.view.center;
    
    //Toolbar
    tool = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, 45)];
    [tool setBackgroundColor: [UIColor blueColor]];
    UIBarButtonItem *editar = self.editButtonItem;
    tool.items = @[editar];
    
    //TextField
    texto = [[UITextField alloc]initWithFrame:CGRectMake(65, 450, 200, 30)];
    texto.textAlignment = NSTextAlignmentLeft;
    texto.borderStyle = UITextBorderStyleRoundedRect;
    texto.font = [UIFont systemFontOfSize:12];
    texto.keyboardType = UIKeyboardTypeDefault;
    texto.returnKeyType = UIReturnKeyDone;
    texto.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    texto.delegate = self;
    [texto setHidden:YES];
    
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target: self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem=back;
    
    UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(next:)];
    self.navigationItem.rightBarButtonItem=next;
    
    //Adicionar subviews
    [self.view addSubview:botao];
    [self.view addSubview:palavra];
    [self.view addSubview:imagem];
    [self.view addSubview:tool];
    [self.view addSubview:texto];
    
    //Opcões da view
    self.view.backgroundColor = [UIColor colorWithRed:0.960 green:0.960 blue:0.862 alpha:0.5];
    self.title = nil;
    self.navigationItem.title = [letras objectAtIndex:cont];
}

#pragma mark - Métodos dos botões de navegação
//Método chamado ao apertar o botão de passar a view
-(void)next:(id)sender {
    [dictionary incrementa];
    
    if([dictionary getCont] > 25){
        [dictionary setCont:0];
    }
    
    [self vaiParaView:NO];
}

//Método chamado ao apertar o botão de voltar
-(void)back:(id)sender {
    //Decrementa o contador
    [dictionary decrementa];
    
    if([dictionary getCont] < 0){
        [dictionary setCont: 25];
    }
    
    [self vaiParaView:YES];
}

#pragma mark - Navegação
// Vai para a próxima view e mexe na animação a ser feita
- (void)vaiParaView: (BOOL)volta{
    [self animaTransicao:volta];
    LetrasViewController *goTo = [[LetrasViewController alloc] initWithNibName:nil bundle:NULL];
    [self.navigationController setViewControllers:[NSArray arrayWithObjects: goTo, self, nil]];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Outros botões
// Permitir edição
- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing: editing animated:YES];
    if(editing){
        [texto setHidden:NO];
    }
    
    else{
        if([texto.text isEqualToString: @""]){
            
        }
        else{
            [palavra setText:texto.text];
        }
        [texto setHidden:YES];
    }
}

//Método chamado ao apertar o botão de mostrar
-(void)mostrar:(id)sender{
    [botao setHidden:YES];
    
    [palavra setText:[palavras objectAtIndex:cont]];
    [palavra setHidden:NO];
    
    NSString *img = [imagens objectAtIndex:cont];
    [imagem setImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource: img ofType:nil]]];
    [imagem setHidden:NO];
    
    [self animacaoAparecer];
}

#pragma mark - Animação
-(void) animacaoAparecer{
    [UIView animateWithDuration: 1 delay: 0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        palavra.transform= CGAffineTransformMakeTranslation(0, -140);
        imagem.transform= CGAffineTransformMakeTranslation(0, -140);
    }
                     completion:^(BOOL finished) {
                     }
     ];
}

//Animação de transição
-(void)animaTransicao: (BOOL)volta{
    [UIView animateWithDuration:0.75 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        if(volta){
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
        }else{
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView: self.navigationController.view cache:NO];
        }
    }];
}

#pragma mark - Touch
-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    [UIView beginAnimations:@"Mover imagem" context:nil];
    CGPoint pos = [touch locationInView:self.view];

    [UIView animateWithDuration:0 animations:^{
        imagem.transform = CGAffineTransformMakeTranslation(pos.x-imagem.center.x, pos.y-imagem.center.y);
    }];
}

@end

