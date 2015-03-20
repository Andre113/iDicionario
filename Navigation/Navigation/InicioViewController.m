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
}
@end

@implementation InicioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.960 green:0.960 blue:0.862 alpha:0.5];

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
    
//    Botão e opções
    botao = [UIButton buttonWithType:UIButtonTypeSystem];
    [botao addTarget:self action:@selector(busca:)forControlEvents: UIControlEventTouchUpInside];
    [botao setTitle:@"Go For It!" forState: UIControlStateNormal];
    botao.frame = CGRectMake(63, 100, 200, 40);
    
//    TableView e opções
    table = [[UITableView alloc]initWithFrame:CGRectMake(25, 150, 270, 350)];
    table.backgroundColor = [UIColor colorWithRed:0.960 green:0.960 blue:0.862 alpha:0.5];
    CALayer *lay = table.layer;
    [lay setMasksToBounds:YES];
    [lay setCornerRadius: 4.0];
    [lay setBorderWidth:1.0];
    [lay setBorderColor:[[UIColor colorWithWhite: 0.8 alpha: 1.0] CGColor]];
    [table setDelegate:self];
    [table setDataSource:self];
    
    [self.view addSubview:textoBusca];
    [self.view addSubview:botao];
    [self.view addSubview:table];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 26;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DictionaryManager *dictionary = [DictionaryManager sharedInstance];
    UITableViewCell *celula = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    NSArray *array = [dictionary iniciaPalavras];
    NSLog(@"%lu", array.count);
    
    celula.textLabel.text = [array objectAtIndex: indexPath.row];
    
    return celula;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DictionaryManager *dictionary = [DictionaryManager sharedInstance];
    int i = (int)indexPath.row;
    [dictionary setCont: i];
    
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

- (NSString *) formatar: (NSString *)entrada{
    NSString *saida = entrada;
    saida = [saida stringByReplacingOccurrencesOfString:@" " withString:@""];
    saida = [saida lowercaseString];
    return saida;
}

- (void)busca: (id)sender{
    NSString *texto = [self formatar: textoBusca.text];
    
    if(texto != nil){
        DictionaryManager *dictionary = [DictionaryManager sharedInstance];
        NSString *p;
        Boolean find = false;
        NSArray *palavras = [dictionary iniciaPalavras];
    
        for (int i=0; i<25 && find==false; i++){
            p=[palavras objectAtIndex:i];
            if ([texto isEqualToString:[self formatar:p]]){
                NSLog(@"GO");
                find = true;
                [dictionary setCont:i];
                
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
        }
        
        if (find == false){
            NSLog (@"KK");
            [UIView animateWithDuration: 0.07 delay: 0 options:
             UIViewAnimationCurveLinear animations:^{
                 [UIView setAnimationRepeatCount:5.0];
                 botao.transform= CGAffineTransformMakeTranslation(0, 4);
             }
                             completion:^(BOOL finished) {
                                 botao.transform= CGAffineTransformMakeTranslation(0, 0);
                             }];
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
