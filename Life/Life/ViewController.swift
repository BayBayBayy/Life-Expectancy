//
//  ViewController.swift
//  Life
//
//  Created by I Wayan Adnyana on 26/04/22.
//

import UIKit

class CellClas: UITableViewCell{
    
}

class ViewController: UIViewController {

    @IBOutlet weak var namaTextField: UITextField!
 
    @IBOutlet weak var agePicker: UIPickerView!
    @IBOutlet weak var buttonGender: UIButton!
    @IBOutlet weak var sickButton: UIButton!
    @IBOutlet weak var checkbutton: UIButton!
    
    var umur = 0
    
    let transparentView = UIView()
    
    let tableVIEW = UITableView()
  
    var selectedButton = UIButton()
    
    var calculateSource =  0
    
    var calculateStatic = 0
    
    var maxUmur = 75
        
    var dataSource = [String]()
    
    var completionHandler : ((String?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        agePicker.dataSource = self
        agePicker.delegate = self
        tableVIEW.delegate = self
        tableVIEW.dataSource = self
        tableVIEW.register(CellClas.self, forCellReuseIdentifier: "Cell")
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        //items
        let flexibleSpace  = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        toolBar.items = [flexibleSpace, doneButton]
        toolBar.sizeToFit()
        namaTextField.inputAccessoryView = toolBar
        
        
        
        
//        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//            namaTextField.resignFirstResponder()
//            return true
//        }
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
//        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func didTapDone(){
        //
        namaTextField.resignFirstResponder()
    }
//    close keyboard
//    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
//            namaTextField.resignFirstResponder()
//        }
    
    func addTransparentView(frames: CGRect){
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        tableVIEW.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.view.addSubview(tableVIEW)
        tableVIEW.layer.cornerRadius = 5
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableVIEW.reloadData()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: { [self] in
            self.transparentView.alpha = 0
            self.tableVIEW.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(self.dataSource.count * 50))
        }, completion: nil)
    }
    
    @objc func removeTransparentView(){
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableVIEW.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }
    
    @IBAction func onClickSelectGender(_ sender: Any) {
        dataSource = ["Pria", "Wanita"]
        selectedButton = buttonGender
        addTransparentView(frames: buttonGender.frame)
    }
    
    @IBAction func onClickSelectSick(_ sender: Any) {
        dataSource = ["Diabetes", "Kanker Paru-paru", "Gagal Jantung", "Stroke", "Gagal Ginjal", "Tidak Ada"]
        selectedButton = sickButton
        addTransparentView(frames: sickButton.frame)
    }
    
    @IBAction func btnClick(_ sender: Any) {
        let d : String = namaTextField.text!
        InputVar.userName = d
        InputVar.calculateSource = calculateSource
        InputVar.calculateStatic = calculateStatic
        calculateAgeStatic()
        calculateAge()
        resultCalculate()
        
    }
    func calculateAge(){
         //input
        let gender = buttonGender.titleLabel?.text
        print(gender)
        print(umur)
        let sickMode = sickButton.titleLabel?.text
        print(sickMode)
//        umur dibawah rata-rata
//        pria
        if gender == "Pria" && sickMode == "Diabetes" && umur < InputVar.calculateStatic {
            calculateSource = ((70+75) / 2) - umur
            print(calculateSource)
        } else if gender == "Pria" && sickMode == "Kanker Paru-paru" && umur < maxUmur {
            calculateSource = ((70+(6 + umur)) / 2) - umur
            print(calculateSource)
        } else if gender == "Pria" && sickMode == "Gagal Jantung" && umur < maxUmur {
            calculateSource = ((70+(13 + umur)) / 2) - umur
            print(calculateSource)
        } else if gender == "Pria" && sickMode == "Stroke" && umur < maxUmur {
            calculateSource = ((70+(8 + umur)) / 2) - umur
            print(calculateSource)
        } else if gender == "Pria" && sickMode == "Gagal Ginjal" && umur < maxUmur {
            calculateSource = ((70+(10 + umur)) / 2) - umur
            print(calculateSource)
        } else if gender == "Pria" && sickMode == "Tidak Ada" && umur < maxUmur {
            calculateSource = 70 - umur
            print(calculateSource)
//            Wanita
        } else if gender == "Wanita" && sickMode == "Diabetes" && umur < maxUmur {
            calculateSource = ((74+80) / 2) - umur
            print(calculateSource)
        } else if gender == "Wanita" && sickMode == "Kanker Paru-paru" && umur < maxUmur {
            calculateSource = ((74+(6 + umur)) / 2) - umur
            print(calculateSource)
        } else if gender == "Wanita" && sickMode == "Gagal Jantung"{
            calculateSource = ((74+(13 + umur)) / 2) - umur
            print(calculateSource)
        } else if gender == "Wanita" && sickMode == "Stroke"{
            calculateSource =  ((70+(8 + umur)) / 2) - umur
            print(calculateSource)
        } else if gender == "Wanita" && sickMode == "Gagal Ginjal"{
            calculateSource = ((74+(10 + umur)) / 2) - umur
            print(calculateSource)
        } else if gender == "Wanita" && sickMode == "Tidak Ada"{
            calculateSource = 74 - umur
            print(calculateSource)
        }
//       umur diatas rata-rata
//       pria
        if gender == "Pria" && sickMode == "Diabetes" && umur > InputVar.calculateStatic {
            calculateSource = umur
            print(calculateSource)
        } else if gender == "Pria" && sickMode == "Kanker Paru-paru" && umur > InputVar.calculateStatic {
            calculateSource = umur
            print(calculateSource)
        } else if gender == "Pria" && sickMode == "Gagal Jantung" && umur > InputVar.calculateStatic  {
            calculateSource = umur
            print(calculateSource)
        } else if gender == "Pria" && sickMode == "Stroke" && umur > InputVar.calculateStatic  {
            calculateSource = umur
            print(calculateSource)
        } else if gender == "Pria" && sickMode == "Gagal Ginjal" && umur > InputVar.calculateStatic  {
            calculateSource = umur
            print(calculateSource)
        } else if gender == "Pria" && sickMode == "Tidak Ada" && umur > InputVar.calculateStatic {
            calculateSource = umur
            print(calculateSource)
//            Wanita
        } else if gender == "Wanita" && sickMode == "Diabetes" && umur > InputVar.calculateStatic {
            calculateSource = umur
            print(calculateSource)
        } else if gender == "Wanita" && sickMode == "Kanker Paru-paru" && umur > InputVar.calculateStatic  {
            calculateSource = umur
            print(calculateSource)
        } else if gender == "Wanita" && sickMode == "Gagal Jantung" && umur > InputVar.calculateStatic  {
            calculateSource = umur
            print(calculateSource)
        } else if gender == "Wanita" && sickMode == "Stroke" && umur > InputVar.calculateStatic  {
            calculateSource =  umur
            print(calculateSource)
        } else if gender == "Wanita" && sickMode == "Gagal Ginjal" && umur > InputVar.calculateStatic  {
            calculateSource = umur
            print(calculateSource)
        } else if gender == "Wanita" && sickMode == "Tidak Ada" && umur > InputVar.calculateStatic  {
            calculateSource = umur
            print(calculateSource)
        } 
        InputVar.calculateSource = calculateSource
    }
    func resultCalculate(){
        let sickCondition = sickButton.titleLabel?.text
        print(sickCondition)
        var tipsChoice : String = ""
        if sickCondition == "Diabetes" {
            tipsChoice = "A1. Selalu mengonsumsi makanan dengan pola gizi seimbang menggunakan prinsip piring makan model T untuk makanan utama dan mengutamakan konsumsi buah-buah untuk makanan selingan. 2. Batasi makanan berikut ini, dan sangat baik jika dapat dihindari : a. Mengandung banyak gula sederhana. b. Mengandung banyak Lemak. c. Mengandung banyak Natrium"
            print("Anda terlalu banyak memakan gula, kurangi gula dan perbanyak aktivitas / berolahraga")
        } else if sickCondition == "Kanker Paru-paru" {
            tipsChoice = "1. Makanan yang baik untuk pasien kanker paru yaitu air kelapa, pisang dan bubuk coklat. 2. Pola makan yang sehat untuk pasien kanker paru-paru yaitu  makan dengan kalori yang memadai berat badan tetap ideal dan konsumsi makanan porsi kecil dengan lebih sering. 3. olahraga yang cukup"
            print("Kamu kurang aware dengan kesehatanmu, kurangi junkfood dan perbanyak olahraga. Jangan lupa untuk kontrol kesehatanmu secara berkala")
        } else if sickCondition == "Gagal Jantung" {
            tipsChoice = "1. Pelajari kondisi gagal jantung. 2. Perhatikan asupan garam. 3. Timbang berat badan setiap hari. 4. Perhatikan asupan lemak. 5. Tak lupa minum obat."
           
        } else if sickCondition == "Stroke" {
            tipsChoice = "1. Bantu Pasien untuk Berpindah Tempat. 2. Ajak Pasien untuk Bergerak. 3. Bantu Proses Makan Pasien. 4. Latih Kesehatan Otaknya 5.Bantu Mengingatkan Jadwal Minum Obat"
            
        } else if sickCondition == "Gagal Ginjal" {
            tipsChoice = "1. Pola Makan Sehat. 2. Kontrol Asupan Cairan. 3.Olahraga. 4. Pertahankan Kolesterol Tetap Rendah"
            
        } else if sickCondition == "Tidak Ada" {
            tipsChoice = "1. Terapkan pola makan sehat. Mengonsumsi makanan sehat dengan gizi seimbang 2. Tetap aktif bergerak 3. Istirahat yang cukup 4. Jangan merokok dan kurangi konsumsi minuman beralkohol. 5. Kelola stres dengan baik."
           
        }
        
        InputVar.tips = tipsChoice
    }
//    static age
    func calculateAgeStatic(){
        //input
       let gender = buttonGender.titleLabel?.text
       print(gender)
       print(umur)
       let sickMode = sickButton.titleLabel?.text
       print(sickMode)
//        umur dibawah rata-rata
//        pria
        if gender == "Pria" && sickMode == "Diabetes"{
            calculateStatic = ((70+75) / 2)
            print(calculateStatic)
        } else if gender == "Pria" && sickMode == "Kanker Paru-paru"{
            calculateStatic = ((70+(6 + umur)) / 2)
        } else if gender == "Pria" && sickMode == "Gagal Jantung"{
            calculateStatic = ((70+(13 + umur)) / 2)
            print(calculateStatic)
        } else if gender == "Pria" && sickMode == "Stroke"{
            calculateStatic = ((70+(8 + umur)) / 2)
            print(calculateStatic)
        } else if gender == "Pria" && sickMode == "Gagal Ginjal"{
            calculateStatic = ((70+(10 + umur)) / 2)
            print(calculateStatic)
        } else if gender == "Pria" && sickMode == "Tidak Ada"{
            calculateStatic = 70
            print(calculateStatic)
//            Wanita
        } else if gender == "Wanita" && sickMode == "Diabetes"{
            calculateStatic = ((74+80) / 2)
            print(calculateStatic)
        } else if gender == "Wanita" && sickMode == "Kanker Paru-paru"{
            calculateStatic = ((74+(6 + umur)) / 2)
            print(calculateStatic)
        } else if gender == "Wanita" && sickMode == "Gagal Jantung"{
            calculateStatic = ((74+(13 + umur)) / 2)
            print(calculateStatic)
        } else if gender == "Wanita" && sickMode == "Stroke"{
            calculateStatic =  ((70+(8 + umur)) / 2)
            print(calculateStatic)
        } else if gender == "Wanita" && sickMode == "Gagal Ginjal"{
            calculateStatic = ((74+(10 + umur)) / 2)
            print(calculateStatic)
        } else if gender == "Wanita" && sickMode == "Tidak Ada"{
            calculateStatic = 74
            print(calculateStatic)
        }
        InputVar.calculateStatic = calculateStatic
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedButton.setTitle(dataSource[indexPath.row], for: .normal)
        removeTransparentView()
    }
}
extension ViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row + 1)
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        umur = row + 1
    }
    
}
