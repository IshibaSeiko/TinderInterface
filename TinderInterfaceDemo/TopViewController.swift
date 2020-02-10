//
//  TopViewController.swift
//  TinderInterfaceDemo
//
//  Created by 石場清子 on 2020/02/10.
//  Copyright © 2020 石場清子. All rights reserved.
//

import UIKit
import VerticalCardSwiper

class TopViewController: UIViewController, VerticalCardSwiperDatasource, VerticalCardSwiperDelegate {

    private var cardSwiper: VerticalCardSwiper!

    private var contactsDemoData: [Contact] = [
        Contact(name: "John Doe", age: 33),
        Contact(name: "Chuck Norris", age: 78),
        Contact(name: "Bill Gates", age: 62),
        Contact(name: "Steve Jobs", age: 56),
        Contact(name: "Barack Obama", age: 56),
        Contact(name: "Mila Kunis", age: 34),
        Contact(name: "Pamela Anderson", age: 50),
        Contact(name: "Christina Anguilera", age: 37),
        Contact(name: "Ed Sheeran", age: 23),
        Contact(name: "Jennifer Lopez", age: 45),
        Contact(name: "Nicki Minaj", age: 31),
        Contact(name: "Tim Cook", age: 57),
        Contact(name: "Satya Nadella", age: 50)
    ]


    override func viewDidLoad() {
        super.viewDidLoad()

        cardSwiper = VerticalCardSwiper(frame: self.view.bounds)
        view.addSubview(cardSwiper)

        cardSwiper.datasource = self
        cardSwiper.delegate = self

        // register cardcell for storyboard use
        cardSwiper.register(nib: UINib(nibName: "ExampleCardCell", bundle: nil), forCellWithReuseIdentifier: "ExampleCardCell")
    }

    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {

        if let cardCell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: "ExampleCardCell", for: index) as? ExampleCardCell {
            return cardCell
        }
        return CardCell()
    }

    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        return contactsDemoData.count
    }

    func willSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        // called right before the card animates off the screen.
        contactsDemoData.remove(at: index)
    }
    func didSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {

    }
}

internal class Contact {

    let name: String!
    let age: Int!

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}
