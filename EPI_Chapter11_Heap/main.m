//
//  main.m
//  EPI_Chapter11_Heap
//
//  Created by Smart Home on 7/20/16.
//  Copyright © 2016 Smart Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Heap.h"

void sortKSortedArray(NSUInteger k, NSMutableArray *arrayToSort);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSMutableArray *arrayToSort = [@[@"C", @"A", @"B", @"F", @"D", @"E", @"G"] mutableCopy];
        
        sortKSortedArray(2, arrayToSort);
        
        NSLog(@"Sorted Array is %@",arrayToSort); //A, B, C, D, E, F, G
        
        Heap <NSNumber *> *numbers = [[Heap alloc] initMaxHeapWithArray:@[@2,@1,@(-1),@3, @(4)]];
        NSLog(@"%@",[numbers pop]); //4
        NSLog(@"%@",[numbers pop]); //3
        [numbers insert:@(-10)];
        NSLog(@"%@",[numbers pop]); //2
        [numbers insert:@(10)];
        NSLog(@"%@",[numbers pop]);//10
        NSLog(@"%@",[numbers peek]);//1
        
        Heap <NSString *> *letters = [[Heap alloc] initWithArray:@[@"C", @"A", @"B", @"F", @"D", @"E", @"G"]];
        NSLog(@"%@",[letters pop]);//A
        NSLog(@"%@",[letters pop]);//B
        [letters insert:@"Z"];
        NSLog(@"%@",[letters pop]);//C
        [letters insert:@"A"];
        NSLog(@"%@",[letters peek]);//A
    }
    return 0;
}

void sortKSortedArray(NSUInteger k, NSMutableArray *arrayToSort)
{
    Heap *minHeapStore = [[Heap alloc] initMinHeapWithSize:(k+1)];
    
    for (NSUInteger index = 0; index <= MIN(k,[arrayToSort count]-1); index++) {
     
        [minHeapStore insert:arrayToSort[index]];
    }
    
    for (NSUInteger index = 0; index <= [arrayToSort count]-1; index++) {
        
        arrayToSort[index] = [minHeapStore pop];
        
        if (index+k+1 <= [arrayToSort count]-1) {
            [minHeapStore insert:arrayToSort[index+k+1]];
        }
    }

}