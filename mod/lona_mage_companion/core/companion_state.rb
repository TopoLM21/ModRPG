# frozen_string_literal: true

module Lona
  module Companion
    # Единое хранилище состояния компаньона.
    #
    # В реальном проекте это может быть сериализуемая часть save-данных
    # (например, через существующую систему флагов/переменных LonaRPG).
    module State
      class << self
        attr_accessor :recruited, :active, :npc_event_id, :trust_level,
                      :mana_threshold, :last_support_tick

        def reset!
          @recruited = false
          @active = false
          @npc_event_id = nil
          @trust_level = 0
          # Порог маны ниже которого компаньон не тратит MP на поддержку,
          # чтобы не "выключаться" полностью в затяжном бою.
          @mana_threshold = 0.25
          @last_support_tick = 0
        end

        def recruited?
          !!@recruited
        end

        def active?
          !!@active
        end
      end

      reset!
    end
  end
end
