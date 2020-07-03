//
//  ViewController.swift
//  WeatherTest
//
//  Created by Alexey Horokhov on 30.06.2020.
//  Copyright © 2020 Alexey Horokhov. All rights reserved.
//

import UIKit
import Swinject
import RxSwift
import RxCocoa
import CoreLocation

final class ViewController: UIViewController, CLLocationManagerDelegate {

    fileprivate var disposeBag = DisposeBag()
    fileprivate var manager: Manager?
    fileprivate var locationManager: CLLocationManager?
    private let cityWeathersRelay: BehaviorRelay<CityWeather?> = BehaviorRelay(value: nil)

    @IBOutlet fileprivate weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        injectManager()
        configureLocationManager()
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled(){
            locationManager?.startUpdatingLocation()
        }
    }

    private func injectManager() {
        guard let manager = Assembler.defaultResolver.resolve(Manager.self) else { return }
        self.manager = manager
    }

    private func fetchData(for coordinates: [String: Double]) {
        manager?.fetchData(for: coordinates)
            .asDriver(onErrorJustReturn: nil)
            .drive(onNext: { [weak self] CityWeathers in
                guard let self = self, let events = CityWeathers else { return }
                self.cityWeathersRelay.accept(events)
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }

    private func getCurrentUserLocation() {
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            let coords = ["lon": 34.8, "lat": 50.92]
            fetchData(for: coords)
            return
        }
        
        let coords = ["lon": location.coordinate.longitude, "lat": location.coordinate.latitude]
        fetchData(for: coords)
    }

}

// MARK: UITableViewDataSource and UITableViewDelegate

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CityTableViewCell,
            let event = cityWeathersRelay.value else { return UITableViewCell() }
        cell.update(with: event)
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailsVC = UIStoryboard(name: "Details", bundle: nil)
            .instantiateViewController(withIdentifier: "details") as? DetailsViewController,
            let cityWeather = cityWeathersRelay.value else { return }

        detailsVC.update(with: cityWeather)
        navigationController?.pushViewController(detailsVC, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
