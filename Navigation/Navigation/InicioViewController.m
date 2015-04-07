//
//  InicioViewController.m
//  Navigation
//
//  Created by Andre Lucas Ota on 17/03/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "InicioViewController.h"
#import "DictionaryManager.h"
#import "LetrasViewController.h"

@interface InicioViewController (){
    UITextField *textoBusca;
    UIButton *botao;
    UITableView *table;
    DictionaryManager *dictionary;
}
@end

@implementation InicioViewController

#pragma mark - View
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.960 green:0.960 blue:0.862 alpha:0.5];
    dictionary = [DictionaryManager sharedInstance];
    
    [self loadBusca];
    [self loadTableView];
}

- (void)vaiParaView{
    //                Gambiarra
    UINavigationController *navigation = [[UINavigationController alloc]init];
    LetrasViewController *letra = [[LetrasViewController alloc]initWithNibName:nil bundle:NULL];
    [navigation setViewControllers:[NSArray arrayWithObjects:letra, nil]];
    
    UIImage *imagem1 = [[UIImage alloc]init];
    imagem1 = [UIImage imageNamed:@"TabView.png"];
    
    navigation.tabBarItem = [[UITabBarItem alloc]initWithTitle:nil image:imagem1 tag: 1];
    
    [self.tabBarController setViewControllers: [NSArray arrayWithObjects:self, navigation, nil]];
    [self.tabBarController setSelectedIndex:1];
}

#pragma mark - TableView
- (void)loadTableView{
    //  TableView e opções
    table = [[UITableView alloc]initWithFrame:CGRectMake(25, 150, 270, 350)];
    table.backgroundColor = [UIColor colorWithRed:0.960 green:0.960 blue:0.862 alpha:0.5];
    
    // Bordas da tabela
    CALayer *lay = table.layer;
    [lay setMasksToBounds:YES];
    [lay setCornerRadius: 4.0];
    [lay setBorderWidth:1.0];
    [lay setBorderColor:[[UIColor colorWithWhite: 0.8 alpha: 1.0] CGColor]];
    
    // Delegate da table
    [table setDelegate:self];
    [table setDataSource:self];
    
    // Add Subview
    [self.view addSubview:textoBusca];
    [self.view addSubview:botao];
    [self.view addSubview:table];
}

// Número de seções
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

// Número de linhas na seção
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 26;
}

// Cria células
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *celula = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    NSArray *array = [dictionary iniciaPalavras];
    
    celula.textLabel.text = [array objectAtIndex: indexPath.row];
    
    return celula;
}

// Seleciona célula
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int i = (int)indexPath.row;
    [dictionary setCont: i];
    
    [self vaiParaView];
}

#pragma mark - Busca
// Carrega elementos utilizados na função de busca
-(void)loadBusca{
    //    Botão e opções
    botao = [UIButton buttonWithType:UIButtonTypeSystem];
    [botao addTarget:self action:@selector(busca:)forControlEvents: UIControlEventTouchUpInside];
    [botao setTitle:@"Go For It!" forState: UIControlStateNormal];
    botao.frame = CGRectMake(63, 100, 200, 40);
    
    //    TextField e opções
    textoBusca = [[UITextField alloc]initWithFrame:CGRectMake(10, 65, 300, 30)];
    textoBusca.textAlignment = NSTextAlignmentLeft;
    textoBusca.borderStyle = UITextBorderStyleRoundedRect;
    textoBusca.font = [UIFont systemFontOfSize:12];
    textoBusca.placeholder = @"Pesquisa";
    textoBusca.keyboardType = UIKeyboardTypeDefault;
    textoBusca.returnKeyType = UIReturnKeyDone;
    textoBusca.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textoBusca.delegate = self;
}

// Ao clicar no botão de busca
- (void)busca: (id)sender{
    NSString *texto = [self formatar: textoBusca.text];
    
    if(texto != nil){
        NSString *p;
        Boolean find = false;
        NSArray *palavras = [dictionary iniciaPalavras];
        
        for (int i=0; i<25 && find==false; i++){
            p=[palavras objectAtIndex:i];
            if ([texto isEqualToString:[self formatar:p]]){
                find = true;
                [dictionary setCont:i];
                [self vaiParaView];
            }
        }
        
        if (find == false){
            [self animacaoBotao];
        }
    }
}

// Formata a String para busca
- (NSString *) formatar: (NSString *)entrada{
    NSString *saida = entrada;
    saida = [saida stringByReplacingOccurrencesOfString:@" " withString:@""];
    saida = [saida lowercaseString];
    return saida;
}

#pragma mark - Animação
// Animação quando a palavra buscada não existe
- (void)animacaoBotao{
    [UIView animateWithDuration: 0.07 delay: 0 options:
     UIViewAnimationOptionCurveLinear animations:^{
         [UIView setAnimationRepeatCount:5.0];
         botao.transform= CGAffineTransformMakeTranslation(0, 4);
     }
                     completion:^(BOOL finished) {
                         botao.transform= CGAffineTransformMakeTranslation(0, 0);
                     }];
}

@end
