# frozen_string_literal: true

module Lona
  module Companion
    # AI-оркестратор: объединяет карту (follow) и бой (support).
    module AI
      class << self
        def update_world
          FollowSystem.update
        end

        def update_battle(battle_context = nil)
          BattleSupport.perform_support(battle_context)
        end
      end
    end
  end
end
