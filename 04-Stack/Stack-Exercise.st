!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:48'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'TC 5/15/2022 19:23:05'!
test01CreateFinderWithEmptyStack 
	SentenceFinderByPrefix new initializeWithStack: (OOStack new). ! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'VB 5/16/2022 14:55:33'!
test02NoResultsOnEmptyStack 
	| emptySentenceFinder |
	emptySentenceFinder := SentenceFinderByPrefix new initializeWithStack: (OOStack new).
	
	self assert: ((emptySentenceFinder find: 'hola') size = 0).
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'TC 5/15/2022 20:18:18'!
test03FindOneResult
	| StackFinder stack |
	stack := OOStack new.
	StackFinder := SentenceFinderByPrefix new initializeWithStack: (stack).
	stack push: 	'Hola'.
	self assert: ((StackFinder find: 'Ho') size = 1).
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'TC 5/15/2022 20:19:56'!
test04DoNotFindWithDifferentCase
	| StackFinder stack |
	stack := OOStack new.
	StackFinder := SentenceFinderByPrefix new initializeWithStack: (stack).
	stack push: 	'Hola'.
	self assert: ((StackFinder find: 'ho') size = 0).
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'TC 5/15/2022 20:28:17'!
test05FindMultiplePrefixes
	| StackFinder stack result |
	stack := OOStack new.
	StackFinder := SentenceFinderByPrefix new initializeWithStack: (stack).
	stack push: 	'First'.
	stack push: 	'Second'.
	stack push: 	'Third'.
	stack push: 	'Fourth'.
	stack push: 	'Fifth'.
	
	result := StackFinder find: 'Fi'.

	result detect: [ :aResult | aResult = 'First' ] ifNone: [ self error: 'First not found' ]. 	
	result detect: [ :aResult | aResult = 'Fifth' ] ifNone: [ self error: 'Fifth not found' ]. 	
	
	self assert: (result size = 2).
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'TC 5/15/2022 21:08:24'!
test06PrefixWithSpacesIsInvalid
	| sentenceFinder |
	sentenceFinder := SentenceFinderByPrefix new initializeWithStack: (OOStack new). 
	self
		should: [ sentenceFinder find: ' ' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Prefix PrefixValidationErrorDescription ]
		

	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'TC 5/15/2022 21:11:49'!
test07EmptyPrefixIsInvalid
	| sentenceFinder |
	sentenceFinder := SentenceFinderByPrefix new initializeWithStack: (OOStack new). 
	self
		should: [ sentenceFinder find: '' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Prefix PrefixValidationErrorDescription ]
		

	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'TC 5/15/2022 21:14:06'!
test08FindFullSentence
	| StackFinder stack result |
	stack := OOStack new.
	StackFinder := SentenceFinderByPrefix new initializeWithStack: (stack).
	stack push: 	'First'.
	stack push: 	'Second'.
	stack push: 	'Third'.
	stack push: 	'Fourth'.
	stack push: 	'Fifth'.
	
	result := StackFinder find: 'Second'.

	result detect: [ :aResult | aResult = 'Second' ] ifNone: [ self error: 'Second not found' ]. 	
	
	self assert: (result size = 1).
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'TC 5/15/2022 21:17:58'!
test09DoNotFindASubstringOfSentenceThatsNotAPrefix
	| StackFinder stack result |
	stack := OOStack new.
	StackFinder := SentenceFinderByPrefix new initializeWithStack: (stack).
	stack push: 	'First'.
	stack push: 	'Second'.
	stack push: 	'Third'.
	stack push: 	'Fourth'.
	stack push: 	'Fifth'.
	
	result := StackFinder find: 'econd'.
	
	self assert: (result size = 0).
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'TC 5/15/2022 21:20:48'!
test10FindMultipleOcurrencess
	| StackFinder stack result |
	stack := OOStack new.
	StackFinder := SentenceFinderByPrefix new initializeWithStack: (stack).
	stack push: 	'First'.
	stack push: 	'Second'.
	stack push: 'Second'.
	stack push: 	'Third'.
	stack push: 	'Fourth'.
	stack push: 	'Fifth'.
	
	result := StackFinder find: 'Second'.
	
	self assert: (result size = 2).
	! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'lastStackItem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'TC 5/14/2022 12:11:22'!
isEmpty
	^self size = 0. ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'TC 5/14/2022 12:09:59'!
pop
	| valueToReturn |
	valueToReturn := self top.
	lastStackItem := lastStackItem previousStackItem.
	^valueToReturn! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'TC 5/14/2022 12:08:27'!
push: aThing
	lastStackItem := StackItem withValue: aThing previousStackItem: lastStackItem. ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'TC 5/14/2022 12:10:54'!
size
	^lastStackItem position.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'TC 5/14/2022 12:10:58'!
top
	^lastStackItem itemValue.! !


!OOStack methodsFor: 'initialize' stamp: 'TC 5/14/2022 12:12:29'!
initialize
	lastStackItem := StackItemBase new. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #Prefix category: 'Stack-Exercise'!
Object subclass: #Prefix
	instanceVariableNames: 'stringPrefix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Prefix methodsFor: 'match' stamp: 'TC 5/15/2022 21:00:39'!
matchWithSentence: aSentenceString
	^(aSentenceString findString: stringPrefix startingAt: 1) = 1! !


!Prefix methodsFor: 'initialize' stamp: 'TC 5/15/2022 20:54:59'!
initializeWith: aPrefixString
	Prefix validateString: aPrefixString.
	stringPrefix := aPrefixString.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Prefix class' category: 'Stack-Exercise'!
Prefix class
	instanceVariableNames: ''!

!Prefix class methodsFor: 'error description' stamp: 'TC 5/15/2022 21:05:26'!
PrefixValidationErrorDescription
	^'Prefix is invalid'! !


!Prefix class methodsFor: 'initialize' stamp: 'TC 5/15/2022 21:17:41'!
validateString: aStringPrefix
	aStringPrefix size > 0 ifFalse: [ self error: self PrefixValidationErrorDescription ].
	aStringPrefix detect: [ :aCharacter | aCharacter = (' ' at: 1) ] ifFound: [ :aChar | 
		self error: self PrefixValidationErrorDescription.
	] ifNone: []! !

!Prefix class methodsFor: 'initialize' stamp: 'TC 5/15/2022 20:46:39'!
with: aPrefixString
	^self new initializeWith: aPrefixString! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'access' stamp: 'TC 5/15/2022 20:59:19'!
find: aSentencePrefixAsString
	| resultSentencesCollection prefix |
	
	resultSentencesCollection := OrderedCollection new. 
	prefix := Prefix with: aSentencePrefixAsString.
	
	self iterateStack: stack doOnEachIteration: [ :aStakItemSentence | 
		(prefix matchWithSentence: aStakItemSentence) ifTrue: [
			resultSentencesCollection addLast: aStakItemSentence. 
		]. 
	].

	^resultSentencesCollection ! !


!SentenceFinderByPrefix methodsFor: 'private' stamp: 'TC 5/15/2022 19:24:53'!
iterateStack: aStack doOnEachIteration: aCallbackClosure
	| tmpStack |
	tmpStack := OOStack new. 
	
	[ aStack size > 0 ] whileTrue: [
		tmpStack push: (aStack pop).
		aCallbackClosure value: (tmpStack top).
	].

	[ tmpStack size > 0 ] whileTrue: [
		aStack push: (tmpStack pop).
	].
	! !


!SentenceFinderByPrefix methodsFor: 'initialize' stamp: 'TC 5/15/2022 19:11:18'!
initializeWithStack: aStack
	stack := aStack. ! !


!classDefinition: #StackItem category: 'Stack-Exercise'!
Object subclass: #StackItem
	instanceVariableNames: 'itemValue previousStackItem position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackItem methodsFor: 'initialize' stamp: 'TC 5/14/2022 12:03:42'!
initializeWithValue: aThing previousStackItem: aPreviousStackItem
	itemValue := aThing.
	previousStackItem := aPreviousStackItem. 
	position := aPreviousStackItem position + 1. ! !


!StackItem methodsFor: 'as yet unclassified' stamp: 'TC 5/14/2022 12:03:15'!
itemValue
	^itemValue! !

!StackItem methodsFor: 'as yet unclassified' stamp: 'TC 5/14/2022 12:03:28'!
position
	^position! !

!StackItem methodsFor: 'as yet unclassified' stamp: 'TC 5/14/2022 12:03:20'!
previousStackItem
	^previousStackItem! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackItem class' category: 'Stack-Exercise'!
StackItem class
	instanceVariableNames: ''!

!StackItem class methodsFor: 'initialize' stamp: 'TC 5/14/2022 12:02:20'!
withValue: aThing previousStackItem: previousStackItem
	^StackItem new initializeWithValue: aThing previousStackItem: previousStackItem! !


!classDefinition: #StackItemBase category: 'Stack-Exercise'!
StackItem subclass: #StackItemBase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackItemBase methodsFor: 'as yet unclassified' stamp: 'TC 5/14/2022 12:05:03'!
itemValue
	self error: OOStack stackEmptyErrorDescription.! !

!StackItemBase methodsFor: 'as yet unclassified' stamp: 'TC 5/14/2022 12:05:15'!
position
	^0! !

!StackItemBase methodsFor: 'as yet unclassified' stamp: 'TC 5/14/2022 12:04:55'!
previousStackItem
	self error: OOStack stackEmptyErrorDescription.! !
