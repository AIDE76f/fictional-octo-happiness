-- Services
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "CarFinder"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,370,0,420)
main.Position = UDim2.new(0.3,0,0.2,0)
main.BackgroundColor3 = Color3.fromRGB(30,30,30)
main.Active = true
main.Draggable = true
main.BorderSizePixel = 0

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,40)
title.Text = "Car Scanner"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 20

local input = Instance.new("TextBox", main)
input.Size = UDim2.new(0.9,0,0,35)
input.Position = UDim2.new(0.05,0,0,50)
input.PlaceholderText = "اكتب اسم السيارة عربي او English"
input.BackgroundColor3 = Color3.fromRGB(40,40,40)
input.TextColor3 = Color3.new(1,1,1)

local button = Instance.new("TextButton", main)
button.Size = UDim2.new(0.9,0,0,35)
button.Position = UDim2.new(0.05,0,0,95)
button.Text = "بحث عن السيارات"
button.BackgroundColor3 = Color3.fromRGB(0,170,255)
button.TextColor3 = Color3.new(1,1,1)
button.Font = Enum.Font.GothamBold

local list = Instance.new("ScrollingFrame", main)
list.Size = UDim2.new(0.9,0,0.65,0)
list.Position = UDim2.new(0.05,0,0,140)
list.BackgroundColor3 = Color3.fromRGB(35,35,35)
list.BorderSizePixel = 0
list.CanvasSize = UDim2.new(0,0,0,0)

local layout = Instance.new("UIListLayout", list)

-- تنظيف القائمة
local function clearList()
	for _,v in pairs(list:GetChildren()) do
		if v:IsA("TextLabel") then
			v:Destroy()
		end
	end
end

-- اضافة نتيجة
local function addResult(name,mileage)

	local item = Instance.new("TextLabel")
	item.Size = UDim2.new(1,0,0,30)
	item.BackgroundTransparency = 1
	item.TextColor3 = Color3.new(1,1,1)
	item.Font = Enum.Font.Gotham
	item.TextSize = 14
	item.Text = name.." | الممشى: "..tostring(mileage)
	item.Parent = list

end

-- استخراج الممشى
local function getMileage(car)

	for _,v in pairs(car:GetDescendants()) do

		local n = string.lower(v.Name)

		if n:find("mileage") or n:find("mile") or n:find("km") or n:find("ممشى") then

			if v:IsA("IntValue") or v:IsA("NumberValue") then
				return v.Value
			end

		end

	end

	return "غير معروف"
end

-- البحث عن السيارات
local function scanCars(searchName)

	clearList()

	searchName = string.lower(searchName)

	for _,obj in pairs(workspace:GetDescendants()) do

		if obj:IsA("Model") then

			local name = string.lower(obj.Name)

			if name:find(searchName) then

				local mileage = getMileage(obj)

				addResult(obj.Name,mileage)

			end

		end

	end

end

-- زر البحث
button.MouseButton1Click:Connect(function()

	local text = input.Text

	if text == "" then
		return
	end

	while true do
		scanCars(text)
		task.wait(5)
	end

end)
