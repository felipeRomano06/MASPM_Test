//
//  List.swift
//  MASPM_Test_FRR
//
//  Created by felipe romano on 23/09/20.
//  Copyright © 2020 felipe romano. All rights reserved.
//

import Foundation
import UIKit

struct simpleCell {
    let title: String
    var body: String?
    var respondio: Bool?
}

struct imageCell {
    let title: String
    var image: UIImage?
    var body: String?
    var respondio: Bool?
}

class Tabla {
    var celdasSimple: [simpleCell] = [simpleCell]()
    var celdasImagen: [imageCell] = [imageCell]()
    
    func dataDefine (modify: [IndexPath]) {
        
        for cell in modify {
            if cell.section == 0{
                switch cell.row {
                case 0:
                    self.celdasImagen.append(imageCell.init(title: "Foto", image: nil, body: nil))
                case 1:
                    self.celdasImagen.append(imageCell.init(title: "Imagen", image: nil, body: "escribe una Url.png"))
                default:
                    return
                }
            }else {
                switch cell.row {
                case 0:
                    self.celdasSimple.append(simpleCell.init(title: "Nombre", body: "Escribe aquí tu nombre"))
                case 1:
                    self.celdasSimple.append(simpleCell.init(title: "Teléfono", body: "Escribe tu teléfono"))
                case 2:
                    self.celdasSimple.append(simpleCell.init(title: "Fecha de nacimiento", body: "Ingresa tu fecha de naciemiento"))
                case 3:
                    self.celdasSimple.append(simpleCell.init(title: "Sexo", body: "Escribe tu sexo"))
                default:
                    return
                }
            }
        }
        
    }
    
    func save ( foto : [UIImage], _url: String, imagenURL: [UIImageView], valorNombre: String, valorTelefono: String, valorFecha: String, valorSexo: String ) {
        
        if self.celdasImagen.count > 0 {
            
            var copiaSeccion1 = self.celdasImagen
            var contador1 = 0
            for cell in self.celdasImagen {
                switch cell.title {
                case "Foto":
                    if foto.isEmpty != true{
                        copiaSeccion1[contador1].image = foto.first
                        copiaSeccion1[contador1].body = "Foto de galeria"
                        copiaSeccion1[contador1].respondio = true
                    }else{
                        copiaSeccion1[contador1].respondio = false
                    }
                case "Imagen":
                    if _url.isEmpty != true {
                        copiaSeccion1[contador1].image = imagenURL.first?.image
                        copiaSeccion1[contador1].body = _url
                        copiaSeccion1[contador1].respondio = true
                    }else {
                        copiaSeccion1[contador1].respondio = false
                    }
                default:
                    return
                }
                contador1 += 1
            }
            
            self.celdasImagen = copiaSeccion1
        
        }
        
        if self.celdasSimple.count > 0 {
            var copiaSeccion2 = self.celdasSimple
            var contador2 = 0
            
            for cell in self.celdasSimple {
                switch cell.title {
                case "Nombre":
                    if valorNombre.isEmpty != true {
                        copiaSeccion2[contador2].body = valorNombre
                        copiaSeccion2[contador2].respondio = true
                    }else{
                        copiaSeccion2[contador2].respondio = false
                    }
                
                case "Teléfono":
                    if valorTelefono.isEmpty != true {
                        copiaSeccion2[contador2].body = valorTelefono
                        copiaSeccion2[contador2].respondio = true
                    }else {
                        copiaSeccion2[contador2].respondio = false
                    }
                case "Fecha de nacimiento":
                    if valorFecha.isEmpty != true {
                        copiaSeccion2[contador2].body = valorFecha
                        copiaSeccion2[contador2].respondio = true
                    }else{
                        copiaSeccion2[contador2].respondio = false
                    }
                case "Sexo":
                    if valorSexo.isEmpty != true {
                        copiaSeccion2[contador2].body = valorSexo
                        copiaSeccion2[contador2].respondio = true
                    }else{
                        copiaSeccion2[contador2].respondio = false
                    }
                    
                default:
                    return
                }
                
                contador2 += 1
            }
            
            self.celdasSimple = copiaSeccion2
        }
    }
    
    func validaCampos()-> Bool{
        if self.celdasImagen.isEmpty != true && self.celdasSimple.isEmpty != true {
            
            if self.celdasSimple.contains(where: { (simpleCell) -> Bool in simpleCell.respondio == false}) == true || self.celdasImagen.contains(where: { (imageCell) -> Bool in imageCell.respondio == false}) == true {
                //errorCampos()
                return false
            }else {
                //segueFirstView()
                return true
            }
        }else {
            if self.celdasImagen.isEmpty != true {
                if self.celdasImagen.contains(where: { (imageCell) -> Bool in imageCell.respondio == false }) == true {
                    //errorCampos()
                    return false
                }else{
                    //segueFirstView()
                    return true
                }
            }else {
                if self.celdasSimple.contains(where: { (simpleCell) -> Bool in simpleCell.respondio == false }) == true {
                    //errorCampos()
                    return false
                }else {
                    // segueFirstView()
                    return true
                }
            }
        }
    }
}
