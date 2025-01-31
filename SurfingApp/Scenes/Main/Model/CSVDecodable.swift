//
//  CSVDecodable.swift
//  SurfingApp
//
//  Created by Dilara ACISU on 30.01.2025.
//

import Foundation

// CSV'den veri alacak modellerin implement etmesi gereken protokol
protocol CSVDecodable {
    init?(csvRow: [String])
}

// CSV Parser Sınıfı
class CSVParser {
    // Statik fonksiyon - CSV dosyasını parse eder
    static func parseCSV<T: CSVDecodable>(fileName: String, type: T.Type) -> [T]? {
        // Dosyanın yolunu bul
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: "csv") else {
            print("Dosya bulunamadı.")
            return nil
        }
        
        do {
            // Dosya içeriğini oku
            let fileContents = try String(contentsOfFile: filePath, encoding: .utf8)
            let rows = fileContents.split(separator: "\n")
            
            var parsedData: [T] = []
            
            // İlk satır başlık olduğu için onu atlıyoruz
            for (index, row) in rows.enumerated() {
                if index == 0 { continue }  // Başlık satırını atla
                
                let columns = row.split(separator: ",").map { String($0) }
                
                if let modelObject = T(csvRow: columns) {
                    parsedData.append(modelObject)
                }
            }
            
            return parsedData
        } catch {
            print("Dosya okunamadı: \(error)")
            return nil
        }
    }
}
