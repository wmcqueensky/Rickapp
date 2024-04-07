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
         cell.backgroundColor = .backgroundGray
         
         let characterStackView = UIStackView()
         let characterImageView = UIImageView()
         let nameLabel = UILabel()
         let statusLabel = UILabel()
         let locationLabel = UILabel()
         let originLabel = UILabel()
         let actualLocationLabel = UILabel()
         let actualOriginLabel = UILabel()
         
         characterImageView.kf.setImage(with: URL(string: character.image))
         
         nameLabel.text = character.name
         nameLabel.textColor = .white
         nameLabel.font = .boldSystemFont(ofSize: 30)
         
         statusLabel.text = character.status + " - " + character.species
         statusLabel.textColor = .white
         
         locationLabel.text = "Last known location:"
         locationLabel.textColor = .gray
         
         actualLocationLabel.text = character.location.name
         actualLocationLabel.textColor = .white
         
         originLabel.text = "First seen in:"
         originLabel.textColor = .gray
         
         actualOriginLabel.text = character.origin.name
         actualOriginLabel.textColor = .white
         
         characterStackView.backgroundColor = .darkGray
         characterStackView.axis = .vertical
         characterStackView.spacing = 10
         characterStackView.layer.cornerRadius = 10
         characterStackView.addArrangedSubviews([characterImageView, nameLabel, statusLabel, locationLabel, actualLocationLabel, originLabel, actualOriginLabel])
         
         cell.contentView.addSubview(characterStackView)
         
         characterStackView.snp.makeConstraints { make in
             make.edges.equalToSuperview().inset(UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25))
         }
         
         return cell
     }

 }
