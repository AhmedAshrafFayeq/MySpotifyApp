//
//  HomeViewController.swift
//  MySpotifyApp
//
//  Created by Ahmed Fayeq on 13/02/2022.
//

import UIKit

// enum of the three different types of collectionView cells
enum BrwoseSectionType{
    case newRelease(viewModels: [NewReleaseCollectionViewCell])             //1
    case featuredPlaylists(viewModels: [NewReleaseCollectionViewCell])      //2
    case recommendedTracks(viewModels: [NewReleaseCollectionViewCell])      //3
}

class HomeViewController: UIViewController {
    
    private var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout{ sectionIndex, _ -> NSCollectionLayoutSection in
            return HomeViewController.createSectionLayout(section: sectionIndex)
        } ) 
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.backgroundColor = .label
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    // to get the number of sections and the data in each section
    var sections = [BrwoseSectionType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Browse"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSettings))
        configureCollectionView()
        view.addSubview(spinner)
        fetchData()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    private func configureCollectionView(){
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: "cell")
        collectionView.register(NewReleaseCollectionViewCell.self,
                                forCellWithReuseIdentifier: NewReleaseCollectionViewCell.identifier)
        collectionView.register(FeaturedPlaylistCollectionViewCell.self,
                                forCellWithReuseIdentifier: FeaturedPlaylistCollectionViewCell.identifier)
        collectionView.register(RecommendedTrackCollectionViewCell.self,
                                forCellWithReuseIdentifier: RecommendedTrackCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
    }
    
    private func fetchData(){
        let group = DispatchGroup()
        group.enter()
        group.enter()
        group.enter()
        
        var newReleases: NewReleasesResponse?
        var featuredPlaylists: FeaturedPlaylistsResponse?
        var recommended: RecommendationResponse?
        
        // New Releases
        APICaller.shared.getNewReleases { result in
            
            switch result{
            case .success(let model):
                newReleases = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        // Featured Playlists
        APICaller.shared.getFeaturedPlaylists { result in
            defer{
                group.leave()
            }
            switch result{
            case .success(let model):
                featuredPlaylists = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        // Recommended Tracks
        APICaller.shared.getRecommendedGenres { result in
            //to be excuted after the scope exit = try/Finally
            defer{
                group.leave()
            }
            switch result {
            case .success(let model):
                let genres = model.genres
                var seeds = Set<String>()
                while seeds.count < 5 {
                    if let random = genres.randomElement(){
                        seeds.insert(random)
                    }
                }
                APICaller.shared.getRecommendations(genres: seeds) { recommendedResult in
                    defer{
                        group.leave()
                    }
                    switch recommendedResult{
                    case .success(let model):
                        recommended = model
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                    
                }
            case .failure(_): break
            }
        }
        
        group.notify(queue: .main) {
            
        }
        
        //Congigure Models
        sections.append(.newRelease(viewModels: []))
        sections.append(.featuredPlaylists(viewModels: []))
        sections.append(.recommendedTracks(viewModels: []))
    }
    
    @objc func didTapSettings(){
        let profileViewController = SettingsViewController()
        profileViewController.title = "Settings"
        profileViewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(profileViewController, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        switch indexPath.section{
        case 0:
            cell.backgroundColor = .systemGreen
        case 1:
            cell.backgroundColor = .systemPink
        case 2:
            cell.backgroundColor = .systemBlue
        default:
            cell.backgroundColor = .systemGreen
        }
        return cell
    }
    
    static func createSectionLayout(section: Int) -> NSCollectionLayoutSection{
        switch section{
        case 0:
            // Item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0))
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            // Vertical Group in horizontal group
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(390)
                ),
                subitem: item,
                count: 3)
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension: .absolute(390)
                ),
                subitem: verticalGroup,
                count: 1)
            
            // Section
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            return section
            
        case 1:
            // Item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(200),
                heightDimension: .absolute(200))
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(200),
                    heightDimension: .absolute(400)
                ),
                subitem: item,
                count: 2)
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(200),
                    heightDimension: .absolute(400)
                ),
                subitem: verticalGroup,
                count: 1)
            
            // Section
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .continuous
            return section
            
        case 2:
            // Item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0))
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(80)
                ),
                subitem: item,
                count: 1)
            
            // Section
            let section = NSCollectionLayoutSection(group: group)
            return section
            
        default:
            // Item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0))
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(390)
                ),
                subitem: item,
                count: 1)
            
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
}
