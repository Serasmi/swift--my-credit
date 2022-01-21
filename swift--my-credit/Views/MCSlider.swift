//
//  MCSlider.swift
//  swift--my-credit
//
//  Created by Sergey Smirnov on 16.11.2021.
//

import UIKit

protocol MCSliderDelegate: AnyObject {
    func slider(_ slider: UISlider, value: Float)
}

class MCSlider: UIView {
    
    typealias Listener = (Float) -> Void
    
    private var listener: Listener?
    
    private let slider = UISlider()
    private let minLabel = UILabel()
    private let maxLabel = UILabel()
    
    private(set) var step: Float = Constants.sliderStep
    private(set) var minSuffix: String?
    private(set) var maxSuffix: String?
    
    public var labelFormatter: NumberFormatter?
    public weak var delegate: MCSliderDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews(slider, minLabel, maxLabel)
        
        configureSlider()
        configureLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(value: Float,
                     minValue: Float = Constants.sliderMinValue,
                     maxValue: Float = Constants.sliderMaxValue,
                     step: Float = Constants.sliderStep,
                     minSuffix: String?,
                     maxSuffix: String?) {
        self.init(frame: .zero)
        
        slider.minimumValue = minValue
        slider.maximumValue = maxValue
        slider.value = value
        
        self.step = step
        
        updateLabel(minLabel, with: minValue, suffix: minSuffix)
        updateLabel(maxLabel, with: maxValue, suffix: maxSuffix)
    }
    
    private func configureLabels() {
        NSLayoutConstraint.activate([
            minLabel.leadingAnchor.constraint(equalTo: slider.leadingAnchor),
            minLabel.topAnchor.constraint(equalTo: slider.bottomAnchor),
            minLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        minLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            maxLabel.leadingAnchor.constraint(greaterThanOrEqualTo: minLabel.trailingAnchor),
            maxLabel.trailingAnchor.constraint(equalTo: slider.trailingAnchor),
            maxLabel.topAnchor.constraint(equalTo: slider.bottomAnchor),
            maxLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        maxLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureSlider() {
        slider.minimumTrackTintColor = Constants.sliderColor
        slider.addTarget(self, action: #selector(changeValue), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            slider.leadingAnchor.constraint(equalTo: leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: trailingAnchor),
            slider.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        slider.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc
    private func changeValue(_ sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        
        sender.value = roundedValue
        self.delegate?.slider(sender, value: roundedValue)
        self.listener?(roundedValue)
    }
    
    public func bind(listener: Listener?) {
        self.listener = listener
        listener?(slider.value)
    }
    
    public func setValue(with value: Float) {
        if (value != slider.value) {
            slider.value = value
            listener?(value)
        }
    }
    
    public func updateMinLabelSuffix(with suffix: String? = nil) {
        updateLabel(minLabel, with: slider.minimumValue, suffix: suffix)
    }
    
    public func updateMaxLabelSuffix(with suffix: String? = nil) {
        updateLabel(maxLabel, with: slider.maximumValue, suffix: suffix)
    }
    
    private func updateLabel(_ label: UILabel, with value: Float, suffix: String?) {
        if let formatter = labelFormatter {
            label.text = formatter.string(from: NSNumber(value: value))
            return
        }
        
        label.text = getFullText(for: value.round(), with: suffix)
    }
}

extension MCSlider {
    
    private func getFullText(for label: String, with suffix: String?) -> String {
        guard let suffix = suffix else {
            return label
        }
        
        return "\(label) \(suffix)"
    }
}
