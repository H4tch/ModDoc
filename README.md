ModDoc
======

#### (This project is currently stalled as I look in to dynamic shared object loading.)

Open design document for a declarative Mod definition language for game
development. Uses [TOML](https://github.com/mojombo/toml#toml) as the
underlying markup language.(I may need to create an extension to TOML. )


## Example
### MetaData

```toml
name 	= "MoonGrav"
version	= 0.9
release = "spantacular"
author 	= "yourmom"

[links]
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
[[ require ]]
	mod     	= "default.physics"
	systems 	= ["Gravity"]
	components	= ["Position", "ExternalForce"]
[[ require ]]
	mod     	= "default.animation"
```

### Exporting Definitions
Mods run in their own namespace and can export symbols for other mods to use
and depend on.

```toml
[export]
    systems 	= ["MoonGrav"]
	components 	= ["Mass", "MoonShot"]
    entities    = ["SlipperTroll"]
```

### Components
```toml
[[ component ]]
    name    = "Mass"
	value 	= 0.0
	invMass	= 0.0
	[flags]
	   invMass = "NetWorkTransient"

# What about something like this?
# Components can contain "symbols", or classnames.
# If a Component only has one field that isn't prefedined, in this case "value",
# then the object can be registered as that type.
[[ component ]]
    name = "MoonShot"
    value = Vectord # I think I should I add Vector as a primitve type.
    [[ Field ]]
        name    = "test"
        value   = 0.0
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
[[ system ]]
	name 	= "MoonGrav"
	script  = "MoonGrav.lua"
	type 	= ["logic"]
	cycle	= 1
	group1 	= ["Position", "Mass", "ExternalForce"]
	group2 	= ["Position", "Mass"]
	depends	= []
	affects = ["ExternalForce"]
```

### Entity Definitions
Entity definitions contain a set of Components, optionally giving them default
values.

```toml
[[ entity ]]
    name = "SlipperTroll"
    [Mass]
        value = 0.2
    [ExternalForce]
    [Position]
```


## File Extensions
Here are some possible file extensions I might use. I'm leaning towards "**.dm**".
```
    .def    -- Generic Definition file
    .decl   -- Generic Declaration file. Turns out id software has "decl files"
            -- but none with ".decl" as the extension.(They do have ".def" though)
    .dm     -- Dungeon Master, uh-ehm, Definition Module.
    .modme  -- I like this one, although depending on the font, it makes the modme
            -- look too long with a non-fixed-width font. E.g. "Gravity.modme"
    .modit  -- There is a company Modit at "www.mod.it" which allows people to
            -- make web apps and games.
    .stuff  -- An of course its "taken", by a gaming company for doing this exact
            -- thing no less.
```


## Experimental
This introduces the ":" specifier for creating a named instance of a table.
The following is somewhat inspired from **Qml.** 

```toml
[Rectangle]
    width   = 0.0
    height  = 0.0
    color   = "white"
    [anchors]
        center  = "none"
        left    = "none"
        right   = "none"
        top     = "none"
        bottom  = "none"
    

[canvas:Rectangle]  # Creates a Rectangle named "canvas".
    width   = 200
    height  = 200
    color   = "blue"
    [logo:Image]    # Creates an Image named logo.
        source = "pics/logo.png"
        # "anchors.center" is a predefined field within Image.
        anchors.center = "parent"
        x = (canvas.height / 2)
```

### As for logic
The ideas so far have been (mostly) about data. The following are just some
ideas for function definitions. These ideas are very unlikely to be worked on.

```toml
[Class]
    fnName  = ()
    

# Implement the function.
Class.fnName a b c =>
    print (a + b + c)

# Implement the function in Lua.
Class.fnName a b c => lua:
    print(a + b + c)
```


