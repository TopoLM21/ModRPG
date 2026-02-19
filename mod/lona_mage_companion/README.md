# LonaRPG Mage Companion Mod (MVP)

MVP-мод компаньона-волшебника для LonaRPG с фокусом на:

- найм (recruitment),
- следование за игроком,
- магическая поддержка в бою.

## Почему Ruby / RGSS-стиль

LonaRPG основана на RPG Maker (RGSS), поэтому мод написан в Ruby-стиле скриптов,
который можно переносить в Script Editor проекта/мод-лоадер, а не как отдельное Qt-приложение.

## Структура

```text
mod/lona_mage_companion/
  VERSION
  init.rb
  core/
    companion_state.rb
    recruitment.rb
    follow_system.rb
    battle_support.rb
    companion_ai.rb
```

## Подключение (общий шаблон)

1. Загрузить сначала `core/*.rb`, затем `init.rb`.
2. В точке инициализации игры вызвать:

```ruby
Lona::Companion::Init.install!
```

3. На событие найма NPC вызвать:

```ruby
Lona::Companion::Recruitment.recruit_mage
```

4. В игровом цикле/апдейте карты вызывать:

```ruby
Lona::Companion::FollowSystem.update
```

5. В боевой фазе (в подходящем колбэке before-action/turn-start) вызывать:

```ruby
Lona::Companion::BattleSupport.perform_support
```

## Что дальше (после MVP)

- Диалоговые ветки (память о выборе, флаги доверия, скрытые условия).
- Сюжетные квесты компаньона.
- Баланс магии по фазам игры (ранняя/средняя/поздняя).
