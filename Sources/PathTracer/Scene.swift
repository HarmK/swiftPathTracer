
extension Ray {

  var sky: Vector {
    let magnitude = direction.dot(Vector(0,1,0))
    return Vector(magnitude, magnitude, magnitude)
  }

}

struct Scene {

  var rays: [[Ray]]
  var spheres: [Sphere]

  init(camera: Vector, width: Int, height: Int) {

    spheres = (0..<25).map { _ in
      let material = Material(albedo: .randomColor, emissive: .black)
      let radius = Double.random(in: 10..<150)
       let position = Vector.random(distance: 500.0)
       return Sphere(material: material, position: position, radius: radius)
    }

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
      $0.collide(with: ray, minDistance: 0.0, maxDistance: .greatestFiniteMagnitude)
    }.sorted(by: { first, second in
      return first.distance < second.distance
    })
    return hits.first
  }

  func render(ray: Ray) -> Vector {
    guard let hit = trace(ray: ray) else {
      return ray.sky
    }
    return hit.sphere.material.albedo
  }

  func render() -> [[Vector]] {
    return rays.map { row in
      return row.map { render(ray: $0) }
    }
  }

}
