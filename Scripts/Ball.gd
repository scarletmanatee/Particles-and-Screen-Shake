extends RigidBody2D

export var size_decay = 0.3
export var alpha_decay = 0.03

var count = 0

func _ready():
	contact_monitor = true
	set_max_contacts_reported(4)

func _physics_process(delta):
	# Check for collisions
	var bodies = get_colliding_bodies()
	for body in bodies:
		get_parent().get_node("Camera").add_trauma(0.5)
	
	# Create comet trail
	var temp = $ColorRect.duplicate()
	temp.rect_position = Vector2(position.x + $ColorRect.rect_position.x,position.y + $ColorRect.rect_position.y)
	temp.name = "Trail" + str(count)
	count += 1
	$Trail.add_child(temp)
	var trail = $Trail.get_children()
	for t in trail:
		t.rect_size = Vector2(t.rect_size.x-size_decay,t.rect_size.y-size_decay)
		t.color.a -= alpha_decay
		if t.color.a <= 0:
			t.color.a = 0
		if t.rect_size.x <= 0.5 or t.color.a <= 0:
			t.queue_free()