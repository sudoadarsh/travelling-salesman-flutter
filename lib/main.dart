import 'package:open_route_service/open_route_service.dart';

///This example uses open_route_service package to achieve
///route optimisation. Follow steps 1 to 7.

/// 6. List of jobs, pass the coordinates of delivery sites here
List<VroomJob> jobs = [
  const VroomJob(
    id: 1,
    location: ORSCoordinate(latitude: 37.426, longitude: 49.22619),
  ),
  const VroomJob(
    id: 2,
    location: ORSCoordinate(latitude: 37.43, longitude: 48.61128),
  ),
  const VroomJob(
    id: 3,
    location: ORSCoordinate(latitude: 38.43, longitude: 47.61128),
  ),
  const VroomJob(
    id: 4,
    location: ORSCoordinate(latitude: 39.43, longitude: 46.61128),
  ),
];

/// 7. List of vehicles, we will pass only one vehicle as that's our requirement.
/// The start coordinates must be an coordinate from the Job list otherwise
/// Un-found route(s) from location [x;y] Code: 500 will be thrown.
List<VroomVehicle> vehicles = [
  const VroomVehicle(
      id: 1,
      profile: "driving-car",
      start: ORSCoordinate(latitude: 37.426, longitude: 49.22619),
  )
];

void main() async {
  /// 1. You will have to generate an API key by logging into the open route
  /// service website.
  /// the token generated is
  String token = 'some token';

  /// 2. Initialise the open route service with your api key
  final OpenRouteService client = OpenRouteService(apiKey: token);

  /// 3. Use the method [optimizationDataPost] to obtain the optimised routes.
  /// It takes in various parameters but we will mostly be concerned with [jobs]
  /// and [vehicles].
  OptimizationData optimizationData = await client.optimizationDataPost(
    /// 4. Takes List<VroomJob>, the VroomJob data model class is predefined in
    /// the package.
    jobs: jobs,
    /// 5. Takes List<VroomVehicle>.
    vehicles: vehicles,
  );

 List<OptimizationRoute> data= optimizationData.routes;
 for (var element in data) {
   element.steps?.forEach((element) {
     print(element.location);
   });
 }

 ///output
  // {latitude: 37.426, longitude: 49.22619, altitude: 0.0}
  // {latitude: 37.426, longitude: 49.22619, altitude: 0.0}
  // {latitude: 37.43, longitude: 48.61128, altitude: 0.0}
  // {latitude: 38.43, longitude: 47.61128, altitude: 0.0}
  // {latitude: 39.43, longitude: 46.61128, altitude: 0.0}
}
