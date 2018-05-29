//
//  ViewController.swift
//  Algorithm Animation
//
//  Created by Keertika on 4/15/18.
//  Copyright © 2018 Keertika. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let delay: UInt32 = 100_000
    
    var N: Int = 16
    
    var algorithm1: String = "insertion sort"
    
    var algorithm2: String = "insertion sort"
    
    @IBOutlet weak var arrayView: ArrayView!
    
    @IBOutlet weak var arrayView2: ArrayView!
    
    //Selecting different array size for sorting.
    @IBAction func arraySize(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        
        switch index {
        case 0:
            N = 16
            
        case 1:
            N = 32
            
        case 2:
            N = 48
            
        case 3:
            N = 64
            
        default:
            N = 16
            
        }
        usleep(delay)
        self.loadArray()
        displayAnimation()
    }
    
    
    //Algorithm selection from first segmented control
    @IBAction func sortTypes(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        
        switch index {
        case 0:
            algorithm1 = "insertion sort"
            
        case 1:
            algorithm1 = "selection sort"
            
        case 2:
            algorithm1 = "quick sort"
            
        case 3:
            algorithm1 = "merge sort"
            
        default:
            algorithm1 = "insertion sort"
        }
        
        displayAnimation()
        
    }
    
    
    //Algorithm selection from second segmented control
    @IBAction func sortTypes2(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        
        switch index {
        case 0:
            algorithm2 = "insertion sort"
            
        case 1:
            algorithm2 = "selection sort"
            
        case 2:
            algorithm2 = "quick sort"
            
        case 3:
            algorithm2 = "merge sort"
            
        default:
            algorithm2 = "insertion sort"
        }
        
        displayAnimation()
    }
    
    
    //Sort Button: Sorting array based on selected algorithm.
    @IBAction func sort_button(_ sender: UIButton) {
        let queue = DispatchQueue.global(qos: .userInitiated)
        
        if (algorithm1 == "insertion sort" && algorithm2 == "insertion sort") {
            queue.async {
                self.insertionSort(&self.arrayView.data)
                self.insertionSort(&self.arrayView2.data)
                
            }
            
        }
        else if (algorithm1 == "insertion sort" && algorithm2 == "selection sort") {
            queue.async {
                self.insertionSort(&self.arrayView.data)
                self.selectionSort(&self.arrayView2.data)
                
            }
            
        }
        else if (algorithm1 == "insertion sort" && algorithm2 == "quick sort") {
            queue.async {
                self.insertionSort(&self.arrayView.data)
                self.quicksort(&self.arrayView2.data)
                
            }
            
        }
        else if (algorithm1 == "insertion sort" && algorithm2 == "merge sort"){
            queue.async {
                self.selectionSort(&self.arrayView.data)
                self.mergeSort(&self.arrayView2.data)
                
            }
            
        }
        else if (algorithm1 == "selection sort" && algorithm2 == "insertion sort") {
            queue.async {
                self.selectionSort(&self.arrayView.data)
                self.insertionSort(&self.arrayView2.data)
                
            }
            
        }
        else if (algorithm1 == "selection sort" && algorithm2 == "selection sort") {
            queue.async {
                self.selectionSort(&self.arrayView.data)
                self.selectionSort(&self.arrayView2.data)
                
            }
            
        }
        else if (algorithm1 == "selection sort" && algorithm2 == "quick sort"){
            queue.async {
                self.selectionSort(&self.arrayView.data)
                self.quicksort(&self.arrayView2.data)
                
            }
            
        }
        else if (algorithm1 == "selection sort" && algorithm2 == "merge sort"){
            queue.async {
                self.selectionSort(&self.arrayView.data)
                self.mergeSort(&self.arrayView2.data)
                
            }
            
        }
        else if (algorithm1 == "quick sort" && algorithm2 == "insertion sort"){
            queue.async {
                self.quicksort(&self.arrayView.data)
                self.insertionSort(&self.arrayView2.data)
                
            }
            
        }
        else if (algorithm1 == "quick sort" && algorithm2 == "selection sort"){
            queue.async {
                self.quicksort(&self.arrayView.data)
                self.selectionSort(&self.arrayView2.data)
                
            }
            
        }
        else if (algorithm1 == "quick sort" && algorithm2 == "quick sort"){
            queue.async {
                self.quicksort(&self.arrayView.data)
                self.quicksort(&self.arrayView2.data)
                
            }
            
        }
        else if (algorithm1 == "quick sort" && algorithm2 == "merge sort"){
            queue.async {
                self.quicksort(&self.arrayView.data)
                self.mergeSort(&self.arrayView2.data)
                
            }
            
        }
        else if (algorithm1 == "merge sort" && algorithm2 == "insertion sort"){
            queue.async {
                self.mergeSort(&self.arrayView.data)
                self.insertionSort(&self.arrayView2.data)
                
            }
            
        }
        
        else if (algorithm1 == "merge sort" && algorithm2 == "selection sort"){
            queue.async {
                self.mergeSort(&self.arrayView.data)
                self.selectionSort(&self.arrayView2.data)
                
            }
            
        }
        else if (algorithm1 == "merge sort" && algorithm2 == "quick sort"){
            queue.async {
                self.mergeSort(&self.arrayView.data)
                self.quicksort(&self.arrayView2.data)
                
            }
            
        }
        else {
            queue.async {
                self.mergeSort(&self.arrayView.data)
                self.mergeSort(&self.arrayView2.data)
                
            }
            
        }
        
        
    }
    
    
    //Loading array when changing array size.
    func loadArray() {
        
        arrayView.data.removeAll()
        arrayView2.data.removeAll()
        
        for i in 0 ..< N {
            arrayView.data.append(i + 1)
            arrayView2.data.append(i + 1)
            
        }
        
    }
    
    //Shuffle Function
    func shuffle(_ a: inout [Int]) {
        let N = a.count
        for i in 0 ..< N {
            // choose index uniformly in [0, i]
            let r = Int(arc4random_uniform(UInt32(i + 1)))
            //ViewController.swap(&a[i], &a[r])
            a.swapAt(i, r)
            DispatchQueue.main.async {
                self.arrayView.setNeedsDisplay()
                self.arrayView2.setNeedsDisplay()
            }
            usleep(delay)
        }
    }
    
    //Insertion Sort
    func insertionSort(_ a: inout [Int]) { for i in 0 ..< a.count {
        var j = i
        while j > 0 && a[j-1] > a[j] {
            a.swapAt(j-1, j)
            j -= 1
            DispatchQueue.main.async {
                self.arrayView.setNeedsDisplay()
                self.arrayView2.setNeedsDisplay()
                
            }
            usleep(delay)
        }
        
        }
        
    }
    
    //Selection Sort
    func selectionSort(_ a: inout [Int]) { for i in 0..<a.count {
        var min_index = i
        for j in i+1..<a.count{
        if a[j] < a[min_index]{
                    min_index = j
                    }
        }
        if min_index != i{
            let temp = a[i]
            a[i] = a[min_index]
            a[min_index] = temp
            DispatchQueue.main.async {
                self.arrayView.setNeedsDisplay()
                self.arrayView2.setNeedsDisplay()
            
        }
            usleep(delay)
            
        }
        }
    }
    
    //Quick Sort
    func quicksort(_ a: inout [Int]) {
        quicksort(&a, 0, a.count - 1)
        
    }
    
    func quicksort(_ a: inout [Int], _ left: Int, _ right: Int) {
        if left < right {
            let pivotIndex = partition(&a, left, right)
            quicksort(&a, left, pivotIndex)
            quicksort(&a, pivotIndex + 1, right)
            DispatchQueue.main.async {
                self.arrayView.setNeedsDisplay()
                self.arrayView2.setNeedsDisplay()
                
            }
            usleep(delay)
            
        }
    }
    
    
    func partition(_ a: inout [Int], _ left: Int, _ right: Int) -> Int {
        var i = left - 1
        var j = right + 1
        let v = a[left]
        while true {
            repeat { j = j-1
                
            } while a[j] > v
            repeat { i = i+1
            } while a[i] < v
            if i < j{
                a.swapAt(i, j)
            }
            else{
                return j
            }
        }
    }
    
    //Merge Sort
    func mergeSort(_ a: inout [Int]) {
        if a.count > 1 {
            var leftArray: [Int] = left(&a)
            var rightArray: [Int] = right(&a)
            
            mergeSort(&leftArray)
            mergeSort(&rightArray)
            
            merge(&a, &leftArray, &rightArray)
        }
        
    }
    
    func left(_ a: inout [Int]) -> [Int]{
        let size: Int = a.count / 2
        var leftArray = [Int] (repeating: 0, count: size)
        
        for i in 0 ..< size{
            leftArray[i] = a[i]
        }
        
        return leftArray
    }
    
    func right(_ a: inout [Int]) -> [Int]{
        let size1: Int = a.count / 2
        let size2: Int = a.count - size1
        var rightArray = [Int] (repeating: 0, count: size2)
        
        for i in 0 ..< size2{
            rightArray[i] = a[i + size1]
        }
        
        return rightArray
    }
    
    
    func merge(_ result: inout [Int], _ left: inout [Int], _ right: inout [Int]) {
       
        var i1: Int = 0
        var i2: Int = 0
        let N: Int = result.count
        
        for i in 0 ..< N{
            if (i2 >= right.count || (i1 < left.count && left [i1] <= right[i2])) {
                result [i] = left [i1]
                i1 = i1 + 1
            }
            else{
                result [i] = right [i2]
                i2 = i2 + 1
            }
            
            DispatchQueue.main.async {
                self.arrayView.setNeedsDisplay()
                self.arrayView2.setNeedsDisplay()
                
            }
            usleep(delay)
        }
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.loadArray()
        displayAnimation()
        
        
    }
    
    //Display animation when changing array size/selecting different sorting algorithms
    func displayAnimation() {
        
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.async {
            self.shuffle(&self.arrayView.data)
            self.shuffle(&self.arrayView2.data)
            
            DispatchQueue.main.async {
                self.arrayView.setNeedsDisplay()
                self.arrayView2.setNeedsDisplay()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


