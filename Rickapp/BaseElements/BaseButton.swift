import UIKit

class BaseButton: UIButton {
    
    var tapAreaInscreased = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return bounds.insetBy(dx: tapAreaInscreased ? -20 : 0, dy: tapAreaInscreased ? -20 : 0).contains(point)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupViews() {}
    func setupConstraints() {}
}
