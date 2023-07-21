//
//  SvgaViewController.swift
//  CXSwiftKit
//
//  Created by chenxing on 2023/7/7.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import CXSwiftKit
import RxSwift
import RxCocoa
import SVGAPlayer

class SvgaViewController: BaseViewController {
    
    private var svgaPlayer: SVGAPlayer!
    
    private let disposeBag = DisposeBag()
    
    private let items = [
        "https://cdn.jsdelivr.net/gh/svga/SVGA-Samples@master/EmptyState.svga?raw=true",
        "https://cdn.jsdelivr.net/gh/svga/SVGA-Samples@master/HamburgerArrow.svga?raw=true",
        "https://cdn.jsdelivr.net/gh/svga/SVGA-Samples@master/PinJump.svga?raw=true",
        "https://github.com/svga/SVGA-Samples/raw/master/Rocket.svga",
        "https://cdn.jsdelivr.net/gh/svga/SVGA-Samples@master/TwitterHeart.svga?raw=true",
        "https://cdn.jsdelivr.net/gh/svga/SVGA-Samples@master/Walkthrough.svga?raw=true",
        "https://cdn.jsdelivr.net/gh/svga/SVGA-Samples@master/angel.svga?raw=true",
        "https://cdn.jsdelivr.net/gh/svga/SVGA-Samples@master/halloween.svga?raw=true",
        "https://cdn.jsdelivr.net/gh/svga/SVGA-Samples@master/kingset.svga?raw=true",
        "https://cdn.jsdelivr.net/gh/svga/SVGA-Samples@master/posche.svga?raw=true",
        "https://cdn.jsdelivr.net/gh/svga/SVGA-Samples@master/rose.svga?raw=true",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navTitle = "SVGA动画"
        bindSvgaPlayer()
    }
    
    override func configure() {
        
    }
    
    override func makeUI() {
        let paddingX: CGFloat = 15
        let paddingY: CGFloat = 10
        let btnW = (cxScreenWidth - 5*paddingX) / 4
        let btnH: CGFloat = 40
        
        let btnA = UIButton(type: .custom)
        btnA.backgroundColor = .gray
        btnA.setTitle("火箭", for: .normal)
        btnA.titleLabel?.font = UIFont.cx.mediumPingFang(ofSize: 16)
        btnA.layer.cornerRadius = 10
        btnA.showsTouchWhenHighlighted = true
        view.addSubview(btnA)
        btnA.cx.makeConstraints { maker in
            maker.top.equalTo(cxNavBarH + 2*paddingY)
            maker.leading.equalTo(paddingX)
            maker.width.equalTo(btnW)
            maker.height.equalTo(btnH)
        }
        btnA.rx.tap.asDriver().drive(onNext: {[weak self] in
            self?.play(with: 1)
        }).disposed(by: disposeBag)
        
        let btnB = UIButton(type: .custom)
        btnB.backgroundColor = .gray
        btnB.setTitle("心跳", for: .normal)
        btnB.titleLabel?.font = UIFont.cx.mediumPingFang(ofSize: 16)
        btnB.layer.cornerRadius = 10
        btnB.showsTouchWhenHighlighted = true
        view.addSubview(btnB)
        btnB.cx.makeConstraints { maker in
            maker.top.equalTo(cxNavBarH + 2*paddingY)
            maker.leading.equalTo(btnW + 2*paddingX)
            maker.width.equalTo(btnW)
            maker.height.equalTo(btnH)
        }
        btnB.rx.tap.asDriver().drive(onNext: { [weak self] in
            self?.play(with: 2)
        }).disposed(by: disposeBag)
        
        let btnC = UIButton(type: .custom)
        btnC.backgroundColor = .gray
        btnC.setTitle("Rose", for: .normal)
        btnC.titleLabel?.font = UIFont.cx.mediumPingFang(ofSize: 16)
        btnC.layer.cornerRadius = 10
        btnC.showsTouchWhenHighlighted = true
        view.addSubview(btnC)
        btnC.cx.makeConstraints { maker in
            maker.top.equalTo(cxNavBarH + 2*paddingY)
            maker.leading.equalTo(2*btnW + 3*paddingX)
            maker.width.equalTo(btnW)
            maker.height.equalTo(btnH)
        }
        btnC.rx.tap.asDriver().drive(onNext: { [weak self] in
            self?.play(with: 3)
        }).disposed(by: disposeBag)
        
        let btnD = UIButton(type: .custom)
        btnD.backgroundColor = .gray
        btnD.setTitle("随机", for: .normal)
        btnD.titleLabel?.font = UIFont.cx.mediumPingFang(ofSize: 16)
        btnD.layer.cornerRadius = 10
        btnD.showsTouchWhenHighlighted = true
        view.addSubview(btnD)
        btnD.cx.makeConstraints { maker in
            maker.top.equalTo(cxNavBarH + 2*paddingY)
            maker.leading.equalTo(3*btnW + 4*paddingX)
            maker.width.equalTo(btnW)
            maker.height.equalTo(btnH)
        }
        btnD.rx.tap.asDriver().drive(onNext: { [weak self] in
            self?.play(with: 4)
        }).disposed(by: disposeBag)
        
        svgaPlayer = SVGAPlayer()
        svgaPlayer.contentMode = .bottom
        view.addSubview(svgaPlayer)
        svgaPlayer.cx.makeConstraints { make in
            make.top.equalTo(cxNavBarH + btnH + 2*paddingY)
            make.leading.equalTo(paddingX)
            make.trailing.equalTo(-paddingX)
            make.bottom.equalTo(-cxSafeAreaBottom)
        }
    }
    
    private func bindSvgaPlayer() {
        CXSvgaPlayManager.shared.svgaPlayer = svgaPlayer
    }
    
    func play(with tag: Int) {
        if tag == 1 {
            CXSvgaPlayManager.shared.play(named: "Rocket")
        } else if tag == 2 {
            CXSvgaPlayManager.shared.play(named: "heartbeat")
        } else if tag == 3 {
            CXSvgaPlayManager.shared.play(named: "rose_2.0.0")
        } else if tag == 4 {
            let i = Int(arc4random_uniform(UInt32(items.count)))
            let url = items[i < items.count ? i : 0]
            CXSvgaPlayManager.shared.play(url: url)
        }
    }
    
}
