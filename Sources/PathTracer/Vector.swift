import Foundation

struct Vector {
    var x: Double
    var y: Double
    var z: Double

    init() {
      self.x = 0
      self.y = 0
      self.z = 0
    }

    init( _ x: Double, _ y: Double, _ z: Double) {
      self.x = x
      self.y = y
      self.z = z
    }

    var squaredLength: Double {
      return (x*x + y*y + z*z)
    }

    var length: Double {
      return sqrt(squaredLength)
    }

    var normalized: Vector {
      let theLength = length
      return Vector(
        x / theLength,
        y / theLength,
        z / theLength
      )
    }


    static func + (left: Vector, right: Vector) -> Vector {
      return Vector(left.x + right.x, left.y + right.y, left.z + right.z)
    }

    static func * (left: Vector, right: Vector) -> Vector {
      return Vector(left.x * right.x, left.y * right.y, left.z * right.z)
    }

    static func * (left: Double, right: Vector) -> Vector {
      return Vector(left * right.x, left * right.y, left * right.z)
    }

    static func * (left: Vector, right: Double) -> Vector {
      return right * left
    }

    static func - (left: Vector, right: Vector) -> Vector {
      return Vector(left.x - right.x, left.y - right.y, left.z - right.z)
    }

    func reflected(_ normal: Vector) -> Vector {
      return self - (2.0 * (self.dot(normal) * normal))
    }

    func cross(_ other: Vector) -> Vector {
      return Vector(
      (y * other.z) - (z * other.y),
      (z * other.x) - (x * other.z),
      (x * other.y) - (y * other.x)
      )
    }

    func dot(_ other: Vector) -> Double {
      return (x * other.x) + (y * other.y)  + (z * other.z)
    }

    static func random(distance: Double) -> Vector {
      let x = Double.random(in: 0..<distance) - (distance * 0.5)
      let y = Double.random(in: 0..<distance) - (distance * 0.5)
      let z = Double.random(in: 0..<distance) - (distance * 0.5)
      return Vector(x,y,z)
    }

    static var randomColor: Vector {
      let x = Double.random(in: 0..<1)
      let y = Double.random(in: 0..<1)
      let z = Double.random(in: 0..<1)
      return Vector(x,y,z)
    }

}
