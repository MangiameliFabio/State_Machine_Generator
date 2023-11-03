# State Machine Generator

This Godot Addon can be used to create simple template code for character state machines.

## Instalation
If you want to use this addon copy the addon folder in your project directory. In Godot, you need to select Project->Project Settings and go into the Plugins tab. Here you can enable the State Machine Generator. When it is enabled you should find a State Machine Generator tab docked on the right side of the editor. Maybe you need to reload your project to make it work.

## How to use
Create a new scene and select a root node you like. The name of the root node will define how the state machine will later be named (don't use names that GDScript reserves). For example, we name it "Player". 

In the State Machine Generator Tab, press Add State Machine. You will now notice a new node in your Scene Tree called PlayerStateMachine. 

Now you can add states. Type the name in the input field and press "add State". The state Nodes will also appear in the scene tree as the child of PlayerStateMachine. 

Don't forget to select an Initial State in the Inspector tab of the PlayerStateMachine.

The Output will show some errors. To fix that you need to reload the project.

You have successfully created the template code for a state machine. You can now customize the scripts and add functionalities for your characters. The .gd file where saved in a new Directory called StateMachine->Player in your project.
