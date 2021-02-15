Class {
	#name : #CNBPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'projectSelector',
		'pathSelector',
		'patternsDropList',
		'packageSearch',
		'cnbSpecView',
		'hierarchies',
		'loadProjectButton',
		'prefix',
		'suffix',
		'rootSelector'
	],
	#category : #CNBSpec
}

{ #category : #accessing }
CNBPresenter class >> defaultExtent [
	^ 1000@600
]

{ #category : #specs }
CNBPresenter class >> defaultSpec [ 
	^ SpBoxLayout newHorizontal
		spacing: 7;
		add: (SpBoxLayout newVertical
			spacing: 4;
			add: (SpBoxLayout newVertical
				add: 'Package name' height: self labelHeight;
				add: #projectSelector height: self buttonHeight;
				yourself) height: self labelHeight + self buttonHeight;
			add: (SpBoxLayout newVertical 
				add: 'Project path' height: self labelHeight;
				add: #pathSelector height: self buttonHeight;
				yourself) height: self labelHeight + self buttonHeight;
			add: (SpBoxLayout newVertical 
				add: 'Root class' height: self labelHeight;
				add: #rootSelector height: self buttonHeight;
				yourself) height: self labelHeight + self buttonHeight;
			add: (SpBoxLayout newVertical
				add: #suffix height: self buttonHeight;
				add: #prefix height: self buttonHeight;
				yourself) height: self buttonHeight + self buttonHeight;
			add: (SpBoxLayout newVertical 
				add: #loadProjectButton width: self buttonWidth;
				yourself) height: self buttonHeight + self buttonHeight;
			add: (SpBoxLayout newVertical 
				add: 'Pattern' height: self labelHeight;
				add: #patternsDropList height: self buttonHeight;
				yourself) height: self labelHeight + self buttonHeight;
			add: '';
			yourself) width: 180;
		add: (SpBoxLayout newVertical
			add: (SpBoxLayout newHorizontal
				add: '';
				add: #packageSearch width: 200;
				yourself) height: self buttonHeight;
			add: #cnbSpecView;
			yourself);
		yourself.
]

{ #category : #accessing }
CNBPresenter class >> defaultTitle [
	^ 'ClassNames Blueprint'
]

{ #category : #'world menu' }
CNBPresenter class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #ClassNamesBlueprint)
		parent: #Tools;
		action: [ self open ];
		order: 15;
		help: 'A class names blueprint presenter';
		icon: (self iconNamed: #smallPaint).
]

{ #category : #specs }
CNBPresenter class >> open [
	<example>
	self new openWithSpec.
]

{ #category : #initialization }
CNBPresenter >> connectPresenters [
	super connectPresenters.
	loadProjectButton action: [ self onLoadProjectClicked  ]. 
	
]

{ #category : #initialization }
CNBPresenter >> initializePresenters [
	super initializePresenters.
	
	projectSelector := self newTextInput.
	pathSelector := self newTextInput.
	rootSelector := self newTextInput.
	prefix := self newRadioButton.
	suffix := self newRadioButton.	
	suffix associatedRadioButtons:  { prefix }.
	prefix label: 'Prefix'.
	suffix label: 'Suffix'.
	
	loadProjectButton := self newButton label: 'Load project'.
	patternsDropList := CNBSpecElementDropList new.
	
	packageSearch := self newSearchInput
		placeholder: 'Search...';
		yourself.	
	cnbSpecView := SpRoassalPresenter new.
	"hierarchies := CNBSpecHierarchies new."
]

{ #category : #initialization }
CNBPresenter >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	
	aWindowPresenter
		title: self class defaultTitle;
		initialExtent: self class defaultExtent
]

{ #category : #'as yet unclassified' }
CNBPresenter >> onLoadProjectClicked [

		cnbSpecView script: [ :canvas | 
			projectSelector text ~='' 
				ifTrue: [  CNBRoassal3Builder 
					projectNameMatches: projectSelector text 
					on: canvas ]
				ifFalse: [ CNBRoassal3Builder 
					importProject: pathSelector text 
					on: canvas  ] ]
	 
		 
		

		
]