## 0. Githud链接

    -    https://github.com/Shannoon/XLPasswordView



# 1. XLPasswordView描述

一个简单的密码输入组件,自己写的随机数字键盘,UI类似支付宝支付密码界面,使用简单,只需要三行代码就可以 , 代理方法也很简单明了


![Paste_Image.png](http://upload-images.jianshu.io/upload_images/1455933-e3f013f10aa2a647.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



# 2. 安装方法

下载示例demo,把XLPasswordView文件夹拖入项目即可



# 3. 使用方法

-    创建



```


    XLPasswordView *passwordView = [XLPasswordView passwordView];
    passwordView.delegate = self;
    [passwordView showPasswordInView:self.view];


```



-    代理方法 , 做一些自定义的事件



```


#pragma mark    -   XLPasswordViewDelegate

/**
 *  输入密码位数已满时调用
 */
- (void)passwordView:(XLPasswordView *)passwordView didFinishInput:(NSString *)password
{
    NSLog(@"输入密码位数已满,在这里做一些事情,例如自动校验密码");
}

/**
 *  用户输入密码时调用
 *
 *  @param passwordView 视图
 *  @param password     输入的密码文本
 */
- (void)passwordView:(XLPasswordView *)passwordView passwordTextDidChange:(NSString *)password
{
    NSLog(@"%@",password);
}

/**
 *  点击了忘记密码时调用
 */
- (void)passwordViewClickForgetPassword:(XLPasswordView *)passwordView
{
    NSLog(@"点击了忘记密码,在这里做一些事情");
}



```
