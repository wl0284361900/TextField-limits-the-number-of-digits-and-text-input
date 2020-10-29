//
//  ViewController.m
//  TextField
//
//  Created by winproluhao on 2020/10/29.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textField1.delegate = self;
    self.textField2.delegate = self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    BOOL res = YES;
    

    if(textField == self.textField1){
        //限制輸入碼只有6位
        if(textField.text.length >= 6 && range.length == 0) return NO;
    }else if(textField == self.textField2){
        //限制輸入只能是數字
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        if(string.length == 1){
            NSRange ran = [string rangeOfCharacterFromSet:set];
            if(ran.length == 0){
                //表示找不到
                return NO;
            }
        }else{
            //如果是複製貼上會跑這裡，因為string.length>1
            NSString *newStr = [[NSString alloc]init];
            for(int i = 0; i < string.length; i++){
                //一次抓一個字
                NSString *c = [string substringWithRange:NSMakeRange(i, 1)];
                NSRange ran = [c rangeOfCharacterFromSet:set];
                if(ran.length != 0){
                    newStr = [newStr stringByAppendingFormat:@"%@", c];
                }else{
                    res = NO;
                }
            }
            [textField setText:newStr];
        }
    }
    return res;
}

// 限制輸入數量
// 限制輸入數字


@end
