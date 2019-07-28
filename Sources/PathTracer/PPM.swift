
class PPM {

  //print PPM file :)
  static func make(from colors: [[Vector]]) {
    print("P3\n\(colors.count) \(colors[0].count)\n255\n")
    for row in colors {
      for pixel in row {
      let red = byteColor(from: pixel.x)
      let green = byteColor(from: pixel.y)
      let blue = byteColor(from: pixel.z)
        print(" \(red) \(green) \(blue)", terminator: "")
      }
      print("")
    }
  }

  static func byteColor(from double: Double) -> Int {
    return double < 1 ? abs(Int(double * 255.0)) : 255
  }

}
