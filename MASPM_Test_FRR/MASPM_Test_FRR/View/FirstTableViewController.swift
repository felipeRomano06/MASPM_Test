//
//  FirstTableViewController.swift
//  MASPM_Test_FRR
//
//  Created by felipe romano on 23/09/20.
//  Copyright © 2020 felipe romano. All rights reserved.
//

import UIKit

class FirstTableViewController: UIViewController, transferirDatos {
    func transf(seccion1: [imageCell], seccion2: [simpleCell]) {
        seccion1SecondV = seccion1
        seccion2SecondV = seccion2
    }
    
    
    @IBOutlet weak var _navigationBar: UINavigationItem!
    @IBOutlet weak var Table: UITableView!
    @IBOutlet weak var _buttonModify: UIButton!
    
    //MARK: - VARIABLES GLOBALES
    
    var cellSelected = [IndexPath]()
    var cellSelectedBackUp = [IndexPath]()
    
    
    //-------------------------------------------------------------//
    //esto debe ir en el viewModels y ser llamado en el viewDidLoad
    //-------------------------------------------------------------//
    
    var seccion1SecondV: [imageCell] = [imageCell]()
    var seccion2SecondV: [simpleCell] = [simpleCell]()

    var seccion2 = [simpleCell.init(title: "Nombre", body: ""), simpleCell.init(title: "Teléfono", body: ""), simpleCell.init(title: "Fecha de nacimiento", body: ""), simpleCell.init(title: "Sexo", body: "")]
    
    var seccion1 = [imageCell.init(title:"Foto", body: "Foto recolectada desde camara"), imageCell.init(title:"Imagen",body:"imagen recolectada de una url")]
    //-------------------------------------------------//
    //-------------------------------------------------//
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Table.reloadData()
        if seccion1SecondV.isEmpty != true || seccion2SecondV.isEmpty != true {
            recuperaDatos()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if seccion1SecondV.isEmpty != true || seccion2SecondV.isEmpty != true {
            recuperaDatos()
        }
        Table.dataSource = self
        Table.delegate = self
        Table.register(UINib(nibName: "SimpleCostumCellTableViewCell", bundle: nil), forCellReuseIdentifier: "simpleCell")
        Table.register(UINib(nibName: "ImageCostumCellTableViewCell", bundle: nil), forCellReuseIdentifier: "imageCell")

        
        
        
    }
    
    func recuperaDatos () {
        for cell in seccion1SecondV {
            switch cell.title {
            case "Foto":
                seccion1[0].image = cell.image
                seccion1[0].body = "foto de galeria"
                
            case "Imagen":
                seccion1[1].image = cell.image
                seccion1[1].body = cell.body
            default:
                return
            }
        }
        for cell in seccion2SecondV {
            switch cell.title {
            case "Nombre":
                seccion2[0].body = cell.body
            case "Teléfono":
                seccion2[1].body = cell.body
            case "Fecha de nacimiento":
                seccion2[2].body = cell.body
            case "Sexo":
                seccion2[3].body = cell.body
                
            default:
                return
            }
        }
    }
    
    @IBAction func SegueToSecondView(_ sender: Any) {
        if cellSelected.count > 0{
            performSegue(withIdentifier: "SegueSecondView", sender: self)
        }else{
            
            let alert = UIAlertController(title: "Alerta", message: "Debes seleccionar al menos una celda", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let SecondView = segue.destination as? SecondTableViewController {
            SecondView.celltoModify = cellSelected.self
            SecondView.delegate = self
            
        }
    }
    
}










//MARK:- Extenciones

extension FirstTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return seccion1.count
        }
        
        return seccion2.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as? ImageCostumCellTableViewCell
            cell?._cellTitle.text = seccion1[indexPath.row].title
            cell?._cellBody.text = seccion1[indexPath.row].body
            cell?._cellImage.image = seccion1[indexPath.row].image
            
            return cell!
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "simpleCell", for: indexPath) as? SimpleCostumCellTableViewCell
        
        cell?._titulo.text = seccion2[indexPath.row].title
        cell?._body.text = seccion2[indexPath.row].body
        return cell!
    }
}

extension FirstTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
            cellSelectedBackUp = cellSelected
            for cell in 0 ... cellSelected.count-1 {
                
                if cellSelected[cell] == indexPath{  
                    cellSelectedBackUp.remove(at: cell)
                    break
                }
            }
            cellSelected.removeAll()
            cellSelected = cellSelectedBackUp
            
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
            cellSelected.append(indexPath)
        }
        cellSelected.sort()
        
    }
    
}
extension  UIImageView {
    func load2(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        
                    }
                }
            }
        }
    }
}
