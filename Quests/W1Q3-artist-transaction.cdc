import Artist from 0x01
 //Namespacing picture resource because comes from artist smart contract
transaction() {
    let pixels: String
    let picture: @Artist.Picture?
    let collectionRef: &Artist.Collection

    prepare(account: AuthAccount) {
        let printerRef = getAccount(0x01)
            .getCapability<&Artist.Printer>(/public/ArtistPicturePrinter)
            .borrow()
            ?? panic("Couldn't borrow printer reference")
        
        self.collectionRef = account
            .getCapability(/public/ArtistPictureCollection)
            .borrow<&Artist.Collection>()
            ?? panic("Couldn't Borrow collection reference.")

        self.pixels = "*   * * *   *   * * *   *"    
        
        let canvas = Artist.Canvas(
            width: printerRef.width,
            height: printerRef.height,
            pixels: self.pixels
        )

        self.picture <- printerRef.print(canvas: canvas)
    }

    execute {
        if (self.picture == nil) {
            log("Picture with ".concat(self.pixels).concat(" already exists!"))
            destroy self.picture
        } else {
            self.collectionRef.deposit(picture: <-self.picture!)
            log("Picture printed!")
        }
    }
}
