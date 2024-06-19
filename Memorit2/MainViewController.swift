//
//  MainViewController.swift
//  Memorit2
//
//  Created by 이우천 on 6/19/24.
//

import UIKit

struct Record {
    let date: Date
    let image: UIImage
    let description: String
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    var records: [Record] = [
        Record(date: Date(), image: UIImage(named: "appicon") ?? UIImage(), description: "테스트 기록 1"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionview.dataSource = self
        collectionview.delegate = self
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowRecordAddViewController" {
            if let recordAddVC = segue.destination as? RecordAddViewController {
                recordAddVC.delegate = self
            }
        }
    }
    
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return records.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecordCell", for: indexPath) as! RecordCell
        let record = records[indexPath.row]
        cell.thumbnailImageView.image = record.image
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.bounds.width - 20) / 3
        return CGSize(width: itemSize, height: itemSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedRecord = records[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let popupVC = storyboard.instantiateViewController(withIdentifier: "PopUpViewController") as? PopUpViewController {
            popupVC.record = selectedRecord
            popupVC.modalPresentationStyle = .overCurrentContext
            popupVC.modalTransitionStyle = .crossDissolve
            present(popupVC, animated: true, completion: nil)
        }
    }
}

extension MainViewController: RecordAddViewControllerDelegate {
    func didAddRecord(_ record: Record) {
        records.append(record)
        collectionview.reloadData()
    }
}
