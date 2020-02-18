//
//  algorithm+sort.swift
//  algorithm
//
//  Created by P36348 on 08/02/2020.
//  Copyright © 2020 P36348. All rights reserved.
//

import Foundation

func bubbleSort(_  arr: inout [Int]) {
    for i in 0..<arr.count {
        for j in 0..<(arr.count - i - 1){
            if arr[j] > arr[j+1] {
                arr.swapAt(j, j+1)
            }
        }
    }
}

func quickSort(_ arr: inout [Int]) {
    if arr.count <= 1 { return }
    let pivot = arr.first!
    var left: [Int] = [], right: [Int] = []

    for i in 1..<arr.count {
        let val = arr[i]
        if val > pivot {
            right.append(val)
        }else {
            left.append(val)
        }
    }

    quickSort(&left)
    quickSort(&right)
    arr = left + [pivot] + right
}

//func quickSort(_ arr: inout [Int]) {
//    if arr.count <= 1 { return }
//    let pivot = arr.first!
//    arr = arr.filter {$0 < pivot} + arr.filter {$0 == pivot} + arr.filter {$0 > pivot}
//}

//func quickSort(_ arr: inout [Int]) {
//
//    func _quickSort(_ arr: inout [Int], _ l: Int, _ h: Int) {
//        if l >= h {return}
//        var _l = l, _h = h
//        var pivotIdx = (l + h) / 2
//        let pivot = arr[pivotIdx]
//
//        while _l < _h {
//            if arr[_l] > arr[pivotIdx] {
//                arr.swapAt(_l, pivotIdx)
//                pivotIdx = _l
//            }
//            _l += 1
//
//            if arr[_h] < arr[pivotIdx] {
//                arr.swapAt(_h, pivotIdx)
//                pivotIdx = _h
//            }
//            _h -= 1
//        }
//        arr[pivotIdx] = pivot
//        _quickSort(&arr, l, pivotIdx - 1)
//        _quickSort(&arr, pivotIdx + 1, h)
//    }
//
//    _quickSort(&arr, 0, arr.count - 1)
//}

func mergeSort(_ arr: inout [Int])  {
    
    if arr.count <= 1 {
        return
    }
    
    let mid = arr.count / 2
    
    var left: [Int] = [], right: [Int] = []
    
    for i in 0..<arr.count {
        if i < mid {
            left.append(arr[i])
        }else {
            right.append(arr[i])
        }
    }
    
    mergeSort(&left)
    mergeSort(&right)

    arr = _mergeArray(&left, &right)
}

private func _mergeArray(_ sorted1: inout [Int], _ sorted2: inout [Int]) -> [Int] {
    var result: [Int] = []
    
    while !sorted1.isEmpty && !sorted2.isEmpty {
        let val1 = sorted1.first!, val2 = sorted2.first!
        if val1 < val2 {
            result.append(sorted1.removeFirst())
        }else {
            result.append(sorted2.removeFirst())
        }
    }
    
    if sorted1.isEmpty {
        result.append(contentsOf: sorted2)
    }
    
    if sorted2.isEmpty {
        result.append(contentsOf: sorted1)
    }
    return result
}

func selectSort(_ arr: inout [Int]) {
    var currentIndex = 0, minIndex = 0
    
    while currentIndex < arr.count {
        
        for i in currentIndex..<arr.count {
            if arr[i] < arr[minIndex] {
                minIndex = i
            }
        }
        arr.swapAt(currentIndex, minIndex)
        currentIndex += 1
        minIndex = currentIndex
    }
}

func insertSort(_ arr: inout [Int]) {
    if arr.count <= 1 {
        return
    }
    
    for i in 1..<arr.count {
        var current = i
        while current >= 1 && arr[current] <= arr[current - 1] {
            arr.swapAt(current, current - 1)
            current -= 1
        }
    }
}

func shellSort(_ arr: inout [Int]) {
    if arr.count <= 1 {
        return
    }
    
    var gap = arr.count / 2
    while gap >= 1 {
        var i = gap
        while i < arr.count {
            while i >= gap && arr[i] <= arr[i - gap] {
                arr.swapAt(i, i - gap)
                i -= gap
            }
            i += gap
        }
        gap -= 1
    }
}

func heapSort(_ arr: inout [Int]) {
    
    func _buildHeap(_ arr: inout [Int], length: Int? = nil) {
        var p = ((length  ?? arr.count) - 1 - 1) / 2
        while p >= 0 {
            _heapify(&arr, p, length)
            p -= 1
        }
    }

    func _heapify(_ arr: inout [Int], _ index: Int, _ length: Int? = nil) {
        let total = length ?? arr.count
        let leftIndex = 2 * index + 1
        let rightIndex = leftIndex + 1
        var maxIndex = index
        
        if index < 0, index >= total { return }
        
        if leftIndex < total && arr[maxIndex] < arr[leftIndex] {
            maxIndex = leftIndex
        }
        
        if rightIndex < total && arr[maxIndex] < arr[rightIndex] {
            maxIndex = rightIndex
        }
        
        if maxIndex != index {
            arr.swapAt(index, maxIndex)
            _heapify(&arr, maxIndex, length)
        }
    }
    
    _buildHeap(&arr)
    
    var length = arr.count
    
    while length != 1 {
        arr.swapAt(0, length - 1)
        
        length -= 1
        
        _heapify(&arr, 0, length)
    }
}

func radixSort(_ arr: inout [Int]) {
    
    func _length(of num: Int) -> Int {
        var result = 1
        var tmp = num / 10
        while tmp != 0 {
            result += 1
            tmp /= 10
        }
        return result
    }
    
    func _getValue(from num: Int, at bit: Int) -> Int {
        if bit < 1 { return 0 }
        let dec = NSDecimalNumber(decimal: pow(10, bit - 1)).intValue
        return (num / dec) % 10
    }
    
    func _getMaxLength(of arr: [Int]) -> Int {
        var result = 1
        for val in arr {
            let length = _length(of: val)
            result = max(result, length)
        }
        return result
    }
    
    var cache: [[Int]] = Array(repeating: [], count: 10)
    let maxLength = _getMaxLength(of: arr)
    
    for bit in 1...maxLength {
        while !arr.isEmpty {
            let val = arr.removeFirst()
            cache[_getValue(from: val, at: bit)].append(val)
        }
        for i in 0...9 {
            arr.append(contentsOf: cache[i])
            cache[i].removeAll()
        }
    }
    
}
