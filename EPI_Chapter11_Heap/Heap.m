//
//  minheap.m
//  EPI_Chapter11_Heap
//
//  Created by Smart Home on 7/20/16.
//  Copyright © 2016 Smart Home. All rights reserved.
//

#import "Heap.h"

@interface Heap()

@property NSMutableArray *heap;//index i children are at index 2*(i+1) and 2*(i+1)-1, index i parent is at floor((i+1)/2)

@end

@implementation Heap

#pragma mark - Heap initializers
- (instancetype) init
{
    self = [super init];
    if (self) {
        _heap = [[NSMutableArray alloc] init];
        _maxHeapSize = LONG_MAX;
        _isMinHeap = TRUE;
    }
    
    return self;
}

- (instancetype) initMinHeapWithSize:(NSUInteger) maxheapSize
{
    self = [super init];
    if (self) {
        _heap = [[NSMutableArray alloc] initWithCapacity:maxheapSize];
        _maxHeapSize = maxheapSize;
        _isMinHeap = TRUE;
    }
    
    return self;
}

- (instancetype) initMaxHeapWithSize:(NSUInteger) maxheapSize
{
    self = [super init];
    if (self) {
        _heap = [[NSMutableArray alloc] initWithCapacity:maxheapSize];
        _maxHeapSize = maxheapSize;
        _isMinHeap = FALSE;
    }
    
    return self;
}

- (instancetype) initWithType:(BOOL)isMinHeap
{
    self = [super init];
    if (self) {
        _heap = [[NSMutableArray alloc] init];
        _maxHeapSize = LONG_MAX;
        _isMinHeap = isMinHeap;
    }
    
    return self;
}

- (instancetype) initWithArray:(NSArray *)array
{
   return [self initWithType:YES andArray:array];
}

- (instancetype) initMaxHeapWithArray:(NSArray *)array
{
    return [self initWithType:NO andArray:array];
}

- (instancetype) initWithType:(BOOL)isMinHeap andArray:(NSArray *)array
{
    self = [super init];
    if (self) {
        _heap = [array mutableCopy];
        _maxHeapSize = LONG_MAX;
        _isMinHeap = isMinHeap;
        [self heapify];
    }
    
    return self;
}


#pragma mark - Heap manipuplations

- (BOOL) insert:(id)objectToAdd
{
    if ([self.heap count] < self.maxHeapSize) {
        [self.heap addObject:objectToAdd];
        [self bubbleUp:[self.heap count]-1];
        return TRUE;
    } else {
        return FALSE;
    }
}

- (id) peek
{
    return self.heap[0];
}

- (id) pop
{
    id valueToReturn = self.heap[0];
    
    self.heap[0] = [self.heap lastObject];
    [self.heap removeLastObject] ;
    [self bubbleDown:0];
    
    return valueToReturn;
}

#pragma mark - Helper functions
-(void) heapify
{
    //First non-leaf node index = pow(2,numLevels-1) - 2
    //numLevels = int(log2([heap count]))+1
    //for(nodes from 1st non leaf node index to node 0) bubble it down until heap condition is satisfied
    NSUInteger nonLeafDepth = log([self.heap count])/log(2);
    NSInteger firstNonLeafIndex = pow(2,nonLeafDepth) - 2;

    for (NSInteger index = firstNonLeafIndex; index >= 0; index--)
    {
        [self bubbleDown:index];
    }
}

-(NSInteger) leftChild:(NSUInteger)index
{
    if ((2*(index+1))-1 < [self.heap count])
    {
        return (2*(index+1))-1;
    }
    else
    {
        return -1;
    }
}

-(NSUInteger) rightChild:(NSUInteger)index
{
    if (2*(index+1) < [self.heap count])
    {
        return 2*(index+1);
    }
    else
    {
        return -1;
    }
}

-(void) bubbleDown:(NSUInteger)startIndex
{
    NSUInteger parentIndex = startIndex;
    NSComparisonResult heapCriterion;
    
    if (self.isMinHeap)
    {
        heapCriterion = NSOrderedAscending;
    }
    else
    {
        heapCriterion = NSOrderedDescending;
    }
    
    while (1)
    {
        NSInteger leftChildIndex = [self leftChild:parentIndex];
        NSInteger rightChildIndex = [self rightChild:parentIndex];
        NSUInteger indexToTest = leftChildIndex;
        
        if (leftChildIndex != -1 && rightChildIndex != -1)
        {
            NSComparisonResult childComp = [self.heap[leftChildIndex] compare:self.heap[rightChildIndex]];
            
            indexToTest = ((childComp == heapCriterion)?leftChildIndex:rightChildIndex);
        }
        else if (indexToTest == -1)
        {
            return;
        }
        
        if ([self.heap[parentIndex] compare:self.heap[indexToTest]] != heapCriterion)
        {
            id tmp = self.heap[parentIndex];
            self.heap[parentIndex] = self.heap[indexToTest];
            self.heap[indexToTest] = tmp;
            parentIndex = indexToTest;
        }
        else
        {
            return ;
        }
    }
}

-(void) bubbleUp:(NSUInteger)startIndex
{
    NSUInteger nodeIndex = startIndex;
    NSComparisonResult heapCriterion;
    
    if (self.isMinHeap)
    {
        heapCriterion = NSOrderedAscending;
    }
    else
    {
        heapCriterion = NSOrderedDescending;
    }
    
    while (nodeIndex != 0)
    {
        NSInteger parentIndex = floor((nodeIndex+1)/2)-1;
        
        if ([self.heap[nodeIndex] compare:self.heap[parentIndex]] == heapCriterion)
        {
            id tmp = self.heap[nodeIndex];
            self.heap[nodeIndex] = self.heap[parentIndex];
            self.heap[parentIndex] = tmp;
            nodeIndex = parentIndex;
        }
        else
        {
            return ;
        }
    }
}

@end
