import SwiftUI
import MapKit

struct ContentView: View {
    // Define a state variable to hold the coordinate region for the Map view
    @StateObject var locationManager = LocationManager()
    
    @StateObject private var viewModel = ContentViewModel()
    
    // Initialize the coordinate region to center on New York City

    
    var body: some View {
        // Use a ZStack to layer a Map view and a semi-transparent Color view
        ZStack {
            // Display a Map view using the region state variable, and ignore safe areas to extend to the edges of the screen
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                .ignoresSafeArea()
                .accentColor(Color(.systemPink))
            
            // Add a semi-transparent background color to the map
            Color(.systemBackground)
                .opacity(0.3)
        }
        // Set the color scheme to dark, and ignore safe areas to extend to the edges of the screen
        .colorScheme(.dark)
        .edgesIgnoringSafeArea(.all)
        
        // Use the onAppear modifier to customize the appearance of the map
        .onAppear {
            // Check if location services are enabled, and set the point-of-interest filter to exclude all points of interest
            viewModel.checkIfLocationServiceIsEnabled()
            MKMapView.appearance().pointOfInterestFilter = .excludingAll
            // Hide points of interest on the map
            MKMapView.appearance().pointOfInterestFilter = .excludingAll
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

final class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    var locationManager: CLLocationManager?
    
    func checkIfLocationServiceIsEnabled() {
        // Check if location services are enabled
        if CLLocationManager.locationServicesEnabled() {
            // Initialize the location manager and set the delegate to self
            locationManager = CLLocationManager()
            locationManager?.delegate = self
        } else {
            // Show an alert if location services are not enabled
            print("Show an alert")
        }
    }
    
    // Check the current authorization status for location services
    private func checkLocationAuthorization() {
        // Make sure the locationManager is not nil
        guard let locationManager = locationManager else { return }

        // Switch on the authorization status returned from the location manager
        switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestAlwaysAuthorization()
            case .restricted:
                print("Your location is restricted likely due to parental controls.")
            case .denied:
                print("You have denied Location Permission")
            case .authorizedAlways, .authorizedWhenInUse:
                region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
            @unknown default:
                break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // Call the checkLocationAuthorization function when the authorization status changes
        checkLocationAuthorization()
    }
}

