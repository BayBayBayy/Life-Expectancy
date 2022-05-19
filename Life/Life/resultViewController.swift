//
//  resultViewController.swift
//  Life
//
//  Created by I Wayan Adnyana on 27/04/22.
//

import UIKit

class resultViewController: UIViewController {

    var unionVal = 0
    
    
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var tipsLabel: UILabel!
    @IBOutlet weak var tipsView: UILabel!
    @IBOutlet weak var namaLabel: UILabel!
    @IBOutlet weak var resultCalculate: UILabel!
    @IBOutlet weak var btnColor: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//kalkulasi
        unionVal = InputVar.calculateSource - InputVar.calculateStatic
        namaLabel.text = "Hi, \(InputVar.userName)"
        print(InputVar.calculateSource)
        print(InputVar.calculateStatic)
        print(unionVal)
        if InputVar.calculateSource > InputVar.calculateStatic {
            // text label
            resultCalculate.text = "Hasil kalkulasi dari usia harapan hidup pada case ini di angka \(InputVar.calculateStatic) tahun. Ini berarti kamu sudah melewati batas rata-rata umur manusia umumnya dengan nilai +\(unionVal) tahun dari hasil kalkulasi usia harapan hidupmu. Dengan umurmu yang sekarang \(InputVar.calculateSource) tahun, kamu bisa sharing ke sesama tentang bagaimana cara menjalani pola hidup sehat "
            // warning label
            warningLabel.text = " Good "
            btnColor.layer.cornerRadius = btnColor.frame.width / 2
            btnColor.layer.masksToBounds = true
            btnColor.backgroundColor = UIColor.green
        } else if InputVar.calculateSource <= InputVar.calculateStatic  {
            // text label
            resultCalculate.text = "Hasil kalkulasi dari usia harapan hidupmu adalah \(InputVar.calculateSource) tahun. Di kasus ini rata-rata usia harapan hidup seseorang bisa mencapai angka \(InputVar.calculateStatic) tahun. Akan tetapi kamu bisa meningkatkan usia harapan hidupmu dengan beberapa tips dibawah"
            // warning label
            warningLabel.text = "Warning"
            btnColor.layer.cornerRadius = btnColor.frame.width / 2
            btnColor.layer.masksToBounds = true
            btnColor.backgroundColor = UIColor.orange
        }
// tips
        if InputVar.calculateSource > InputVar.calculateStatic {
            tipsView.isHidden = true
            tipsLabel.isHidden = true

        } else if InputVar.calculateSource <= InputVar.calculateStatic {
            tipsView.text = "\(InputVar.tips)"
        }
//        background color
//        if unionVal >= 0 {
//            warningLabel.text = "Very Good"
//            btnColor.layer.cornerRadius = btnColor.frame.width / 2
//            btnColor.layer.masksToBounds = true
//            btnColor.backgroundColor = UIColor.green
//        } else {
//            warningLabel.text = "Warning"
//            btnColor.layer.cornerRadius = btnColor.frame.width / 2
//            btnColor.layer.masksToBounds = true
//            btnColor.backgroundColor = UIColor.orange
//            
//            }
        }

   
        
    }
    

    

