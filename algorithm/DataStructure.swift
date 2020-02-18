//
//  DataStructure.swift
//  algorithm
//
//  Created by P36348 on 12/02/2020.
//  Copyright © 2020 P36348. All rights reserved.
//

import Foundation

class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    init(val: Int, left: TreeNode?, right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

extension TreeNode {
    static func buildTree(_ arr: [Int?]) -> TreeNode? {
        var result: TreeNode? = nil
        
        return result
    }
}

class ListNode {
    var val: Int
    var next: ListNode?
    init(val: Int, next: ListNode?) {
        self.val = val
        self.next = next
    }
}

extension ListNode {
    static func buildList(_ arr: [Int]) -> ListNode? {
        var result: ListNode? = nil
        
        var current: ListNode? = nil
        
        for val in arr {
            if result == nil {
                result = ListNode(val: val, next: nil)
                current = result
            }else {
                current?.next = ListNode(val: val, next: nil)
                current = current?.next
            }
        }
        
        return result
    }
}

class Stack<T> {
    private var array: Array<T> = []
    
    var isEmpty: Bool {
        return self.array.isEmpty
    }
    
    func push(_ val: T) {
        self.array.append(val)
    }
    
    func pop() -> T {
        return self.array.removeLast()
    }
    
    func peek() -> T {
        return self.array.last!
    }
}

class Queue<T> {
    private var array: Array<T> = []
    
    var isEmpty: Bool {
        return self.array.isEmpty
    }
    
    func push(_ val: T) {
        self.array.append(val)
    }
    
    func pop() -> T {
        return self.array.removeFirst()
    }
    
    func front() -> T {
        return self.array.first!
    }
}
