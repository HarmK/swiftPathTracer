
struct Material {
  var color: Vector
  var emmit: Double = 0.0
}

struct Ray {
  var origin: Vector
  var direction: Vector

  func pointAt(distance: Double) -> Vector {
    return origin + (direction * distance)
  }

}

struct Sphere {
  var material: Material
  var position: Vector
  var radius: Double

  var invRadius: Double {
    return 1.0 / radius
  }
}

struct Hit {
  var sphere: Sphere
  var position: Vector
  var normal: Vector
  var distance: Double
}

extension Sphere {

  func collide(with ray: Ray, minDistance: Double, maxDistance: Double) -> Hit? {

    let oc = ray.origin - position
    let a = dot(ray.direction, ray.direction)
    let b = dot(ray.direction, oc)
    let c = dot(oc, oc) - radius*radius
    let det = b*b - a*c
    let sqrDet = det.squareRoot()

    guard det >= 0.0 else {
      return nil
    }

    let rootClose = (-b - sqrDet) / a
    if (minDistance < rootClose) && (rootClose < maxDistance) {
      let hitPoint = ray.pointAt(distance: rootClose)
      return Hit(sphere: self, position: hitPoint,normal: (hitPoint-position)*invRadius, distance: rootClose)
    } else {
      // It's to solve the case when the camera is inside the sphere, I guess
      let rootFar = (-b + sqrDet) / a
      if (minDistance < rootFar) && (rootClose < rootFar) {
        let hitPoint = ray.pointAt(distance: rootFar)
        return Hit(sphere: self, position: hitPoint,normal: (hitPoint-position)*invRadius, distance: rootFar)
      } else {
        return nil
      }
    }
  }

}
