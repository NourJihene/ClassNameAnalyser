Class {
	#name : #CNBPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'projectCNB',
		'cnbCanvas',
		'presenter',
		'roots'
	],
	#category : #CNBSpec
}

{ #category : #running }
CNBPresenterTest >> setUp [
	super setUp.
	
	presenter := CNBPresenter new.
	projectCNB := CNBRoassal3Builder projectNameMatches: 'moose-*'.
	roots := projectCNB viewModel rootModels collect: [ :each | each ].
	cnbCanvas := projectCNB on: RSCanvas new.
	presenter projectSelector text: 'moose-*'. 
	presenter onLoadProjectClicked.
	presenter cnbSpecView openWithSpec.
]

{ #category : #tests }
CNBPresenterTest >> testCanvasNotNil [


	self assert: presenter cnbSpecView canvas isNotNil equals: true
]

{ #category : #tests }
CNBPresenterTest >> testColorHighlighted [
	| highlightedBoxes |

	
	highlightedBoxes := ((CNBPatternSelector of: projectCNB)
		selectPatternOf: #'Scattered Vocabulary').
		
	self
		assert: (highlightedBoxes collect: #color) asSet
		equals: { Color purple } asSet 
]

{ #category : #tests }
CNBPresenterTest >> testGoDarker [
	| highlightedBoxes darkerBoxes expectedBoxesToGoDarker actualBoxesToGoDarker |
	
	highlightedBoxes := ((CNBPatternSelector of: projectCNB) 
			selectPatternOf: #'Scattered Vocabulary').
	expectedBoxesToGoDarker := presenter boxesToBeDarkerFor: #'Scattered Vocabulary'.
	actualBoxesToGoDarker := cnbCanvas deepNodes 
		reject: [ :each | highlightedBoxes includes: each model ].

	presenter lookFor: #'Scattered Vocabulary'.
	darkerBoxes := presenter boxesToBeDarkerFor: #'Scattered Vocabulary'.
	self assert: highlightedBoxes size equals: (presenter lookFor: #'Scattered Vocabulary') size.
]

{ #category : #tests }
CNBPresenterTest >> testHierarchyPattern [

	| aRoot |
	aRoot := roots atRandom.
	self assert: aRoot pattern name equals: (CNBPatternSelector of: aRoot) name 
]

{ #category : #tests }
CNBPresenterTest >> testHomogeneous [

	| cnb homogeneousPackage homogeneousModel |
	cnb := DMClassNamesBlueprintSample projectNameMatches: 'moose-*'.
	homogeneousPackage := cnb viewModel models detect: [ :package | 
		                      package name = 'Moose-MenuBar' ].

	homogeneousModel := homogeneousPackage models asOrderedCollection
		                    first.
	self assert: homogeneousModel checkHomogeneous equals: true.

]

{ #category : #tests }
CNBPresenterTest >> testNotHomogeneous [

	| cnb notHomogeneousPackage notHomogeneousModel |
	cnb := DMClassNamesBlueprintSample projectNameMatches: 'moose-*'.

	notHomogeneousPackage := cnb viewModel models detect: [ :package | 
		                         package name = 'Moose-Algos-Graph' ].

	notHomogeneousModel := notHomogeneousPackage models
		                       asOrderedCollection first. 
		self assert: notHomogeneousModel checkHomogeneous equals: false
]

{ #category : #tests }
CNBPresenterTest >> testNumberColorHighlighted [
	| highlightedBoxes |
	
	projectCNB := CNBRoassal3Builder projectNameMatches: 'moose-*'.
	
	highlightedBoxes := ((CNBPatternSelector of: projectCNB)
		selectPatternOf: #'Scattered Vocabulary').
		
	self assert: highlightedBoxes size equals: 3.
]

{ #category : #tests }
CNBPresenterTest >> testSelectFatBlobs [
	
	| expectedFatBlobBoxes actualFatBlobBoxes suffixViewModels |
	
	expectedFatBlobBoxes := (presenter lookFor: #'Fat Blob') 
		collect: [ :each | each ] .
	
	suffixViewModels := roots 
		flatCollect: [ :each | each concepts ].
	actualFatBlobBoxes := suffixViewModels 
		select: [ :each | each checkFatBlob ].
	
	self 
		assert: (expectedFatBlobBoxes collect: #package) asSet 
		equals: (actualFatBlobBoxes collect: #package)
	
]