# 实现一个二分查找
# 输入:一个顺序list
# 输出: 待查找的元素的位置
def binarySearch(alist, item):
    first = 0
    last = len(alist) - 1

    while first <= last:
        mid = (first + last)//2
        print(mid)
        if alist[mid] > item:
            last = mid - 1
        elif alist[mid] < item:
            first = mid + 1
        else:
            return mid+1
    return -1

def b(alist,item):
    n = len(alist)
    if n > 0:
        mid = n//2
        if alist[mid] == item:
            return True
        elif item < alist[mid]:
            return b(alist[;mid], item)
        else:
            return b(alist[mid+1, item])
        return False

test = [0, 1, 2, 8, 13, 17, 19, 32, 42]
print(binarySearch(test, 3))