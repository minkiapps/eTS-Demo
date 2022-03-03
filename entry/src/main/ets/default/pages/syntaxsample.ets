@Entry
@Component
struct DataSample {

  @State index: number = 0

  build() {
    Column() {
      Text(`${this.index}`)
        .margin({ top : 16 })
      .fontSize(32)
      LinkUse({ index: $index })
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct LinkUse {
  @Link @Watch("changeOdd") index : number;

  isOdd: boolean = false; //don't need to be state since index @watch will trigger a rebuild

  changeOdd() {
    this.isOdd = this.index % 2 != 0;
  }

  build() {
    Column() {
      Button(`Link usage: ${this.index}, isOdd: ${this.isOdd}`).onClick(() => {
        this.index++;
      })

      PropUse({index:this.index})
    }.margin({ top : 16})
  }
}

@Component
struct PropUse {
  @Prop index: number;

  build() {
    Text(`PropUse ${this.index}`)
      .fontSize(24)
      .margin({top : 16})
  }
}