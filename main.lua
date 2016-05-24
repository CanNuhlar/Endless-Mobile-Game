    local bg1  
    local bg2  
    local runtime = 0  
    local scrollSpeed = 5
    local playerRect
    local obstacle01Left
    local obstacle01Right
    local obstacle02Left
    local obstacle02Right
    local obstacle03Left
    local obstacle03Right
    local obstacle04Right
    local obstacle04Left
    local obstacle05Right -- which is out of canvas at the init
    local obstacle05Left -- which is out of canvas at the init

    --function to draw idiotic player
    local function addPlayer()
    	local playerSprite = {type = "image",filename="player.png"}
    	playerRect = display.newRect(540, 1700, 150, 150)
    	playerRect.fill = playerSprite
    end

    --function to spin the player rect which is annoying as hell :)
    local function spinPlayer()
    	transition.to( playerRect, { rotation = playerRect.rotation-360, time=750, onComplete=spinImage } )
    end

    --increasing scroll speed over time to increase the difficulty
    local function speedUpScroll()
    	if scrollSpeed < 30 then
    		scrollSpeed = scrollSpeed + 0.5
    	else
    		scrollSpeed = 30
    	end
    	--print(scrollSpeed)
    end

    -- random color for obstacles to make the game more annoying
    local function randomcolorFill()
    	obstacle01Left.r = math.random()
    	obstacle01Left.g = math.random()
    	obstacle01Left.b = math.random()

    	obstacle02Left.r = math.random()
    	obstacle02Left.g = math.random()
    	obstacle02Left.b = math.random()

    	obstacle03Left.r = math.random()
    	obstacle03Left.g = math.random()
    	obstacle03Left.b = math.random()

    	obstacle04Left.r = math.random()
    	obstacle04Left.g = math.random()
    	obstacle04Left.b = math.random()

    	obstacle05Left.r = math.random()
    	obstacle05Left.g = math.random()
    	obstacle05Left.b = math.random()

    	obstacle01Left:setFillColor(obstacle01Left.r,obstacle01Left.g,obstacle01Left.b)
    	obstacle01Right:setFillColor(obstacle01Left.r,obstacle01Left.g,obstacle01Left.b)

    	obstacle02Left:setFillColor(obstacle02Left.r,obstacle02Left.g,obstacle02Left.b)
    	obstacle02Right:setFillColor(obstacle02Left.r,obstacle02Left.g,obstacle02Left.b)

    	obstacle03Left:setFillColor(obstacle03Left.r,obstacle03Left.g,obstacle03Left.b)
    	obstacle03Right:setFillColor(obstacle03Left.r,obstacle03Left.g,obstacle03Left.b)

    	obstacle04Left:setFillColor(obstacle04Left.r,obstacle04Left.g,obstacle04Left.b)
    	obstacle04Right:setFillColor(obstacle04Left.r,obstacle04Left.g,obstacle04Left.b)

    	obstacle05Left:setFillColor(obstacle04Left.r,obstacle04Left.g,obstacle04Left.b)
    	obstacle05Right:setFillColor(obstacle04Left.r,obstacle04Left.g,obstacle04Left.b)
    end

    --scrollable bg main
    local function addScrollableBg()  
        local bgImage = { type="image", filename="bg_main.jpg" }
        --local bgImage2 = {type = "image",filename="deneme2.jpg"}
        -- Add First bg image
        bg1 = display.newRect(0, 0, display.contentWidth, display.actualContentHeight)
        bg1.fill = bgImage
        bg1.x = display.contentCenterX
        bg1.y = display.contentCenterY
        -- Add Second bg image
        bg2 = display.newRect(0, 0, display.contentWidth, display.actualContentHeight)
        bg2.fill = bgImage
        bg2.x = display.contentCenterX
        bg2.y = display.contentCenterY - display.actualContentHeight
    end

    --moving background
    local function moveBg(dt)  
        bg1.y = bg1.y + scrollSpeed * dt
        bg2.y = bg2.y + scrollSpeed * dt
        if (bg1.y - display.contentHeight/2) > display.actualContentHeight then
            bg1:translate(0, -bg1.contentHeight * 2)
        end
        if (bg2.y - display.contentHeight/2) > display.actualContentHeight then
            bg2:translate(0, -bg2.contentHeight * 2)
        end
    end

    --getting time for scrolling
    local function getDeltaTime()  
       local temp = system.getTimer()
       local dt = (temp-runtime) / (1000/60)
       runtime = temp
       return dt
    end

    --called each time a frame has been rendered
    local function enterFrame()  
        local dt = getDeltaTime()
        moveBg(dt)
        if obstacle01Left ~=nil then
        	obstacle01Left.y = obstacle01Left.y + scrollSpeed + 3.8
        	obstacle01Right.y = obstacle01Right.y + scrollSpeed + 3.8
        	obstacle02Left.y = obstacle02Left.y + scrollSpeed + 3.8
        	obstacle02Right.y = obstacle02Right.y + scrollSpeed + 3.8
        	obstacle03Left.y = obstacle03Left.y + scrollSpeed + 3.8
        	obstacle03Right.y = obstacle03Right.y + scrollSpeed + 3.8
        	obstacle04Left.y = obstacle04Left.y + scrollSpeed + 3.8
        	obstacle04Right.y = obstacle04Right.y + scrollSpeed + 3.8
        	obstacle05Left.y = obstacle05Left.y + scrollSpeed + 3.8
        	obstacle05Right.y = obstacle05Right.y + scrollSpeed + 3.8
        	--print(obstacle01Right.y)
        end
    end

    --runs only once to prevent memory issues
    function init()  
    	local music = audio.loadSound("bgm.wav") --converted mp3 to wav which is supported by Corona SDK
    	--audio.play(music, {loops=-1}) 
        addScrollableBg()
        Runtime:addEventListener("enterFrame", enterFrame)
        addPlayer()
        spinPlayer()
        playerRect:addEventListener("touch", playerRect)
    end

    --main 
    init()
    local deneme = timer.performWithDelay (750, spinPlayer, 0)
    local speedUp = timer.performWithDelay(1000, speedUpScroll, 0)
    
    local randomY01 = math.random(100,740)
    
    local randomY02 = math.random(100,740) -- distance between first obs. from bottom and second
    local randomX02 = math.random(850,1000) -- distance between second level obstacles

    local randomY03 = math.random(100,740) -- distance between second obs. from bottom and third
    local randomX03 = math.random(450,600) -- distance between third level obstacles

    local randomY04 = math.random(100,740) -- distance between third obs. from bottom and fourth
    local randomX04 = math.random(50,200) -- distance between fourth level obstacles

    local randomY05 = math.random(100,740) 
    local randomX05 = math.random(-350,-200)

    local randomdistancebetweenObject1 = math.random(840,900) -- distance between first obs. from bottom
    local randomdistancebetweenObject2 = math.random(840,900) -- distance between second obs. from bottom
    local randomdistancebetweenObject3 = math.random(840,900) -- distance between third obs. from bottom
    local randomdistancebetweenObject4 = math.random(840,900) -- distance between fourth obs. from bottom
	local randomdistancebetweenObject5 = math.random(840,900) -- distance between fourth obs. from bottom
    -- first set of obstacles
    obstacle01Left = display.newRect(0, 1300, randomY01, 150)
    obstacle01Left.anchorX = 0
    obstacle01Left.align = "left"

    obstacle01Right = display.newRect(display.contentWidth, 1300, randomdistancebetweenObject1 - randomY01, 150)
    obstacle01Right.anchorX = 1
    obstacle01Right.align = "right"

    -- second set of obstacles
    obstacle02Left = display.newRect(0, randomX02, randomY02, 150)
    obstacle02Left.anchorX = 0
    obstacle02Left.align = "left"

    obstacle02Right = display.newRect(display.contentWidth, randomX02, randomdistancebetweenObject2 - randomY02, 150)
    obstacle02Right.anchorX = 1
    obstacle02Right.align = "right"

    -- third set of obstacles
    obstacle03Left = display.newRect(0, randomX03, randomY03, 150)
    obstacle03Left.anchorX = 0
    obstacle03Left.align = "left"

    obstacle03Right = display.newRect(display.contentWidth, randomX03, randomdistancebetweenObject3 - randomY03, 150)
    obstacle03Right.anchorX = 1
    obstacle03Right.align = "right"

    -- fourth set of obstacles
    obstacle04Left = display.newRect(0, randomX04, randomY04, 150)
    obstacle04Left.anchorX = 0
    obstacle04Left.align = "left"

    obstacle04Right = display.newRect(display.contentWidth, randomX04, randomdistancebetweenObject4 - randomY04, 150)
    obstacle04Right.anchorX = 1
    obstacle04Right.align = "right"

    -- fifth set of obstacles
    obstacle05Left = display.newRect(0, randomX05, randomY05, 150)
    obstacle05Left.anchorX = 0
    obstacle05Left.align = "left"

    obstacle05Right = display.newRect(display.contentWidth, randomX05, randomdistancebetweenObject4 - randomY05, 150)
    obstacle05Right.anchorX = 1
    obstacle05Right.align = "right"


   	
    local randomColor = timer.performWithDelay(50, randomcolorFill, 0)

    --touch event listener for player movement
    function playerRect:touch( event )
    	if event.phase == "began" then
    		display.getCurrentStage():setFocus( self )
    		self.markX = self.x
    		print("began")
    	elseif event.phase == "moved" then
    		local x = (event.x - event.xStart) + self.markX
    		print(x)
    		if x < 120 then
    			self.x = 120
    		elseif x + 120 > display.contentWidth then
    			self.x = display.contentWidth - 120 
    		else
    			self.x = x
    		end
    		--print("moved")
       	elseif event.phase =="ended" or event.phase == "cancelled" then
       		display.getCurrentStage():setFocus( nil )
    	end
    	return true
    end