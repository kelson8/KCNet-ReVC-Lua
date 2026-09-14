-- Testing with coroutines in lua

-- I may use this for trying to get my wait functions working like in the original scripts.

------------------
--- New Coroutines test
--- These seem useful, I can stop executation of one and resume it later.
--- Or I can just cancel one running if something is missing or a value is incorrect.
-- https://softwarepatternslexicon.com/lua/lua-programming-fundamentals/coroutines-and-asynchronous-programming-basics/

local is_test_valid = false

-- Define a simple coroutine function
function simpleCoroutine()
	print("Coroutine started")
	coroutine.yield()  -- Yield control back to the caller
	print("Coroutine resumed")
end

---@diagnostic disable-next-line: unused-function, unused-local
local function coroutine_test()
	-- Create a coroutine
	local co = coroutine.create(simpleCoroutine)

	-- Check its status
	-- print("Coroutine status: " .. coroutine.status(co))

	-- Resume the coroutine, moved out of the OnTick for testing.
	coroutine.resume(co)

	-- Resume the coroutine again, should run the function after
	-- This might be very useful for fade functions or anything that requires loading.
	-- I can make this only resume if a vehicle model has loaded or a lot more if that works.

	-- This will be perfect to only load models or objects in if they exist within the lua code.
	-- I never even thought about coroutines like this.
	if is_test_valid then
		coroutine.resume(co)
	else
		print("Coroutine failed to run! Value is not correct.")
	end

end

-- coroutine_test()

-------------------------



-------------------------
--- These below are for the test wait functions that I'm trying to fix to work
--- I would like to get these able to set a wait with a miliseconds timer like the original scripts would.
--- It mostly did that for loading models, waiting on things to load and to prevent crashes.

---------
--- New, for testing co routines in lua
--- TODO Try to fix this to work.
---------

local threads = {}

function spawnThread(fn)
    local co = coroutine.create(fn)
    table.insert(threads, co)
end

function wait(milliseconds)
    return coroutine.yield(milliseconds)
end

function updateThreads(deltaTime)
    for i = #threads, 1, -1 do
        local thread = threads[i]
        thread.remaining = (thread.remaining or 0) - deltaTime

        if thread.remaining <= 0 then
            local ok, delay = coroutine.resume(thread.co)

            if not ok then
                print("Lua script error: " .. tostring(delay))
                table.remove(threads, i)
            elseif coroutine.status(thread.co) == "dead" then
                table.remove(threads, i)
            else
                thread.remaining = tonumber(delay) or 0
            end
        end
    end
end

spawnThread(function()
    while true do
        -- if playerIsNearInteriorEntrance() then
            -- requestInterior(1)

            -- while not interiorIsLoaded(1) do
            --     wait(0)
            -- end

            -- setPlayerInterior(1)
        -- end

        
		world.blow_up_all_vehicles()
		wait(1000)
    end
end)