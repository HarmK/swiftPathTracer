let screenWidth = 500
let screenHeight = 500
let screenDistance = 500.0

extension Material {
  public static let sky = Material(color: .white, emmit: 1.0)
  public static let plain = Material(color: .offWhite, emmit: 0.0)
}

extension Vector {
  public static let white = Vector(1,1,1)
  public static let offWhite = Vector(0.5,0.5,0.5)
  public static let red = Vector(1,0,0)
  public static let green = Vector(1,0,0)
  public static let orange = Vector(1,0.5,0)
  public static let black = Vector(0,0,0)
}

//camera position
let camera = Vector(0,0,-1 * screenDistance)

//create scene
let scene = Scene(camera: camera, width: screenWidth, height: screenHeight)

//render to PPM
PPM.make(from: scene.render() )
