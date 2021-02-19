//
//  DiffLinkedList.swift
//  GitHubDiff
//
//  Created by YAUHENI IVANIUK on 2/19/21.
//

import Foundation

class DiffNode {
    var headerLine: String?
    var leftLine: String?
    var leftCount: String?
    var rightLine: String?
    var rightCount: String?
    var lineType: DiffLineType
    var next: DiffNode?
    weak var previous: DiffNode?
    
    public init(headerLine: String?, leftLine: String?, leftCount: String?, rightLine: String?, rightCount: String?, lineType: DiffLineType)  {
        self.headerLine = headerLine
        self.leftLine = leftLine
        self.leftCount = leftCount
        self.rightLine = rightLine
        self.rightCount = rightCount
        self.lineType = lineType
    }
}

class LinkedList {
    
    private var head: DiffNode?
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: DiffNode? {
        return head
    }
    
    public var last: DiffNode? {
        guard var node = head else {
            return nil
        }
        
        while let next = node.next {
            node = next
        }
        return node
    }
    
    func previusEmptyLeft() -> DiffNode? {
        var current = last
        while current != nil {
            switch current?.lineType {
            case .notChanged, .fileName, .position:
                return nil
            case .left:
                return nil
            case .right:
                if current?.leftLine == nil {
                    return current
                }
                current = current?.previous
            case .none:
                print("Out of range")
            }
        }
        return nil
    }
    
    func previusEmptyRight() -> DiffNode? {
        var current = last
        while current != nil {
            switch current?.lineType {
            case .notChanged, .fileName, .position:
                return nil
            case .left:
                if current?.rightLine == nil {
                    return current
                }
                current = current?.previous
            case .right:
                return nil
            case .none:
                print("Out of range")
            }
        }
        return nil
    }
    
    func append(node: DiffNode) {
        if let lastNode = last {
            node.previous = lastNode
            lastNode.next = node
        } else {
            head = node
        }
    }
    
}
