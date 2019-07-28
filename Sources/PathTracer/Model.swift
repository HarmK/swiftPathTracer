
struct Material {
  var albedo: Vector
  var emissive: Vector
}

struct Ray {
  var origin: Vector
  var direction: Vector

  func point(at distance: Double) -> Vector {
    return origin + direction * distance
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

  private func hit(ray: Ray, distance: Double) -> Hit {
    let hitPosition = ray.point(at: distance)
    let hitNormal = (hitPosition - position).normalized
    return Hit(sphere: self, position: hitPosition, normal: hitNormal, distance: distance)
  }

  func collide(with ray: Ray, minDistance: Double, maxDistance: Double) -> Hit? {

    let oc = ray.origin - position

    let a = ray.direction.dot(ray.direction)
    let b = 2.0 * oc.dot(ray.direction)
    let c = oc.dot(oc) - radius*radius

    let discriminator = b*b - 4*a*c

    guard discriminator > 0 else {
      return nil
    }

    let squardDisc = discriminator.squareRoot()

    let distance = (-b - squardDisc)

    if distance < maxDistance && distance > minDistance {
      return hit(ray: ray, distance: distance)
    } else {
      let distance = (-b + squardDisc)
      if distance < maxDistance && distance > minDistance {
          return hit(ray: ray, distance: distance)
      }
    }
    return nil
  }

}
