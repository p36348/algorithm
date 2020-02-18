//
//  main.swift
//  algorithm
//
//  Created by P36348 on 08/02/2020.
//  Copyright © 2020 P36348. All rights reserved.
//

import Foundation

/*
 perform helper, for marking time usage
 */
func perform(_ method: @escaping () -> Void, _ finished: @escaping (Double) -> Void) {
        let date = Date().timeIntervalSince1970
        method()
        let usage = Date().timeIntervalSince1970 - date
        finished(usage)
}


let arr = (1...10000).map { _ in Int(arc4random()) }
perform({ var _arr = arr; _arr.sort() }, { print("swift sort finished, usage:", $0, "s") })
perform({ var _arr = arr; heapSort(&_arr) }, { print("heap sort finished, usage:", $0, "s") })
perform({ var _arr = arr; quickSort(&_arr)}, { print("quick sort finished, usage:", $0, "s") })
perform({ var _arr = arr; radixSort(&_arr) }, { print("radix sort finished, usage:", $0, "s") })
perform({ var _arr = arr; mergeSort(&_arr) }, { print("merge sort finished, usage:", $0, "s") })
perform({ var _arr = arr; shellSort(&_arr) }, { print("shell sort finished, usage:", $0, "s") })
perform({ var _arr = arr; insertSort(&_arr) }, { print("insert sort finished, usage:", $0, "s") })
perform({ var _arr = arr; selectSort(&_arr) }, { print("select sort finished, usage:", $0, "s") })
perform({ var _arr = arr; bubbleSort(&_arr) }, { print("bubble sort finished, usage:", $0, "s") })
//perform({ var _arr = arr; binarySearch(_arr, val: 3) }, { print("binary search finished, usage:", $0, "s") })

/*
 test sort
 */

//var _arr = arr
//radixSort(&_arr)
//print(arr.sorted().map {"\($0)"}.joined() == _arr.map {"\($0)"}.joined())
