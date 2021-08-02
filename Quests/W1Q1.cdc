// *...*
// .*.*.
// ..*..
// .*.*.
// *...*

pub struct Canvas {
    pub let width: UInt8
    pub let height: UInt8
    pub let pixels: String
    
    init (width: UInt8, height: UInt8, pixels: String) {
        self.width = width
        self.height = height
        // 123
        // 456
        // 789
        // 123456789
        self.pixels = pixels
    }
}

pub resource Picture {
    pub let canvas: Canvas
    init(canvas: Canvas) {
        self.canvas = canvas
    }
}

pub fun serializeStringArray(_ lines: [String]): String {
    var buffer = ""
    for line in lines {
        buffer = buffer.concat(line)
    }

    return buffer
}

pub fun display(canvas: Canvas) {
    //Declaring necessary frame constants
    let horizontalFrame = "-"
    let verticalFrame = "|"
    let cornerFrame = "+"
    let canvasWidth = Int(canvas.width)
    let canvasHeight = Int(canvas.height)

    //Necessary variables to create top and bottom of the frame
    var topAndBottomBorder = ""
    var widthCounter = 0

    //Creating the top and bottom of the display, this should work with any size canvas width
    topAndBottomBorder = topAndBottomBorder.concat(cornerFrame)
    while widthCounter < canvasWidth {
        topAndBottomBorder = topAndBottomBorder.concat(horizontalFrame)
        widthCounter = widthCounter + 1
    }
    topAndBottomBorder = topAndBottomBorder.concat(cornerFrame)

    //Necessary variables used to frame the contents of the canvas
    var canvasLine = ""
    var heightCounter = 0
    var startLine = 0
    var endLine = canvasWidth

    //Print top of display
    log(topAndBottomBorder)

    //Changing each line of canvas so it is properly displayed
    //And then logging it
    //Hopefully works for any size canvas height and width
    while heightCounter < canvasHeight {
        canvasLine = canvasLine.concat(verticalFrame)
        canvasLine = canvasLine.concat(canvas.pixels.slice(from: startLine, upTo: endLine))
        canvasLine = canvasLine.concat(verticalFrame)

        log(canvasLine)

        canvasLine = ""
        startLine = endLine
        endLine = endLine + canvasWidth
        heightCounter = heightCounter + 1
    }

    //Finally logging the bottom of the display
    log(topAndBottomBorder)

}

pub fun main() {
    let pixelsX = [
        "*   *",
        " * * ",
        "  *  ",
        " * * ",
        "*   *"
    ]
    let canvasX = Canvas(
        width: 5,
        height: 5,
        pixels: serializeStringArray(pixelsX)
    )

    //testing non square canvases
    let pixelsY = [
        "*   *   *",
        "  *   *  ",
        "    *    ",
        "  *   *  ",
        "*   *   *"
    ]
    let canvasY = Canvas(
        width: 9,
        height: 5,
        pixels: serializeStringArray(pixelsY)
    )

    display(canvas: canvasX)
    display(canvas: canvasY)
}
