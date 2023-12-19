//  Created by Akyl on 28.02.2023.

import UIKit
import GoogleMaps

protocol MainDisplayLogic: AnyObject {
    func displayParkings(_ viewModel: MainFlow.Something.ViewModel)
    func displaySelectedParkingStatus()
    func displaySelectedParking()
}

final class MainViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var interactor: MainBusinessLogic?
    var router: (MainRoutingLogic & MainDataPassing)?
    
    var mapView: GMSMapView!
    
    // MARK: - Private Properties
    
    private lazy var menuButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "menu_button"), for: .normal)
        button.addTarget(self, action: #selector(menuDidTap), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var userLocationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "userLocation_button_icon"), for: .normal)
        button.addTarget(self, action: #selector(userLocationDidTap), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - Private Methods

private extension MainViewController {
    
    func configure() {
        configureMap()
        configureMenuButton()
        configureUserLocationButton()
        getParkings()
    }
    
    func getParkings() {
        interactor?.getParkings()
    }
    
    func configureMap() {
        let mapID = GMSMapID(identifier: "f1d3134ce7c61b50")
        let camera = GMSCameraPosition.camera(withLatitude: 43.227041, longitude: 76.908877, zoom: 16.0)
        let mapView = GMSMapView(frame: self.view.frame, mapID: mapID, camera: camera)
        view = mapView
        
        self.mapView = mapView
        mapView.delegate = self
        
        mapView.isMyLocationEnabled = true
        
        mapView.settings.allowScrollGesturesDuringRotateOrZoom = false
        mapView.settings.tiltGestures = false
        mapView.settings.rotateGestures = false
        
        let bostandykPath = GMSMutablePath()
        RegionCoordinates.bostandykCoordinates.forEach { bostandykPath.add($0) }
        let bostandykRegion = GMSPolyline(path: bostandykPath)
        bostandykRegion.strokeWidth = 1.6
        bostandykRegion.strokeColor = .middleBlue
        bostandykRegion.map = mapView
        let bostandykPolygon = GMSPolygon(path: bostandykPath)
        bostandykPolygon.fillColor = UIColor.middleBlue.withAlphaComponent(0.25)
        bostandykPolygon.strokeWidth = 0.0
        bostandykPolygon.map = mapView
        
        let auezovPath = GMSMutablePath()
        RegionCoordinates.auezovCoordinates.forEach { auezovPath.add($0) }
        let auezovRegion = GMSPolyline(path: auezovPath)
        auezovRegion.strokeWidth = 1.6
        auezovRegion.strokeColor = .middleBlue
        auezovRegion.map = mapView
        let auezovPolygon = GMSPolygon(path: auezovPath)
        auezovPolygon.fillColor = UIColor.middleBlue.withAlphaComponent(0.25)
        auezovPolygon.strokeWidth = 0.0
        auezovPolygon.map = mapView
        
        let zhetisuPath = GMSMutablePath()
        RegionCoordinates.zhetisu.forEach { zhetisuPath.add($0) }
        let zhetisuRegion = GMSPolyline(path: zhetisuPath)
        zhetisuRegion.strokeWidth = 1.6
        zhetisuRegion.strokeColor = .middleBlue
        zhetisuRegion.map = mapView
        let zhetisuPolygon = GMSPolygon(path: zhetisuPath)
        zhetisuPolygon.fillColor = UIColor.middleBlue.withAlphaComponent(0.25)
        zhetisuPolygon.strokeWidth = 0.0
        zhetisuPolygon.map = mapView
        
        let alatauPath = GMSMutablePath()
        RegionCoordinates.alatauski.forEach { alatauPath.add($0) }
        let alatauRegion = GMSPolyline(path: alatauPath)
        alatauRegion.strokeWidth = 1.6
        alatauRegion.strokeColor = .middleBlue
        alatauRegion.map = mapView
        let alatauPolygon = GMSPolygon(path: alatauPath)
        alatauPolygon.fillColor = UIColor.middleBlue.withAlphaComponent(0.25)
        alatauPolygon.strokeWidth = 0.0
        alatauPolygon.map = mapView
        
        let almalinPath = GMSMutablePath()
        RegionCoordinates.almalinskiy.forEach { almalinPath.add($0) }
        let almalinRegion = GMSPolyline(path: almalinPath)
        almalinRegion.strokeWidth = 1.6
        almalinRegion.strokeColor = .middleBlue
        almalinRegion.map = mapView
        let almalinPolygon = GMSPolygon(path: almalinPath)
        almalinPolygon.fillColor = UIColor.middleBlue.withAlphaComponent(0.25)
        almalinPolygon.strokeWidth = 0.0
        almalinPolygon.map = mapView
        
        let nauryzbaiPath = GMSMutablePath()
        RegionCoordinates.nauryzbayski.forEach { nauryzbaiPath.add($0) }
        let nauryzbayRegion = GMSPolyline(path: nauryzbaiPath)
        nauryzbayRegion.strokeWidth = 1.6
        nauryzbayRegion.strokeColor = .middleBlue
        nauryzbayRegion.map = mapView
        let nauryzbayPolygon = GMSPolygon(path: nauryzbaiPath)
        nauryzbayPolygon.fillColor = UIColor.middleBlue.withAlphaComponent(0.25)
        nauryzbayPolygon.strokeWidth = 0.0
        nauryzbayPolygon.map = mapView
        
        let medeuPath = GMSMutablePath()
        RegionCoordinates.medeuskiy.forEach { medeuPath.add($0) }
        let medeuRegion = GMSPolyline(path: medeuPath)
        medeuRegion.strokeWidth = 1.6
        medeuRegion.strokeColor = .middleBlue
        medeuRegion.map = mapView
        let medeuPolygon = GMSPolygon(path: medeuPath)
        medeuPolygon.fillColor = UIColor.middleBlue.withAlphaComponent(0.25)
        medeuPolygon.strokeWidth = 0.0
        medeuPolygon.map = mapView
    }
    
    func configureMenuButton() {
        view.addSubview(menuButton)
        menuButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).offset(-56)
            make.leading.equalToSuperview().offset(32)
            make.size.equalTo(48)
        }
    }
    
    func configureUserLocationButton() {
        view.addSubview(userLocationButton)
        userLocationButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).offset(-56)
            make.trailing.equalToSuperview().offset(-32)
            make.size.equalTo(48)
        }
    }
}

// MARK: - UI Actions

private extension MainViewController {
    
    @objc
    func menuDidTap() {
        router?.routeToMenu()
    }
    
    @objc
    func userLocationDidTap() {
        guard let lat = self.mapView.myLocation?.coordinate.latitude,
              let lng = self.mapView.myLocation?.coordinate.longitude else {
            return
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: 16)
        self.mapView.animate(to: camera)
    }
}

// MARK: - Display Logic

extension MainViewController: MainDisplayLogic {
    
    func displaySelectedParkingStatus() {
        router?.routeToParkingStatus()
    }
    
    func displaySelectedParking() {
        router?.routeToParking()
    }
    
    func displayParkings(_ viewModel: MainFlow.Something.ViewModel) {
        for parking in viewModel.parkings {
            router?.dataStore?.parkings[createPickupPointMarker(with: parking.coordinates)] = parking
        }
    }
}

extension MainViewController: GMSMapViewDelegate {
    
    func createPickupPointMarker(with coordinate: CLLocationCoordinate2D) -> GMSMarker { //
        let parkingMarker = GMSMarker(position: coordinate)
        parkingMarker.icon = UIImage(named: "parking_icon")
        parkingMarker.map = mapView
        return parkingMarker
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        guard let selectedParking = router?.dataStore?.parkings[marker] else {
            return false
        }
        router?.dataStore?.selectedParking = selectedParking
        let request = MainFlow.Status.Request(parkingId: selectedParking.id)
        interactor?.getParkingStatus(request)
        return true
    }
}

extension MainViewController: ParkingViewControllerDelegate, ParkingStateViewControllerDelegate {
    
    func parkingStateViewControllerDelegateSuccessfullParking(_ vc: ParkingStateViewController, _ parkingId: Int) {
        let request = MainFlow.Status.Request(parkingId: parkingId)
        interactor?.getParkingStatus(request)
    }
    
    func parkingViewControllerDelegateSuccessfullyAtParking(_ vc: ParkingViewController, _ parkingId: Int) {
        let request = MainFlow.Status.Request(parkingId: parkingId)
        interactor?.getParkingStatus(request)
    }
}
