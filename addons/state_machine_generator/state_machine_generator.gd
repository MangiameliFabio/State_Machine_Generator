@tool
extends EditorPlugin

var dock
var snap_button_
var root_object
var state_name
var state_machine_button
var state_button
var state_line

#Check if buttons are disabled or not
func _process(delta):
	if(!root_object):
		return
		
	if(root_object.has_node(root_object.name + "StateMachine")):
		state_machine_button.disabled = true
		state_button.disabled = false
		state_line.set_editable(true)
	else:
		state_machine_button.disabled = false
		state_button.disabled = true
		state_line.set_editable(false)
	

# Check if an object was selected in the node tree. Will call edit if true.
func handles(object:Object) -> bool:
	return object is Node

# Assign root_object
func edit(object:Object) -> void:
	root_object = get_tree().get_edited_scene_root()	

#Create dock at the right side of the screen and connect buttons.
func _enter_tree():
	dock = preload("res://addons/state_machine_generator/state_machine_generator_dock.tscn").instantiate()
	state_machine_button = dock.get_node("AddStateMachineButton")
	state_button = dock.get_node("HBoxContainer/AddStateButton")
	state_line = dock.get_node("HBoxContainer/StateLine")
	
	state_machine_button.connect("button_down", add_state_machine)
	state_button.connect("button_down", add_state)
	state_line.connect("text_changed", change_state_name)
	
	add_control_to_dock(DOCK_SLOT_RIGHT_UL, dock)

func _exit_tree():
	# Clean-up 
	remove_control_from_docks(dock)
	dock.free()

# Check if directory for state machines exist. If not creates it.
func create_directory():
	var dir = DirAccess.open("res://")
	if(!dir.dir_exists("res://StateMachines/" + root_object.name + "/States")):
		dir.make_dir("res://StateMachines/") 
		dir.make_dir("res://StateMachines/" + root_object.name)	
		dir.make_dir("res://StateMachines/" + root_object.name + "/States") 

func add_state_machine():
	root_object = get_tree().get_edited_scene_root()
	create_directory()
	
	#Create state machine node for tree
	var state_machine_node = Node.new()
	state_machine_node.name = root_object.name + "StateMachine"
	create_state_machine()
	create_base_state()
	#Set script for node
	state_machine_node.set_script(load("res://StateMachines/" + root_object.name + "/" + root_object.name + "_State_Machine" + ".gd"))
	
	#Add node to tree
	root_object.add_child(state_machine_node)
	state_machine_node.set_owner(root_object)

# Create gdscript for state machine
func create_state_machine():
	var file = FileAccess.open("res://StateMachines/" + root_object.name + "/" + root_object.name + "_State_Machine" + ".gd", FileAccess.WRITE)
	file.store_string(load_state_machine_template())
	file.close()
	return file

# Load code for state machine script from template and change placeholder
func load_state_machine_template():
	var file = FileAccess.open("res://addons/state_machine_generator/templates/state_machine_template.txt", FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	content = content.replace("%STATEMACHINENAME%", root_object.name + "StateMachine")
	content = content.replace("%CHARACTERNAME%", root_object.name)
	return content

# Create gdscript for base state
func create_base_state():
	var file = FileAccess.open("res://StateMachines/" + root_object.name + "/" + root_object.name + "_Base_State" + ".gd", FileAccess.WRITE)
	file.store_string(load_base_state_template())
	file.close()
	return file

# Load code for base state script from template and change placeholder
func load_base_state_template():
	var file = FileAccess.open("res://addons/state_machine_generator/templates/base_state_template.txt", FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	content = content.replace("%BASESTATENAME%", root_object.name + "BaseState")
	content = content.replace("%CHARACTERNAME%", root_object.name)
	content = content.replace("%STATEMACHINENEAME%", root_object.name + "StateMachine")
	return content

# Change state_name when user edits LineEdit in dock
func change_state_name(new_name):
	state_name = new_name

func add_state():
	#Create state node for tree
	var state_node = Node.new()
	state_node.name = state_name
	#create script for node and attach it
	create_state()
	state_node.set_script(load("res://StateMachines/" +  root_object.name + "/States/" + root_object.name + "_" + state_name + ".gd"))
	#add state to tree as child of state machine
	root_object.get_node(root_object.name + "StateMachine").add_child(state_node)
	state_node.set_owner(root_object)

# Create gdscript for new state
func create_state():
	var file = FileAccess.open("res://StateMachines/" +  root_object.name + "/States/" + root_object.name + "_" + state_name + ".gd", FileAccess.WRITE)
	file.store_string(load_state_template())
	file.close()
	return file
	
# Load code for new state script from template and change placeholder
func load_state_template():
	var file = FileAccess.open("res://addons/state_machine_generator/templates/state_template.txt", FileAccess.READ)
	var content = file.get_as_text()
	content = content.replace("%BASESTATENAME%", root_object.name + "BaseState")
	file.close()	
	return content
