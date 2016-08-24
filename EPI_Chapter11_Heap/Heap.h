//
//  minheap.h
//  EPI_Chapter11_Heap
//
//  Created by Smart Home on 7/20/16.
//  Copyright © 2016 Smart Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Heap<ObjectType> : NSObject

@property NSUInteger maxHeapSize;
@property BOOL isMinHeap;//True = Min, False = MAX

- (BOOL) insert:(ObjectType)objectToAdd;
- (ObjectType) peek;
- (ObjectType) pop;

- (instancetype) init;
- (instancetype) initMinHeapWithSize:(NSUInteger) maxheapSize;
- (instancetype) initMaxHeapWithSize:(NSUInteger) maxheapSize;
- (instancetype) initWithType:(BOOL)isMinHeap;
- (instancetype) initMaxHeapWithArray:(NSArray *)array;
- (instancetype) initWithArray:(NSArray *)array;
@end
