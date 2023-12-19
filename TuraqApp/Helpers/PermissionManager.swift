//
//  PermissionManager.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 03.05.2023.
//

import UIKit
import CoreLocation
import UserNotifications

class PermissionsManager {
    
    // MARK: - Location Permissions
    
    static func isLocationPermissionEnabled() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    
    static func requestLocationPermission(completion: @escaping (Bool) -> Void) {
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        completion(locationManager.authorizationStatus == .authorizedWhenInUse)
    }
    
    static func disableLocationPermission() {
        let locationManager = CLLocationManager()
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: - Notification Permissions
    
    static func isNotificationPermissionEnabled(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            let isEnabled = settings.authorizationStatus == .authorized
            completion(isEnabled)
        }
    }
    
    static func requestNotificationPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            completion(granted)
        }
    }
    
    static func disableNotificationPermission() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
