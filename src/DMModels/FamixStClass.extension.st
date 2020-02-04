Extension { #name : #FamixStClass }

{ #category : #'*DMModels' }
FamixStClass >> level [ 

	| c depth |	
	depth := 0.	
	c := self superclass.
	
	[c isNil]		
	whileFalse: [ 
			depth := depth + 1.
			c := c superclass.
		 ].
	^depth-1
]

{ #category : #'*DMModels' }
FamixStClass >> root [
	self isTrait
		ifTrue: [ ^ self ].
	({'ProtoObject' . 'Object'} includes: self name)
		ifTrue: [ ^ self ].
	self superclass isNotNil
		ifFalse: [ ^ self ].
	self superclass name = 'Object'
		ifTrue: [ ^ self ].
	^ self superclass root
]