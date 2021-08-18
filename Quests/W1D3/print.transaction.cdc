import Artist from "./contract.cdc"

// Print a Picture and store it in the authorizing account's Picture Collection.
transaction(width: UInt8, height: UInt8, pixels: String) {
    prepare(account: AuthAccount) {
        let printerRef = getAccount(0x01)
            .getCapability(/public/ArtistPicturePrinter)
            .borrow<&Artist.Printer>()
            ?? panic("Couldn't borrow Printer reference.")

        let collectionRef = account
            .getCapability(/public/ArtistPictureCollection)
            .borrow<&Artist.Collection>()
            ?? panic("Couldn't borrow Collection reference.")

        let picture <- printerRef.print(width: width,
        height: height,
        pixels: pixels
        )
        
        if picture != nil {
            collectonRef.deposit(picture: <- picture!)
        } else {
            destroy picture
        }
    }
}
