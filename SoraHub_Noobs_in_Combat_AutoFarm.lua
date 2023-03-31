local players = game.Players:GetPlayers()
local playercount = 0

for i , v in pairs(players) do
	playercount = i
end

getgenv().autofarm = true
	while getgenv().autofarm do
		if playercount == 1 then
			wait(10)
			game:GetService("ReplicatedStorage").connection.inGame.actions.Move:FireServer("2",-784,296) -- tp next to endpoint (turn,x,y) 
			wait(3)
			game:GetService("ReplicatedStorage").connection.inGame.Voting:FireServer() -- end turn
			wait(6)
			game:GetService("ReplicatedStorage").connection.inGame.actions.Capture:FireServer("2","5") -- active win condition (turn.idek wtf remotespy say sso)
			wait(5)
			game:GetService("ReplicatedStorage").connection.inGame.ReturnBack:FireServer()  --return to lobby
		else 
			wait(5)

			local createlobby = {
				[1] = {
					[1] = {
						["index"] = "inviteOnly",
						["value"] = true
					},
					[2] = {
						["index"] = "groupId",
						["value"] = "Campaign"
					}
				}
			}

			game:GetService("ReplicatedStorage").connection.lobby.room_create:FireServer(unpack(createlobby)) -- create lobby

			wait(2)

			local mapselection = {
				[1] = "map",
				[2] = "Boot camp",
				[3] = "1"
			}

			game:GetService("ReplicatedStorage").connection.lobby.room_edit:InvokeServer(unpack(mapselection)) -- map selection

			wait(2)

			game:GetService("ReplicatedStorage").connection.lobby.room_start:FireServer() -- game start
	
		end
		wait(1)
	end
