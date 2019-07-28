
class PPM {
  
  //print PPM file :)
  static func make(from colors: [[Vector]]) {
    print("P3\n\(colors.count) \(colors[0].count)\n255\n")
    for row in colors {
      for pixel in row {
      let red = abs(Int(pixel.x * 255.0))
      let green = abs(Int(pixel.y * 255.0))
      let blue = abs(Int(pixel.z * 255.0))
        print(" \(red) \(green) \(blue)", terminator: "")
      }
      print("")
    }
  }
}
