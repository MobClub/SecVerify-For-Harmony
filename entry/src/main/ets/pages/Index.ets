import { OperationCallback, SecPure, VerifyResult , VerifyException} from '@mobsdk/secverify';
import { http } from '@kit.NetworkKit';
import { bundleManager, common } from '@kit.AbilityKit';
import { MobSDK } from '@mobsdk/mobcore';
import { QueryPhoneBody } from './QueryPhoneBody';
import { ThemeChooser } from './ThemeChooser';

let context = getContext(this)
@Entry
@Component
struct Index {
  @State content: string = "结果:"
  result: VerifyResult | null = null;
  appkey = "您的appkey";
  secret = "您的appsecret";
  isInited = false;
  scroller: Scroller = new Scroller()
  chooserController?: CustomDialogController
  async aboutToAppear() {
  }

  build() {
    Scroll(this.scroller) {
      Column() {
        Text("SecVerify DEMO")
          .width('100%')
          .margin(10)
          .align(Alignment.Center)
          .textAlign(TextAlign.Center)
        Button("初始化公共库（每次启动必须调用）")
          .width('90%')
          .margin(10)
          .padding(15)
          .onClick(() => {
            MobSDK.init(context, this.appkey, this.secret);
            this.content = "调用MobSDK.init()"
            this.isInited = true;
          })
        Row(){
          Button("同意隐私")
            .width('45%')
            .margin(5)
            .padding(15)
            .onClick(() => {
              MobSDK.submitPolicyGrantResult(true);
              this.content = "隐私状态isForb: " +MobSDK.isForb()
            })
          Button("不同意隐私")
            .width('45%')
            .margin(5)
            .padding(15)
            .onClick(() => {
              MobSDK.submitPolicyGrantResult(false);
              this.content = "隐私状态isForb: " +MobSDK.isForb()
            })
        }

        Row(){
          Button("预取号")
            .width('45%')
            .margin(5)
            .padding(15)
            .onClick(() => {
              if(!this.isInited){
                this.content = "请先初始化公共库！"
                return;
              }
              let callback: OperationCallback<void> = {
                onSuccess: (data) => {
                  this.content = new Date() + " onSuccess"
                },
                onFailure: (e) => {
                  this.content = new Date() + " onFailure:" + JSON.stringify(e)
                }
              };
              SecPure.preVerify(callback);
              console.log("SecPure", "preVerify invoked")
            })
          Button("预取号promise")
            .width('45%')
            .margin(5)
            .padding(15)
            .onClick(() => {
              if(!this.isInited){
                this.content = "请先初始化公共库！"
                return;
              }
              SecPure.preVerifySync().then((data)=>{
                this.content = new Date() + " onSuccess"
              }).catch((e:VerifyException)=>{
                this.content = new Date() + " onFailure:" + JSON.stringify(e)
              })
              console.log("SecPure", "preVerify invoked")
            })
        }
        Row(){
          Button("取号")
            .width('30%')
            .margin(5)
            .padding(15)
            .onClick(() => {
              if(!this.isInited){
                this.content = "请先初始化公共库！"
                return;
              }
              let callback: OperationCallback<VerifyResult> = {
                onSuccess: (data) => {
                  this.content = new Date() + " onSuccess:" + JSON.stringify(data)
                  this.result = data;
                },
                onFailure: (error) => {
                  this.content = new Date() + " onFailure:" + JSON.stringify(error)
                }
              };
              let theme = ThemeChooser.theme
              SecPure.setSecTheme(theme)
              SecPure.verify(callback);
              console.log("SecPure", "verify invoked")
            })
          Button("取号promise")
            .width('30%')
            .margin(5)
            .padding(15)
            .onClick(() => {
              if(!this.isInited){
                this.content = "请先初始化公共库！"
                return;
              }
              let theme = ThemeChooser.theme
              SecPure.setSecTheme(theme)
              SecPure.verifySync().then((data)=>{
                this.content = new Date() + " onSuccess:" + JSON.stringify(data)
                this.result = data;
              }).catch((e:VerifyResult)=>{
                this.content = new Date() + " onFailure:" + JSON.stringify(e)
              });
              console.log("SecPure", "verify invoked")
            })
          Button("设置主题")
              .width('30%')
              .margin(5)
              .padding(15)
              .onClick(() => {
                this.chooserController = new CustomDialogController({
                  builder: ThemeChooser({
                    controller: this.chooserController
                  }),
                  cornerRadius: 0,
                  alignment: DialogAlignment.Center,
                })
                this.chooserController.open()
              })

          }

        TextInput({placeholder:'请输入预取号超时时间ms'})
          .width('90%')
          .margin(10)
          .padding(15)
          .type(InputType.Number)
          .onChange(value=>{
            if(!this.isInited){
              this.content = "请先初始化公共库！"
              return;
            }
            let timeout = Number.parseInt(value);
            console.log("SecPure", "timeout = " +timeout);
            SecPure.setPreVerifyTimeout(timeout);

          })
        Button("登录")
          .width('90%')
          .margin(10)
          .padding(15)
          .onClick(async () => {
            if(!this.isInited){
              this.content = "请先初始化公共库！"
              return;
            }
            if (this.result === null) {
              this.content = "请先取号！";
              return;
            }
            let URL_LOGIN = "http://demo.accuratead.cn/demo/sdkLogin";
            let bundleInfo: bundleManager.BundleInfo = bundleManager.getBundleInfoForSelfSync(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_SIGNATURE_INFO);
            let sign:string = bundleInfo.signatureInfo.fingerprint;
            sign = sign.toLowerCase()
            let body = new QueryPhoneBody()
            body.opToken = this.result.opToken
            body.operator = this.result.operator
            body.phoneOperator = this.result.operator
            body.token = this.result.token
            body.md5 = sign
            body.appkey = this.appkey
            let json = JSON.stringify(body)
            console.log("SecPure", "request:"+json)
            try {
              let data = await http.createHttp().request(URL_LOGIN, {
                method: http.RequestMethod.POST,
                extraData: json,
                header: {
                  "Content-Type": "application/json"
                }
              });
              this.content = new Date() + JSON.stringify(data.result);
              console.log('SecPure', this.content)
            } catch (e) {
              this.content = new Date() + JSON.stringify(e);
              console.log('SecPure', this.content)
            }
          })

        Button("测试")
          .width('90%')
          .margin(10)
          .padding(15)
          .visibility(Visibility.Visible)
          .onClick(async () => {

          })


        Text(this.content)
          .fontSize(20)
          .textAlign(TextAlign.Start)
          .fontWeight(FontWeight.Bold)
          .margin(10)
          .width('90%')
      }
    }
    .width('100%')
  }
}

