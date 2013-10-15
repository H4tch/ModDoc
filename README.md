ModDoc
======

Open design for a declarative Mod definition language for game development. 
Uses [TOML](https://github.com/mojombo/toml#toml) as the underlying markup
language.


## Example
### MetaData

```toml
name 	= "MoonGrav"
version	= 0.9
release = "spantacular"
author 	= "YourMom"
[ links ]
	website 	= "forums.epicness.net/h4tch/threads/MoonGrav-0-9a"
    contribute 	= "http://github.com/h4tch/ModDoc/"
	donate  	= "http://WeWantYourMoney.com/"
```


### Dependencies
Will be able to support having a dependency on a specific field of a Component
defined in any Mod. E.g, default.Position.z (Should this really be supported?
It breaks encapsulation. But Components are open data structures and shouldn't
change often. Plus if code gets fields of components using the reflection
system, it's better to check up front for that. Although, Components *should*
be fairly minimal, but I doubt users will care. The huge boon to the engine is
that any piece of data is compatible with everything else, this only works if
components contain the minimal essentials and don't change often. See next point.)

```toml
[[ require ]]    # This is a Table Array for multiple dependencies.
	mod     	= "default"
	systems 	= ["Gravity"]
	components	= ["Position", "ExternalForce"]
```

### Exporting Definitions
Mods can be run in their own namespace and choose to export symbols for other mods
to use and depend on.

```toml
[export]
    systems = ["MoonGrav"]
    components = ["MatianMass"]
```

### Components
```toml
[Mass]
	mass 	= 0.0
	invMass	= 0.0
```

### Systems
Since MoonGrav was in the export list of Systems, it can find the definition by
looking up the table. However, what if it wasn't defined? Should I require a special
field saying what type of structure it is. Also, it would save on runtime performance
if Components and Systems weren't named the same thing. Their name can be shared, but
their identifier needs to be unique. For example, think of the tables as class names.
In C++, there is a VelocitySystem that has it's name field set to "Velocity". Then, there
is a Velocity Component with it's name set to "Velocity".(Actually future versions will
remove the Velocity structure to shift the focus the dynamic registration system.)

```toml
[MoonGrav]
	name 	= "Gravity"
	script 	= "lua"
	type 	= ["logic"]
	cycle	= ""
	group1 	= ["Position", "Mass", "ExternalForce"]
	group2 	= ["Position", "Mass"]
	depends	= []
	affects = ["ExternalForce"]
```


## File Extensions
Here are some possible file extensions I might use. I'm leaning towards "**.dm**".
    .def    -- Generic Definition file
    .decl   -- Generic Declaration file. Turns out id software has "decl files"
            -- but none with ".decl" as the extension.(They do have ".def" though)
    .dm     -- Dungeon Master, uh-ehm, Definition Module.
    .modme  -- I like this one, although depending on the font, it makes the modme
            -- look too long with a non-fixed-width font. E.g. "Gravity.modme"
    .modit  -- There is a company Moddit at "www.mod.it" which allows people to
            -- make web apps and games.


