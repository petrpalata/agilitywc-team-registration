module DogsHelper
    def microchip_position_select(form, field, options = {})
        form.select(field, Dog.microchip_positions.map { |k, v| [v, k] }, options)
    end
end
