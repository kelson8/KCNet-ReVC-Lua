-- Testing with coroutines in lua

-- I may use this for trying to get my wait functions working like in the original scripts.

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