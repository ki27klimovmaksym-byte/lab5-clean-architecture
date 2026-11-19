# Політика гілок

- `main` містить стабільну версію, готову до позначення тегом релізу.
- `develop` об'єднує перевірені зміни перед релізом.
- `feature/domain-layer`, `feature/application-layer`, `feature/infrastructure-layer` і `feature/presentation-layer` призначені для окремих шарів.
- Коміти використовують Conventional Commits: `feat`, `fix`, `docs`, `refactor`, `merge`.
- Локальні PR-описи з рев'ю зберігаються у `docs/pull-requests/`. Віддалений GitHub/GitLab не налаштований у цій папці.
