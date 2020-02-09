# app/hyperstack/component/app.rb

# This is your top level component, the rails router will
# direct all requests to mount this component.  You may
# then use the Route psuedo component to mount specific
# subcomponents depending on the URL.

class App < HyperComponent
  include Hyperstack::Router

  before_mount do

    # we will attach our component to Move's dispatcher

    # and mutate some state when it dispatches to us

    Move.on_dispatch { |params| mutate @move = params.move }

    # we also will initialize our state so it's in sync with @count

    @move = 'move2'

  end

  render(DIV) do

    DIV(class: @move) do

      "Click me :)"

    end.on(:click) do

      @count == 1 ? @count = 2 : @count = 1

      # Move will execute on the server

      Move.run(move: "move#{@count}")

    end

  end
end
