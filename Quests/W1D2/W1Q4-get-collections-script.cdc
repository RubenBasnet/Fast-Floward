import Artist from 0x01

pub fun main() {
  
  let accounts = [
    getAccount(0x01),
    getAccount(0x02),
    getAccount(0x03),
    getAccount(0x04),
    getAccount(0x05)
  ]
  
  for account in accounts {
    let collectionRef = account
      .getCapability(/public/ArtistPictureCollection)
      .borrow<&Artist.Collection>()
    
    if collectionRef == nil {
      log("Account ".concat(account.address.toString()).concat(" doesn't have a Picture Collection!"))
    } else {
      log("Account's ".concat(account.address.toString()).concat(" Picture"))
      var pictureNumber = 1
      for canvas in collectionRef!.getCanvases() {
        var rowIndex = 0
        log("Picture #".concat(pictureNumber.toString()))
        while rowIndex < Int(canvas.height) {
          let row = canvas.pixels.slice(
          from: rowIndex * Int(canvas.width),
          upTo: (rowIndex+1) * Int(canvas.width)
          )
          log(row)
          rowIndex = rowIndex + 1
        }
        pictureNumber = pictureNumber + 1
      }
    }
  }

}
