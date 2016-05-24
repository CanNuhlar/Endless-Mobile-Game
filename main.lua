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
    	obstacle01Left:setFillColor(obstacle01Left.r,obstacle01Left.g,obstacle01Left.b)
    	obstacle01Right:setFillColor(obstacle01Left.r,obstacle01Left.g,obstacle01Left.b)
    end

    --scrollable bg main
    local function addScrollableBg()  
        local bgImage = { type="image", filename="bg_main.jpg" }
        local bgImage2 = {type = "image",filename="deneme2.jpg"}
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
        	--obstacle01Left.y = obstacle01Left.y + scrollSpeed + 3.8
        	--obstacle01Right.y = obstacle01Right.y + scrollSpeed + 3.8
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
    local randomdistancebetweenObjects = math.random(840,900)

    obstacle01Left = display.newRect(0, 1200, randomY01, 150)
    obstacle01Left.anchorX = 0
    obstacle01Left.align = "left"

    obstacle01Right = display.newRect(display.contentWidth, 1200, randomdistancebetweenObjects - randomY01, 150)
    obstacle01Right.anchorX = 1
    obstacle01Right.align = "right"
   	
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