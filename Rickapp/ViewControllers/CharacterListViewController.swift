import UIKit
 import SnapKit
 import Kingfisher

 class CharacterListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
     let baseURL = "https://rickandmortyapi.com/api/character"
     let label = UILabel()
     let tableView = UITableView()

     var characters: [Character] = []

     override func viewDidLoad() {
         super.viewDidLoad()
         setupViews()
         setUpConstraints()
         fetchCharacterData()
     }

     func setupViews() {
         label.text = "This is Rickapp"
         label.textColor = .white
         label.font = .italicSystemFont(ofSize: CGFloat(30))

         tableView.dataSource = self
         tableView.delegate = self
         tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
         tableView.rowHeight = 500

         self.view.addSubview(label)
         self.view.addSubview(tableView)
     }

     func setUpConstraints() {
         label.snp.makeConstraints { make in
             make.centerX.equalToSuperview()
             make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
         }

         tableView.snp.makeConstraints { make in
             make.top.equalTo(label.snp.bottom).offset(20)
             make.leading.trailing.bottom.equalToSuperview()
         }
     }

     func fetchCharacterData() {
         guard let url = URL(string: baseURL) else {
             return
         }

         URLSession.shared.dataTask(with: url) { data, _, error in
             if let error = error {
                 print("Error fetching data: \(error)")
                 return
             }

             if let data = data {
                 do {
                     let response = try JSONDecoder().decode(CharacterResponse.self, from: data)
                     self.characters = response.results
                     DispatchQueue.main.async {
                         self.tableView.reloadData()
                     }
                 } catch {
                     print("Error decoding data: \(error)")
                 }
             }
         }.resume()
     }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return characters.count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
         let character = characters[indexPath.row]
         
         cell.textLabel?.removeFromSuperview()
         cell.isUserInteractionEnabled = false
         cell.backgroundColor = .darkGray
         
         let characterStackView = UIStackView()
         let characterImageView = UIImageView()
         let nameLabel = UILabel()
         let statusLabel = UILabel()
         let locationLabel = UILabel()
         let originLabel = UILabel()
         
         characterImageView.kf.setImage(with: URL(string: character.image))
         
         nameLabel.text = character.name
         nameLabel.textColor = .white
         nameLabel.font = .boldSystemFont(ofSize: 30)
         
         statusLabel.text = character.status + " - " + character.species
         
         locationLabel.text = "Last known location: \n\(character.location.name)"
         locationLabel.numberOfLines = 0
         
         originLabel.text = "First seen in: \n\(character.origin.name)"
         originLabel.numberOfLines = 0

         characterStackView.backgroundColor = .gray
         characterStackView.axis = .vertical
         characterStackView.spacing = 40
         characterStackView.addArrangedSubviews([characterImageView, nameLabel, statusLabel, locationLabel, originLabel])
         characterStackView.setCustomSpacing(5, after: characterImageView)
         characterStackView.setCustomSpacing(5, after: nameLabel)
         
         cell.contentView.addSubview(characterStackView)
         
         characterStackView.snp.makeConstraints { make in
             make.edges.equalToSuperview().inset(UIEdgeInsets(top: 30, left: 20, bottom: 30, right: 20))
         }
         
         return cell
     }

 }

 struct Character: Codable {
     let name: String
     let status: String
     let species: String
     let location: Location
     let origin: Origin
     let image: String

     enum CodingKeys: String, CodingKey {
         case name, status, species, location, origin, image = "image"
     }
 }

 struct Location: Codable {
     let name: String
 }

 struct Origin: Codable {
     let name: String
 }

 struct CharacterResponse: Codable {
     let results: [Character]
 }
