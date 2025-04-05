local vector2 = require("src.shared.utils.vector2")

return {
     CARD_ORIGIN = vector2.new(0.5, 0.75),
     CARD_ANCHOR = vector2.new(0.5,0.5),
     CARD_SIZE = vector2.new(0.01, 0.025) * 18,
     CARD_DIRECTION_FACTOR = -1,
     CORNER_RADIUS = 4,
     CARD_GAP = 0.01 / 2,
     CARD_COUNT = 70,
     selectedCard = nil,
}