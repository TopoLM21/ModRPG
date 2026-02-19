# frozen_string_literal: true

module Lona
  module Companion
    module Recruitment
      class << self
        # Минимальный найм для MVP.
        #
        # npc_event_id — event id персонажа-волшебника на карте (опционально).
        def recruit_mage(npc_event_id: nil)
          return false if State.recruited?

          State.recruited = true
          State.active = true
          State.npc_event_id = npc_event_id if npc_event_id

          push_message('Волшебник присоединился к вам.')
          true
        end

        def dismiss_mage
          return false unless State.recruited?

          State.active = false
          push_message('Волшебник временно покинул отряд.')
          true
        end

        private

        def push_message(text)
          # RGSS-safe: используем стандартное окно сообщений, если доступно.
          if defined?($game_message) && $game_message
            $game_message.add(text)
          end
        end
      end
    end
  end
end
