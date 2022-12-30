# State Machine Generator

This Godot Addon can be used to create simple template code for a character state machines.

## Instalation
If you want to use this addon simply copy the addon folder in your project directory. In Godot you need to select Project->Project Settings and go into the Plugins tab. Here you can enable the State Machine Generator. When its eneabled you should find a State MAchine Generator tab docked on the right side of the editor. Maybe you need to reload your project to make it work.

## How to use
Create a new scene and select a root node you like. The name of the root node will define how the state machine will later be named (don't use names which are reserved by GDScript). For example we name it "Player". 

In the State Machine Generator Tab, press Add State Machine. You will now notice a new node in your Scene Tree called PlayerStateMachine. 

Now you can add states. Type the name in the input field and press add State. The state Nodes will also appear in the scene tree as child of PlayerStateMachine. 

When you created all the state you need for now don't forget to select an Inital State in the Inspector tab of the PlayerStateMachine.

The Output will show some errors. To fix that you need to reload the project.

You have succesfully created the tamplate code for a state machine. You can now customize the scripts and add the functionalities for your characters. The .gd file where saved in a new Directory called StateMachine->Player in your project.
