//
//  File.swift
//  
//
//  Created by Jose Luis Perez Reyes on 03/05/21.
//

import Foundation
import Foundation
/**
 
 Define the entrance for the different flows for tagging events

    - case messageCenter:          "CN" - Centro de mensajes
    - case extendedMessage:        "ME" - Mensaje Extendido (Centro de mensajes)
    - case modal:                  "MD" - Medio Modal
    - case pushNotification:       "NP" - Notificaciones push
    - case prodDashboardBanner:    "BN"
    - case longPress:              "LP"
    - case floatinButton:          "FL" - Botones flotantes
    - case operationsMenu:         "MO" - Menu de operaciones
    - case loginAccess:            "LG" - Pantalla de login
    - case directAccess:           "AD"
    - case widget:                 "WD" - Widgets
    - case newFunctions:           "ND"
    - case finantial:              "FN" - Mis finanzas (apagado)
    - productsCarrousel:           "CA" - Carrousel de productos para ti
    - productsCards:               "CD" - Cards Sumary
    - siriVoice:                   "SV" - Siri
    - case generic:                "GN" - Se envia por defecto cuando no esta definida la entrada
    - case prodDashboardStatic:    "BF"
    - case cFTWExist:              "EX"
    - case cFTWNew:                "NU"
    - case deepLink:               "DL" - Entradas desde urls externas que invocan la aplicación (URLTypes)
    - case settings:                "AJ" - Entradas desde tab de ajustes de la aplicación
 
 - Returns: An String describing the current flow entrance defined for tagging current event
 */
public enum enumFlowEntrance: String{
    case messageCenter       = "CN"
    case extendedMessage     = "ME"
    case modal               = "MD"
    case pushNotification    = "NP"
    case longPress           = "LP"
    case floatingButton      = "FL"
    case operationsMenu      = "MO"
    case loginAccess         = "LG"
    case directAccess        = "AD"
    case widget              = "WD"
    case newFuntions         = "NF"
    case finantial           = "FN"
    case productsCarrousel   = "CA"
    case productCards        = "CD"
    case siriVoice           = "SV"
    case generic             = "GN"
    case prodDashboardStatic = "BF"
    case cFTWExist           = "EX"
    case cFTWNew             = "NU"
    case deepLink            = "DL"
    case settings            = "AJ"
    
    init?(value: String?) {
        guard let value = value else { return nil }
        self.init(rawValue: value)
    }
}

class FWAnalitycsHelper: NSObject {

    public static var flowEntrance : enumFlowEntrance = .generic

    class func tagging(event strEvent : String?, category strCategory : String?, subcategory strSubcategory : String? = nil, step strStep : String?,
                       errorType strErrorType : String? = nil,
                       errorDescription strErrorDescription : String? = nil,
                       field strField : String? = nil,
                       flowEntrance : enumFlowEntrance? = nil,
                       strTerm : String? = nil,
                       strAmount : String? = nil,
                       strInstruction : String? = nil,
                       strRate : String? = nil,
                       strFolio : String? = nil,
                       strIssuer : String? = nil,
                       strAdviser : String? = nil,
                       strDate : String? = nil,
                       strCreditOrigin : String? = nil,
                       dctOptionalValues : [String: Any]? = nil,
                       commerce : String? = nil) {
        
        var dctParameters : [String : Any] = [:]
        
        if let strCategory = strCategory {
            if (!strCategory.isEmpty) {
                dctParameters["Category"] = strCategory
            }
        }
        
        if let strSubcategory = strSubcategory {
            dctParameters["Sub_Category"] = strSubcategory
        }
        
        if let strStep = strStep {
            if (!strStep.isEmpty) {
                dctParameters["Step"] = strStep
            }
        }
        
        if let strField = strField {
            if (!strField.isEmpty) {
                dctParameters["field"] = strField
            }
        }
        
        if let strErrorType = strErrorType {
            if (!strErrorType.isEmpty) {
                dctParameters["error_type"] = strErrorType
            }
        }
        
        if let strErrorDescription = strErrorDescription {
            if (!strErrorDescription.isEmpty) {
                dctParameters["error_desc"] = strErrorDescription
            }
        }
        
      /*  if let strUser = //Singleton reference NameUser {
            if (!strUser.isEmpty) {
                dctParameters["idClient"] = strUser
            }
        }*/
        
       /* if let strCU = //Singleton CU {
            if (!strCU.isEmpty){
                dctParameters["cu"] = strCU
            }
        }
        */
       /* if let strClientLevel = // Singleton typeClient {
            if (!strClientLevel.isEmpty){
                dctParameters["tipo_cliente"] = strClientLevel
            }
        }*/
        
        if let flowEntrance = flowEntrance{
            dctParameters["input"] = flowEntrance.rawValue
        }else{
            dctParameters["input"] = self.flowEntrance.rawValue
        }
        
        if let strTerm = strTerm{
            if (!strTerm.isEmpty){
                dctParameters["term"] = strTerm
            }
        }
        
        if let strAmount = strAmount{
            if (!strAmount.isEmpty){
                dctParameters["amount"] = strAmount
            }
        }
        
        if let strInstruction = strInstruction{
            if (!strInstruction.isEmpty){
                dctParameters["instruction"] = strInstruction
            }
        }
        
        if let strRate = strRate{
            if (!strRate.isEmpty){
                dctParameters["rate"] = strRate
            }
        }
        
        if let strFolio = strFolio {
            if (!strFolio.isEmpty){
                dctParameters["folio"] = strFolio
            }
        }
        
        if let strIssuer = strIssuer {
            if (!strIssuer.isEmpty){
                dctParameters["transmitter"] = strIssuer
            }
        }
    
        
        if let strAdviser = strAdviser {
            if (!strAdviser.isEmpty){
                dctParameters["asesor"] = strAdviser
            }
        }
        
        if let strDate = strDate {
            if (!strDate.isEmpty){
                dctParameters["date"] = strDate
            }
        }
        
        if let dctOptionalValues = dctOptionalValues {
            dctParameters.merge(dctOptionalValues) { (current, _) in current }
        }
        
        if let strCreditOrigin = strCreditOrigin {
            if (!strCreditOrigin.isEmpty){
                dctParameters["origin"] = strCreditOrigin
            }
        }
        
        if let commerce = commerce {
            if (!commerce.isEmpty){
                dctParameters["commerce"] = commerce
            }
        }

        if let strEvent = strEvent {
            if (!strEvent.isEmpty) {
                Analytics.logEvent(strEvent, parameters: dctParameters)
            }
        }
    }
}
