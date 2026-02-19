# frozen_string_literal: true

module Lona
  module Companion
    module BattleSupport
      SUPPORT_COOLDOWN_TICKS = 120

      class << self
        # Вызывать на подходящем шаге боевого цикла.
        # battle_context — адаптер к текущей боевой системе (duck typing).
        def perform_support(battle_context = default_context)
          return unless State.active?
          return unless battle_context
          return if on_cooldown?(battle_context.tick)

          caster = battle_context.companion_actor
          ally = battle_context.player_actor
          return unless caster && ally
          return unless enough_mana?(caster)

          cast_best_support_spell(caster, ally, battle_context)
          State.last_support_tick = battle_context.tick
        end

        private

        def default_context
          return nil unless defined?(LonaBattleContext)

          LonaBattleContext.current
        end

        def on_cooldown?(current_tick)
          (current_tick - State.last_support_tick) < SUPPORT_COOLDOWN_TICKS
        end

        def enough_mana?(caster)
          return false if caster.max_mp.to_f <= 0.0

          (caster.mp.to_f / caster.max_mp.to_f) >= State.mana_threshold
        end

        def cast_best_support_spell(caster, ally, battle_context)
          hp_ratio = ally.hp.to_f / [ally.max_hp.to_f, 1.0].max

          if hp_ratio < 0.45 && caster.knows?(:minor_heal)
            battle_context.cast_spell(caster, ally, :minor_heal)
          elsif caster.knows?(:magic_barrier)
            battle_context.cast_spell(caster, ally, :magic_barrier)
          elsif caster.knows?(:focus_boost)
            battle_context.cast_spell(caster, ally, :focus_boost)
          end
        end
      end
    end
  end
end
