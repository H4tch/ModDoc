
# The whole MOD is self contained within a ZIP file. The ZIP has a signature
# file containing info about the author and Md5 hash sums of certain files.
# Content media files are ignored, so they can be limitedly modified without
# effecting the signage. The import files, are the ones which contain the
# definitions and logic that will be performed.

# How are mods structured? Can you import other files as mods? Assuming the
# files are hashed, it should be secure, right? (only can include files within
# ZIP). 


# Should this be within an "info" Table?
name 	= "MoonGrav"
version	= 0.9
release = "alpha"
author 	= "YourMom13"
[ links ]
	website 	= "forums.epicness.net/h4tch/threads/MoonGrav-0-9a"
    contribute 	= "http://github.com/h4tch/ModDoc/"
	donate($13.37 suggested) = "http://WeWantYourMoney.com/"


# Support specific dependencies?
[[ require ]]	# This is a Table Array for multiple dependencies.
	mod     	= "default"
	systems 	= ["Gravity"]
	components	= ["Position", "ExternalForce"]

[export]
	systems 	= ["MoonGravity"]
	components 	= ["MartianMass"] 


[[ component ]]
	name 	= "Mass"
	[Data] # This probably isn't needed.
		mass 	= 0.0
		invMass	= 0.0


[[ system ]]
	name 	= "Gravity"
	script 	= "lua"
	type 	= ["logic"]
	cycle	= ""
	group1 	= ["Position", "Mass", "ExternalForce"]
	group2 	= ["Position", "Mass"]
	depends	= []
	affects = ["ExternalForce"]
	

