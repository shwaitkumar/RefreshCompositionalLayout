//
//  ViewController.swift
//  RefreshCompositionalLayout
//
//  Created by WorksDelight on 07/06/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    enum Section: String, CaseIterable {
        case section1 = "Squares"
        case section2 = "Big Rectangle"
        case section3 = "Rectangles"
        case section4 = "List"
    }
    
    enum SectionItem: Hashable {
        case itemType1(Item1)
        case itemType2
        case itemType3(Item2)
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, SectionItem>!
    
    var itemType1Array = [Item1(text: "1", number: 1), Item1(text: "2", number: 2), Item1(text: "3", number: 3), Item1(text: "4", number: 4), Item1(text: "5", number: 5)]
    var itemType2Array = [Item2(text: "6"), Item2(text: "7"), Item2(text: "8")]
    
    var isShowingList = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureCollectionView()
        configureDatasource()
        generateInitialData(animated: true)
    }
    
    // MARK: - Setup CollectionView
    private func configureCollectionView() {
        collectionView.register(SimpleCollectionViewCell.self, forCellWithReuseIdentifier: SimpleCollectionViewCell.reuseIdentifer)
        collectionView.collectionViewLayout = generateLayout()
        collectionView.delegate = self
    }

    private func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
        layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let sectionLayoutKind = Section.allCases[sectionIndex]
            switch sectionLayoutKind {
            case .section1:
                return self.generateSquareLayout()
            case .section2:
                return self.generateBigRectangleLayout()
            case .section3:
                return self.generateRectanglesLayout()
            case .section4:
                return self.generateListLayout()
            }
        }
        
        return layout
    }
    
    private func generateSquareLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/3),
            heightDimension: .fractionalWidth(1/3))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])


        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous

        return section
    }
    
    private func generateBigRectangleLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(2/3))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])


        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous

        return section
    }
    
    private func generateRectanglesLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(2/3),
            heightDimension: .fractionalWidth(1/3))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])


        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous

        return section
    }
    
    private func generateListLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])


        let section = NSCollectionLayoutSection(group: group)

        return section
    }
    
    // MARK: - Datasource
    private func configureDatasource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { [unowned self] collectionView, indexPath, item in
            return self.cell(collectionView: collectionView, indexPath: indexPath, item: item)
        })
    }
    
    // MARK: Cell
    private func cell(collectionView: UICollectionView, indexPath: IndexPath, item: SectionItem) -> UICollectionViewCell {
        switch item {
        case .itemType1(let item1):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimpleCollectionViewCell.reuseIdentifer, for: indexPath) as? SimpleCollectionViewCell else { fatalError("Could not create new cell") }
            
            cell.configure(item1.text)

            return cell
            
        case .itemType2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimpleCollectionViewCell.reuseIdentifer, for: indexPath) as? SimpleCollectionViewCell else { fatalError("Could not create new cell") }
            
            cell.configure("Mid")

            return cell
            
        case .itemType3(let item2):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimpleCollectionViewCell.reuseIdentifer, for: indexPath) as? SimpleCollectionViewCell else { fatalError("Could not create new cell") }
            
            cell.configure(item2.text)

            return cell
            
        }
    }
    
    private func generateInitialData(animated: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, SectionItem>()
        
        switch isShowingList {
        case true:
            snapshot.appendSections([.section4])
            snapshot.appendItems(itemType1Array.map { ViewController.SectionItem.itemType1($0) }, toSection: .section4)
            
        case false:
            snapshot.appendSections([.section1, .section2, .section3])
            snapshot.appendItems(itemType1Array.map { ViewController.SectionItem.itemType1($0) }, toSection: .section1)
            snapshot.appendItems([ViewController.SectionItem.itemType2], toSection: .section2)
            snapshot.appendItems(itemType2Array.map { ViewController.SectionItem.itemType3($0) }, toSection: .section3)
        }
        
        dataSource.apply(snapshot, animatingDifferences: animated)
    }

}

// MARK: - UICollectionView Delegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let selectedItem = dataSource.itemIdentifier(for: indexPath) else { return }
        
        switch selectedItem {
        case .itemType1(_):
            var oldSnapshot = dataSource.snapshot()
            switch isShowingList {
            case true:
                oldSnapshot.deleteAllItems()
                oldSnapshot.appendSections([.section1, .section2, .section3])
                oldSnapshot.appendItems(itemType1Array.map { ViewController.SectionItem.itemType1($0) }, toSection: .section1)
                oldSnapshot.appendItems([ViewController.SectionItem.itemType2], toSection: .section2)
                oldSnapshot.appendItems(itemType2Array.map { ViewController.SectionItem.itemType3($0) }, toSection: .section3)
            case false:
                oldSnapshot.deleteAllItems()
                oldSnapshot.appendSections([.section4])
                oldSnapshot.appendItems(itemType1Array.map { ViewController.SectionItem.itemType1($0) }, toSection: .section4)
            }
            isShowingList = !isShowingList
            DispatchQueue.main.async {
                self.dataSource.apply(oldSnapshot, animatingDifferences: true)
                if self.isShowingList {
                    let listLayout = self.generateListLayout()
                    collectionView.setCollectionViewLayout(UICollectionViewCompositionalLayout(section: listLayout), animated: true)
                } else {
                    let originalLayout = self.generateLayout()
                    collectionView.setCollectionViewLayout(originalLayout, animated: true)
                }
            }
        case .itemType2:
            print("section 2")
        case .itemType3(_):
            print("section 3")
        }
    }
}

