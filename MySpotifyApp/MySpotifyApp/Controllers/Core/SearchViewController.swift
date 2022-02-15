//
//  SearchViewController.swift
//  MySpotifyApp
//
//  Created by Ahmed Fayeq on 13/02/2022.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    


}



//
//  Tree.swift
//  MyVodafone
//
//  Created by Javier Giner Alvarez on 16/04/2021.
//  Copyright © 2021 TSSE. All rights reserved.
//

import Foundation

// MARK: - @functionBuilder
@resultBuilder
struct NodeBuilder {
    static func buildBlock<Value>(_ children: Node<Value>...) -> [Node<Value>] {
        children
    }
}

/// Tree Design Pattern
final class Node<Value> {
    var value: Value
    private (set) var children: [Node]
    weak var parent: Node?
    
    var count: Int {
        1 + children.reduce(0) { $0 + $1.count }
    }
    
    init(_ value: Value) {
        self.value = value
        children = []
    }

    init(_ value: Value, children: [Node]) {
        self.value = value
        self.children = children
    }

    init(_ value: Value, @NodeBuilder builder: () -> [Node]) {
        self.value = value
        self.children = builder()
    }
    
    func add(child: Node) {
        children.append(child)
        child.parent = self
    }
}
// MARK: - Extensions
extension Node: Equatable where Value: Equatable {
    static func == (lhs: Node, rhs: Node) -> Bool {
        lhs.value == rhs.value && lhs.children == rhs.children
    }
}
extension Node: Hashable where Value: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
        hasher.combine(children)
    }
}
extension Node: Codable where Value: Codable { }

extension Node where Value: Equatable {
    func find(_ value: Value) -> Node? {
        if self.value == value {
            return self
        }
        
        for child in children {
            if let match = child.find(value) {
                return match
            }
        }
        return nil
    }
}

extension Node: CustomStringConvertible {
  var description: String {
    var text = "\(value)"

    if !children.isEmpty {
      text += " {" + children.map { $0.description }.joined(separator: ", ") + "} "
    }
    return text
  }
}

