// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast_v2.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Podcast extends DataClass implements Insertable<Podcast> {
  final String artwork30;
  final String artwork60;
  final String artwork100;
  final String artwork600;
  final String artworkOrig;
  final String description;
  final int episodesCount;
  final String feed;
  final String id;
  final String logoUrl;
  final String name;
  final String primaryGenre;
  final double popularity;
  final String title;
  final String url;
  Podcast(
      {this.artwork30,
      this.artwork60,
      this.artwork100,
      this.artwork600,
      this.artworkOrig,
      this.description,
      this.episodesCount,
      this.feed,
      this.id,
      this.logoUrl,
      this.name,
      this.primaryGenre,
      this.popularity,
      this.title,
      this.url});
  factory Podcast.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    final doubleType = db.typeSystem.forDartType<double>();
    return Podcast(
      artwork30: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}artwork30']),
      artwork60: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}artwork60']),
      artwork100: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}artwork100']),
      artwork600: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}artwork600']),
      artworkOrig: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}artwork_orig']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      episodesCount: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}episodes_count']),
      feed: stringType.mapFromDatabaseResponse(data['${effectivePrefix}feed']),
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      logoUrl: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}logo_url']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      primaryGenre: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}primary_genre']),
      popularity: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}popularity']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      url: stringType.mapFromDatabaseResponse(data['${effectivePrefix}url']),
    );
  }
  factory Podcast.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Podcast(
      artwork30: serializer.fromJson<String>(json['artwork30']),
      artwork60: serializer.fromJson<String>(json['artwork60']),
      artwork100: serializer.fromJson<String>(json['artwork100']),
      artwork600: serializer.fromJson<String>(json['artwork600']),
      artworkOrig: serializer.fromJson<String>(json['artworkOrig']),
      description: serializer.fromJson<String>(json['description']),
      episodesCount: serializer.fromJson<int>(json['episodesCount']),
      feed: serializer.fromJson<String>(json['feed']),
      id: serializer.fromJson<String>(json['id']),
      logoUrl: serializer.fromJson<String>(json['logoUrl']),
      name: serializer.fromJson<String>(json['name']),
      primaryGenre: serializer.fromJson<String>(json['primaryGenre']),
      popularity: serializer.fromJson<double>(json['popularity']),
      title: serializer.fromJson<String>(json['title']),
      url: serializer.fromJson<String>(json['url']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'artwork30': serializer.toJson<String>(artwork30),
      'artwork60': serializer.toJson<String>(artwork60),
      'artwork100': serializer.toJson<String>(artwork100),
      'artwork600': serializer.toJson<String>(artwork600),
      'artworkOrig': serializer.toJson<String>(artworkOrig),
      'description': serializer.toJson<String>(description),
      'episodesCount': serializer.toJson<int>(episodesCount),
      'feed': serializer.toJson<String>(feed),
      'id': serializer.toJson<String>(id),
      'logoUrl': serializer.toJson<String>(logoUrl),
      'name': serializer.toJson<String>(name),
      'primaryGenre': serializer.toJson<String>(primaryGenre),
      'popularity': serializer.toJson<double>(popularity),
      'title': serializer.toJson<String>(title),
      'url': serializer.toJson<String>(url),
    };
  }

  @override
  PodcastsCompanion createCompanion(bool nullToAbsent) {
    return PodcastsCompanion(
      artwork30: artwork30 == null && nullToAbsent
          ? const Value.absent()
          : Value(artwork30),
      artwork60: artwork60 == null && nullToAbsent
          ? const Value.absent()
          : Value(artwork60),
      artwork100: artwork100 == null && nullToAbsent
          ? const Value.absent()
          : Value(artwork100),
      artwork600: artwork600 == null && nullToAbsent
          ? const Value.absent()
          : Value(artwork600),
      artworkOrig: artworkOrig == null && nullToAbsent
          ? const Value.absent()
          : Value(artworkOrig),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      episodesCount: episodesCount == null && nullToAbsent
          ? const Value.absent()
          : Value(episodesCount),
      feed: feed == null && nullToAbsent ? const Value.absent() : Value(feed),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      logoUrl: logoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(logoUrl),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      primaryGenre: primaryGenre == null && nullToAbsent
          ? const Value.absent()
          : Value(primaryGenre),
      popularity: popularity == null && nullToAbsent
          ? const Value.absent()
          : Value(popularity),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      url: url == null && nullToAbsent ? const Value.absent() : Value(url),
    );
  }

  Podcast copyWith(
          {String artwork30,
          String artwork60,
          String artwork100,
          String artwork600,
          String artworkOrig,
          String description,
          int episodesCount,
          String feed,
          String id,
          String logoUrl,
          String name,
          String primaryGenre,
          double popularity,
          String title,
          String url}) =>
      Podcast(
        artwork30: artwork30 ?? this.artwork30,
        artwork60: artwork60 ?? this.artwork60,
        artwork100: artwork100 ?? this.artwork100,
        artwork600: artwork600 ?? this.artwork600,
        artworkOrig: artworkOrig ?? this.artworkOrig,
        description: description ?? this.description,
        episodesCount: episodesCount ?? this.episodesCount,
        feed: feed ?? this.feed,
        id: id ?? this.id,
        logoUrl: logoUrl ?? this.logoUrl,
        name: name ?? this.name,
        primaryGenre: primaryGenre ?? this.primaryGenre,
        popularity: popularity ?? this.popularity,
        title: title ?? this.title,
        url: url ?? this.url,
      );
  @override
  String toString() {
    return (StringBuffer('Podcast(')
          ..write('artwork30: $artwork30, ')
          ..write('artwork60: $artwork60, ')
          ..write('artwork100: $artwork100, ')
          ..write('artwork600: $artwork600, ')
          ..write('artworkOrig: $artworkOrig, ')
          ..write('description: $description, ')
          ..write('episodesCount: $episodesCount, ')
          ..write('feed: $feed, ')
          ..write('id: $id, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('name: $name, ')
          ..write('primaryGenre: $primaryGenre, ')
          ..write('popularity: $popularity, ')
          ..write('title: $title, ')
          ..write('url: $url')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      artwork30.hashCode,
      $mrjc(
          artwork60.hashCode,
          $mrjc(
              artwork100.hashCode,
              $mrjc(
                  artwork600.hashCode,
                  $mrjc(
                      artworkOrig.hashCode,
                      $mrjc(
                          description.hashCode,
                          $mrjc(
                              episodesCount.hashCode,
                              $mrjc(
                                  feed.hashCode,
                                  $mrjc(
                                      id.hashCode,
                                      $mrjc(
                                          logoUrl.hashCode,
                                          $mrjc(
                                              name.hashCode,
                                              $mrjc(
                                                  primaryGenre.hashCode,
                                                  $mrjc(
                                                      popularity.hashCode,
                                                      $mrjc(title.hashCode,
                                                          url.hashCode)))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Podcast &&
          other.artwork30 == this.artwork30 &&
          other.artwork60 == this.artwork60 &&
          other.artwork100 == this.artwork100 &&
          other.artwork600 == this.artwork600 &&
          other.artworkOrig == this.artworkOrig &&
          other.description == this.description &&
          other.episodesCount == this.episodesCount &&
          other.feed == this.feed &&
          other.id == this.id &&
          other.logoUrl == this.logoUrl &&
          other.name == this.name &&
          other.primaryGenre == this.primaryGenre &&
          other.popularity == this.popularity &&
          other.title == this.title &&
          other.url == this.url);
}

class PodcastsCompanion extends UpdateCompanion<Podcast> {
  final Value<String> artwork30;
  final Value<String> artwork60;
  final Value<String> artwork100;
  final Value<String> artwork600;
  final Value<String> artworkOrig;
  final Value<String> description;
  final Value<int> episodesCount;
  final Value<String> feed;
  final Value<String> id;
  final Value<String> logoUrl;
  final Value<String> name;
  final Value<String> primaryGenre;
  final Value<double> popularity;
  final Value<String> title;
  final Value<String> url;
  const PodcastsCompanion({
    this.artwork30 = const Value.absent(),
    this.artwork60 = const Value.absent(),
    this.artwork100 = const Value.absent(),
    this.artwork600 = const Value.absent(),
    this.artworkOrig = const Value.absent(),
    this.description = const Value.absent(),
    this.episodesCount = const Value.absent(),
    this.feed = const Value.absent(),
    this.id = const Value.absent(),
    this.logoUrl = const Value.absent(),
    this.name = const Value.absent(),
    this.primaryGenre = const Value.absent(),
    this.popularity = const Value.absent(),
    this.title = const Value.absent(),
    this.url = const Value.absent(),
  });
  PodcastsCompanion.insert({
    this.artwork30 = const Value.absent(),
    this.artwork60 = const Value.absent(),
    this.artwork100 = const Value.absent(),
    this.artwork600 = const Value.absent(),
    this.artworkOrig = const Value.absent(),
    this.description = const Value.absent(),
    this.episodesCount = const Value.absent(),
    this.feed = const Value.absent(),
    this.id = const Value.absent(),
    this.logoUrl = const Value.absent(),
    this.name = const Value.absent(),
    this.primaryGenre = const Value.absent(),
    this.popularity = const Value.absent(),
    this.title = const Value.absent(),
    this.url = const Value.absent(),
  });
  PodcastsCompanion copyWith(
      {Value<String> artwork30,
      Value<String> artwork60,
      Value<String> artwork100,
      Value<String> artwork600,
      Value<String> artworkOrig,
      Value<String> description,
      Value<int> episodesCount,
      Value<String> feed,
      Value<String> id,
      Value<String> logoUrl,
      Value<String> name,
      Value<String> primaryGenre,
      Value<double> popularity,
      Value<String> title,
      Value<String> url}) {
    return PodcastsCompanion(
      artwork30: artwork30 ?? this.artwork30,
      artwork60: artwork60 ?? this.artwork60,
      artwork100: artwork100 ?? this.artwork100,
      artwork600: artwork600 ?? this.artwork600,
      artworkOrig: artworkOrig ?? this.artworkOrig,
      description: description ?? this.description,
      episodesCount: episodesCount ?? this.episodesCount,
      feed: feed ?? this.feed,
      id: id ?? this.id,
      logoUrl: logoUrl ?? this.logoUrl,
      name: name ?? this.name,
      primaryGenre: primaryGenre ?? this.primaryGenre,
      popularity: popularity ?? this.popularity,
      title: title ?? this.title,
      url: url ?? this.url,
    );
  }
}

class $PodcastsTable extends Podcasts with TableInfo<$PodcastsTable, Podcast> {
  final GeneratedDatabase _db;
  final String _alias;
  $PodcastsTable(this._db, [this._alias]);
  final VerificationMeta _artwork30Meta = const VerificationMeta('artwork30');
  GeneratedTextColumn _artwork30;
  @override
  GeneratedTextColumn get artwork30 => _artwork30 ??= _constructArtwork30();
  GeneratedTextColumn _constructArtwork30() {
    return GeneratedTextColumn(
      'artwork30',
      $tableName,
      true,
    );
  }

  final VerificationMeta _artwork60Meta = const VerificationMeta('artwork60');
  GeneratedTextColumn _artwork60;
  @override
  GeneratedTextColumn get artwork60 => _artwork60 ??= _constructArtwork60();
  GeneratedTextColumn _constructArtwork60() {
    return GeneratedTextColumn(
      'artwork60',
      $tableName,
      true,
    );
  }

  final VerificationMeta _artwork100Meta = const VerificationMeta('artwork100');
  GeneratedTextColumn _artwork100;
  @override
  GeneratedTextColumn get artwork100 => _artwork100 ??= _constructArtwork100();
  GeneratedTextColumn _constructArtwork100() {
    return GeneratedTextColumn(
      'artwork100',
      $tableName,
      true,
    );
  }

  final VerificationMeta _artwork600Meta = const VerificationMeta('artwork600');
  GeneratedTextColumn _artwork600;
  @override
  GeneratedTextColumn get artwork600 => _artwork600 ??= _constructArtwork600();
  GeneratedTextColumn _constructArtwork600() {
    return GeneratedTextColumn(
      'artwork600',
      $tableName,
      true,
    );
  }

  final VerificationMeta _artworkOrigMeta =
      const VerificationMeta('artworkOrig');
  GeneratedTextColumn _artworkOrig;
  @override
  GeneratedTextColumn get artworkOrig =>
      _artworkOrig ??= _constructArtworkOrig();
  GeneratedTextColumn _constructArtworkOrig() {
    return GeneratedTextColumn(
      'artwork_orig',
      $tableName,
      true,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      true,
    );
  }

  final VerificationMeta _episodesCountMeta =
      const VerificationMeta('episodesCount');
  GeneratedIntColumn _episodesCount;
  @override
  GeneratedIntColumn get episodesCount =>
      _episodesCount ??= _constructEpisodesCount();
  GeneratedIntColumn _constructEpisodesCount() {
    return GeneratedIntColumn(
      'episodes_count',
      $tableName,
      true,
    );
  }

  final VerificationMeta _feedMeta = const VerificationMeta('feed');
  GeneratedTextColumn _feed;
  @override
  GeneratedTextColumn get feed => _feed ??= _constructFeed();
  GeneratedTextColumn _constructFeed() {
    return GeneratedTextColumn(
      'feed',
      $tableName,
      true,
    );
  }

  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _logoUrlMeta = const VerificationMeta('logoUrl');
  GeneratedTextColumn _logoUrl;
  @override
  GeneratedTextColumn get logoUrl => _logoUrl ??= _constructLogoUrl();
  GeneratedTextColumn _constructLogoUrl() {
    return GeneratedTextColumn(
      'logo_url',
      $tableName,
      true,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _primaryGenreMeta =
      const VerificationMeta('primaryGenre');
  GeneratedTextColumn _primaryGenre;
  @override
  GeneratedTextColumn get primaryGenre =>
      _primaryGenre ??= _constructPrimaryGenre();
  GeneratedTextColumn _constructPrimaryGenre() {
    return GeneratedTextColumn(
      'primary_genre',
      $tableName,
      true,
    );
  }

  final VerificationMeta _popularityMeta = const VerificationMeta('popularity');
  GeneratedRealColumn _popularity;
  @override
  GeneratedRealColumn get popularity => _popularity ??= _constructPopularity();
  GeneratedRealColumn _constructPopularity() {
    return GeneratedRealColumn(
      'popularity',
      $tableName,
      true,
    );
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      true,
    );
  }

  final VerificationMeta _urlMeta = const VerificationMeta('url');
  GeneratedTextColumn _url;
  @override
  GeneratedTextColumn get url => _url ??= _constructUrl();
  GeneratedTextColumn _constructUrl() {
    return GeneratedTextColumn(
      'url',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        artwork30,
        artwork60,
        artwork100,
        artwork600,
        artworkOrig,
        description,
        episodesCount,
        feed,
        id,
        logoUrl,
        name,
        primaryGenre,
        popularity,
        title,
        url
      ];
  @override
  $PodcastsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'podcasts';
  @override
  final String actualTableName = 'podcasts';
  @override
  VerificationContext validateIntegrity(PodcastsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.artwork30.present) {
      context.handle(_artwork30Meta,
          artwork30.isAcceptableValue(d.artwork30.value, _artwork30Meta));
    }
    if (d.artwork60.present) {
      context.handle(_artwork60Meta,
          artwork60.isAcceptableValue(d.artwork60.value, _artwork60Meta));
    }
    if (d.artwork100.present) {
      context.handle(_artwork100Meta,
          artwork100.isAcceptableValue(d.artwork100.value, _artwork100Meta));
    }
    if (d.artwork600.present) {
      context.handle(_artwork600Meta,
          artwork600.isAcceptableValue(d.artwork600.value, _artwork600Meta));
    }
    if (d.artworkOrig.present) {
      context.handle(_artworkOrigMeta,
          artworkOrig.isAcceptableValue(d.artworkOrig.value, _artworkOrigMeta));
    }
    if (d.description.present) {
      context.handle(_descriptionMeta,
          description.isAcceptableValue(d.description.value, _descriptionMeta));
    }
    if (d.episodesCount.present) {
      context.handle(
          _episodesCountMeta,
          episodesCount.isAcceptableValue(
              d.episodesCount.value, _episodesCountMeta));
    }
    if (d.feed.present) {
      context.handle(
          _feedMeta, feed.isAcceptableValue(d.feed.value, _feedMeta));
    }
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.logoUrl.present) {
      context.handle(_logoUrlMeta,
          logoUrl.isAcceptableValue(d.logoUrl.value, _logoUrlMeta));
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    }
    if (d.primaryGenre.present) {
      context.handle(
          _primaryGenreMeta,
          primaryGenre.isAcceptableValue(
              d.primaryGenre.value, _primaryGenreMeta));
    }
    if (d.popularity.present) {
      context.handle(_popularityMeta,
          popularity.isAcceptableValue(d.popularity.value, _popularityMeta));
    }
    if (d.title.present) {
      context.handle(
          _titleMeta, title.isAcceptableValue(d.title.value, _titleMeta));
    }
    if (d.url.present) {
      context.handle(_urlMeta, url.isAcceptableValue(d.url.value, _urlMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  Podcast map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Podcast.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(PodcastsCompanion d) {
    final map = <String, Variable>{};
    if (d.artwork30.present) {
      map['artwork30'] = Variable<String, StringType>(d.artwork30.value);
    }
    if (d.artwork60.present) {
      map['artwork60'] = Variable<String, StringType>(d.artwork60.value);
    }
    if (d.artwork100.present) {
      map['artwork100'] = Variable<String, StringType>(d.artwork100.value);
    }
    if (d.artwork600.present) {
      map['artwork600'] = Variable<String, StringType>(d.artwork600.value);
    }
    if (d.artworkOrig.present) {
      map['artwork_orig'] = Variable<String, StringType>(d.artworkOrig.value);
    }
    if (d.description.present) {
      map['description'] = Variable<String, StringType>(d.description.value);
    }
    if (d.episodesCount.present) {
      map['episodes_count'] = Variable<int, IntType>(d.episodesCount.value);
    }
    if (d.feed.present) {
      map['feed'] = Variable<String, StringType>(d.feed.value);
    }
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.logoUrl.present) {
      map['logo_url'] = Variable<String, StringType>(d.logoUrl.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.primaryGenre.present) {
      map['primary_genre'] = Variable<String, StringType>(d.primaryGenre.value);
    }
    if (d.popularity.present) {
      map['popularity'] = Variable<double, RealType>(d.popularity.value);
    }
    if (d.title.present) {
      map['title'] = Variable<String, StringType>(d.title.value);
    }
    if (d.url.present) {
      map['url'] = Variable<String, StringType>(d.url.value);
    }
    return map;
  }

  @override
  $PodcastsTable createAlias(String alias) {
    return $PodcastsTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $PodcastsTable _podcasts;
  $PodcastsTable get podcasts => _podcasts ??= $PodcastsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [podcasts];
}
