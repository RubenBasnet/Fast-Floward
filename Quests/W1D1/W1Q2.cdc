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


pub resource Printer {
    pub let printed: {String: Bool}

    init() {
        self.printed = {}
    }

    pub fun print(canvas: Canvas): @Picture? {
        if (self.printed.containsKey(canvas.pixels)) {
            log("Can not print more than once")
            return nil
        }
        else {
            let picture <- create Picture(canvas: canvas)
            log(picture.canvas)
            self.printed.insert(key: canvas.pixels, true)
            destroy picture
            return <- create Picture(canvas: canvas)
        }
    }
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
    
    let printer <- create Printer()
    let printerOne <- printer.print(canvas: canvasX)
    let printerTwo <- printer.print(canvas: canvasX)


    destroy printer
    destroy printerOne
    destroy printerTwo
}
