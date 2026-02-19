# frozen_string_literal: true

module Lona
  module Companion
    module Init
      class << self
        def install!
          install_interpreter_hooks
        end

        private

        def install_interpreter_hooks
          return unless defined?(Game_Interpreter)
          return if Game_Interpreter.method_defined?(:lona_companion_recruit_mage)

          Game_Interpreter.class_eval do
            # Хелпер для event script call:
            # lona_companion_recruit_mage(12)
            def lona_companion_recruit_mage(event_id = nil)
              Lona::Companion::Recruitment.recruit_mage(npc_event_id: event_id)
            end

            def lona_companion_dismiss_mage
              Lona::Companion::Recruitment.dismiss_mage
            end
          end
        end
      end
    end
  end
end
