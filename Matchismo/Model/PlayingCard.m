//
//  PlayingCard.m
//  Matchismo
//
//  Created by Marek Štefkovič on 31.1.2013.
//  Copyright (c) 2013 Marek Štefkovič. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

- (NSString *)suit
{
	return _suit ? _suit : @"?";
}

- (void)setSuit:(NSString *)suit
{
	if ([[[self class] validSuits] containsObject:suit]) {
		_suit = suit;
	}
}

- (void)setRank:(NSUInteger)rank
{
	if (rank <= [[self class] maxRank]) {
		_rank = rank;
	}
}

+ (NSArray *)validSuits
{
	static NSArray *validSuits = nil;
	if (!validSuits) validSuits = @[@"♥", @"♦", @"♠", @"♣"];
	return validSuits;
}

+ (NSUInteger)maxRank
{
	return [self rankStrings].count - 1;
}

#pragma mark - Overrides

- (NSString *)contents
{
	return [[[self class] rankStrings][self.rank] stringByAppendingString:self.suit];
}

- (NSInteger)match:(NSArray *)otherCards
{
	NSInteger score = 0;
	NSUInteger multipier = 1;
	
	for (PlayingCard *otherCard in otherCards) {
		if ([otherCard.suit isEqualToString:self.suit]) {
			score = 1;
			multipier++;
		} else if (otherCard.rank == self.rank) {
			score = 4;
			multipier++;
		} else {
			return 0;
		}
	}
	return score * multipier;
}

- (NSString *)description
{
	return [self contents];
}

#pragma mark - Private interface

+ (NSArray *)rankStrings
{
	static NSArray *rankStrings = nil;
	if (!rankStrings) {
		rankStrings = @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
	}
	return rankStrings;
}


@end
