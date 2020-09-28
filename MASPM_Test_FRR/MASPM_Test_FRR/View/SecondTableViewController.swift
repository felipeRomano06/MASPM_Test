//
//  SecondTableViewController.swift
//  MASPM_Test_FRR
//
//  Created by felipe romano on 26/09/20.
//  Copyright © 2020 felipe romano. All rights reserved.
//

import UIKit

protocol transferirDatos {
    func transf(seccion1: [imageCell], seccion2: [simpleCell])
}

class SecondTableViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var _table: UITableView!
    @IBOutlet weak var _buttonListo: UIButton!
    
    var delegate: transferirDatos?
    var datePicker = UIDatePicker()
    var celltoModify = [IndexPath]()
    var seccion1Objeto:[imageCell] = [imageCell]()
    var seccion2Objeto:[simpleCell] = [simpleCell]()
    var imagePiker: UIImagePickerController = UIImagePickerController()
    var valorActual: String = ""
    var valorNombre = ""
    var valorFecha = ""
    var valorTelefono = ""
    var valorSexo = ""
    var _url = ""
    var imagenURL: [UIImageView] = [UIImageView]()
    var fotoImagen: [UIImageView] = [UIImageView]()
    var foto: [UIImage] = [UIImage]()
    var imagen: [UIImage] = [UIImage]()
    var dataPickerTxt: [UITextField] = [UITextField]()
    var arrayTextField: [UITextField] = [UITextField]()
    var ViewPickerTxt: [UITextField] = [UITextField]()
    var arrayInt:[Int] = [Int]()
    var pickerView = UIPickerView()
    let arraySexo = ["","Hombre","Mujer"]
    var tablaClase = Tabla()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _table.dataSource = self
        _table.delegate = self
        imagePiker.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        tablaClase.dataDefine(modify: celltoModify)
        establecerTable()
        _table.tableFooterView = UIView()
        
    }
    // crea las celdas costum
    func establecerTable () {
        
        _table.register(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "imageCell")
        _table.register(UINib(nibName: "NameTableViewCell", bundle: nil), forCellReuseIdentifier: "nameCell")
    }
    
    //funcion para crear un DatePicker
    func creatDatePiker(text: UITextField) {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolBar.setItems([doneBtn], animated: true)
        text.inputAccessoryView = toolBar
        text.inputView = datePicker
        datePicker.datePickerMode = .date
    }
    
    // funcion para esconder UIDatePicker
    @objc func donePressed(){
        let formater = DateFormatter()
        formater.dateStyle = .medium
        formater.timeStyle = .none
        valorFecha = formater.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    // funcion para obtener la foto desde camara o desde la memoria
    @objc func buttonFoto(_ sender:UIButton!) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            if (UIImagePickerController.availableCaptureModes(for: .rear) != nil){
                imagePiker.allowsEditing = false
                imagePiker.sourceType = .camera
                imagePiker.cameraCaptureMode = .photo
                
                present(imagePiker, animated: true, completion: nil)
            }
        }else {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                imagePiker.allowsEditing = false
                imagePiker.sourceType = .photoLibrary
               
                present(imagePiker, animated: true, completion: nil)
            }
        }
    }
    
    // funcion cuando se presiona el boton de modificar
    @IBAction func buttonReady(_ sender: Any) {
        self.view.endEditing(true)
        // metodo para salvar los datos
        tablaClase.save(foto: foto, _url: _url, imagenURL: imagenURL, valorNombre: valorNombre, valorTelefono: valorTelefono, valorFecha: valorFecha, valorSexo: valorSexo)
        //metodo para validar los campos, devueve un Bool
        if tablaClase.validaCampos() {
            segueFirstView()
        }else{
            errorCampos()
        }
        
    }
    
    // MARK: - funciones para esconder el kayboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
    }
    
    //MARK:- Utilities
    // estas dos funciones podrian ir en la clase de Utilities
    // funcion para regresar a la vista anterior con todos los datos nuevos
    func segueFirstView (){
        delegate?.transf(seccion1: tablaClase.celdasImagen, seccion2: tablaClase.celdasSimple)

        self.navigationController?.popViewController(animated: true)
    }
    // muestra modal para indicar que falta datos
    func errorCampos(){
        let alert = UIAlertController(title: "Alerta", message: "Te hacen falta celdas por llenar", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

// MARK:- Extensiones
// DataSours TableView para crear la tabla
extension SecondTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            //return seccion1Objeto.count
            return tablaClase.celdasImagen.count
        }
        //return seccion2Objeto.count
        return tablaClase.celdasSimple.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as? ImageTableViewCell
            cell?._title.text = tablaClase.celdasImagen[indexPath.row].title
            //cell?._title.text = seccion1Objeto[indexPath.row].title
            
            if tablaClase.celdasImagen[indexPath.row].title == "Foto" {
            //if seccion1Objeto[indexPath.row].title == "Foto" {
                cell?._textFieldImage.isEnabled = false
                cell?._buttonImage.addTarget(self, action: #selector(buttonFoto(_:)), for: .touchUpInside)
                fotoImagen.append((cell?._image)!)
                return cell!
            }
            cell?._buttonImage.isHidden = true
            cell?._textFieldImage.delegate = self
            cell?._textFieldImage.placeholder = tablaClase.celdasImagen[indexPath.row].body
            //cell?._textFieldImage.placeholder = seccion1Objeto[indexPath.row].body
            cell?._textFieldImage.tag = 5
            cell?._image.tag = 5
            imagenURL.append((cell?._image)!)
            
            return cell!
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath) as? NameTableViewCell
            if arrayInt.contains(indexPath.row) == false {
                
                cell?._textFieldName.delegate = self
                cell?._title.text = tablaClase.celdasSimple[indexPath.row].title
                //cell?._title.text = seccion2Objeto[indexPath.row].title
                cell?._textFieldName.placeholder = tablaClase.celdasSimple[indexPath.row].body
                //cell?._textFieldName.placeholder = seccion2Objeto[indexPath.row].body
                arrayInt.append(indexPath.row)
                switch tablaClase.celdasSimple[indexPath.row].title {
                //switch seccion2Objeto[indexPath.row].title {
                case "Nombre":
                    cell?._textFieldName.tag = 1
                case "Teléfono":
                    cell?._textFieldName.tag = 2
                    cell?._textFieldName.keyboardType = UIKeyboardType.numberPad
                case "Fecha de nacimiento":
                    cell?._textFieldName.tag = 3
                    creatDatePiker(text: (cell?._textFieldName)!)
                case "Sexo":
                    cell?._textFieldName.tag = 4
                    ViewPickerTxt.append((cell?._textFieldName)!)
                    cell?._textFieldName.inputView = pickerView
                default:
                    print("ninguno")
                }
        
            }
        return cell!
            
        }
    }
}
// delegados para eventos de TextField
extension SecondTableViewController: UITextFieldDelegate{
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField.tag {
        case 1:
            if let valor = textField.text {
                valorNombre = valor
            }
        case 2:
            if let valor = textField.text {
                valorTelefono = valor
            }
            
        case 4:
            if let valor = textField.text {
                valorSexo = valor
            }
        case 5:
        if let valor = textField.text {
            _url = valor
        }
        
        default:
            print("No es ninguno")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 3 {
            textField.text = valorFecha
        }
        if textField.tag == 4 {
            textField.text = valorSexo
        }
        if textField.tag == 5 {
            let url = URL(string: textField.text!)
            if let _url = url {
                imagenURL.first?.load(url: _url)
                
            }
        }
    }
}

// funcion para descargar imagen mediante una URL
extension  UIImageView {
    func load(url: URL) {
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
// delegados para utilizar la camara del dispositivo o albun de fotos
extension SecondTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imagen: UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            fotoImagen.first?.image = imagen
            foto.append(imagen)
            // se guarda en la memoria del celular
            if imagePiker.sourceType == .camera {
                fotoImagen.first?.image = imagen
                UIImageWriteToSavedPhotosAlbum(imagen, nil, nil, nil)
            }
        }
        
        imagePiker.dismiss(animated: true, completion: nil)
    }
}
// Delegados para utilizar el UIDatePicker
extension SecondTableViewController: UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arraySexo.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arraySexo[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        valorSexo = arraySexo[row]
        ViewPickerTxt.first?.resignFirstResponder()
    }
    
}
