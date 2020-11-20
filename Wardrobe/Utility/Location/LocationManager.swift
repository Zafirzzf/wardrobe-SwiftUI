//
//  LocationManager.swift
//  Aloha
//
//  Created by 周正飞 on 2019/4/4.
//  Copyright © 2019 Cuapp. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
import Combine

/// 获取位置周期间隔
private let periodInterval: TimeInterval = 60
/// 记录新位置的最小偏移
private let minLocationOffset = 0.0005

/// 位置信息管理类
class LocationManager: NSObject {

    static let shared = LocationManager()
    private let locationManager = CLLocationManager()
    
    var currentCoordinate: CurrentValueSubject<CLLocationCoordinate2D, LocationError> = .init(.init())
    lazy var authStatus: CurrentValueSubject<CLAuthorizationStatus, Never> = .init(locationManager.authorizationStatus)
    
    private var timer: Timer?
    private var lastEnterBackgroundTimestamp = CACurrentMediaTime()
    
    var hasPermission: Bool {
        return authStatus.value == .authorizedWhenInUse
    }
    
    override init() {
        super.init()
        startService()
    }
    
    private func startService() {
        setupManager()
        addNotificaiton()
        startPeriodObtainLocation()
    }

    private func setupManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }
    
    private func startPeriodObtainLocation() {
        guard timer == nil, hasPermission else {
            return
        }
        let timer = Timer(timeInterval: periodInterval, repeats: true) { [weak self] (_) in
            self?.obtainNewLocation()
        }
        RunLoop.main.add(timer, forMode: .common)
        timer.fire()
        self.timer = timer
    }
    
    private func stopObtainLocationTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func obtainNewLocation() {
        locationManager.startUpdatingLocation()
    }
}

// MARK: - 对外接口
extension LocationManager {
    
    /// 获取最新坐标
    func getNewestCoordinate() -> AnyPublisher<CLLocationCoordinate2D, Never> {
        obtainNewLocation()
        return currentCoordinate
            .dropFirst()
            .first()
            .timeout(5, scheduler: DispatchQueue.main)
            .replaceError(with: CLLocationCoordinate2D())
            .eraseToAnyPublisher()
    }

    func requestPermissionIfNeed() {
        locationManager.requestWhenInUseAuthorization()
    }
}

// MARK: - 通知监听
extension LocationManager {
    private func addNotificaiton() {
        NotificationCenter.default.addObserver(self, selector: #selector(enterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(enterBackGround), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    @objc
    private func enterForeground() {
        if CACurrentMediaTime() - lastEnterBackgroundTimestamp > periodInterval {
            obtainNewLocation()
        }
    }
    
    @objc
    private func enterBackGround() {
        lastEnterBackgroundTimestamp = CACurrentMediaTime()
    }
}

// MARK: - Location代理
extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let recentLocation = locations.last,
            locationIsValid(recentLocation) else {
                return
        }
        recordNewLocationIfNeed(new: recentLocation)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        guard let error = error as? CLError else {
            return
        }
        currentCoordinate.send(completion: .failure(.clError(error)))
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authStatus.send(status)
    }
    
    private func locationIsValid(_ location: CLLocation) -> Bool {
        guard location.coordinate.latitude != 0 && location.coordinate.longitude != 0,
            CLLocationCoordinate2DIsValid(location.coordinate) else {
                return false
        }
        return true
    }
    
    private func recordNewLocationIfNeed(new: CLLocation) {
        if currentCoordinate.value == .invalidValue || new.coordinate.maxDistance(of: currentCoordinate.value) > minLocationOffset {
            currentCoordinate.send(new.coordinate)
        }
    }
}

extension CLLocationCoordinate2D: Equatable {
    func maxDistance(of coordinate: CLLocationCoordinate2D) -> Double {
        return max(fabs(self.latitude - coordinate.latitude), fabs(self.longitude - coordinate.longitude))
    }
    
    public static func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
    
    static var invalidValue: CLLocationCoordinate2D { .init() }
}
