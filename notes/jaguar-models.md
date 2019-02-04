# Jaguar Models

[jaguar_orm](https://pub.dartlang.org/packages/jaguar_orm) powers some of
the models powering data persisted to sqlite.
The notes below describe how to work with these models.

## Creating/Updating models

Models reside in the `lib/models` directory.  Please refer to
the [jaguar_orm]((https://pub.dartlang.org/packages/jaguar_orm)) docs
and existing app models for more information on working with these models.
In addition to the manually created model files, the ORM package creates
generated code supporting these models in files with `.jorm.dart` name suffixes.
Upon creating new models, or updating existing models, please run the following
to update the generated code:

```
flutter packages pub run build_runner build
```

## Registering new models

In order for any new model to be accessible via the `app` singleton,
the new model must be register in the `initModels` method in `lib/app.dart`.

## Updating sqlite schemas

In order to update existing sqlite schemas, uncomment the `await model.drop()`
line and when the app starts up, a new table will replace the dropped table.

## Migrations

Currently, there is no support for gracefully updating existing sqlite schemas
in installed apps.
