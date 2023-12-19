import UIKit
import SnapKit

final class SegmentedProgressBar: UIView {
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        
        return view
    }()
    
    // MARK: - Init
    
    init(numberOfSegments: Int, currentIndex: Int, spacing: Int) {
        super.init(frame: .zero)
        
        for index in 0..<numberOfSegments {
            let segment = UIView()
            segment.frame = .zero
            segment.layer.cornerRadius = 5
            segment.backgroundColor = index != currentIndex - 1 ? .disabledGray : .mainBlue
            
            stackView.addArrangedSubview(segment)
            stackView.spacing = CGFloat(spacing)
        }
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(6)
        }
    }
}
