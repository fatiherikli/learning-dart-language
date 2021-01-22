// > POST /api/dartservices/v2/compile HTTP/1.1
// > Host: v1.api.dartpad.dev
// > User-Agent: curl/7.64.1
// > Accept: */*
// > Connection: keep-alive

import 'dart:async';
import 'dart:math' show Random;

main() async {
  print('Compute PI using https://en.wikipedia.org/wiki/Monte_Carlo_method');
  await for (var estimate in computePi().take(5)) {
    print(estimate);
  }
}



Stream<double> computePi({int batch: 100000}) async* {
  var total = 0;
  var count = 0;
  while (true) {
    var points = generateRandom().take(batch);
    var inside = points.where((p) => p.isInsideUnitCircle);
    total += batch;
    count += inside.length;
    var ratio = count / total;
    yield ratio * 4;
  }
}



Iterable<Point> generateRandom([int seed]) sync* {
  final random = Random(seed);
  while (true) {
    yield Point(random.nextDouble(), random.nextDouble());
  }
}


class Point {
  final double x, y;
  const Point(this.x, this.y);
  bool get isInsideUnitCircle => x * x + y * y <= 1;
}

// < STDOUT
