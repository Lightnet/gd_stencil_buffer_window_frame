# gd_stencil_buffer_window_frame

# License: MIT

# Godot: 4.5+

# Information:
  Sample stencil buffer window frame that render cube when look bebhind the window frame it does not appear in cube.
  
  This help me to keep it simple and how it works.

# Screen
```
create plane
create standard 3d materail.
-Transparency
	-Transparency: Alpha
- Albedo
	- Color: A = 0 , #ffffff00 //full transparent.
- Stencil
	- Mode : Custom
	- Flags: Wrtie
	- Reference : 1 // set render view id
```
# Mesh Cube
```
create boxmesh
create standard 3d materail.
- Render Proprity: 1 // need to screen to match id to render to screen id
- Transparency
	-Transparency: Alpha // need to be set for screen to work
- Stencil
	- Mode : Custom
	- Flags: Read
	- Compare: Equal // match id to render to screen.
	- Reference : 1 // set render view id
```

# Credits:
- Lukky 
	- https://www.youtube.com/watch?v=YRASzwjjokM
	- https://github.com/lukky-nl/Stencil-Buffer-Holographic-Display
