//
//  ViewController.m
//  WeirdTest
//
//  Created by Bin Yu on 29/03/2017.
//  Copyright © 2017 Bin Yu. All rights reserved.
//

#define BOOLSTR(val) (val ? @"YES" : @"NO")

#import "ViewController.h"
#import "Trie.h"
#import "SummaryRanges.h"

@interface CancelToken : NSObject

@property (nonatomic, assign, getter=isCancelled) BOOL cancelled;

@end

@implementation CancelToken

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self cancellableDispatchAfter];
}

- (void)cancellableDispatchAfter {
    [self cancelable_dispatch_after:dispatch_time(DISPATCH_TIME_NOW, (int64_t)NSEC_PER_SEC * 2)
                              queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                              block:^{
                                  NSLog(@"Not cancelled after 2 seconds");
                              }];
    
    CancelToken *cancelToken = [self cancelable_dispatch_after:dispatch_time(DISPATCH_TIME_NOW, (int64_t)NSEC_PER_SEC * 2)
                                                         queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                                                         block:^{
                                                             NSLog(@"Shouldn't be shown here!");
                                                         }];
    cancelToken.cancelled = YES;
}

- (void)regularExpressionMatching {
    NSString *s = @"aa";
    NSString *p = @"a";
    NSLog(@"%@ matches %@: %@", s, p, BOOLSTR([self isMatch:s p:p]));
    
    s = @"aa";
    p = @"a*";
    NSLog(@"%@ matches %@: %@", s, p, BOOLSTR([self isMatch:s p:p]));
    
    s = @"aa";
    p = @".*";
    NSLog(@"%@ matches %@: %@", s, p, BOOLSTR([self isMatch:s p:p]));
    
    s = @"ab";
    p = @".*";
    NSLog(@"%@ matches %@: %@", s, p, BOOLSTR([self isMatch:s p:p]));
    
    s = @"aab";
    p = @"c*a*b";
    NSLog(@"%@ matches %@: %@", s, p, BOOLSTR([self isMatch:s p:p]));
}

- (void)summaryRanges {
    SummaryRanges *summaryRanges = [SummaryRanges new];
    NSInteger nums[5] = {1, 3, 7, 2, 6};
    for (NSInteger i = 0; i < 5; i++) {
        [summaryRanges addNum:nums[i]];
        NSLog(@"Summary Ranges: %@", [summaryRanges getIntervals]);
    }
}

- (void)addAndSearchWord {
    Trie *trie = [Trie trie];
    [trie addWord:@"bad"];
    [trie addWord:@"dad"];
    [trie addWord:@"mod"];
    NSLog(@"Search %@: %@", @"pad", BOOLSTR([trie search:@"pad"]));
    NSLog(@"Search %@: %@", @"bad", BOOLSTR([trie search:@"bad"]));
    NSLog(@"Search %@: %@", @".ad", BOOLSTR([trie search:@".ad"]));
    NSLog(@"Search %@: %@", @"b..", BOOLSTR([trie search:@"b.."]));
}

- (void)expressionAddOperators {
    NSString *input = @"123";
    NSInteger target = 6;
    NSLog(@"Expression add operators for %@ and target %@: %@", input, @(target), [self expressionAddOperators:input target:target]);
    
    input = @"232";
    target = 8;
    NSLog(@"Expression add operators for %@ and target %@: %@", input, @(target), [self expressionAddOperators:input target:target]);

    input = @"105";
    target = 5;
    NSLog(@"Expression add operators for %@ and target %@: %@", input, @(target), [self expressionAddOperators:input target:target]);
    
    input = @"00";
    target = 0;
    NSLog(@"Expression add operators for %@ and target %@: %@", input, @(target), [self expressionAddOperators:input target:target]);
    
    input = @"3456237490";
    target = 9191;
    NSLog(@"Expression add operators for %@ and target %@: %@", input, @(target), [self expressionAddOperators:input target:target]);
}

- (void)shortestPalindrome {
    NSString *input = @"aacecaaa";
    NSLog(@"Shortest palindrome of %@: %@", input, [self shortestPalindrome:input]);
    
    input = @"dcbabcd";
    NSLog(@"Shortest palindrome of %@: %@", input, [self shortestPalindrome:input]);
    
    input = @"aaaaaaaaa";
    NSLog(@"Shortest palindrome of %@: %@", input, [self shortestPalindrome:input]);
    
    input = @"";
    NSLog(@"Shortest palindrome of %@: %@", input, [self shortestPalindrome:input]);
}

- (void)countAllPalindromeSubstrings {
    NSString *input = @"abaab";
    NSLog(@"Count all palindrome substring in %@: %@", input, @([self countAllPalindromeSubstrings:input]));
    
    input = @"abbaeae";
    NSLog(@"Count all palindrome substring in %@: %@", input, @([self countAllPalindromeSubstrings:input]));

}

- (void)simplifyPath {
    NSString *input = @"/home/";
    NSLog(@"Simplified path of %@: %@", input, [self simplifyPath:input]);
    
    input = @"/a/./b/../../c/";
    NSLog(@"Simplified path of %@: %@", input, [self simplifyPath:input]);
    
    input = @"/";
    NSLog(@"Simplified path of %@: %@", input, [self simplifyPath:input]);
    
    input = @"a";
    NSLog(@"Simplified path of %@: %@", input, [self simplifyPath:input]);
    
    input = @".././a";
    NSLog(@"Simplified path of %@: %@", input, [self simplifyPath:input]);
}

- (void)longestPalindromicSubstring {
    NSString *input = @"babad";
    NSLog(@"Longest Palindrome Substring of %@: %@", input, [self longestPalindromicSubstringConstantSpace:input]);
    
    input = @"cbbd";
    NSLog(@"Longest Palindrome Substring of %@: %@", input, [self longestPalindromicSubstringConstantSpace:input]);
    
    input = @"abbaeae";
    NSLog(@"Longest Palindrome Substring of %@: %@", input, [self longestPalindromicSubstringDP:input]);
}

- (void)minimumWindowSubstring {
    NSString *S = @"ADOBECODEBANC";
    NSString *T = @"ABC";
    
    NSLog(@"Minimum window of %@ in %@: %@", T, S, [self minimumWindowSubstring:T inString:S]);
}

- (void)oneEditDistance {
    NSString *input1 = @"geek";
    NSString *input2 = @"geeks";
    NSLog(@"One edit distance between %@ and %@: %@",
          input1, input2, BOOLSTR([self oneEditDistanceBetweenString:input1 andString:input2]));
    
    input1 = @"geeks";
    input2 = @"geeks";
    NSLog(@"One edit distance between %@ and %@: %@",
          input1, input2, BOOLSTR([self oneEditDistanceBetweenString:input1 andString:input2]));
    
    input1 = @"geeks";
    input2 = @"geaks";
    NSLog(@"One edit distance between %@ and %@: %@",
          input1, input2, BOOLSTR([self oneEditDistanceBetweenString:input1 andString:input2]));
    
    input1 = @"peaks";
    input2 = @"geeks";
    NSLog(@"One edit distance between %@ and %@: %@",
          input1, input2, BOOLSTR([self oneEditDistanceBetweenString:input1 andString:input2]));



}

- (void)editDistance {
    NSString *input1 = @"sunday";
    NSString *input2 = @"saturday";
    NSLog(@"Edit distance between %@ and %@: %@",
          input1, input2, @([self editDistanceBetweenString:input1 andString:input2]));
    
    input1 = @"geek";
    input2 = @"gesek";
    NSLog(@"Edit distance between %@ and %@: %@",
          input1, input2, @([self editDistanceBetweenString:input1 andString:input2]));
    
    input1 = @"cat";
    input2 = @"cut";
    NSLog(@"Edit distance between %@ and %@: %@",
          input1, input2, @([self editDistanceBetweenString:input1 andString:input2]));

}

- (void)commonStringBetweenStrings {
    NSString *input1 = @"abcsdfc";
    NSString *input2 = @"bcsr";
    NSInteger k = 2;
    NSLog(@"Common String Between %@ and %@ longger than %@: %@",
          input1, input2, @(k),
          BOOLSTR([self commonStringBetweenString:input1 andString:input2 longerThanOrEqualToK:k]));
    
    input1 = @"abcsdfc";
    input2 = @"bcsr";
    k = 5;
    NSLog(@"Common String Between %@ and %@ longger than %@: %@",
          input1, input2, @(k),
          BOOLSTR([self commonStringBetweenString:input1 andString:input2 longerThanOrEqualToK:k]));

}

- (void)generateParentheses {
    NSInteger pair = 3;
    NSLog(@"Combinations for %@ pairs of parentheses: %@", @(pair), [self generateParentheses:pair]);
}

- (void)letterCombinations {
    NSString *input = @"23";
    NSLog(@"Letter combinations of %@: %@", input, [self letterCombinationsOfPhoneNumber:input]);
}

- (void)wordBreakII {
    NSString *input = @"catsanddog";
    NSArray *dict = @[@"cat", @"cats", @"and", @"sand", @"dog"];
    NSLog(@"%@ can be broken into: %@", input, [self wordBreakIIBetter:input dictionary:dict]);
}

- (void)validPalindrome {
    NSString *input = @"A man, a plan, a canal: Panama";
    NSLog(@"%@ is palindrome: %@", input, @([self isPalindrome:input]));
    
    input = @"race a car";
    NSLog(@"%@ is palindrome: %@", input, @([self isPalindrome:input]));
    
    input = @"a aa b c a a a";
    NSLog(@"%@ is palindrome: %@", input, @([self isPalindrome:input]));
    
    input = @"a aa b  a a a";
    NSLog(@"%@ is palindrome: %@", input, @([self isPalindrome:input]));
}

- (void)findAllAnagrams {
    NSString *s = @"cbaebabacd";
    NSString *p = @"abc";
    NSLog(@"All anagram indexs of %@ in %@: %@", s, p, [self findAnagrams:s p:p]);
    
    s = @"abab";
    p = @"ab";
    NSLog(@"All anagram indexs of %@ in %@: %@", s, p, [self findAnagrams:s p:p]);
    
    s = @"aaaaaa";
    p = @"a";
    NSLog(@"All anagram indexs of %@ in %@: %@", s, p, [self findAnagrams:s p:p]);

}

- (void)decodeWays {
    NSString *input = @"1234234127311012";
    NSLog(@"Decode %@ into %@", input, [self decodeWays:input]);
}

- (void)balanceParentheses {
    NSString *input = @"((bc)";
    NSLog(@"Balance %@: %@", input, [self balanceParenthesesWithoutStack:input]);
    
    input = @")))a((";
    NSLog(@"Balance %@: %@", input, [self balanceParenthesesWithoutStack:input]);
    
    input = @"(a(b)";
    NSLog(@"Balance %@: %@", input, [self balanceParenthesesWithoutStack:input]);
    
    input = @"(a(((b";
    NSLog(@"Balance %@: %@", input, [self balanceParenthesesWithoutStack:input]);
    
    input = @")))a((b)";
    NSLog(@"Balance %@: %@", input, [self balanceParenthesesWithoutStack:input]);
    
    input = @"(a((b))))))";
    NSLog(@"Balance %@: %@", input, [self balanceParentheseWithStack:input]);
}

- (void)prettyJSONFormat {
    NSString *input = @"{A: 'B', C: {D: 'E', F: {G: 'H', I: 'J'}}}";
    for (NSString *line in [self printPrettyJson:input]) {
        NSLog(@"%@", line);
    }
}

- (void)removeInvalidParentheses {
    NSString *input = @"(a())())";
    NSLog(@"Outputs of %@: %@", input, [self removeInvalidParentheses:input]);
    
    input = @")(";
    NSLog(@"Outputs of %@: %@", input, [self removeInvalidParentheses:input]);
    
    input = @"((((((((((()";
    NSLog(@"Outputs of %@: %@", input, [self removeInvalidParentheses:input]);
}

- (void)fastEnumeration {
    NSDictionary<NSString *, NSNumber *> *counter = @{
                                                      @"test1" : @(1),
                                                      @"test2" : @(2)
                                                      };
    for (NSString *key in counter) {
        NSLog(@"%@ : %@", key, counter[key].stringValue);
    }
}

- (void)arrayInitialization {
    NSNumber *numObjs[5] = { @(1), @(2), @(3), @(4), @(5) };
    NSLog(@"Array from C array: %@", [NSArray arrayWithObjects:numObjs count:5]);
    
    NSInteger nums[5] = { 1, 2, 3, 4, 5 };
    // http://stackoverflow.com/questions/32842753/memset-showing-wrong-results
    // The  memset()  function  fills  the  first  n  bytes of the memory area
    // pointed to by s with the "constant byte c".
    // NOTICE: ONLY use memset for setting "0", NOT other values
    memset(nums, 0, sizeof(NSInteger) * 5);
    NSMutableArray<NSNumber *> *numsStr = [NSMutableArray array];
    for (NSInteger i=0; i<5; i++) {
        [numsStr addObject:@(nums[i])];
    }
    NSLog(@"C array after memset %@:", [numsStr componentsJoinedByString:@", "]);
}

- (void)numberInitializationTest {
    // WRONG: compiler error
    // NSNumber * nilNumber = @(nil);
}

- (void)binarySearchIndexTest {
    NSArray<NSNumber *> *sortedNumbers = @[@(1), @(3), @(4), @(4), @(4), @(5), @(9)];
    NSString *sortedNumbersString = [sortedNumbers componentsJoinedByString:@", "];
    NSInteger insertIndex =
    [sortedNumbers indexOfObject:@(8)
                   inSortedRange:NSMakeRange(0, sortedNumbers.count)
                         options:NSBinarySearchingInsertionIndex
                 usingComparator:^NSComparisonResult(NSNumber *num1, NSNumber *num2) {
                     return [num1 compare:num2];
                 }];
    NSLog(@"Insertion Index of 8 in array [%@]: %@", sortedNumbersString, @(insertIndex));
    
    insertIndex =
    [sortedNumbers indexOfObject:@(10)
                   inSortedRange:NSMakeRange(0, sortedNumbers.count)
                         options:NSBinarySearchingInsertionIndex
                 usingComparator:^NSComparisonResult(NSNumber *num1, NSNumber *num2) {
                     return [num1 compare:num2];
                 }];
    NSLog(@"Insertion Index of 10 in array [%@]: %@", sortedNumbersString, @(insertIndex));

    
    insertIndex =
    [sortedNumbers indexOfObject:@(4)
                   inSortedRange:NSMakeRange(0, sortedNumbers.count)
                         options:NSBinarySearchingInsertionIndex
                 usingComparator:^NSComparisonResult(NSNumber *num1, NSNumber *num2) {
                     return [num1 compare:num2];
                 }];
    NSLog(@"Insertion Index of 4 in array [%@]: %@", sortedNumbersString, @(insertIndex));
    
    NSInteger index =
    [sortedNumbers indexOfObject:@(4)
                   inSortedRange:NSMakeRange(0, sortedNumbers.count)
                         options:NSBinarySearchingFirstEqual
                 usingComparator:^NSComparisonResult(NSNumber *num1, NSNumber *num2) {
                     return [num1 compare:num2];
                 }];
    NSLog(@"First Index (lower bound) of 4 in array [%@]: %@", sortedNumbersString, @(index));
    
    index =
    [sortedNumbers indexOfObject:@(4)
                   inSortedRange:NSMakeRange(0, sortedNumbers.count)
                         options:NSBinarySearchingLastEqual
                 usingComparator:^NSComparisonResult(NSNumber *num1, NSNumber *num2) {
                     return [num1 compare:num2];
                 }];
    NSLog(@"Last Index (upper bound) of 4 in array [%@]: %@", sortedNumbersString, @(index));
}

#pragma mark - Private

#pragma mark - Cancellable Dispatch After

- (CancelToken *)cancelable_dispatch_after:(dispatch_time_t)after
                                     queue:(dispatch_queue_t)queue
                                     block:(dispatch_block_t)block {
    CancelToken *cancelToken = [CancelToken new];
    
    dispatch_after(after, queue, ^{
        if (!cancelToken.isCancelled && block) {
            block();
        }
    });
    
    return cancelToken;
}

#pragma mark - Regular Expression Matching

- (BOOL)isMatch:(NSString *)s p:(NSString *)p {
    if (s == nil || p == nil) return NO;
    BOOL dp[s.length+1][p.length+1];
    // initialize the dp container
    // empty string matches empty string
    dp[0][0] = YES;
    // if the length of p is 0, then we would say s is not match to empty string
    for (NSInteger i=1; i<=s.length; i++) dp[i][0] = NO;
    // if the length of s is 0, then if the previous character in p p[j-1] == '*'
    // and also previous character is NOT the first one, then we could say dp[0][j] = dp[0][j-2]
    for (NSInteger j=1; j<=p.length; j++) {
        unichar c = [p characterAtIndex:j-1];
        dp[0][j] = j > 1 && c == '*' && dp[0][j-2];
    }
    
    // now we can build the DP table
    for (NSInteger i=1; i<=s.length; i++) {
        for (NSInteger j=1; j<=p.length; j++) {
            unichar sc = [s characterAtIndex:i-1];
            unichar pc = [p characterAtIndex:j-1];
            if (pc != '*') {
                dp[i][j] = dp[i-1][j-1] && (sc == pc || pc == '.');
            } else if (j > 1) {
                unichar pcc = [p characterAtIndex:j-2];
                dp[i][j] = dp[i][j-2] || ((sc == pcc || pcc == '.') && dp[i-1][j]);
            }
        }
    }
    return dp[s.length][p.length];
}


#pragma mark - Expression Add Operators

/**
 1. overflow
 2. '0' multiplication
 3. continuously multiplication operations -> we need to remember the "previous" result!
 */
- (NSArray<NSString *> *)expressionAddOperators:(NSString *)digits target:(NSInteger)target {
    if (!digits || !digits.length) {
        return nil;
    }
    NSMutableArray<NSString *> *results = [NSMutableArray array];
    [self expressionAddOperatorsHelper:digits target:target sum:0
                                 start:0 previousMultiply:0
                                result:@"" results:results];
    return results;
}

- (void)expressionAddOperatorsHelper:(NSString *)digits target:(NSInteger)target sum:(NSInteger)sum
                               start:(NSInteger)start previousMultiply:(NSInteger)multed
                              result:(NSString *)result results:(NSMutableArray<NSString *> *)results {
    if (start == digits.length) {
        if (target == sum) {
            [results addObject:[result copy]];
        }
        return;
    }
    
    for (NSInteger i = start; i < digits.length; i++) {
        // if the digit at 'start' index is '0', then we skip follow recursion EXCEPT the first '0'
        if (i != start && [digits characterAtIndex:start] == '0') {
            break;
        }
        
        NSInteger num = [digits substringWithRange:NSMakeRange(start, i-start+1)].integerValue;
        
        if (start == 0) {
            [self expressionAddOperatorsHelper:digits target:target sum:num
                                         start:i+1 previousMultiply:num
                                        result:@(num).stringValue
                                       results:results];
        } else {
            // Add operation
            [self expressionAddOperatorsHelper:digits target:target sum:sum+num
                                         start:i+1 previousMultiply:num
                                        result:[result stringByAppendingFormat:@"%@%@", @"+", @(num)]
                                       results:results];
            // Minus operation
            [self expressionAddOperatorsHelper:digits target:target sum:sum-num
                                         start:i+1 previousMultiply:-num
                                        result:[result stringByAppendingFormat:@"%@%@", @"-", @(num)]
                                       results:results];
            
            // Multiply operation
            [self expressionAddOperatorsHelper:digits target:target sum:sum-multed+multed*num
                                         start:i+1 previousMultiply:multed*num
                                        result:[result stringByAppendingFormat:@"%@%@", @"*", @(num)]
                                       results:results];
        }
    }
}

#pragma mark - Count All Palindrome Substrings

// length >= 2
- (NSInteger)countAllPalindromeSubstrings:(NSString *)input {
    if (!input || input.length < 2) {
        return 0;
    }
    
    BOOL flags[input.length][input.length];
    NSInteger counts[input.length][input.length];
    
    memset(flags, 0, sizeof(flags));
    memset(counts, 0, sizeof(counts));
    
    for (NSInteger i = input.length - 1; i >= 0; i--) {
        for (NSInteger j = i; j < input.length; j++) {
            // j - i < 3 means "a", "aa" and "aba" are all valid for this checking.
            flags[i][j] = ([input characterAtIndex:i] == [input characterAtIndex:j]) && (j - i < 3 || flags[i+1][j-1]);
            
            // make sure to exclude i == j. This is important to solve boundary issues, like counts[i+1][j]
            if (i == j) {
                continue;
            }
            if (flags[i][j]) {
                // counts[i+1][j-1] means removing common palindromic substring
                counts[i][j] = counts[i][j-1] + counts[i+1][j] + 1 - counts[i+1][j-1];
            } else {
                counts[i][j] = counts[i][j-1] + counts[i+1][j] - counts[i+1][j-1];
            }
        }
    }
    // from 0 to length-1
    return counts[0][input.length - 1];
}

#pragma mark - Shortest Palindrome

// scan from left to right, and recursion
- (NSString *)shortestPalindrome:(NSString *)input {
    if (!input || !input.length) {
        return nil;
    }
    NSInteger left = 0, right = input.length-1;
    while (right >= 0) {
        if ([input characterAtIndex:left] == [input characterAtIndex:right]) {
            left++;
        }
        right--;
    }
    if (left == input.length) {
        return input;
    }
    NSString *suffix = [input substringFromIndex:left];
    NSString *prefix = [self reverseString:suffix];
    NSString *middle = [self shortestPalindrome:[input substringToIndex:left]];
    return [NSString stringWithFormat:@"%@%@%@", prefix, middle, suffix];
}

- (NSString *)reverseString:(NSString *)input {
    if (!input || !input.length) {
        return input;
    }
    return [[[[input componentsSeparatedByString:@""]
              reverseObjectEnumerator]
             allObjects]
            componentsJoinedByString:@""];
}

// Longest Palindromic Substring style
- (NSString *)shortestPalindromeLPS:(NSString *)input {
    if (!input || !input.length) {
        return nil;
    }
    // we cut the input string, and ONLY check left half.
    NSInteger mid = input.length / 2;
    NSString *result = nil;
    
    // start from mid, in order to check from "shortest" to "longest"
    for (NSInteger i = mid; i >= 0; i--) {
        result = [self expendHelper:input left:i right:i];
        if (result) return result;
        result = [self expendHelper:input left:i-1 right:i];
        if (result) return result;
    }
    return result;
}

- (NSString *)expendHelper:(NSString *)input left:(NSInteger)left right:(NSInteger)right {
    if (!input || !input.length) {
        return nil;
    }
    while (left >= 0 && right < input.length) {
        if ([input characterAtIndex:left] != [input characterAtIndex:right]) {
            break;
        }
        left--; right++;
    }
    if (left >= 0) {
        return nil;
    }
    NSString *back = [input substringFromIndex:right];
    NSMutableString *front = [NSMutableString string];
    for (NSInteger i = back.length - 1; i >= 0; i--) {
        [front appendFormat:@"%C", [input characterAtIndex:i]];
    }
    return [NSString stringWithFormat:@"%@%@", front, input];
}

#pragma mark - Simplify Path

- (NSString *)simplifyPath:(NSString *)path {
    if (!path || !path.length) {
        return nil;
    }
    
    NSScanner *pathScanner = [NSScanner scannerWithString:path];
    NSMutableArray<NSString *> *components = [NSMutableArray array];

    while (!pathScanner.isAtEnd) {
        NSString *component;
        // skip '/'s
        if ([pathScanner scanString:@"/" intoString:NULL]) {
            continue;
        } else if ([pathScanner scanUpToString:@"/" intoString:&component]) {
            if (!component || [component isEqualToString:@"."]) {
                continue;
            } else if ([component isEqualToString:@".."]) {
                [components removeLastObject];
            } else {
                [components addObject:component];
            }
        }
    }
    
    // in order to make sure that the first '/' will be added
    [components insertObject:@"" atIndex:0];
    return [components componentsJoinedByString:@"/"];
}

#pragma mark - Longest Palindromic Substring

- (NSString *)longestPalindromicSubstringConstantSpace:(NSString *)s {
    if (!s) {
        return nil;
    }
    
    if (s.length < 2) {
        return s;
    }
    
    NSInteger start = 0;
    NSInteger maxLen = 0;
    
    for (NSInteger i = 0; i < s.length-1; i++) {
        [self maximumPalindromeIn:s from:i to:i start:&start maxLen:&maxLen];
        [self maximumPalindromeIn:s from:i to:i+1 start:&start maxLen:&maxLen];
    }
    
    return [s substringWithRange:NSMakeRange(start, maxLen)];
}

- (void)maximumPalindromeIn:(NSString *)s from:(NSInteger)i to:(NSInteger)j
                            start:(NSInteger *)start maxLen:(NSInteger *)maxLen {
    if (!s) {
        return;
    }
    
    while (i >= 0 && j < s.length) {
        if ([s characterAtIndex:i] != [s characterAtIndex:j]) {
            break;
        }
        i--; j++;
    }
    
    if (*maxLen < j - i - 1) {
        *maxLen = j - i - 1;
        *start = i + 1;
    }
}

- (NSString *)longestPalindromicSubstringDP:(NSString *)s {
    if (!s || !s.length) {
        return nil;
    }
    
    NSString *result = @"";
    BOOL dp[s.length][s.length];
    memset(dp, 0, sizeof(dp));
    
    // i MUST contain j, because we need to make sure that dp[i+1][j-1] has been calculated
    for (NSInteger i = s.length-1; i >= 0; i--) {
        for (NSInteger j = i; j < s.length; j++) {
            if ([s characterAtIndex:i] == [s characterAtIndex:j]) {
                // j-i == 1 -> single character; j-i == 2 -> double characters
                dp[i][j] = j-i < 3 || dp[i+1][j-1];
            }
            
            
            
            if (dp[i][j] && j-i+1 > result.length) {
                result = [s substringWithRange:NSMakeRange(i, j-i+1)];
            }
        }
    }
    
    return result;
}

#pragma mark - Minimum Window Substring

// Similar to "Find All Anagrams"
// S = "ADOBECODEBANC"
// T = "ABC"

- (NSString *)minimumWindowSubstring:(NSString *)T inString:(NSString *)S {
    if (!S || !T || !S.length || !T.length) {
        return nil;
    }
    
    NSMutableDictionary<NSString *, NSNumber *> *letters = [NSMutableDictionary dictionary];
    
    for (NSInteger i=0; i<T.length; i++) {
        NSString *c = [T substringWithRange:NSMakeRange(i, 1)];
        if (letters[c] == nil) {
            letters[c] = @(0);
        }
        letters[c] = @(letters[c].integerValue + 1);
    }
    
    NSString *result = nil;
    NSInteger start = 0, end = 0, count = 0;
    
    while (end < S.length) {
        NSString *ec = [S substringWithRange:NSMakeRange(end, 1)];
        
        if (!letters[ec]) {
            letters[ec] = @(letters[ec].integerValue - 1);
        }
        
        if (letters[ec].integerValue > 0) {
            count++;
        }
        
        end++;
        letters[ec] = @(letters[ec].integerValue - 1);  // for non-exist letters, it changes to negative number
        
        while (count == T.length) {
            if (!result || result.length > end-start) {
                result = [S substringWithRange:NSMakeRange(start, end-start)];
            }
            NSString *sc = [S substringWithRange:NSMakeRange(start, 1)];
            if (letters[sc].integerValue == 0) {
                count--;
            }
            letters[sc] = @(letters[sc].integerValue + 1);
            start++;
        }
    }
    
    return result;
}

#pragma mark - One Edit Distance

// Can be solved in the same way as edit distance, but the time complexity is O(M*N)
// Target is O(M+N)

- (BOOL)oneEditDistanceBetweenString:(NSString *)s1 andString:(NSString *)s2 {
    if (!s1 || !s2) {
        return NO;
    }
    // NOTICE: [NSString length] is NSUInteger, not NSInteger. NSUInteger - NSUInteger = NSUInteger
    NSInteger lengthDiff = s1.length - s2.length;
    if (ABS(lengthDiff > 1)) {
        return NO;
    }
    
    NSInteger editDistance = 0;
    NSInteger p1 = 0, p2 = 0;
    
    while (p1 < s1.length && p2 < s2.length) {
        unichar c1 = [s1 characterAtIndex:p1];
        unichar c2 = [s2 characterAtIndex:p2];
        if (c1 == c2) {
            p1++; p2++;
        } else {
            editDistance++;
            if (editDistance > 1) {
                return NO;
            }
            if (s1.length > s2.length) {
                p1++;
            } else if (s1.length < s2.length) {
                p2++;
            } else {
                p1++; p2++;
            }
        }
    }
    
    // check the last character if necessary
    if (p1 < s1.length || p2 < s2.length) {
        editDistance++;
    }
    
    return editDistance == 1;
}

#pragma mark - Edit Distance

// O(M*N)

- (NSInteger)editDistanceBetweenString:(NSString *)s1 andString:(NSString *)s2 {
    if (!s1 || !s2 || !s1.length || !s2.length) return -1;
    NSInteger dp[s1.length+1][s2.length+1];
    for (NSInteger i = 0; i <= s1.length; i++) {
        dp[i][0] = i;
    }
    
    for (NSInteger i = 0; i <= s2.length; i++) {
        dp[0][i] = i;
    }
    
    for (NSInteger start1 = 1; start1 <= s1.length; start1++) {
        for (NSInteger start2 = 1; start2 <= s2.length; start2++) {
            unichar c1 = [s1 characterAtIndex:start1-1];
            unichar c2 = [s2 characterAtIndex:start2-1];
            if (c1 == c2) {
                dp[start1][start2] = dp[start1-1][start2-1];
            } else {
                /*
                 insert in s1: dp[start1][start2-1]
                 delete in s1: dp[start1-1][start2]
                 replace s1 and s2: dp[start1-1][start2-1]
                 */
                dp[start1][start2] = 1 + MIN(MIN(dp[start1-1][start2], dp[start1][start2-1]),
                                         dp[start1-1][start2-1]);
            }
        }
    }
    return dp[s1.length][s2.length];
}

#pragma mark - Common String Longer Than Or Equal to K

- (BOOL)commonStringBetweenString:(NSString *)s1 andString:(NSString *)s2 longerThanOrEqualToK:(NSInteger)k {
    if (!s1 || !s2 || !s1.length || !s2.length) {
        return NO;
    }
    NSInteger dp[s1.length+1][s2.length+1];
    for (NSInteger row = 0; row <= s1.length; row++) {
        dp[row][0] = 0;
    }
    for (NSInteger col = 0; col <= s2.length; col++) {
        dp[0][col] = 0;
    }
    
    for (NSInteger start1 = 1; start1 <= s1.length; start1++) {
        for (NSInteger start2 = 1; start2 <= s2.length; start2++) {
            // dp[start1][start2]
            unichar c1 = [s1 characterAtIndex:start1-1];
            unichar c2 = [s2 characterAtIndex:start2-1];
            if (c1 == c2) {
                dp[start1][start2] = dp[start1-1][start2-1]+1;
            } else {
                dp[start1][start2] = 0;
            }
            if (dp[start1][start2] >= k) {
                return YES;
            }
        }
    }
    
    return NO;
}

#pragma mark - Generate Parenthesis

- (NSArray<NSString *> *)generateParentheses:(NSInteger)n {
    NSMutableArray<NSString *> *results = [NSMutableArray array];
    if (!n) {
        return results;
    }
    [self generateParenthesesHelperWithLeft:n right:n result:[NSMutableString string] results:results];
    return results;
}

- (void)generateParenthesesHelperWithLeft:(NSInteger)left right:(NSInteger)right
                                   result:(NSMutableString *)result
                                  results:(NSMutableArray<NSString *> *)results {
    if (left == 0 && right == 0) {
        [results addObject:[result copy]];
        return;
    }
    
    if (left) {
        [result appendString:@"("];
        [self generateParenthesesHelperWithLeft:left-1 right:right result:result results:results];
        [result deleteCharactersInRange:NSMakeRange(result.length-1, 1)];
    }
    
    if (right && right > left) {
        [result appendString:@")"];
        [self generateParenthesesHelperWithLeft:left right:right-1 result:result results:results];
        [result deleteCharactersInRange:NSMakeRange(result.length-1, 1)];
    }
        
}

#pragma mark - Letter Combinations of Phone Number

- (NSArray<NSString *> *)letterCombinationsOfPhoneNumber:(NSString *)phoneNumber {
    if (!phoneNumber || !phoneNumber.length) {
        return nil;
    }
    NSMutableArray<NSString *> *results = [NSMutableArray array];
    [self phoneNumberHelper:phoneNumber start:0 result:[NSMutableString string] results:results];
    return results;
}

- (void)phoneNumberHelper:(NSString *)phoneNumber start:(NSInteger)start
                   result:(NSMutableString *)result results:(NSMutableArray *)results {
    if (start == phoneNumber.length) {
        [results addObject:[result copy]];
        return;
    }
    NSInteger digit = [phoneNumber characterAtIndex:start] - '0';
    NSArray<NSString *> *letters = [self digitToLetters:digit];
    for (NSString *letter in letters) {
        [result appendString:letter];
        [self phoneNumberHelper:phoneNumber start:start+1 result:result results:results];
        [result deleteCharactersInRange:NSMakeRange(result.length-1, 1)];
    }
}

- (NSArray<NSString *> *)digitToLetters:(NSInteger)digit {
    return [@[
              @[@""],
              @[@""],
              @[@"a", @"b", @"c"],
              @[@"d", @"e", @"f"],
              @[@"g", @"h", @"i"],
              @[@"j", @"k", @"l"],
              @[@"m", @"n", @"o"],
              @[@"p", @"q", @"r", @"s"],
              @[@"w", @"x", @"y", @"z"]
              ] objectAtIndex:digit];
}

#pragma mark - Word Break II

- (NSArray<NSString *> *)wordBreakIIBetter:(NSString *)s dictionary:(NSArray<NSString *> *)wordDict {
    return [self betterDFS:s dictionary:[NSSet setWithArray:wordDict] cache:[NSMutableDictionary dictionary]];
}

- (NSArray<NSString *> *)betterDFS:(NSString *)s dictionary:(NSSet<NSString *> *)wordDict cache:(NSMutableDictionary *)cache {
    if (cache[s]) {
        return cache[s];
    }
    NSMutableArray<NSString *> *results = [NSMutableArray array];
    if (s.length == 0) {
        [results addObject:@""];
        return results;
    }
    
    for (NSInteger i=1; i<=s.length; i++) {
        NSString *word = [s substringToIndex:i];
        if ([wordDict containsObject:word]) {
            NSString *followWord = [s substringFromIndex:i];
            NSArray<NSString *> *followResults = [self betterDFS:followWord dictionary:wordDict cache:cache];
            for (NSString *followResult in followResults) {
                NSString *result = [word stringByAppendingFormat:@"%@%@", followResult.length ? @" " : @"", followResult];
                [results addObject:result];
            }
        }
    }
    cache[s] = results;
    return results;
}

- (NSArray<NSString *> *)wordBreakII:(NSString *)s dictionary:(NSArray<NSString *> *)wordDict {
    return [self DFS:s dictionary:wordDict cache:[NSMutableDictionary dictionary]];
}

- (NSArray<NSString *> *)DFS:(NSString *)s dictionary:(NSArray<NSString *> *)wordDict
                       cache:(NSMutableDictionary<NSString *, NSMutableArray<NSString *> *> *)cache {
    // return cache value if found
    if (cache[s]) return cache[s];
    
    NSMutableArray<NSString *> *results = [NSMutableArray array];
    // return empty array for empty string
    if (s.length == 0) {
        [results addObject:@""];
        return results;
    }
    
    // now we start to find words from dictionary set word by word
    for (NSString *word in wordDict) {
        if ([s hasPrefix:word]) {
            // backtracking now
            NSString *follow = [s substringFromIndex:word.length];
            NSArray<NSString *> *followWords = [self DFS:follow dictionary:wordDict cache:cache];
            for (NSString *followWord in followWords) {
                NSString *result = [word stringByAppendingFormat:@"%@%@", followWord.length ? @" " : @"", followWord];
                [results addObject:result];
            }
        }
    }
    cache[s] = results;
    return results;
}

#pragma mark - Valid Palindrome

- (BOOL)isPalindrome:(NSString *)s {
    NSInteger left = 0, right = s.length-1;
    NSCharacterSet *alphanumeric = [NSCharacterSet alphanumericCharacterSet];
    while (left < right) {
        while (left < right && ![alphanumeric characterIsMember:[s characterAtIndex:left]]) left++;
        while (left < right && ![alphanumeric characterIsMember:[s characterAtIndex:right]]) right--;
        NSString *lc = [s substringWithRange:NSMakeRange(left, 1)];
        NSString *rc = [s substringWithRange:NSMakeRange(right, 1)];
        if (![lc.lowercaseString isEqualToString:rc.lowercaseString]) return NO;
        left++; right--;
    }
    return YES;
}

#pragma mark - Find All Anagrams

- (NSArray<NSNumber *> *)findAnagrams:(NSString *)s p:(NSString *)p {
    NSMutableDictionary<NSString *, NSNumber *> *hashTable = [NSMutableDictionary dictionary];
    NSMutableArray<NSNumber *> *results = [NSMutableArray array];
    
    // put all letters in p into hash table, count them
    for (NSInteger i=0; i<p.length; i++) {
        NSString *c = [p substringWithRange:NSMakeRange(i,1)];
        if (!hashTable[c]) hashTable[c] = @(1);
        else hashTable[c] = @(hashTable[c].integerValue+1);
    }
    
    // now we iterate s from beginning to end
    NSInteger count = p.length;
    NSInteger start = 0, end = 0;
    while (end < s.length) {
        NSString *c = [s substringWithRange:NSMakeRange(end,1)];
        
        // if current character is not in p, we still add them into hash table
        if (!hashTable[c]) hashTable[c] = @(0);
        
        // decrease the total count and letter count by 1
        if (hashTable[c].integerValue > 0) count--;
        
        hashTable[c] = @(hashTable[c].integerValue-1);
        // move the end pointer to next one
        end++;
        
        // if count == 0, then we find a anagram of p.
        if (count == 0) [results addObject:@(start)];
        
        if (end - start == p.length) {
            NSString *sc = [s substringWithRange:NSMakeRange(start, 1)];
            // here we filter out all non-anagram letters, whose count is -1.
            hashTable[sc] = @(hashTable[sc].integerValue+1);
            if (hashTable[sc].integerValue > 0) count++;
            start++;
        }
    }
    // http://stackoverflow.com/questions/27389591/best-practice-return-mutablearray-copy-or-mutablearray-if-return-type-is-nsarra
    /* Generally speaking:
     If your caller is following these guidelines, just return the mutable array since it's slightly cheaper, 	   and the caller won't mutate it.
     If you're not sure whether caller might not follow these guidelines, and you want to code defensively, 	   return an immutable copy using array.copy.
     **/
    return [results copy];
}

#pragma mark - Decode Ways

- (NSArray *)decodeWays:(NSString *)input {
    if (input == nil || input.length == 0) {
        return nil;
    }
    NSMutableArray *results = [NSMutableArray array];
    [self decodeHelperWithInput:input start:0 result:@"" results:results];
    return results;
}

- (void)decodeHelperWithInput:(NSString *)input start:(NSInteger)start
                       result:(NSString *)result results:(NSMutableArray *)results {
    if (start >= input.length) {
        [results addObject:[result copy]];
        return;
    }
    NSInteger d1 = [input substringWithRange:NSMakeRange(start, 1)].integerValue;
    if (d1 == 0) {
        return;
    }
    if (d1 > 0 && d1 <= 9) {
        [self decodeHelperWithInput:input start:start+1
                             result:[result stringByAppendingString:[self decodeFromInteger:d1]]
                            results:results];
    }
    if (start < input.length-1) {
        NSInteger d2 = [input substringWithRange:NSMakeRange(start, 2)].integerValue;
        if (d2 > 0 && d2 <= 26) {
            [self decodeHelperWithInput:input start:start+2
                                 result:[result stringByAppendingString:[self decodeFromInteger:d2]]
                                results:results];
        }
    }
}

- (NSString *)decodeFromInteger:(NSInteger)input {
    if (input <= 0 || input > 26) {
        return nil;
    }
    return @{
             @(1) : @"A",  @(2) : @"B", @(3) : @"C", @(4) : @"D",
             @(5) : @"E",  @(6) : @"F", @(7) : @"G", @(8) : @"H",
             @(9) : @"I",  @(10) : @"G", @(11) : @"K", @(12) : @"L",
             @(13) : @"M", @(14) : @"N", @(15) : @"O", @(16) : @"P",
             @(17) : @"Q", @(18) : @"R", @(19) : @"S", @(20) : @"T",
             @(21) : @"U", @(22) : @"V", @(23) : @"W", @(24) : @"X",
             @(25) : @"Y", @(26) : @"Z",
             }[@(input)];
}

#pragma mark - Balance Parentheses

- (NSString *)balanceParentheseWithStack:(NSString *)input {
    if (!input || !input.length) {
        return nil;
    }
    
    NSString *result = @"";
    NSMutableArray<NSString *> *stack = [NSMutableArray array];
    NSMutableArray<NSNumber *> *lefts = [NSMutableArray array]; // IMPORTANT
    
    for (NSInteger i = 0; i < input.length; i++) {
        NSString *c = [input substringWithRange:NSMakeRange(i, 1)];
        if ([c isEqualToString:@"("]) {
                [stack addObject:c];
                [lefts addObject:@(stack.count-1)];
        } else if ([c isEqualToString:@")"]) {
            if (lefts.lastObject) {
                NSInteger lastLeftIndex = lefts.lastObject.integerValue;
                NSString *left = [[stack subarrayWithRange:NSMakeRange(lastLeftIndex, stack.count-lastLeftIndex)] componentsJoinedByString:@""];
                result = [NSString stringWithFormat:@"%@%@%@", left, result, c];
                [lefts removeLastObject];
                [stack removeObjectsInRange:NSMakeRange(lastLeftIndex, stack.count-lastLeftIndex)];
            }
        } else {
            [stack addObject:c];
        }
    }
    if (stack.count) {
        NSString *restChars = [[stack componentsJoinedByString:@""] stringByReplacingOccurrencesOfString:@"(" withString:@""];
        result = [NSString stringWithFormat:@"%@%@", restChars, result];
    }
    return result;
}

- (NSString *)balanceParenthesesWithoutStack:(NSString *)input {
    // use stack to mark the index of '('. pop top when meeting ')'
    NSString *result = [self removeRightParentheses:input];
    result = [self removeLeftParentheses:result];
    return result;
}

- (NSString *)removeRightParentheses:(NSString *)input {
    NSInteger count = 0;
    NSMutableString *result = [NSMutableString string];
    for (NSInteger i=0; i<input.length; i++) {
        unichar c = [input characterAtIndex:i];
        [result appendFormat:@"%C", c];
        if (c == '(') count++;
        else if (c == ')') {
            if (count > 0) count--;
            else [result deleteCharactersInRange:NSMakeRange(result.length-1, 1)];
        }
    }
    return result;
}

- (NSString *)removeLeftParentheses:(NSString *)input {
    NSInteger count = 0;
    NSMutableString *result = [NSMutableString string];
    for (NSInteger i=input.length-1; i>=0; i--) {
        unichar c = [input characterAtIndex:i];
        [result insertString:[NSString stringWithFormat:@"%C", c] atIndex:0];
        if (c == ')') count++;
        else if (c == '(') {
            if (count > 0) count--;
            else [result deleteCharactersInRange:NSMakeRange(0, 1)];
        }
    }
    return result;
}

#pragma mark - Print Pretty JSON

- (NSArray<NSString *> *)printPrettyJson:(NSString *)json {
    if (!json) {
        return nil;
    }
    NSMutableArray<NSString *> *results = [NSMutableArray array];
    NSMutableString *indent = [NSMutableString string];
    unichar indentChar = '\t';
    NSMutableString *line = nil;
    
    for (NSInteger i = 0; i < json.length; i++) {
        unichar c = [json characterAtIndex:i];
        switch (c) {
            case '{':
            case '[':
                [self addLine:line toResults:results];
                [self addLine:[NSString stringWithFormat:@"%@%C", indent, c] toResults:results];
                [self increaseIndent:indent withChar:indentChar];
                line = [indent mutableCopy];
                break;
            case '}':
            case ']':
                if (![line isEqualToString:indent]) {
                    [self addLine:line toResults:results];
                }
                [self decreaseIndent:indent];
                [self addLine:[NSString stringWithFormat:@"%@%C", indent, c] toResults:results];
                line = [indent mutableCopy];
                break;
            case ',':
                [self addCharacter:c toLine:line];
                [self addLine:line toResults:results];
                line = [indent mutableCopy];
                break;
            case ' ':
                break;
            default:
                [self addCharacter:c toLine:line];
                break;
        }
    }
    
    return results;
}

- (void)addCharacter:(unichar)c toLine:(NSMutableString *)line {
    if (line) {
        [line appendFormat:@"%C", c];
    }
}

- (void)addLine:(NSString *)line toResults:(NSMutableArray<NSString *> *)results {
    if (line) {
        [results addObject:[line copy]];
    }
}

- (void)increaseIndent:(NSMutableString *)indent withChar:(unichar)indentChar {
    if (indent) {
        [indent appendFormat:@"%C",indentChar];
    }
}

- (void)decreaseIndent:(NSMutableString *)indent {
    if (indent) {
        [indent deleteCharactersInRange:NSMakeRange(indent.length-1, 1)];
    }
}

#pragma mark - Remove Invalide Parentheses

- (NSArray<NSString *> *)removeInvalidParentheses:(NSString *)s {
    if (s == nil) return nil;
    NSMutableArray<NSString *> *results = [NSMutableArray array];
    NSMutableArray<NSString *> *queue = [NSMutableArray array];
    NSMutableSet<NSString *> *visited = [NSMutableSet set];
    BOOL found = NO;
    [queue addObject:s];
    while (queue.count) {
        NSString *front = queue.firstObject;
        [queue removeObjectAtIndex:0];
        if ([self isValid:front]) {
            found = YES;
            [results addObject:front];
        }
        // if this node is valid, it's children MUST be invalid, due to removing one more parenthese.
        if (found) continue;
        for (NSUInteger i=0; i<front.length; i++) {
            if (![self isParenthesis:[front characterAtIndex:i]]) continue;
            NSMutableString *mutableFront = [front mutableCopy];
            [mutableFront deleteCharactersInRange:NSMakeRange(i,1)];
            if (![visited containsObject:mutableFront]) {
                [visited addObject:mutableFront];
                [queue addObject:mutableFront];
            }
        }
    }
    return results;
}

- (BOOL)isValid:(NSString *)s {
    NSInteger count = 0;
    for (NSUInteger i=0; i<s.length; i++) {
        if ([s characterAtIndex:i] == '(') {
            count++;
        } else if ([s characterAtIndex:i] == ')') {
            count--;
        }
        if (count < 0) return NO;
    }
    return count == 0;	// it is possible that count > 0, which means we have more '('s
}

- (BOOL)isParenthesis:(unichar)c {
    return c == '(' || c == ')';
}

@end
