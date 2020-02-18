//
//  algorithm+search.swift
//  algorithm
//
//  Created by P36348 on 08/02/2020.
//  Copyright © 2020 P36348. All rights reserved.
//

import Foundation

func binarySearch(_ arr: [Int], val: Int) -> Int? {
    if arr.isEmpty || val > arr.last! {
        return nil
    }
    var h = arr.count - 1
    var l = 0
    while h >= l {
        let index = (h + l) / 2
        let _val = arr[index]
        if _val == val {
            return index
        }
        if _val > val {
            h = index
        }
        if _val < val {
            l = index + 1
        }
    }
    
    return nil
}

func binaryTreeSearch(_ node: TreeNode?, _ target: Int) -> TreeNode? {
    var result: TreeNode? = nil
    var current = node
    
    while current != nil {
        if current!.val == target {
            result = current
            break
        }
        if current!.val > target {
            current = current!.left
        }
        if current!.val < target {
            current = current!.right
        }
    }
    
    return result
}
