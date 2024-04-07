import UIKit

class BaseButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupViews() {}
    func setupConstraints() {}
    
    func animateTap() {
        UIView.animate(withDuration: 0.2) {
            self.setTitleColor(.gray, for: .normal)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            UIView.animate(withDuration: 0.2) {
                self.setTitleColor(.white, for: .normal)
            }
        }
    }
}
