# 🏠 Smart Home — мобильное приложение

**Дипломная работа:** «Разработка модуля видеонаблюдения для умного дома».

Мобильное приложение умного дома на Flutter: дома и камеры пользователя, просмотр видеопотока с камер в реальном времени и push-уведомления о незнакомцах в кадре.

**Бэкенд:** [smart-home-fastapi](https://github.com/donuwave/smart-home-fastapi) — микросервисы на FastAPI, RabbitMQ, распознавание лиц на pgvector.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase_Cloud_Messaging-FFCA28?style=flat&logo=firebase&logoColor=black)
![Android](https://img.shields.io/badge/Android-3DDC84?style=flat&logo=android&logoColor=white)

## Возможности

- Регистрация и вход, токены в защищённом хранилище (`flutter_secure_storage`)
- Список домов пользователя и переход в выбранный дом
- Главный экран дома: приветствие пользователя, карточка погоды, устройства
- Список устройств дома и страница камеры
- **Видеопоток с камеры** в реальном времени (MJPEG через API Gateway)
- **Push-уведомления** через Firebase Cloud Messaging: FCM-токен устройства привязывается к сессии на бэкенде, и при появлении незнакомца в кадре уведомление приходит на все устройства жильцов дома

## Как устроено

- Структура по слоям: `screens` (экраны) / `widgets` (общие виджеты) / `entities` (сущности: `auth`, `home`, `device`, `profile`, `notification`, `weather`), в сущности есть `service` для запросов к API и модели ответа
- HTTP-клиент на пакете `http`, все запросы идут через API Gateway
- Конфиг окружения через `--dart-define=ENV=prod`
- На эмуляторе Android бэкенд доступен по адресу `10.0.2.2`

## Стек

Flutter, Dart, http, flutter_secure_storage, firebase_core, firebase_messaging, mjpeg_stream

## Запуск

1. Запусти [бэкенд](https://github.com/donuwave/smart-home-fastapi): нужен API Gateway.
2. Подключи свой проект Firebase: `flutterfire configure` создаст `firebase_options.dart` и `google-services.json`.
3. Запусти на эмуляторе Android:

```bash
flutter pub get
flutter run
```

Для другого адреса API:

```bash
flutter run --dart-define=ENV=prod
```
