// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_models.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class DriftShoppingList extends DataClass
    implements Insertable<DriftShoppingList> {
  final int id;
  final String title;
  DriftShoppingList({required this.id, required this.title});
  factory DriftShoppingList.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return DriftShoppingList(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    return map;
  }

  DriftShoppingListsCompanion toCompanion(bool nullToAbsent) {
    return DriftShoppingListsCompanion(
      id: Value(id),
      title: Value(title),
    );
  }

  factory DriftShoppingList.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftShoppingList(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
    };
  }

  DriftShoppingList copyWith({int? id, String? title}) => DriftShoppingList(
        id: id ?? this.id,
        title: title ?? this.title,
      );
  @override
  String toString() {
    return (StringBuffer('DriftShoppingList(')
          ..write('id: $id, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftShoppingList &&
          other.id == this.id &&
          other.title == this.title);
}

class DriftShoppingListsCompanion extends UpdateCompanion<DriftShoppingList> {
  final Value<int> id;
  final Value<String> title;
  const DriftShoppingListsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
  });
  DriftShoppingListsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
  }) : title = Value(title);
  static Insertable<DriftShoppingList> custom({
    Expression<int>? id,
    Expression<String>? title,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
    });
  }

  DriftShoppingListsCompanion copyWith({Value<int>? id, Value<String>? title}) {
    return DriftShoppingListsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DriftShoppingListsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }
}

class $DriftShoppingListsTable extends DriftShoppingLists
    with TableInfo<$DriftShoppingListsTable, DriftShoppingList> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DriftShoppingListsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title =
      GeneratedColumn<String?>('title', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          type: const StringType(),
          requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title];
  @override
  String get aliasedName => _alias ?? 'drift_shopping_lists';
  @override
  String get actualTableName => 'drift_shopping_lists';
  @override
  VerificationContext validateIntegrity(Insertable<DriftShoppingList> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftShoppingList map(Map<String, dynamic> data, {String? tablePrefix}) {
    return DriftShoppingList.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $DriftShoppingListsTable createAlias(String alias) {
    return $DriftShoppingListsTable(attachedDatabase, alias);
  }
}

class DriftShoppingItem extends DataClass
    implements Insertable<DriftShoppingItem> {
  final int id;
  final int listId;
  final int listPosition;
  final String label;
  final bool completed;
  DriftShoppingItem(
      {required this.id,
      required this.listId,
      required this.listPosition,
      required this.label,
      required this.completed});
  factory DriftShoppingItem.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return DriftShoppingItem(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      listId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}list_id'])!,
      listPosition: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}list_position'])!,
      label: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}label'])!,
      completed: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}completed'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['list_id'] = Variable<int>(listId);
    map['list_position'] = Variable<int>(listPosition);
    map['label'] = Variable<String>(label);
    map['completed'] = Variable<bool>(completed);
    return map;
  }

  DriftShoppingItemsCompanion toCompanion(bool nullToAbsent) {
    return DriftShoppingItemsCompanion(
      id: Value(id),
      listId: Value(listId),
      listPosition: Value(listPosition),
      label: Value(label),
      completed: Value(completed),
    );
  }

  factory DriftShoppingItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftShoppingItem(
      id: serializer.fromJson<int>(json['id']),
      listId: serializer.fromJson<int>(json['listId']),
      listPosition: serializer.fromJson<int>(json['listPosition']),
      label: serializer.fromJson<String>(json['label']),
      completed: serializer.fromJson<bool>(json['completed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'listId': serializer.toJson<int>(listId),
      'listPosition': serializer.toJson<int>(listPosition),
      'label': serializer.toJson<String>(label),
      'completed': serializer.toJson<bool>(completed),
    };
  }

  DriftShoppingItem copyWith(
          {int? id,
          int? listId,
          int? listPosition,
          String? label,
          bool? completed}) =>
      DriftShoppingItem(
        id: id ?? this.id,
        listId: listId ?? this.listId,
        listPosition: listPosition ?? this.listPosition,
        label: label ?? this.label,
        completed: completed ?? this.completed,
      );
  @override
  String toString() {
    return (StringBuffer('DriftShoppingItem(')
          ..write('id: $id, ')
          ..write('listId: $listId, ')
          ..write('listPosition: $listPosition, ')
          ..write('label: $label, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, listId, listPosition, label, completed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftShoppingItem &&
          other.id == this.id &&
          other.listId == this.listId &&
          other.listPosition == this.listPosition &&
          other.label == this.label &&
          other.completed == this.completed);
}

class DriftShoppingItemsCompanion extends UpdateCompanion<DriftShoppingItem> {
  final Value<int> id;
  final Value<int> listId;
  final Value<int> listPosition;
  final Value<String> label;
  final Value<bool> completed;
  const DriftShoppingItemsCompanion({
    this.id = const Value.absent(),
    this.listId = const Value.absent(),
    this.listPosition = const Value.absent(),
    this.label = const Value.absent(),
    this.completed = const Value.absent(),
  });
  DriftShoppingItemsCompanion.insert({
    this.id = const Value.absent(),
    required int listId,
    required int listPosition,
    required String label,
    required bool completed,
  })  : listId = Value(listId),
        listPosition = Value(listPosition),
        label = Value(label),
        completed = Value(completed);
  static Insertable<DriftShoppingItem> custom({
    Expression<int>? id,
    Expression<int>? listId,
    Expression<int>? listPosition,
    Expression<String>? label,
    Expression<bool>? completed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (listId != null) 'list_id': listId,
      if (listPosition != null) 'list_position': listPosition,
      if (label != null) 'label': label,
      if (completed != null) 'completed': completed,
    });
  }

  DriftShoppingItemsCompanion copyWith(
      {Value<int>? id,
      Value<int>? listId,
      Value<int>? listPosition,
      Value<String>? label,
      Value<bool>? completed}) {
    return DriftShoppingItemsCompanion(
      id: id ?? this.id,
      listId: listId ?? this.listId,
      listPosition: listPosition ?? this.listPosition,
      label: label ?? this.label,
      completed: completed ?? this.completed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (listId.present) {
      map['list_id'] = Variable<int>(listId.value);
    }
    if (listPosition.present) {
      map['list_position'] = Variable<int>(listPosition.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DriftShoppingItemsCompanion(')
          ..write('id: $id, ')
          ..write('listId: $listId, ')
          ..write('listPosition: $listPosition, ')
          ..write('label: $label, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }
}

class $DriftShoppingItemsTable extends DriftShoppingItems
    with TableInfo<$DriftShoppingItemsTable, DriftShoppingItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DriftShoppingItemsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _listIdMeta = const VerificationMeta('listId');
  @override
  late final GeneratedColumn<int?> listId = GeneratedColumn<int?>(
      'list_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _listPositionMeta =
      const VerificationMeta('listPosition');
  @override
  late final GeneratedColumn<int?> listPosition = GeneratedColumn<int?>(
      'list_position', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String?> label = GeneratedColumn<String?>(
      'label', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _completedMeta = const VerificationMeta('completed');
  @override
  late final GeneratedColumn<bool?> completed = GeneratedColumn<bool?>(
      'completed', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (completed IN (0, 1))');
  @override
  List<GeneratedColumn> get $columns =>
      [id, listId, listPosition, label, completed];
  @override
  String get aliasedName => _alias ?? 'drift_shopping_items';
  @override
  String get actualTableName => 'drift_shopping_items';
  @override
  VerificationContext validateIntegrity(Insertable<DriftShoppingItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('list_id')) {
      context.handle(_listIdMeta,
          listId.isAcceptableOrUnknown(data['list_id']!, _listIdMeta));
    } else if (isInserting) {
      context.missing(_listIdMeta);
    }
    if (data.containsKey('list_position')) {
      context.handle(
          _listPositionMeta,
          listPosition.isAcceptableOrUnknown(
              data['list_position']!, _listPositionMeta));
    } else if (isInserting) {
      context.missing(_listPositionMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(_completedMeta,
          completed.isAcceptableOrUnknown(data['completed']!, _completedMeta));
    } else if (isInserting) {
      context.missing(_completedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftShoppingItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    return DriftShoppingItem.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $DriftShoppingItemsTable createAlias(String alias) {
    return $DriftShoppingItemsTable(attachedDatabase, alias);
  }
}

abstract class _$DriftShopperDatabase extends GeneratedDatabase {
  _$DriftShopperDatabase(QueryExecutor e)
      : super(SqlTypeSystem.defaultInstance, e);
  late final $DriftShoppingListsTable driftShoppingLists =
      $DriftShoppingListsTable(this);
  late final $DriftShoppingItemsTable driftShoppingItems =
      $DriftShoppingItemsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [driftShoppingLists, driftShoppingItems];
}
