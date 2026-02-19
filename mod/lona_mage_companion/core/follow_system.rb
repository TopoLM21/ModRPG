# frozen_string_literal: true

module Lona
  module Companion
    module FollowSystem
      class << self
        # Вызов из update-цикла карты.
        def update
          return unless State.active?
          return unless defined?($game_player) && $game_player

          # Базовая стратегия: компаньон держит позицию рядом с игроком.
          # В production-версии можно заменить на pathfinding по навмешу.
          maintain_relative_position
        end

        private

        def maintain_relative_position
          event = companion_event
          return unless event

          target_x = $game_player.x - 1
          target_y = $game_player.y

          # Небольшой "snap" для минимального MVP.
          event.moveto(target_x, target_y) if event.x != target_x || event.y != target_y
        end

        def companion_event
          return nil unless State.npc_event_id
          return nil unless defined?($game_map) && $game_map

          $game_map.events[State.npc_event_id]
        end
      end
    end
  end
end
