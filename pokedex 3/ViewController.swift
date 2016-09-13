//
//  ViewController.swift
//  pokedex 3
//
//  Created by brenda saavedra on 12/09/16.
//  Copyright © 2016 bsc. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    var arrPokemon = [Pokemon]()
    var arrFilter = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parsePokemonCSV()
        initAudio()
    }
    
    func initAudio(){
        let path = Bundle.main.path(forResource:"music", ofType: "mp3")!
        
        do{
            musicPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = 1
            musicPlayer.play()
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    func parsePokemonCSV(){
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do{
            let csv = try CSV(contentsOfURL:path)
            let rows = csv.rows
            
            for row in rows {
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let pokemon = Pokemon(name: name, pokedexId: pokeId)
                arrPokemon.append(pokemon)
            }
        }catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isSearching ? arrFilter.count : arrPokemon.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PokeCell{
            
            let pokemon = isSearching ? arrFilter[indexPath.row] : arrPokemon[indexPath.row]
            
            cell.configureCell(pokemon: pokemon)
            return cell
        }else{
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    //MARK: SearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
        }else{
            isSearching = true
            let lower = searchBar.text!.lowercased()
            arrFilter = arrPokemon.filter({$0.name.range(of: lower) != nil})
        }
        self.collectionView.reloadData()
    }
    
    //MARK: IBAction
    @IBAction func musicBtnPressed(_ sender: UIButton){
        if(musicPlayer.isPlaying){
            musicPlayer.pause()
            sender.alpha = 0.2
        }else{
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }


}

