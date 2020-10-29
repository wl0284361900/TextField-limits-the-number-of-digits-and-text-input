# TextField 限制輸入位數、輸入文字 全攻略

### 限制輸入位數
> ***目標： 如果限制TextField只能輸入六位數***

![](https://i.imgur.com/cLoS2lO.png)

這樣的邏輯只對一半
你會發現要刪除輸入過的內容將無法刪除。
我們去思考跟range是否有相關
把range印出來後：

![](https://i.imgur.com/vw6VRkM.png)

當一直在新增文字進textField時，他會改變location的位置

![](https://i.imgur.com/Wokmf6f.png)

刪減文字時，可以看到range的length會一直是1

> Q:為什麼這邊新增時，length不會增加
原因是他新增進來的時候，還沒有放到textField而是當BOOL返回為YES時，
它才會新增上去，他才有實體的位子和長度

> - 補充NSRange
> - {location, length}
> - location是一個以0為開始的index，length是表示對象的長度

於是我在修正一下程式碼

![](https://i.imgur.com/I6001X8.png)

可以看到如此就可以正常刪減了

![](https://i.imgur.com/y2XAfh8.gif)



---
###  限制輸入文字
> ***目標：輸入的內容有英文和數字，只讓數字顯示出來，英文過濾掉***

**撰寫邏輯：**
創建一個Set，把我要顯示出來的值（這裡是放0-9），放入這個Set。
```
NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
```
然後進來的值(string)就去比對，是否包含在Set裡面，不是就返回return
```
if(string.length == 1){
    NSRange ran = [string rangeOfCharacterFromSet:set];
    if(ran.length == 0){
        //表示找不到
        return NO;
    }
}
```
如果比對後有該值的話，length會是1。
> 不過這裡要注意，如果是複製貼上的話就會無法過濾，原因是string.length==1這裏。
> 通常一個字一個字輸入，string.length會是1，不過複製貼上是一整串。
> 所以代碼要改成如下

![](https://i.imgur.com/4SyKn0k.png)

成果：

![](https://i.imgur.com/P8tiX0W.gif)

> 小嘮叨：
> 這邊另外存一個BOOL，是當他返回NO時，他不會讓TextField接收到的string改變TextField的值。所以在60行的地方改變它新的字串（newString），我們自己組的字串


-  網址：https://developer.apple.com/documentation/uikit/uitextfielddelegate/1619599-textfield?language=objc








###### tags: `Objective-C`
