//
//  File.swift
//  
//
//  Created by Jose Luis Perez Reyes on 03/05/21.
//

import Foundation

final class FWPerformanceMetrics{
    private var performanceMetrics: [String: HTTPMetric] = [:]
    private var queue = DispatchQueue(label: "performanceMetrics.queue", attributes: .concurrent)
    
    func getMetric(of key:String) -> HTTPMetric?{
        return queue.sync {
            self.performanceMetrics[key]
        }
    }
    
    func setMetricWith(key name:String, metric:HTTPMetric){
        queue.sync(flags: .barrier) {
            self.performanceMetrics[name] = metric
        }
    }
    
    func removeValue(forKey key:String) {
        _ = queue.sync(flags: .barrier) {
            self.performanceMetrics.removeValue(forKey: key)
        }
    }
}

public class FWPerformanceTracker : NSObject {
    public var dicTraceObjects : Dictionary <String, Trace>?
    
    //MARK: - SINGLETON
    public static let obtainInstance: BDMPerformanceTracker = {
        let instance = BDMPerformanceTracker()
        instance.dicTraceObjects = Dictionary()
        return instance
    }()
    
    public func startTrackingFlow(traceName:String) {
        if  let path = Bundle.main.path(forResource: "PerformanceTrackNames", ofType: "plist"),
            let dicTraceNames : NSDictionary = NSDictionary.init(contentsOfFile: path) {
            let _ : String = (dicTraceNames.value(forKey: traceName) as! String)
//                if let traceToTrack = Performance.startTrace(name: sTraceName) {
//                    dicTraceObjects?[traceName] = traceToTrack
//                }
        }
    }
    
    public func stopTrackingFlow(traceName:String) {
        if let traceToStop = dicTraceObjects?[traceName] {
            traceToStop.stop()
            dicTraceObjects?.removeValue(forKey:traceName)
        }
    }
    
    public func addMetric(metricName:String, to traceName:String) {
        if let traceToAddMetric = dicTraceObjects?[traceName] {
            traceToAddMetric.incrementMetric(metricName, by: 1)
        }
    }
    
    public func startTrackingFlow(vcName:String) {
        let sTraceName : String = String.init(format: "custom_screen_%@", vcName)
        if let trace : Trace = Performance.startTrace(name: sTraceName) {
            dicTraceObjects?[vcName] = trace
        }
    }
    
    public func stopTrackingFlow(vcName:String) {
        let sTraceName : String = String.init(format: "custom_screen_%@", vcName)
        self.stopTrackingFlow(traceName: sTraceName)
    }
    
    public func stopTrackingAllFlows() {
        if let dicKeys = dicTraceObjects?.keys, dicKeys.count > 0 {
            for sTraceName in (dicTraceObjects?.keys)! {
                self.stopTrackingFlow(traceName: sTraceName)
            }
        }
    }
}
