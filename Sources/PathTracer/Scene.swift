

struct Scene {

  func mix(_ u: Vector, _ v: Vector, _ alpha: Double) -> Vector {
      return (1.0 - alpha)*u + alpha*v
  }

  func backgroundColor(ray: Ray) -> Vector {
    let unitDir = ray.direction.normalized
    let t = 0.5 * (unitDir.y + 1.0)
    let white = Vector(1.0, 1.0, 1.0)
    let blue = Vector(0.5, 0.7, 1.0)
    return mix(white, blue, t)
}


func randomMinus1Plus1() -> Double {
    return 2.0 * Double.random(in: 0...1) - 1.0
}

func randomPointInsideUnitSphere() -> Vector {
    let radius = Double.random(in: 0...1)
    return radius * Vector(randomMinus1Plus1(), randomMinus1Plus1(), randomMinus1Plus1()).normalized
}

  var rays: [[Ray]]
  var spheres: [Sphere]

  init(camera: Vector, width: Int, height: Int) {

    spheres = []

    spheres = (0..<10).map { _ in
      let material = Material(color: .randomColor * 0.5, emmit: 0)
      let radius = Double.random(in: 40..<50)
       let position = Vector.random(distance: 300.0)
       return Sphere(material: material, position: position, radius: radius)
    }

    //spheres.append(Sphere(material: .plain, position: Vector(0,100,0), radius: 50))
    spheres.append(Sphere(material: .plain, position: Vector(0,0,0), radius: 50))
    spheres.append(Sphere(material: .plain, position: Vector(0,-100,0), radius: 50))
    spheres.append(Sphere(material: .plain, position: Vector(0,100000,0), radius: 99900))


    //create screen points
    let screenPoints: [[Double]] = (0..<width).map { _ in
      return (0..<height).map { Double($0)}
    }

    //create rays
    rays = screenPoints.enumerated().map { y,line in
      return line.map { x in
        let dx = Double(x) - Double(width) / 2
        let dy = Double(y) - Double(height) / 2

        let position = Vector(dx, dy, 0)
        // + Vector.random(distance: 0.5)
        let direction = ( position - camera ).normalized
        return Ray(origin: camera, direction: direction)
      }
    }
  }

  func trace(ray: Ray) -> Hit? {
    let hits = spheres.compactMap {
      $0.collide(with: ray, minDistance: 0, maxDistance: .greatestFiniteMagnitude)
    }.sorted(by: { first, second in
      return first.distance < second.distance
    })
    return hits.first
  }

  func recursiveRender(ray: Ray, depth: Int) -> Vector {
    let newDepth = depth - 1
    guard newDepth > 0 else {
      return backgroundColor(ray: ray)
    }

    guard let hit = trace(ray: ray) else {
      return backgroundColor(ray: ray)
    }

    let target = hit.position + hit.normal + randomPointInsideUnitSphere()
    let bounceDirection = target - hit.position
    let bounceRay = Ray(origin: hit.position , direction: bounceDirection)

    let bounceColor = recursiveRender(ray: bounceRay,depth: newDepth)

    return hit.sphere.material.color * bounceColor
  }

  func render(ray: Ray) -> Vector {
    return recursiveRender(ray: ray, depth: 4)
  }

  let samples = 16

  func render() -> [[Vector]] {
    return rays.map { row in
      return row.map { ray in
        //sample n times
        return (0..<samples).reduce(Vector()) { result, sample in
          return result + render(ray: ray)
        } * (1.0 / Double(samples))
      }
    }
  }

}

//Vector(x: 0.026492794208832195, y: 0.10155571113385675, z: -0.9944770331139403),
// bounce: Vector(x: 0.9057585298575315, y: 0.25436307203304404, z: -0.3389703721215701)
