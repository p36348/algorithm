# Swift实现的数据结构与算法

## 排序算法

### 冒泡排序

> 它重复地走访过要排序的元素列，依次比较两个相邻的元素，如果顺序（如从大到小、首字母从从Z到A）错误就把他们交换过来。走访元素的工作是重复地进行直到没有相邻元素需要交换，也就是说该元素列已经排序完成。

1. 从数组`a`的第0个下标开始操作, 取出元素.
2. 用该元素对比下一个元素, 如果大于(或小于), 则把该元素的与其交换, 否则不交换.
    **意义: 把大的数据往后移.**
3. 下标+1, 取出元素.
4. 重复步骤2, 直到下标到达数组最后1位.
5. 重复步骤1到步骤4, 步骤4操作至数组下标最后第2位. 以此类推, 直到最后步骤4的下标到达数组的第1位.

```swift
func bubbleSort(_  arr: inout [Int]) {
    for i in 0..<arr.count {
        for j in 0..<(arr.count - i - 1){
            if arr[j] > arr[j+1] {
                arr.swapAt(j, j+1)
            }
        }
    }
}
```

---

### 快速排序

> 取数组的一个元素作为基准, 将数组拆分两段, 左边一段的元素总小于右边一段的元素, 然后再对这两段数据进行同样的操作, 当拆分至两段数组的宽度小于等于1的时候, 数组中任何一个元素左边的元素均小于等于它, 其右边的元素均大于等于它.

1. 取数组`a`的中间下标的元素`x`.
2. 把小于(或等于)`x`的其他元素放在`x`的前面(数组`b`), 大于`x`的其他元素形放在`x`的后面(数组`b`).
3. 重复对数组`b`和数组`c`做步骤1和步骤2的操作, 直到在步骤1中被操作的数组长度变成不大于1.

    解释: 每次操作都把小于某元素的子集放到左边, 大于的放在右边, 以此类推操作, 最后每个元素`x`左边的值都会小于`x`, 其右边的值都会大于`x`, 这样就实现了排序目的.

```swift
func quickSort(_ arr: [Int]) -> [Int] {
    if arr.count <= 1 {
        return arr
    }
    let mid = arr[arr.count / 2]
    var left: [Int] = [], right: [Int] = []
    for i in 0..<arr.count {
        if i != arr.count / 2 {
            let val = arr[i]
            if val > mid {
                right.append(val)
            }else {
                left.append(val)
            }
        }
    }
    return quickSort(left) + [mid] + quickSort(right)
}
```

---

### 归并排序

> 递归地把数组拆分成两段子数组, 分别对两段子数组进行排序, 然后把已经有序的两段数组合并起来. 当拆分的子数组宽度小于等于1的时候递归函数即可返回.

步骤(合并):

1. 申请空间，使其大小为两个**已经排序**序列之和，该空间用来存放合并后的序列
2. 设定两个指针，最初位置分别为两个已经排序序列的起始位置
3. 比较两个指针所指向的元素，选择相对小的元素放入到合并空间，并移动指针到下一位置
4. 重复步骤3直到某一指针达到序列尾
5. 将另一序列剩下的所有元素直接复制到合并序列尾

```swift
func mergeSort(_ arr: [Int]) -> [Int] {

    if arr.count <= 1 {
        return arr
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

    var sorted1 = mergeSort(left), sorted2 = mergeSort(right)

    return _mergeArray(&sorted1, &sorted2)
}

func _mergeArray(_ sorted1: inout [Int], _ sorted2: inout [Int]) -> [Int] {
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
```

---

### 选择排序

1. 取数组`a`中的第1个元素，逐一和其后面的元素做对比，把其中最小的元素下标标记出来，直到数组末尾。
2. 交换被标记的元素和第1个元素的位置，然后取数组中下1位元素，重复步骤1，直到取到数组最后一位元素为止。

    解释: 每一次都可以把当前循环中, 数组右边(待排序的子数组)里最小的元素取出并且交换到数组左端,(已经排序的子数组的末端), **相比冒泡排序对比元素的次数多, 交换次数较少**.

```swift
func selectSort(_ arr: [Int]) -> [Int] {
    var _arr = arr, currentIndex = 0, minIndex = 0

    while currentIndex < _arr.count {

        for i in currentIndex..<_arr.count {
            if _arr[i] < _arr[minIndex] {
                minIndex = i
            }
        }
        _arr.swapAt(currentIndex, minIndex)
        currentIndex += 1
        minIndex = currentIndex
    }
    return _arr
}
```

---

### 插入排序

1. 取数组`a`中的第2个元素`x`，和它左边的所有元素做比较，如果被比较的元素更大，则交换位置，直到被比较的元素比`x`小，或者`x`已经在数组的最左边。
2. 取下一个元素`y`，重复步骤1，直到下标到达数组最右端为止。

    意义: 保持让数组左边的子数组是排序好的, 每1轮循环都通过逐个对比交换位置的方式, 把右边子数组中的元素放进左边子数组中.

```swift
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
```

---

### Shell排序

> 其实是**插入排序**的改良, **插入排序**每次只交换相邻的两个元素, 而**Shell排序**则交换距离更远的两个 元素, 加快了元素交换的速度. 相当于

  1. 定义一个变量`n`, `n`小于数组`a`的宽度.
  2. 取数组中的第`n`个元素`x`, 比较`x`和数组第0个元素`y`, 如果`x`更小, 交换`x`和`y`的位置.
  3. 取数组中的第`2n`个元素`z`, (下标从大到小)依次比较`z`和数组左边与`z`间隔为**`n`的整数倍** 的元素, 直到被比较的元素比`z`小, 或者`z`已经在数组的最左边.
  4. 取数组中的第`3n`个元素`v`, 从步骤2开始重复, 直到下标到达数组右侧不能再往上增加.
  5. 把变量`n`-1, 从步骤2开始重复操作, 直到`n`的值变为1.

```swift
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
```

---

### 堆排序

> 利用了二叉树的性质, 对数组进行转换, 建立堆完成之后, 树的根节点的值是数组中最大的值. 取出最大值后交换数组末尾, 再对根节点做`heapify`操作, 又可以在根节点中得到数组中最大的值. 所以依次可以得到有序数组.

  1. 对数组`a`, 把数组`a`视作为完全二叉树, 对所有节点自下往上进行`heapify`操作.
  2. 把根节点的值取出(就是拿出数组`a`的第0个元素), 添加到新数组`b`的前端, 然后把二叉树末端的值移到根节点(数组最后一个元素移到数组前端).
  3. 对根节点进行`heapify`操作, 然后重新回到步骤2, 直到数组`a`中的元素都添加到了`b`中, 此时数组`b`的元素就是升序.

**heapify & build heap:**
    根据完全二叉树的性质, 对于这个二叉树数组`a`里的元素`a[i]`, 它的父节点为`a[(i-1)/2]`, 左节点为`a[2n+1]`, 右节点为`a[2n+2]`(如果这3个节点存在的话). `heapify`就是把一个完全二叉树构建成`堆(heap)`数据结构的一个子操作. 通过以上性质, 对比并交换每个子树的三个节点, 让父节点总是大于(或小于)它的子节点. `build heap`操作则是从堆底的子树开始往上对子树的根节点执行`heapify`操作. 

```swift
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
```

---

### 基数排序(LSD)

```swift
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

```

---

## 搜索算法

### 二分搜索

> 对于一个有序的数组, 迭代(递归)地拿数组中间值对比目标值, 根据对比结果调整下一次取值的位置, 直到命中目标值或者取值范围大小收缩至0.

```swift
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
```

### 二叉树搜索

> 利用二叉排序树的性质, 递归(或迭代)地对比节点和目标值, 根据对比结果进行返回, 或者切换到当前节点的子节点进行下一次对比. 直到得到对应的结果或者没有下一个子节点结束.
> **二叉搜索树**：
> （又：二叉搜索树，二叉排序树）它或者是一棵空树，或者是具有下列性质的二叉树： 若它的左子树不空，则左子树上所有结点的值均小于它的根结点的值； 若它的右子树不空，则右子树上所有结点的值均大于它的根结点的值； 它的左、右子树也分别为二叉排序树

```swift
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
```
