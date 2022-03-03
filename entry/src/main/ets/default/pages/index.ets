// @ts-nocheck
import fetch from '@system.fetch';
import router from '@system.router'
import dayjs from 'dayjs'
import resourceManager from '@ohos.resourceManager';

interface Joke {
  value: string;
}

@Entry
@Component
struct Index {
  aboutToAppear() {
    console.log(`Index page appeared ${dayjs()}`)
  }

  aboutToDisAppear() {
    console.log("Index page disappeared")
  }

  build() {
    Column() {
      JokeLayout()
      Blank()

      //Button('Goto to another page')
      //  .margin({ bottom: 8 })
      //  .onClick((event: ClickEvent) => {
      //    router.push({ uri: 'pages/syntaxsample' })
      //  })
      DayFooter()
    }
    .width('100%')
    .height('100%')
    .linearGradient({ angle: 180, colors: [['#ffffff', 0.1], ['#C0C0C0', 0.6], ['#808080', 1]] })
  }
}

@Component
struct JokeLayout {
  build() {
    Column() {
      JokeHeader()
      JokeView()
      JokeRating()
    }
  }
}

@Component
struct JokeHeader {
  build() {
    Column() {
      Text($r('app.string.chuck_norris_jokes'))
        .fontSize(30)
        .margin({ top: 16 })
        .fontWeight(FontWeight.Bold)

      Navigator({ target: 'pages/detailpage', type: NavigationType.Push }) {
        Image($rawfile('chucknorris.jpg'))
          .size({width : 100, height : 100})
          .border({ width: 2, color: Color.Black, radius: 50 })
          .sharedTransition("chuck_norris")
      }.margin({top : 16})
    }
  }
}

@Component
struct JokeView {

  @State jokeText: string = 'Jokes comes here'

  build() {
    Column() {

      Text(this.jokeText)
        .fontSize(24)
        .width('100%')
        .textAlign(TextAlign.Center)
        .fontWeight(FontWeight.Medium)
        .padding({ left: 16, right: 16 })
        .margin({ top: 16 })

      Button($r('app.string.chuck_norris_reload_joke'))
        .margin({ top: 16 })
        .onClick((event: ClickEvent) => {
          this.jokeText = 'Loading...'
          this.rating = 0

          fetch.fetch({
            url: "https://api.chucknorris.io/jokes/random",
            method: 'GET',
            success: (response) => {
              console.log(response.data as string)
              let joke: Joke = JSON.parse(response.data as string)
              console.log('Joke: ' + joke.value)

              this.jokeText = joke.value
            },
            fail: function (data) {
              console.log("Fetch fail: " + data)
            },
            complete: function () {
              console.log("Fetch joke completed");
            }
          })
        })
    }
  }
}

@Component
struct JokeRating {
  @State rating: number = 0

  build() {
    Column() {
      Text('Joke rating score: ' + this.rating)
        .fontSize(20)
      Rating({ rating: this.rating, indicator: this.indicator })
        .stars(5)
        .stepSize(0.5)
        .margin({ top: 16 })
        .onChange((value: number) => {
          this.rating = value
        })
    }.padding(35)
  }
}

@Component
struct DayFooter {
  build() {
    Text(dayjs().toString())
      .fontSize(20)
      .margin({ bottom: 8 })
  }
}