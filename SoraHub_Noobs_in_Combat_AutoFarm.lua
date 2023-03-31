local players = game.Players:GetPlayers()
local playercount = 0

for i , v in pairs(players) do
	playercount = i
end

getgenv().autofarm = true
	while getgenv().autofarm do
		if playercount == 1 then
			game:GetService("StarterGui"):SetCore("SendNotification",{
				Title = "Game joined", -- Required
				Text = "Loading...", -- Required
				Icon = "rbxassetid://12935455887", -- Optional
				Duration = 5
			})

			wait(10)
			game:GetService("StarterGui"):SetCore("SendNotification",{
				Title = "Teleporting...", -- Required
				Text = "Teleporting to the end of map", -- Required
				Icon = "rbxassetid://12935455887", -- Optional
				Duration = 5
			})
			game:GetService("ReplicatedStorage").connection.inGame.actions.Move:FireServer("2",-784,296) -- tp next to endpoint

			wait(3)
			game:GetService("StarterGui"):SetCore("SendNotification",{
				Title = "End Turn.", -- Required
				Text = "Loading...", -- Required
				Icon = "rbxassetid://12935455887", -- Optional
				Duration = 5
			})
			game:GetService("ReplicatedStorage").connection.inGame.Voting:FireServer() -- end turn

			wait(6)
			game:GetService("StarterGui"):SetCore("SendNotification",{
				Title = "Activating Win Condition.", -- Required
				Text = "Loading...", -- Required
				Icon = "rbxassetid://12935455887", -- Optional
				Duration = 5
			})
			game:GetService("ReplicatedStorage").connection.inGame.actions.Capture:FireServer("2","5") -- active win condition

			wait(5)
			game:GetService("StarterGui"):SetCore("SendNotification",{
				Title = "Teleporting...", -- Required
				Text = "Teleporting to the lobby.", -- Required
				Icon = "rbxassetid://12935455887", -- Optional
				Duration = 5
			})
			game:GetService("ReplicatedStorage").connection.inGame.ReturnBack:FireServer()  --return to lobby
		else 
			wait(5)
			game:GetService("StarterGui"):SetCore("SendNotification",{
				Title = "Creating Lobby...", -- Required
				Text = "Private Lobby.", -- Required
				Icon = "rbxassetid://12935455887", -- Optional
				Duration = 5
			})
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
			game:GetService("StarterGui"):SetCore("SendNotification",{
				Title = "Selecting Map...", -- Required
				Text = "Map Selected.", -- Required
				Icon = "rbxassetid://12935455887", -- Optional
				Duration = 5
			})
			local mapselection = {
				[1] = "map",
				[2] = "Boot camp",
				[3] = "1"
			}

			game:GetService("ReplicatedStorage").connection.lobby.room_edit:InvokeServer(unpack(mapselection)) -- map selection

			wait(2)
			game:GetService("StarterGui"):SetCore("SendNotification",{
				Title = "Teleporting...", -- Required
				Text = "Teleporting to the Game.", -- Required
				Icon = "rbxassetid://12935455887", -- Optional
				Duration = 5
			})
			game:GetService("ReplicatedStorage").connection.lobby.room_start:FireServer() -- game start
	
		end
		wait(1)
	end
