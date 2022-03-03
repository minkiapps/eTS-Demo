import {AppStorage} from '../storage/appstorage.ets'
import featureAbility from '@ohos.ability.featureAbility'

@Entry
@Component
struct Detailpage {
  build() {
    Column() {
      Column() {
        Image($rawfile('chucknorris.jpg'))
          .size({ width: 100, height: 100 })
          .border({ width: 2, color: $r('sys.color.id_color_text_primary'), radius: 50 })
          .sharedTransition("chuck_norris")
          .margin({ top: 16 })

        Text($r('app.string.chuck_norris_name'))
          .fontSize(24)
          .fontColor($r('sys.color.id_color_text_primary'))

        Bar()
      }

      Scroll() {
        Text($r('app.string.chuck_norris_description'))
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor($r('sys.color.id_color_text_secondary'))
          .padding({ left: 16, right: 16, bottom: 16 })
      }.layoutWeight(1).margin({ top: 8 })
    }
  }
}

@Component
struct Bar {

  storage : AppStorage = new AppStorage()

  @State like: boolean = false
  @State likeSize: number = 24

  async aboutToAppear() {
    this.like = await this.storage.getIsLiked()
    console.log('Bar appeared in async function, Like Status: ' + this.like)
  }

  build() {
    Stack({ alignContent: Alignment.End }) {
      Row() {
        Image($rawfile('share.svg'))
          .size({ width: 24, height: 24 })
          .margin({ right: 8 })

        Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
          Image($rawfile(this.like ? 'heart_filled.png' : 'heart.png'))
            .size({ width: this.likeSize, height: this.likeSize })
            .onClick((clickEvent) => {
              this.like = !this.like
              this.storage.setLike(this.like)
              animateTo({
                duration: 300,
                curve: Curve.EaseInOut,
                iterations: 1,
                onFinish: () => {
                  this.likeSize = 24
                }
              }, () => {
                this.likeSize = 20
              })
            })
        }.width(24)
      }
      .margin({ right: 16 })
      .height(36)
      .padding({left : 16, right : 16})
      .backgroundColor('#333333')
      .borderRadius(8)
    }.width('100%')
  }
}