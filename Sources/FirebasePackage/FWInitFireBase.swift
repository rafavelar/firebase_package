//
//  File.swift
//  
//
//  Created by Jose Luis Perez Reyes on 30/04/21.
//
import Foundation
import FirebaseApp
public class FireBaseHelper: NSObject{
    public func loadIniFirebase(){
        FirebaseApp.initialize()
        print("InitFireBase")
    }
}
