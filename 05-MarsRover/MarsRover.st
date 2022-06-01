!classDefinition: #MarsRoverTests category: 'MarsRover'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 19:34:02'!
test01NewRoverStartsWithPosition
	| marsRover |
	marsRover _ MarsRover new.
	self assert: (marsRover position = (0@0))! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 19:34:43'!
test02NewRoverStartsWithDirection
	| marsRover |
	marsRover _ MarsRover new.
	self assert: (marsRover direction = Direction north)! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 19:49:42'!
test03RoverCanGoForward
	| marsRover |
	marsRover _ MarsRover new.
	marsRover forward.
	self deny: (marsRover position = (0@0))! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 19:49:39'!
test04RoverCanGoBackward
	| marsRover |
	marsRover _ MarsRover new.
	marsRover backward.
	self deny: (marsRover position = (0@0))! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 19:50:30'!
test05MarsRoverCanTurnLeft
	| marsRover |
	marsRover _ MarsRover new.
	marsRover left.
	self assert: (marsRover direction = Direction west)! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 19:50:55'!
test06MarsRoverCanTurnRight
	| marsRover |
	marsRover _ MarsRover new.
	marsRover right.
	self assert: (marsRover direction = Direction east)! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 19:51:58'!
test07MarsRoverCanGoForwardMoreThanOne
	| marsRover |
	marsRover _ MarsRover new.
	marsRover forward .
	marsRover forward .
	self assert: (marsRover position = (0@2))! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 19:53:04'!
test08MarsRoverCanTurnLeftAndGoForward
	| marsRover |
	marsRover _ MarsRover new.
	marsRover left .
	marsRover forward .
	self assert: (marsRover position = (-1@0))! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 19:54:17'!
test09MarsRoverCanTurnLeftMoreThanOne
	| marsRover |
	marsRover _ MarsRover new.
	marsRover left .
	marsRover left .
	self assert: (marsRover direction = (Direction south)).
! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'TC 5/29/2022 12:55:02'!
test10MarsRoverCanReceiveForwardCommand
	| marsRover |
	marsRover _ MarsRover new.
	marsRover receiveCommands: 'f'.
	self deny: (marsRover position = (0@0)) ! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'TC 5/29/2022 12:55:05'!
test11MarsRoverCanReceiveBackwardCommand
	| marsRover |
	marsRover _ MarsRover new.
	marsRover receiveCommands: 'b'.
	self deny: (marsRover position = (0@0)) ! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'TC 5/29/2022 13:02:49'!
test12MarsRoverCanReceiveMultipleCommands
	| marsRover |
	marsRover _ MarsRover new.
	marsRover receiveCommands: 'ff'.
	self assert: (marsRover position = (0@2)) .
	marsRover receiveCommands: 'lff'.
	self assert: (marsRover position = (-2@2)) .! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'TC 5/29/2022 13:07:40'!
test13MarsRoverCanReceiveAllCommands
	| marsRover |
	marsRover _ MarsRover new.
	marsRover receiveCommands: 'fflfflbbrff'.
	self assert: (marsRover position = (-4@4)).
	"
  -4 4   
  ###
       #  
       ###     
	    #	
	    S
	"
	
! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'TC 5/29/2022 13:08:50'!
test14MarsRoverStopWhenWrongReceiveUnknownCommand
	| marsRover |
	marsRover _ MarsRover new.
	marsRover receiveCommands: 'fflffxlbbrff'.
	self assert: (marsRover position = (-2@2)).
	"
       ###     
	    #	
	    S
	"
	
! !


!classDefinition: #Direction category: 'MarsRover'!
Object subclass: #Direction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Direction methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 19:27:25'!
= aDirection
	^self class = aDirection class! !

!Direction methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 19:16:23'!
left
	^self subclassResponsibility ! !

!Direction methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 19:16:57'!
positionDelta
	^self subclassResponsibility ! !

!Direction methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 19:16:26'!
right
	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Direction class' category: 'MarsRover'!
Direction class
	instanceVariableNames: ''!

!Direction class methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 19:26:40'!
east
	^East new! !

!Direction class methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 19:26:24'!
north
	^North new! !

!Direction class methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 19:26:32'!
south
	^South new! !

!Direction class methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 19:26:54'!
west
	^West new! !


!classDefinition: #East category: 'MarsRover'!
Direction subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 19:29:26'!
left
	^Direction north! !

!East methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 19:21:39'!
positionDelta
	^1@0 ! !

!East methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 19:30:08'!
right
	^Direction south! !


!classDefinition: #North category: 'MarsRover'!
Direction subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 19:29:42'!
left
	^Direction west! !

!North methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 19:21:56'!
positionDelta
	^0@1 ! !

!North methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 19:30:26'!
right
	^Direction east! !


!classDefinition: #South category: 'MarsRover'!
Direction subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 19:30:34'!
left
	^Direction east! !

!South methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 19:22:04'!
positionDelta
	^0@-1 ! !

!South methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 19:30:39'!
right
	^Direction west! !


!classDefinition: #West category: 'MarsRover'!
Direction subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 19:30:46'!
left
	^Direction south! !

!West methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 19:22:09'!
positionDelta
	^-1@0 ! !

!West methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 19:30:54'!
right
	^Direction north! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'TC 5/28/2022 19:27:46'!
initialize
	position _ 0@0.
	direction _ Direction north.! !


!MarsRover methodsFor: 'communication' stamp: 'TC 5/29/2022 12:56:14'!
receiveCommands: aStringOfCommandIdentifier
	aStringOfCommandIdentifier do: [ :aStringChar | self receiveCommand: (aStringChar asString) onUnknownCommand: [^self]]! !


!MarsRover methodsFor: 'control' stamp: 'TC 5/28/2022 19:24:40'!
backward
	position _ position - (direction positionDelta).! !

!MarsRover methodsFor: 'control' stamp: 'TC 5/28/2022 18:12:57'!
direction
	^direction.! !

!MarsRover methodsFor: 'control' stamp: 'TC 5/28/2022 19:24:21'!
forward
	position _ position + (direction positionDelta).! !

!MarsRover methodsFor: 'control' stamp: 'TC 5/28/2022 19:23:02'!
left
	direction _ direction left.! !

!MarsRover methodsFor: 'control' stamp: 'TC 5/28/2022 18:04:47'!
position
	^position! !

!MarsRover methodsFor: 'control' stamp: 'TC 5/28/2022 19:23:11'!
right
	direction _ direction right.! !


!MarsRover methodsFor: 'private' stamp: 'TC 5/29/2022 12:52:52'!
receiveCommand: aRoverCommandIdentifier onUnknownCommand: unknownCommandClosure
	(RoverCommand initializeWithStringIdentifier: aRoverCommandIdentifier onUnknownCommand: unknownCommandClosure) runWithRover: self! !


!classDefinition: #RoverCommand category: 'MarsRover'!
Object subclass: #RoverCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RoverCommand methodsFor: 'as yet unclassified' stamp: 'TC 5/29/2022 12:51:10'!
runWithRover: aMarsRover
	^self subclassResponsibility. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RoverCommand class' category: 'MarsRover'!
RoverCommand class
	instanceVariableNames: ''!

!RoverCommand class methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 20:00:15'!
canInitializeWithStringIdentifier: aStringIdentifier
	^self subclassResponsibility. ! !

!RoverCommand class methodsFor: 'as yet unclassified' stamp: 'TC 5/29/2022 12:51:56'!
initializeWithStringIdentifier: aStringIdentifier onUnknownCommand: unknownCommandClosure
	self subclasses detect: [ :aSubclass |
		aSubclass canInitializeWithStringIdentifier: aStringIdentifier 
	] ifFound: [ :aSubclass |
		^aSubclass new
	] ifNone: unknownCommandClosure.! !


!classDefinition: #CommandBackward category: 'MarsRover'!
RoverCommand subclass: #CommandBackward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CommandBackward methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 20:05:17'!
runWithRover: aMarsRover
	aMarsRover backward. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CommandBackward class' category: 'MarsRover'!
CommandBackward class
	instanceVariableNames: ''!

!CommandBackward class methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 20:02:16'!
canInitializeWithStringIdentifier: aStringIdentifier
	^aStringIdentifier = 'b'! !


!classDefinition: #CommandForward category: 'MarsRover'!
RoverCommand subclass: #CommandForward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CommandForward methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 20:05:04'!
runWithRover: aMarsRover
	aMarsRover forward. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CommandForward class' category: 'MarsRover'!
CommandForward class
	instanceVariableNames: ''!

!CommandForward class methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 20:03:27'!
canInitializeWithStringIdentifier: aStringIdentifier
	^aStringIdentifier = 'f'! !


!classDefinition: #CommandLeft category: 'MarsRover'!
RoverCommand subclass: #CommandLeft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CommandLeft methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 20:05:48'!
runWithRover: aMarsRover
	aMarsRover left. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CommandLeft class' category: 'MarsRover'!
CommandLeft class
	instanceVariableNames: ''!

!CommandLeft class methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 20:03:36'!
canInitializeWithStringIdentifier: aStringIdentifier
	^aStringIdentifier = 'l'! !


!classDefinition: #CommandRight category: 'MarsRover'!
RoverCommand subclass: #CommandRight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CommandRight methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 20:05:55'!
runWithRover: aMarsRover
	aMarsRover right. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CommandRight class' category: 'MarsRover'!
CommandRight class
	instanceVariableNames: ''!

!CommandRight class methodsFor: 'as yet unclassified' stamp: 'TC 5/28/2022 20:03:42'!
canInitializeWithStringIdentifier: aStringIdentifier
	^aStringIdentifier = 'r'! !
