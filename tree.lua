local waittime = 5

---- pos_fix
function pos_fix()
	turtle.select(1)
	while (not turtle.detectDown()) do 
		turtle.down()
	end
end

---- tree_grown
function wait_tree_grown()
	pos_fix()
	print("Waiting for new tree to grow...")
	turtle.up()
	while (not turtle.detect()) do
		sleep(waittime)
	end
	print("New tree grew.")
end

---- take_sapling
function take_sapling()
	turtle.turnLeft()

	turtle.select(1)
	turtle.suck(1)

	turtle.turnRight()

	if (not turtle.compareTo(15)) then
		print("No more saplings. Abort.")
		error()
	end
end

---- place_sapling
function place_sapling()
	pos_fix()
	take_sapling()
	turtle.place()
	if (turtle.detect()) then
		print("New sapling placed.")
	else 
		print("Failed to place new sapling. Abort")
		error()
	end
end

---- dump_all
function dump_all()
	pos_fix()
	print("Dumping all items.")
	for i=1,14 do
		turtle.select(i)
		if (turtle.compareTo(15)) then
			turtle.turnLeft()
			turtle.drop()
			turtle.turnRight()
		else
			turtle.turnRight()
			turtle.drop()
			turtle.turnLeft()
		end
		turtle.drop()
	end
end

---- cut_tree
function cut_tree()
	print("Cutting tree...")
	pos_fix()
	while (turtle.detect()) do
		turtle.dig()
		turtle.digUp()
		turtle.up()
	end
end

---- refuelturtle
function refuelturtle()
	if (turtle.getFuelLevel() < 100) then
		turtle.turnRight()
		turtle.suck(10)
		for i=1,14 do
			turtle.select(i)
			turtle.refuel()
		end
		print("Refueling....")
	end
end

---- main
while (true) do
	pos_fix()
	if (not turtle.detect()) then place_sapling() end
	wait_tree_grown()

	cut_tree()

	dump_all()

	refuelturtle()
end
