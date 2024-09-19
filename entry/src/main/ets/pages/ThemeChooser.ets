import { ClauseSpan, SetCheckCallback, ThemeConfig} from '@mobsdk/secverify'
import { Prompt, promptAction } from '@kit.ArkUI'
import { GenAuthLoginDialog } from 'cmccssosdk'

@CustomDialog
@Component
export struct ThemeChooser {
  static theme: ThemeConfig = new ThemeConfig()

  controller?: CustomDialogController
  cuctController: CustomDialogController
  cmController:CustomDialogController
  scroller: Scroller = new Scroller()
  static enableWindowMode = false
  @State enableWindowMode:boolean = ThemeChooser.enableWindowMode
  @State statusBarColor?: string = ThemeChooser.theme.getSystemBarProperties().statusBarColor
  @State statusBarContentColor?: string = ThemeChooser.theme.getSystemBarProperties().statusBarContentColor
  @State numberSize: number = ThemeChooser.theme.getNumberSize()
  @State numberColor: string = ThemeChooser.theme.getNumberColor() as string
  @State numberMarginLeft?:Length = ThemeChooser.theme.getNumberMargin().left
  @State numberMarginTop?:Length = ThemeChooser.theme.getNumberMargin().top
  @State numberMarginBottom?:Length = ThemeChooser.theme.getNumberMargin().bottom
  @State numberMarginRight?:Length = ThemeChooser.theme.getNumberMargin().right
  @State numberAlignRuleOption:AlignRuleOption = ThemeChooser.theme.getNumberAlignRuleOption()
  @State loginBtnText:string = ThemeChooser.theme.getLogBtnText()
  @State loginBtnTextSize:number = ThemeChooser.theme.getLoginBtnTextSize()
  @State loginBtnTextColor: string = ThemeChooser.theme.getLoginBtnTextColor() as string
  @State loginBtnColor: string = ThemeChooser.theme.getLoginBtnColor() as string
  @State loginBtnWidth: Length = ThemeChooser.theme.getLoginBtnWidth()
  @State loginBtnHeight: Length = ThemeChooser.theme.getLoginBtnHeight()
  @State loginBtnMarginLeft?:Length = ThemeChooser.theme.getLoginBtnMargin().left
  @State loginBtnMarginTop?:Length = ThemeChooser.theme.getLoginBtnMargin().top
  @State loginBtnMarginBottom?:Length = ThemeChooser.theme.getLoginBtnMargin().bottom
  @State loginBtnMarginRight?:Length = ThemeChooser.theme.getLoginBtnMargin().right
  @State loginBtnAlignRuleOption: AlignRuleOption = ThemeChooser.theme.getLoginBtnAlignRuleOption()
  static enableUncheckedLoginListener = false
  @State setUncheckedLoginListener:boolean = ThemeChooser.enableUncheckedLoginListener
  static enableCheckedLoginListener = false
  @State setCheckedLoginListener:boolean = ThemeChooser.enableCheckedLoginListener
  static enableLoginPageComponent = false
  @State setLoginPageComponent:boolean = ThemeChooser.enableLoginPageComponent
  @State checkedWidth:Length = ThemeChooser.theme.getCheckedWidth()
  @State checkedHeight:Length = ThemeChooser.theme.getCheckedHeight()
  @State checkBoxMarginLeft?:Length = ThemeChooser.theme.getCheckBoxMargin().left
  @State checkBoxMarginTop?:Length = ThemeChooser.theme.getCheckBoxMargin().top
  @State checkBoxMarginRight?:Length = ThemeChooser.theme.getCheckBoxMargin().right
  @State checkBoxMarginBottom?:Length = ThemeChooser.theme.getCheckBoxMargin().bottom
  @State checkBoxAlignRuleOption: AlignRuleOption = ThemeChooser.theme.getCheckBoxAlignRuleOption()
  @State checkBoxShape:CheckBoxShape = ThemeChooser.theme.getCheckBoxShape()
  static enableCheckBoxChangeListener = false
  @State setCheckBoxChangeListener:boolean = ThemeChooser.enableCheckBoxChangeListener
  @State clauseState: boolean = false
  static clauseStyle = 1
  @State clauseMarginLeft?:Length = ThemeChooser.theme.getClauseMargin().left
  @State clauseMarginTop?:Length = ThemeChooser.theme.getClauseMargin().top
  @State clauseMarginRight?:Length = ThemeChooser.theme.getClauseMargin().right
  @State clauseMarginBottom?:Length = ThemeChooser.theme.getClauseMargin().bottom
  @State clauseAlignRuleOption: AlignRuleOption = ThemeChooser.theme.getClauseAlignRuleOption()
  @State navTextSize:number = ThemeChooser.theme.getNavTextSize()
  @State navTextColor: string = ThemeChooser.theme.getNavTextColor() as string
  @State navColor:string = ThemeChooser.theme.getNavColor() as string
  static enableClauseComponent = false
  @State enableClauseComponent:boolean = ThemeChooser.enableClauseComponent
  static enableBackPressedListener = false
  @State setBackPressedListener:boolean = ThemeChooser.enableBackPressedListener

  build() {
    Scroll(this.scroller) {
      Column() {
        Row(){
          Text('弹窗模式\nsetWindowMode').width('60%')
          Checkbox().select(this.enableWindowMode)
            .onChange((value: boolean) => {
              this.enableWindowMode = value
              ThemeChooser.enableWindowMode = value
            })
        }.width('100%')
        divider()

        Row() {
          Text('状态栏\nsetSystemBarProperties').width('20%').fontSize(15)
          TextInput({ placeholder: '背景六位RBG' })
            .width('40%')
            .fontSize(15)
            .placeholderColor('#ff868181')
            .backgroundColor(this.statusBarColor)
            .onChange((value: string) => {
              this.statusBarColor = '#' + value
            })
          TextInput({ placeholder: '时间六位RBG' })
            .width('40%')
            .fontSize(15)
            .placeholderColor('#ff868181')
            .backgroundColor(this.statusBarContentColor)
            .onChange((value: string) => {
              this.statusBarContentColor = '#' + value
            })
        }.width('100%')
        divider()

        Row() {
          Text('号码栏字体大小\nsetNumberSize').width('60%')
          TextInput({ text: this.numberSize + '', placeholder: '数字' })
            .width('40%')
            .fontSize(this.numberSize)
            .type(InputType.Number)
            .onChange((value: string) => {
              if (value === '') {
                this.numberSize = ThemeChooser.theme.getNumberSize()
              }else {
                this.numberSize = Number.parseInt(value)
              }
            })
        }.width('100%')
        divider()

        Row() {
          Text('手机号码字体颜色\nsetNumberColor').width('60%')
          TextInput({ placeholder: '六位RBG' })
            .width('40%')
            .backgroundColor(this.numberColor)
            .onChange((value: string) => {
              this.numberColor = '#' + value
            })
        }.width('100%')
        divider()

        RelativeContainer() {
          Text('号码栏偏移\nsetNumberMargin').width('40%').alignRules( {
            center: { anchor: '__container__', align: VerticalAlign.Center },
            start: { anchor: '__container__', align: HorizontalAlign.Start }
          }).id('numberTitle')
          TextInput({ text: this.numberMarginLeft + '', placeholder: '数字' })
            .width('65')
            .height('40')
            .type(InputType.Number)
            .alignRules( {
              center: { anchor: '__container__', align: VerticalAlign.Center },
              start: { anchor: 'numberTitle', align: HorizontalAlign.End},
            })
            .onChange((value: string) => {
                this.numberMarginLeft = Number.parseInt(value)
            }).id('numberLeft')
          TextInput({ text: this.numberMarginTop + '', placeholder: '数字' })
            .width('65')
            .height('40')
            .type(InputType.Number)
            .alignRules( {
              top: { anchor: '__container__', align: VerticalAlign.Top },
              start: { anchor: 'numberLeft', align: HorizontalAlign.End},

            })
            .onChange((value: string) => {
                this.numberMarginTop = Number.parseInt(value)
            }).id('numberTop')
          TextInput({ text: this.numberMarginBottom + '', placeholder: '数字' })
            .width('65')
            .height('40')
            .type(InputType.Number)
            .alignRules( {
              bottom: { anchor: '__container__', align: VerticalAlign.Bottom },
              start: { anchor: 'numberLeft', align: HorizontalAlign.End}
            })
            .onChange((value: string) => {
                this.numberMarginBottom = Number.parseInt(value)
            })
          TextInput({ text: this.numberMarginRight + '', placeholder: '数字' })
            .width('65')
            .height('40')
            .type(InputType.Number)
            .alignRules( {
              center: { anchor: '__container__', align: VerticalAlign.Center },
              start: { anchor: 'numberTop', align: HorizontalAlign.End},
            })
            .onChange((value: string) => {
                this.numberMarginRight = Number.parseInt(value)
            })
        }.height('80')
        .width('100%')
        divider()

        Row(){
          Text('号码栏相对布局偏移规则\nsetNumberAlignRuleOption').width('60%')
          Column(){
            Text('顶部')
            Radio({ value: '顶部', group: 'numberRadioGroup' }).checked(ThemeChooser.theme.getNumberAlignRuleOption().top != undefined)
              .onChange((isChecked: boolean) => {
                if(isChecked){
                  this.numberAlignRuleOption ={
                    middle: { anchor: '__container__', align: HorizontalAlign.Center },
                    top: { anchor: '__container__', align: VerticalAlign.Top}
                  }
                }
              })
          }
          Column(){
            Text('底部')
            Radio({ value: '底部', group: 'numberRadioGroup' }).checked(ThemeChooser.theme.getNumberAlignRuleOption().bottom != undefined)
              .onChange((isChecked: boolean) => {
                if(isChecked){
                  this.numberAlignRuleOption ={
                    middle: { anchor: '__container__', align: HorizontalAlign.Center },
                    bottom: { anchor: '__container__', align: VerticalAlign.Bottom}
                  }
                }
              })
          }.margin({
            left:15
          })
        }.width('100%')
        divider()

        Row() {
          Text('登录按钮文本内容\nsetLogBtnText').width('60%')
          TextInput({ text: this.loginBtnText + '', placeholder: '输入文本' })
            .width('40%')
            .onChange((value: string) => {
              if (value === '') {
                this.loginBtnText = ThemeChooser.theme.getLogBtnText()
              }else {
                this.loginBtnText = value
              }
            })
        }.width('100%')
        divider()

        Row() {
          Text('登录文本字体大小\nsetLoginBtnTextSize').width('60%')
          TextInput({ text: this.loginBtnTextSize + '', placeholder: '数字' })
            .width('40%')
            .fontSize(this.loginBtnTextSize)
            .type(InputType.Number)
            .onChange((value: string) => {
              if (value === '') {
                this.loginBtnTextSize = ThemeChooser.theme.getLoginBtnTextSize()
              }else {
                this.loginBtnTextSize = Number.parseInt(value)
              }
            })
        }.width('100%')
        divider()

        Row() {
          Text('登录按钮字体颜色\nsetLoginBtnTextColor').width('60%')
          TextInput({ placeholder: '六位RBG' })
            .width('40%')
            .backgroundColor(this.loginBtnTextColor)
            .onChange((value: string) => {
              this.loginBtnTextColor = '#' + value
            })
        }.width('100%')
        divider()

        Row() {
          Text('登录按钮背景颜色\nsetLoginBtnColor').width('60%')
          TextInput({ placeholder: '六位RBG' })
            .width('40%')
            .backgroundColor(this.loginBtnColor)
            .onChange((value: string) => {
              this.loginBtnColor = '#' + value
            })
        }.width('100%')
        divider()

        Row() {
          Text('登录按钮宽度\nsetLoginBtnWidth').width('60%')
          TextInput({ text: this.loginBtnWidth + '', placeholder: '数字' })
            .width('40%')
            .type(InputType.Number)
            .onChange((value: string) => {
              if (value === '') {
                this.loginBtnWidth = ThemeChooser.theme.getLoginBtnWidth()
              }else {
                this.loginBtnWidth = Number.parseInt(value)
              }
            })
        }.width('100%')
        divider()

        Row() {
          Text('登录按钮高度\nsetLoginBtnHeight').width('60%')
          TextInput({ text: this.loginBtnHeight + '', placeholder: '数字' })
            .width('40%')
            .type(InputType.Number)
            .onChange((value: string) => {
              if (value === '') {
                this.loginBtnHeight = ThemeChooser.theme.getLoginBtnHeight()
              }else {
                this.loginBtnHeight = Number.parseInt(value)
              }
            })
        }.width('100%')
        divider()

        RelativeContainer() {
          Text('登录按钮边缘边距\nsetLoginBtnMargin').width('40%').alignRules( {
            center: { anchor: '__container__', align: VerticalAlign.Center },
            start: { anchor: '__container__', align: HorizontalAlign.Start }
          }).id('loginTitle')
          TextInput({ text: this.loginBtnMarginLeft + '', placeholder: '数字' })
            .width('65')
            .height('40')
            .type(InputType.Number)
            .alignRules( {
              center: { anchor: '__container__', align: VerticalAlign.Center },
              start: { anchor: 'loginTitle', align: HorizontalAlign.End},
            })
            .onChange((value: string) => {
                this.loginBtnMarginLeft = Number.parseInt(value)
            }).id('loginLeft')
          TextInput({ text: this.loginBtnMarginTop + '', placeholder: '数字' })
            .width('65')
            .height('40')
            .type(InputType.Number)
            .alignRules( {
              top: { anchor: '__container__', align: VerticalAlign.Top },
              start: { anchor: 'loginLeft', align: HorizontalAlign.End},

            })
            .onChange((value: string) => {
                this.loginBtnMarginTop = Number.parseInt(value)
            }).id('loginTop')
          TextInput({ text: this.loginBtnMarginBottom + '', placeholder: '数字' })
            .width('65')
            .height('40')
            .type(InputType.Number)
            .alignRules( {
              bottom: { anchor: '__container__', align: VerticalAlign.Bottom },
              start: { anchor: 'loginLeft', align: HorizontalAlign.End}
            })
            .onChange((value: string) => {
                this.loginBtnMarginBottom = Number.parseInt(value)
            })
          TextInput({ text: this.loginBtnMarginRight + '', placeholder: '数字' })
            .width('65')
            .height('40')
            .type(InputType.Number)
            .alignRules( {
              center: { anchor: '__container__', align: VerticalAlign.Center },
              start: { anchor: 'loginTop', align: HorizontalAlign.End},
            })
            .onChange((value: string) => {
                this.loginBtnMarginRight = Number.parseInt(value)
            })
        }.height('80')
        .width('100%')
        divider()

        Row(){
          Text('登录按钮相对布局偏移规则\nsetLoginBtnAlignRuleOption').width('60%')
          Column(){
            Text('顶部')
            Radio({ value: '顶部', group: 'loginRadioGroup' }).checked(ThemeChooser.theme.getLoginBtnAlignRuleOption().top != undefined)
              .onChange((isChecked: boolean) => {
                if(isChecked){
                  this.loginBtnAlignRuleOption ={
                    middle: { anchor: '__container__', align: HorizontalAlign.Center },
                    top: { anchor: '__container__', align: VerticalAlign.Top}
                  }
                }
              })
          }
          Column(){
            Text('底部')
            Radio({ value: '底部', group: 'loginRadioGroup' }).checked(ThemeChooser.theme.getLoginBtnAlignRuleOption().bottom != undefined)
              .onChange((isChecked: boolean) => {
                if(isChecked){
                  this.loginBtnAlignRuleOption ={
                    middle: { anchor: '__container__', align: HorizontalAlign.Center },
                    bottom: { anchor: '__container__', align: VerticalAlign.Bottom}
                  }
                }
              })
          }.margin({
            left:15
          })
        }.width('100%')
        divider()

        Row(){
          Text('勾选框选中时登录按钮点击监听事件\nsetCheckedLoginListener').width('60%')
          Checkbox().select(this.setCheckedLoginListener)
            .onChange((value: boolean) => {
              this.setCheckedLoginListener = value
              ThemeChooser.enableCheckedLoginListener = this.setCheckedLoginListener
            })
        }.width('100%')
        divider()

        Row(){
          Text('勾选框未选中时登录按钮点击监听事件\nsetUncheckedLoginListener').width('60%')
          Checkbox().select(this.setUncheckedLoginListener)
            .onChange((value: boolean) => {
              this.setUncheckedLoginListener = value
              ThemeChooser.enableUncheckedLoginListener = this.setUncheckedLoginListener
            })
        }.width('100%')
        divider()

        Row(){
          Text('授权页布局自定义组件\nsetLoginPageComponent').width('60%')
          Checkbox().select(this.setLoginPageComponent)
            .onChange((value: boolean) => {
              this.setLoginPageComponent = value
              ThemeChooser.enableLoginPageComponent = this.setLoginPageComponent
            })
        }.width('100%')
        divider()

        Row() {
          Text('隐私条款勾选框宽高\nsetCheckBox').width('60%')
          TextInput({ text: this.checkedWidth + '', placeholder: '宽' })
            .width('20%')
            .type(InputType.Number)
            .onChange((value: string) => {
              if (value === '') {
                this.checkedWidth = ThemeChooser.theme.getCheckedWidth()
              }else {
                this.checkedWidth = Number.parseInt(value)
              }
            })
          TextInput({ text: this.checkedHeight + '', placeholder: '高' })
            .width('20%')
            .type(InputType.Number)
            .onChange((value: string) => {
              if (value === '') {
                this.checkedHeight = ThemeChooser.theme.getCheckedHeight()
              }else {
                this.checkedHeight = Number.parseInt(value)
              }
            })
        }.width('100%')
        divider()

        RelativeContainer() {
          Text('隐私条款勾选框偏移边距\nsetCheckBoxMargin').width('40%').alignRules( {
            center: { anchor: '__container__', align: VerticalAlign.Center },
            start: { anchor: '__container__', align: HorizontalAlign.Start }
          }).id('checkBoxTitle')
          TextInput({ text: this.checkBoxMarginLeft + '', placeholder: '数字' })
            .width('65')
            .height('40')
            .type(InputType.Number)
            .alignRules( {
              center: { anchor: '__container__', align: VerticalAlign.Center },
              start: { anchor: 'checkBoxTitle', align: HorizontalAlign.End},
            })
            .onChange((value: string) => {
                this.checkBoxMarginLeft = Number.parseInt(value)
            }).id('checkBoxLeft')
          TextInput({ text: this.checkBoxMarginTop + '', placeholder: '数字' })
            .width('65')
            .height('40')
            .type(InputType.Number)
            .alignRules( {
              top: { anchor: '__container__', align: VerticalAlign.Top },
              start: { anchor: 'checkBoxLeft', align: HorizontalAlign.End},

            })
            .onChange((value: string) => {
                this.checkBoxMarginTop = Number.parseInt(value)
            }).id('checkBoxTop')
          TextInput({ text: this.checkBoxMarginBottom + '', placeholder: '数字' })
            .width('65')
            .height('40')
            .type(InputType.Number)
            .alignRules( {
              bottom: { anchor: '__container__', align: VerticalAlign.Bottom },
              start: { anchor: 'checkBoxLeft', align: HorizontalAlign.End}
            })
            .onChange((value: string) => {
                this.checkBoxMarginBottom = Number.parseInt(value)
            })
          TextInput({ text: this.checkBoxMarginRight + '', placeholder: '数字' })
            .width('65')
            .height('40')
            .type(InputType.Number)
            .alignRules( {
              center: { anchor: '__container__', align: VerticalAlign.Center },
              start: { anchor: 'checkBoxTop', align: HorizontalAlign.End},
            })
            .onChange((value: string) => {
                this.checkBoxMarginRight = Number.parseInt(value)
            })
        }.height('80')
        .width('100%')
        divider()

        Row(){
          Text('隐私条款勾选框相对布局偏移规则\nsetCheckBoxAlignRuleOption').width('60%')
          Column(){
            Text('顶部')
            Radio({ value: '顶部', group: 'checkBoxRadioGroup' }).checked(ThemeChooser.theme.getCheckBoxAlignRuleOption().top != undefined)
              .onChange((isChecked: boolean) => {
                if(isChecked){
                  this.checkBoxAlignRuleOption ={
                    'left': { 'anchor': '__container__', 'align': HorizontalAlign.Start },
                    'top': { anchor: '__container__', align: VerticalAlign.Top}
                  }
                }
              })
          }
          Column(){
            Text('底部')
            Radio({ value: '底部', group: 'checkBoxRadioGroup' }).checked(ThemeChooser.theme.getCheckBoxAlignRuleOption().bottom != undefined)
              .onChange((isChecked: boolean) => {
                if(isChecked){
                  this.checkBoxAlignRuleOption ={
                    'left': { 'anchor': '__container__', 'align': HorizontalAlign.Start },
                    'bottom': { anchor: '__container__', align: VerticalAlign.Bottom}
                  }
                }
              })
          }.margin({
            left:15
          })
        }.width('100%')
        divider()

        Row(){
          Text('勾选框类型（圆形/圆角矩形）\nsetCheckBoxShape').width('60%')
          Column(){
            Text('圆形')
            Radio({ value: '圆形', group: 'shapeRadioGroup' }).checked(ThemeChooser.theme.getCheckBoxShape() === CheckBoxShape.CIRCLE)
              .onChange((isChecked: boolean) => {
                if(isChecked){
                  this.checkBoxShape = CheckBoxShape.CIRCLE
                }
              })
          }
          Column(){
            Text('圆角矩形')
            Radio({ value: '圆角矩形', group: 'shapeRadioGroup' }).checked(ThemeChooser.theme.getCheckBoxShape() === CheckBoxShape.ROUNDED_SQUARE)
              .onChange((isChecked: boolean) => {
                if(isChecked){
                  this.checkBoxShape = CheckBoxShape.ROUNDED_SQUARE
                }
              })
          }
          .margin({
            left:15
          })
        }.width('100%')
        divider()

        Row(){
          Text('授权页勾选框是否勾选的监听事件\nsetCheckBoxChangeListener').width('60%')
          Checkbox().select(this.setCheckBoxChangeListener)
            .onChange((value: boolean) => {
              this.setCheckBoxChangeListener = value
              ThemeChooser.enableCheckBoxChangeListener = this.setCheckBoxChangeListener
            })
        }.width('100%')
        divider()

        Row(){
          Text('隐私条款勾选框勾选状态\nsetClauseState').width('60%')
          Checkbox().select(this.clauseState)
            .onChange((value: boolean) => {
              this.clauseState = value
            })
        }.width('100%')
        divider()

        Row(){
          Text('隐私条款的协议文本，自定义条款，自定义条款链接、字体颜色\nsetClauses').width('60%')
          Column(){
            Text('默认')
            Radio({ value: '默认', group: 'clauseRadioGroup' }).checked(ThemeChooser.clauseStyle === 1)
              .onChange((isChecked: boolean) => {
                if(isChecked){
                  ThemeChooser.clauseStyle = 1
                }
              })
          }
          Column(){
            Text('自定义')
            Radio({ value: '自定义', group: 'clauseRadioGroup' }).checked(ThemeChooser.clauseStyle === 2)
              .onChange((isChecked: boolean) => {
                if(isChecked){
                  ThemeChooser.clauseStyle = 2
                }
              })
          }
          .margin({
            left:15
          })
        }.width('100%')
        divider()

        RelativeContainer() {
          Text('隐私条款偏移边距\nsetClauseMargin').width('40%').alignRules( {
            center: { anchor: '__container__', align: VerticalAlign.Center },
            start: { anchor: '__container__', align: HorizontalAlign.Start }
          }).id('clauseTitle')
          TextInput({ text: this.clauseMarginLeft + '', placeholder: '数字' })
            .width('65')
            .height('40')
            .type(InputType.Number)
            .alignRules( {
              center: { anchor: '__container__', align: VerticalAlign.Center },
              start: { anchor: 'clauseTitle', align: HorizontalAlign.End},
            })
            .onChange((value: string) => {
                this.clauseMarginLeft = Number.parseInt(value)
            }).id('clauseLeft')
          TextInput({ text: this.clauseMarginTop + '', placeholder: '数字' })
            .width('65')
            .height('40')
            .type(InputType.Number)
            .alignRules( {
              top: { anchor: '__container__', align: VerticalAlign.Top },
              start: { anchor: 'clauseLeft', align: HorizontalAlign.End},

            })
            .onChange((value: string) => {
                this.clauseMarginTop = Number.parseInt(value)
            }).id('clauseTop')
          TextInput({ text: this.clauseMarginBottom + '', placeholder: '数字' })
            .width('65')
            .height('40')
            .type(InputType.Number)
            .alignRules( {
              bottom: { anchor: '__container__', align: VerticalAlign.Bottom },
              start: { anchor: 'clauseLeft', align: HorizontalAlign.End}
            })
            .onChange((value: string) => {
                this.clauseMarginBottom = Number.parseInt(value)
            })
          TextInput({ text: this.clauseMarginRight + '', placeholder: '数字' })
            .width('65')
            .height('40')
            .type(InputType.Number)
            .alignRules( {
              center: { anchor: '__container__', align: VerticalAlign.Center },
              start: { anchor: 'clauseTop', align: HorizontalAlign.End},
            })
            .onChange((value: string) => {
                this.clauseMarginRight = Number.parseInt(value)
            })
        }.height('80')
        .width('100%')
        divider()

        Row(){
          Text('隐私条款相对布局偏移规则\nsetClauseAlignRuleOption').width('60%')
          Column(){
            Text('顶部')
            Radio({ value: '顶部', group: 'clauseStyleRadioGroup' }).checked(ThemeChooser.theme.getClauseAlignRuleOption().top != undefined)
              .onChange((isChecked: boolean) => {
                if(isChecked){
                  this.clauseAlignRuleOption ={
                    middle: { anchor: '__container__', align: HorizontalAlign.Center },
                    top: { anchor: '__container__', align: VerticalAlign.Top}
                  }
                }
              })
          }
          Column(){
            Text('底部')
            Radio({ value: '底部', group: 'clauseStyleRadioGroup' }).checked(ThemeChooser.theme.getClauseAlignRuleOption().bottom != undefined)
              .onChange((isChecked: boolean) => {
                if(isChecked){
                  this.clauseAlignRuleOption ={
                    middle: { anchor: '__container__', align: HorizontalAlign.Center },
                    bottom: { anchor: '__container__', align: VerticalAlign.Bottom}
                  }
                }
              })
          }.margin({
            left:15
          })
        }.width('100%')
        divider()

        Row() {
          Text('服务条款标题字体大小\nsetNavTextSize').width('60%')
          TextInput({ text: this.navTextSize + '', placeholder: '数字' })
            .width('40%')
            .fontSize(this.navTextSize)
            .type(InputType.Number)
            .onChange((value: string) => {
              if (value === '') {
                this.navTextSize = ThemeChooser.theme.getNavTextSize()
              }else {
                this.navTextSize = Number.parseInt(value)
              }
            })
        }.width('100%')
        divider()

        Row() {
          Text('服务条款标题字体颜色\nsetNavTextColor').width('60%')
          TextInput({ placeholder: '六位RBG' })
            .width('40%')
            .backgroundColor(this.navTextColor)
            .onChange((value: string) => {
              this.navTextColor = '#' + value
            })
        }.width('100%')
        divider()

        Row() {
          Text('服务条款标题颜色\nsetNavColor').width('60%')
          TextInput({ placeholder: '六位RBG' })
            .width('40%')
            .backgroundColor(this.navColor)
            .onChange((value: string) => {
              this.navColor = '#' + value
            })
        }.width('100%')
        divider()

        Row(){
          Text('服务条款标题栏自定义组件\nsetClauseComponent').width('60%')
          Checkbox().select(this.enableClauseComponent)
            .onChange((value: boolean) => {
              this.enableClauseComponent = value
              ThemeChooser.enableClauseComponent = value
            })
        }.width('100%')
        divider()

        Row(){
          Text('授权页返回键监听事件\nsetBackPressedListener').width('60%')
          Checkbox().select(this.setBackPressedListener)
            .onChange((value: boolean) => {
              this.setBackPressedListener = value
              ThemeChooser.enableBackPressedListener = value
            })
        }.width('100%')
        divider()
      }.width('100%')
    }
    .width('100%')
    .scrollable(ScrollDirection.Vertical) // 滚动方向纵向

  }

  aboutToDisappear(): void {
    if(Number.isNaN(this.numberMarginTop)){
      this.numberMarginTop = 0
    }
    if(Number.isNaN(this.numberMarginLeft)){
      this.numberMarginLeft = 0
    }
    if(Number.isNaN(this.numberMarginRight)){
      this.numberMarginRight = 0
    }
    if(Number.isNaN(this.numberMarginBottom)){
      this.numberMarginBottom = 0
    }
    if(Number.isNaN(this.loginBtnMarginTop)){
      this.loginBtnMarginTop = 0
    }
    if(Number.isNaN(this.loginBtnMarginLeft)){
      this.loginBtnMarginLeft = 0
    }
    if(Number.isNaN(this.loginBtnMarginRight)){
      this.loginBtnMarginRight = 0
    }
    if(Number.isNaN(this.loginBtnMarginBottom)){
      this.loginBtnMarginBottom = 0
    }
    if(Number.isNaN(this.checkBoxMarginTop)){
      this.checkBoxMarginTop = 0
    }
    if(Number.isNaN(this.checkBoxMarginLeft)){
      this.checkBoxMarginLeft = 0
    }
    if(Number.isNaN(this.checkBoxMarginRight)){
      this.checkBoxMarginRight = 0
    }
    if(Number.isNaN(this.checkBoxMarginBottom)){
      this.checkBoxMarginBottom = 0
    }
    if(Number.isNaN(this.clauseMarginTop)){
      this.clauseMarginTop = 0
    }
    if(Number.isNaN(this.clauseMarginLeft)){
      this.clauseMarginLeft = 0
    }
    if(Number.isNaN(this.clauseMarginRight)){
      this.clauseMarginRight = 0
    }
    if(Number.isNaN(this.clauseMarginBottom)){
      this.clauseMarginBottom = 0
    }

    ThemeChooser.theme
      .setSystemBarProperties({
        statusBarColor: this.statusBarColor,
        statusBarContentColor: this.statusBarContentColor
      })
      .setNumberSize(this.numberSize)
      .setNumberColor(this.numberColor)
      .setNumberMargin({
        top:this.numberMarginTop,
        left:this.numberMarginLeft,
        right:this.numberMarginRight,
        bottom:this.numberMarginBottom
      })
      .setNumberAlignRuleOption(this.numberAlignRuleOption)
      .setLogBtnText(this.loginBtnText)
      .setLoginBtnTextSize(this.loginBtnTextSize)
      .setLoginBtnColor(this.loginBtnColor)
      .setLoginBtnTextColor(this.loginBtnTextColor)
      .setLoginBtnWidth(this.loginBtnWidth)
      .setLoginBtnHeight(this.loginBtnHeight)
      .setLoginBtnMargin({
        top:this.loginBtnMarginTop,
        left:this.loginBtnMarginLeft,
        right:this.loginBtnMarginRight,
        bottom:this.loginBtnMarginBottom
      })
      .setLoginBtnAlignRuleOption(this.loginBtnAlignRuleOption)
    if(ThemeChooser.enableCheckedLoginListener){
      ThemeChooser.theme.setCheckedLoginListener({
        onLoginClickStart(context: UIContext) {
          showToast("开始登录授权")
        }
      , onLoginClickComplete(context: UIContext) {
          showToast("登录授权结束")
        }
      })
    }else{
      ThemeChooser.theme.setCheckedLoginListener(undefined)
    }
    if(ThemeChooser.enableUncheckedLoginListener){
      ThemeChooser.theme.setUncheckedLoginListener({
        onAuthLoginListener(context: UIContext, callBack: SetCheckCallback) {
          promptAction.showDialog({
            message: '是否登录授权',
            buttons: [
              {
                text: '确定',
                color: '#000000'
              },
              {
                text: '取消',
                color: '#000000'
              }
            ],
          })
            .then(data => {
              if (data.index == 0) {
                callBack.onAuthLoginCallBack(true)
              } else {
                callBack.onAuthLoginCallBack(false)
              }
            })
        }
      })
    }else{
      ThemeChooser.theme.setUncheckedLoginListener(undefined)
    }
    if(ThemeChooser.enableLoginPageComponent){
      ThemeChooser.theme.setLoginPageComponent(authPageComponent)
    }else{
      ThemeChooser.theme.setLoginPageComponent(undefined)
    }
    ThemeChooser.theme.setCheckBox(this.checkedWidth, this.checkedHeight)
      .setCheckBoxMargin({
        top:this.checkBoxMarginTop,
        left:this.checkBoxMarginLeft,
        right:this.checkBoxMarginRight,
        bottom:this.checkBoxMarginBottom
      })
      .setCheckBoxAlignRuleOption(this.checkBoxAlignRuleOption)
      .setCheckBoxShape(this.checkBoxShape)
    if(ThemeChooser.enableCheckBoxChangeListener){
      ThemeChooser.theme.setCheckBoxChangeListener({
        onCheckedChanged(b: boolean) {
          showToast("勾选框状态" + b)
        }
      })
    }else{
      ThemeChooser.theme.setCheckBoxChangeListener(undefined)
    }
    ThemeChooser.theme.setClauseState(this.clauseState)
    if(ThemeChooser.clauseStyle == 1){
      ThemeChooser.theme.setClauses([ThemeChooser.theme.getPrefixClause(), ThemeChooser.theme.getSelfClause()])
    }else{
      ThemeChooser.theme.setClauses([{
        text: "登录即同意",
        type: ClauseSpan.NORMAL,
        fontColor: '#ff3680ec',
        fontSize: 15,
        fontWeight: FontWeight.Bold
      }, {
        text: "不用填",
        type: ClauseSpan.OPERATOR_PROTOCOL,
        fontColor: '#ff15468d',
        fontSize: 15,
        fontWeight: FontWeight.Bold
      }, {
        text: "自定义协议",
        type: ClauseSpan.CUSTOM_PROTOCOL,
        fontColor: '#ffd23064',
        fontSize: 15,
        fontWeight: FontWeight.Bold,
        url : "http://www.baidu.com"
      }])
    }
    ThemeChooser.theme.setClauseMargin({
      top:this.clauseMarginTop,
      left:this.clauseMarginLeft,
      right:this.clauseMarginRight,
      bottom:this.clauseMarginBottom
    })
      .setClauseAlignRuleOption(this.clauseAlignRuleOption)
      .setNavTextSize(this.navTextSize)
      .setNavTextColor(this.navTextColor)
      .setNavColor(this.navColor)

    if(ThemeChooser.enableClauseComponent){
      ThemeChooser.theme.setClauseComponent(clauseComponent)
    }else{
      ThemeChooser.theme.setClauseComponent(undefined)
    }
    if(ThemeChooser.enableWindowMode) {
      ThemeChooser.theme.useDialogMode({
        alignment: DialogAlignment.Center,
        width: '100%',
        height: '80%'
      })
    }else{
      ThemeChooser.theme.useDialogMode(undefined)
    }
    if(ThemeChooser.enableBackPressedListener){
      ThemeChooser.theme.setBackPressedListener({
        onBackPressed: () => {
          showToast("返回键监听")
        }
      })
    }else{
      ThemeChooser.theme.setBackPressedListener(undefined)
    }
    // 在自定义组件即将析构销毁时将dialogController置空
    this.controller = undefined // 将dialogController置空
  }

}
function showToast(result: string) {
  Prompt.showToast({
    message: result,
  })
}

@Builder
function divider():void{
  Divider().strokeWidth(3).color('#000000')
}

@Builder
function authPageComponent(): void {
  Column() {
    Text('自定义布局')
      .fontSize(40)
      .alignRules({
        middle: { anchor: '__container__', align: HorizontalAlign.Center },
        top: { anchor: '__container__', align: VerticalAlign.Top },

      })

    Button('自定义按钮')
      .alignRules({
        middle: { anchor: '__container__', align: HorizontalAlign.Center },
        top: { anchor: '__container__', align: VerticalAlign.Top },

      }).margin({top:'150%'}).onClick(()=>{
      showToast("click")
    })
  }.width('100%')
  .height('100%')
  .alignRules({
    top: { anchor: '__container__', align: VerticalAlign.Top },
    bottom: { anchor: '__container__', align: VerticalAlign.Bottom },
    left:{ anchor: '__container__', align: HorizontalAlign.Start }
  })
  .id("111")
}

@Builder
function clauseComponent(): void {
  Column() {
    Text('自定义协议页标题栏')
      .fontSize(20)
      .alignRules({
        middle: { anchor: '__container__', align: HorizontalAlign.Center },
        center: { anchor: '__container__', align: VerticalAlign.Center },

      })
  }.width('100%')
  .height(50)
  .backgroundColor(0x7f0086d0)
  .id("clauseComponent")
}
