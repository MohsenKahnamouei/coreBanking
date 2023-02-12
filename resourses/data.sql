-- we don't know how to generate root <with-no-name> (class Root) :(
grant audit_abort_exempt, firewall_exempt, select, system_user on *.* to 'mysql.infoschema'@localhost;

grant audit_abort_exempt, authentication_policy_admin, backup_admin, clone_admin, connection_admin, firewall_exempt, persist_ro_variables_admin, session_variables_admin, shutdown, super, system_user, system_variables_admin on *.* to 'mysql.session'@localhost;

grant audit_abort_exempt, firewall_exempt, system_user on *.* to 'mysql.sys'@localhost;

grant alter, alter routine, application_password_admin, audit_abort_exempt, audit_admin, authentication_policy_admin, backup_admin, binlog_admin, binlog_encryption_admin, clone_admin, connection_admin, create, create role, create routine, create tablespace, create temporary tables, create user, create view, delete, drop, drop role, encryption_key_admin, event, execute, file, firewall_exempt, flush_optimizer_costs, flush_status, flush_tables, flush_user_resources, group_replication_admin, group_replication_stream, index, innodb_redo_log_archive, innodb_redo_log_enable, insert, lock tables, passwordless_user_admin, persist_ro_variables_admin, process, references, reload, replication client, replication slave, replication_applier, replication_slave_admin, resource_group_admin, resource_group_user, role_admin, select, sensitive_variables_observer, service_connection_admin, session_variables_admin, set_user_id, show databases, show view, show_routine, shutdown, super, system_user, system_variables_admin, table_encryption_admin, trigger, update, xa_recover_admin, grant option on *.* to root@localhost;

create table performance_schema.accounts
(
	USER char(32) collate utf8mb4_bin null,
	HOST char(255) charset ascii null,
	CURRENT_CONNECTIONS bigint not null,
	TOTAL_CONNECTIONS bigint not null,
	MAX_SESSION_CONTROLLED_MEMORY bigint unsigned not null,
	MAX_SESSION_TOTAL_MEMORY bigint unsigned not null,
	constraint ACCOUNT
		unique (USER, HOST) using hash
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.binary_log_transaction_compression_stats
(
	LOG_TYPE enum('BINARY', 'RELAY') not null comment 'The log type to which the transactions were written.',
	COMPRESSION_TYPE varchar(64) not null comment 'The transaction compression algorithm used.',
	TRANSACTION_COUNTER bigint unsigned not null comment 'Number of transactions written to the log',
	COMPRESSED_BYTES_COUNTER bigint unsigned not null comment 'The total number of bytes compressed.',
	UNCOMPRESSED_BYTES_COUNTER bigint unsigned not null comment 'The total number of bytes uncompressed.',
	COMPRESSION_PERCENTAGE smallint not null comment 'The compression ratio as a percentage.',
	FIRST_TRANSACTION_ID text null comment 'The first transaction written.',
	FIRST_TRANSACTION_COMPRESSED_BYTES bigint unsigned not null comment 'First transaction written compressed bytes.',
	FIRST_TRANSACTION_UNCOMPRESSED_BYTES bigint unsigned not null comment 'First transaction written uncompressed bytes.',
	FIRST_TRANSACTION_TIMESTAMP timestamp(6) null comment 'When the first transaction was written.',
	LAST_TRANSACTION_ID text null comment 'The last transaction written.',
	LAST_TRANSACTION_COMPRESSED_BYTES bigint unsigned not null comment 'Last transaction written compressed bytes.',
	LAST_TRANSACTION_UNCOMPRESSED_BYTES bigint unsigned not null comment 'Last transaction written uncompressed bytes.',
	LAST_TRANSACTION_TIMESTAMP timestamp(6) null comment 'When the last transaction was written.'
)
engine=PERFORMANCE_SCHEMA;

create table mysql.cash
(
	cashid int not null comment 'کد صندوق',
	currencyid int not null comment 'ارز',
	balance mediumtext not null comment 'مانده',
	constraint cash_cashid_uindex
		unique (cashid)
)
comment 'صندوق';

alter table mysql.cash
	add primary key (cashid);

create table mysql.columns_priv
(
	Host char(255) charset ascii default '' not null,
	Db char(64) default '' not null,
	User char(32) default '' not null,
	Table_name char(64) default '' not null,
	Column_name char(64) default '' not null,
	Timestamp timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
	Column_priv set('Select', 'Insert', 'Update', 'References') charset utf8mb3 default '' not null,
	primary key (Host, User, Db, Table_name, Column_name)
)
comment 'Column privileges' collate=utf8mb3_bin;

create table mysql.component
(
	component_id int unsigned auto_increment
		primary key,
	component_group_id int unsigned not null,
	component_urn text not null
)
comment 'Components' charset=utf8mb3;

create table performance_schema.cond_instances
(
	NAME varchar(128) not null,
	OBJECT_INSTANCE_BEGIN bigint unsigned not null
		primary key
)
engine=PERFORMANCE_SCHEMA;

create index NAME
	on performance_schema.cond_instances (NAME)
	using hash;

create table mysql.currency
(
	id int not null
		primary key,
	currencyname text not null comment 'نام ارز',
	currencyswift text not null comment 'کد سویفت'
)
comment 'ارز';

create table mysql.customer
(
	customer_type int not null comment 'تایپ مشتری',
	customer_id int not null comment 'شماره مشتری',
	address text null comment 'ادرس',
	constraint customer_customer_id_uindex
		unique (customer_id)
)
comment 'مشتری';

alter table mysql.customer
	add primary key (customer_id);

create table mysql.customer_type
(
	customer_type int not null comment '0:حقیقی
1:حقوقی',
	type_name tinytext not null,
	constraint customer_type_pk
		unique (customer_type)
)
comment 'انواع مشتری';

create table performance_schema.data_lock_waits
(
	ENGINE varchar(32) not null,
	REQUESTING_ENGINE_LOCK_ID varchar(128) not null,
	REQUESTING_ENGINE_TRANSACTION_ID bigint unsigned null,
	REQUESTING_THREAD_ID bigint unsigned null,
	REQUESTING_EVENT_ID bigint unsigned null,
	REQUESTING_OBJECT_INSTANCE_BEGIN bigint unsigned not null,
	BLOCKING_ENGINE_LOCK_ID varchar(128) not null,
	BLOCKING_ENGINE_TRANSACTION_ID bigint unsigned null,
	BLOCKING_THREAD_ID bigint unsigned null,
	BLOCKING_EVENT_ID bigint unsigned null,
	BLOCKING_OBJECT_INSTANCE_BEGIN bigint unsigned not null
)
engine=PERFORMANCE_SCHEMA;

create index BLOCKING_ENGINE_LOCK_ID
	on performance_schema.data_lock_waits (BLOCKING_ENGINE_LOCK_ID, ENGINE)
	using hash;

create index BLOCKING_ENGINE_TRANSACTION_ID
	on performance_schema.data_lock_waits (BLOCKING_ENGINE_TRANSACTION_ID, ENGINE)
	using hash;

create index BLOCKING_THREAD_ID
	on performance_schema.data_lock_waits (BLOCKING_THREAD_ID, BLOCKING_EVENT_ID)
	using hash;

create index REQUESTING_ENGINE_LOCK_ID
	on performance_schema.data_lock_waits (REQUESTING_ENGINE_LOCK_ID, ENGINE)
	using hash;

create index REQUESTING_ENGINE_TRANSACTION_ID
	on performance_schema.data_lock_waits (REQUESTING_ENGINE_TRANSACTION_ID, ENGINE)
	using hash;

create index REQUESTING_THREAD_ID
	on performance_schema.data_lock_waits (REQUESTING_THREAD_ID, REQUESTING_EVENT_ID)
	using hash;

create table performance_schema.data_locks
(
	ENGINE varchar(32) not null,
	ENGINE_LOCK_ID varchar(128) not null,
	ENGINE_TRANSACTION_ID bigint unsigned null,
	THREAD_ID bigint unsigned null,
	EVENT_ID bigint unsigned null,
	OBJECT_SCHEMA varchar(64) null,
	OBJECT_NAME varchar(64) null,
	PARTITION_NAME varchar(64) null,
	SUBPARTITION_NAME varchar(64) null,
	INDEX_NAME varchar(64) null,
	OBJECT_INSTANCE_BEGIN bigint unsigned not null,
	LOCK_TYPE varchar(32) not null,
	LOCK_MODE varchar(32) not null,
	LOCK_STATUS varchar(32) not null,
	LOCK_DATA varchar(8192) null,
	primary key (ENGINE_LOCK_ID, ENGINE)
)
engine=PERFORMANCE_SCHEMA;

create index ENGINE_TRANSACTION_ID
	on performance_schema.data_locks (ENGINE_TRANSACTION_ID, ENGINE)
	using hash;

create index OBJECT_SCHEMA
	on performance_schema.data_locks (OBJECT_SCHEMA, OBJECT_NAME, PARTITION_NAME, SUBPARTITION_NAME)
	using hash;

create index THREAD_ID
	on performance_schema.data_locks (THREAD_ID, EVENT_ID)
	using hash;

create table mysql.db
(
	Host char(255) charset ascii default '' not null,
	Db char(64) default '' not null,
	User char(32) default '' not null,
	Select_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Insert_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Update_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Delete_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Create_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Drop_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Grant_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	References_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Index_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Alter_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Create_tmp_table_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Lock_tables_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Create_view_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Show_view_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Create_routine_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Alter_routine_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Execute_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Event_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Trigger_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	primary key (Host, User, Db)
)
comment 'Database privileges' collate=utf8mb3_bin;

create index User
	on mysql.db (User);

create table mysql.default_roles
(
	HOST char(255) charset ascii default '' not null,
	USER char(32) default '' not null,
	DEFAULT_ROLE_HOST char(255) charset ascii default '%' not null,
	DEFAULT_ROLE_USER char(32) default '' not null,
	primary key (HOST, USER, DEFAULT_ROLE_HOST, DEFAULT_ROLE_USER)
)
comment 'Default roles' collate=utf8mb3_bin;

create table mysql.deposit
(
	customer_id int not null comment 'مشتری',
	currency_id int not null comment 'ارز',
	balance mediumtext not null comment 'مانده سپرده',
	`depossitnumber(20)` varchar(20) charset utf8mb3 not null comment 'شماره سپرده',
	deposittitle text not null comment 'عنوان سپرده',
	deposittype int not null comment 'تایپ سپرده',
	constraint `deposit_depossitnumber(20)_uindex`
		unique (`depossitnumber(20)`)
)
comment ' لیست سپرده ها';

create table mysql.deposittransaction
(
	id int auto_increment comment 'شماره',
	depid text not null comment 'سپرده',
	amount mediumtext not null comment 'مبلغ',
	trnid int not null comment 'نوع تراکنش',
	drcrtyp int not null comment 'بدهکار0/بستانکار1',
	trndate datetime not null comment 'تاریخ تراکنش',
	trndesc text null comment 'توضیحات تراکنش',
	refsystem varchar(1) charset utf8mb3 not null comment 'نام سیستم مرجع',
	constraint deposittransaction_id_uindex
		unique (id)
)
comment 'تراکنش های سپرده';

create table mysql.deposittype
(
	`id(2)` int not null,
	deptypnam text not null,
	constraint `deposittype_id(2)_uindex`
		unique (`id(2)`)
)
comment 'تایپ سپرده';

create table mysql.engine_cost
(
	engine_name varchar(64) not null,
	device_type int not null,
	cost_name varchar(64) not null,
	cost_value float null,
	last_update timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
	comment varchar(1024) null,
	default_value float as ((case `cost_name` when _utf8mb4'io_block_read_cost' then 1.0 when _utf8mb4'memory_block_read_cost' then 0.25 else NULL end)),
	primary key (cost_name, engine_name, device_type)
)
charset=utf8mb3;

create table performance_schema.error_log
(
	LOGGED timestamp(6) not null
		primary key,
	THREAD_ID bigint unsigned null,
	PRIO enum('System', 'Error', 'Warning', 'Note') not null,
	ERROR_CODE varchar(10) null,
	SUBSYSTEM varchar(7) null,
	DATA text not null
)
engine=PERFORMANCE_SCHEMA;

create index ERROR_CODE
	on performance_schema.error_log (ERROR_CODE)
	using hash;

create index PRIO
	on performance_schema.error_log (PRIO)
	using hash;

create index SUBSYSTEM
	on performance_schema.error_log (SUBSYSTEM)
	using hash;

create index THREAD_ID
	on performance_schema.error_log (THREAD_ID)
	using hash;

create table performance_schema.events_errors_summary_by_account_by_error
(
	USER char(32) collate utf8mb4_bin null,
	HOST char(255) charset ascii null,
	ERROR_NUMBER int null,
	ERROR_NAME varchar(64) null,
	SQL_STATE varchar(5) null,
	SUM_ERROR_RAISED bigint unsigned not null,
	SUM_ERROR_HANDLED bigint unsigned not null,
	FIRST_SEEN timestamp null,
	LAST_SEEN timestamp null,
	constraint ACCOUNT
		unique (USER, HOST, ERROR_NUMBER) using hash
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_errors_summary_by_host_by_error
(
	HOST char(255) charset ascii null,
	ERROR_NUMBER int null,
	ERROR_NAME varchar(64) null,
	SQL_STATE varchar(5) null,
	SUM_ERROR_RAISED bigint unsigned not null,
	SUM_ERROR_HANDLED bigint unsigned not null,
	FIRST_SEEN timestamp null,
	LAST_SEEN timestamp null,
	constraint HOST
		unique (HOST, ERROR_NUMBER) using hash
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_errors_summary_by_thread_by_error
(
	THREAD_ID bigint unsigned not null,
	ERROR_NUMBER int null,
	ERROR_NAME varchar(64) null,
	SQL_STATE varchar(5) null,
	SUM_ERROR_RAISED bigint unsigned not null,
	SUM_ERROR_HANDLED bigint unsigned not null,
	FIRST_SEEN timestamp null,
	LAST_SEEN timestamp null,
	constraint THREAD_ID
		unique (THREAD_ID, ERROR_NUMBER) using hash
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_errors_summary_by_user_by_error
(
	USER char(32) collate utf8mb4_bin null,
	ERROR_NUMBER int null,
	ERROR_NAME varchar(64) null,
	SQL_STATE varchar(5) null,
	SUM_ERROR_RAISED bigint unsigned not null,
	SUM_ERROR_HANDLED bigint unsigned not null,
	FIRST_SEEN timestamp null,
	LAST_SEEN timestamp null,
	constraint USER
		unique (USER, ERROR_NUMBER) using hash
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_errors_summary_global_by_error
(
	ERROR_NUMBER int null,
	ERROR_NAME varchar(64) null,
	SQL_STATE varchar(5) null,
	SUM_ERROR_RAISED bigint unsigned not null,
	SUM_ERROR_HANDLED bigint unsigned not null,
	FIRST_SEEN timestamp null,
	LAST_SEEN timestamp null,
	constraint ERROR_NUMBER
		unique (ERROR_NUMBER) using hash
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_stages_current
(
	THREAD_ID bigint unsigned not null,
	EVENT_ID bigint unsigned not null,
	END_EVENT_ID bigint unsigned null,
	EVENT_NAME varchar(128) not null,
	SOURCE varchar(64) null,
	TIMER_START bigint unsigned null,
	TIMER_END bigint unsigned null,
	TIMER_WAIT bigint unsigned null,
	WORK_COMPLETED bigint unsigned null,
	WORK_ESTIMATED bigint unsigned null,
	NESTING_EVENT_ID bigint unsigned null,
	NESTING_EVENT_TYPE enum('TRANSACTION', 'STATEMENT', 'STAGE', 'WAIT') null,
	primary key (THREAD_ID, EVENT_ID)
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_stages_history
(
	THREAD_ID bigint unsigned not null,
	EVENT_ID bigint unsigned not null,
	END_EVENT_ID bigint unsigned null,
	EVENT_NAME varchar(128) not null,
	SOURCE varchar(64) null,
	TIMER_START bigint unsigned null,
	TIMER_END bigint unsigned null,
	TIMER_WAIT bigint unsigned null,
	WORK_COMPLETED bigint unsigned null,
	WORK_ESTIMATED bigint unsigned null,
	NESTING_EVENT_ID bigint unsigned null,
	NESTING_EVENT_TYPE enum('TRANSACTION', 'STATEMENT', 'STAGE', 'WAIT') null,
	primary key (THREAD_ID, EVENT_ID)
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_stages_history_long
(
	THREAD_ID bigint unsigned not null,
	EVENT_ID bigint unsigned not null,
	END_EVENT_ID bigint unsigned null,
	EVENT_NAME varchar(128) not null,
	SOURCE varchar(64) null,
	TIMER_START bigint unsigned null,
	TIMER_END bigint unsigned null,
	TIMER_WAIT bigint unsigned null,
	WORK_COMPLETED bigint unsigned null,
	WORK_ESTIMATED bigint unsigned null,
	NESTING_EVENT_ID bigint unsigned null,
	NESTING_EVENT_TYPE enum('TRANSACTION', 'STATEMENT', 'STAGE', 'WAIT') null
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_stages_summary_by_account_by_event_name
(
	USER char(32) collate utf8mb4_bin null,
	HOST char(255) charset ascii null,
	EVENT_NAME varchar(128) not null,
	COUNT_STAR bigint unsigned not null,
	SUM_TIMER_WAIT bigint unsigned not null,
	MIN_TIMER_WAIT bigint unsigned not null,
	AVG_TIMER_WAIT bigint unsigned not null,
	MAX_TIMER_WAIT bigint unsigned not null,
	constraint ACCOUNT
		unique (USER, HOST, EVENT_NAME) using hash
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_stages_summary_by_host_by_event_name
(
	HOST char(255) charset ascii null,
	EVENT_NAME varchar(128) not null,
	COUNT_STAR bigint unsigned not null,
	SUM_TIMER_WAIT bigint unsigned not null,
	MIN_TIMER_WAIT bigint unsigned not null,
	AVG_TIMER_WAIT bigint unsigned not null,
	MAX_TIMER_WAIT bigint unsigned not null,
	constraint HOST
		unique (HOST, EVENT_NAME) using hash
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_stages_summary_by_thread_by_event_name
(
	THREAD_ID bigint unsigned not null,
	EVENT_NAME varchar(128) not null,
	COUNT_STAR bigint unsigned not null,
	SUM_TIMER_WAIT bigint unsigned not null,
	MIN_TIMER_WAIT bigint unsigned not null,
	AVG_TIMER_WAIT bigint unsigned not null,
	MAX_TIMER_WAIT bigint unsigned not null,
	primary key (THREAD_ID, EVENT_NAME)
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_stages_summary_by_user_by_event_name
(
	USER char(32) collate utf8mb4_bin null,
	EVENT_NAME varchar(128) not null,
	COUNT_STAR bigint unsigned not null,
	SUM_TIMER_WAIT bigint unsigned not null,
	MIN_TIMER_WAIT bigint unsigned not null,
	AVG_TIMER_WAIT bigint unsigned not null,
	MAX_TIMER_WAIT bigint unsigned not null,
	constraint USER
		unique (USER, EVENT_NAME) using hash
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_stages_summary_global_by_event_name
(
	EVENT_NAME varchar(128) not null
		primary key,
	COUNT_STAR bigint unsigned not null,
	SUM_TIMER_WAIT bigint unsigned not null,
	MIN_TIMER_WAIT bigint unsigned not null,
	AVG_TIMER_WAIT bigint unsigned not null,
	MAX_TIMER_WAIT bigint unsigned not null
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_statements_current
(
	THREAD_ID bigint unsigned not null,
	EVENT_ID bigint unsigned not null,
	END_EVENT_ID bigint unsigned null,
	EVENT_NAME varchar(128) not null,
	SOURCE varchar(64) null,
	TIMER_START bigint unsigned null,
	TIMER_END bigint unsigned null,
	TIMER_WAIT bigint unsigned null,
	LOCK_TIME bigint unsigned not null,
	SQL_TEXT longtext null,
	DIGEST varchar(64) null,
	DIGEST_TEXT longtext null,
	CURRENT_SCHEMA varchar(64) null,
	OBJECT_TYPE varchar(64) null,
	OBJECT_SCHEMA varchar(64) null,
	OBJECT_NAME varchar(64) null,
	OBJECT_INSTANCE_BEGIN bigint unsigned null,
	MYSQL_ERRNO int null,
	RETURNED_SQLSTATE varchar(5) null,
	MESSAGE_TEXT varchar(128) null,
	ERRORS bigint unsigned not null,
	WARNINGS bigint unsigned not null,
	ROWS_AFFECTED bigint unsigned not null,
	ROWS_SENT bigint unsigned not null,
	ROWS_EXAMINED bigint unsigned not null,
	CREATED_TMP_DISK_TABLES bigint unsigned not null,
	CREATED_TMP_TABLES bigint unsigned not null,
	SELECT_FULL_JOIN bigint unsigned not null,
	SELECT_FULL_RANGE_JOIN bigint unsigned not null,
	SELECT_RANGE bigint unsigned not null,
	SELECT_RANGE_CHECK bigint unsigned not null,
	SELECT_SCAN bigint unsigned not null,
	SORT_MERGE_PASSES bigint unsigned not null,
	SORT_RANGE bigint unsigned not null,
	SORT_ROWS bigint unsigned not null,
	SORT_SCAN bigint unsigned not null,
	NO_INDEX_USED bigint unsigned not null,
	NO_GOOD_INDEX_USED bigint unsigned not null,
	NESTING_EVENT_ID bigint unsigned null,
	NESTING_EVENT_TYPE enum('TRANSACTION', 'STATEMENT', 'STAGE', 'WAIT') null,
	NESTING_EVENT_LEVEL int null,
	STATEMENT_ID bigint unsigned null,
	CPU_TIME bigint unsigned not null,
	MAX_CONTROLLED_MEMORY bigint unsigned not null,
	MAX_TOTAL_MEMORY bigint unsigned not null,
	EXECUTION_ENGINE enum('PRIMARY', 'SECONDARY') null,
	primary key (THREAD_ID, EVENT_ID)
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_statements_histogram_by_digest
(
	SCHEMA_NAME varchar(64) null,
	DIGEST varchar(64) null,
	BUCKET_NUMBER int unsigned not null,
	BUCKET_TIMER_LOW bigint unsigned not null,
	BUCKET_TIMER_HIGH bigint unsigned not null,
	COUNT_BUCKET bigint unsigned not null,
	COUNT_BUCKET_AND_LOWER bigint unsigned not null,
	BUCKET_QUANTILE double(7,6) not null,
	constraint SCHEMA_NAME
		unique (SCHEMA_NAME, DIGEST, BUCKET_NUMBER) using hash
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_statements_histogram_global
(
	BUCKET_NUMBER int unsigned not null
		primary key,
	BUCKET_TIMER_LOW bigint unsigned not null,
	BUCKET_TIMER_HIGH bigint unsigned not null,
	COUNT_BUCKET bigint unsigned not null,
	COUNT_BUCKET_AND_LOWER bigint unsigned not null,
	BUCKET_QUANTILE double(7,6) not null
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_statements_history
(
	THREAD_ID bigint unsigned not null,
	EVENT_ID bigint unsigned not null,
	END_EVENT_ID bigint unsigned null,
	EVENT_NAME varchar(128) not null,
	SOURCE varchar(64) null,
	TIMER_START bigint unsigned null,
	TIMER_END bigint unsigned null,
	TIMER_WAIT bigint unsigned null,
	LOCK_TIME bigint unsigned not null,
	SQL_TEXT longtext null,
	DIGEST varchar(64) null,
	DIGEST_TEXT longtext null,
	CURRENT_SCHEMA varchar(64) null,
	OBJECT_TYPE varchar(64) null,
	OBJECT_SCHEMA varchar(64) null,
	OBJECT_NAME varchar(64) null,
	OBJECT_INSTANCE_BEGIN bigint unsigned null,
	MYSQL_ERRNO int null,
	RETURNED_SQLSTATE varchar(5) null,
	MESSAGE_TEXT varchar(128) null,
	ERRORS bigint unsigned not null,
	WARNINGS bigint unsigned not null,
	ROWS_AFFECTED bigint unsigned not null,
	ROWS_SENT bigint unsigned not null,
	ROWS_EXAMINED bigint unsigned not null,
	CREATED_TMP_DISK_TABLES bigint unsigned not null,
	CREATED_TMP_TABLES bigint unsigned not null,
	SELECT_FULL_JOIN bigint unsigned not null,
	SELECT_FULL_RANGE_JOIN bigint unsigned not null,
	SELECT_RANGE bigint unsigned not null,
	SELECT_RANGE_CHECK bigint unsigned not null,
	SELECT_SCAN bigint unsigned not null,
	SORT_MERGE_PASSES bigint unsigned not null,
	SORT_RANGE bigint unsigned not null,
	SORT_ROWS bigint unsigned not null,
	SORT_SCAN bigint unsigned not null,
	NO_INDEX_USED bigint unsigned not null,
	NO_GOOD_INDEX_USED bigint unsigned not null,
	NESTING_EVENT_ID bigint unsigned null,
	NESTING_EVENT_TYPE enum('TRANSACTION', 'STATEMENT', 'STAGE', 'WAIT') null,
	NESTING_EVENT_LEVEL int null,
	STATEMENT_ID bigint unsigned null,
	CPU_TIME bigint unsigned not null,
	MAX_CONTROLLED_MEMORY bigint unsigned not null,
	MAX_TOTAL_MEMORY bigint unsigned not null,
	EXECUTION_ENGINE enum('PRIMARY', 'SECONDARY') null,
	primary key (THREAD_ID, EVENT_ID)
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_statements_history_long
(
	THREAD_ID bigint unsigned not null,
	EVENT_ID bigint unsigned not null,
	END_EVENT_ID bigint unsigned null,
	EVENT_NAME varchar(128) not null,
	SOURCE varchar(64) null,
	TIMER_START bigint unsigned null,
	TIMER_END bigint unsigned null,
	TIMER_WAIT bigint unsigned null,
	LOCK_TIME bigint unsigned not null,
	SQL_TEXT longtext null,
	DIGEST varchar(64) null,
	DIGEST_TEXT longtext null,
	CURRENT_SCHEMA varchar(64) null,
	OBJECT_TYPE varchar(64) null,
	OBJECT_SCHEMA varchar(64) null,
	OBJECT_NAME varchar(64) null,
	OBJECT_INSTANCE_BEGIN bigint unsigned null,
	MYSQL_ERRNO int null,
	RETURNED_SQLSTATE varchar(5) null,
	MESSAGE_TEXT varchar(128) null,
	ERRORS bigint unsigned not null,
	WARNINGS bigint unsigned not null,
	ROWS_AFFECTED bigint unsigned not null,
	ROWS_SENT bigint unsigned not null,
	ROWS_EXAMINED bigint unsigned not null,
	CREATED_TMP_DISK_TABLES bigint unsigned not null,
	CREATED_TMP_TABLES bigint unsigned not null,
	SELECT_FULL_JOIN bigint unsigned not null,
	SELECT_FULL_RANGE_JOIN bigint unsigned not null,
	SELECT_RANGE bigint unsigned not null,
	SELECT_RANGE_CHECK bigint unsigned not null,
	SELECT_SCAN bigint unsigned not null,
	SORT_MERGE_PASSES bigint unsigned not null,
	SORT_RANGE bigint unsigned not null,
	SORT_ROWS bigint unsigned not null,
	SORT_SCAN bigint unsigned not null,
	NO_INDEX_USED bigint unsigned not null,
	NO_GOOD_INDEX_USED bigint unsigned not null,
	NESTING_EVENT_ID bigint unsigned null,
	NESTING_EVENT_TYPE enum('TRANSACTION', 'STATEMENT', 'STAGE', 'WAIT') null,
	NESTING_EVENT_LEVEL int null,
	STATEMENT_ID bigint unsigned null,
	CPU_TIME bigint unsigned not null,
	MAX_CONTROLLED_MEMORY bigint unsigned not null,
	MAX_TOTAL_MEMORY bigint unsigned not null,
	EXECUTION_ENGINE enum('PRIMARY', 'SECONDARY') null
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_statements_summary_by_account_by_event_name
(
	USER char(32) collate utf8mb4_bin null,
	HOST char(255) charset ascii null,
	EVENT_NAME varchar(128) not null,
	COUNT_STAR bigint unsigned not null,
	SUM_TIMER_WAIT bigint unsigned not null,
	MIN_TIMER_WAIT bigint unsigned not null,
	AVG_TIMER_WAIT bigint unsigned not null,
	MAX_TIMER_WAIT bigint unsigned not null,
	SUM_LOCK_TIME bigint unsigned not null,
	SUM_ERRORS bigint unsigned not null,
	SUM_WARNINGS bigint unsigned not null,
	SUM_ROWS_AFFECTED bigint unsigned not null,
	SUM_ROWS_SENT bigint unsigned not null,
	SUM_ROWS_EXAMINED bigint unsigned not null,
	SUM_CREATED_TMP_DISK_TABLES bigint unsigned not null,
	SUM_CREATED_TMP_TABLES bigint unsigned not null,
	SUM_SELECT_FULL_JOIN bigint unsigned not null,
	SUM_SELECT_FULL_RANGE_JOIN bigint unsigned not null,
	SUM_SELECT_RANGE bigint unsigned not null,
	SUM_SELECT_RANGE_CHECK bigint unsigned not null,
	SUM_SELECT_SCAN bigint unsigned not null,
	SUM_SORT_MERGE_PASSES bigint unsigned not null,
	SUM_SORT_RANGE bigint unsigned not null,
	SUM_SORT_ROWS bigint unsigned not null,
	SUM_SORT_SCAN bigint unsigned not null,
	SUM_NO_INDEX_USED bigint unsigned not null,
	SUM_NO_GOOD_INDEX_USED bigint unsigned not null,
	SUM_CPU_TIME bigint unsigned not null,
	MAX_CONTROLLED_MEMORY bigint unsigned not null,
	MAX_TOTAL_MEMORY bigint unsigned not null,
	COUNT_SECONDARY bigint unsigned not null,
	constraint ACCOUNT
		unique (USER, HOST, EVENT_NAME) using hash
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_statements_summary_by_digest
(
	SCHEMA_NAME varchar(64) null,
	DIGEST varchar(64) null,
	DIGEST_TEXT longtext null,
	COUNT_STAR bigint unsigned not null,
	SUM_TIMER_WAIT bigint unsigned not null,
	MIN_TIMER_WAIT bigint unsigned not null,
	AVG_TIMER_WAIT bigint unsigned not null,
	MAX_TIMER_WAIT bigint unsigned not null,
	SUM_LOCK_TIME bigint unsigned not null,
	SUM_ERRORS bigint unsigned not null,
	SUM_WARNINGS bigint unsigned not null,
	SUM_ROWS_AFFECTED bigint unsigned not null,
	SUM_ROWS_SENT bigint unsigned not null,
	SUM_ROWS_EXAMINED bigint unsigned not null,
	SUM_CREATED_TMP_DISK_TABLES bigint unsigned not null,
	SUM_CREATED_TMP_TABLES bigint unsigned not null,
	SUM_SELECT_FULL_JOIN bigint unsigned not null,
	SUM_SELECT_FULL_RANGE_JOIN bigint unsigned not null,
	SUM_SELECT_RANGE bigint unsigned not null,
	SUM_SELECT_RANGE_CHECK bigint unsigned not null,
	SUM_SELECT_SCAN bigint unsigned not null,
	SUM_SORT_MERGE_PASSES bigint unsigned not null,
	SUM_SORT_RANGE bigint unsigned not null,
	SUM_SORT_ROWS bigint unsigned not null,
	SUM_SORT_SCAN bigint unsigned not null,
	SUM_NO_INDEX_USED bigint unsigned not null,
	SUM_NO_GOOD_INDEX_USED bigint unsigned not null,
	SUM_CPU_TIME bigint unsigned not null,
	MAX_CONTROLLED_MEMORY bigint unsigned not null,
	MAX_TOTAL_MEMORY bigint unsigned not null,
	COUNT_SECONDARY bigint unsigned not null,
	FIRST_SEEN timestamp(6) not null,
	LAST_SEEN timestamp(6) not null,
	QUANTILE_95 bigint unsigned not null,
	QUANTILE_99 bigint unsigned not null,
	QUANTILE_999 bigint unsigned not null,
	QUERY_SAMPLE_TEXT longtext null,
	QUERY_SAMPLE_SEEN timestamp(6) not null,
	QUERY_SAMPLE_TIMER_WAIT bigint unsigned not null,
	constraint SCHEMA_NAME
		unique (SCHEMA_NAME, DIGEST) using hash
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_statements_summary_by_host_by_event_name
(
	HOST char(255) charset ascii null,
	EVENT_NAME varchar(128) not null,
	COUNT_STAR bigint unsigned not null,
	SUM_TIMER_WAIT bigint unsigned not null,
	MIN_TIMER_WAIT bigint unsigned not null,
	AVG_TIMER_WAIT bigint unsigned not null,
	MAX_TIMER_WAIT bigint unsigned not null,
	SUM_LOCK_TIME bigint unsigned not null,
	SUM_ERRORS bigint unsigned not null,
	SUM_WARNINGS bigint unsigned not null,
	SUM_ROWS_AFFECTED bigint unsigned not null,
	SUM_ROWS_SENT bigint unsigned not null,
	SUM_ROWS_EXAMINED bigint unsigned not null,
	SUM_CREATED_TMP_DISK_TABLES bigint unsigned not null,
	SUM_CREATED_TMP_TABLES bigint unsigned not null,
	SUM_SELECT_FULL_JOIN bigint unsigned not null,
	SUM_SELECT_FULL_RANGE_JOIN bigint unsigned not null,
	SUM_SELECT_RANGE bigint unsigned not null,
	SUM_SELECT_RANGE_CHECK bigint unsigned not null,
	SUM_SELECT_SCAN bigint unsigned not null,
	SUM_SORT_MERGE_PASSES bigint unsigned not null,
	SUM_SORT_RANGE bigint unsigned not null,
	SUM_SORT_ROWS bigint unsigned not null,
	SUM_SORT_SCAN bigint unsigned not null,
	SUM_NO_INDEX_USED bigint unsigned not null,
	SUM_NO_GOOD_INDEX_USED bigint unsigned not null,
	SUM_CPU_TIME bigint unsigned not null,
	MAX_CONTROLLED_MEMORY bigint unsigned not null,
	MAX_TOTAL_MEMORY bigint unsigned not null,
	COUNT_SECONDARY bigint unsigned not null,
	constraint HOST
		unique (HOST, EVENT_NAME) using hash
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_statements_summary_by_program
(
	OBJECT_TYPE enum('EVENT', 'FUNCTION', 'PROCEDURE', 'TABLE', 'TRIGGER') not null,
	OBJECT_SCHEMA varchar(64) not null,
	OBJECT_NAME varchar(64) not null,
	COUNT_STAR bigint unsigned not null,
	SUM_TIMER_WAIT bigint unsigned not null,
	MIN_TIMER_WAIT bigint unsigned not null,
	AVG_TIMER_WAIT bigint unsigned not null,
	MAX_TIMER_WAIT bigint unsigned not null,
	COUNT_STATEMENTS bigint unsigned not null,
	SUM_STATEMENTS_WAIT bigint unsigned not null,
	MIN_STATEMENTS_WAIT bigint unsigned not null,
	AVG_STATEMENTS_WAIT bigint unsigned not null,
	MAX_STATEMENTS_WAIT bigint unsigned not null,
	SUM_LOCK_TIME bigint unsigned not null,
	SUM_ERRORS bigint unsigned not null,
	SUM_WARNINGS bigint unsigned not null,
	SUM_ROWS_AFFECTED bigint unsigned not null,
	SUM_ROWS_SENT bigint unsigned not null,
	SUM_ROWS_EXAMINED bigint unsigned not null,
	SUM_CREATED_TMP_DISK_TABLES bigint unsigned not null,
	SUM_CREATED_TMP_TABLES bigint unsigned not null,
	SUM_SELECT_FULL_JOIN bigint unsigned not null,
	SUM_SELECT_FULL_RANGE_JOIN bigint unsigned not null,
	SUM_SELECT_RANGE bigint unsigned not null,
	SUM_SELECT_RANGE_CHECK bigint unsigned not null,
	SUM_SELECT_SCAN bigint unsigned not null,
	SUM_SORT_MERGE_PASSES bigint unsigned not null,
	SUM_SORT_RANGE bigint unsigned not null,
	SUM_SORT_ROWS bigint unsigned not null,
	SUM_SORT_SCAN bigint unsigned not null,
	SUM_NO_INDEX_USED bigint unsigned not null,
	SUM_NO_GOOD_INDEX_USED bigint unsigned not null,
	SUM_CPU_TIME bigint unsigned not null,
	MAX_CONTROLLED_MEMORY bigint unsigned not null,
	MAX_TOTAL_MEMORY bigint unsigned not null,
	COUNT_SECONDARY bigint unsigned not null,
	primary key (OBJECT_TYPE, OBJECT_SCHEMA, OBJECT_NAME)
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_statements_summary_by_thread_by_event_name
(
	THREAD_ID bigint unsigned not null,
	EVENT_NAME varchar(128) not null,
	COUNT_STAR bigint unsigned not null,
	SUM_TIMER_WAIT bigint unsigned not null,
	MIN_TIMER_WAIT bigint unsigned not null,
	AVG_TIMER_WAIT bigint unsigned not null,
	MAX_TIMER_WAIT bigint unsigned not null,
	SUM_LOCK_TIME bigint unsigned not null,
	SUM_ERRORS bigint unsigned not null,
	SUM_WARNINGS bigint unsigned not null,
	SUM_ROWS_AFFECTED bigint unsigned not null,
	SUM_ROWS_SENT bigint unsigned not null,
	SUM_ROWS_EXAMINED bigint unsigned not null,
	SUM_CREATED_TMP_DISK_TABLES bigint unsigned not null,
	SUM_CREATED_TMP_TABLES bigint unsigned not null,
	SUM_SELECT_FULL_JOIN bigint unsigned not null,
	SUM_SELECT_FULL_RANGE_JOIN bigint unsigned not null,
	SUM_SELECT_RANGE bigint unsigned not null,
	SUM_SELECT_RANGE_CHECK bigint unsigned not null,
	SUM_SELECT_SCAN bigint unsigned not null,
	SUM_SORT_MERGE_PASSES bigint unsigned not null,
	SUM_SORT_RANGE bigint unsigned not null,
	SUM_SORT_ROWS bigint unsigned not null,
	SUM_SORT_SCAN bigint unsigned not null,
	SUM_NO_INDEX_USED bigint unsigned not null,
	SUM_NO_GOOD_INDEX_USED bigint unsigned not null,
	SUM_CPU_TIME bigint unsigned not null,
	MAX_CONTROLLED_MEMORY bigint unsigned not null,
	MAX_TOTAL_MEMORY bigint unsigned not null,
	COUNT_SECONDARY bigint unsigned not null,
	primary key (THREAD_ID, EVENT_NAME)
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_statements_summary_by_user_by_event_name
(
	USER char(32) collate utf8mb4_bin null,
	EVENT_NAME varchar(128) not null,
	COUNT_STAR bigint unsigned not null,
	SUM_TIMER_WAIT bigint unsigned not null,
	MIN_TIMER_WAIT bigint unsigned not null,
	AVG_TIMER_WAIT bigint unsigned not null,
	MAX_TIMER_WAIT bigint unsigned not null,
	SUM_LOCK_TIME bigint unsigned not null,
	SUM_ERRORS bigint unsigned not null,
	SUM_WARNINGS bigint unsigned not null,
	SUM_ROWS_AFFECTED bigint unsigned not null,
	SUM_ROWS_SENT bigint unsigned not null,
	SUM_ROWS_EXAMINED bigint unsigned not null,
	SUM_CREATED_TMP_DISK_TABLES bigint unsigned not null,
	SUM_CREATED_TMP_TABLES bigint unsigned not null,
	SUM_SELECT_FULL_JOIN bigint unsigned not null,
	SUM_SELECT_FULL_RANGE_JOIN bigint unsigned not null,
	SUM_SELECT_RANGE bigint unsigned not null,
	SUM_SELECT_RANGE_CHECK bigint unsigned not null,
	SUM_SELECT_SCAN bigint unsigned not null,
	SUM_SORT_MERGE_PASSES bigint unsigned not null,
	SUM_SORT_RANGE bigint unsigned not null,
	SUM_SORT_ROWS bigint unsigned not null,
	SUM_SORT_SCAN bigint unsigned not null,
	SUM_NO_INDEX_USED bigint unsigned not null,
	SUM_NO_GOOD_INDEX_USED bigint unsigned not null,
	SUM_CPU_TIME bigint unsigned not null,
	MAX_CONTROLLED_MEMORY bigint unsigned not null,
	MAX_TOTAL_MEMORY bigint unsigned not null,
	COUNT_SECONDARY bigint unsigned not null,
	constraint USER
		unique (USER, EVENT_NAME) using hash
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_statements_summary_global_by_event_name
(
	EVENT_NAME varchar(128) not null
		primary key,
	COUNT_STAR bigint unsigned not null,
	SUM_TIMER_WAIT bigint unsigned not null,
	MIN_TIMER_WAIT bigint unsigned not null,
	AVG_TIMER_WAIT bigint unsigned not null,
	MAX_TIMER_WAIT bigint unsigned not null,
	SUM_LOCK_TIME bigint unsigned not null,
	SUM_ERRORS bigint unsigned not null,
	SUM_WARNINGS bigint unsigned not null,
	SUM_ROWS_AFFECTED bigint unsigned not null,
	SUM_ROWS_SENT bigint unsigned not null,
	SUM_ROWS_EXAMINED bigint unsigned not null,
	SUM_CREATED_TMP_DISK_TABLES bigint unsigned not null,
	SUM_CREATED_TMP_TABLES bigint unsigned not null,
	SUM_SELECT_FULL_JOIN bigint unsigned not null,
	SUM_SELECT_FULL_RANGE_JOIN bigint unsigned not null,
	SUM_SELECT_RANGE bigint unsigned not null,
	SUM_SELECT_RANGE_CHECK bigint unsigned not null,
	SUM_SELECT_SCAN bigint unsigned not null,
	SUM_SORT_MERGE_PASSES bigint unsigned not null,
	SUM_SORT_RANGE bigint unsigned not null,
	SUM_SORT_ROWS bigint unsigned not null,
	SUM_SORT_SCAN bigint unsigned not null,
	SUM_NO_INDEX_USED bigint unsigned not null,
	SUM_NO_GOOD_INDEX_USED bigint unsigned not null,
	SUM_CPU_TIME bigint unsigned not null,
	MAX_CONTROLLED_MEMORY bigint unsigned not null,
	MAX_TOTAL_MEMORY bigint unsigned not null,
	COUNT_SECONDARY bigint unsigned not null
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_transactions_current
(
	THREAD_ID bigint unsigned not null,
	EVENT_ID bigint unsigned not null,
	END_EVENT_ID bigint unsigned null,
	EVENT_NAME varchar(128) not null,
	STATE enum('ACTIVE', 'COMMITTED', 'ROLLED BACK') null,
	TRX_ID bigint unsigned null,
	GTID varchar(64) null,
	XID_FORMAT_ID int null,
	XID_GTRID varchar(130) null,
	XID_BQUAL varchar(130) null,
	XA_STATE varchar(64) null,
	SOURCE varchar(64) null,
	TIMER_START bigint unsigned null,
	TIMER_END bigint unsigned null,
	TIMER_WAIT bigint unsigned null,
	ACCESS_MODE enum('READ ONLY', 'READ WRITE') null,
	ISOLATION_LEVEL varchar(64) null,
	AUTOCOMMIT enum('YES', 'NO') not null,
	NUMBER_OF_SAVEPOINTS bigint unsigned null,
	NUMBER_OF_ROLLBACK_TO_SAVEPOINT bigint unsigned null,
	NUMBER_OF_RELEASE_SAVEPOINT bigint unsigned null,
	OBJECT_INSTANCE_BEGIN bigint unsigned null,
	NESTING_EVENT_ID bigint unsigned null,
	NESTING_EVENT_TYPE enum('TRANSACTION', 'STATEMENT', 'STAGE', 'WAIT') null,
	primary key (THREAD_ID, EVENT_ID)
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_transactions_history
(
	THREAD_ID bigint unsigned not null,
	EVENT_ID bigint unsigned not null,
	END_EVENT_ID bigint unsigned null,
	EVENT_NAME varchar(128) not null,
	STATE enum('ACTIVE', 'COMMITTED', 'ROLLED BACK') null,
	TRX_ID bigint unsigned null,
	GTID varchar(64) null,
	XID_FORMAT_ID int null,
	XID_GTRID varchar(130) null,
	XID_BQUAL varchar(130) null,
	XA_STATE varchar(64) null,
	SOURCE varchar(64) null,
	TIMER_START bigint unsigned null,
	TIMER_END bigint unsigned null,
	TIMER_WAIT bigint unsigned null,
	ACCESS_MODE enum('READ ONLY', 'READ WRITE') null,
	ISOLATION_LEVEL varchar(64) null,
	AUTOCOMMIT enum('YES', 'NO') not null,
	NUMBER_OF_SAVEPOINTS bigint unsigned null,
	NUMBER_OF_ROLLBACK_TO_SAVEPOINT bigint unsigned null,
	NUMBER_OF_RELEASE_SAVEPOINT bigint unsigned null,
	OBJECT_INSTANCE_BEGIN bigint unsigned null,
	NESTING_EVENT_ID bigint unsigned null,
	NESTING_EVENT_TYPE enum('TRANSACTION', 'STATEMENT', 'STAGE', 'WAIT') null,
	primary key (THREAD_ID, EVENT_ID)
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_transactions_history_long
(
	THREAD_ID bigint unsigned not null,
	EVENT_ID bigint unsigned not null,
	END_EVENT_ID bigint unsigned null,
	EVENT_NAME varchar(128) not null,
	STATE enum('ACTIVE', 'COMMITTED', 'ROLLED BACK') null,
	TRX_ID bigint unsigned null,
	GTID varchar(64) null,
	XID_FORMAT_ID int null,
	XID_GTRID varchar(130) null,
	XID_BQUAL varchar(130) null,
	XA_STATE varchar(64) null,
	SOURCE varchar(64) null,
	TIMER_START bigint unsigned null,
	TIMER_END bigint unsigned null,
	TIMER_WAIT bigint unsigned null,
	ACCESS_MODE enum('READ ONLY', 'READ WRITE') null,
	ISOLATION_LEVEL varchar(64) null,
	AUTOCOMMIT enum('YES', 'NO') not null,
	NUMBER_OF_SAVEPOINTS bigint unsigned null,
	NUMBER_OF_ROLLBACK_TO_SAVEPOINT bigint unsigned null,
	NUMBER_OF_RELEASE_SAVEPOINT bigint unsigned null,
	OBJECT_INSTANCE_BEGIN bigint unsigned null,
	NESTING_EVENT_ID bigint unsigned null,
	NESTING_EVENT_TYPE enum('TRANSACTION', 'STATEMENT', 'STAGE', 'WAIT') null
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_transactions_summary_by_account_by_event_name
(
	USER char(32) collate utf8mb4_bin null,
	HOST char(255) charset ascii null,
	EVENT_NAME varchar(128) not null,
	COUNT_STAR bigint unsigned not null,
	SUM_TIMER_WAIT bigint unsigned not null,
	MIN_TIMER_WAIT bigint unsigned not null,
	AVG_TIMER_WAIT bigint unsigned not null,
	MAX_TIMER_WAIT bigint unsigned not null,
	COUNT_READ_WRITE bigint unsigned not null,
	SUM_TIMER_READ_WRITE bigint unsigned not null,
	MIN_TIMER_READ_WRITE bigint unsigned not null,
	AVG_TIMER_READ_WRITE bigint unsigned not null,
	MAX_TIMER_READ_WRITE bigint unsigned not null,
	COUNT_READ_ONLY bigint unsigned not null,
	SUM_TIMER_READ_ONLY bigint unsigned not null,
	MIN_TIMER_READ_ONLY bigint unsigned not null,
	AVG_TIMER_READ_ONLY bigint unsigned not null,
	MAX_TIMER_READ_ONLY bigint unsigned not null,
	constraint ACCOUNT
		unique (USER, HOST, EVENT_NAME) using hash
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_transactions_summary_by_host_by_event_name
(
	HOST char(255) charset ascii null,
	EVENT_NAME varchar(128) not null,
	COUNT_STAR bigint unsigned not null,
	SUM_TIMER_WAIT bigint unsigned not null,
	MIN_TIMER_WAIT bigint unsigned not null,
	AVG_TIMER_WAIT bigint unsigned not null,
	MAX_TIMER_WAIT bigint unsigned not null,
	COUNT_READ_WRITE bigint unsigned not null,
	SUM_TIMER_READ_WRITE bigint unsigned not null,
	MIN_TIMER_READ_WRITE bigint unsigned not null,
	AVG_TIMER_READ_WRITE bigint unsigned not null,
	MAX_TIMER_READ_WRITE bigint unsigned not null,
	COUNT_READ_ONLY bigint unsigned not null,
	SUM_TIMER_READ_ONLY bigint unsigned not null,
	MIN_TIMER_READ_ONLY bigint unsigned not null,
	AVG_TIMER_READ_ONLY bigint unsigned not null,
	MAX_TIMER_READ_ONLY bigint unsigned not null,
	constraint HOST
		unique (HOST, EVENT_NAME) using hash
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_transactions_summary_by_thread_by_event_name
(
	THREAD_ID bigint unsigned not null,
	EVENT_NAME varchar(128) not null,
	COUNT_STAR bigint unsigned not null,
	SUM_TIMER_WAIT bigint unsigned not null,
	MIN_TIMER_WAIT bigint unsigned not null,
	AVG_TIMER_WAIT bigint unsigned not null,
	MAX_TIMER_WAIT bigint unsigned not null,
	COUNT_READ_WRITE bigint unsigned not null,
	SUM_TIMER_READ_WRITE bigint unsigned not null,
	MIN_TIMER_READ_WRITE bigint unsigned not null,
	AVG_TIMER_READ_WRITE bigint unsigned not null,
	MAX_TIMER_READ_WRITE bigint unsigned not null,
	COUNT_READ_ONLY bigint unsigned not null,
	SUM_TIMER_READ_ONLY bigint unsigned not null,
	MIN_TIMER_READ_ONLY bigint unsigned not null,
	AVG_TIMER_READ_ONLY bigint unsigned not null,
	MAX_TIMER_READ_ONLY bigint unsigned not null,
	primary key (THREAD_ID, EVENT_NAME)
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_transactions_summary_by_user_by_event_name
(
	USER char(32) collate utf8mb4_bin null,
	EVENT_NAME varchar(128) not null,
	COUNT_STAR bigint unsigned not null,
	SUM_TIMER_WAIT bigint unsigned not null,
	MIN_TIMER_WAIT bigint unsigned not null,
	AVG_TIMER_WAIT bigint unsigned not null,
	MAX_TIMER_WAIT bigint unsigned not null,
	COUNT_READ_WRITE bigint unsigned not null,
	SUM_TIMER_READ_WRITE bigint unsigned not null,
	MIN_TIMER_READ_WRITE bigint unsigned not null,
	AVG_TIMER_READ_WRITE bigint unsigned not null,
	MAX_TIMER_READ_WRITE bigint unsigned not null,
	COUNT_READ_ONLY bigint unsigned not null,
	SUM_TIMER_READ_ONLY bigint unsigned not null,
	MIN_TIMER_READ_ONLY bigint unsigned not null,
	AVG_TIMER_READ_ONLY bigint unsigned not null,
	MAX_TIMER_READ_ONLY bigint unsigned not null,
	constraint USER
		unique (USER, EVENT_NAME) using hash
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_transactions_summary_global_by_event_name
(
	EVENT_NAME varchar(128) not null
		primary key,
	COUNT_STAR bigint unsigned not null,
	SUM_TIMER_WAIT bigint unsigned not null,
	MIN_TIMER_WAIT bigint unsigned not null,
	AVG_TIMER_WAIT bigint unsigned not null,
	MAX_TIMER_WAIT bigint unsigned not null,
	COUNT_READ_WRITE bigint unsigned not null,
	SUM_TIMER_READ_WRITE bigint unsigned not null,
	MIN_TIMER_READ_WRITE bigint unsigned not null,
	AVG_TIMER_READ_WRITE bigint unsigned not null,
	MAX_TIMER_READ_WRITE bigint unsigned not null,
	COUNT_READ_ONLY bigint unsigned not null,
	SUM_TIMER_READ_ONLY bigint unsigned not null,
	MIN_TIMER_READ_ONLY bigint unsigned not null,
	AVG_TIMER_READ_ONLY bigint unsigned not null,
	MAX_TIMER_READ_ONLY bigint unsigned not null
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_waits_current
(
	THREAD_ID bigint unsigned not null,
	EVENT_ID bigint unsigned not null,
	END_EVENT_ID bigint unsigned null,
	EVENT_NAME varchar(128) not null,
	SOURCE varchar(64) null,
	TIMER_START bigint unsigned null,
	TIMER_END bigint unsigned null,
	TIMER_WAIT bigint unsigned null,
	SPINS int unsigned null,
	OBJECT_SCHEMA varchar(64) null,
	OBJECT_NAME varchar(512) null,
	INDEX_NAME varchar(64) null,
	OBJECT_TYPE varchar(64) null,
	OBJECT_INSTANCE_BEGIN bigint unsigned not null,
	NESTING_EVENT_ID bigint unsigned null,
	NESTING_EVENT_TYPE enum('TRANSACTION', 'STATEMENT', 'STAGE', 'WAIT') null,
	OPERATION varchar(32) not null,
	NUMBER_OF_BYTES bigint null,
	FLAGS int unsigned null,
	primary key (THREAD_ID, EVENT_ID)
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_waits_history
(
	THREAD_ID bigint unsigned not null,
	EVENT_ID bigint unsigned not null,
	END_EVENT_ID bigint unsigned null,
	EVENT_NAME varchar(128) not null,
	SOURCE varchar(64) null,
	TIMER_START bigint unsigned null,
	TIMER_END bigint unsigned null,
	TIMER_WAIT bigint unsigned null,
	SPINS int unsigned null,
	OBJECT_SCHEMA varchar(64) null,
	OBJECT_NAME varchar(512) null,
	INDEX_NAME varchar(64) null,
	OBJECT_TYPE varchar(64) null,
	OBJECT_INSTANCE_BEGIN bigint unsigned not null,
	NESTING_EVENT_ID bigint unsigned null,
	NESTING_EVENT_TYPE enum('TRANSACTION', 'STATEMENT', 'STAGE', 'WAIT') null,
	OPERATION varchar(32) not null,
	NUMBER_OF_BYTES bigint null,
	FLAGS int unsigned null,
	primary key (THREAD_ID, EVENT_ID)
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_waits_history_long
(
	THREAD_ID bigint unsigned not null,
	EVENT_ID bigint unsigned not null,
	END_EVENT_ID bigint unsigned null,
	EVENT_NAME varchar(128) not null,
	SOURCE varchar(64) null,
	TIMER_START bigint unsigned null,
	TIMER_END bigint unsigned null,
	TIMER_WAIT bigint unsigned null,
	SPINS int unsigned null,
	OBJECT_SCHEMA varchar(64) null,
	OBJECT_NAME varchar(512) null,
	INDEX_NAME varchar(64) null,
	OBJECT_TYPE varchar(64) null,
	OBJECT_INSTANCE_BEGIN bigint unsigned not null,
	NESTING_EVENT_ID bigint unsigned null,
	NESTING_EVENT_TYPE enum('TRANSACTION', 'STATEMENT', 'STAGE', 'WAIT') null,
	OPERATION varchar(32) not null,
	NUMBER_OF_BYTES bigint null,
	FLAGS int unsigned null
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_waits_summary_by_account_by_event_name
(
	USER char(32) collate utf8mb4_bin null,
	HOST char(255) charset ascii null,
	EVENT_NAME varchar(128) not null,
	COUNT_STAR bigint unsigned not null,
	SUM_TIMER_WAIT bigint unsigned not null,
	MIN_TIMER_WAIT bigint unsigned not null,
	AVG_TIMER_WAIT bigint unsigned not null,
	MAX_TIMER_WAIT bigint unsigned not null,
	constraint ACCOUNT
		unique (USER, HOST, EVENT_NAME) using hash
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_waits_summary_by_host_by_event_name
(
	HOST char(255) charset ascii null,
	EVENT_NAME varchar(128) not null,
	COUNT_STAR bigint unsigned not null,
	SUM_TIMER_WAIT bigint unsigned not null,
	MIN_TIMER_WAIT bigint unsigned not null,
	AVG_TIMER_WAIT bigint unsigned not null,
	MAX_TIMER_WAIT bigint unsigned not null,
	constraint HOST
		unique (HOST, EVENT_NAME) using hash
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_waits_summary_by_instance
(
	EVENT_NAME varchar(128) not null,
	OBJECT_INSTANCE_BEGIN bigint unsigned not null
		primary key,
	COUNT_STAR bigint unsigned not null,
	SUM_TIMER_WAIT bigint unsigned not null,
	MIN_TIMER_WAIT bigint unsigned not null,
	AVG_TIMER_WAIT bigint unsigned not null,
	MAX_TIMER_WAIT bigint unsigned not null
)
engine=PERFORMANCE_SCHEMA;

create index EVENT_NAME
	on performance_schema.events_waits_summary_by_instance (EVENT_NAME)
	using hash;

create table performance_schema.events_waits_summary_by_thread_by_event_name
(
	THREAD_ID bigint unsigned not null,
	EVENT_NAME varchar(128) not null,
	COUNT_STAR bigint unsigned not null,
	SUM_TIMER_WAIT bigint unsigned not null,
	MIN_TIMER_WAIT bigint unsigned not null,
	AVG_TIMER_WAIT bigint unsigned not null,
	MAX_TIMER_WAIT bigint unsigned not null,
	primary key (THREAD_ID, EVENT_NAME)
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_waits_summary_by_user_by_event_name
(
	USER char(32) collate utf8mb4_bin null,
	EVENT_NAME varchar(128) not null,
	COUNT_STAR bigint unsigned not null,
	SUM_TIMER_WAIT bigint unsigned not null,
	MIN_TIMER_WAIT bigint unsigned not null,
	AVG_TIMER_WAIT bigint unsigned not null,
	MAX_TIMER_WAIT bigint unsigned not null,
	constraint USER
		unique (USER, EVENT_NAME) using hash
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.events_waits_summary_global_by_event_name
(
	EVENT_NAME varchar(128) not null
		primary key,
	COUNT_STAR bigint unsigned not null,
	SUM_TIMER_WAIT bigint unsigned not null,
	MIN_TIMER_WAIT bigint unsigned not null,
	AVG_TIMER_WAIT bigint unsigned not null,
	MAX_TIMER_WAIT bigint unsigned not null
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.file_instances
(
	FILE_NAME varchar(512) not null
		primary key,
	EVENT_NAME varchar(128) not null,
	OPEN_COUNT int unsigned not null
)
engine=PERFORMANCE_SCHEMA;

create index EVENT_NAME
	on performance_schema.file_instances (EVENT_NAME)
	using hash;

create table performance_schema.file_summary_by_event_name
(
	EVENT_NAME varchar(128) not null
		primary key,
	COUNT_STAR bigint unsigned not null,
	SUM_TIMER_WAIT bigint unsigned not null,
	MIN_TIMER_WAIT bigint unsigned not null,
	AVG_TIMER_WAIT bigint unsigned not null,
	MAX_TIMER_WAIT bigint unsigned not null,
	COUNT_READ bigint unsigned not null,
	SUM_TIMER_READ bigint unsigned not null,
	MIN_TIMER_READ bigint unsigned not null,
	AVG_TIMER_READ bigint unsigned not null,
	MAX_TIMER_READ bigint unsigned not null,
	SUM_NUMBER_OF_BYTES_READ bigint not null,
	COUNT_WRITE bigint unsigned not null,
	SUM_TIMER_WRITE bigint unsigned not null,
	MIN_TIMER_WRITE bigint unsigned not null,
	AVG_TIMER_WRITE bigint unsigned not null,
	MAX_TIMER_WRITE bigint unsigned not null,
	SUM_NUMBER_OF_BYTES_WRITE bigint not null,
	COUNT_MISC bigint unsigned not null,
	SUM_TIMER_MISC bigint unsigned not null,
	MIN_TIMER_MISC bigint unsigned not null,
	AVG_TIMER_MISC bigint unsigned not null,
	MAX_TIMER_MISC bigint unsigned not null
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.file_summary_by_instance
(
	FILE_NAME varchar(512) not null,
	EVENT_NAME varchar(128) not null,
	OBJECT_INSTANCE_BEGIN bigint unsigned not null
		primary key,
	COUNT_STAR bigint unsigned not null,
	SUM_TIMER_WAIT bigint unsigned not null,
	MIN_TIMER_WAIT bigint unsigned not null,
	AVG_TIMER_WAIT bigint unsigned not null,
	MAX_TIMER_WAIT bigint unsigned not null,
	COUNT_READ bigint unsigned not null,
	SUM_TIMER_READ bigint unsigned not null,
	MIN_TIMER_READ bigint unsigned not null,
	AVG_TIMER_READ bigint unsigned not null,
	MAX_TIMER_READ bigint unsigned not null,
	SUM_NUMBER_OF_BYTES_READ bigint not null,
	COUNT_WRITE bigint unsigned not null,
	SUM_TIMER_WRITE bigint unsigned not null,
	MIN_TIMER_WRITE bigint unsigned not null,
	AVG_TIMER_WRITE bigint unsigned not null,
	MAX_TIMER_WRITE bigint unsigned not null,
	SUM_NUMBER_OF_BYTES_WRITE bigint not null,
	COUNT_MISC bigint unsigned not null,
	SUM_TIMER_MISC bigint unsigned not null,
	MIN_TIMER_MISC bigint unsigned not null,
	AVG_TIMER_MISC bigint unsigned not null,
	MAX_TIMER_MISC bigint unsigned not null
)
engine=PERFORMANCE_SCHEMA;

create index EVENT_NAME
	on performance_schema.file_summary_by_instance (EVENT_NAME)
	using hash;

create index FILE_NAME
	on performance_schema.file_summary_by_instance (FILE_NAME)
	using hash;

create table mysql.func
(
	name char(64) default '' not null
		primary key,
	ret tinyint default 0 not null,
	dl char(128) default '' not null,
	type enum('function', 'aggregate') charset utf8mb3 not null
)
comment 'User defined functions' collate=utf8mb3_bin;

create table mysql.general_log
(
	event_time timestamp(6) default CURRENT_TIMESTAMP(6) not null on update CURRENT_TIMESTAMP(6),
	user_host mediumtext not null,
	thread_id bigint unsigned not null,
	server_id int unsigned not null,
	command_type varchar(64) not null,
	argument mediumblob not null
)
comment 'General log' engine=CSV charset=utf8mb3;

create table mysql.global_grants
(
	USER char(32) default '' not null,
	HOST char(255) charset ascii default '' not null,
	PRIV char(32) charset utf8mb3 default '' not null,
	WITH_GRANT_OPTION enum('N', 'Y') charset utf8mb3 default 'N' not null,
	primary key (USER, HOST, PRIV)
)
comment 'Extended global grants' collate=utf8mb3_bin;

create table performance_schema.global_status
(
	VARIABLE_NAME varchar(64) not null
		primary key,
	VARIABLE_VALUE varchar(1024) null
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.global_variables
(
	VARIABLE_NAME varchar(64) not null
		primary key,
	VARIABLE_VALUE varchar(1024) null
)
engine=PERFORMANCE_SCHEMA;

create table mysql.gtid_executed
(
	source_uuid char(36) not null comment 'uuid of the source where the transaction was originally executed.',
	interval_start bigint not null comment 'First number of interval.',
	interval_end bigint not null comment 'Last number of interval.',
	primary key (source_uuid, interval_start)
);

create table mysql.help_category
(
	help_category_id smallint unsigned not null
		primary key,
	name char(64) not null,
	parent_category_id smallint unsigned null,
	url text not null,
	constraint name
		unique (name)
)
comment 'help categories' charset=utf8mb3;

create table mysql.help_keyword
(
	help_keyword_id int unsigned not null
		primary key,
	name char(64) not null,
	constraint name
		unique (name)
)
comment 'help keywords' charset=utf8mb3;

create table mysql.help_relation
(
	help_topic_id int unsigned not null,
	help_keyword_id int unsigned not null,
	primary key (help_keyword_id, help_topic_id)
)
comment 'keyword-topic relation' charset=utf8mb3;

create table mysql.help_topic
(
	help_topic_id int unsigned not null
		primary key,
	name char(64) not null,
	help_category_id smallint unsigned not null,
	description text not null,
	example text not null,
	url text not null,
	constraint name
		unique (name)
)
comment 'help topics' charset=utf8mb3;

create table performance_schema.host_cache
(
	IP varchar(64) not null
		primary key,
	HOST varchar(255) charset ascii null,
	HOST_VALIDATED enum('YES', 'NO') not null,
	SUM_CONNECT_ERRORS bigint not null,
	COUNT_HOST_BLOCKED_ERRORS bigint not null,
	COUNT_NAMEINFO_TRANSIENT_ERRORS bigint not null,
	COUNT_NAMEINFO_PERMANENT_ERRORS bigint not null,
	COUNT_FORMAT_ERRORS bigint not null,
	COUNT_ADDRINFO_TRANSIENT_ERRORS bigint not null,
	COUNT_ADDRINFO_PERMANENT_ERRORS bigint not null,
	COUNT_FCRDNS_ERRORS bigint not null,
	COUNT_HOST_ACL_ERRORS bigint not null,
	COUNT_NO_AUTH_PLUGIN_ERRORS bigint not null,
	COUNT_AUTH_PLUGIN_ERRORS bigint not null,
	COUNT_HANDSHAKE_ERRORS bigint not null,
	COUNT_PROXY_USER_ERRORS bigint not null,
	COUNT_PROXY_USER_ACL_ERRORS bigint not null,
	COUNT_AUTHENTICATION_ERRORS bigint not null,
	COUNT_SSL_ERRORS bigint not null,
	COUNT_MAX_USER_CONNECTIONS_ERRORS bigint not null,
	COUNT_MAX_USER_CONNECTIONS_PER_HOUR_ERRORS bigint not null,
	COUNT_DEFAULT_DATABASE_ERRORS bigint not null,
	COUNT_INIT_CONNECT_ERRORS bigint not null,
	COUNT_LOCAL_ERRORS bigint not null,
	COUNT_UNKNOWN_ERRORS bigint not null,
	FIRST_SEEN timestamp not null,
	LAST_SEEN timestamp not null,
	FIRST_ERROR_SEEN timestamp null,
	LAST_ERROR_SEEN timestamp null
)
engine=PERFORMANCE_SCHEMA;

create index HOST
	on performance_schema.host_cache (HOST)
	using hash;

create table performance_schema.hosts
(
	HOST char(255) charset ascii null,
	CURRENT_CONNECTIONS bigint not null,
	TOTAL_CONNECTIONS bigint not null,
	MAX_SESSION_CONTROLLED_MEMORY bigint unsigned not null,
	MAX_SESSION_TOTAL_MEMORY bigint unsigned not null,
	constraint HOST
		unique (HOST) using hash
)
engine=PERFORMANCE_SCHEMA;

create table mysql.innodb_index_stats
(
	database_name varchar(64) not null,
	table_name varchar(199) not null,
	index_name varchar(64) not null,
	last_update timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
	stat_name varchar(64) not null,
	stat_value bigint unsigned not null,
	sample_size bigint unsigned null,
	stat_description varchar(1024) not null,
	primary key (database_name, table_name, index_name, stat_name)
)
collate=utf8mb3_bin;

create table performance_schema.innodb_redo_log_files
(
	FILE_ID bigint not null comment 'Id of the file.',
	FILE_NAME varchar(2000) not null comment 'Path to the file.',
	START_LSN bigint not null comment 'LSN of the first block in the file.',
	END_LSN bigint not null comment 'LSN after the last block in the file.',
	SIZE_IN_BYTES bigint not null comment 'Size of the file (in bytes).',
	IS_FULL tinyint not null comment '1 iff file has no free space inside.',
	CONSUMER_LEVEL int not null comment 'All redo log consumers registered on smaller levels than this value, have already consumed this file.'
)
engine=PERFORMANCE_SCHEMA;

create table mysql.innodb_table_stats
(
	database_name varchar(64) not null,
	table_name varchar(199) not null,
	last_update timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
	n_rows bigint unsigned not null,
	clustered_index_size bigint unsigned not null,
	sum_of_other_index_sizes bigint unsigned not null,
	primary key (database_name, table_name)
)
collate=utf8mb3_bin;

create table performance_schema.keyring_component_status
(
	STATUS_KEY varchar(256) not null,
	STATUS_VALUE varchar(1024) not null
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.keyring_keys
(
	KEY_ID varchar(255) not null,
	KEY_OWNER varchar(255) null,
	BACKEND_KEY_ID varchar(255) null
)
engine=PERFORMANCE_SCHEMA collate=utf8mb4_bin;

create table mysql.loan
(
	customerid int not null comment 'شماره مشتری',
	Serial int not null comment 'سریال',
	begindate timestamp not null comment 'زمان شروع تسهیلات',
	amountloan float not null comment ' مبلغ اصل تسهیلات',
	amountprofit float not null comment 'سود تسهیلات',
	paycount int not null comment 'تعداد اقساط',
	profitrate float not null comment ' نرخ تسهیلات بر مبنای درصد',
	currencyId int not null comment 'ارز تسهیلات',
	constraint loan_customerid_Serial_uindex
		unique (customerid, Serial)
)
comment 'تسهیلات';

create table mysql.loanpaytables
(
	customerid int not null comment 'مشتری ',
	Serial int not null comment 'سریال',
	paynumber int not null comment 'شماره قسط',
	ghestamount float not null comment 'مبلغ قسط',
	aslamount float not null comment 'مبلغ اصلی از قسط',
	sudamount float not null comment 'مبلغ سود از قسط',
	paystate int not null comment 'پرداخت شده =0و پرداخت نشده=1',
	Sarresidghest timestamp not null comment 'سررسید قسط',
	constraint loanpaytables_customerid_Serial_paynumber_uindex
		unique (customerid, Serial, paynumber)
)
comment 'جدول اقساط تسهیلات';

create table mysql.loanrate
(
	rateid int not null
		primary key,
	rate int not null comment 'نرخ'
)
comment 'نرخ سود تسهیلات';

create table performance_schema.log_status
(
	SERVER_UUID char(36) collate utf8mb4_bin not null,
	LOCAL json not null,
	REPLICATION json not null,
	STORAGE_ENGINES json not null
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.memory_summary_by_account_by_event_name
(
	USER char(32) collate utf8mb4_bin null,
	HOST char(255) charset ascii null,
	EVENT_NAME varchar(128) not null,
	COUNT_ALLOC bigint unsigned not null,
	COUNT_FREE bigint unsigned not null,
	SUM_NUMBER_OF_BYTES_ALLOC bigint unsigned not null,
	SUM_NUMBER_OF_BYTES_FREE bigint unsigned not null,
	LOW_COUNT_USED bigint not null,
	CURRENT_COUNT_USED bigint not null,
	HIGH_COUNT_USED bigint not null,
	LOW_NUMBER_OF_BYTES_USED bigint not null,
	CURRENT_NUMBER_OF_BYTES_USED bigint not null,
	HIGH_NUMBER_OF_BYTES_USED bigint not null,
	constraint ACCOUNT
		unique (USER, HOST, EVENT_NAME) using hash
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.memory_summary_by_host_by_event_name
(
	HOST char(255) charset ascii null,
	EVENT_NAME varchar(128) not null,
	COUNT_ALLOC bigint unsigned not null,
	COUNT_FREE bigint unsigned not null,
	SUM_NUMBER_OF_BYTES_ALLOC bigint unsigned not null,
	SUM_NUMBER_OF_BYTES_FREE bigint unsigned not null,
	LOW_COUNT_USED bigint not null,
	CURRENT_COUNT_USED bigint not null,
	HIGH_COUNT_USED bigint not null,
	LOW_NUMBER_OF_BYTES_USED bigint not null,
	CURRENT_NUMBER_OF_BYTES_USED bigint not null,
	HIGH_NUMBER_OF_BYTES_USED bigint not null,
	constraint HOST
		unique (HOST, EVENT_NAME) using hash
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.memory_summary_by_thread_by_event_name
(
	THREAD_ID bigint unsigned not null,
	EVENT_NAME varchar(128) not null,
	COUNT_ALLOC bigint unsigned not null,
	COUNT_FREE bigint unsigned not null,
	SUM_NUMBER_OF_BYTES_ALLOC bigint unsigned not null,
	SUM_NUMBER_OF_BYTES_FREE bigint unsigned not null,
	LOW_COUNT_USED bigint not null,
	CURRENT_COUNT_USED bigint not null,
	HIGH_COUNT_USED bigint not null,
	LOW_NUMBER_OF_BYTES_USED bigint not null,
	CURRENT_NUMBER_OF_BYTES_USED bigint not null,
	HIGH_NUMBER_OF_BYTES_USED bigint not null,
	primary key (THREAD_ID, EVENT_NAME)
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.memory_summary_by_user_by_event_name
(
	USER char(32) collate utf8mb4_bin null,
	EVENT_NAME varchar(128) not null,
	COUNT_ALLOC bigint unsigned not null,
	COUNT_FREE bigint unsigned not null,
	SUM_NUMBER_OF_BYTES_ALLOC bigint unsigned not null,
	SUM_NUMBER_OF_BYTES_FREE bigint unsigned not null,
	LOW_COUNT_USED bigint not null,
	CURRENT_COUNT_USED bigint not null,
	HIGH_COUNT_USED bigint not null,
	LOW_NUMBER_OF_BYTES_USED bigint not null,
	CURRENT_NUMBER_OF_BYTES_USED bigint not null,
	HIGH_NUMBER_OF_BYTES_USED bigint not null,
	constraint USER
		unique (USER, EVENT_NAME) using hash
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.memory_summary_global_by_event_name
(
	EVENT_NAME varchar(128) not null
		primary key,
	COUNT_ALLOC bigint unsigned not null,
	COUNT_FREE bigint unsigned not null,
	SUM_NUMBER_OF_BYTES_ALLOC bigint unsigned not null,
	SUM_NUMBER_OF_BYTES_FREE bigint unsigned not null,
	LOW_COUNT_USED bigint not null,
	CURRENT_COUNT_USED bigint not null,
	HIGH_COUNT_USED bigint not null,
	LOW_NUMBER_OF_BYTES_USED bigint not null,
	CURRENT_NUMBER_OF_BYTES_USED bigint not null,
	HIGH_NUMBER_OF_BYTES_USED bigint not null
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.metadata_locks
(
	OBJECT_TYPE varchar(64) not null,
	OBJECT_SCHEMA varchar(64) null,
	OBJECT_NAME varchar(64) null,
	COLUMN_NAME varchar(64) null,
	OBJECT_INSTANCE_BEGIN bigint unsigned not null
		primary key,
	LOCK_TYPE varchar(32) not null,
	LOCK_DURATION varchar(32) not null,
	LOCK_STATUS varchar(32) not null,
	SOURCE varchar(64) null,
	OWNER_THREAD_ID bigint unsigned null,
	OWNER_EVENT_ID bigint unsigned null
)
engine=PERFORMANCE_SCHEMA;

create index OBJECT_TYPE
	on performance_schema.metadata_locks (OBJECT_TYPE, OBJECT_SCHEMA, OBJECT_NAME, COLUMN_NAME)
	using hash;

create index OWNER_THREAD_ID
	on performance_schema.metadata_locks (OWNER_THREAD_ID, OWNER_EVENT_ID)
	using hash;

create table performance_schema.mutex_instances
(
	NAME varchar(128) not null,
	OBJECT_INSTANCE_BEGIN bigint unsigned not null
		primary key,
	LOCKED_BY_THREAD_ID bigint unsigned null
)
engine=PERFORMANCE_SCHEMA;

create index LOCKED_BY_THREAD_ID
	on performance_schema.mutex_instances (LOCKED_BY_THREAD_ID)
	using hash;

create index NAME
	on performance_schema.mutex_instances (NAME)
	using hash;

create table mysql.ndb_binlog_index
(
	Position bigint unsigned not null,
	File varchar(255) not null,
	epoch bigint unsigned not null,
	inserts int unsigned not null,
	updates int unsigned not null,
	deletes int unsigned not null,
	schemaops int unsigned not null,
	orig_server_id int unsigned not null,
	orig_epoch bigint unsigned not null,
	gci int unsigned not null,
	next_position bigint unsigned not null,
	next_file varchar(255) not null,
	primary key (epoch, orig_server_id, orig_epoch)
)
charset=latin1;

create table performance_schema.objects_summary_global_by_type
(
	OBJECT_TYPE varchar(64) null,
	OBJECT_SCHEMA varchar(64) null,
	OBJECT_NAME varchar(64) null,
	COUNT_STAR bigint unsigned not null,
	SUM_TIMER_WAIT bigint unsigned not null,
	MIN_TIMER_WAIT bigint unsigned not null,
	AVG_TIMER_WAIT bigint unsigned not null,
	MAX_TIMER_WAIT bigint unsigned not null,
	constraint OBJECT
		unique (OBJECT_TYPE, OBJECT_SCHEMA, OBJECT_NAME) using hash
)
engine=PERFORMANCE_SCHEMA;

create table mysql.org_customer
(
	id int not null comment 'شماره مشتری',
	shomaresabt tinytext not null comment 'شماره ثبت',
	fullname tinytext null comment 'عنوان مشتری',
	constraint org_customer_id_uindex
		unique (id),
	constraint org_customer_customer_customer_id_fk
		foreign key (id) references mysql.customer (customer_id)
)
comment 'مشتریان حقوقی';

create table mysql.password_history
(
	Host char(255) charset ascii default '' not null,
	User char(32) default '' not null,
	Password_timestamp timestamp(6) default CURRENT_TIMESTAMP(6) not null,
	Password text null,
	primary key (Host, User, Password_timestamp)
)
comment 'Password history for user accounts' collate=utf8mb3_bin;

create table performance_schema.performance_timers
(
	TIMER_NAME enum('CYCLE', 'NANOSECOND', 'MICROSECOND', 'MILLISECOND', 'THREAD_CPU') not null,
	TIMER_FREQUENCY bigint null,
	TIMER_RESOLUTION bigint null,
	TIMER_OVERHEAD bigint null
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.persisted_variables
(
	VARIABLE_NAME varchar(64) not null
		primary key,
	VARIABLE_VALUE varchar(1024) null
)
engine=PERFORMANCE_SCHEMA;

create table mysql.plugin
(
	name varchar(64) default '' not null
		primary key,
	dl varchar(128) default '' not null
)
comment 'MySQL plugins' charset=utf8mb3;

create table performance_schema.prepared_statements_instances
(
	OBJECT_INSTANCE_BEGIN bigint unsigned not null
		primary key,
	STATEMENT_ID bigint unsigned not null,
	STATEMENT_NAME varchar(64) null,
	SQL_TEXT longtext not null,
	OWNER_THREAD_ID bigint unsigned not null,
	OWNER_EVENT_ID bigint unsigned not null,
	OWNER_OBJECT_TYPE enum('EVENT', 'FUNCTION', 'PROCEDURE', 'TABLE', 'TRIGGER') null,
	OWNER_OBJECT_SCHEMA varchar(64) null,
	OWNER_OBJECT_NAME varchar(64) null,
	EXECUTION_ENGINE enum('PRIMARY', 'SECONDARY') null,
	TIMER_PREPARE bigint unsigned not null,
	COUNT_REPREPARE bigint unsigned not null,
	COUNT_EXECUTE bigint unsigned not null,
	SUM_TIMER_EXECUTE bigint unsigned not null,
	MIN_TIMER_EXECUTE bigint unsigned not null,
	AVG_TIMER_EXECUTE bigint unsigned not null,
	MAX_TIMER_EXECUTE bigint unsigned not null,
	SUM_LOCK_TIME bigint unsigned not null,
	SUM_ERRORS bigint unsigned not null,
	SUM_WARNINGS bigint unsigned not null,
	SUM_ROWS_AFFECTED bigint unsigned not null,
	SUM_ROWS_SENT bigint unsigned not null,
	SUM_ROWS_EXAMINED bigint unsigned not null,
	SUM_CREATED_TMP_DISK_TABLES bigint unsigned not null,
	SUM_CREATED_TMP_TABLES bigint unsigned not null,
	SUM_SELECT_FULL_JOIN bigint unsigned not null,
	SUM_SELECT_FULL_RANGE_JOIN bigint unsigned not null,
	SUM_SELECT_RANGE bigint unsigned not null,
	SUM_SELECT_RANGE_CHECK bigint unsigned not null,
	SUM_SELECT_SCAN bigint unsigned not null,
	SUM_SORT_MERGE_PASSES bigint unsigned not null,
	SUM_SORT_RANGE bigint unsigned not null,
	SUM_SORT_ROWS bigint unsigned not null,
	SUM_SORT_SCAN bigint unsigned not null,
	SUM_NO_INDEX_USED bigint unsigned not null,
	SUM_NO_GOOD_INDEX_USED bigint unsigned not null,
	SUM_CPU_TIME bigint unsigned not null,
	MAX_CONTROLLED_MEMORY bigint unsigned not null,
	MAX_TOTAL_MEMORY bigint unsigned not null,
	COUNT_SECONDARY bigint unsigned not null,
	constraint OWNER_THREAD_ID
		unique (OWNER_THREAD_ID, OWNER_EVENT_ID) using hash
)
engine=PERFORMANCE_SCHEMA;

create index OWNER_OBJECT_TYPE
	on performance_schema.prepared_statements_instances (OWNER_OBJECT_TYPE, OWNER_OBJECT_SCHEMA, OWNER_OBJECT_NAME)
	using hash;

create index STATEMENT_ID
	on performance_schema.prepared_statements_instances (STATEMENT_ID)
	using hash;

create index STATEMENT_NAME
	on performance_schema.prepared_statements_instances (STATEMENT_NAME)
	using hash;

create table performance_schema.processlist
(
	ID bigint unsigned not null
		primary key,
	USER varchar(32) null,
	HOST varchar(261) charset ascii null,
	DB varchar(64) null,
	COMMAND varchar(16) null,
	TIME bigint null,
	STATE varchar(64) null,
	INFO longtext null,
	EXECUTION_ENGINE enum('PRIMARY', 'SECONDARY') null
)
engine=PERFORMANCE_SCHEMA;

create table mysql.procs_priv
(
	Host char(255) charset ascii default '' not null,
	Db char(64) default '' not null,
	User char(32) default '' not null,
	Routine_name char(64) charset utf8mb3 default '' not null,
	Routine_type enum('FUNCTION', 'PROCEDURE') not null,
	Grantor varchar(288) default '' not null,
	Proc_priv set('Execute', 'Alter Routine', 'Grant') charset utf8mb3 default '' not null,
	Timestamp timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
	primary key (Host, User, Db, Routine_name, Routine_type)
)
comment 'Procedure privileges' collate=utf8mb3_bin;

create index Grantor
	on mysql.procs_priv (Grantor);

create table mysql.proxies_priv
(
	Host char(255) charset ascii default '' not null,
	User char(32) default '' not null,
	Proxied_host char(255) charset ascii default '' not null,
	Proxied_user char(32) default '' not null,
	With_grant tinyint(1) default 0 not null,
	Grantor varchar(288) default '' not null,
	Timestamp timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
	primary key (Host, User, Proxied_host, Proxied_user)
)
comment 'User proxy privileges' collate=utf8mb3_bin;

create index Grantor
	on mysql.proxies_priv (Grantor);

create table mysql.real_customer
(
	fname tinytext not null comment 'نام مشتری',
	lname tinytext not null comment 'نام خانوادگی',
	codemeli varchar(10) not null comment 'کد ملی',
	id int auto_increment,
	constraint real_customer_codemeli_uindex
		unique (codemeli),
	constraint real_customer_id_uindex
		unique (id),
	constraint real_customer_customer_customer_id_fk
		foreign key (id) references mysql.customer (customer_id)
)
comment 'مشتریان حقیقی';

alter table mysql.real_customer
	add primary key (id);

create table performance_schema.replication_applier_configuration
(
	CHANNEL_NAME char(64) not null
		primary key,
	DESIRED_DELAY int not null,
	PRIVILEGE_CHECKS_USER text collate utf8mb3_bin null comment 'User name for the security context of the applier.',
	REQUIRE_ROW_FORMAT enum('YES', 'NO') not null comment 'Indicates whether the channel shall only accept row based events.',
	REQUIRE_TABLE_PRIMARY_KEY_CHECK enum('STREAM', 'ON', 'OFF') not null comment 'Indicates what is the channel policy regarding tables having primary keys on create and alter table queries',
	ASSIGN_GTIDS_TO_ANONYMOUS_TRANSACTIONS_TYPE enum('OFF', 'LOCAL', 'UUID') not null comment 'Indicates whether the channel will generate a new GTID for anonymous transactions. OFF means that anonymous transactions will remain anonymous. LOCAL means that anonymous transactions will be assigned a newly generated GTID based on server_uuid. UUID indicates that anonymous transactions will be assigned a newly generated GTID based on Assign_gtids_to_anonymous_transactions_value',
	ASSIGN_GTIDS_TO_ANONYMOUS_TRANSACTIONS_VALUE text collate utf8mb3_bin null comment 'Indicates the UUID used while generating GTIDs for anonymous transactions'
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.replication_applier_filters
(
	CHANNEL_NAME char(64) not null,
	FILTER_NAME char(64) not null,
	FILTER_RULE longtext not null,
	CONFIGURED_BY enum('STARTUP_OPTIONS', 'CHANGE_REPLICATION_FILTER', 'STARTUP_OPTIONS_FOR_CHANNEL', 'CHANGE_REPLICATION_FILTER_FOR_CHANNEL') not null,
	ACTIVE_SINCE timestamp(6) not null,
	COUNTER bigint unsigned default '0' not null
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.replication_applier_global_filters
(
	FILTER_NAME char(64) not null,
	FILTER_RULE longtext not null,
	CONFIGURED_BY enum('STARTUP_OPTIONS', 'CHANGE_REPLICATION_FILTER') not null,
	ACTIVE_SINCE timestamp(6) not null
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.replication_applier_status
(
	CHANNEL_NAME char(64) not null
		primary key,
	SERVICE_STATE enum('ON', 'OFF') not null,
	REMAINING_DELAY int unsigned null,
	COUNT_TRANSACTIONS_RETRIES bigint unsigned not null
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.replication_applier_status_by_coordinator
(
	CHANNEL_NAME char(64) not null
		primary key,
	THREAD_ID bigint unsigned null,
	SERVICE_STATE enum('ON', 'OFF') not null,
	LAST_ERROR_NUMBER int not null,
	LAST_ERROR_MESSAGE varchar(1024) not null,
	LAST_ERROR_TIMESTAMP timestamp(6) not null,
	LAST_PROCESSED_TRANSACTION char(57) null,
	LAST_PROCESSED_TRANSACTION_ORIGINAL_COMMIT_TIMESTAMP timestamp(6) not null,
	LAST_PROCESSED_TRANSACTION_IMMEDIATE_COMMIT_TIMESTAMP timestamp(6) not null,
	LAST_PROCESSED_TRANSACTION_START_BUFFER_TIMESTAMP timestamp(6) not null,
	LAST_PROCESSED_TRANSACTION_END_BUFFER_TIMESTAMP timestamp(6) not null,
	PROCESSING_TRANSACTION char(57) null,
	PROCESSING_TRANSACTION_ORIGINAL_COMMIT_TIMESTAMP timestamp(6) not null,
	PROCESSING_TRANSACTION_IMMEDIATE_COMMIT_TIMESTAMP timestamp(6) not null,
	PROCESSING_TRANSACTION_START_BUFFER_TIMESTAMP timestamp(6) not null
)
engine=PERFORMANCE_SCHEMA;

create index THREAD_ID
	on performance_schema.replication_applier_status_by_coordinator (THREAD_ID)
	using hash;

create table performance_schema.replication_applier_status_by_worker
(
	CHANNEL_NAME char(64) not null,
	WORKER_ID bigint unsigned not null,
	THREAD_ID bigint unsigned null,
	SERVICE_STATE enum('ON', 'OFF') not null,
	LAST_ERROR_NUMBER int not null,
	LAST_ERROR_MESSAGE varchar(1024) not null,
	LAST_ERROR_TIMESTAMP timestamp(6) not null,
	LAST_APPLIED_TRANSACTION char(57) null,
	LAST_APPLIED_TRANSACTION_ORIGINAL_COMMIT_TIMESTAMP timestamp(6) not null,
	LAST_APPLIED_TRANSACTION_IMMEDIATE_COMMIT_TIMESTAMP timestamp(6) not null,
	LAST_APPLIED_TRANSACTION_START_APPLY_TIMESTAMP timestamp(6) not null,
	LAST_APPLIED_TRANSACTION_END_APPLY_TIMESTAMP timestamp(6) not null,
	APPLYING_TRANSACTION char(57) null,
	APPLYING_TRANSACTION_ORIGINAL_COMMIT_TIMESTAMP timestamp(6) not null,
	APPLYING_TRANSACTION_IMMEDIATE_COMMIT_TIMESTAMP timestamp(6) not null,
	APPLYING_TRANSACTION_START_APPLY_TIMESTAMP timestamp(6) not null,
	LAST_APPLIED_TRANSACTION_RETRIES_COUNT bigint unsigned not null,
	LAST_APPLIED_TRANSACTION_LAST_TRANSIENT_ERROR_NUMBER int not null,
	LAST_APPLIED_TRANSACTION_LAST_TRANSIENT_ERROR_MESSAGE varchar(1024) null,
	LAST_APPLIED_TRANSACTION_LAST_TRANSIENT_ERROR_TIMESTAMP timestamp(6) not null,
	APPLYING_TRANSACTION_RETRIES_COUNT bigint unsigned not null,
	APPLYING_TRANSACTION_LAST_TRANSIENT_ERROR_NUMBER int not null,
	APPLYING_TRANSACTION_LAST_TRANSIENT_ERROR_MESSAGE varchar(1024) null,
	APPLYING_TRANSACTION_LAST_TRANSIENT_ERROR_TIMESTAMP timestamp(6) not null,
	primary key (CHANNEL_NAME, WORKER_ID)
)
engine=PERFORMANCE_SCHEMA;

create index THREAD_ID
	on performance_schema.replication_applier_status_by_worker (THREAD_ID)
	using hash;

create table mysql.replication_asynchronous_connection_failover
(
	Channel_name char(64) not null comment 'The replication channel name that connects source and replica.',
	Host char(255) charset ascii not null comment 'The source hostname that the replica will attempt to switch over the replication connection to in case of a failure.',
	Port int unsigned not null comment 'The source port that the replica will attempt to switch over the replication connection to in case of a failure.',
	Network_namespace char(64) not null comment 'The source network namespace that the replica will attempt to switch over the replication connection to in case of a failure. If its value is empty, connections use the default (global) namespace.',
	Weight tinyint unsigned not null comment 'The order in which the replica shall try to switch the connection over to when there are failures. Weight can be set to a number between 1 and 100, where 100 is the highest weight and 1 the lowest.',
	Managed_name char(64) default '' not null comment 'The name of the group which this server belongs to.',
	primary key (Channel_name, Host, Port, Network_namespace, Managed_name)
)
comment 'The source configuration details' charset=utf8mb3;

create table performance_schema.replication_asynchronous_connection_failover
(
	CHANNEL_NAME char(64) charset utf8mb3 not null comment 'The replication channel name that connects source and replica.',
	HOST char(255) charset ascii not null comment 'The source hostname that the replica will attempt to switch over the replication connection to in case of a failure.',
	PORT int not null comment 'The source port that the replica will attempt to switch over the replication connection to in case of a failure.',
	NETWORK_NAMESPACE char(64) null comment 'The source network namespace that the replica will attempt to switch over the replication connection to in case of a failure. If its value is empty, connections use the default (global) namespace.',
	WEIGHT int unsigned not null comment 'The order in which the replica shall try to switch the connection over to when there are failures. Weight can be set to a number between 1 and 100, where 100 is the highest weight and 1 the lowest.',
	MANAGED_NAME char(64) charset utf8mb3 default '' not null comment 'The name of the group which this server belongs to.'
)
engine=PERFORMANCE_SCHEMA;

create index Channel_name
	on mysql.replication_asynchronous_connection_failover (Channel_name, Managed_name);

create table mysql.replication_asynchronous_connection_failover_managed
(
	Channel_name char(64) not null comment 'The replication channel name that connects source and replica.',
	Managed_name char(64) default '' not null comment 'The name of the source which needs to be managed.',
	Managed_type char(64) default '' not null comment 'Determines the managed type.',
	Configuration json null comment 'The data to help manage group. For Managed_type = GroupReplication, Configuration value should contain {"Primary_weight": 80, "Secondary_weight": 60}, so that it assigns weight=80 to PRIMARY of the group, and weight=60 for rest of the members in mysql.replication_asynchronous_connection_failover table.',
	primary key (Channel_name, Managed_name)
)
comment 'The managed source configuration details' charset=utf8mb3;

create table performance_schema.replication_asynchronous_connection_failover_managed
(
	CHANNEL_NAME char(64) charset utf8mb3 not null comment 'The replication channel name that connects source and replica.',
	MANAGED_NAME char(64) charset utf8mb3 default '' not null comment 'The name of the source which needs to be managed.',
	MANAGED_TYPE char(64) charset utf8mb3 default '' not null comment 'Determines the managed type.',
	CONFIGURATION json null comment 'The data to help manage group. For Managed_type = GroupReplication, Configuration value should contain {"Primary_weight": 80, "Secondary_weight": 60}, so that it assigns weight=80 to PRIMARY of the group, and weight=60 for rest of the members in mysql.replication_asynchronous_connection_failover table.'
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.replication_connection_configuration
(
	CHANNEL_NAME char(64) not null
		primary key,
	HOST char(255) charset ascii not null,
	PORT int not null,
	USER char(32) collate utf8mb4_bin not null,
	NETWORK_INTERFACE char(60) collate utf8mb4_bin not null,
	AUTO_POSITION enum('1', '0') not null,
	SSL_ALLOWED enum('YES', 'NO', 'IGNORED') not null,
	SSL_CA_FILE varchar(512) not null,
	SSL_CA_PATH varchar(512) not null,
	SSL_CERTIFICATE varchar(512) not null,
	SSL_CIPHER varchar(512) not null,
	SSL_KEY varchar(512) not null,
	SSL_VERIFY_SERVER_CERTIFICATE enum('YES', 'NO') not null,
	SSL_CRL_FILE varchar(255) not null,
	SSL_CRL_PATH varchar(255) not null,
	CONNECTION_RETRY_INTERVAL int not null,
	CONNECTION_RETRY_COUNT bigint unsigned not null,
	HEARTBEAT_INTERVAL double(10,3) not null comment 'Number of seconds after which a heartbeat will be sent .',
	TLS_VERSION varchar(255) not null,
	PUBLIC_KEY_PATH varchar(512) not null,
	GET_PUBLIC_KEY enum('YES', 'NO') not null,
	NETWORK_NAMESPACE varchar(64) not null,
	COMPRESSION_ALGORITHM char(64) collate utf8mb4_bin not null comment 'Compression algorithm used for data transfer between master and slave.',
	ZSTD_COMPRESSION_LEVEL int not null comment 'Compression level associated with zstd compression algorithm.',
	TLS_CIPHERSUITES text collate utf8mb3_bin null,
	SOURCE_CONNECTION_AUTO_FAILOVER enum('1', '0') not null,
	GTID_ONLY enum('1', '0') not null comment 'Indicates if this channel only uses GTIDs and does not persist positions.'
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.replication_connection_status
(
	CHANNEL_NAME char(64) not null
		primary key,
	GROUP_NAME char(36) collate utf8mb4_bin not null,
	SOURCE_UUID char(36) collate utf8mb4_bin not null,
	THREAD_ID bigint unsigned null,
	SERVICE_STATE enum('ON', 'OFF', 'CONNECTING') not null,
	COUNT_RECEIVED_HEARTBEATS bigint unsigned default '0' not null,
	LAST_HEARTBEAT_TIMESTAMP timestamp(6) not null comment 'Shows when the most recent heartbeat signal was received.',
	RECEIVED_TRANSACTION_SET longtext not null,
	LAST_ERROR_NUMBER int not null,
	LAST_ERROR_MESSAGE varchar(1024) not null,
	LAST_ERROR_TIMESTAMP timestamp(6) not null,
	LAST_QUEUED_TRANSACTION char(57) null,
	LAST_QUEUED_TRANSACTION_ORIGINAL_COMMIT_TIMESTAMP timestamp(6) not null,
	LAST_QUEUED_TRANSACTION_IMMEDIATE_COMMIT_TIMESTAMP timestamp(6) not null,
	LAST_QUEUED_TRANSACTION_START_QUEUE_TIMESTAMP timestamp(6) not null,
	LAST_QUEUED_TRANSACTION_END_QUEUE_TIMESTAMP timestamp(6) not null,
	QUEUEING_TRANSACTION char(57) null,
	QUEUEING_TRANSACTION_ORIGINAL_COMMIT_TIMESTAMP timestamp(6) not null,
	QUEUEING_TRANSACTION_IMMEDIATE_COMMIT_TIMESTAMP timestamp(6) not null,
	QUEUEING_TRANSACTION_START_QUEUE_TIMESTAMP timestamp(6) not null
)
engine=PERFORMANCE_SCHEMA;

create index THREAD_ID
	on performance_schema.replication_connection_status (THREAD_ID)
	using hash;

create table mysql.replication_group_configuration_version
(
	name char(255) charset ascii not null comment 'The configuration name.'
		primary key,
	version bigint unsigned not null comment 'The version of the configuration name.'
)
comment 'The group configuration version.';

create table mysql.replication_group_member_actions
(
	name char(255) charset ascii not null comment 'The action name.',
	event char(64) charset ascii not null comment 'The event that will trigger the action.',
	enabled tinyint(1) not null comment 'Whether the action is enabled.',
	type char(64) charset ascii not null comment 'The action type.',
	priority tinyint unsigned not null comment 'The order on which the action will be run, value between 1 and 100, lower values first.',
	error_handling char(64) charset ascii not null comment 'On errors during the action will be handled: IGNORE, CRITICAL.',
	primary key (name, event)
)
comment 'The member actions configuration.';

create index event
	on mysql.replication_group_member_actions (event);

create table performance_schema.replication_group_member_stats
(
	CHANNEL_NAME char(64) not null,
	VIEW_ID char(60) collate utf8mb4_bin not null,
	MEMBER_ID char(36) collate utf8mb4_bin not null,
	COUNT_TRANSACTIONS_IN_QUEUE bigint unsigned not null,
	COUNT_TRANSACTIONS_CHECKED bigint unsigned not null,
	COUNT_CONFLICTS_DETECTED bigint unsigned not null,
	COUNT_TRANSACTIONS_ROWS_VALIDATING bigint unsigned not null,
	TRANSACTIONS_COMMITTED_ALL_MEMBERS longtext not null,
	LAST_CONFLICT_FREE_TRANSACTION text not null,
	COUNT_TRANSACTIONS_REMOTE_IN_APPLIER_QUEUE bigint unsigned not null,
	COUNT_TRANSACTIONS_REMOTE_APPLIED bigint unsigned not null,
	COUNT_TRANSACTIONS_LOCAL_PROPOSED bigint unsigned not null,
	COUNT_TRANSACTIONS_LOCAL_ROLLBACK bigint unsigned not null
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.replication_group_members
(
	CHANNEL_NAME char(64) not null,
	MEMBER_ID char(36) collate utf8mb4_bin not null,
	MEMBER_HOST char(255) charset ascii not null,
	MEMBER_PORT int null,
	MEMBER_STATE char(64) collate utf8mb4_bin not null,
	MEMBER_ROLE char(64) collate utf8mb4_bin not null,
	MEMBER_VERSION char(64) collate utf8mb4_bin not null,
	MEMBER_COMMUNICATION_STACK char(64) collate utf8mb4_bin not null
)
engine=PERFORMANCE_SCHEMA;

create table mysql.role_edges
(
	FROM_HOST char(255) charset ascii default '' not null,
	FROM_USER char(32) default '' not null,
	TO_HOST char(255) charset ascii default '' not null,
	TO_USER char(32) default '' not null,
	WITH_ADMIN_OPTION enum('N', 'Y') charset utf8mb3 default 'N' not null,
	primary key (FROM_HOST, FROM_USER, TO_HOST, TO_USER)
)
comment 'Role hierarchy and role grants' collate=utf8mb3_bin;

create table performance_schema.rwlock_instances
(
	NAME varchar(128) not null,
	OBJECT_INSTANCE_BEGIN bigint unsigned not null
		primary key,
	WRITE_LOCKED_BY_THREAD_ID bigint unsigned null,
	READ_LOCKED_BY_COUNT int unsigned not null
)
engine=PERFORMANCE_SCHEMA;

create index NAME
	on performance_schema.rwlock_instances (NAME)
	using hash;

create index WRITE_LOCKED_BY_THREAD_ID
	on performance_schema.rwlock_instances (WRITE_LOCKED_BY_THREAD_ID)
	using hash;

create table mysql.server_cost
(
	cost_name varchar(64) not null
		primary key,
	cost_value float null,
	last_update timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
	comment varchar(1024) null,
	default_value float as ((case `cost_name` when _utf8mb4'disk_temptable_create_cost' then 20.0 when _utf8mb4'disk_temptable_row_cost' then 0.5 when _utf8mb4'key_compare_cost' then 0.05 when _utf8mb4'memory_temptable_create_cost' then 1.0 when _utf8mb4'memory_temptable_row_cost' then 0.1 when _utf8mb4'row_evaluate_cost' then 0.1 else NULL end))
)
charset=utf8mb3;

create table mysql.servers
(
	Server_name char(64) default '' not null
		primary key,
	Host char(255) charset ascii default '' not null,
	Db char(64) default '' not null,
	Username char(64) default '' not null,
	Password char(64) default '' not null,
	Port int default 0 not null,
	Socket char(64) default '' not null,
	Wrapper char(64) default '' not null,
	Owner char(64) default '' not null
)
comment 'MySQL Foreign Servers table' charset=utf8mb3;

create table performance_schema.session_account_connect_attrs
(
	PROCESSLIST_ID bigint unsigned not null,
	ATTR_NAME varchar(32) not null,
	ATTR_VALUE varchar(1024) null,
	ORDINAL_POSITION int null,
	primary key (PROCESSLIST_ID, ATTR_NAME)
)
engine=PERFORMANCE_SCHEMA collate=utf8mb4_bin;

create table performance_schema.session_connect_attrs
(
	PROCESSLIST_ID bigint unsigned not null,
	ATTR_NAME varchar(32) not null,
	ATTR_VALUE varchar(1024) null,
	ORDINAL_POSITION int null,
	primary key (PROCESSLIST_ID, ATTR_NAME)
)
engine=PERFORMANCE_SCHEMA collate=utf8mb4_bin;

create table performance_schema.session_status
(
	VARIABLE_NAME varchar(64) not null
		primary key,
	VARIABLE_VALUE varchar(1024) null
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.session_variables
(
	VARIABLE_NAME varchar(64) not null
		primary key,
	VARIABLE_VALUE varchar(1024) null
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.setup_actors
(
	HOST char(255) charset ascii default '%' not null,
	USER char(32) collate utf8mb4_bin default '%' not null,
	ROLE char(32) collate utf8mb4_bin default '%' not null,
	ENABLED enum('YES', 'NO') default 'YES' not null,
	HISTORY enum('YES', 'NO') default 'YES' not null,
	primary key (HOST, USER, ROLE)
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.setup_consumers
(
	NAME varchar(64) not null
		primary key,
	ENABLED enum('YES', 'NO') not null
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.setup_instruments
(
	NAME varchar(128) not null
		primary key,
	ENABLED enum('YES', 'NO') not null,
	TIMED enum('YES', 'NO') null,
	PROPERTIES set('singleton', 'progress', 'user', 'global_statistics', 'mutable', 'controlled_by_default') not null,
	FLAGS set('controlled') null,
	VOLATILITY int not null,
	DOCUMENTATION longtext null
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.setup_objects
(
	OBJECT_TYPE enum('EVENT', 'FUNCTION', 'PROCEDURE', 'TABLE', 'TRIGGER') default 'TABLE' not null,
	OBJECT_SCHEMA varchar(64) default '%' null,
	OBJECT_NAME varchar(64) default '%' not null,
	ENABLED enum('YES', 'NO') default 'YES' not null,
	TIMED enum('YES', 'NO') default 'YES' not null,
	constraint OBJECT
		unique (OBJECT_TYPE, OBJECT_SCHEMA, OBJECT_NAME) using hash
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.setup_threads
(
	NAME varchar(128) not null
		primary key,
	ENABLED enum('YES', 'NO') not null,
	HISTORY enum('YES', 'NO') not null,
	PROPERTIES set('singleton', 'user') not null,
	VOLATILITY int not null,
	DOCUMENTATION longtext null
)
engine=PERFORMANCE_SCHEMA;

create table mysql.slave_master_info
(
	Number_of_lines int unsigned not null comment 'Number of lines in the file.',
	Master_log_name text collate utf8mb3_bin not null comment 'The name of the master binary log currently being read from the master.',
	Master_log_pos bigint unsigned not null comment 'The master log position of the last read event.',
	Host varchar(255) charset ascii null comment 'The host name of the source.',
	User_name text collate utf8mb3_bin null comment 'The user name used to connect to the master.',
	User_password text collate utf8mb3_bin null comment 'The password used to connect to the master.',
	Port int unsigned not null comment 'The network port used to connect to the master.',
	Connect_retry int unsigned not null comment 'The period (in seconds) that the slave will wait before trying to reconnect to the master.',
	Enabled_ssl tinyint(1) not null comment 'Indicates whether the server supports SSL connections.',
	Ssl_ca text collate utf8mb3_bin null comment 'The file used for the Certificate Authority (CA) certificate.',
	Ssl_capath text collate utf8mb3_bin null comment 'The path to the Certificate Authority (CA) certificates.',
	Ssl_cert text collate utf8mb3_bin null comment 'The name of the SSL certificate file.',
	Ssl_cipher text collate utf8mb3_bin null comment 'The name of the cipher in use for the SSL connection.',
	Ssl_key text collate utf8mb3_bin null comment 'The name of the SSL key file.',
	Ssl_verify_server_cert tinyint(1) not null comment 'Whether to verify the server certificate.',
	Heartbeat float not null,
	Bind text collate utf8mb3_bin null comment 'Displays which interface is employed when connecting to the MySQL server',
	Ignored_server_ids text collate utf8mb3_bin null comment 'The number of server IDs to be ignored, followed by the actual server IDs',
	Uuid text collate utf8mb3_bin null comment 'The master server uuid.',
	Retry_count bigint unsigned not null comment 'Number of reconnect attempts, to the master, before giving up.',
	Ssl_crl text collate utf8mb3_bin null comment 'The file used for the Certificate Revocation List (CRL)',
	Ssl_crlpath text collate utf8mb3_bin null comment 'The path used for Certificate Revocation List (CRL) files',
	Enabled_auto_position tinyint(1) not null comment 'Indicates whether GTIDs will be used to retrieve events from the master.',
	Channel_name varchar(64) not null comment 'The channel on which the replica is connected to a source. Used in Multisource Replication'
		primary key,
	Tls_version text collate utf8mb3_bin null comment 'Tls version',
	Public_key_path text collate utf8mb3_bin null comment 'The file containing public key of master server.',
	Get_public_key tinyint(1) not null comment 'Preference to get public key from master.',
	Network_namespace text collate utf8mb3_bin null comment 'Network namespace used for communication with the master server.',
	Master_compression_algorithm varchar(64) collate utf8mb3_bin not null comment 'Compression algorithm supported for data transfer between source and replica.',
	Master_zstd_compression_level int unsigned not null comment 'Compression level associated with zstd compression algorithm.',
	Tls_ciphersuites text collate utf8mb3_bin null comment 'Ciphersuites used for TLS 1.3 communication with the master server.',
	Source_connection_auto_failover tinyint(1) default 0 not null comment 'Indicates whether the channel connection failover is enabled.',
	Gtid_only tinyint(1) default 0 not null comment 'Indicates if this channel only uses GTIDs and does not persist positions.'
)
comment 'Master Information' charset=utf8mb3;

create table mysql.slave_relay_log_info
(
	Number_of_lines int unsigned not null comment 'Number of lines in the file or rows in the table. Used to version table definitions.',
	Relay_log_name text collate utf8mb3_bin null comment 'The name of the current relay log file.',
	Relay_log_pos bigint unsigned null comment 'The relay log position of the last executed event.',
	Master_log_name text collate utf8mb3_bin null comment 'The name of the master binary log file from which the events in the relay log file were read.',
	Master_log_pos bigint unsigned null comment 'The master log position of the last executed event.',
	Sql_delay int null comment 'The number of seconds that the slave must lag behind the master.',
	Number_of_workers int unsigned null,
	Id int unsigned null comment 'Internal Id that uniquely identifies this record.',
	Channel_name varchar(64) not null comment 'The channel on which the replica is connected to a source. Used in Multisource Replication'
		primary key,
	Privilege_checks_username varchar(32) collate utf8mb3_bin null comment 'Username part of PRIVILEGE_CHECKS_USER.',
	Privilege_checks_hostname varchar(255) charset ascii null comment 'Hostname part of PRIVILEGE_CHECKS_USER.',
	Require_row_format tinyint(1) not null comment 'Indicates whether the channel shall only accept row based events.',
	Require_table_primary_key_check enum('STREAM', 'ON', 'OFF') default 'STREAM' not null comment 'Indicates what is the channel policy regarding tables having primary keys on create and alter table queries',
	Assign_gtids_to_anonymous_transactions_type enum('OFF', 'LOCAL', 'UUID') default 'OFF' not null comment 'Indicates whether the channel will generate a new GTID for anonymous transactions. OFF means that anonymous transactions will remain anonymous. LOCAL means that anonymous transactions will be assigned a newly generated GTID based on server_uuid. UUID indicates that anonymous transactions will be assigned a newly generated GTID based on Assign_gtids_to_anonymous_transactions_value',
	Assign_gtids_to_anonymous_transactions_value text collate utf8mb3_bin null comment 'Indicates the UUID used while generating GTIDs for anonymous transactions'
)
comment 'Relay Log Information' charset=utf8mb3;

create table mysql.slave_worker_info
(
	Id int unsigned not null,
	Relay_log_name text collate utf8mb3_bin not null,
	Relay_log_pos bigint unsigned not null,
	Master_log_name text collate utf8mb3_bin not null,
	Master_log_pos bigint unsigned not null,
	Checkpoint_relay_log_name text collate utf8mb3_bin not null,
	Checkpoint_relay_log_pos bigint unsigned not null,
	Checkpoint_master_log_name text collate utf8mb3_bin not null,
	Checkpoint_master_log_pos bigint unsigned not null,
	Checkpoint_seqno int unsigned not null,
	Checkpoint_group_size int unsigned not null,
	Checkpoint_group_bitmap blob not null,
	Channel_name varchar(64) not null comment 'The channel on which the replica is connected to a source. Used in Multisource Replication',
	primary key (Channel_name, Id)
)
comment 'Worker Information' charset=utf8mb3;

create table mysql.slow_log
(
	start_time timestamp(6) default CURRENT_TIMESTAMP(6) not null on update CURRENT_TIMESTAMP(6),
	user_host mediumtext not null,
	query_time time(6) not null,
	lock_time time(6) not null,
	rows_sent int not null,
	rows_examined int not null,
	db varchar(512) not null,
	last_insert_id int not null,
	insert_id int not null,
	server_id int unsigned not null,
	sql_text mediumblob not null,
	thread_id bigint unsigned not null
)
comment 'Slow log' engine=CSV charset=utf8mb3;

create table performance_schema.socket_instances
(
	EVENT_NAME varchar(128) not null,
	OBJECT_INSTANCE_BEGIN bigint unsigned not null
		primary key,
	THREAD_ID bigint unsigned null,
	SOCKET_ID int not null,
	IP varchar(64) not null,
	PORT int not null,
	STATE enum('IDLE', 'ACTIVE') not null
)
engine=PERFORMANCE_SCHEMA;

create index IP
	on performance_schema.socket_instances (IP, PORT)
	using hash;

create index SOCKET_ID
	on performance_schema.socket_instances (SOCKET_ID)
	using hash;

create index THREAD_ID
	on performance_schema.socket_instances (THREAD_ID)
	using hash;

create table performance_schema.socket_summary_by_event_name
(
	EVENT_NAME varchar(128) not null
		primary key,
	COUNT_STAR bigint unsigned not null,
	SUM_TIMER_WAIT bigint unsigned not null,
	MIN_TIMER_WAIT bigint unsigned not null,
	AVG_TIMER_WAIT bigint unsigned not null,
	MAX_TIMER_WAIT bigint unsigned not null,
	COUNT_READ bigint unsigned not null,
	SUM_TIMER_READ bigint unsigned not null,
	MIN_TIMER_READ bigint unsigned not null,
	AVG_TIMER_READ bigint unsigned not null,
	MAX_TIMER_READ bigint unsigned not null,
	SUM_NUMBER_OF_BYTES_READ bigint unsigned not null,
	COUNT_WRITE bigint unsigned not null,
	SUM_TIMER_WRITE bigint unsigned not null,
	MIN_TIMER_WRITE bigint unsigned not null,
	AVG_TIMER_WRITE bigint unsigned not null,
	MAX_TIMER_WRITE bigint unsigned not null,
	SUM_NUMBER_OF_BYTES_WRITE bigint unsigned not null,
	COUNT_MISC bigint unsigned not null,
	SUM_TIMER_MISC bigint unsigned not null,
	MIN_TIMER_MISC bigint unsigned not null,
	AVG_TIMER_MISC bigint unsigned not null,
	MAX_TIMER_MISC bigint unsigned not null
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.socket_summary_by_instance
(
	EVENT_NAME varchar(128) not null,
	OBJECT_INSTANCE_BEGIN bigint unsigned not null
		primary key,
	COUNT_STAR bigint unsigned not null,
	SUM_TIMER_WAIT bigint unsigned not null,
	MIN_TIMER_WAIT bigint unsigned not null,
	AVG_TIMER_WAIT bigint unsigned not null,
	MAX_TIMER_WAIT bigint unsigned not null,
	COUNT_READ bigint unsigned not null,
	SUM_TIMER_READ bigint unsigned not null,
	MIN_TIMER_READ bigint unsigned not null,
	AVG_TIMER_READ bigint unsigned not null,
	MAX_TIMER_READ bigint unsigned not null,
	SUM_NUMBER_OF_BYTES_READ bigint unsigned not null,
	COUNT_WRITE bigint unsigned not null,
	SUM_TIMER_WRITE bigint unsigned not null,
	MIN_TIMER_WRITE bigint unsigned not null,
	AVG_TIMER_WRITE bigint unsigned not null,
	MAX_TIMER_WRITE bigint unsigned not null,
	SUM_NUMBER_OF_BYTES_WRITE bigint unsigned not null,
	COUNT_MISC bigint unsigned not null,
	SUM_TIMER_MISC bigint unsigned not null,
	MIN_TIMER_MISC bigint unsigned not null,
	AVG_TIMER_MISC bigint unsigned not null,
	MAX_TIMER_MISC bigint unsigned not null
)
engine=PERFORMANCE_SCHEMA;

create index EVENT_NAME
	on performance_schema.socket_summary_by_instance (EVENT_NAME)
	using hash;

create table performance_schema.status_by_account
(
	USER char(32) collate utf8mb4_bin null,
	HOST char(255) charset ascii null,
	VARIABLE_NAME varchar(64) not null,
	VARIABLE_VALUE varchar(1024) null,
	constraint ACCOUNT
		unique (USER, HOST, VARIABLE_NAME) using hash
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.status_by_host
(
	HOST char(255) charset ascii null,
	VARIABLE_NAME varchar(64) not null,
	VARIABLE_VALUE varchar(1024) null,
	constraint HOST
		unique (HOST, VARIABLE_NAME) using hash
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.status_by_thread
(
	THREAD_ID bigint unsigned not null,
	VARIABLE_NAME varchar(64) not null,
	VARIABLE_VALUE varchar(1024) null,
	primary key (THREAD_ID, VARIABLE_NAME)
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.status_by_user
(
	USER char(32) collate utf8mb4_bin null,
	VARIABLE_NAME varchar(64) not null,
	VARIABLE_VALUE varchar(1024) null,
	constraint USER
		unique (USER, VARIABLE_NAME) using hash
)
engine=PERFORMANCE_SCHEMA;

create table sys.sys_config
(
	variable varchar(128) not null
		primary key,
	value varchar(128) null,
	set_time timestamp default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP,
	set_by varchar(128) null
);

create definer = `mysql.sys`@localhost trigger sys.sys_config_insert_set_user
	before insert
	on sys.sys_config
	for each row
	BEGIN
    IF @sys.ignore_sys_config_triggers != true AND NEW.set_by IS NULL THEN
        SET NEW.set_by = USER();
    END IF;
END;

create definer = `mysql.sys`@localhost trigger sys.sys_config_update_set_user
	before update
	on sys.sys_config
	for each row
	BEGIN
    IF @sys.ignore_sys_config_triggers != true AND NEW.set_by IS NULL THEN
        SET NEW.set_by = USER();
    END IF;
END;

grant select on table sys.sys_config to 'mysql.sys'@localhost;

create table performance_schema.table_handles
(
	OBJECT_TYPE varchar(64) not null,
	OBJECT_SCHEMA varchar(64) not null,
	OBJECT_NAME varchar(64) not null,
	OBJECT_INSTANCE_BEGIN bigint unsigned not null
		primary key,
	OWNER_THREAD_ID bigint unsigned null,
	OWNER_EVENT_ID bigint unsigned null,
	INTERNAL_LOCK varchar(64) null,
	EXTERNAL_LOCK varchar(64) null
)
engine=PERFORMANCE_SCHEMA;

create index OBJECT_TYPE
	on performance_schema.table_handles (OBJECT_TYPE, OBJECT_SCHEMA, OBJECT_NAME)
	using hash;

create index OWNER_THREAD_ID
	on performance_schema.table_handles (OWNER_THREAD_ID, OWNER_EVENT_ID)
	using hash;

create table performance_schema.table_io_waits_summary_by_index_usage
(
	OBJECT_TYPE varchar(64) null,
	OBJECT_SCHEMA varchar(64) null,
	OBJECT_NAME varchar(64) null,
	INDEX_NAME varchar(64) null,
	COUNT_STAR bigint unsigned not null,
	SUM_TIMER_WAIT bigint unsigned not null,
	MIN_TIMER_WAIT bigint unsigned not null,
	AVG_TIMER_WAIT bigint unsigned not null,
	MAX_TIMER_WAIT bigint unsigned not null,
	COUNT_READ bigint unsigned not null,
	SUM_TIMER_READ bigint unsigned not null,
	MIN_TIMER_READ bigint unsigned not null,
	AVG_TIMER_READ bigint unsigned not null,
	MAX_TIMER_READ bigint unsigned not null,
	COUNT_WRITE bigint unsigned not null,
	SUM_TIMER_WRITE bigint unsigned not null,
	MIN_TIMER_WRITE bigint unsigned not null,
	AVG_TIMER_WRITE bigint unsigned not null,
	MAX_TIMER_WRITE bigint unsigned not null,
	COUNT_FETCH bigint unsigned not null,
	SUM_TIMER_FETCH bigint unsigned not null,
	MIN_TIMER_FETCH bigint unsigned not null,
	AVG_TIMER_FETCH bigint unsigned not null,
	MAX_TIMER_FETCH bigint unsigned not null,
	COUNT_INSERT bigint unsigned not null,
	SUM_TIMER_INSERT bigint unsigned not null,
	MIN_TIMER_INSERT bigint unsigned not null,
	AVG_TIMER_INSERT bigint unsigned not null,
	MAX_TIMER_INSERT bigint unsigned not null,
	COUNT_UPDATE bigint unsigned not null,
	SUM_TIMER_UPDATE bigint unsigned not null,
	MIN_TIMER_UPDATE bigint unsigned not null,
	AVG_TIMER_UPDATE bigint unsigned not null,
	MAX_TIMER_UPDATE bigint unsigned not null,
	COUNT_DELETE bigint unsigned not null,
	SUM_TIMER_DELETE bigint unsigned not null,
	MIN_TIMER_DELETE bigint unsigned not null,
	AVG_TIMER_DELETE bigint unsigned not null,
	MAX_TIMER_DELETE bigint unsigned not null,
	constraint OBJECT
		unique (OBJECT_TYPE, OBJECT_SCHEMA, OBJECT_NAME, INDEX_NAME) using hash
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.table_io_waits_summary_by_table
(
	OBJECT_TYPE varchar(64) null,
	OBJECT_SCHEMA varchar(64) null,
	OBJECT_NAME varchar(64) null,
	COUNT_STAR bigint unsigned not null,
	SUM_TIMER_WAIT bigint unsigned not null,
	MIN_TIMER_WAIT bigint unsigned not null,
	AVG_TIMER_WAIT bigint unsigned not null,
	MAX_TIMER_WAIT bigint unsigned not null,
	COUNT_READ bigint unsigned not null,
	SUM_TIMER_READ bigint unsigned not null,
	MIN_TIMER_READ bigint unsigned not null,
	AVG_TIMER_READ bigint unsigned not null,
	MAX_TIMER_READ bigint unsigned not null,
	COUNT_WRITE bigint unsigned not null,
	SUM_TIMER_WRITE bigint unsigned not null,
	MIN_TIMER_WRITE bigint unsigned not null,
	AVG_TIMER_WRITE bigint unsigned not null,
	MAX_TIMER_WRITE bigint unsigned not null,
	COUNT_FETCH bigint unsigned not null,
	SUM_TIMER_FETCH bigint unsigned not null,
	MIN_TIMER_FETCH bigint unsigned not null,
	AVG_TIMER_FETCH bigint unsigned not null,
	MAX_TIMER_FETCH bigint unsigned not null,
	COUNT_INSERT bigint unsigned not null,
	SUM_TIMER_INSERT bigint unsigned not null,
	MIN_TIMER_INSERT bigint unsigned not null,
	AVG_TIMER_INSERT bigint unsigned not null,
	MAX_TIMER_INSERT bigint unsigned not null,
	COUNT_UPDATE bigint unsigned not null,
	SUM_TIMER_UPDATE bigint unsigned not null,
	MIN_TIMER_UPDATE bigint unsigned not null,
	AVG_TIMER_UPDATE bigint unsigned not null,
	MAX_TIMER_UPDATE bigint unsigned not null,
	COUNT_DELETE bigint unsigned not null,
	SUM_TIMER_DELETE bigint unsigned not null,
	MIN_TIMER_DELETE bigint unsigned not null,
	AVG_TIMER_DELETE bigint unsigned not null,
	MAX_TIMER_DELETE bigint unsigned not null,
	constraint OBJECT
		unique (OBJECT_TYPE, OBJECT_SCHEMA, OBJECT_NAME) using hash
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.table_lock_waits_summary_by_table
(
	OBJECT_TYPE varchar(64) null,
	OBJECT_SCHEMA varchar(64) null,
	OBJECT_NAME varchar(64) null,
	COUNT_STAR bigint unsigned not null,
	SUM_TIMER_WAIT bigint unsigned not null,
	MIN_TIMER_WAIT bigint unsigned not null,
	AVG_TIMER_WAIT bigint unsigned not null,
	MAX_TIMER_WAIT bigint unsigned not null,
	COUNT_READ bigint unsigned not null,
	SUM_TIMER_READ bigint unsigned not null,
	MIN_TIMER_READ bigint unsigned not null,
	AVG_TIMER_READ bigint unsigned not null,
	MAX_TIMER_READ bigint unsigned not null,
	COUNT_WRITE bigint unsigned not null,
	SUM_TIMER_WRITE bigint unsigned not null,
	MIN_TIMER_WRITE bigint unsigned not null,
	AVG_TIMER_WRITE bigint unsigned not null,
	MAX_TIMER_WRITE bigint unsigned not null,
	COUNT_READ_NORMAL bigint unsigned not null,
	SUM_TIMER_READ_NORMAL bigint unsigned not null,
	MIN_TIMER_READ_NORMAL bigint unsigned not null,
	AVG_TIMER_READ_NORMAL bigint unsigned not null,
	MAX_TIMER_READ_NORMAL bigint unsigned not null,
	COUNT_READ_WITH_SHARED_LOCKS bigint unsigned not null,
	SUM_TIMER_READ_WITH_SHARED_LOCKS bigint unsigned not null,
	MIN_TIMER_READ_WITH_SHARED_LOCKS bigint unsigned not null,
	AVG_TIMER_READ_WITH_SHARED_LOCKS bigint unsigned not null,
	MAX_TIMER_READ_WITH_SHARED_LOCKS bigint unsigned not null,
	COUNT_READ_HIGH_PRIORITY bigint unsigned not null,
	SUM_TIMER_READ_HIGH_PRIORITY bigint unsigned not null,
	MIN_TIMER_READ_HIGH_PRIORITY bigint unsigned not null,
	AVG_TIMER_READ_HIGH_PRIORITY bigint unsigned not null,
	MAX_TIMER_READ_HIGH_PRIORITY bigint unsigned not null,
	COUNT_READ_NO_INSERT bigint unsigned not null,
	SUM_TIMER_READ_NO_INSERT bigint unsigned not null,
	MIN_TIMER_READ_NO_INSERT bigint unsigned not null,
	AVG_TIMER_READ_NO_INSERT bigint unsigned not null,
	MAX_TIMER_READ_NO_INSERT bigint unsigned not null,
	COUNT_READ_EXTERNAL bigint unsigned not null,
	SUM_TIMER_READ_EXTERNAL bigint unsigned not null,
	MIN_TIMER_READ_EXTERNAL bigint unsigned not null,
	AVG_TIMER_READ_EXTERNAL bigint unsigned not null,
	MAX_TIMER_READ_EXTERNAL bigint unsigned not null,
	COUNT_WRITE_ALLOW_WRITE bigint unsigned not null,
	SUM_TIMER_WRITE_ALLOW_WRITE bigint unsigned not null,
	MIN_TIMER_WRITE_ALLOW_WRITE bigint unsigned not null,
	AVG_TIMER_WRITE_ALLOW_WRITE bigint unsigned not null,
	MAX_TIMER_WRITE_ALLOW_WRITE bigint unsigned not null,
	COUNT_WRITE_CONCURRENT_INSERT bigint unsigned not null,
	SUM_TIMER_WRITE_CONCURRENT_INSERT bigint unsigned not null,
	MIN_TIMER_WRITE_CONCURRENT_INSERT bigint unsigned not null,
	AVG_TIMER_WRITE_CONCURRENT_INSERT bigint unsigned not null,
	MAX_TIMER_WRITE_CONCURRENT_INSERT bigint unsigned not null,
	COUNT_WRITE_LOW_PRIORITY bigint unsigned not null,
	SUM_TIMER_WRITE_LOW_PRIORITY bigint unsigned not null,
	MIN_TIMER_WRITE_LOW_PRIORITY bigint unsigned not null,
	AVG_TIMER_WRITE_LOW_PRIORITY bigint unsigned not null,
	MAX_TIMER_WRITE_LOW_PRIORITY bigint unsigned not null,
	COUNT_WRITE_NORMAL bigint unsigned not null,
	SUM_TIMER_WRITE_NORMAL bigint unsigned not null,
	MIN_TIMER_WRITE_NORMAL bigint unsigned not null,
	AVG_TIMER_WRITE_NORMAL bigint unsigned not null,
	MAX_TIMER_WRITE_NORMAL bigint unsigned not null,
	COUNT_WRITE_EXTERNAL bigint unsigned not null,
	SUM_TIMER_WRITE_EXTERNAL bigint unsigned not null,
	MIN_TIMER_WRITE_EXTERNAL bigint unsigned not null,
	AVG_TIMER_WRITE_EXTERNAL bigint unsigned not null,
	MAX_TIMER_WRITE_EXTERNAL bigint unsigned not null,
	constraint OBJECT
		unique (OBJECT_TYPE, OBJECT_SCHEMA, OBJECT_NAME) using hash
)
engine=PERFORMANCE_SCHEMA;

create table mysql.tables_priv
(
	Host char(255) charset ascii default '' not null,
	Db char(64) default '' not null,
	User char(32) default '' not null,
	Table_name char(64) default '' not null,
	Grantor varchar(288) default '' not null,
	Timestamp timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
	Table_priv set('Select', 'Insert', 'Update', 'Delete', 'Create', 'Drop', 'Grant', 'References', 'Index', 'Alter', 'Create View', 'Show view', 'Trigger') charset utf8mb3 default '' not null,
	Column_priv set('Select', 'Insert', 'Update', 'References') charset utf8mb3 default '' not null,
	primary key (Host, User, Db, Table_name)
)
comment 'Table privileges' collate=utf8mb3_bin;

create index Grantor
	on mysql.tables_priv (Grantor);

create table performance_schema.threads
(
	THREAD_ID bigint unsigned not null
		primary key,
	NAME varchar(128) not null,
	TYPE varchar(10) not null,
	PROCESSLIST_ID bigint unsigned null,
	PROCESSLIST_USER varchar(32) null,
	PROCESSLIST_HOST varchar(255) charset ascii null,
	PROCESSLIST_DB varchar(64) null,
	PROCESSLIST_COMMAND varchar(16) null,
	PROCESSLIST_TIME bigint null,
	PROCESSLIST_STATE varchar(64) null,
	PROCESSLIST_INFO longtext null,
	PARENT_THREAD_ID bigint unsigned null,
	ROLE varchar(64) null,
	INSTRUMENTED enum('YES', 'NO') not null,
	HISTORY enum('YES', 'NO') not null,
	CONNECTION_TYPE varchar(16) null,
	THREAD_OS_ID bigint unsigned null,
	RESOURCE_GROUP varchar(64) null,
	EXECUTION_ENGINE enum('PRIMARY', 'SECONDARY') null,
	CONTROLLED_MEMORY bigint unsigned not null,
	MAX_CONTROLLED_MEMORY bigint unsigned not null,
	TOTAL_MEMORY bigint unsigned not null,
	MAX_TOTAL_MEMORY bigint unsigned not null
)
engine=PERFORMANCE_SCHEMA;

create index NAME
	on performance_schema.threads (NAME)
	using hash;

create index PROCESSLIST_ACCOUNT
	on performance_schema.threads (PROCESSLIST_USER, PROCESSLIST_HOST)
	using hash;

create index PROCESSLIST_HOST
	on performance_schema.threads (PROCESSLIST_HOST)
	using hash;

create index PROCESSLIST_ID
	on performance_schema.threads (PROCESSLIST_ID)
	using hash;

create index RESOURCE_GROUP
	on performance_schema.threads (RESOURCE_GROUP)
	using hash;

create index THREAD_OS_ID
	on performance_schema.threads (THREAD_OS_ID)
	using hash;

create table mysql.time_zone
(
	Time_zone_id int unsigned auto_increment
		primary key,
	Use_leap_seconds enum('Y', 'N') default 'N' not null
)
comment 'Time zones' charset=utf8mb3;

create table mysql.time_zone_leap_second
(
	Transition_time bigint not null
		primary key,
	Correction int not null
)
comment 'Leap seconds information for time zones' charset=utf8mb3;

create table mysql.time_zone_name
(
	Name char(64) not null
		primary key,
	Time_zone_id int unsigned not null
)
comment 'Time zone names' charset=utf8mb3;

create table mysql.time_zone_transition
(
	Time_zone_id int unsigned not null,
	Transition_time bigint not null,
	Transition_type_id int unsigned not null,
	primary key (Time_zone_id, Transition_time)
)
comment 'Time zone transitions' charset=utf8mb3;

create table mysql.time_zone_transition_type
(
	Time_zone_id int unsigned not null,
	Transition_type_id int unsigned not null,
	Offset int default 0 not null,
	Is_DST tinyint unsigned default '0' not null,
	Abbreviation char(8) default '' not null,
	primary key (Time_zone_id, Transition_type_id)
)
comment 'Time zone transition types' charset=utf8mb3;

create table performance_schema.tls_channel_status
(
	CHANNEL varchar(128) not null,
	PROPERTY varchar(128) not null,
	VALUE varchar(2048) not null
)
engine=PERFORMANCE_SCHEMA;

create table mysql.transaction
(
	trnid int not null comment 'کد تراکنش',
	trnname text not null comment 'نام تراکنش',
	trnsystem text not null comment 'محصول',
	constraint transaction_trnid_uindex
		unique (trnid)
)
comment ' تراکنش ها';

create table mysql.user
(
	Host char(255) charset ascii default '' not null,
	User char(32) default '' not null,
	Select_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Insert_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Update_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Delete_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Create_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Drop_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Reload_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Shutdown_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Process_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	File_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Grant_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	References_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Index_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Alter_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Show_db_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Super_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Create_tmp_table_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Lock_tables_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Execute_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Repl_slave_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Repl_client_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Create_view_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Show_view_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Create_routine_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Alter_routine_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Create_user_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Event_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Trigger_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Create_tablespace_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	ssl_type enum('', 'ANY', 'X509', 'SPECIFIED') charset utf8mb3 default '' not null,
	ssl_cipher blob not null,
	x509_issuer blob not null,
	x509_subject blob not null,
	max_questions int unsigned default '0' not null,
	max_updates int unsigned default '0' not null,
	max_connections int unsigned default '0' not null,
	max_user_connections int unsigned default '0' not null,
	plugin char(64) default 'caching_sha2_password' not null,
	authentication_string text null,
	password_expired enum('N', 'Y') charset utf8mb3 default 'N' not null,
	password_last_changed timestamp null,
	password_lifetime smallint unsigned null,
	account_locked enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Create_role_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Drop_role_priv enum('N', 'Y') charset utf8mb3 default 'N' not null,
	Password_reuse_history smallint unsigned null,
	Password_reuse_time smallint unsigned null,
	Password_require_current enum('N', 'Y') charset utf8mb3 null,
	User_attributes json null,
	primary key (Host, User)
)
comment 'Users and global privileges' collate=utf8mb3_bin;

grant select on table mysql.user to 'mysql.session'@localhost;

create table performance_schema.user_defined_functions
(
	UDF_NAME varchar(64) not null
		primary key,
	UDF_RETURN_TYPE varchar(20) not null,
	UDF_TYPE varchar(20) not null,
	UDF_LIBRARY varchar(1024) null,
	UDF_USAGE_COUNT bigint null
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.user_variables_by_thread
(
	THREAD_ID bigint unsigned not null,
	VARIABLE_NAME varchar(64) not null,
	VARIABLE_VALUE longblob null,
	primary key (THREAD_ID, VARIABLE_NAME)
)
engine=PERFORMANCE_SCHEMA;

create table mysql.users
(
	usercode text not null,
	username text not null,
	password text not null
);



INSERT INTO mysql.users (usercode, username, password) VALUES ('1', 'کارمند', '1234');
INSERT INTO mysql.users (usercode, username, password) VALUES ('2', 'رئیس', '4321');


INSERT INTO mysql.cash (cashid, currencyid, balance) VALUES (1, 1, '0');
INSERT INTO mysql.cash (cashid, currencyid, balance) VALUES (2, 2, '0');

INSERT INTO mysql.currency (id, currencyname, currencyswift) VALUES (1, 'ریال', 'IRR');
INSERT INTO mysql.currency (id, currencyname, currencyswift) VALUES (2, 'دلار', 'USD');


INSERT INTO mysql.customer_type (customer_type, type_name) VALUES (0, 'حقیقی');
INSERT INTO mysql.customer_type (customer_type, type_name) VALUES (1, 'حقوقی');


INSERT INTO mysql.deposittype (`id(2)`, deptypnam) VALUES (1, 'جاری');
INSERT INTO mysql.deposittype (`id(2)`, deptypnam) VALUES (2, 'قرض الحسنه');
INSERT INTO mysql.deposittype (`id(2)`, deptypnam) VALUES (3, 'کوتاه مدت');
INSERT INTO mysql.deposittype (`id(2)`, deptypnam) VALUES (4, 'بلند مدت');
INSERT INTO mysql.deposittype (`id(2)`, deptypnam) VALUES (5, 'کوتاه مدت ویژه');



INSERT INTO mysql.loanrate (rateid, rate) VALUES (1, 20);



INSERT INTO mysql.transaction (trnid, trnname, trnsystem) VALUES (1, 'افتتاح سپرده', 'D');
INSERT INTO mysql.transaction (trnid, trnname, trnsystem) VALUES (2, 'افزایش صندوق', 'C');
INSERT INTO mysql.transaction (trnid, trnname, trnsystem) VALUES (3, 'کاهش صندوق', 'C');
INSERT INTO mysql.transaction (trnid, trnname, trnsystem) VALUES (4, 'واریز به سپرده از محل صندوق', 'D');
INSERT INTO mysql.transaction (trnid, trnname, trnsystem) VALUES (5, 'واریز به سپرده از محل صندوق', 'C');
INSERT INTO mysql.transaction (trnid, trnname, trnsystem) VALUES (6, 'انتقال وجه بین سپرده', 'D');
INSERT INTO mysql.transaction (trnid, trnname, trnsystem) VALUES (7, 'تشکیل پرونده تسهیلات', 'L');
INSERT INTO mysql.transaction (trnid, trnname, trnsystem) VALUES (8, 'دریافت قسط تسهیلات', 'L');



create table performance_schema.users
(
	USER char(32) collate utf8mb4_bin null,
	CURRENT_CONNECTIONS bigint not null,
	TOTAL_CONNECTIONS bigint not null,
	MAX_SESSION_CONTROLLED_MEMORY bigint unsigned not null,
	MAX_SESSION_TOTAL_MEMORY bigint unsigned not null,
	constraint USER
		unique (USER) using hash
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.variables_by_thread
(
	THREAD_ID bigint unsigned not null,
	VARIABLE_NAME varchar(64) not null,
	VARIABLE_VALUE varchar(1024) null,
	primary key (THREAD_ID, VARIABLE_NAME)
)
engine=PERFORMANCE_SCHEMA;

create table performance_schema.variables_info
(
	VARIABLE_NAME varchar(64) not null,
	VARIABLE_SOURCE enum('COMPILED', 'GLOBAL', 'SERVER', 'EXPLICIT', 'EXTRA', 'USER', 'LOGIN', 'COMMAND_LINE', 'PERSISTED', 'DYNAMIC') default 'COMPILED' null,
	VARIABLE_PATH varchar(1024) null,
	MIN_VALUE varchar(64) null,
	MAX_VALUE varchar(64) null,
	SET_TIME timestamp(6) null,
	SET_USER char(32) collate utf8mb4_bin null,
	SET_HOST char(255) charset ascii null
)
engine=PERFORMANCE_SCHEMA;

create view ADMINISTRABLE_ROLE_AUTHORIZATIONS as
	select `information_schema`.`applicable_roles`.`USER`         AS `USER`,
       `information_schema`.`applicable_roles`.`HOST`         AS `HOST`,
       `information_schema`.`applicable_roles`.`GRANTEE`      AS `GRANTEE`,
       `information_schema`.`applicable_roles`.`GRANTEE_HOST` AS `GRANTEE_HOST`,
       `information_schema`.`applicable_roles`.`ROLE_NAME`    AS `ROLE_NAME`,
       `information_schema`.`applicable_roles`.`ROLE_HOST`    AS `ROLE_HOST`,
       `information_schema`.`applicable_roles`.`IS_GRANTABLE` AS `IS_GRANTABLE`,
       `information_schema`.`applicable_roles`.`IS_DEFAULT`   AS `IS_DEFAULT`,
       `information_schema`.`applicable_roles`.`IS_MANDATORY` AS `IS_MANDATORY`
from `information_schema`.`APPLICABLE_ROLES`
where (`information_schema`.`applicable_roles`.`IS_GRANTABLE` = 'YES');

create view APPLICABLE_ROLES as
	with recursive `role_graph` (`c_parent_user`, `c_parent_host`, `c_from_user`, `c_from_host`, `c_to_user`, `c_to_host`,
                             `role_path`, `c_with_admin`, `c_enabled`)
                   as (select internal_get_username()                        AS `INTERNAL_GET_USERNAME()`,
                              internal_get_hostname()                        AS `INTERNAL_GET_HOSTNAME()`,
                              internal_get_username()                        AS `INTERNAL_GET_USERNAME()`,
                              internal_get_hostname()                        AS `INTERNAL_GET_HOSTNAME()`,
                              cast('' as char(64) charset utf8mb4)           AS `CAST('' as CHAR(64) CHARSET utf8mb4)`,
                              cast('' as char(255) charset utf8mb4)          AS `CAST('' as CHAR(255) CHARSET utf8mb4)`,
                              cast(sha2(concat(quote(internal_get_username()), '@', quote(internal_get_hostname())),
                                        256) as char(17000) charset utf8mb4) AS `CAST(SHA2(CONCAT(QUOTE(INTERNAL_GET_USERNAME()),'@',                        QUOTE(INTERNAL_GET_HOSTNAME())), 256)            AS CHAR(17000) CHARSET utf8mb4)`,
                              cast('N' as char(1) charset utf8mb4)           AS `CAST('N' as CHAR(1) CHARSET utf8mb4)`,
                              false                                          AS `FALSE`
                       union
                       select internal_get_username()                        AS `INTERNAL_GET_USERNAME()`,
                              internal_get_hostname()                        AS `INTERNAL_GET_HOSTNAME()`,
                              `mandatory_roles`.`ROLE_NAME`                  AS `ROLE_NAME`,
                              `mandatory_roles`.`ROLE_HOST`                  AS `ROLE_HOST`,
                              internal_get_username()                        AS `INTERNAL_GET_USERNAME()`,
                              internal_get_hostname()                        AS `INTERNAL_GET_HOSTNAME()`,
                              cast(sha2(concat(quote(`mandatory_roles`.`ROLE_NAME`), '@',
                                               convert(quote(`mandatory_roles`.`ROLE_HOST`) using utf8mb4)),
                                        256) as char(17000) charset utf8mb4) AS `CAST(SHA2(CONCAT(QUOTE(ROLE_NAME),'@',                   CONVERT(QUOTE(ROLE_HOST) using utf8mb4)), 256)              AS CHAR(17000) CHARSET utf8mb4)`,
                              cast('N' as char(1) charset utf8mb4)           AS `CAST('N' as CHAR(1) CHARSET utf8mb4)`,
                              false                                          AS `FALSE`
                       from json_table(internal_get_mandatory_roles_json(), '$[*]'
                                       columns (`ROLE_NAME` varchar(255) character set utf8mb4 path '$.ROLE_NAME', `ROLE_HOST` varchar(255) character set utf8mb4 path '$.ROLE_HOST')) `mandatory_roles`
                       where concat(quote(`mandatory_roles`.`ROLE_NAME`), '@',
                                    convert(quote(`mandatory_roles`.`ROLE_HOST`) using utf8mb4)) in
                             (select concat(convert(quote(`mysql`.`role_edges`.`FROM_USER`) using utf8mb4), '@',
                                            convert(quote(`mysql`.`role_edges`.`FROM_HOST`) using utf8mb4))
                              from `mysql`.`role_edges`
                              where ((`mysql`.`role_edges`.`TO_USER` = internal_get_username()) and
                                     (convert(`mysql`.`role_edges`.`TO_HOST` using utf8mb4) =
                                      convert(internal_get_hostname() using utf8mb4)))) is false
                       union
                       select `role_graph`.`c_parent_user`                                                       AS `c_parent_user`,
                              `role_graph`.`c_parent_host`                                                       AS `c_parent_host`,
                              `mysql`.`role_edges`.`FROM_USER`                                                   AS `FROM_USER`,
                              `mysql`.`role_edges`.`FROM_HOST`                                                   AS `FROM_HOST`,
                              `mysql`.`role_edges`.`TO_USER`                                                     AS `TO_USER`,
                              `mysql`.`role_edges`.`TO_HOST`                                                     AS `TO_HOST`,
                              if((locate(sha2(concat(convert(quote(`mysql`.`role_edges`.`FROM_USER`) using utf8mb4),
                                                     '@',
                                                     convert(quote(`mysql`.`role_edges`.`FROM_HOST`) using utf8mb4)),
                                              256), `role_graph`.`role_path`) = 0),
                                 concat(`role_graph`.`role_path`, '->', convert(sha2(concat(
                                                                                             convert(quote(`mysql`.`role_edges`.`FROM_USER`) using utf8mb4),
                                                                                             '@',
                                                                                             convert(quote(`mysql`.`role_edges`.`FROM_HOST`) using utf8mb4)),
                                                                                     256) using utf8mb4)),
                                 NULL)                                                                           AS `IF(LOCATE(SHA2(CONCAT(QUOTE(FROM_USER),'@',                      CONVERT(QUOTE(FROM_HOST) using utf8mb4)), 256),                 role_path) = 0,          CONCAT(role_path,'->', SHA2(CONCAT(QUOTE(FROM_USER),'@',           CONVERT(QUOTE(FROM_HOST) using utf8`,
                              `mysql`.`role_edges`.`WITH_ADMIN_OPTION`                                           AS `WITH_ADMIN_OPTION`,
                              if(((0 <> `role_graph`.`c_enabled`) or (0 <> internal_is_enabled_role(
                                      `mysql`.`role_edges`.`FROM_USER`, `mysql`.`role_edges`.`FROM_HOST`))), true,
                                 false)                                                                          AS `IF(c_enabled OR        INTERNAL_IS_ENABLED_ROLE(FROM_USER, FROM_HOST), TRUE, FALSE)`
                       from (`mysql`.`role_edges`
                                join `role_graph`)
                       where ((`mysql`.`role_edges`.`TO_USER` = `role_graph`.`c_from_user`) and
                              (convert(`mysql`.`role_edges`.`TO_HOST` using utf8mb4) = `role_graph`.`c_from_host`) and
                              (`role_graph`.`role_path` is not null)))
select distinct `role_graph`.`c_parent_user`                                                                        AS `USER`,
                `role_graph`.`c_parent_host`                                                                        AS `HOST`,
                `role_graph`.`c_to_user`                                                                            AS `GRANTEE`,
                `role_graph`.`c_to_host`                                                                            AS `GRANTEE_HOST`,
                `role_graph`.`c_from_user`                                                                          AS `ROLE_NAME`,
                `role_graph`.`c_from_host`                                                                          AS `ROLE_HOST`,
                if((`role_graph`.`c_with_admin` = 'N'), 'NO', 'YES')                                                AS `IS_GRANTABLE`,
                (select if(count(0), 'YES', 'NO')
                 from `mysql`.`default_roles`
                 where ((`mysql`.`default_roles`.`DEFAULT_ROLE_USER` = `role_graph`.`c_from_user`) and
                        (convert(`mysql`.`default_roles`.`DEFAULT_ROLE_HOST` using utf8mb4) =
                         `role_graph`.`c_from_host`) and
                        (`mysql`.`default_roles`.`USER` = `role_graph`.`c_parent_user`) and
                        (convert(`mysql`.`default_roles`.`HOST` using utf8mb4) =
                         `role_graph`.`c_parent_host`)))                                                            AS `IS_DEFAULT`,
                if(internal_is_mandatory_role(`role_graph`.`c_from_user`, `role_graph`.`c_from_host`), 'YES',
                   'NO')                                                                                            AS `IS_MANDATORY`
from `role_graph`
where (`role_graph`.`c_to_user` <> '');

create view CHARACTER_SETS as
	select `cs`.`name`          AS `CHARACTER_SET_NAME`,
       `col`.`name`         AS `DEFAULT_COLLATE_NAME`,
       `cs`.`comment`       AS `DESCRIPTION`,
       `cs`.`mb_max_length` AS `MAXLEN`
from (`mysql`.`character_sets` `cs`
         join `mysql`.`collations` `col` on ((`cs`.`default_collation_id` = `col`.`id`)));

create view CHECK_CONSTRAINTS as
	select (`cat`.`name` collate utf8mb3_tolower_ci) AS `CONSTRAINT_CATALOG`,
       (`sch`.`name` collate utf8mb3_tolower_ci) AS `CONSTRAINT_SCHEMA`,
       `cc`.`name`                               AS `CONSTRAINT_NAME`,
       `cc`.`check_clause_utf8`                  AS `CHECK_CLAUSE`
from (((`mysql`.`check_constraints` `cc` join `mysql`.`tables` `tbl` on ((`cc`.`table_id` = `tbl`.`id`))) join `mysql`.`schemata` `sch` on ((`tbl`.`schema_id` = `sch`.`id`)))
         join `mysql`.`catalogs` `cat` on ((`cat`.`id` = `sch`.`catalog_id`)))
where ((0 <> can_access_table(`sch`.`name`, `tbl`.`name`)) and (0 <> is_visible_dd_object(`tbl`.`hidden`)));

create view COLLATIONS as
	select `col`.`name`                                                                                AS `COLLATION_NAME`,
       `cs`.`name`                                                                                 AS `CHARACTER_SET_NAME`,
       `col`.`id`                                                                                  AS `ID`,
       if(exists(select 1
                 from `mysql`.`character_sets`
                 where (`mysql`.`character_sets`.`default_collation_id` = `col`.`id`)), 'Yes', '') AS `IS_DEFAULT`,
       if(`col`.`is_compiled`, 'Yes', '')                                                          AS `IS_COMPILED`,
       `col`.`sort_length`                                                                         AS `SORTLEN`,
       `col`.`pad_attribute`                                                                       AS `PAD_ATTRIBUTE`
from (`mysql`.`collations` `col`
         join `mysql`.`character_sets` `cs` on ((`col`.`character_set_id` = `cs`.`id`)));

create view COLLATION_CHARACTER_SET_APPLICABILITY as
	select `col`.`name` AS `COLLATION_NAME`, `cs`.`name` AS `CHARACTER_SET_NAME`
from (`mysql`.`character_sets` `cs`
         join `mysql`.`collations` `col` on ((`cs`.`id` = `col`.`character_set_id`)));

create view COLUMNS as
	select (`cat`.`name` collate utf8mb3_tolower_ci)                                                          AS `TABLE_CATALOG`,
       (`sch`.`name` collate utf8mb3_tolower_ci)                                                          AS `TABLE_SCHEMA`,
       (`tbl`.`name` collate utf8mb3_tolower_ci)                                                          AS `TABLE_NAME`,
       (`col`.`name` collate utf8mb3_tolower_ci)                                                          AS `COLUMN_NAME`,
       `col`.`ordinal_position`                                                                           AS `ORDINAL_POSITION`,
       `col`.`default_value_utf8`                                                                         AS `COLUMN_DEFAULT`,
       if((`col`.`is_nullable` = 1), 'YES', 'NO')                                                         AS `IS_NULLABLE`,
       substring_index(substring_index(`col`.`column_type_utf8`, '(', 1), ' ',
                       1)                                                                                 AS `DATA_TYPE`,
       internal_dd_char_length(`col`.`type`, `col`.`char_length`, `coll`.`name`,
                               0)                                                                         AS `CHARACTER_MAXIMUM_LENGTH`,
       internal_dd_char_length(`col`.`type`, `col`.`char_length`, `coll`.`name`,
                               1)                                                                         AS `CHARACTER_OCTET_LENGTH`,
       if((`col`.`numeric_precision` = 0), NULL, `col`.`numeric_precision`)                               AS `NUMERIC_PRECISION`,
       if(((`col`.`numeric_scale` = 0) and (`col`.`numeric_precision` = 0)), NULL,
          `col`.`numeric_scale`)                                                                          AS `NUMERIC_SCALE`,
       `col`.`datetime_precision`                                                                         AS `DATETIME_PRECISION`,
       (case `col`.`type`
            when 'MYSQL_TYPE_STRING' then if((`cs`.`name` = 'binary'), NULL, `cs`.`name`)
            when 'MYSQL_TYPE_VAR_STRING' then if((`cs`.`name` = 'binary'), NULL, `cs`.`name`)
            when 'MYSQL_TYPE_VARCHAR' then if((`cs`.`name` = 'binary'), NULL, `cs`.`name`)
            when 'MYSQL_TYPE_TINY_BLOB' then if((`cs`.`name` = 'binary'), NULL, `cs`.`name`)
            when 'MYSQL_TYPE_MEDIUM_BLOB' then if((`cs`.`name` = 'binary'), NULL, `cs`.`name`)
            when 'MYSQL_TYPE_BLOB' then if((`cs`.`name` = 'binary'), NULL, `cs`.`name`)
            when 'MYSQL_TYPE_LONG_BLOB' then if((`cs`.`name` = 'binary'), NULL, `cs`.`name`)
            when 'MYSQL_TYPE_ENUM' then if((`cs`.`name` = 'binary'), NULL, `cs`.`name`)
            when 'MYSQL_TYPE_SET' then if((`cs`.`name` = 'binary'), NULL, `cs`.`name`)
            else NULL end)                                                                                AS `CHARACTER_SET_NAME`,
       (case `col`.`type`
            when 'MYSQL_TYPE_STRING' then if((`cs`.`name` = 'binary'), NULL, `coll`.`name`)
            when 'MYSQL_TYPE_VAR_STRING' then if((`cs`.`name` = 'binary'), NULL, `coll`.`name`)
            when 'MYSQL_TYPE_VARCHAR' then if((`cs`.`name` = 'binary'), NULL, `coll`.`name`)
            when 'MYSQL_TYPE_TINY_BLOB' then if((`cs`.`name` = 'binary'), NULL, `coll`.`name`)
            when 'MYSQL_TYPE_MEDIUM_BLOB' then if((`cs`.`name` = 'binary'), NULL, `coll`.`name`)
            when 'MYSQL_TYPE_BLOB' then if((`cs`.`name` = 'binary'), NULL, `coll`.`name`)
            when 'MYSQL_TYPE_LONG_BLOB' then if((`cs`.`name` = 'binary'), NULL, `coll`.`name`)
            when 'MYSQL_TYPE_ENUM' then if((`cs`.`name` = 'binary'), NULL, `coll`.`name`)
            when 'MYSQL_TYPE_SET' then if((`cs`.`name` = 'binary'), NULL, `coll`.`name`)
            else NULL end)                                                                                AS `COLLATION_NAME`,
       `col`.`column_type_utf8`                                                                           AS `COLUMN_TYPE`,
       `col`.`column_key`                                                                                 AS `COLUMN_KEY`,
       internal_get_dd_column_extra((`col`.`generation_expression_utf8` is null), `col`.`is_virtual`,
                                    `col`.`is_auto_increment`, `col`.`update_option`,
                                    if(length(`col`.`default_option`), true, false), `col`.`options`, `col`.`hidden`,
                                    `tbl`.`type`)                                                         AS `EXTRA`,
       get_dd_column_privileges(`sch`.`name`, `tbl`.`name`, `col`.`name`)                                 AS `PRIVILEGES`,
       ifnull(`col`.`comment`, '')                                                                        AS `COLUMN_COMMENT`,
       ifnull(`col`.`generation_expression_utf8`, '')                                                     AS `GENERATION_EXPRESSION`,
       `col`.`srs_id`                                                                                     AS `SRS_ID`
from (((((`mysql`.`columns` `col` join `mysql`.`tables` `tbl` on ((`col`.`table_id` = `tbl`.`id`))) join `mysql`.`schemata` `sch` on ((`tbl`.`schema_id` = `sch`.`id`))) join `mysql`.`catalogs` `cat` on ((`cat`.`id` = `sch`.`catalog_id`))) join `mysql`.`collations` `coll` on ((`col`.`collation_id` = `coll`.`id`)))
         join `mysql`.`character_sets` `cs` on ((`coll`.`character_set_id` = `cs`.`id`)))
where ((0 <> internal_get_view_warning_or_error(`sch`.`name`, `tbl`.`name`, `tbl`.`type`, `tbl`.`options`)) and
       (0 <> can_access_column(`sch`.`name`, `tbl`.`name`, `col`.`name`)) and
       (0 <> is_visible_dd_object(`tbl`.`hidden`, (`col`.`hidden` not in ('Visible', 'User')), `col`.`options`)));

create view COLUMNS_EXTENSIONS as
	select `cat`.`name`                              AS `TABLE_CATALOG`,
       `sch`.`name`                              AS `TABLE_SCHEMA`,
       `tbl`.`name`                              AS `TABLE_NAME`,
       (`col`.`name` collate utf8mb3_tolower_ci) AS `COLUMN_NAME`,
       `col`.`engine_attribute`                  AS `ENGINE_ATTRIBUTE`,
       `col`.`secondary_engine_attribute`        AS `SECONDARY_ENGINE_ATTRIBUTE`
from (((`mysql`.`columns` `col` join `mysql`.`tables` `tbl` on ((`col`.`table_id` = `tbl`.`id`))) join `mysql`.`schemata` `sch` on ((`tbl`.`schema_id` = `sch`.`id`)))
         join `mysql`.`catalogs` `cat` on ((`cat`.`id` = `sch`.`catalog_id`)))
where ((0 <> internal_get_view_warning_or_error(`sch`.`name`, `tbl`.`name`, `tbl`.`type`, `tbl`.`options`)) and
       (0 <> can_access_column(`sch`.`name`, `tbl`.`name`, `col`.`name`)) and
       (0 <> is_visible_dd_object(`tbl`.`hidden`, (`col`.`hidden` not in ('Visible', 'User')), `col`.`options`)));

create view COLUMN_STATISTICS as
	select `mysql`.`column_statistics`.`schema_name` AS `SCHEMA_NAME`,
       `mysql`.`column_statistics`.`table_name`  AS `TABLE_NAME`,
       `mysql`.`column_statistics`.`column_name` AS `COLUMN_NAME`,
       `mysql`.`column_statistics`.`histogram`   AS `HISTOGRAM`
from `mysql`.`column_statistics`
where (0 <> can_access_table(`mysql`.`column_statistics`.`schema_name`, `mysql`.`column_statistics`.`table_name`));

create view ENABLED_ROLES as
	select `current_user_enabled_roles`.`ROLE_NAME`                                              AS `ROLE_NAME`,
       `current_user_enabled_roles`.`ROLE_HOST`                                              AS `ROLE_HOST`,
       (select if(count(0), 'YES', 'NO')
        from `mysql`.`default_roles`
        where ((`mysql`.`default_roles`.`DEFAULT_ROLE_USER` = `current_user_enabled_roles`.`ROLE_NAME`) and
               (convert(`mysql`.`default_roles`.`DEFAULT_ROLE_HOST` using utf8mb4) =
                `current_user_enabled_roles`.`ROLE_HOST`) and
               (`mysql`.`default_roles`.`USER` = internal_get_username()) and
               (convert(`mysql`.`default_roles`.`HOST` using utf8mb4) =
                convert(internal_get_hostname() using utf8mb4))))                            AS `IS_DEFAULT`,
       if(internal_is_mandatory_role(`current_user_enabled_roles`.`ROLE_NAME`,
                                     `current_user_enabled_roles`.`ROLE_HOST`), 'YES', 'NO') AS `IS_MANDATORY`
from json_table(internal_get_enabled_role_json(), '$[*]'
                columns (`ROLE_NAME` varchar(255) character set utf8mb4 path '$.ROLE_NAME', `ROLE_HOST` varchar(255) character set utf8mb4 path '$.ROLE_HOST')) `current_user_enabled_roles`;

create view EVENTS as
	select (`cat`.`name` collate utf8mb3_tolower_ci)                                         AS `EVENT_CATALOG`,
       (`sch`.`name` collate utf8mb3_tolower_ci)                                         AS `EVENT_SCHEMA`,
       `evt`.`name`                                                                      AS `EVENT_NAME`,
       `evt`.`definer`                                                                   AS `DEFINER`,
       `evt`.`time_zone`                                                                 AS `TIME_ZONE`,
       'SQL'                                                                             AS `EVENT_BODY`,
       `evt`.`definition_utf8`                                                           AS `EVENT_DEFINITION`,
       if((`evt`.`interval_value` is null), 'ONE TIME', 'RECURRING')                     AS `EVENT_TYPE`,
       convert_tz(`evt`.`execute_at`, '+00:00', `evt`.`time_zone`)                       AS `EXECUTE_AT`,
       convert_interval_to_user_interval(`evt`.`interval_value`, `evt`.`interval_field`) AS `INTERVAL_VALUE`,
       `evt`.`interval_field`                                                            AS `INTERVAL_FIELD`,
       `evt`.`sql_mode`                                                                  AS `SQL_MODE`,
       convert_tz(`evt`.`starts`, '+00:00', `evt`.`time_zone`)                           AS `STARTS`,
       convert_tz(`evt`.`ends`, '+00:00', `evt`.`time_zone`)                             AS `ENDS`,
       `evt`.`status`                                                                    AS `STATUS`,
       if((`evt`.`on_completion` = 'DROP'), 'NOT PRESERVE', 'PRESERVE')                  AS `ON_COMPLETION`,
       `evt`.`created`                                                                   AS `CREATED`,
       `evt`.`last_altered`                                                              AS `LAST_ALTERED`,
       convert_tz(`evt`.`last_executed`, '+00:00', `evt`.`time_zone`)                    AS `LAST_EXECUTED`,
       `evt`.`comment`                                                                   AS `EVENT_COMMENT`,
       `evt`.`originator`                                                                AS `ORIGINATOR`,
       `cs_client`.`name`                                                                AS `CHARACTER_SET_CLIENT`,
       `coll_conn`.`name`                                                                AS `COLLATION_CONNECTION`,
       `coll_db`.`name`                                                                  AS `DATABASE_COLLATION`
from ((((((`mysql`.`events` `evt` join `mysql`.`schemata` `sch` on ((`evt`.`schema_id` = `sch`.`id`))) join `mysql`.`catalogs` `cat` on ((`cat`.`id` = `sch`.`catalog_id`))) join `mysql`.`collations` `coll_client` on ((`coll_client`.`id` = `evt`.`client_collation_id`))) join `mysql`.`character_sets` `cs_client` on ((`cs_client`.`id` = `coll_client`.`character_set_id`))) join `mysql`.`collations` `coll_conn` on ((`coll_conn`.`id` = `evt`.`connection_collation_id`)))
         join `mysql`.`collations` `coll_db` on ((`coll_db`.`id` = `evt`.`schema_collation_id`)))
where (0 <> can_access_event(`sch`.`name`));

create view FILES as
	select internal_tablespace_id(`ts`.`name`, `tsf`.`file_name`, `ts`.`engine`, `ts`.`se_private_data`)                 AS `FILE_ID`,
       replace(if(((locate(left(`tsf`.`file_name`, 1), './') = 0) and (substr(`tsf`.`file_name`, 2, 1) <> ':')),
                  concat('./', `tsf`.`file_name`), `tsf`.`file_name`), '\\',
               '/')                                                                                                  AS `FILE_NAME`,
       internal_tablespace_type(`ts`.`name`, `tsf`.`file_name`, `ts`.`engine`,
                                `ts`.`se_private_data`)                                                              AS `FILE_TYPE`,
       `ts`.`name`                                                                                                   AS `TABLESPACE_NAME`,
       ''                                                                                                            AS `TABLE_CATALOG`,
       NULL                                                                                                          AS `TABLE_SCHEMA`,
       NULL                                                                                                          AS `TABLE_NAME`,
       internal_tablespace_logfile_group_name(`ts`.`name`, `tsf`.`file_name`, `ts`.`engine`,
                                              `ts`.`se_private_data`)                                                AS `LOGFILE_GROUP_NAME`,
       internal_tablespace_logfile_group_number(`ts`.`name`, `tsf`.`file_name`, `ts`.`engine`,
                                                `ts`.`se_private_data`)                                              AS `LOGFILE_GROUP_NUMBER`,
       `ts`.`engine`                                                                                                 AS `ENGINE`,
       NULL                                                                                                          AS `FULLTEXT_KEYS`,
       NULL                                                                                                          AS `DELETED_ROWS`,
       NULL                                                                                                          AS `UPDATE_COUNT`,
       internal_tablespace_free_extents(`ts`.`name`, `tsf`.`file_name`, `ts`.`engine`,
                                        `ts`.`se_private_data`)                                                      AS `FREE_EXTENTS`,
       internal_tablespace_total_extents(`ts`.`name`, `tsf`.`file_name`, `ts`.`engine`,
                                         `ts`.`se_private_data`)                                                     AS `TOTAL_EXTENTS`,
       internal_tablespace_extent_size(`ts`.`name`, `tsf`.`file_name`, `ts`.`engine`,
                                       `ts`.`se_private_data`)                                                       AS `EXTENT_SIZE`,
       internal_tablespace_initial_size(`ts`.`name`, `tsf`.`file_name`, `ts`.`engine`,
                                        `ts`.`se_private_data`)                                                      AS `INITIAL_SIZE`,
       internal_tablespace_maximum_size(`ts`.`name`, `tsf`.`file_name`, `ts`.`engine`,
                                        `ts`.`se_private_data`)                                                      AS `MAXIMUM_SIZE`,
       internal_tablespace_autoextend_size(`ts`.`name`, `tsf`.`file_name`, `ts`.`engine`,
                                           `ts`.`se_private_data`)                                                   AS `AUTOEXTEND_SIZE`,
       NULL                                                                                                          AS `CREATION_TIME`,
       NULL                                                                                                          AS `LAST_UPDATE_TIME`,
       NULL                                                                                                          AS `LAST_ACCESS_TIME`,
       NULL                                                                                                          AS `RECOVER_TIME`,
       NULL                                                                                                          AS `TRANSACTION_COUNTER`,
       internal_tablespace_version(`ts`.`name`, `tsf`.`file_name`, `ts`.`engine`,
                                   `ts`.`se_private_data`)                                                           AS `VERSION`,
       internal_tablespace_row_format(`ts`.`name`, `tsf`.`file_name`, `ts`.`engine`,
                                      `ts`.`se_private_data`)                                                        AS `ROW_FORMAT`,
       NULL                                                                                                          AS `TABLE_ROWS`,
       NULL                                                                                                          AS `AVG_ROW_LENGTH`,
       NULL                                                                                                          AS `DATA_LENGTH`,
       NULL                                                                                                          AS `MAX_DATA_LENGTH`,
       NULL                                                                                                          AS `INDEX_LENGTH`,
       internal_tablespace_data_free(`ts`.`name`, `tsf`.`file_name`, `ts`.`engine`,
                                     `ts`.`se_private_data`)                                                         AS `DATA_FREE`,
       NULL                                                                                                          AS `CREATE_TIME`,
       NULL                                                                                                          AS `UPDATE_TIME`,
       NULL                                                                                                          AS `CHECK_TIME`,
       NULL                                                                                                          AS `CHECKSUM`,
       internal_tablespace_status(`ts`.`name`, `tsf`.`file_name`, `ts`.`engine`,
                                  `ts`.`se_private_data`)                                                            AS `STATUS`,
       internal_tablespace_extra(`ts`.`name`, `tsf`.`file_name`, `ts`.`engine`,
                                 `ts`.`se_private_data`)                                                             AS `EXTRA`
from (`mysql`.`tablespaces` `ts`
         join `mysql`.`tablespace_files` `tsf` on ((`ts`.`id` = `tsf`.`tablespace_id`)));

create view INNODB_DATAFILES as
	select get_dd_tablespace_private_data(`ts`.`se_private_data`, 'id') AS `SPACE`, `ts_files`.`file_name` AS `PATH`
from (`mysql`.`tablespace_files` `ts_files`
         join `mysql`.`tablespaces` `ts` on ((`ts`.`id` = `ts_files`.`tablespace_id`)))
where ((`ts`.`se_private_data` is not null) and (`ts`.`engine` = 'InnoDB') and (`ts`.`name` <> 'mysql') and
       (`ts`.`name` <> 'innodb_temporary'));

create view INNODB_FIELDS as
	select get_dd_index_private_data(`idx`.`se_private_data`, 'id') AS `INDEX_ID`,
       `col`.`name`                                             AS `NAME`,
       (`fld`.`ordinal_position` - 1)                           AS `POS`
from (((`mysql`.`index_column_usage` `fld` join `mysql`.`columns` `col` on ((`fld`.`column_id` = `col`.`id`))) join `mysql`.`indexes` `idx` on ((`fld`.`index_id` = `idx`.`id`)))
         join `mysql`.`tables` `tbl` on ((`tbl`.`id` = `idx`.`table_id`)))
where ((`tbl`.`type` <> 'VIEW') and (`tbl`.`hidden` = 'Visible') and (0 = `fld`.`hidden`) and
       (`tbl`.`se_private_id` is not null) and (`tbl`.`engine` = 'INNODB'));

create view INNODB_FOREIGN as
	select (concat(`sch`.`name`, '/', `fk`.`name`) collate utf8mb3_tolower_ci)                               AS `ID`,
       concat(`sch`.`name`, '/', `tbl`.`name`)                                                           AS `FOR_NAME`,
       concat(`fk`.`referenced_table_schema`, '/', `fk`.`referenced_table_name`)                         AS `REF_NAME`,
       count(0)                                                                                          AS `N_COLS`,
       (((((if((`fk`.`delete_rule` = 'CASCADE'), 1, 0) | if((`fk`.`delete_rule` = 'SET NULL'), 2, 0)) |
           if((`fk`.`update_rule` = 'CASCADE'), 4, 0)) | if((`fk`.`update_rule` = 'SET NULL'), 8, 0)) |
         if((`fk`.`delete_rule` = 'NO ACTION'), 16, 0)) | if((`fk`.`update_rule` = 'NO ACTION'), 32, 0)) AS `TYPE`
from (((`mysql`.`foreign_keys` `fk` join `mysql`.`tables` `tbl` on ((`fk`.`table_id` = `tbl`.`id`))) join `mysql`.`schemata` `sch` on ((`fk`.`schema_id` = `sch`.`id`)))
         join `mysql`.`foreign_key_column_usage` `col` on ((`fk`.`id` = `col`.`foreign_key_id`)))
where ((`tbl`.`type` <> 'VIEW') and (`tbl`.`hidden` = 'Visible') and (`tbl`.`se_private_id` is not null) and
       (`tbl`.`engine` = 'INNODB'))
group by `fk`.`id`;

create view INNODB_FOREIGN_COLS as
	select (concat(`sch`.`name`, '/', `fk`.`name`) collate utf8mb3_tolower_ci) AS `ID`,
       `col`.`name`                                                        AS `FOR_COL_NAME`,
       `fk_col`.`referenced_column_name`                                   AS `REF_COL_NAME`,
       `fk_col`.`ordinal_position`                                         AS `POS`
from ((((`mysql`.`foreign_key_column_usage` `fk_col` join `mysql`.`foreign_keys` `fk` on ((`fk`.`id` = `fk_col`.`foreign_key_id`))) join `mysql`.`tables` `tbl` on ((`fk`.`table_id` = `tbl`.`id`))) join `mysql`.`schemata` `sch` on ((`fk`.`schema_id` = `sch`.`id`)))
         join `mysql`.`columns` `col` on (((`tbl`.`id` = `col`.`table_id`) and (`fk_col`.`column_id` = `col`.`id`))))
where ((`tbl`.`type` <> 'VIEW') and (`tbl`.`hidden` = 'Visible') and (`tbl`.`se_private_id` is not null) and
       (`tbl`.`engine` = 'INNODB'));

create view INNODB_TABLESPACES_BRIEF as
	select get_dd_tablespace_private_data(`ts`.`se_private_data`, 'id')    AS `SPACE`,
       `ts`.`name`                                                     AS `NAME`,
       `ts_files`.`file_name`                                          AS `PATH`,
       get_dd_tablespace_private_data(`ts`.`se_private_data`, 'flags') AS `FLAG`,
       if((get_dd_tablespace_private_data(`ts`.`se_private_data`, 'id') = 0), 'System',
          if((((get_dd_tablespace_private_data(`ts`.`se_private_data`, 'flags') & 2048) >> 11) <> 0), 'General',
             'Single'))                                                AS `SPACE_TYPE`
from (`mysql`.`tablespace_files` `ts_files`
         join `mysql`.`tablespaces` `ts` on ((`ts`.`id` = `ts_files`.`tablespace_id`)))
where ((`ts`.`se_private_data` is not null) and (`ts`.`engine` = 'InnoDB') and (`ts`.`name` <> 'mysql') and
       (`ts`.`name` <> 'innodb_temporary'));

create view KEYWORDS as
	select `j`.`word` AS `WORD`, `j`.`reserved` AS `RESERVED`
from json_table(
             '[["ACCESSIBLE",1],["ACCOUNT",0],["ACTION",0],["ACTIVE",0],["ADD",1],["ADMIN",0],["AFTER",0],["AGAINST",0],["AGGREGATE",0],["ALGORITHM",0],["ALL",1],["ALTER",1],["ALWAYS",0],["ANALYZE",1],["AND",1],["ANY",0],["ARRAY",0],["AS",1],["ASC",1],["ASCII",0],["ASENSITIVE",1],["ASSIGN_GTIDS_TO_ANONYMOUS_TRANSACTIONS",0],["AT",0],["ATTRIBUTE",0],["AUTHENTICATION",0],["AUTOEXTEND_SIZE",0],["AUTO_INCREMENT",0],["AVG",0],["AVG_ROW_LENGTH",0],["BACKUP",0],["BEFORE",1],["BEGIN",0],["BETWEEN",1],["BIGINT",1],["BINARY",1],["BINLOG",0],["BIT",0],["BLOB",1],["BLOCK",0],["BOOL",0],["BOOLEAN",0],["BOTH",1],["BTREE",0],["BUCKETS",0],["BY",1],["BYTE",0],["CACHE",0],["CALL",1],["CASCADE",1],["CASCADED",0],["CASE",1],["CATALOG_NAME",0],["CHAIN",0],["CHALLENGE_RESPONSE",0],["CHANGE",1],["CHANGED",0],["CHANNEL",0],["CHAR",1],["CHARACTER",1],["CHARSET",0],["CHECK",1],["CHECKSUM",0],["CIPHER",0],["CLASS_ORIGIN",0],["CLIENT",0],["CLONE",0],["CLOSE",0],["COALESCE",0],["CODE",0],["COLLATE",1],["COLLATION",0],["COLUMN",1],["COLUMNS",0],["COLUMN_FORMAT",0],["COLUMN_NAME",0],["COMMENT",0],["COMMIT",0],["COMMITTED",0],["COMPACT",0],["COMPLETION",0],["COMPONENT",0],["COMPRESSED",0],["COMPRESSION",0],["CONCURRENT",0],["CONDITION",1],["CONNECTION",0],["CONSISTENT",0],["CONSTRAINT",1],["CONSTRAINT_CATALOG",0],["CONSTRAINT_NAME",0],["CONSTRAINT_SCHEMA",0],["CONTAINS",0],["CONTEXT",0],["CONTINUE",1],["CONVERT",1],["CPU",0],["CREATE",1],["CROSS",1],["CUBE",1],["CUME_DIST",1],["CURRENT",0],["CURRENT_DATE",1],["CURRENT_TIME",1],["CURRENT_TIMESTAMP",1],["CURRENT_USER",1],["CURSOR",1],["CURSOR_NAME",0],["DATA",0],["DATABASE",1],["DATABASES",1],["DATAFILE",0],["DATE",0],["DATETIME",0],["DAY",0],["DAY_HOUR",1],["DAY_MICROSECOND",1],["DAY_MINUTE",1],["DAY_SECOND",1],["DEALLOCATE",0],["DEC",1],["DECIMAL",1],["DECLARE",1],["DEFAULT",1],["DEFAULT_AUTH",0],["DEFINER",0],["DEFINITION",0],["DELAYED",1],["DELAY_KEY_WRITE",0],["DELETE",1],["DENSE_RANK",1],["DESC",1],["DESCRIBE",1],["DESCRIPTION",0],["DETERMINISTIC",1],["DIAGNOSTICS",0],["DIRECTORY",0],["DISABLE",0],["DISCARD",0],["DISK",0],["DISTINCT",1],["DISTINCTROW",1],["DIV",1],["DO",0],["DOUBLE",1],["DROP",1],["DUAL",1],["DUMPFILE",0],["DUPLICATE",0],["DYNAMIC",0],["EACH",1],["ELSE",1],["ELSEIF",1],["EMPTY",1],["ENABLE",0],["ENCLOSED",1],["ENCRYPTION",0],["END",0],["ENDS",0],["ENFORCED",0],["ENGINE",0],["ENGINES",0],["ENGINE_ATTRIBUTE",0],["ENUM",0],["ERROR",0],["ERRORS",0],["ESCAPE",0],["ESCAPED",1],["EVENT",0],["EVENTS",0],["EVERY",0],["EXCEPT",1],["EXCHANGE",0],["EXCLUDE",0],["EXECUTE",0],["EXISTS",1],["EXIT",1],["EXPANSION",0],["EXPIRE",0],["EXPLAIN",1],["EXPORT",0],["EXTENDED",0],["EXTENT_SIZE",0],["FACTOR",0],["FAILED_LOGIN_ATTEMPTS",0],["FALSE",1],["FAST",0],["FAULTS",0],["FETCH",1],["FIELDS",0],["FILE",0],["FILE_BLOCK_SIZE",0],["FILTER",0],["FINISH",0],["FIRST",0],["FIRST_VALUE",1],["FIXED",0],["FLOAT",1],["FLOAT4",1],["FLOAT8",1],["FLUSH",0],["FOLLOWING",0],["FOLLOWS",0],["FOR",1],["FORCE",1],["FOREIGN",1],["FORMAT",0],["FOUND",0],["FROM",1],["FULL",0],["FULLTEXT",1],["FUNCTION",1],["GENERAL",0],["GENERATED",1],["GEOMCOLLECTION",0],["GEOMETRY",0],["GEOMETRYCOLLECTION",0],["GET",1],["GET_FORMAT",0],["GET_MASTER_PUBLIC_KEY",0],["GET_SOURCE_PUBLIC_KEY",0],["GLOBAL",0],["GRANT",1],["GRANTS",0],["GROUP",1],["GROUPING",1],["GROUPS",1],["GROUP_REPLICATION",0],["GTID_ONLY",0],["HANDLER",0],["HASH",0],["HAVING",1],["HELP",0],["HIGH_PRIORITY",1],["HISTOGRAM",0],["HISTORY",0],["HOST",0],["HOSTS",0],["HOUR",0],["HOUR_MICROSECOND",1],["HOUR_MINUTE",1],["HOUR_SECOND",1],["IDENTIFIED",0],["IF",1],["IGNORE",1],["IGNORE_SERVER_IDS",0],["IMPORT",0],["IN",1],["INACTIVE",0],["INDEX",1],["INDEXES",0],["INFILE",1],["INITIAL",0],["INITIAL_SIZE",0],["INITIATE",0],["INNER",1],["INOUT",1],["INSENSITIVE",1],["INSERT",1],["INSERT_METHOD",0],["INSTALL",0],["INSTANCE",0],["INT",1],["INT1",1],["INT2",1],["INT3",1],["INT4",1],["INT8",1],["INTEGER",1],["INTERSECT",1],["INTERVAL",1],["INTO",1],["INVISIBLE",0],["INVOKER",0],["IO",0],["IO_AFTER_GTIDS",1],["IO_BEFORE_GTIDS",1],["IO_THREAD",0],["IPC",0],["IS",1],["ISOLATION",0],["ISSUER",0],["ITERATE",1],["JOIN",1],["JSON",0],["JSON_TABLE",1],["JSON_VALUE",0],["KEY",1],["KEYRING",0],["KEYS",1],["KEY_BLOCK_SIZE",0],["KILL",1],["LAG",1],["LANGUAGE",0],["LAST",0],["LAST_VALUE",1],["LATERAL",1],["LEAD",1],["LEADING",1],["LEAVE",1],["LEAVES",0],["LEFT",1],["LESS",0],["LEVEL",0],["LIKE",1],["LIMIT",1],["LINEAR",1],["LINES",1],["LINESTRING",0],["LIST",0],["LOAD",1],["LOCAL",0],["LOCALTIME",1],["LOCALTIMESTAMP",1],["LOCK",1],["LOCKED",0],["LOCKS",0],["LOGFILE",0],["LOGS",0],["LONG",1],["LONGBLOB",1],["LONGTEXT",1],["LOOP",1],["LOW_PRIORITY",1],["MASTER",0],["MASTER_AUTO_POSITION",0],["MASTER_BIND",1],["MASTER_COMPRESSION_ALGORITHMS",0],["MASTER_CONNECT_RETRY",0],["MASTER_DELAY",0],["MASTER_HEARTBEAT_PERIOD",0],["MASTER_HOST",0],["MASTER_LOG_FILE",0],["MASTER_LOG_POS",0],["MASTER_PASSWORD",0],["MASTER_PORT",0],["MASTER_PUBLIC_KEY_PATH",0],["MASTER_RETRY_COUNT",0],["MASTER_SSL",0],["MASTER_SSL_CA",0],["MASTER_SSL_CAPATH",0],["MASTER_SSL_CERT",0],["MASTER_SSL_CIPHER",0],["MASTER_SSL_CRL",0],["MASTER_SSL_CRLPATH",0],["MASTER_SSL_KEY",0],["MASTER_SSL_VERIFY_SERVER_CERT",1],["MASTER_TLS_CIPHERSUITES",0],["MASTER_TLS_VERSION",0],["MASTER_USER",0],["MASTER_ZSTD_COMPRESSION_LEVEL",0],["MATCH",1],["MAXVALUE",1],["MAX_CONNECTIONS_PER_HOUR",0],["MAX_QUERIES_PER_HOUR",0],["MAX_ROWS",0],["MAX_SIZE",0],["MAX_UPDATES_PER_HOUR",0],["MAX_USER_CONNECTIONS",0],["MEDIUM",0],["MEDIUMBLOB",1],["MEDIUMINT",1],["MEDIUMTEXT",1],["MEMBER",0],["MEMORY",0],["MERGE",0],["MESSAGE_TEXT",0],["MICROSECOND",0],["MIDDLEINT",1],["MIGRATE",0],["MINUTE",0],["MINUTE_MICROSECOND",1],["MINUTE_SECOND",1],["MIN_ROWS",0],["MOD",1],["MODE",0],["MODIFIES",1],["MODIFY",0],["MONTH",0],["MULTILINESTRING",0],["MULTIPOINT",0],["MULTIPOLYGON",0],["MUTEX",0],["MYSQL_ERRNO",0],["NAME",0],["NAMES",0],["NATIONAL",0],["NATURAL",1],["NCHAR",0],["NDB",0],["NDBCLUSTER",0],["NESTED",0],["NETWORK_NAMESPACE",0],["NEVER",0],["NEW",0],["NEXT",0],["NO",0],["NODEGROUP",0],["NONE",0],["NOT",1],["NOWAIT",0],["NO_WAIT",0],["NO_WRITE_TO_BINLOG",1],["NTH_VALUE",1],["NTILE",1],["NULL",1],["NULLS",0],["NUMBER",0],["NUMERIC",1],["NVARCHAR",0],["OF",1],["OFF",0],["OFFSET",0],["OJ",0],["OLD",0],["ON",1],["ONE",0],["ONLY",0],["OPEN",0],["OPTIMIZE",1],["OPTIMIZER_COSTS",1],["OPTION",1],["OPTIONAL",0],["OPTIONALLY",1],["OPTIONS",0],["OR",1],["ORDER",1],["ORDINALITY",0],["ORGANIZATION",0],["OTHERS",0],["OUT",1],["OUTER",1],["OUTFILE",1],["OVER",1],["OWNER",0],["PACK_KEYS",0],["PAGE",0],["PARSER",0],["PARTIAL",0],["PARTITION",1],["PARTITIONING",0],["PARTITIONS",0],["PASSWORD",0],["PASSWORD_LOCK_TIME",0],["PATH",0],["PERCENT_RANK",1],["PERSIST",0],["PERSIST_ONLY",0],["PHASE",0],["PLUGIN",0],["PLUGINS",0],["PLUGIN_DIR",0],["POINT",0],["POLYGON",0],["PORT",0],["PRECEDES",0],["PRECEDING",0],["PRECISION",1],["PREPARE",0],["PRESERVE",0],["PREV",0],["PRIMARY",1],["PRIVILEGES",0],["PRIVILEGE_CHECKS_USER",0],["PROCEDURE",1],["PROCESS",0],["PROCESSLIST",0],["PROFILE",0],["PROFILES",0],["PROXY",0],["PURGE",1],["QUARTER",0],["QUERY",0],["QUICK",0],["RANDOM",0],["RANGE",1],["RANK",1],["READ",1],["READS",1],["READ_ONLY",0],["READ_WRITE",1],["REAL",1],["REBUILD",0],["RECOVER",0],["RECURSIVE",1],["REDO_BUFFER_SIZE",0],["REDUNDANT",0],["REFERENCE",0],["REFERENCES",1],["REGEXP",1],["REGISTRATION",0],["RELAY",0],["RELAYLOG",0],["RELAY_LOG_FILE",0],["RELAY_LOG_POS",0],["RELAY_THREAD",0],["RELEASE",1],["RELOAD",0],["REMOVE",0],["RENAME",1],["REORGANIZE",0],["REPAIR",0],["REPEAT",1],["REPEATABLE",0],["REPLACE",1],["REPLICA",0],["REPLICAS",0],["REPLICATE_DO_DB",0],["REPLICATE_DO_TABLE",0],["REPLICATE_IGNORE_DB",0],["REPLICATE_IGNORE_TABLE",0],["REPLICATE_REWRITE_DB",0],["REPLICATE_WILD_DO_TABLE",0],["REPLICATE_WILD_IGNORE_TABLE",0],["REPLICATION",0],["REQUIRE",1],["REQUIRE_ROW_FORMAT",0],["REQUIRE_TABLE_PRIMARY_KEY_CHECK",0],["RESET",0],["RESIGNAL",1],["RESOURCE",0],["RESPECT",0],["RESTART",0],["RESTORE",0],["RESTRICT",1],["RESUME",0],["RETAIN",0],["RETURN",1],["RETURNED_SQLSTATE",0],["RETURNING",0],["RETURNS",0],["REUSE",0],["REVERSE",0],["REVOKE",1],["RIGHT",1],["RLIKE",1],["ROLE",0],["ROLLBACK",0],["ROLLUP",0],["ROTATE",0],["ROUTINE",0],["ROW",1],["ROWS",1],["ROW_COUNT",0],["ROW_FORMAT",0],["ROW_NUMBER",1],["RTREE",0],["SAVEPOINT",0],["SCHEDULE",0],["SCHEMA",1],["SCHEMAS",1],["SCHEMA_NAME",0],["SECOND",0],["SECONDARY",0],["SECONDARY_ENGINE",0],["SECONDARY_ENGINE_ATTRIBUTE",0],["SECONDARY_LOAD",0],["SECONDARY_UNLOAD",0],["SECOND_MICROSECOND",1],["SECURITY",0],["SELECT",1],["SENSITIVE",1],["SEPARATOR",1],["SERIAL",0],["SERIALIZABLE",0],["SERVER",0],["SESSION",0],["SET",1],["SHARE",0],["SHOW",1],["SHUTDOWN",0],["SIGNAL",1],["SIGNED",0],["SIMPLE",0],["SKIP",0],["SLAVE",0],["SLOW",0],["SMALLINT",1],["SNAPSHOT",0],["SOCKET",0],["SOME",0],["SONAME",0],["SOUNDS",0],["SOURCE",0],["SOURCE_AUTO_POSITION",0],["SOURCE_BIND",0],["SOURCE_COMPRESSION_ALGORITHMS",0],["SOURCE_CONNECTION_AUTO_FAILOVER",0],["SOURCE_CONNECT_RETRY",0],["SOURCE_DELAY",0],["SOURCE_HEARTBEAT_PERIOD",0],["SOURCE_HOST",0],["SOURCE_LOG_FILE",0],["SOURCE_LOG_POS",0],["SOURCE_PASSWORD",0],["SOURCE_PORT",0],["SOURCE_PUBLIC_KEY_PATH",0],["SOURCE_RETRY_COUNT",0],["SOURCE_SSL",0],["SOURCE_SSL_CA",0],["SOURCE_SSL_CAPATH",0],["SOURCE_SSL_CERT",0],["SOURCE_SSL_CIPHER",0],["SOURCE_SSL_CRL",0],["SOURCE_SSL_CRLPATH",0],["SOURCE_SSL_KEY",0],["SOURCE_SSL_VERIFY_SERVER_CERT",0],["SOURCE_TLS_CIPHERSUITES",0],["SOURCE_TLS_VERSION",0],["SOURCE_USER",0],["SOURCE_ZSTD_COMPRESSION_LEVEL",0],["SPATIAL",1],["SPECIFIC",1],["SQL",1],["SQLEXCEPTION",1],["SQLSTATE",1],["SQLWARNING",1],["SQL_AFTER_GTIDS",0],["SQL_AFTER_MTS_GAPS",0],["SQL_BEFORE_GTIDS",0],["SQL_BIG_RESULT",1],["SQL_BUFFER_RESULT",0],["SQL_CALC_FOUND_ROWS",1],["SQL_NO_CACHE",0],["SQL_SMALL_RESULT",1],["SQL_THREAD",0],["SQL_TSI_DAY",0],["SQL_TSI_HOUR",0],["SQL_TSI_MINUTE",0],["SQL_TSI_MONTH",0],["SQL_TSI_QUARTER",0],["SQL_TSI_SECOND",0],["SQL_TSI_WEEK",0],["SQL_TSI_YEAR",0],["SRID",0],["SSL",1],["STACKED",0],["START",0],["STARTING",1],["STARTS",0],["STATS_AUTO_RECALC",0],["STATS_PERSISTENT",0],["STATS_SAMPLE_PAGES",0],["STATUS",0],["STOP",0],["STORAGE",0],["STORED",1],["STRAIGHT_JOIN",1],["STREAM",0],["STRING",0],["SUBCLASS_ORIGIN",0],["SUBJECT",0],["SUBPARTITION",0],["SUBPARTITIONS",0],["SUPER",0],["SUSPEND",0],["SWAPS",0],["SWITCHES",0],["SYSTEM",1],["TABLE",1],["TABLES",0],["TABLESPACE",0],["TABLE_CHECKSUM",0],["TABLE_NAME",0],["TEMPORARY",0],["TEMPTABLE",0],["TERMINATED",1],["TEXT",0],["THAN",0],["THEN",1],["THREAD_PRIORITY",0],["TIES",0],["TIME",0],["TIMESTAMP",0],["TIMESTAMPADD",0],["TIMESTAMPDIFF",0],["TINYBLOB",1],["TINYINT",1],["TINYTEXT",1],["TLS",0],["TO",1],["TRAILING",1],["TRANSACTION",0],["TRIGGER",1],["TRIGGERS",0],["TRUE",1],["TRUNCATE",0],["TYPE",0],["TYPES",0],["UNBOUNDED",0],["UNCOMMITTED",0],["UNDEFINED",0],["UNDO",1],["UNDOFILE",0],["UNDO_BUFFER_SIZE",0],["UNICODE",0],["UNINSTALL",0],["UNION",1],["UNIQUE",1],["UNKNOWN",0],["UNLOCK",1],["UNREGISTER",0],["UNSIGNED",1],["UNTIL",0],["UPDATE",1],["UPGRADE",0],["USAGE",1],["USE",1],["USER",0],["USER_RESOURCES",0],["USE_FRM",0],["USING",1],["UTC_DATE",1],["UTC_TIME",1],["UTC_TIMESTAMP",1],["VALIDATION",0],["VALUE",0],["VALUES",1],["VARBINARY",1],["VARCHAR",1],["VARCHARACTER",1],["VARIABLES",0],["VARYING",1],["VCPU",0],["VIEW",0],["VIRTUAL",1],["VISIBLE",0],["WAIT",0],["WARNINGS",0],["WEEK",0],["WEIGHT_STRING",0],["WHEN",1],["WHERE",1],["WHILE",1],["WINDOW",1],["WITH",1],["WITHOUT",0],["WORK",0],["WRAPPER",0],["WRITE",1],["X509",0],["XA",0],["XID",0],["XML",0],["XOR",1],["YEAR",0],["YEAR_MONTH",1],["ZEROFILL",1],["ZONE",0]]',
             '$[*]' columns (`word` varchar(128) character set utf8mb4 path '$[0]', `reserved` int path '$[1]')) `j`;

create view KEY_COLUMN_USAGE as
	select (`cat`.`name` collate utf8mb3_tolower_ci)     AS `CONSTRAINT_CATALOG`,
       (`sch`.`name` collate utf8mb3_tolower_ci)     AS `CONSTRAINT_SCHEMA`,
       `constraints`.`CONSTRAINT_NAME`               AS `CONSTRAINT_NAME`,
       (`cat`.`name` collate utf8mb3_tolower_ci)     AS `TABLE_CATALOG`,
       (`sch`.`name` collate utf8mb3_tolower_ci)     AS `TABLE_SCHEMA`,
       (`tbl`.`name` collate utf8mb3_tolower_ci)     AS `TABLE_NAME`,
       (`col`.`name` collate utf8mb3_tolower_ci)     AS `COLUMN_NAME`,
       `constraints`.`ORDINAL_POSITION`              AS `ORDINAL_POSITION`,
       `constraints`.`POSITION_IN_UNIQUE_CONSTRAINT` AS `POSITION_IN_UNIQUE_CONSTRAINT`,
       `constraints`.`REFERENCED_TABLE_SCHEMA`       AS `REFERENCED_TABLE_SCHEMA`,
       `constraints`.`REFERENCED_TABLE_NAME`         AS `REFERENCED_TABLE_NAME`,
       `constraints`.`REFERENCED_COLUMN_NAME`        AS `REFERENCED_COLUMN_NAME`
from (((`mysql`.`tables` `tbl` join `mysql`.`schemata` `sch` on ((`tbl`.`schema_id` = `sch`.`id`))) join `mysql`.`catalogs` `cat` on ((`cat`.`id` = `sch`.`catalog_id`)))
         join (lateral (select `idx`.`name`                                     AS `CONSTRAINT_NAME`,
                               `icu`.`ordinal_position`                         AS `ORDINAL_POSITION`,
                               NULL                                             AS `POSITION_IN_UNIQUE_CONSTRAINT`,
                               NULL                                             AS `REFERENCED_TABLE_SCHEMA`,
                               NULL                                             AS `REFERENCED_TABLE_NAME`,
                               NULL                                             AS `REFERENCED_COLUMN_NAME`,
                               `icu`.`column_id`                                AS `column_id`,
                               ((0 <> `idx`.`hidden`) or (0 <> `icu`.`hidden`)) AS `HIDDEN`
                        from (`mysql`.`indexes` `idx`
                                 join `mysql`.`index_column_usage` `icu` on ((`icu`.`index_id` = `idx`.`id`)))
                        where ((`idx`.`table_id` = `tbl`.`id`) and (`idx`.`type` in ('PRIMARY', 'UNIQUE')))
                        union all
                        select (`fk`.`name` collate utf8mb3_tolower_ci) AS `CONSTRAINT_NAME`,
                               `fkcu`.`ordinal_position`                AS `ORDINAL_POSITION`,
                               `fkcu`.`ordinal_position`                AS `POSITION_IN_UNIQUE_CONSTRAINT`,
                               `fk`.`referenced_table_schema`           AS `REFERENCED_TABLE_SCHEMA`,
                               `fk`.`referenced_table_name`             AS `REFERENCED_TABLE_NAME`,
                               `fkcu`.`referenced_column_name`          AS `REFERENCED_COLUMN_NAME`,
                               `fkcu`.`column_id`                       AS `column_id`,
                               false                                    AS `HIDDEN`
                        from (`mysql`.`foreign_keys` `fk`
                                 join `mysql`.`foreign_key_column_usage` `fkcu`
                                      on ((`fkcu`.`foreign_key_id` = `fk`.`id`)))
                        where (`fk`.`table_id` = `tbl`.`id`)) `constraints` join `mysql`.`columns` `col` on ((`constraints`.`column_id` = `col`.`id`))))
where ((0 <> can_access_column(`sch`.`name`, `tbl`.`name`, `col`.`name`)) and (0 <> is_visible_dd_object(`tbl`.`hidden`,
                                                                                                         ((`col`.`hidden` not in ('Visible', 'User')) or
                                                                                                          (0 <> `constraints`.`HIDDEN`)),
                                                                                                         `col`.`options`)));

create view PARAMETERS as
	select (`cat`.`name` collate utf8mb3_tolower_ci)                                                 AS `SPECIFIC_CATALOG`,
       (`sch`.`name` collate utf8mb3_tolower_ci)                                                 AS `SPECIFIC_SCHEMA`,
       `rtn`.`name`                                                                              AS `SPECIFIC_NAME`,
       if((`rtn`.`type` = 'FUNCTION'), (`prm`.`ordinal_position` - 1), `prm`.`ordinal_position`) AS `ORDINAL_POSITION`,
       if(((`rtn`.`type` = 'FUNCTION') and (`prm`.`ordinal_position` = 1)), NULL, `prm`.`mode`)  AS `PARAMETER_MODE`,
       if(((`rtn`.`type` = 'FUNCTION') and (`prm`.`ordinal_position` = 1)), NULL, `prm`.`name`)  AS `PARAMETER_NAME`,
       substring_index(substring_index(`prm`.`data_type_utf8`, '(', 1), ' ', 1)                  AS `DATA_TYPE`,
       internal_dd_char_length(`prm`.`data_type`, `prm`.`char_length`, `col`.`name`,
                               0)                                                                AS `CHARACTER_MAXIMUM_LENGTH`,
       internal_dd_char_length(`prm`.`data_type`, `prm`.`char_length`, `col`.`name`,
                               1)                                                                AS `CHARACTER_OCTET_LENGTH`,
       `prm`.`numeric_precision`                                                                 AS `NUMERIC_PRECISION`,
       if((`prm`.`numeric_precision` is null), NULL, ifnull(`prm`.`numeric_scale`, 0))           AS `NUMERIC_SCALE`,
       `prm`.`datetime_precision`                                                                AS `DATETIME_PRECISION`,
       (case `prm`.`data_type`
            when 'MYSQL_TYPE_STRING' then if((`cs`.`name` = 'binary'), NULL, `cs`.`name`)
            when 'MYSQL_TYPE_VAR_STRING' then if((`cs`.`name` = 'binary'), NULL, `cs`.`name`)
            when 'MYSQL_TYPE_VARCHAR' then if((`cs`.`name` = 'binary'), NULL, `cs`.`name`)
            when 'MYSQL_TYPE_TINY_BLOB' then if((`cs`.`name` = 'binary'), NULL, `cs`.`name`)
            when 'MYSQL_TYPE_MEDIUM_BLOB' then if((`cs`.`name` = 'binary'), NULL, `cs`.`name`)
            when 'MYSQL_TYPE_BLOB' then if((`cs`.`name` = 'binary'), NULL, `cs`.`name`)
            when 'MYSQL_TYPE_LONG_BLOB' then if((`cs`.`name` = 'binary'), NULL, `cs`.`name`)
            when 'MYSQL_TYPE_ENUM' then if((`cs`.`name` = 'binary'), NULL, `cs`.`name`)
            when 'MYSQL_TYPE_SET' then if((`cs`.`name` = 'binary'), NULL, `cs`.`name`)
            else NULL end)                                                                       AS `CHARACTER_SET_NAME`,
       (case `prm`.`data_type`
            when 'MYSQL_TYPE_STRING' then if((`cs`.`name` = 'binary'), NULL, `col`.`name`)
            when 'MYSQL_TYPE_VAR_STRING' then if((`cs`.`name` = 'binary'), NULL, `col`.`name`)
            when 'MYSQL_TYPE_VARCHAR' then if((`cs`.`name` = 'binary'), NULL, `col`.`name`)
            when 'MYSQL_TYPE_TINY_BLOB' then if((`cs`.`name` = 'binary'), NULL, `col`.`name`)
            when 'MYSQL_TYPE_MEDIUM_BLOB' then if((`cs`.`name` = 'binary'), NULL, `col`.`name`)
            when 'MYSQL_TYPE_BLOB' then if((`cs`.`name` = 'binary'), NULL, `col`.`name`)
            when 'MYSQL_TYPE_LONG_BLOB' then if((`cs`.`name` = 'binary'), NULL, `col`.`name`)
            when 'MYSQL_TYPE_ENUM' then if((`cs`.`name` = 'binary'), NULL, `col`.`name`)
            when 'MYSQL_TYPE_SET' then if((`cs`.`name` = 'binary'), NULL, `col`.`name`)
            else NULL end)                                                                       AS `COLLATION_NAME`,
       `prm`.`data_type_utf8`                                                                    AS `DTD_IDENTIFIER`,
       `rtn`.`type`                                                                              AS `ROUTINE_TYPE`
from (((((`mysql`.`parameters` `prm` join `mysql`.`routines` `rtn` on ((`prm`.`routine_id` = `rtn`.`id`))) join `mysql`.`schemata` `sch` on ((`rtn`.`schema_id` = `sch`.`id`))) join `mysql`.`catalogs` `cat` on ((`cat`.`id` = `sch`.`catalog_id`))) join `mysql`.`collations` `col` on ((`prm`.`collation_id` = `col`.`id`)))
         join `mysql`.`character_sets` `cs` on ((`col`.`character_set_id` = `cs`.`id`)))
where (0 <> can_access_routine(`sch`.`name`, `rtn`.`name`, `rtn`.`type`, `rtn`.`definer`, false));

create view PARTITIONS as
	select (`cat`.`name` collate utf8mb3_tolower_ci)                                                                     AS `TABLE_CATALOG`,
       (`sch`.`name` collate utf8mb3_tolower_ci)                                                                     AS `TABLE_SCHEMA`,
       `tbl`.`name`                                                                                                  AS `TABLE_NAME`,
       `part`.`name`                                                                                                 AS `PARTITION_NAME`,
       `sub_part`.`name`                                                                                             AS `SUBPARTITION_NAME`,
       (`part`.`number` + 1)                                                                                         AS `PARTITION_ORDINAL_POSITION`,
       (`sub_part`.`number` + 1)                                                                                     AS `SUBPARTITION_ORDINAL_POSITION`,
       (case `tbl`.`partition_type`
            when 'HASH' then 'HASH'
            when 'RANGE' then 'RANGE'
            when 'LIST' then 'LIST'
            when 'AUTO' then 'AUTO'
            when 'KEY_51' then 'KEY'
            when 'KEY_55' then 'KEY'
            when 'LINEAR_KEY_51' then 'LINEAR KEY'
            when 'LINEAR_KEY_55' then 'LINEAR KEY'
            when 'LINEAR_HASH' then 'LINEAR HASH'
            when 'RANGE_COLUMNS' then 'RANGE COLUMNS'
            when 'LIST_COLUMNS' then 'LIST COLUMNS'
            else NULL end)                                                                                           AS `PARTITION_METHOD`,
       (case `tbl`.`subpartition_type`
            when 'HASH' then 'HASH'
            when 'RANGE' then 'RANGE'
            when 'LIST' then 'LIST'
            when 'AUTO' then 'AUTO'
            when 'KEY_51' then 'KEY'
            when 'KEY_55' then 'KEY'
            when 'LINEAR_KEY_51' then 'LINEAR KEY'
            when 'LINEAR_KEY_55' then 'LINEAR KEY'
            when 'LINEAR_HASH' then 'LINEAR HASH'
            when 'RANGE_COLUMNS' then 'RANGE COLUMNS'
            when 'LIST_COLUMNS' then 'LIST COLUMNS'
            else NULL end)                                                                                           AS `SUBPARTITION_METHOD`,
       `tbl`.`partition_expression_utf8`                                                                             AS `PARTITION_EXPRESSION`,
       `tbl`.`subpartition_expression_utf8`                                                                          AS `SUBPARTITION_EXPRESSION`,
       `part`.`description_utf8`                                                                                     AS `PARTITION_DESCRIPTION`,
       internal_table_rows(`sch`.`name`, `tbl`.`name`, if((`tbl`.`partition_type` is null), `tbl`.`engine`, ''),
                           `tbl`.`se_private_id`, (`tbl`.`hidden` <> 'Visible'), if((`sub_part`.`name` is null),
                                                                                    if((`part`.`name` is null),
                                                                                       `tbl`.`se_private_data`,
                                                                                       `part_ts`.`se_private_data`),
                                                                                    `sub_part_ts`.`se_private_data`), 0,
                           0,
                           ifnull(`sub_part`.`name`, `part`.`name`))                                                 AS `TABLE_ROWS`,
       internal_avg_row_length(`sch`.`name`, `tbl`.`name`, if((`tbl`.`partition_type` is null), `tbl`.`engine`, ''),
                               `tbl`.`se_private_id`, (`tbl`.`hidden` <> 'Visible'), if((`sub_part`.`name` is null),
                                                                                        if((`part`.`name` is null),
                                                                                           `tbl`.`se_private_data`,
                                                                                           `part_ts`.`se_private_data`),
                                                                                        `sub_part_ts`.`se_private_data`),
                               0, 0,
                               ifnull(`sub_part`.`name`, `part`.`name`))                                             AS `AVG_ROW_LENGTH`,
       internal_data_length(`sch`.`name`, `tbl`.`name`, if((`tbl`.`partition_type` is null), `tbl`.`engine`, ''),
                            `tbl`.`se_private_id`, (`tbl`.`hidden` <> 'Visible'), if((`sub_part`.`name` is null),
                                                                                     if((`part`.`name` is null),
                                                                                        `tbl`.`se_private_data`,
                                                                                        `part_ts`.`se_private_data`),
                                                                                     `sub_part_ts`.`se_private_data`),
                            0, 0,
                            ifnull(`sub_part`.`name`, `part`.`name`))                                                AS `DATA_LENGTH`,
       internal_max_data_length(`sch`.`name`, `tbl`.`name`, if((`tbl`.`partition_type` is null), `tbl`.`engine`, ''),
                                `tbl`.`se_private_id`, (`tbl`.`hidden` <> 'Visible'), if((`sub_part`.`name` is null),
                                                                                         if((`part`.`name` is null),
                                                                                            `tbl`.`se_private_data`,
                                                                                            `part_ts`.`se_private_data`),
                                                                                         `sub_part_ts`.`se_private_data`),
                                0, 0,
                                ifnull(`sub_part`.`name`, `part`.`name`))                                            AS `MAX_DATA_LENGTH`,
       internal_index_length(`sch`.`name`, `tbl`.`name`, if((`tbl`.`partition_type` is null), `tbl`.`engine`, ''),
                             `tbl`.`se_private_id`, (`tbl`.`hidden` <> 'Visible'), if((`sub_part`.`name` is null),
                                                                                      if((`part`.`name` is null),
                                                                                         `tbl`.`se_private_data`,
                                                                                         `part_ts`.`se_private_data`),
                                                                                      `sub_part_ts`.`se_private_data`),
                             0, 0,
                             ifnull(`sub_part`.`name`, `part`.`name`))                                               AS `INDEX_LENGTH`,
       internal_data_free(`sch`.`name`, `tbl`.`name`, if((`tbl`.`partition_type` is null), `tbl`.`engine`, ''),
                          `tbl`.`se_private_id`, (`tbl`.`hidden` <> 'Visible'), if((`sub_part`.`name` is null),
                                                                                   if((`part`.`name` is null),
                                                                                      `tbl`.`se_private_data`,
                                                                                      `part_ts`.`se_private_data`),
                                                                                   `sub_part_ts`.`se_private_data`), 0,
                          0,
                          ifnull(`sub_part`.`name`, `part`.`name`))                                                  AS `DATA_FREE`,
       `tbl`.`created`                                                                                               AS `CREATE_TIME`,
       internal_update_time(`sch`.`name`, `tbl`.`name`, if((`tbl`.`partition_type` is null), `tbl`.`engine`, ''),
                            `tbl`.`se_private_id`, (`tbl`.`hidden` <> 'Visible'), if((`sub_part`.`name` is null),
                                                                                     if((`part`.`name` is null),
                                                                                        `tbl`.`se_private_data`,
                                                                                        `part_ts`.`se_private_data`),
                                                                                     `sub_part_ts`.`se_private_data`),
                            0, 0,
                            ifnull(`sub_part`.`name`, `part`.`name`))                                                AS `UPDATE_TIME`,
       internal_check_time(`sch`.`name`, `tbl`.`name`, if((`tbl`.`partition_type` is null), `tbl`.`engine`, ''),
                           `tbl`.`se_private_id`, (`tbl`.`hidden` <> 'Visible'), if((`sub_part`.`name` is null),
                                                                                    if((`part`.`name` is null),
                                                                                       `tbl`.`se_private_data`,
                                                                                       `part_ts`.`se_private_data`),
                                                                                    `sub_part_ts`.`se_private_data`), 0,
                           0,
                           ifnull(`sub_part`.`name`, `part`.`name`))                                                 AS `CHECK_TIME`,
       internal_checksum(`sch`.`name`, `tbl`.`name`, if((`tbl`.`partition_type` is null), `tbl`.`engine`, ''),
                         `tbl`.`se_private_id`, (`tbl`.`hidden` <> 'Visible'), if((`sub_part`.`name` is null),
                                                                                  if((`part`.`name` is null),
                                                                                     `tbl`.`se_private_data`,
                                                                                     `part_ts`.`se_private_data`),
                                                                                  `sub_part_ts`.`se_private_data`), 0,
                         0,
                         ifnull(`sub_part`.`name`, `part`.`name`))                                                   AS `CHECKSUM`,
       if((`sub_part`.`name` is null), ifnull(`part`.`comment`, ''),
          ifnull(`sub_part`.`comment`, ''))                                                                          AS `PARTITION_COMMENT`,
       if((`part`.`name` is null), '', internal_get_partition_nodegroup(
               if((`sub_part`.`name` is null), `part`.`options`,
                  `sub_part`.`options`)))                                                                            AS `NODEGROUP`,
       ifnull(`sub_part_ts`.`name`, `part_ts`.`name`)                                                                AS `TABLESPACE_NAME`
from ((((((`mysql`.`tables` `tbl` join `mysql`.`schemata` `sch` on ((`sch`.`id` = `tbl`.`schema_id`))) join `mysql`.`catalogs` `cat` on ((`cat`.`id` = `sch`.`catalog_id`))) left join `mysql`.`table_partitions` `part` on ((`part`.`table_id` = `tbl`.`id`))) left join `mysql`.`table_partitions` `sub_part` on ((`sub_part`.`parent_partition_id` = `part`.`id`))) left join `mysql`.`tablespaces` `part_ts` on ((`part_ts`.`id` = `part`.`tablespace_id`)))
         left join `mysql`.`tablespaces` `sub_part_ts`
                   on (((`sub_part`.`tablespace_id` is not null) and (`sub_part_ts`.`id` = `sub_part`.`tablespace_id`))))
where ((0 <> can_access_table(`sch`.`name`, `tbl`.`name`)) and (0 <> is_visible_dd_object(`tbl`.`hidden`)) and
       (`part`.`parent_partition_id` is null));

create view REFERENTIAL_CONSTRAINTS as
	select `cat`.`name`                             AS `CONSTRAINT_CATALOG`,
       `sch`.`name`                             AS `CONSTRAINT_SCHEMA`,
       (`fk`.`name` collate utf8mb3_tolower_ci) AS `CONSTRAINT_NAME`,
       `fk`.`referenced_table_catalog`          AS `UNIQUE_CONSTRAINT_CATALOG`,
       `fk`.`referenced_table_schema`           AS `UNIQUE_CONSTRAINT_SCHEMA`,
       `fk`.`unique_constraint_name`            AS `UNIQUE_CONSTRAINT_NAME`,
       `fk`.`match_option`                      AS `MATCH_OPTION`,
       `fk`.`update_rule`                       AS `UPDATE_RULE`,
       `fk`.`delete_rule`                       AS `DELETE_RULE`,
       `tbl`.`name`                             AS `TABLE_NAME`,
       `fk`.`referenced_table_name`             AS `REFERENCED_TABLE_NAME`
from (((`mysql`.`foreign_keys` `fk` join `mysql`.`tables` `tbl` on ((`fk`.`table_id` = `tbl`.`id`))) join `mysql`.`schemata` `sch` on ((`fk`.`schema_id` = `sch`.`id`)))
         join `mysql`.`catalogs` `cat` on ((`cat`.`id` = `sch`.`catalog_id`)))
where ((0 <> can_access_table(`sch`.`name`, `tbl`.`name`)) and (0 <> is_visible_dd_object(`tbl`.`hidden`)));

create view RESOURCE_GROUPS as
	select `res`.`resource_group_name`              AS `RESOURCE_GROUP_NAME`,
       `res`.`resource_group_type`              AS `RESOURCE_GROUP_TYPE`,
       `res`.`resource_group_enabled`           AS `RESOURCE_GROUP_ENABLED`,
       convert_cpu_id_mask(`res`.`cpu_id_mask`) AS `VCPU_IDS`,
       `res`.`thread_priority`                  AS `THREAD_PRIORITY`
from `mysql`.`resource_groups` `res`
where (0 <> can_access_resource_group(`res`.`resource_group_name`));

create view ROLE_ROUTINE_GRANTS as
	with recursive `role_graph` (`c_parent_user`, `c_parent_host`, `c_from_user`, `c_from_host`, `c_to_user`, `c_to_host`,
                             `role_path`, `c_with_admin`, `c_enabled`)
                   as (select internal_get_username()                        AS `INTERNAL_GET_USERNAME()`,
                              internal_get_hostname()                        AS `INTERNAL_GET_HOSTNAME()`,
                              internal_get_username()                        AS `INTERNAL_GET_USERNAME()`,
                              internal_get_hostname()                        AS `INTERNAL_GET_HOSTNAME()`,
                              cast('' as char(64) charset utf8mb4)           AS `CAST('' as CHAR(64) CHARSET utf8mb4)`,
                              cast('' as char(255) charset utf8mb4)          AS `CAST('' as CHAR(255) CHARSET utf8mb4)`,
                              cast(sha2(concat(quote(internal_get_username()), '@', quote(internal_get_hostname())),
                                        256) as char(17000) charset utf8mb4) AS `CAST(SHA2(CONCAT(QUOTE(INTERNAL_GET_USERNAME()),'@',                        QUOTE(INTERNAL_GET_HOSTNAME())), 256)            AS CHAR(17000) CHARSET utf8mb4)`,
                              cast('N' as char(1) charset utf8mb4)           AS `CAST('N' as CHAR(1) CHARSET utf8mb4)`,
                              false                                          AS `FALSE`
                       union
                       select internal_get_username()                        AS `INTERNAL_GET_USERNAME()`,
                              internal_get_hostname()                        AS `INTERNAL_GET_HOSTNAME()`,
                              `mandatory_roles`.`ROLE_NAME`                  AS `ROLE_NAME`,
                              `mandatory_roles`.`ROLE_HOST`                  AS `ROLE_HOST`,
                              internal_get_username()                        AS `INTERNAL_GET_USERNAME()`,
                              internal_get_hostname()                        AS `INTERNAL_GET_HOSTNAME()`,
                              cast(sha2(concat(quote(`mandatory_roles`.`ROLE_NAME`), '@',
                                               convert(quote(`mandatory_roles`.`ROLE_HOST`) using utf8mb4)),
                                        256) as char(17000) charset utf8mb4) AS `CAST(SHA2(CONCAT(QUOTE(ROLE_NAME),'@',                   CONVERT(QUOTE(ROLE_HOST) using utf8mb4)), 256)              AS CHAR(17000) CHARSET utf8mb4)`,
                              cast('N' as char(1) charset utf8mb4)           AS `CAST('N' as CHAR(1) CHARSET utf8mb4)`,
                              false                                          AS `FALSE`
                       from json_table(internal_get_mandatory_roles_json(), '$[*]'
                                       columns (`ROLE_NAME` varchar(255) character set utf8mb4 path '$.ROLE_NAME', `ROLE_HOST` varchar(255) character set utf8mb4 path '$.ROLE_HOST')) `mandatory_roles`
                       where concat(quote(`mandatory_roles`.`ROLE_NAME`), '@',
                                    convert(quote(`mandatory_roles`.`ROLE_HOST`) using utf8mb4)) in
                             (select concat(convert(quote(`mysql`.`role_edges`.`FROM_USER`) using utf8mb4), '@',
                                            convert(quote(`mysql`.`role_edges`.`FROM_HOST`) using utf8mb4))
                              from `mysql`.`role_edges`
                              where ((`mysql`.`role_edges`.`TO_USER` = internal_get_username()) and
                                     (convert(`mysql`.`role_edges`.`TO_HOST` using utf8mb4) =
                                      convert(internal_get_hostname() using utf8mb4)))) is false
                       union
                       select `role_graph`.`c_parent_user`                                                       AS `c_parent_user`,
                              `role_graph`.`c_parent_host`                                                       AS `c_parent_host`,
                              `mysql`.`role_edges`.`FROM_USER`                                                   AS `FROM_USER`,
                              `mysql`.`role_edges`.`FROM_HOST`                                                   AS `FROM_HOST`,
                              `mysql`.`role_edges`.`TO_USER`                                                     AS `TO_USER`,
                              `mysql`.`role_edges`.`TO_HOST`                                                     AS `TO_HOST`,
                              if((locate(sha2(concat(convert(quote(`mysql`.`role_edges`.`FROM_USER`) using utf8mb4),
                                                     '@',
                                                     convert(quote(`mysql`.`role_edges`.`FROM_HOST`) using utf8mb4)),
                                              256), `role_graph`.`role_path`) = 0),
                                 concat(`role_graph`.`role_path`, '->', convert(sha2(concat(
                                                                                             convert(quote(`mysql`.`role_edges`.`FROM_USER`) using utf8mb4),
                                                                                             '@',
                                                                                             convert(quote(`mysql`.`role_edges`.`FROM_HOST`) using utf8mb4)),
                                                                                     256) using utf8mb4)),
                                 NULL)                                                                           AS `IF(LOCATE(SHA2(CONCAT(QUOTE(FROM_USER),'@',                      CONVERT(QUOTE(FROM_HOST) using utf8mb4)), 256),                 role_path) = 0,          CONCAT(role_path,'->', SHA2(CONCAT(QUOTE(FROM_USER),'@',           CONVERT(QUOTE(FROM_HOST) using utf8`,
                              `mysql`.`role_edges`.`WITH_ADMIN_OPTION`                                           AS `WITH_ADMIN_OPTION`,
                              if(((0 <> `role_graph`.`c_enabled`) or (0 <> internal_is_enabled_role(
                                      `mysql`.`role_edges`.`FROM_USER`, `mysql`.`role_edges`.`FROM_HOST`))), true,
                                 false)                                                                          AS `IF(c_enabled OR        INTERNAL_IS_ENABLED_ROLE(FROM_USER, FROM_HOST), TRUE, FALSE)`
                       from (`mysql`.`role_edges`
                                join `role_graph`)
                       where ((`mysql`.`role_edges`.`TO_USER` = `role_graph`.`c_from_user`) and
                              (convert(`mysql`.`role_edges`.`TO_HOST` using utf8mb4) = `role_graph`.`c_from_host`) and
                              (`role_graph`.`role_path` is not null)))
select distinct internal_get_username(`pp`.`Grantor`)                         AS `GRANTOR`,
                internal_get_hostname(`pp`.`Grantor`)                         AS `GRANTOR_HOST`,
                `pp`.`User`                                                   AS `GRANTEE`,
                `pp`.`Host`                                                   AS `GRANTEE_HOST`,
                'def'                                                         AS `SPECIFIC_CATALOG`,
                `pp`.`Db`                                                     AS `SPECIFIC_SCHEMA`,
                `pp`.`Routine_name`                                           AS `SPECIFIC_NAME`,
                'def'                                                         AS `ROUTINE_CATALOG`,
                `pp`.`Db`                                                     AS `ROUTINE_SCHEMA`,
                `pp`.`Routine_name`                                           AS `ROUTINE_NAME`,
                `pp`.`Proc_priv`                                              AS `PRIVILEGE_TYPE`,
                if((find_in_set('Grant', `pp`.`Proc_priv`) > 0), 'YES', 'NO') AS `IS_GRANTABLE`
from (`mysql`.`procs_priv` `pp`
         join `role_graph` `rg`
              on (((`pp`.`User` = `rg`.`c_from_user`) and (convert(`pp`.`Host` using utf8mb4) = `rg`.`c_from_host`))))
where ((`pp`.`Proc_priv` > 0) and (`rg`.`c_to_user` <> '') and (`rg`.`c_enabled` = true));

create view ROLE_TABLE_GRANTS as
	with recursive `role_graph` (`c_parent_user`, `c_parent_host`, `c_from_user`, `c_from_host`, `c_to_user`, `c_to_host`,
                             `role_path`, `c_with_admin`, `c_enabled`)
                   as (select internal_get_username()                        AS `INTERNAL_GET_USERNAME()`,
                              internal_get_hostname()                        AS `INTERNAL_GET_HOSTNAME()`,
                              internal_get_username()                        AS `INTERNAL_GET_USERNAME()`,
                              internal_get_hostname()                        AS `INTERNAL_GET_HOSTNAME()`,
                              cast('' as char(64) charset utf8mb4)           AS `CAST('' as CHAR(64) CHARSET utf8mb4)`,
                              cast('' as char(255) charset utf8mb4)          AS `CAST('' as CHAR(255) CHARSET utf8mb4)`,
                              cast(sha2(concat(quote(internal_get_username()), '@', quote(internal_get_hostname())),
                                        256) as char(17000) charset utf8mb4) AS `CAST(SHA2(CONCAT(QUOTE(INTERNAL_GET_USERNAME()),'@',                        QUOTE(INTERNAL_GET_HOSTNAME())), 256)            AS CHAR(17000) CHARSET utf8mb4)`,
                              cast('N' as char(1) charset utf8mb4)           AS `CAST('N' as CHAR(1) CHARSET utf8mb4)`,
                              false                                          AS `FALSE`
                       union
                       select internal_get_username()                        AS `INTERNAL_GET_USERNAME()`,
                              internal_get_hostname()                        AS `INTERNAL_GET_HOSTNAME()`,
                              `mandatory_roles`.`ROLE_NAME`                  AS `ROLE_NAME`,
                              `mandatory_roles`.`ROLE_HOST`                  AS `ROLE_HOST`,
                              internal_get_username()                        AS `INTERNAL_GET_USERNAME()`,
                              internal_get_hostname()                        AS `INTERNAL_GET_HOSTNAME()`,
                              cast(sha2(concat(quote(`mandatory_roles`.`ROLE_NAME`), '@',
                                               convert(quote(`mandatory_roles`.`ROLE_HOST`) using utf8mb4)),
                                        256) as char(17000) charset utf8mb4) AS `CAST(SHA2(CONCAT(QUOTE(ROLE_NAME),'@',                   CONVERT(QUOTE(ROLE_HOST) using utf8mb4)), 256)              AS CHAR(17000) CHARSET utf8mb4)`,
                              cast('N' as char(1) charset utf8mb4)           AS `CAST('N' as CHAR(1) CHARSET utf8mb4)`,
                              false                                          AS `FALSE`
                       from json_table(internal_get_mandatory_roles_json(), '$[*]'
                                       columns (`ROLE_NAME` varchar(255) character set utf8mb4 path '$.ROLE_NAME', `ROLE_HOST` varchar(255) character set utf8mb4 path '$.ROLE_HOST')) `mandatory_roles`
                       where concat(quote(`mandatory_roles`.`ROLE_NAME`), '@',
                                    convert(quote(`mandatory_roles`.`ROLE_HOST`) using utf8mb4)) in
                             (select concat(convert(quote(`mysql`.`role_edges`.`FROM_USER`) using utf8mb4), '@',
                                            convert(quote(`mysql`.`role_edges`.`FROM_HOST`) using utf8mb4))
                              from `mysql`.`role_edges`
                              where ((`mysql`.`role_edges`.`TO_USER` = internal_get_username()) and
                                     (convert(`mysql`.`role_edges`.`TO_HOST` using utf8mb4) =
                                      convert(internal_get_hostname() using utf8mb4)))) is false
                       union
                       select `role_graph`.`c_parent_user`                                                       AS `c_parent_user`,
                              `role_graph`.`c_parent_host`                                                       AS `c_parent_host`,
                              `mysql`.`role_edges`.`FROM_USER`                                                   AS `FROM_USER`,
                              `mysql`.`role_edges`.`FROM_HOST`                                                   AS `FROM_HOST`,
                              `mysql`.`role_edges`.`TO_USER`                                                     AS `TO_USER`,
                              `mysql`.`role_edges`.`TO_HOST`                                                     AS `TO_HOST`,
                              if((locate(sha2(concat(convert(quote(`mysql`.`role_edges`.`FROM_USER`) using utf8mb4),
                                                     '@',
                                                     convert(quote(`mysql`.`role_edges`.`FROM_HOST`) using utf8mb4)),
                                              256), `role_graph`.`role_path`) = 0),
                                 concat(`role_graph`.`role_path`, '->', convert(sha2(concat(
                                                                                             convert(quote(`mysql`.`role_edges`.`FROM_USER`) using utf8mb4),
                                                                                             '@',
                                                                                             convert(quote(`mysql`.`role_edges`.`FROM_HOST`) using utf8mb4)),
                                                                                     256) using utf8mb4)),
                                 NULL)                                                                           AS `IF(LOCATE(SHA2(CONCAT(QUOTE(FROM_USER),'@',                      CONVERT(QUOTE(FROM_HOST) using utf8mb4)), 256),                 role_path) = 0,          CONCAT(role_path,'->', SHA2(CONCAT(QUOTE(FROM_USER),'@',           CONVERT(QUOTE(FROM_HOST) using utf8`,
                              `mysql`.`role_edges`.`WITH_ADMIN_OPTION`                                           AS `WITH_ADMIN_OPTION`,
                              if(((0 <> `role_graph`.`c_enabled`) or (0 <> internal_is_enabled_role(
                                      `mysql`.`role_edges`.`FROM_USER`, `mysql`.`role_edges`.`FROM_HOST`))), true,
                                 false)                                                                          AS `IF(c_enabled OR        INTERNAL_IS_ENABLED_ROLE(FROM_USER, FROM_HOST), TRUE, FALSE)`
                       from (`mysql`.`role_edges`
                                join `role_graph`)
                       where ((`mysql`.`role_edges`.`TO_USER` = `role_graph`.`c_from_user`) and
                              (convert(`mysql`.`role_edges`.`TO_HOST` using utf8mb4) = `role_graph`.`c_from_host`) and
                              (`role_graph`.`role_path` is not null)))
select distinct internal_get_username(`tp`.`Grantor`)                          AS `GRANTOR`,
                internal_get_hostname(`tp`.`Grantor`)                          AS `GRANTOR_HOST`,
                `tp`.`User`                                                    AS `GRANTEE`,
                `tp`.`Host`                                                    AS `GRANTEE_HOST`,
                'def'                                                          AS `TABLE_CATALOG`,
                `tp`.`Db`                                                      AS `TABLE_SCHEMA`,
                `tp`.`Table_name`                                              AS `TABLE_NAME`,
                `tp`.`Table_priv`                                              AS `PRIVILEGE_TYPE`,
                if((find_in_set('Grant', `tp`.`Table_priv`) > 0), 'YES', 'NO') AS `IS_GRANTABLE`
from (`mysql`.`tables_priv` `tp`
         join `role_graph` `rg`
              on (((`tp`.`User` = `rg`.`c_from_user`) and (convert(`tp`.`Host` using utf8mb4) = `rg`.`c_from_host`))))
where ((`tp`.`Table_priv` > 0) and (`rg`.`c_to_user` <> '') and (`rg`.`c_enabled` = true));

create view ROUTINES as
	select `rtn`.`name`                                                                                           AS `SPECIFIC_NAME`,
       (`cat`.`name` collate utf8mb3_tolower_ci)                                                              AS `ROUTINE_CATALOG`,
       (`sch`.`name` collate utf8mb3_tolower_ci)                                                              AS `ROUTINE_SCHEMA`,
       `rtn`.`name`                                                                                           AS `ROUTINE_NAME`,
       `rtn`.`type`                                                                                           AS `ROUTINE_TYPE`,
       if((`rtn`.`type` = 'PROCEDURE'), '', substring_index(substring_index(`rtn`.`result_data_type_utf8`, '(', 1), ' ',
                                                            1))                                               AS `DATA_TYPE`,
       internal_dd_char_length(`rtn`.`result_data_type`, `rtn`.`result_char_length`, `coll_result`.`name`,
                               0)                                                                             AS `CHARACTER_MAXIMUM_LENGTH`,
       internal_dd_char_length(`rtn`.`result_data_type`, `rtn`.`result_char_length`, `coll_result`.`name`,
                               1)                                                                             AS `CHARACTER_OCTET_LENGTH`,
       `rtn`.`result_numeric_precision`                                                                       AS `NUMERIC_PRECISION`,
       `rtn`.`result_numeric_scale`                                                                           AS `NUMERIC_SCALE`,
       `rtn`.`result_datetime_precision`                                                                      AS `DATETIME_PRECISION`,
       (case `rtn`.`result_data_type`
            when 'MYSQL_TYPE_STRING' then if((`cs_result`.`name` = 'binary'), NULL, `cs_result`.`name`)
            when 'MYSQL_TYPE_VAR_STRING' then if((`cs_result`.`name` = 'binary'), NULL, `cs_result`.`name`)
            when 'MYSQL_TYPE_VARCHAR' then if((`cs_result`.`name` = 'binary'), NULL, `cs_result`.`name`)
            when 'MYSQL_TYPE_TINY_BLOB' then if((`cs_result`.`name` = 'binary'), NULL, `cs_result`.`name`)
            when 'MYSQL_TYPE_MEDIUM_BLOB' then if((`cs_result`.`name` = 'binary'), NULL, `cs_result`.`name`)
            when 'MYSQL_TYPE_BLOB' then if((`cs_result`.`name` = 'binary'), NULL, `cs_result`.`name`)
            when 'MYSQL_TYPE_LONG_BLOB' then if((`cs_result`.`name` = 'binary'), NULL, `cs_result`.`name`)
            when 'MYSQL_TYPE_ENUM' then if((`cs_result`.`name` = 'binary'), NULL, `cs_result`.`name`)
            when 'MYSQL_TYPE_SET' then if((`cs_result`.`name` = 'binary'), NULL, `cs_result`.`name`)
            else NULL end)                                                                                    AS `CHARACTER_SET_NAME`,
       (case `rtn`.`result_data_type`
            when 'MYSQL_TYPE_STRING' then if((`cs_result`.`name` = 'binary'), NULL, `coll_result`.`name`)
            when 'MYSQL_TYPE_VAR_STRING' then if((`cs_result`.`name` = 'binary'), NULL, `coll_result`.`name`)
            when 'MYSQL_TYPE_VARCHAR' then if((`cs_result`.`name` = 'binary'), NULL, `coll_result`.`name`)
            when 'MYSQL_TYPE_TINY_BLOB' then if((`cs_result`.`name` = 'binary'), NULL, `coll_result`.`name`)
            when 'MYSQL_TYPE_MEDIUM_BLOB' then if((`cs_result`.`name` = 'binary'), NULL, `coll_result`.`name`)
            when 'MYSQL_TYPE_BLOB' then if((`cs_result`.`name` = 'binary'), NULL, `coll_result`.`name`)
            when 'MYSQL_TYPE_LONG_BLOB' then if((`cs_result`.`name` = 'binary'), NULL, `coll_result`.`name`)
            when 'MYSQL_TYPE_ENUM' then if((`cs_result`.`name` = 'binary'), NULL, `coll_result`.`name`)
            when 'MYSQL_TYPE_SET' then if((`cs_result`.`name` = 'binary'), NULL, `coll_result`.`name`)
            else NULL end)                                                                                    AS `COLLATION_NAME`,
       if((`rtn`.`type` = 'PROCEDURE'), NULL,
          `rtn`.`result_data_type_utf8`)                                                                      AS `DTD_IDENTIFIER`,
       'SQL'                                                                                                  AS `ROUTINE_BODY`,
       if(can_access_routine(`sch`.`name`, `rtn`.`name`, `rtn`.`type`, `rtn`.`definer`, true), `rtn`.`definition_utf8`,
          NULL)                                                                                               AS `ROUTINE_DEFINITION`,
       NULL                                                                                                   AS `EXTERNAL_NAME`,
       `rtn`.`external_language`                                                                              AS `EXTERNAL_LANGUAGE`,
       'SQL'                                                                                                  AS `PARAMETER_STYLE`,
       if((`rtn`.`is_deterministic` = 0), 'NO', 'YES')                                                        AS `IS_DETERMINISTIC`,
       `rtn`.`sql_data_access`                                                                                AS `SQL_DATA_ACCESS`,
       NULL                                                                                                   AS `SQL_PATH`,
       `rtn`.`security_type`                                                                                  AS `SECURITY_TYPE`,
       `rtn`.`created`                                                                                        AS `CREATED`,
       `rtn`.`last_altered`                                                                                   AS `LAST_ALTERED`,
       `rtn`.`sql_mode`                                                                                       AS `SQL_MODE`,
       `rtn`.`comment`                                                                                        AS `ROUTINE_COMMENT`,
       `rtn`.`definer`                                                                                        AS `DEFINER`,
       `cs_client`.`name`                                                                                     AS `CHARACTER_SET_CLIENT`,
       `coll_conn`.`name`                                                                                     AS `COLLATION_CONNECTION`,
       `coll_db`.`name`                                                                                       AS `DATABASE_COLLATION`
from ((((((((`mysql`.`routines` `rtn` join `mysql`.`schemata` `sch` on ((`rtn`.`schema_id` = `sch`.`id`))) join `mysql`.`catalogs` `cat` on ((`cat`.`id` = `sch`.`catalog_id`))) join `mysql`.`collations` `coll_client` on ((`coll_client`.`id` = `rtn`.`client_collation_id`))) join `mysql`.`character_sets` `cs_client` on ((`cs_client`.`id` = `coll_client`.`character_set_id`))) join `mysql`.`collations` `coll_conn` on ((`coll_conn`.`id` = `rtn`.`connection_collation_id`))) join `mysql`.`collations` `coll_db` on ((`coll_db`.`id` = `rtn`.`schema_collation_id`))) left join `mysql`.`collations` `coll_result` on ((`coll_result`.`id` = `rtn`.`result_collation_id`)))
         left join `mysql`.`character_sets` `cs_result` on ((`cs_result`.`id` = `coll_result`.`character_set_id`)))
where (0 <> can_access_routine(`sch`.`name`, `rtn`.`name`, `rtn`.`type`, `rtn`.`definer`, false));

create view SCHEMATA as
	select (`cat`.`name` collate utf8mb3_tolower_ci) AS `CATALOG_NAME`,
       (`sch`.`name` collate utf8mb3_tolower_ci) AS `SCHEMA_NAME`,
       `cs`.`name`                               AS `DEFAULT_CHARACTER_SET_NAME`,
       `col`.`name`                              AS `DEFAULT_COLLATION_NAME`,
       NULL                                      AS `SQL_PATH`,
       `sch`.`default_encryption`                AS `DEFAULT_ENCRYPTION`
from (((`mysql`.`schemata` `sch` join `mysql`.`catalogs` `cat` on ((`cat`.`id` = `sch`.`catalog_id`))) join `mysql`.`collations` `col` on ((`sch`.`default_collation_id` = `col`.`id`)))
         join `mysql`.`character_sets` `cs` on ((`col`.`character_set_id` = `cs`.`id`)))
where (0 <> can_access_database(`sch`.`name`));

create view SCHEMATA_EXTENSIONS as
	select (`cat`.`name` collate utf8mb3_tolower_ci) AS `CATALOG_NAME`,
       (`sch`.`name` collate utf8mb3_tolower_ci) AS `SCHEMA_NAME`,
       get_dd_schema_options(`sch`.`options`)    AS `OPTIONS`
from (`mysql`.`schemata` `sch`
         join `mysql`.`catalogs` `cat` on ((`cat`.`id` = `sch`.`catalog_id`)))
where (0 <> can_access_database(`sch`.`name`));

create view STATISTICS as
	select (`cat`.`name` collate utf8mb3_tolower_ci)                                                         AS `TABLE_CATALOG`,
       (`sch`.`name` collate utf8mb3_tolower_ci)                                                         AS `TABLE_SCHEMA`,
       (`tbl`.`name` collate utf8mb3_tolower_ci)                                                         AS `TABLE_NAME`,
       if(((`idx`.`type` = 'PRIMARY') or (`idx`.`type` = 'UNIQUE')), 0, 1)                               AS `NON_UNIQUE`,
       (`sch`.`name` collate utf8mb3_tolower_ci)                                                         AS `INDEX_SCHEMA`,
       (`idx`.`name` collate utf8mb3_tolower_ci)                                                         AS `INDEX_NAME`,
       `icu`.`ordinal_position`                                                                          AS `SEQ_IN_INDEX`,
       if((`col`.`hidden` = 'SQL'), NULL,
          (`col`.`name` collate utf8mb3_tolower_ci))                                                     AS `COLUMN_NAME`,
       (case when (`icu`.`order` = 'DESC') then 'D' when (`icu`.`order` = 'ASC') then 'A' else NULL end) AS `COLLATION`,
       internal_index_column_cardinality(`sch`.`name`, `tbl`.`name`, `idx`.`name`, `col`.`name`,
                                         `idx`.`ordinal_position`, `icu`.`ordinal_position`,
                                         if((`tbl`.`partition_type` is null), `tbl`.`engine`, ''),
                                         `tbl`.`se_private_id`,
                                         ((`tbl`.`hidden` <> 'Visible') or (0 <> `idx`.`hidden`) or
                                          (0 <> `icu`.`hidden`)),
                                         coalesce(`stat`.`cardinality`, cast(-(1) as unsigned)),
                                         coalesce(cast(`stat`.`cached_time` as unsigned), 0))            AS `CARDINALITY`,
       get_dd_index_sub_part_length(`icu`.`length`, `col`.`type`, `col`.`char_length`, `col`.`collation_id`,
                                    `idx`.`type`)                                                        AS `SUB_PART`,
       NULL                                                                                              AS `PACKED`,
       if((`col`.`is_nullable` = 1), 'YES', '')                                                          AS `NULLABLE`,
       (case
            when (`idx`.`type` = 'SPATIAL') then 'SPATIAL'
            when (`idx`.`algorithm` = 'SE_PRIVATE') then ''
            else `idx`.`algorithm` end)                                                                  AS `INDEX_TYPE`,
       if(((`idx`.`type` = 'PRIMARY') or (`idx`.`type` = 'UNIQUE')), '',
          if(internal_keys_disabled(`tbl`.`options`), 'disabled', ''))                                   AS `COMMENT`,
       `idx`.`comment`                                                                                   AS `INDEX_COMMENT`,
       if(`idx`.`is_visible`, 'YES', 'NO')                                                               AS `IS_VISIBLE`,
       if((`col`.`hidden` = 'SQL'), `col`.`generation_expression_utf8`, NULL)                            AS `EXPRESSION`
from (((((((`mysql`.`index_column_usage` `icu` join `mysql`.`indexes` `idx` on ((`idx`.`id` = `icu`.`index_id`))) join `mysql`.`tables` `tbl` on ((`idx`.`table_id` = `tbl`.`id`))) join `mysql`.`columns` `col` on ((`icu`.`column_id` = `col`.`id`))) join `mysql`.`schemata` `sch` on ((`tbl`.`schema_id` = `sch`.`id`))) join `mysql`.`catalogs` `cat` on ((`cat`.`id` = `sch`.`catalog_id`))) join `mysql`.`collations` `coll` on ((`tbl`.`collation_id` = `coll`.`id`)))
         left join `mysql`.`index_stats` `stat`
                   on (((`tbl`.`name` = `stat`.`table_name`) and (`sch`.`name` = `stat`.`schema_name`) and
                        (`idx`.`name` = `stat`.`index_name`) and (`col`.`name` = `stat`.`column_name`))))
where ((0 <> can_access_table(`sch`.`name`, `tbl`.`name`)) and
       (0 <> is_visible_dd_object(`tbl`.`hidden`, ((0 <> `idx`.`hidden`) or (0 <> `icu`.`hidden`)), `idx`.`options`)));

create view ST_GEOMETRY_COLUMNS as
	select `information_schema`.`cols`.`TABLE_CATALOG` AS `TABLE_CATALOG`,
       `information_schema`.`cols`.`TABLE_SCHEMA`  AS `TABLE_SCHEMA`,
       `information_schema`.`cols`.`TABLE_NAME`    AS `TABLE_NAME`,
       `information_schema`.`cols`.`COLUMN_NAME`   AS `COLUMN_NAME`,
       `information_schema`.`srs`.`SRS_NAME`       AS `SRS_NAME`,
       `information_schema`.`cols`.`SRS_ID`        AS `SRS_ID`,
       `information_schema`.`cols`.`DATA_TYPE`     AS `GEOMETRY_TYPE_NAME`
from (`information_schema`.`COLUMNS` `cols`
         left join `information_schema`.`ST_SPATIAL_REFERENCE_SYSTEMS` `srs`
                   on ((`information_schema`.`cols`.`SRS_ID` = `information_schema`.`srs`.`SRS_ID`)))
where (`information_schema`.`cols`.`DATA_TYPE` in
       ('geometry', 'point', 'linestring', 'polygon', 'multipoint', 'multilinestring', 'multipolygon',
        'geomcollection'));

create view ST_SPATIAL_REFERENCE_SYSTEMS as
	select `mysql`.`st_spatial_reference_systems`.`name`                     AS `SRS_NAME`,
       `mysql`.`st_spatial_reference_systems`.`id`                       AS `SRS_ID`,
       `mysql`.`st_spatial_reference_systems`.`organization`             AS `ORGANIZATION`,
       `mysql`.`st_spatial_reference_systems`.`organization_coordsys_id` AS `ORGANIZATION_COORDSYS_ID`,
       `mysql`.`st_spatial_reference_systems`.`definition`               AS `DEFINITION`,
       `mysql`.`st_spatial_reference_systems`.`description`              AS `DESCRIPTION`
from `mysql`.`st_spatial_reference_systems`;

create view ST_UNITS_OF_MEASURE as
	select `st_units_of_measure`.`UNIT_NAME`         AS `UNIT_NAME`,
       `st_units_of_measure`.`UNIT_TYPE`         AS `UNIT_TYPE`,
       `st_units_of_measure`.`CONVERSION_FACTOR` AS `CONVERSION_FACTOR`,
       `st_units_of_measure`.`DESCRIPTION`       AS `DESCRIPTION`
from json_table(
             '[["metre","LINEAR","",1],["millimetre","LINEAR","",0.001],["centimetre","LINEAR","",0.01],["German legal metre","LINEAR","",1.0000135965],["foot","LINEAR","",0.3048],["US survey foot","LINEAR","",0.30480060960121924],["Clarke\'s yard","LINEAR","",0.9143917962],["Clarke\'s foot","LINEAR","",0.3047972654],["British link (Sears 1922 truncated)","LINEAR","",0.20116756],["nautical mile","LINEAR","",1852],["fathom","LINEAR","",1.8288],["US survey chain","LINEAR","",20.11684023368047],["US survey link","LINEAR","",0.2011684023368047],["US survey mile","LINEAR","",1609.3472186944375],["Indian yard","LINEAR","",0.9143985307444408],["kilometre","LINEAR","",1000],["Clarke\'s chain","LINEAR","",20.1166195164],["Clarke\'s link","LINEAR","",0.201166195164],["British yard (Benoit 1895 A)","LINEAR","",0.9143992],["British yard (Sears 1922)","LINEAR","",0.9143984146160287],["British foot (Sears 1922)","LINEAR","",0.3047994715386762],["Gold Coast foot","LINEAR","",0.3047997101815088],["British chain (Sears 1922)","LINEAR","",20.116765121552632],["yard","LINEAR","",0.9144],["British link (Sears 1922)","LINEAR","",0.2011676512155263],["British foot (Benoit 1895 A)","LINEAR","",0.3047997333333333],["Indian foot (1962)","LINEAR","",0.3047996],["British chain (Benoit 1895 A)","LINEAR","",20.1167824],["chain","LINEAR","",20.1168],["British link (Benoit 1895 A)","LINEAR","",0.201167824],["British yard (Benoit 1895 B)","LINEAR","",0.9143992042898124],["British foot (Benoit 1895 B)","LINEAR","",0.30479973476327077],["British chain (Benoit 1895 B)","LINEAR","",20.116782494375872],["British link (Benoit 1895 B)","LINEAR","",0.2011678249437587],["British foot (1865)","LINEAR","",0.30480083333333335],["Indian foot","LINEAR","",0.30479951024814694],["Indian foot (1937)","LINEAR","",0.30479841],["Indian foot (1975)","LINEAR","",0.3047995],["British foot (1936)","LINEAR","",0.3048007491],["Indian yard (1937)","LINEAR","",0.91439523],["Indian yard (1962)","LINEAR","",0.9143988],["Indian yard (1975)","LINEAR","",0.9143985],["Statute mile","LINEAR","",1609.344],["link","LINEAR","",0.201168],["British yard (Sears 1922 truncated)","LINEAR","",0.914398],["British foot (Sears 1922 truncated)","LINEAR","",0.30479933333333337],["British chain (Sears 1922 truncated)","LINEAR","",20.116756]]',
             '$[*]'
             columns (`UNIT_NAME` varchar(255) character set utf8mb4 path '$[0]', `UNIT_TYPE` varchar(7) character set utf8mb4 path '$[1]', `DESCRIPTION` varchar(255) character set utf8mb4 path '$[2]', `CONVERSION_FACTOR` double path '$[3]')) `st_units_of_measure`;

create view TABLES as
	select (`cat`.`name` collate utf8mb3_tolower_ci)                                                                      AS `TABLE_CATALOG`,
       (`sch`.`name` collate utf8mb3_tolower_ci)                                                                      AS `TABLE_SCHEMA`,
       (`tbl`.`name` collate utf8mb3_tolower_ci)                                                                      AS `TABLE_NAME`,
       `tbl`.`type`                                                                                                   AS `TABLE_TYPE`,
       if((`tbl`.`type` = 'BASE TABLE'), `tbl`.`engine`, NULL)                                                        AS `ENGINE`,
       if((`tbl`.`type` = 'VIEW'), NULL, 10)                                                                          AS `VERSION`,
       `tbl`.`row_format`                                                                                             AS `ROW_FORMAT`,
       if((`tbl`.`type` = 'VIEW'), NULL,
          internal_table_rows(`sch`.`name`, `tbl`.`name`, if((`tbl`.`partition_type` is null), `tbl`.`engine`, ''),
                              `tbl`.`se_private_id`, (`tbl`.`hidden` <> 'Visible'), `ts`.`se_private_data`,
                              coalesce(`stat`.`table_rows`, 0),
                              coalesce(cast(`stat`.`cached_time` as unsigned), 0)))                                   AS `TABLE_ROWS`,
       if((`tbl`.`type` = 'VIEW'), NULL,
          internal_avg_row_length(`sch`.`name`, `tbl`.`name`, if((`tbl`.`partition_type` is null), `tbl`.`engine`, ''),
                                  `tbl`.`se_private_id`, (`tbl`.`hidden` <> 'Visible'), `ts`.`se_private_data`,
                                  coalesce(`stat`.`avg_row_length`, 0),
                                  coalesce(cast(`stat`.`cached_time` as unsigned), 0)))                               AS `AVG_ROW_LENGTH`,
       if((`tbl`.`type` = 'VIEW'), NULL,
          internal_data_length(`sch`.`name`, `tbl`.`name`, if((`tbl`.`partition_type` is null), `tbl`.`engine`, ''),
                               `tbl`.`se_private_id`, (`tbl`.`hidden` <> 'Visible'), `ts`.`se_private_data`,
                               coalesce(`stat`.`data_length`, 0),
                               coalesce(cast(`stat`.`cached_time` as unsigned), 0)))                                  AS `DATA_LENGTH`,
       if((`tbl`.`type` = 'VIEW'), NULL,
          internal_max_data_length(`sch`.`name`, `tbl`.`name`, if((`tbl`.`partition_type` is null), `tbl`.`engine`, ''),
                                   `tbl`.`se_private_id`, (`tbl`.`hidden` <> 'Visible'), `ts`.`se_private_data`,
                                   coalesce(`stat`.`max_data_length`, 0),
                                   coalesce(cast(`stat`.`cached_time` as unsigned), 0)))                              AS `MAX_DATA_LENGTH`,
       if((`tbl`.`type` = 'VIEW'), NULL,
          internal_index_length(`sch`.`name`, `tbl`.`name`, if((`tbl`.`partition_type` is null), `tbl`.`engine`, ''),
                                `tbl`.`se_private_id`, (`tbl`.`hidden` <> 'Visible'), `ts`.`se_private_data`,
                                coalesce(`stat`.`index_length`, 0),
                                coalesce(cast(`stat`.`cached_time` as unsigned), 0)))                                 AS `INDEX_LENGTH`,
       if((`tbl`.`type` = 'VIEW'), NULL,
          internal_data_free(`sch`.`name`, `tbl`.`name`, if((`tbl`.`partition_type` is null), `tbl`.`engine`, ''),
                             `tbl`.`se_private_id`, (`tbl`.`hidden` <> 'Visible'), `ts`.`se_private_data`,
                             coalesce(`stat`.`data_free`, 0),
                             coalesce(cast(`stat`.`cached_time` as unsigned), 0)))                                    AS `DATA_FREE`,
       if((`tbl`.`type` = 'VIEW'), NULL,
          internal_auto_increment(`sch`.`name`, `tbl`.`name`, if((`tbl`.`partition_type` is null), `tbl`.`engine`, ''),
                                  `tbl`.`se_private_id`,
                                  ((0 <> is_visible_dd_object(`tbl`.`hidden`, false, `tbl`.`options`)) is false),
                                  `ts`.`se_private_data`, coalesce(`stat`.`auto_increment`, 0),
                                  coalesce(cast(`stat`.`cached_time` as unsigned), 0),
                                  `tbl`.`se_private_data`))                                                           AS `AUTO_INCREMENT`,
       `tbl`.`created`                                                                                                AS `CREATE_TIME`,
       if((`tbl`.`type` = 'VIEW'), NULL,
          internal_update_time(`sch`.`name`, `tbl`.`name`, if((`tbl`.`partition_type` is null), `tbl`.`engine`, ''),
                               `tbl`.`se_private_id`, (`tbl`.`hidden` <> 'Visible'), `ts`.`se_private_data`,
                               coalesce(cast(`stat`.`update_time` as unsigned), 0),
                               coalesce(cast(`stat`.`cached_time` as unsigned), 0)))                                  AS `UPDATE_TIME`,
       if((`tbl`.`type` = 'VIEW'), NULL,
          internal_check_time(`sch`.`name`, `tbl`.`name`, if((`tbl`.`partition_type` is null), `tbl`.`engine`, ''),
                              `tbl`.`se_private_id`, (`tbl`.`hidden` <> 'Visible'), `ts`.`se_private_data`,
                              coalesce(cast(`stat`.`check_time` as unsigned), 0),
                              coalesce(cast(`stat`.`cached_time` as unsigned), 0)))                                   AS `CHECK_TIME`,
       `col`.`name`                                                                                                   AS `TABLE_COLLATION`,
       if((`tbl`.`type` = 'VIEW'), NULL,
          internal_checksum(`sch`.`name`, `tbl`.`name`, if((`tbl`.`partition_type` is null), `tbl`.`engine`, ''),
                            `tbl`.`se_private_id`, (`tbl`.`hidden` <> 'Visible'), `ts`.`se_private_data`,
                            coalesce(`stat`.`checksum`, 0),
                            coalesce(cast(`stat`.`cached_time` as unsigned), 0)))                                     AS `CHECKSUM`,
       if((`tbl`.`type` = 'VIEW'), NULL, get_dd_create_options(`tbl`.`options`, if(
               (ifnull(`tbl`.`partition_expression`, 'NOT_PART_TBL') = 'NOT_PART_TBL'), 0, 1),
                                                               if((`sch`.`default_encryption` = 'YES'), 1, 0)))       AS `CREATE_OPTIONS`,
       internal_get_comment_or_error(`sch`.`name`, `tbl`.`name`, `tbl`.`type`, `tbl`.`options`,
                                     `tbl`.`comment`)                                                                 AS `TABLE_COMMENT`
from (((((`mysql`.`tables` `tbl` join `mysql`.`schemata` `sch` on ((`tbl`.`schema_id` = `sch`.`id`))) join `mysql`.`catalogs` `cat` on ((`cat`.`id` = `sch`.`catalog_id`))) left join `mysql`.`collations` `col` on ((`tbl`.`collation_id` = `col`.`id`))) left join `mysql`.`tablespaces` `ts` on ((`tbl`.`tablespace_id` = `ts`.`id`)))
         left join `mysql`.`table_stats` `stat`
                   on (((`tbl`.`name` = `stat`.`table_name`) and (`sch`.`name` = `stat`.`schema_name`))))
where ((0 <> can_access_table(`sch`.`name`, `tbl`.`name`)) and (0 <> is_visible_dd_object(`tbl`.`hidden`)));

create view TABLESPACES_EXTENSIONS as
	select `tsps`.`name` AS `TABLESPACE_NAME`, `tsps`.`engine_attribute` AS `ENGINE_ATTRIBUTE`
from `mysql`.`tablespaces` `tsps`;

create view TABLES_EXTENSIONS as
	select `cat`.`name`                       AS `TABLE_CATALOG`,
       `sch`.`name`                       AS `TABLE_SCHEMA`,
       `tbl`.`name`                       AS `TABLE_NAME`,
       `tbl`.`engine_attribute`           AS `ENGINE_ATTRIBUTE`,
       `tbl`.`secondary_engine_attribute` AS `SECONDARY_ENGINE_ATTRIBUTE`
from ((`mysql`.`tables` `tbl` join `mysql`.`schemata` `sch` on ((`tbl`.`schema_id` = `sch`.`id`)))
         join `mysql`.`catalogs` `cat` on ((`cat`.`id` = `sch`.`catalog_id`)))
where ((0 <> can_access_table(`sch`.`name`, `tbl`.`name`)) and (0 <> is_visible_dd_object(`tbl`.`hidden`)));

create view TABLE_CONSTRAINTS as
	select (`cat`.`name` collate utf8mb3_tolower_ci) AS `CONSTRAINT_CATALOG`,
       (`sch`.`name` collate utf8mb3_tolower_ci) AS `CONSTRAINT_SCHEMA`,
       `constraints`.`CONSTRAINT_NAME`           AS `CONSTRAINT_NAME`,
       (`sch`.`name` collate utf8mb3_tolower_ci) AS `TABLE_SCHEMA`,
       (`tbl`.`name` collate utf8mb3_tolower_ci) AS `TABLE_NAME`,
       `constraints`.`CONSTRAINT_TYPE`           AS `CONSTRAINT_TYPE`,
       `constraints`.`ENFORCED`                  AS `ENFORCED`
from (((`mysql`.`tables` `tbl` join `mysql`.`schemata` `sch` on ((`tbl`.`schema_id` = `sch`.`id`))) join `mysql`.`catalogs` `cat` on ((`cat`.`id` = `sch`.`catalog_id`)))
         join lateral (select `idx`.`name`                                                AS `CONSTRAINT_NAME`,
                              if((`idx`.`type` = 'PRIMARY'), 'PRIMARY KEY', `idx`.`type`) AS `CONSTRAINT_TYPE`,
                              'YES'                                                       AS `ENFORCED`
                       from `mysql`.`indexes` `idx`
                       where ((`idx`.`table_id` = `tbl`.`id`) and (`idx`.`type` in ('PRIMARY', 'UNIQUE')) and
                              (0 <> is_visible_dd_object(`tbl`.`hidden`, `idx`.`hidden`, `idx`.`options`)))
                       union all
                       select (`fk`.`name` collate utf8mb3_tolower_ci) AS `CONSTRAINT_NAME`,
                              'FOREIGN KEY'                            AS `CONSTRAINT_TYPE`,
                              'YES'                                    AS `ENFORCED`
                       from `mysql`.`foreign_keys` `fk`
                       where (`fk`.`table_id` = `tbl`.`id`)
                       union all
                       select `cc`.`name`     AS `CONSTRAINT_NAME`,
                              'CHECK'         AS `CONSTRAINT_TYPE`,
                              `cc`.`enforced` AS `ENFORCED`
                       from `mysql`.`check_constraints` `cc`
                       where (`cc`.`table_id` = `tbl`.`id`)) `constraints`)
where ((0 <> can_access_table(`sch`.`name`, `tbl`.`name`)) and (0 <> is_visible_dd_object(`tbl`.`hidden`)));

create view TABLE_CONSTRAINTS_EXTENSIONS as
	select `cat`.`name`                       AS `CONSTRAINT_CATALOG`,
       `sch`.`name`                       AS `CONSTRAINT_SCHEMA`,
       `idx`.`name`                       AS `CONSTRAINT_NAME`,
       `tbl`.`name`                       AS `TABLE_NAME`,
       `idx`.`engine_attribute`           AS `ENGINE_ATTRIBUTE`,
       `idx`.`secondary_engine_attribute` AS `SECONDARY_ENGINE_ATTRIBUTE`
from (((`mysql`.`indexes` `idx` join `mysql`.`tables` `tbl` on ((`idx`.`table_id` = `tbl`.`id`))) join `mysql`.`schemata` `sch` on ((`tbl`.`schema_id` = `sch`.`id`)))
         join `mysql`.`catalogs` `cat` on ((`cat`.`id` = `sch`.`catalog_id`)))
where ((0 <> can_access_table(`sch`.`name`, `tbl`.`name`)) and
       (0 <> is_visible_dd_object(`tbl`.`hidden`, false, `idx`.`options`)));

create view TRIGGERS as
	select (`cat`.`name` collate utf8mb3_tolower_ci) AS `TRIGGER_CATALOG`,
       (`sch`.`name` collate utf8mb3_tolower_ci) AS `TRIGGER_SCHEMA`,
       `trg`.`name`                              AS `TRIGGER_NAME`,
       `trg`.`event_type`                        AS `EVENT_MANIPULATION`,
       (`cat`.`name` collate utf8mb3_tolower_ci) AS `EVENT_OBJECT_CATALOG`,
       (`sch`.`name` collate utf8mb3_tolower_ci) AS `EVENT_OBJECT_SCHEMA`,
       (`tbl`.`name` collate utf8mb3_tolower_ci) AS `EVENT_OBJECT_TABLE`,
       `trg`.`action_order`                      AS `ACTION_ORDER`,
       NULL                                      AS `ACTION_CONDITION`,
       `trg`.`action_statement_utf8`             AS `ACTION_STATEMENT`,
       'ROW'                                     AS `ACTION_ORIENTATION`,
       `trg`.`action_timing`                     AS `ACTION_TIMING`,
       NULL                                      AS `ACTION_REFERENCE_OLD_TABLE`,
       NULL                                      AS `ACTION_REFERENCE_NEW_TABLE`,
       'OLD'                                     AS `ACTION_REFERENCE_OLD_ROW`,
       'NEW'                                     AS `ACTION_REFERENCE_NEW_ROW`,
       `trg`.`created`                           AS `CREATED`,
       `trg`.`sql_mode`                          AS `SQL_MODE`,
       `trg`.`definer`                           AS `DEFINER`,
       `cs_client`.`name`                        AS `CHARACTER_SET_CLIENT`,
       `coll_conn`.`name`                        AS `COLLATION_CONNECTION`,
       `coll_db`.`name`                          AS `DATABASE_COLLATION`
from (((((((`mysql`.`triggers` `trg` join `mysql`.`tables` `tbl` on ((`tbl`.`id` = `trg`.`table_id`))) join `mysql`.`schemata` `sch` on ((`tbl`.`schema_id` = `sch`.`id`))) join `mysql`.`catalogs` `cat` on ((`cat`.`id` = `sch`.`catalog_id`))) join `mysql`.`collations` `coll_client` on ((`coll_client`.`id` = `trg`.`client_collation_id`))) join `mysql`.`character_sets` `cs_client` on ((`cs_client`.`id` = `coll_client`.`character_set_id`))) join `mysql`.`collations` `coll_conn` on ((`coll_conn`.`id` = `trg`.`connection_collation_id`)))
         join `mysql`.`collations` `coll_db` on ((`coll_db`.`id` = `trg`.`schema_collation_id`)))
where ((`tbl`.`type` <> 'VIEW') and (0 <> can_access_trigger(`sch`.`name`, `tbl`.`name`)) and
       (0 <> is_visible_dd_object(`tbl`.`hidden`)));

create view USER_ATTRIBUTES as
	select `mysql`.`user`.`User`                                                      AS `USER`,
       `mysql`.`user`.`Host`                                                      AS `HOST`,
       json_unquote(json_extract(`mysql`.`user`.`User_attributes`, '$.metadata')) AS `ATTRIBUTE`
from `mysql`.`user`
where (0 <> can_access_user(`mysql`.`user`.`User`, `mysql`.`user`.`Host`));

create view VIEWS as
	select (`cat`.`name` collate utf8mb3_tolower_ci)                                         AS `TABLE_CATALOG`,
       (`sch`.`name` collate utf8mb3_tolower_ci)                                         AS `TABLE_SCHEMA`,
       (`vw`.`name` collate utf8mb3_tolower_ci)                                          AS `TABLE_NAME`,
       if((can_access_view(`sch`.`name`, `vw`.`name`, `vw`.`view_definer`, `vw`.`options`) = true),
          `vw`.`view_definition_utf8`, '')                                               AS `VIEW_DEFINITION`,
       `vw`.`view_check_option`                                                          AS `CHECK_OPTION`,
       `vw`.`view_is_updatable`                                                          AS `IS_UPDATABLE`,
       `vw`.`view_definer`                                                               AS `DEFINER`,
       if((`vw`.`view_security_type` = 'DEFAULT'), 'DEFINER', `vw`.`view_security_type`) AS `SECURITY_TYPE`,
       `cs`.`name`                                                                       AS `CHARACTER_SET_CLIENT`,
       `conn_coll`.`name`                                                                AS `COLLATION_CONNECTION`
from (((((`mysql`.`tables` `vw` join `mysql`.`schemata` `sch` on ((`vw`.`schema_id` = `sch`.`id`))) join `mysql`.`catalogs` `cat` on ((`cat`.`id` = `sch`.`catalog_id`))) join `mysql`.`collations` `conn_coll` on ((`conn_coll`.`id` = `vw`.`view_connection_collation_id`))) join `mysql`.`collations` `client_coll` on ((`client_coll`.`id` = `vw`.`view_client_collation_id`)))
         join `mysql`.`character_sets` `cs` on ((`cs`.`id` = `client_coll`.`character_set_id`)))
where ((0 <> can_access_table(`sch`.`name`, `vw`.`name`)) and (`vw`.`type` = 'VIEW'));

create view VIEW_ROUTINE_USAGE as
	select (`cat`.`name` collate utf8mb3_tolower_ci)            AS `TABLE_CATALOG`,
       (`sch`.`name` collate utf8mb3_tolower_ci)            AS `TABLE_SCHEMA`,
       (`vw`.`name` collate utf8mb3_tolower_ci)             AS `TABLE_NAME`,
       (`vru`.`routine_catalog` collate utf8mb3_tolower_ci) AS `SPECIFIC_CATALOG`,
       (`vru`.`routine_schema` collate utf8mb3_tolower_ci)  AS `SPECIFIC_SCHEMA`,
       `vru`.`routine_name`                                 AS `SPECIFIC_NAME`
from ((((`mysql`.`tables` `vw` join `mysql`.`schemata` `sch` on ((`vw`.`schema_id` = `sch`.`id`))) join `mysql`.`catalogs` `cat` on ((`cat`.`id` = `sch`.`catalog_id`))) join `mysql`.`view_routine_usage` `vru` on ((`vru`.`view_id` = `vw`.`id`)))
         join `mysql`.`routines` `rtn`
              on (((`vru`.`routine_catalog` = `cat`.`name`) and (`vru`.`routine_schema` = `sch`.`name`) and
                   (`vru`.`routine_name` = `rtn`.`name`))))
where ((`vw`.`type` = 'VIEW') and
       (0 <> can_access_routine(`vru`.`routine_schema`, `vru`.`routine_name`, `rtn`.`type`, `rtn`.`definer`, false)) and
       (0 <> can_access_view(`sch`.`name`, `vw`.`name`, `vw`.`view_definer`, `vw`.`options`)));

create view VIEW_TABLE_USAGE as
	select (`cat`.`name` collate utf8mb3_tolower_ci)          AS `VIEW_CATALOG`,
       (`sch`.`name` collate utf8mb3_tolower_ci)          AS `VIEW_SCHEMA`,
       (`vw`.`name` collate utf8mb3_tolower_ci)           AS `VIEW_NAME`,
       (`vtu`.`table_catalog` collate utf8mb3_tolower_ci) AS `TABLE_CATALOG`,
       (`vtu`.`table_schema` collate utf8mb3_tolower_ci)  AS `TABLE_SCHEMA`,
       (`vtu`.`table_name` collate utf8mb3_tolower_ci)    AS `TABLE_NAME`
from (((`mysql`.`tables` `vw` join `mysql`.`schemata` `sch` on ((`vw`.`schema_id` = `sch`.`id`))) join `mysql`.`catalogs` `cat` on ((`cat`.`id` = `sch`.`catalog_id`)))
         join `mysql`.`view_table_usage` `vtu` on ((`vtu`.`view_id` = `vw`.`id`)))
where ((0 <> can_access_table(`vtu`.`table_schema`, `vtu`.`table_name`)) and (`vw`.`type` = 'VIEW') and
       (0 <> can_access_view(`sch`.`name`, `vw`.`name`, `vw`.`view_definer`, `vw`.`options`)));

create definer = `mysql.sys`@localhost view sys.host_summary as
	select if((`performance_schema`.`accounts`.`HOST` is null), 'background',
          `performance_schema`.`accounts`.`HOST`)                                                              AS `host`,
       sum(`sys`.`stmt`.`total`)                                                                               AS `statements`,
       format_pico_time(sum(`sys`.`stmt`.`total_latency`))                                                     AS `statement_latency`,
       format_pico_time(ifnull((sum(`sys`.`stmt`.`total_latency`) / nullif(sum(`sys`.`stmt`.`total`), 0)),
                               0))                                                                             AS `statement_avg_latency`,
       sum(`sys`.`stmt`.`full_scans`)                                                                          AS `table_scans`,
       sum(`sys`.`io`.`ios`)                                                                                   AS `file_ios`,
       format_pico_time(sum(`sys`.`io`.`io_latency`))                                                          AS `file_io_latency`,
       sum(`performance_schema`.`accounts`.`CURRENT_CONNECTIONS`)                                              AS `current_connections`,
       sum(`performance_schema`.`accounts`.`TOTAL_CONNECTIONS`)                                                AS `total_connections`,
       count(distinct `performance_schema`.`accounts`.`USER`)                                                  AS `unique_users`,
       format_bytes(sum(`sys`.`mem`.`current_allocated`))                                                      AS `current_memory`,
       format_bytes(sum(`sys`.`mem`.`total_allocated`))                                                        AS `total_memory_allocated`
from (((`performance_schema`.`accounts` join `sys`.`x$host_summary_by_statement_latency` `stmt` on ((`performance_schema`.`accounts`.`HOST` = `sys`.`stmt`.`host`))) join `sys`.`x$host_summary_by_file_io` `io` on ((`performance_schema`.`accounts`.`HOST` = `sys`.`io`.`host`)))
         join `sys`.`x$memory_by_host_by_current_bytes` `mem`
              on ((`performance_schema`.`accounts`.`HOST` = `sys`.`mem`.`host`)))
group by if((`performance_schema`.`accounts`.`HOST` is null), 'background', `performance_schema`.`accounts`.`HOST`);

create definer = `mysql.sys`@localhost view sys.host_summary_by_file_io as
	select if((`performance_schema`.`events_waits_summary_by_host_by_event_name`.`HOST` is null), 'background',
          `performance_schema`.`events_waits_summary_by_host_by_event_name`.`HOST`)                              AS `host`,
       sum(
               `performance_schema`.`events_waits_summary_by_host_by_event_name`.`COUNT_STAR`)                   AS `ios`,
       format_pico_time(sum(
               `performance_schema`.`events_waits_summary_by_host_by_event_name`.`SUM_TIMER_WAIT`))              AS `io_latency`
from `performance_schema`.`events_waits_summary_by_host_by_event_name`
where (`performance_schema`.`events_waits_summary_by_host_by_event_name`.`EVENT_NAME` like 'wait/io/file/%')
group by if((`performance_schema`.`events_waits_summary_by_host_by_event_name`.`HOST` is null), 'background',
            `performance_schema`.`events_waits_summary_by_host_by_event_name`.`HOST`)
order by sum(`performance_schema`.`events_waits_summary_by_host_by_event_name`.`SUM_TIMER_WAIT`) desc;

create definer = `mysql.sys`@localhost view sys.host_summary_by_file_io_type as
	select if((`performance_schema`.`events_waits_summary_by_host_by_event_name`.`HOST` is null), 'background',
          `performance_schema`.`events_waits_summary_by_host_by_event_name`.`HOST`)                         AS `host`,
       `performance_schema`.`events_waits_summary_by_host_by_event_name`.`EVENT_NAME`                       AS `event_name`,
       `performance_schema`.`events_waits_summary_by_host_by_event_name`.`COUNT_STAR`                       AS `total`,
       format_pico_time(
               `performance_schema`.`events_waits_summary_by_host_by_event_name`.`SUM_TIMER_WAIT`)          AS `total_latency`,
       format_pico_time(
               `performance_schema`.`events_waits_summary_by_host_by_event_name`.`MAX_TIMER_WAIT`)          AS `max_latency`
from `performance_schema`.`events_waits_summary_by_host_by_event_name`
where ((`performance_schema`.`events_waits_summary_by_host_by_event_name`.`EVENT_NAME` like 'wait/io/file%') and
       (`performance_schema`.`events_waits_summary_by_host_by_event_name`.`COUNT_STAR` > 0))
order by if((`performance_schema`.`events_waits_summary_by_host_by_event_name`.`HOST` is null), 'background',
            `performance_schema`.`events_waits_summary_by_host_by_event_name`.`HOST`),
         `performance_schema`.`events_waits_summary_by_host_by_event_name`.`SUM_TIMER_WAIT` desc;

create definer = `mysql.sys`@localhost view sys.host_summary_by_stages as
	select if((`performance_schema`.`events_stages_summary_by_host_by_event_name`.`HOST` is null), 'background',
          `performance_schema`.`events_stages_summary_by_host_by_event_name`.`HOST`)                         AS `host`,
       `performance_schema`.`events_stages_summary_by_host_by_event_name`.`EVENT_NAME`                       AS `event_name`,
       `performance_schema`.`events_stages_summary_by_host_by_event_name`.`COUNT_STAR`                       AS `total`,
       format_pico_time(
               `performance_schema`.`events_stages_summary_by_host_by_event_name`.`SUM_TIMER_WAIT`)          AS `total_latency`,
       format_pico_time(
               `performance_schema`.`events_stages_summary_by_host_by_event_name`.`AVG_TIMER_WAIT`)          AS `avg_latency`
from `performance_schema`.`events_stages_summary_by_host_by_event_name`
where (`performance_schema`.`events_stages_summary_by_host_by_event_name`.`SUM_TIMER_WAIT` <> 0)
order by if((`performance_schema`.`events_stages_summary_by_host_by_event_name`.`HOST` is null), 'background',
            `performance_schema`.`events_stages_summary_by_host_by_event_name`.`HOST`),
         `performance_schema`.`events_stages_summary_by_host_by_event_name`.`SUM_TIMER_WAIT` desc;

create definer = `mysql.sys`@localhost view sys.host_summary_by_statement_latency as
	select if((`performance_schema`.`events_statements_summary_by_host_by_event_name`.`HOST` is null), 'background',
          `performance_schema`.`events_statements_summary_by_host_by_event_name`.`HOST`)                              AS `host`,
       sum(
               `performance_schema`.`events_statements_summary_by_host_by_event_name`.`COUNT_STAR`)                   AS `total`,
       format_pico_time(sum(
               `performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_TIMER_WAIT`))              AS `total_latency`,
       format_pico_time(max(
               `performance_schema`.`events_statements_summary_by_host_by_event_name`.`MAX_TIMER_WAIT`))              AS `max_latency`,
       format_pico_time(sum(
               `performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_LOCK_TIME`))               AS `lock_latency`,
       format_pico_time(sum(
               `performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_CPU_TIME`))                AS `cpu_latency`,
       sum(
               `performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_ROWS_SENT`)                AS `rows_sent`,
       sum(
               `performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_ROWS_EXAMINED`)            AS `rows_examined`,
       sum(
               `performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_ROWS_AFFECTED`)            AS `rows_affected`,
       (sum(`performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_NO_INDEX_USED`) + sum(
               `performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_NO_GOOD_INDEX_USED`))      AS `full_scans`
from `performance_schema`.`events_statements_summary_by_host_by_event_name`
group by if((`performance_schema`.`events_statements_summary_by_host_by_event_name`.`HOST` is null), 'background',
            `performance_schema`.`events_statements_summary_by_host_by_event_name`.`HOST`)
order by sum(`performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_TIMER_WAIT`) desc;

create definer = `mysql.sys`@localhost view sys.host_summary_by_statement_type as
	select if((`performance_schema`.`events_statements_summary_by_host_by_event_name`.`HOST` is null), 'background',
          `performance_schema`.`events_statements_summary_by_host_by_event_name`.`HOST`)                         AS `host`,
       substring_index(`performance_schema`.`events_statements_summary_by_host_by_event_name`.`EVENT_NAME`, '/',
                       -(1))                                                                                     AS `statement`,
       `performance_schema`.`events_statements_summary_by_host_by_event_name`.`COUNT_STAR`                       AS `total`,
       format_pico_time(
               `performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_TIMER_WAIT`)          AS `total_latency`,
       format_pico_time(
               `performance_schema`.`events_statements_summary_by_host_by_event_name`.`MAX_TIMER_WAIT`)          AS `max_latency`,
       format_pico_time(
               `performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_LOCK_TIME`)           AS `lock_latency`,
       format_pico_time(
               `performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_CPU_TIME`)            AS `cpu_latency`,
       `performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_ROWS_SENT`                    AS `rows_sent`,
       `performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_ROWS_EXAMINED`                AS `rows_examined`,
       `performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_ROWS_AFFECTED`                AS `rows_affected`,
       (`performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_NO_INDEX_USED` +
        `performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_NO_GOOD_INDEX_USED`)         AS `full_scans`
from `performance_schema`.`events_statements_summary_by_host_by_event_name`
where (`performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_TIMER_WAIT` <> 0)
order by if((`performance_schema`.`events_statements_summary_by_host_by_event_name`.`HOST` is null), 'background',
            `performance_schema`.`events_statements_summary_by_host_by_event_name`.`HOST`),
         `performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_TIMER_WAIT` desc;

create definer = `mysql.sys`@localhost view sys.innodb_buffer_stats_by_schema as
	select if((locate('.', `ibp`.`TABLE_NAME`) = 0), 'InnoDB System',
          replace(substring_index(`ibp`.`TABLE_NAME`, '.', 1), '`', ''))                    AS `object_schema`,
       format_bytes(sum(if((`ibp`.`COMPRESSED_SIZE` = 0), 16384, `ibp`.`COMPRESSED_SIZE`))) AS `allocated`,
       format_bytes(sum(`ibp`.`DATA_SIZE`))                                                 AS `data`,
       count(`ibp`.`PAGE_NUMBER`)                                                           AS `pages`,
       count(if((`ibp`.`IS_HASHED` = 'YES'), 1, NULL))                                      AS `pages_hashed`,
       count(if((`ibp`.`IS_OLD` = 'YES'), 1, NULL))                                         AS `pages_old`,
       round((sum(`ibp`.`NUMBER_RECORDS`) / count(distinct `ibp`.`INDEX_NAME`)), 0)         AS `rows_cached`
from `information_schema`.`INNODB_BUFFER_PAGE` `ibp`
where (`ibp`.`TABLE_NAME` is not null)
group by `object_schema`
order by sum(if((`ibp`.`COMPRESSED_SIZE` = 0), 16384, `ibp`.`COMPRESSED_SIZE`)) desc;

create definer = `mysql.sys`@localhost view sys.innodb_buffer_stats_by_table as
	select if((locate('.', `ibp`.`TABLE_NAME`) = 0), 'InnoDB System',
          replace(substring_index(`ibp`.`TABLE_NAME`, '.', 1), '`', ''))                    AS `object_schema`,
       replace(substring_index(`ibp`.`TABLE_NAME`, '.', -(1)), '`', '')                     AS `object_name`,
       format_bytes(sum(if((`ibp`.`COMPRESSED_SIZE` = 0), 16384, `ibp`.`COMPRESSED_SIZE`))) AS `allocated`,
       format_bytes(sum(`ibp`.`DATA_SIZE`))                                                 AS `data`,
       count(`ibp`.`PAGE_NUMBER`)                                                           AS `pages`,
       count(if((`ibp`.`IS_HASHED` = 'YES'), 1, NULL))                                      AS `pages_hashed`,
       count(if((`ibp`.`IS_OLD` = 'YES'), 1, NULL))                                         AS `pages_old`,
       round((sum(`ibp`.`NUMBER_RECORDS`) / count(distinct `ibp`.`INDEX_NAME`)), 0)         AS `rows_cached`
from `information_schema`.`INNODB_BUFFER_PAGE` `ibp`
where (`ibp`.`TABLE_NAME` is not null)
group by `object_schema`, `object_name`
order by sum(if((`ibp`.`COMPRESSED_SIZE` = 0), 16384, `ibp`.`COMPRESSED_SIZE`)) desc;

create definer = `mysql.sys`@localhost view sys.innodb_lock_waits as
	select `r`.`trx_wait_started`                                                                                    AS `wait_started`,
       timediff(now(), `r`.`trx_wait_started`)                                                                   AS `wait_age`,
       timestampdiff(SECOND, `r`.`trx_wait_started`, now())                                                      AS `wait_age_secs`,
       concat(`sys`.`quote_identifier`(`rl`.`OBJECT_SCHEMA`), '.',
              `sys`.`quote_identifier`(`rl`.`OBJECT_NAME`))                                                      AS `locked_table`,
       `rl`.`OBJECT_SCHEMA`                                                                                      AS `locked_table_schema`,
       `rl`.`OBJECT_NAME`                                                                                        AS `locked_table_name`,
       `rl`.`PARTITION_NAME`                                                                                     AS `locked_table_partition`,
       `rl`.`SUBPARTITION_NAME`                                                                                  AS `locked_table_subpartition`,
       `rl`.`INDEX_NAME`                                                                                         AS `locked_index`,
       `rl`.`LOCK_TYPE`                                                                                          AS `locked_type`,
       `r`.`trx_id`                                                                                              AS `waiting_trx_id`,
       `r`.`trx_started`                                                                                         AS `waiting_trx_started`,
       timediff(now(), `r`.`trx_started`)                                                                        AS `waiting_trx_age`,
       `r`.`trx_rows_locked`                                                                                     AS `waiting_trx_rows_locked`,
       `r`.`trx_rows_modified`                                                                                   AS `waiting_trx_rows_modified`,
       `r`.`trx_mysql_thread_id`                                                                                 AS `waiting_pid`,
       `sys`.`format_statement`(`r`.`trx_query`)                                                                 AS `waiting_query`,
       `rl`.`ENGINE_LOCK_ID`                                                                                     AS `waiting_lock_id`,
       `rl`.`LOCK_MODE`                                                                                          AS `waiting_lock_mode`,
       `b`.`trx_id`                                                                                              AS `blocking_trx_id`,
       `b`.`trx_mysql_thread_id`                                                                                 AS `blocking_pid`,
       `sys`.`format_statement`(`b`.`trx_query`)                                                                 AS `blocking_query`,
       `bl`.`ENGINE_LOCK_ID`                                                                                     AS `blocking_lock_id`,
       `bl`.`LOCK_MODE`                                                                                          AS `blocking_lock_mode`,
       `b`.`trx_started`                                                                                         AS `blocking_trx_started`,
       timediff(now(), `b`.`trx_started`)                                                                        AS `blocking_trx_age`,
       `b`.`trx_rows_locked`                                                                                     AS `blocking_trx_rows_locked`,
       `b`.`trx_rows_modified`                                                                                   AS `blocking_trx_rows_modified`,
       concat('KILL QUERY ', `b`.`trx_mysql_thread_id`)                                                          AS `sql_kill_blocking_query`,
       concat('KILL ', `b`.`trx_mysql_thread_id`)                                                                AS `sql_kill_blocking_connection`
from ((((`performance_schema`.`data_lock_waits` `w` join `information_schema`.`INNODB_TRX` `b` on ((`b`.`trx_id` =
                                                                                                    cast(`w`.`BLOCKING_ENGINE_TRANSACTION_ID` as char charset utf8mb4)))) join `information_schema`.`INNODB_TRX` `r` on ((
        `r`.`trx_id` =
        cast(`w`.`REQUESTING_ENGINE_TRANSACTION_ID` as char charset utf8mb4)))) join `performance_schema`.`data_locks` `bl` on ((`bl`.`ENGINE_LOCK_ID` = `w`.`BLOCKING_ENGINE_LOCK_ID`)))
         join `performance_schema`.`data_locks` `rl` on ((`rl`.`ENGINE_LOCK_ID` = `w`.`REQUESTING_ENGINE_LOCK_ID`)))
order by `r`.`trx_wait_started`;

create definer = `mysql.sys`@localhost view sys.io_by_thread_by_latency as
	select if((`performance_schema`.`threads`.`PROCESSLIST_ID` is null),
          substring_index(`performance_schema`.`threads`.`NAME`, '/', -(1)),
          concat(`performance_schema`.`threads`.`PROCESSLIST_USER`, '@',
                 convert(`performance_schema`.`threads`.`PROCESSLIST_HOST` using utf8mb4)))                        AS `user`,
       sum(
               `performance_schema`.`events_waits_summary_by_thread_by_event_name`.`COUNT_STAR`)                   AS `total`,
       format_pico_time(sum(
               `performance_schema`.`events_waits_summary_by_thread_by_event_name`.`SUM_TIMER_WAIT`))              AS `total_latency`,
       format_pico_time(min(
               `performance_schema`.`events_waits_summary_by_thread_by_event_name`.`MIN_TIMER_WAIT`))              AS `min_latency`,
       format_pico_time(avg(
               `performance_schema`.`events_waits_summary_by_thread_by_event_name`.`AVG_TIMER_WAIT`))              AS `avg_latency`,
       format_pico_time(max(
               `performance_schema`.`events_waits_summary_by_thread_by_event_name`.`MAX_TIMER_WAIT`))              AS `max_latency`,
       `performance_schema`.`events_waits_summary_by_thread_by_event_name`.`THREAD_ID`                             AS `thread_id`,
       `performance_schema`.`threads`.`PROCESSLIST_ID`                                                             AS `processlist_id`
from (`performance_schema`.`events_waits_summary_by_thread_by_event_name`
         left join `performance_schema`.`threads`
                   on ((`performance_schema`.`events_waits_summary_by_thread_by_event_name`.`THREAD_ID` =
                        `performance_schema`.`threads`.`THREAD_ID`)))
where ((`performance_schema`.`events_waits_summary_by_thread_by_event_name`.`EVENT_NAME` like 'wait/io/file/%') and
       (`performance_schema`.`events_waits_summary_by_thread_by_event_name`.`SUM_TIMER_WAIT` > 0))
group by `performance_schema`.`events_waits_summary_by_thread_by_event_name`.`THREAD_ID`,
         `performance_schema`.`threads`.`PROCESSLIST_ID`, `user`
order by sum(`performance_schema`.`events_waits_summary_by_thread_by_event_name`.`SUM_TIMER_WAIT`) desc;

create definer = `mysql.sys`@localhost view sys.io_global_by_file_by_bytes as
	select `sys`.`format_path`(`performance_schema`.`file_summary_by_instance`.`FILE_NAME`)                              AS `file`,
       `performance_schema`.`file_summary_by_instance`.`COUNT_READ`                                                  AS `count_read`,
       format_bytes(
               `performance_schema`.`file_summary_by_instance`.`SUM_NUMBER_OF_BYTES_READ`)                           AS `total_read`,
       format_bytes(ifnull((`performance_schema`.`file_summary_by_instance`.`SUM_NUMBER_OF_BYTES_READ` /
                            nullif(`performance_schema`.`file_summary_by_instance`.`COUNT_READ`, 0)),
                           0))                                                                                       AS `avg_read`,
       `performance_schema`.`file_summary_by_instance`.`COUNT_WRITE`                                                 AS `count_write`,
       format_bytes(
               `performance_schema`.`file_summary_by_instance`.`SUM_NUMBER_OF_BYTES_WRITE`)                          AS `total_written`,
       format_bytes(ifnull((`performance_schema`.`file_summary_by_instance`.`SUM_NUMBER_OF_BYTES_WRITE` /
                            nullif(`performance_schema`.`file_summary_by_instance`.`COUNT_WRITE`, 0)),
                           0.00))                                                                                    AS `avg_write`,
       format_bytes((`performance_schema`.`file_summary_by_instance`.`SUM_NUMBER_OF_BYTES_READ` +
                     `performance_schema`.`file_summary_by_instance`.`SUM_NUMBER_OF_BYTES_WRITE`))                   AS `total`,
       ifnull(round((100 - ((`performance_schema`.`file_summary_by_instance`.`SUM_NUMBER_OF_BYTES_READ` / nullif(
               (`performance_schema`.`file_summary_by_instance`.`SUM_NUMBER_OF_BYTES_READ` +
                `performance_schema`.`file_summary_by_instance`.`SUM_NUMBER_OF_BYTES_WRITE`), 0)) * 100)), 2),
              0.00)                                                                                                  AS `write_pct`
from `performance_schema`.`file_summary_by_instance`
order by (`performance_schema`.`file_summary_by_instance`.`SUM_NUMBER_OF_BYTES_READ` +
          `performance_schema`.`file_summary_by_instance`.`SUM_NUMBER_OF_BYTES_WRITE`) desc;

create definer = `mysql.sys`@localhost view sys.io_global_by_file_by_latency as
	select `sys`.`format_path`(`performance_schema`.`file_summary_by_instance`.`FILE_NAME`)    AS `file`,
       `performance_schema`.`file_summary_by_instance`.`COUNT_STAR`                        AS `total`,
       format_pico_time(`performance_schema`.`file_summary_by_instance`.`SUM_TIMER_WAIT`)  AS `total_latency`,
       `performance_schema`.`file_summary_by_instance`.`COUNT_READ`                        AS `count_read`,
       format_pico_time(`performance_schema`.`file_summary_by_instance`.`SUM_TIMER_READ`)  AS `read_latency`,
       `performance_schema`.`file_summary_by_instance`.`COUNT_WRITE`                       AS `count_write`,
       format_pico_time(`performance_schema`.`file_summary_by_instance`.`SUM_TIMER_WRITE`) AS `write_latency`,
       `performance_schema`.`file_summary_by_instance`.`COUNT_MISC`                        AS `count_misc`,
       format_pico_time(`performance_schema`.`file_summary_by_instance`.`SUM_TIMER_MISC`)  AS `misc_latency`
from `performance_schema`.`file_summary_by_instance`
order by `performance_schema`.`file_summary_by_instance`.`SUM_TIMER_WAIT` desc;

create definer = `mysql.sys`@localhost view sys.io_global_by_wait_by_bytes as
	select substring_index(`performance_schema`.`file_summary_by_event_name`.`EVENT_NAME`, '/', -(2))            AS `event_name`,
       `performance_schema`.`file_summary_by_event_name`.`COUNT_STAR`                                        AS `total`,
       format_pico_time(
               `performance_schema`.`file_summary_by_event_name`.`SUM_TIMER_WAIT`)                           AS `total_latency`,
       format_pico_time(
               `performance_schema`.`file_summary_by_event_name`.`MIN_TIMER_WAIT`)                           AS `min_latency`,
       format_pico_time(
               `performance_schema`.`file_summary_by_event_name`.`AVG_TIMER_WAIT`)                           AS `avg_latency`,
       format_pico_time(
               `performance_schema`.`file_summary_by_event_name`.`MAX_TIMER_WAIT`)                           AS `max_latency`,
       `performance_schema`.`file_summary_by_event_name`.`COUNT_READ`                                        AS `count_read`,
       format_bytes(
               `performance_schema`.`file_summary_by_event_name`.`SUM_NUMBER_OF_BYTES_READ`)                 AS `total_read`,
       format_bytes(ifnull((`performance_schema`.`file_summary_by_event_name`.`SUM_NUMBER_OF_BYTES_READ` /
                            nullif(`performance_schema`.`file_summary_by_event_name`.`COUNT_READ`, 0)),
                           0))                                                                               AS `avg_read`,
       `performance_schema`.`file_summary_by_event_name`.`COUNT_WRITE`                                       AS `count_write`,
       format_bytes(
               `performance_schema`.`file_summary_by_event_name`.`SUM_NUMBER_OF_BYTES_WRITE`)                AS `total_written`,
       format_bytes(ifnull((`performance_schema`.`file_summary_by_event_name`.`SUM_NUMBER_OF_BYTES_WRITE` /
                            nullif(`performance_schema`.`file_summary_by_event_name`.`COUNT_WRITE`, 0)),
                           0))                                                                               AS `avg_written`,
       format_bytes((`performance_schema`.`file_summary_by_event_name`.`SUM_NUMBER_OF_BYTES_WRITE` +
                     `performance_schema`.`file_summary_by_event_name`.`SUM_NUMBER_OF_BYTES_READ`))          AS `total_requested`
from `performance_schema`.`file_summary_by_event_name`
where ((`performance_schema`.`file_summary_by_event_name`.`EVENT_NAME` like 'wait/io/file/%') and
       (`performance_schema`.`file_summary_by_event_name`.`COUNT_STAR` > 0))
order by (`performance_schema`.`file_summary_by_event_name`.`SUM_NUMBER_OF_BYTES_WRITE` +
          `performance_schema`.`file_summary_by_event_name`.`SUM_NUMBER_OF_BYTES_READ`) desc;

create definer = `mysql.sys`@localhost view sys.io_global_by_wait_by_latency as
	select substring_index(`performance_schema`.`file_summary_by_event_name`.`EVENT_NAME`, '/', -(2))            AS `event_name`,
       `performance_schema`.`file_summary_by_event_name`.`COUNT_STAR`                                        AS `total`,
       format_pico_time(
               `performance_schema`.`file_summary_by_event_name`.`SUM_TIMER_WAIT`)                           AS `total_latency`,
       format_pico_time(
               `performance_schema`.`file_summary_by_event_name`.`AVG_TIMER_WAIT`)                           AS `avg_latency`,
       format_pico_time(
               `performance_schema`.`file_summary_by_event_name`.`MAX_TIMER_WAIT`)                           AS `max_latency`,
       format_pico_time(
               `performance_schema`.`file_summary_by_event_name`.`SUM_TIMER_READ`)                           AS `read_latency`,
       format_pico_time(
               `performance_schema`.`file_summary_by_event_name`.`SUM_TIMER_WRITE`)                          AS `write_latency`,
       format_pico_time(
               `performance_schema`.`file_summary_by_event_name`.`SUM_TIMER_MISC`)                           AS `misc_latency`,
       `performance_schema`.`file_summary_by_event_name`.`COUNT_READ`                                        AS `count_read`,
       format_bytes(
               `performance_schema`.`file_summary_by_event_name`.`SUM_NUMBER_OF_BYTES_READ`)                 AS `total_read`,
       format_bytes(ifnull((`performance_schema`.`file_summary_by_event_name`.`SUM_NUMBER_OF_BYTES_READ` /
                            nullif(`performance_schema`.`file_summary_by_event_name`.`COUNT_READ`, 0)),
                           0))                                                                               AS `avg_read`,
       `performance_schema`.`file_summary_by_event_name`.`COUNT_WRITE`                                       AS `count_write`,
       format_bytes(
               `performance_schema`.`file_summary_by_event_name`.`SUM_NUMBER_OF_BYTES_WRITE`)                AS `total_written`,
       format_bytes(ifnull((`performance_schema`.`file_summary_by_event_name`.`SUM_NUMBER_OF_BYTES_WRITE` /
                            nullif(`performance_schema`.`file_summary_by_event_name`.`COUNT_WRITE`, 0)),
                           0))                                                                               AS `avg_written`
from `performance_schema`.`file_summary_by_event_name`
where ((`performance_schema`.`file_summary_by_event_name`.`EVENT_NAME` like 'wait/io/file/%') and
       (`performance_schema`.`file_summary_by_event_name`.`COUNT_STAR` > 0))
order by `performance_schema`.`file_summary_by_event_name`.`SUM_TIMER_WAIT` desc;

create definer = `mysql.sys`@localhost view sys.latest_file_io as
	select if((`information_schema`.`processlist`.`ID` is null),
          concat(substring_index(`performance_schema`.`threads`.`NAME`, '/', -(1)), ':',
                 `performance_schema`.`events_waits_history_long`.`THREAD_ID`), convert(
                  concat(`information_schema`.`processlist`.`USER`, '@', `information_schema`.`processlist`.`HOST`, ':',
                         `information_schema`.`processlist`.`ID`) using utf8mb4))          AS `thread`,
       `sys`.`format_path`(`performance_schema`.`events_waits_history_long`.`OBJECT_NAME`) AS `file`,
       format_pico_time(`performance_schema`.`events_waits_history_long`.`TIMER_WAIT`)     AS `latency`,
       `performance_schema`.`events_waits_history_long`.`OPERATION`                        AS `operation`,
       format_bytes(`performance_schema`.`events_waits_history_long`.`NUMBER_OF_BYTES`)    AS `requested`
from ((`performance_schema`.`events_waits_history_long` join `performance_schema`.`threads` on ((
        `performance_schema`.`events_waits_history_long`.`THREAD_ID` = `performance_schema`.`threads`.`THREAD_ID`)))
         left join `information_schema`.`PROCESSLIST`
                   on ((`performance_schema`.`threads`.`PROCESSLIST_ID` = `information_schema`.`processlist`.`ID`)))
where ((`performance_schema`.`events_waits_history_long`.`OBJECT_NAME` is not null) and
       (`performance_schema`.`events_waits_history_long`.`EVENT_NAME` like 'wait/io/file/%'))
order by `performance_schema`.`events_waits_history_long`.`TIMER_START`;

create definer = `mysql.sys`@localhost view sys.memory_by_host_by_current_bytes as
	select if((`performance_schema`.`memory_summary_by_host_by_event_name`.`HOST` is null), 'background',
          `performance_schema`.`memory_summary_by_host_by_event_name`.`HOST`)                                        AS `host`,
       sum(
               `performance_schema`.`memory_summary_by_host_by_event_name`.`CURRENT_COUNT_USED`)                     AS `current_count_used`,
       format_bytes(sum(
               `performance_schema`.`memory_summary_by_host_by_event_name`.`CURRENT_NUMBER_OF_BYTES_USED`))          AS `current_allocated`,
       format_bytes(ifnull(
               (sum(`performance_schema`.`memory_summary_by_host_by_event_name`.`CURRENT_NUMBER_OF_BYTES_USED`) /
                nullif(sum(`performance_schema`.`memory_summary_by_host_by_event_name`.`CURRENT_COUNT_USED`), 0)),
               0))                                                                                                   AS `current_avg_alloc`,
       format_bytes(max(
               `performance_schema`.`memory_summary_by_host_by_event_name`.`CURRENT_NUMBER_OF_BYTES_USED`))          AS `current_max_alloc`,
       format_bytes(sum(
               `performance_schema`.`memory_summary_by_host_by_event_name`.`SUM_NUMBER_OF_BYTES_ALLOC`))             AS `total_allocated`
from `performance_schema`.`memory_summary_by_host_by_event_name`
group by if((`performance_schema`.`memory_summary_by_host_by_event_name`.`HOST` is null), 'background',
            `performance_schema`.`memory_summary_by_host_by_event_name`.`HOST`)
order by sum(`performance_schema`.`memory_summary_by_host_by_event_name`.`CURRENT_NUMBER_OF_BYTES_USED`) desc;

create definer = `mysql.sys`@localhost view sys.memory_by_thread_by_current_bytes as
	select `mt`.`THREAD_ID`                                                                                           AS `thread_id`,
       if((`t`.`NAME` = 'thread/sql/one_connection'),
          concat(`t`.`PROCESSLIST_USER`, '@', convert(`t`.`PROCESSLIST_HOST` using utf8mb4)),
          replace(`t`.`NAME`, 'thread/', ''))                                                                     AS `user`,
       sum(`mt`.`CURRENT_COUNT_USED`)                                                                             AS `current_count_used`,
       format_bytes(sum(`mt`.`CURRENT_NUMBER_OF_BYTES_USED`))                                                     AS `current_allocated`,
       format_bytes(ifnull((sum(`mt`.`CURRENT_NUMBER_OF_BYTES_USED`) / nullif(sum(`mt`.`CURRENT_COUNT_USED`), 0)),
                           0))                                                                                    AS `current_avg_alloc`,
       format_bytes(max(`mt`.`CURRENT_NUMBER_OF_BYTES_USED`))                                                     AS `current_max_alloc`,
       format_bytes(sum(`mt`.`SUM_NUMBER_OF_BYTES_ALLOC`))                                                        AS `total_allocated`
from (`performance_schema`.`memory_summary_by_thread_by_event_name` `mt`
         join `performance_schema`.`threads` `t` on ((`mt`.`THREAD_ID` = `t`.`THREAD_ID`)))
group by `mt`.`THREAD_ID`,
         if((`t`.`NAME` = 'thread/sql/one_connection'),
            concat(`t`.`PROCESSLIST_USER`, '@', convert(`t`.`PROCESSLIST_HOST` using utf8mb4)),
            replace(`t`.`NAME`, 'thread/', ''))
order by sum(`mt`.`CURRENT_NUMBER_OF_BYTES_USED`) desc;

create definer = `mysql.sys`@localhost view sys.memory_by_user_by_current_bytes as
	select if((`performance_schema`.`memory_summary_by_user_by_event_name`.`USER` is null), 'background',
          `performance_schema`.`memory_summary_by_user_by_event_name`.`USER`)                                        AS `user`,
       sum(
               `performance_schema`.`memory_summary_by_user_by_event_name`.`CURRENT_COUNT_USED`)                     AS `current_count_used`,
       format_bytes(sum(
               `performance_schema`.`memory_summary_by_user_by_event_name`.`CURRENT_NUMBER_OF_BYTES_USED`))          AS `current_allocated`,
       format_bytes(ifnull(
               (sum(`performance_schema`.`memory_summary_by_user_by_event_name`.`CURRENT_NUMBER_OF_BYTES_USED`) /
                nullif(sum(`performance_schema`.`memory_summary_by_user_by_event_name`.`CURRENT_COUNT_USED`), 0)),
               0))                                                                                                   AS `current_avg_alloc`,
       format_bytes(max(
               `performance_schema`.`memory_summary_by_user_by_event_name`.`CURRENT_NUMBER_OF_BYTES_USED`))          AS `current_max_alloc`,
       format_bytes(sum(
               `performance_schema`.`memory_summary_by_user_by_event_name`.`SUM_NUMBER_OF_BYTES_ALLOC`))             AS `total_allocated`
from `performance_schema`.`memory_summary_by_user_by_event_name`
group by if((`performance_schema`.`memory_summary_by_user_by_event_name`.`USER` is null), 'background',
            `performance_schema`.`memory_summary_by_user_by_event_name`.`USER`)
order by sum(`performance_schema`.`memory_summary_by_user_by_event_name`.`CURRENT_NUMBER_OF_BYTES_USED`) desc;

create definer = `mysql.sys`@localhost view sys.memory_global_by_current_bytes as
	select `performance_schema`.`memory_summary_global_by_event_name`.`EVENT_NAME`                                 AS `event_name`,
       `performance_schema`.`memory_summary_global_by_event_name`.`CURRENT_COUNT_USED`                         AS `current_count`,
       format_bytes(
               `performance_schema`.`memory_summary_global_by_event_name`.`CURRENT_NUMBER_OF_BYTES_USED`)      AS `current_alloc`,
       format_bytes(ifnull((`performance_schema`.`memory_summary_global_by_event_name`.`CURRENT_NUMBER_OF_BYTES_USED` /
                            nullif(`performance_schema`.`memory_summary_global_by_event_name`.`CURRENT_COUNT_USED`, 0)),
                           0))                                                                                 AS `current_avg_alloc`,
       `performance_schema`.`memory_summary_global_by_event_name`.`HIGH_COUNT_USED`                            AS `high_count`,
       format_bytes(
               `performance_schema`.`memory_summary_global_by_event_name`.`HIGH_NUMBER_OF_BYTES_USED`)         AS `high_alloc`,
       format_bytes(ifnull((`performance_schema`.`memory_summary_global_by_event_name`.`HIGH_NUMBER_OF_BYTES_USED` /
                            nullif(`performance_schema`.`memory_summary_global_by_event_name`.`HIGH_COUNT_USED`, 0)),
                           0))                                                                                 AS `high_avg_alloc`
from `performance_schema`.`memory_summary_global_by_event_name`
where (`performance_schema`.`memory_summary_global_by_event_name`.`CURRENT_NUMBER_OF_BYTES_USED` > 0)
order by `performance_schema`.`memory_summary_global_by_event_name`.`CURRENT_NUMBER_OF_BYTES_USED` desc;

create definer = `mysql.sys`@localhost view sys.memory_global_total as
	select format_bytes(sum(
        `performance_schema`.`memory_summary_global_by_event_name`.`CURRENT_NUMBER_OF_BYTES_USED`)) AS `total_allocated`
from `performance_schema`.`memory_summary_global_by_event_name`;

create definer = `mysql.sys`@localhost view sys.metrics as
	select lower(`performance_schema`.`global_status`.`VARIABLE_NAME`) AS `Variable_name`,
       `performance_schema`.`global_status`.`VARIABLE_VALUE`       AS `Variable_value`,
       'Global Status'                                             AS `Type`,
       'YES'                                                       AS `Enabled`
from `performance_schema`.`global_status`
union all
select `information_schema`.`innodb_metrics`.`NAME`                                   AS `Variable_name`,
       `information_schema`.`innodb_metrics`.`COUNT`                                  AS `Variable_value`,
       concat('InnoDB Metrics - ', `information_schema`.`innodb_metrics`.`SUBSYSTEM`) AS `Type`,
       if((`information_schema`.`innodb_metrics`.`STATUS` = 'enabled'), 'YES', 'NO')  AS `Enabled`
from `information_schema`.`INNODB_METRICS`
where (`information_schema`.`innodb_metrics`.`NAME` not in
       ('lock_row_lock_time', 'lock_row_lock_time_avg', 'lock_row_lock_time_max', 'lock_row_lock_waits',
        'buffer_pool_reads', 'buffer_pool_read_requests', 'buffer_pool_write_requests', 'buffer_pool_wait_free',
        'buffer_pool_read_ahead', 'buffer_pool_read_ahead_evicted', 'buffer_pool_pages_total', 'buffer_pool_pages_misc',
        'buffer_pool_pages_data', 'buffer_pool_bytes_data', 'buffer_pool_pages_dirty', 'buffer_pool_bytes_dirty',
        'buffer_pool_pages_free', 'buffer_pages_created', 'buffer_pages_written', 'buffer_pages_read',
        'buffer_data_reads', 'buffer_data_written', 'file_num_open_files', 'os_log_bytes_written', 'os_log_fsyncs',
        'os_log_pending_fsyncs', 'os_log_pending_writes', 'log_waits', 'log_write_requests', 'log_writes',
        'innodb_dblwr_writes', 'innodb_dblwr_pages_written', 'innodb_page_size'))
union all
select 'memory_current_allocated' AS                                                                            `Variable_name`,
       sum(
               `performance_schema`.`memory_summary_global_by_event_name`.`CURRENT_NUMBER_OF_BYTES_USED`) AS    `Variable_value`,
       'Performance Schema' AS                                                                                  `Type`,
       if(((select count(0)
            from `performance_schema`.`setup_instruments`
            where ((`performance_schema`.`setup_instruments`.`NAME` like 'memory/%') and
                   (`performance_schema`.`setup_instruments`.`ENABLED` = 'YES'))) = 0), 'NO', if(((select count(0)
                                                                                                   from `performance_schema`.`setup_instruments`
                                                                                                   where ((`performance_schema`.`setup_instruments`.`NAME` like 'memory/%') and
                                                                                                          (`performance_schema`.`setup_instruments`.`ENABLED` = 'NO'))) =
                                                                                                  0), 'YES',
                                                                                                 'PARTIAL')) AS `Enabled`
from `performance_schema`.`memory_summary_global_by_event_name`
union all
select 'memory_total_allocated'                                                                              AS `Variable_name`,
       sum(
               `performance_schema`.`memory_summary_global_by_event_name`.`SUM_NUMBER_OF_BYTES_ALLOC`)       AS `Variable_value`,
       'Performance Schema'                                                                                  AS `Type`,
       if(((select count(0)
            from `performance_schema`.`setup_instruments`
            where ((`performance_schema`.`setup_instruments`.`NAME` like 'memory/%') and
                   (`performance_schema`.`setup_instruments`.`ENABLED` = 'YES'))) = 0), 'NO', if(((select count(0)
                                                                                                   from `performance_schema`.`setup_instruments`
                                                                                                   where ((`performance_schema`.`setup_instruments`.`NAME` like 'memory/%') and
                                                                                                          (`performance_schema`.`setup_instruments`.`ENABLED` = 'NO'))) =
                                                                                                  0), 'YES',
                                                                                                 'PARTIAL')) AS `Enabled`
from `performance_schema`.`memory_summary_global_by_event_name`
union all
select 'NOW()' AS `Variable_name`, now(3) AS `Variable_value`, 'System Time' AS `Type`, 'YES' AS `Enabled`
union all
select 'UNIX_TIMESTAMP()'               AS `Variable_name`,
       round(unix_timestamp(now(3)), 3) AS `Variable_value`,
       'System Time'                    AS `Type`,
       'YES'                            AS `Enabled`
order by `Type`, `Variable_name`;

create definer = `mysql.sys`@localhost view sys.processlist as
	select `pps`.`THREAD_ID`                                                                        AS `thd_id`,
       `pps`.`PROCESSLIST_ID`                                                                   AS `conn_id`,
       if((`pps`.`NAME` in ('thread/sql/one_connection', 'thread/thread_pool/tp_one_connection')),
          concat(`pps`.`PROCESSLIST_USER`, '@', convert(`pps`.`PROCESSLIST_HOST` using utf8mb4)),
          replace(`pps`.`NAME`, 'thread/', ''))                                                 AS `user`,
       `pps`.`PROCESSLIST_DB`                                                                   AS `db`,
       `pps`.`PROCESSLIST_COMMAND`                                                              AS `command`,
       `pps`.`PROCESSLIST_STATE`                                                                AS `state`,
       `pps`.`PROCESSLIST_TIME`                                                                 AS `time`,
       `sys`.`format_statement`(`pps`.`PROCESSLIST_INFO`)                                       AS `current_statement`,
       `pps`.`EXECUTION_ENGINE`                                                                 AS `execution_engine`,
       if((`esc`.`END_EVENT_ID` is null), format_pico_time(`esc`.`TIMER_WAIT`), NULL)           AS `statement_latency`,
       if((`esc`.`END_EVENT_ID` is null), round((100 * (`estc`.`WORK_COMPLETED` / `estc`.`WORK_ESTIMATED`)), 2),
          NULL)                                                                                 AS `progress`,
       format_pico_time(`esc`.`LOCK_TIME`)                                                      AS `lock_latency`,
       format_pico_time(`esc`.`CPU_TIME`)                                                       AS `cpu_latency`,
       `esc`.`ROWS_EXAMINED`                                                                    AS `rows_examined`,
       `esc`.`ROWS_SENT`                                                                        AS `rows_sent`,
       `esc`.`ROWS_AFFECTED`                                                                    AS `rows_affected`,
       `esc`.`CREATED_TMP_TABLES`                                                               AS `tmp_tables`,
       `esc`.`CREATED_TMP_DISK_TABLES`                                                          AS `tmp_disk_tables`,
       if(((`esc`.`NO_GOOD_INDEX_USED` > 0) or (`esc`.`NO_INDEX_USED` > 0)), 'YES', 'NO')       AS `full_scan`,
       if((`esc`.`END_EVENT_ID` is not null), `sys`.`format_statement`(`esc`.`SQL_TEXT`), NULL) AS `last_statement`,
       if((`esc`.`END_EVENT_ID` is not null), format_pico_time(`esc`.`TIMER_WAIT`),
          NULL)                                                                                 AS `last_statement_latency`,
       format_bytes(`sys`.`mem`.`current_allocated`)                                            AS `current_memory`,
       `ewc`.`EVENT_NAME`                                                                       AS `last_wait`,
       if(((`ewc`.`END_EVENT_ID` is null) and (`ewc`.`EVENT_NAME` is not null)), 'Still Waiting',
          convert(format_pico_time(`ewc`.`TIMER_WAIT`) using utf8mb4))                          AS `last_wait_latency`,
       `ewc`.`SOURCE`                                                                           AS `source`,
       format_pico_time(`etc`.`TIMER_WAIT`)                                                     AS `trx_latency`,
       `etc`.`STATE`                                                                            AS `trx_state`,
       `etc`.`AUTOCOMMIT`                                                                       AS `trx_autocommit`,
       `conattr_pid`.`ATTR_VALUE`                                                               AS `pid`,
       `conattr_progname`.`ATTR_VALUE`                                                          AS `program_name`
from (((((((`performance_schema`.`threads` `pps` left join `performance_schema`.`events_waits_current` `ewc` on ((`pps`.`THREAD_ID` = `ewc`.`THREAD_ID`))) left join `performance_schema`.`events_stages_current` `estc` on ((`pps`.`THREAD_ID` = `estc`.`THREAD_ID`))) left join `performance_schema`.`events_statements_current` `esc` on ((`pps`.`THREAD_ID` = `esc`.`THREAD_ID`))) left join `performance_schema`.`events_transactions_current` `etc` on ((`pps`.`THREAD_ID` = `etc`.`THREAD_ID`))) left join `sys`.`x$memory_by_thread_by_current_bytes` `mem` on ((`pps`.`THREAD_ID` = `sys`.`mem`.`thread_id`))) left join `performance_schema`.`session_connect_attrs` `conattr_pid` on ((
        (`conattr_pid`.`PROCESSLIST_ID` = `pps`.`PROCESSLIST_ID`) and (`conattr_pid`.`ATTR_NAME` = '_pid'))))
         left join `performance_schema`.`session_connect_attrs` `conattr_progname`
                   on (((`conattr_progname`.`PROCESSLIST_ID` = `pps`.`PROCESSLIST_ID`) and
                        (`conattr_progname`.`ATTR_NAME` = 'program_name'))))
order by `pps`.`PROCESSLIST_TIME` desc, `last_wait_latency` desc;

create definer = `mysql.sys`@localhost view sys.ps_check_lost_instrumentation as
	select `performance_schema`.`global_status`.`VARIABLE_NAME`  AS `variable_name`,
       `performance_schema`.`global_status`.`VARIABLE_VALUE` AS `variable_value`
from `performance_schema`.`global_status`
where ((`performance_schema`.`global_status`.`VARIABLE_NAME` like 'perf%lost') and
       (`performance_schema`.`global_status`.`VARIABLE_VALUE` > 0));

create definer = `mysql.sys`@localhost view sys.schema_auto_increment_columns as
	select `information_schema`.`columns`.`TABLE_SCHEMA`                                      AS `TABLE_SCHEMA`,
       `information_schema`.`columns`.`TABLE_NAME`                                        AS `TABLE_NAME`,
       `information_schema`.`columns`.`COLUMN_NAME`                                       AS `COLUMN_NAME`,
       `information_schema`.`columns`.`DATA_TYPE`                                         AS `DATA_TYPE`,
       `information_schema`.`columns`.`COLUMN_TYPE`                                       AS `COLUMN_TYPE`,
       (locate('unsigned', `information_schema`.`columns`.`COLUMN_TYPE`) = 0)             AS `is_signed`,
       (locate('unsigned', `information_schema`.`columns`.`COLUMN_TYPE`) > 0)             AS `is_unsigned`,
       ((case `information_schema`.`columns`.`DATA_TYPE`
             when 'tinyint' then 255
             when 'smallint' then 65535
             when 'mediumint' then 16777215
             when 'int' then 4294967295
             when 'bigint' then 18446744073709551615 end) >>
        if((locate('unsigned', `information_schema`.`columns`.`COLUMN_TYPE`) > 0), 0, 1)) AS `max_value`,
       `information_schema`.`tables`.`AUTO_INCREMENT`                                     AS `AUTO_INCREMENT`,
       (`information_schema`.`tables`.`AUTO_INCREMENT` / ((case `information_schema`.`columns`.`DATA_TYPE`
                                                               when 'tinyint' then 255
                                                               when 'smallint' then 65535
                                                               when 'mediumint' then 16777215
                                                               when 'int' then 4294967295
                                                               when 'bigint' then 18446744073709551615 end) >> if(
                                                                  (locate('unsigned', `information_schema`.`columns`.`COLUMN_TYPE`) > 0),
                                                                  0, 1)))                 AS `auto_increment_ratio`
from (`information_schema`.`COLUMNS`
         join `information_schema`.`TABLES`
              on (((`information_schema`.`columns`.`TABLE_SCHEMA` = `information_schema`.`tables`.`TABLE_SCHEMA`) and
                   (`information_schema`.`columns`.`TABLE_NAME` = `information_schema`.`tables`.`TABLE_NAME`))))
where ((`information_schema`.`columns`.`TABLE_SCHEMA` not in
        ('mysql', 'sys', 'INFORMATION_SCHEMA', 'performance_schema')) and
       (`information_schema`.`tables`.`TABLE_TYPE` = 'BASE TABLE') and
       (`information_schema`.`columns`.`EXTRA` = 'auto_increment'))
order by (`information_schema`.`tables`.`AUTO_INCREMENT` / ((case `information_schema`.`columns`.`DATA_TYPE`
                                                                 when 'tinyint' then 255
                                                                 when 'smallint' then 65535
                                                                 when 'mediumint' then 16777215
                                                                 when 'int' then 4294967295
                                                                 when 'bigint' then 18446744073709551615 end) >> if(
                                                                    (locate('unsigned', `information_schema`.`columns`.`COLUMN_TYPE`) > 0),
                                                                    0, 1))) desc,
         ((case `information_schema`.`columns`.`DATA_TYPE`
               when 'tinyint' then 255
               when 'smallint' then 65535
               when 'mediumint' then 16777215
               when 'int' then 4294967295
               when 'bigint' then 18446744073709551615 end) >>
          if((locate('unsigned', `information_schema`.`columns`.`COLUMN_TYPE`) > 0), 0, 1));

create definer = `mysql.sys`@localhost view sys.schema_index_statistics as
	select `performance_schema`.`table_io_waits_summary_by_index_usage`.`OBJECT_SCHEMA`                      AS `table_schema`,
       `performance_schema`.`table_io_waits_summary_by_index_usage`.`OBJECT_NAME`                        AS `table_name`,
       `performance_schema`.`table_io_waits_summary_by_index_usage`.`INDEX_NAME`                         AS `index_name`,
       `performance_schema`.`table_io_waits_summary_by_index_usage`.`COUNT_FETCH`                        AS `rows_selected`,
       format_pico_time(
               `performance_schema`.`table_io_waits_summary_by_index_usage`.`SUM_TIMER_FETCH`)           AS `select_latency`,
       `performance_schema`.`table_io_waits_summary_by_index_usage`.`COUNT_INSERT`                       AS `rows_inserted`,
       format_pico_time(
               `performance_schema`.`table_io_waits_summary_by_index_usage`.`SUM_TIMER_INSERT`)          AS `insert_latency`,
       `performance_schema`.`table_io_waits_summary_by_index_usage`.`COUNT_UPDATE`                       AS `rows_updated`,
       format_pico_time(
               `performance_schema`.`table_io_waits_summary_by_index_usage`.`SUM_TIMER_UPDATE`)          AS `update_latency`,
       `performance_schema`.`table_io_waits_summary_by_index_usage`.`COUNT_DELETE`                       AS `rows_deleted`,
       format_pico_time(
               `performance_schema`.`table_io_waits_summary_by_index_usage`.`SUM_TIMER_DELETE`)          AS `delete_latency`
from `performance_schema`.`table_io_waits_summary_by_index_usage`
where (`performance_schema`.`table_io_waits_summary_by_index_usage`.`INDEX_NAME` is not null)
order by `performance_schema`.`table_io_waits_summary_by_index_usage`.`SUM_TIMER_WAIT` desc;

create definer = `mysql.sys`@localhost view sys.schema_object_overview as
	select `information_schema`.`routines`.`ROUTINE_SCHEMA` AS `db`,
       `information_schema`.`routines`.`ROUTINE_TYPE`   AS `object_type`,
       count(0)                                         AS `count`
from `information_schema`.`ROUTINES`
group by `information_schema`.`routines`.`ROUTINE_SCHEMA`, `information_schema`.`routines`.`ROUTINE_TYPE`
union
select `information_schema`.`tables`.`TABLE_SCHEMA` AS `TABLE_SCHEMA`,
       `information_schema`.`tables`.`TABLE_TYPE`   AS `TABLE_TYPE`,
       count(0)                                     AS `COUNT(*)`
from `information_schema`.`TABLES`
group by `information_schema`.`tables`.`TABLE_SCHEMA`, `information_schema`.`tables`.`TABLE_TYPE`
union
select `information_schema`.`statistics`.`TABLE_SCHEMA`                       AS `TABLE_SCHEMA`,
       concat('INDEX (', `information_schema`.`statistics`.`INDEX_TYPE`, ')') AS `CONCAT('INDEX (', INDEX_TYPE, ')')`,
       count(0)                                                               AS `COUNT(*)`
from `information_schema`.`STATISTICS`
group by `information_schema`.`statistics`.`TABLE_SCHEMA`, `information_schema`.`statistics`.`INDEX_TYPE`
union
select `information_schema`.`triggers`.`TRIGGER_SCHEMA` AS `TRIGGER_SCHEMA`,
       'TRIGGER'                                        AS `TRIGGER`,
       count(0)                                         AS `COUNT(*)`
from `information_schema`.`TRIGGERS`
group by `information_schema`.`triggers`.`TRIGGER_SCHEMA`
union
select `information_schema`.`events`.`EVENT_SCHEMA` AS `EVENT_SCHEMA`, 'EVENT' AS `EVENT`, count(0) AS `COUNT(*)`
from `information_schema`.`EVENTS`
group by `information_schema`.`events`.`EVENT_SCHEMA`
order by `db`, `object_type`;

create definer = `mysql.sys`@localhost view sys.schema_redundant_indexes as
	select `sys`.`redundant_keys`.`table_schema`                                                                       AS `table_schema`,
       `sys`.`redundant_keys`.`table_name`                                                                         AS `table_name`,
       `sys`.`redundant_keys`.`index_name`                                                                         AS `redundant_index_name`,
       `sys`.`redundant_keys`.`index_columns`                                                                      AS `redundant_index_columns`,
       `sys`.`redundant_keys`.`non_unique`                                                                         AS `redundant_index_non_unique`,
       `sys`.`dominant_keys`.`index_name`                                                                          AS `dominant_index_name`,
       `sys`.`dominant_keys`.`index_columns`                                                                       AS `dominant_index_columns`,
       `sys`.`dominant_keys`.`non_unique`                                                                          AS `dominant_index_non_unique`,
       if(((0 <> `sys`.`redundant_keys`.`subpart_exists`) or (0 <> `sys`.`dominant_keys`.`subpart_exists`)), 1,
          0)                                                                                                       AS `subpart_exists`,
       concat('ALTER TABLE `', `sys`.`redundant_keys`.`table_schema`, '`.`', `sys`.`redundant_keys`.`table_name`,
              '` DROP INDEX `', `sys`.`redundant_keys`.`index_name`,
              '`')                                                                                                 AS `sql_drop_index`
from (`sys`.`x$schema_flattened_keys` `redundant_keys`
         join `sys`.`x$schema_flattened_keys` `dominant_keys`
              on (((`sys`.`redundant_keys`.`table_schema` = `sys`.`dominant_keys`.`table_schema`) and
                   (`sys`.`redundant_keys`.`table_name` = `sys`.`dominant_keys`.`table_name`))))
where ((`sys`.`redundant_keys`.`index_name` <> `sys`.`dominant_keys`.`index_name`) and
       (((`sys`.`redundant_keys`.`index_columns` = `sys`.`dominant_keys`.`index_columns`) and
         ((`sys`.`redundant_keys`.`non_unique` > `sys`.`dominant_keys`.`non_unique`) or
          ((`sys`.`redundant_keys`.`non_unique` = `sys`.`dominant_keys`.`non_unique`) and
           (if((`sys`.`redundant_keys`.`index_name` = 'PRIMARY'), '', `sys`.`redundant_keys`.`index_name`) >
            if((`sys`.`dominant_keys`.`index_name` = 'PRIMARY'), '', `sys`.`dominant_keys`.`index_name`))))) or
        ((locate(concat(`sys`.`redundant_keys`.`index_columns`, ','), `sys`.`dominant_keys`.`index_columns`) = 1) and
         (`sys`.`redundant_keys`.`non_unique` = 1)) or
        ((locate(concat(`sys`.`dominant_keys`.`index_columns`, ','), `sys`.`redundant_keys`.`index_columns`) = 1) and
         (`sys`.`dominant_keys`.`non_unique` = 0))));

create definer = `mysql.sys`@localhost view sys.schema_table_lock_waits as
	select `g`.`OBJECT_SCHEMA`                               AS `object_schema`,
       `g`.`OBJECT_NAME`                                 AS `object_name`,
       `pt`.`THREAD_ID`                                  AS `waiting_thread_id`,
       `pt`.`PROCESSLIST_ID`                             AS `waiting_pid`,
       `sys`.`ps_thread_account`(`p`.`OWNER_THREAD_ID`)  AS `waiting_account`,
       `p`.`LOCK_TYPE`                                   AS `waiting_lock_type`,
       `p`.`LOCK_DURATION`                               AS `waiting_lock_duration`,
       `sys`.`format_statement`(`pt`.`PROCESSLIST_INFO`) AS `waiting_query`,
       `pt`.`PROCESSLIST_TIME`                           AS `waiting_query_secs`,
       `ps`.`ROWS_AFFECTED`                              AS `waiting_query_rows_affected`,
       `ps`.`ROWS_EXAMINED`                              AS `waiting_query_rows_examined`,
       `gt`.`THREAD_ID`                                  AS `blocking_thread_id`,
       `gt`.`PROCESSLIST_ID`                             AS `blocking_pid`,
       `sys`.`ps_thread_account`(`g`.`OWNER_THREAD_ID`)  AS `blocking_account`,
       `g`.`LOCK_TYPE`                                   AS `blocking_lock_type`,
       `g`.`LOCK_DURATION`                               AS `blocking_lock_duration`,
       concat('KILL QUERY ', `gt`.`PROCESSLIST_ID`)      AS `sql_kill_blocking_query`,
       concat('KILL ', `gt`.`PROCESSLIST_ID`)            AS `sql_kill_blocking_connection`
from (((((`performance_schema`.`metadata_locks` `g` join `performance_schema`.`metadata_locks` `p` on ((
        (`g`.`OBJECT_TYPE` = `p`.`OBJECT_TYPE`) and (`g`.`OBJECT_SCHEMA` = `p`.`OBJECT_SCHEMA`) and
        (`g`.`OBJECT_NAME` = `p`.`OBJECT_NAME`) and (`g`.`LOCK_STATUS` = 'GRANTED') and
        (`p`.`LOCK_STATUS` = 'PENDING')))) join `performance_schema`.`threads` `gt` on ((`g`.`OWNER_THREAD_ID` = `gt`.`THREAD_ID`))) join `performance_schema`.`threads` `pt` on ((`p`.`OWNER_THREAD_ID` = `pt`.`THREAD_ID`))) left join `performance_schema`.`events_statements_current` `gs` on ((`g`.`OWNER_THREAD_ID` = `gs`.`THREAD_ID`)))
         left join `performance_schema`.`events_statements_current` `ps` on ((`p`.`OWNER_THREAD_ID` = `ps`.`THREAD_ID`)))
where (`g`.`OBJECT_TYPE` = 'TABLE');

create definer = `mysql.sys`@localhost view sys.schema_table_statistics as
	select `pst`.`OBJECT_SCHEMA`                                  AS `table_schema`,
       `pst`.`OBJECT_NAME`                                    AS `table_name`,
       format_pico_time(`pst`.`SUM_TIMER_WAIT`)               AS `total_latency`,
       `pst`.`COUNT_FETCH`                                    AS `rows_fetched`,
       format_pico_time(`pst`.`SUM_TIMER_FETCH`)              AS `fetch_latency`,
       `pst`.`COUNT_INSERT`                                   AS `rows_inserted`,
       format_pico_time(`pst`.`SUM_TIMER_INSERT`)             AS `insert_latency`,
       `pst`.`COUNT_UPDATE`                                   AS `rows_updated`,
       format_pico_time(`pst`.`SUM_TIMER_UPDATE`)             AS `update_latency`,
       `pst`.`COUNT_DELETE`                                   AS `rows_deleted`,
       format_pico_time(`pst`.`SUM_TIMER_DELETE`)             AS `delete_latency`,
       `sys`.`fsbi`.`count_read`                              AS `io_read_requests`,
       format_bytes(`sys`.`fsbi`.`sum_number_of_bytes_read`)  AS `io_read`,
       format_pico_time(`sys`.`fsbi`.`sum_timer_read`)        AS `io_read_latency`,
       `sys`.`fsbi`.`count_write`                             AS `io_write_requests`,
       format_bytes(`sys`.`fsbi`.`sum_number_of_bytes_write`) AS `io_write`,
       format_pico_time(`sys`.`fsbi`.`sum_timer_write`)       AS `io_write_latency`,
       `sys`.`fsbi`.`count_misc`                              AS `io_misc_requests`,
       format_pico_time(`sys`.`fsbi`.`sum_timer_misc`)        AS `io_misc_latency`
from (`performance_schema`.`table_io_waits_summary_by_table` `pst`
         left join `sys`.`x$ps_schema_table_statistics_io` `fsbi`
                   on (((`pst`.`OBJECT_SCHEMA` = `sys`.`fsbi`.`table_schema`) and
                        (`pst`.`OBJECT_NAME` = `sys`.`fsbi`.`table_name`))))
order by `pst`.`SUM_TIMER_WAIT` desc;

create definer = `mysql.sys`@localhost view sys.schema_table_statistics_with_buffer as
	select `pst`.`OBJECT_SCHEMA`                                        AS `table_schema`,
       `pst`.`OBJECT_NAME`                                          AS `table_name`,
       `pst`.`COUNT_FETCH`                                          AS `rows_fetched`,
       format_pico_time(`pst`.`SUM_TIMER_FETCH`)                    AS `fetch_latency`,
       `pst`.`COUNT_INSERT`                                         AS `rows_inserted`,
       format_pico_time(`pst`.`SUM_TIMER_INSERT`)                   AS `insert_latency`,
       `pst`.`COUNT_UPDATE`                                         AS `rows_updated`,
       format_pico_time(`pst`.`SUM_TIMER_UPDATE`)                   AS `update_latency`,
       `pst`.`COUNT_DELETE`                                         AS `rows_deleted`,
       format_pico_time(`pst`.`SUM_TIMER_DELETE`)                   AS `delete_latency`,
       `sys`.`fsbi`.`count_read`                                    AS `io_read_requests`,
       format_bytes(`sys`.`fsbi`.`sum_number_of_bytes_read`)        AS `io_read`,
       format_pico_time(`sys`.`fsbi`.`sum_timer_read`)              AS `io_read_latency`,
       `sys`.`fsbi`.`count_write`                                   AS `io_write_requests`,
       format_bytes(`sys`.`fsbi`.`sum_number_of_bytes_write`)       AS `io_write`,
       format_pico_time(`sys`.`fsbi`.`sum_timer_write`)             AS `io_write_latency`,
       `sys`.`fsbi`.`count_misc`                                    AS `io_misc_requests`,
       format_pico_time(`sys`.`fsbi`.`sum_timer_misc`)              AS `io_misc_latency`,
       format_bytes(`sys`.`ibp`.`allocated`)                        AS `innodb_buffer_allocated`,
       format_bytes(`sys`.`ibp`.`data`)                             AS `innodb_buffer_data`,
       format_bytes((`sys`.`ibp`.`allocated` - `sys`.`ibp`.`data`)) AS `innodb_buffer_free`,
       `sys`.`ibp`.`pages`                                          AS `innodb_buffer_pages`,
       `sys`.`ibp`.`pages_hashed`                                   AS `innodb_buffer_pages_hashed`,
       `sys`.`ibp`.`pages_old`                                      AS `innodb_buffer_pages_old`,
       `sys`.`ibp`.`rows_cached`                                    AS `innodb_buffer_rows_cached`
from ((`performance_schema`.`table_io_waits_summary_by_table` `pst` left join `sys`.`x$ps_schema_table_statistics_io` `fsbi` on ((
        (`pst`.`OBJECT_SCHEMA` = `sys`.`fsbi`.`table_schema`) and (`pst`.`OBJECT_NAME` = `sys`.`fsbi`.`table_name`))))
         left join `sys`.`x$innodb_buffer_stats_by_table` `ibp`
                   on (((`pst`.`OBJECT_SCHEMA` = `sys`.`ibp`.`object_schema`) and
                        (`pst`.`OBJECT_NAME` = `sys`.`ibp`.`object_name`))))
order by `pst`.`SUM_TIMER_WAIT` desc;

create definer = `mysql.sys`@localhost view sys.schema_tables_with_full_table_scans as
	select `performance_schema`.`table_io_waits_summary_by_index_usage`.`OBJECT_SCHEMA`                    AS `object_schema`,
       `performance_schema`.`table_io_waits_summary_by_index_usage`.`OBJECT_NAME`                      AS `object_name`,
       `performance_schema`.`table_io_waits_summary_by_index_usage`.`COUNT_READ`                       AS `rows_full_scanned`,
       format_pico_time(`performance_schema`.`table_io_waits_summary_by_index_usage`.`SUM_TIMER_WAIT`) AS `latency`
from `performance_schema`.`table_io_waits_summary_by_index_usage`
where ((`performance_schema`.`table_io_waits_summary_by_index_usage`.`INDEX_NAME` is null) and
       (`performance_schema`.`table_io_waits_summary_by_index_usage`.`COUNT_READ` > 0))
order by `performance_schema`.`table_io_waits_summary_by_index_usage`.`COUNT_READ` desc;

create definer = `mysql.sys`@localhost view sys.schema_unused_indexes as
	select `t`.`OBJECT_SCHEMA` AS `object_schema`, `t`.`OBJECT_NAME` AS `object_name`, `t`.`INDEX_NAME` AS `index_name`
from (`performance_schema`.`table_io_waits_summary_by_index_usage` `t`
         join `information_schema`.`STATISTICS` `s`
              on (((`t`.`OBJECT_SCHEMA` = `information_schema`.`s`.`TABLE_SCHEMA`) and
                   (`t`.`OBJECT_NAME` = `information_schema`.`s`.`TABLE_NAME`) and
                   (`t`.`INDEX_NAME` = `information_schema`.`s`.`INDEX_NAME`))))
where ((`t`.`INDEX_NAME` is not null) and (`t`.`COUNT_STAR` = 0) and (`t`.`OBJECT_SCHEMA` <> 'mysql') and
       (`t`.`INDEX_NAME` <> 'PRIMARY') and (`information_schema`.`s`.`NON_UNIQUE` = 1) and
       (`information_schema`.`s`.`SEQ_IN_INDEX` = 1))
order by `t`.`OBJECT_SCHEMA`, `t`.`OBJECT_NAME`;

create definer = `mysql.sys`@localhost view sys.session as
	select `sys`.`processlist`.`thd_id`                 AS `thd_id`,
       `sys`.`processlist`.`conn_id`                AS `conn_id`,
       `sys`.`processlist`.`user`                   AS `user`,
       `sys`.`processlist`.`db`                     AS `db`,
       `sys`.`processlist`.`command`                AS `command`,
       `sys`.`processlist`.`state`                  AS `state`,
       `sys`.`processlist`.`time`                   AS `time`,
       `sys`.`processlist`.`current_statement`      AS `current_statement`,
       `sys`.`processlist`.`execution_engine`       AS `execution_engine`,
       `sys`.`processlist`.`statement_latency`      AS `statement_latency`,
       `sys`.`processlist`.`progress`               AS `progress`,
       `sys`.`processlist`.`lock_latency`           AS `lock_latency`,
       `sys`.`processlist`.`cpu_latency`            AS `cpu_latency`,
       `sys`.`processlist`.`rows_examined`          AS `rows_examined`,
       `sys`.`processlist`.`rows_sent`              AS `rows_sent`,
       `sys`.`processlist`.`rows_affected`          AS `rows_affected`,
       `sys`.`processlist`.`tmp_tables`             AS `tmp_tables`,
       `sys`.`processlist`.`tmp_disk_tables`        AS `tmp_disk_tables`,
       `sys`.`processlist`.`full_scan`              AS `full_scan`,
       `sys`.`processlist`.`last_statement`         AS `last_statement`,
       `sys`.`processlist`.`last_statement_latency` AS `last_statement_latency`,
       `sys`.`processlist`.`current_memory`         AS `current_memory`,
       `sys`.`processlist`.`last_wait`              AS `last_wait`,
       `sys`.`processlist`.`last_wait_latency`      AS `last_wait_latency`,
       `sys`.`processlist`.`source`                 AS `source`,
       `sys`.`processlist`.`trx_latency`            AS `trx_latency`,
       `sys`.`processlist`.`trx_state`              AS `trx_state`,
       `sys`.`processlist`.`trx_autocommit`         AS `trx_autocommit`,
       `sys`.`processlist`.`pid`                    AS `pid`,
       `sys`.`processlist`.`program_name`           AS `program_name`
from `sys`.`processlist`
where ((`sys`.`processlist`.`conn_id` is not null) and (`sys`.`processlist`.`command` <> 'Daemon'));

create definer = `mysql.sys`@localhost view sys.session_ssl_status as
	select `sslver`.`THREAD_ID`        AS `thread_id`,
       `sslver`.`VARIABLE_VALUE`   AS `ssl_version`,
       `sslcip`.`VARIABLE_VALUE`   AS `ssl_cipher`,
       `sslreuse`.`VARIABLE_VALUE` AS `ssl_sessions_reused`
from ((`performance_schema`.`status_by_thread` `sslver` left join `performance_schema`.`status_by_thread` `sslcip` on ((
        (`sslcip`.`THREAD_ID` = `sslver`.`THREAD_ID`) and (`sslcip`.`VARIABLE_NAME` = 'Ssl_cipher'))))
         left join `performance_schema`.`status_by_thread` `sslreuse`
                   on (((`sslreuse`.`THREAD_ID` = `sslver`.`THREAD_ID`) and
                        (`sslreuse`.`VARIABLE_NAME` = 'Ssl_sessions_reused'))))
where (`sslver`.`VARIABLE_NAME` = 'Ssl_version');

create definer = `mysql.sys`@localhost view sys.statement_analysis as
	select `sys`.`format_statement`(`performance_schema`.`events_statements_summary_by_digest`.`DIGEST_TEXT`)        AS `query`,
       `performance_schema`.`events_statements_summary_by_digest`.`SCHEMA_NAME`                                  AS `db`,
       if(((`performance_schema`.`events_statements_summary_by_digest`.`SUM_NO_GOOD_INDEX_USED` > 0) or
           (`performance_schema`.`events_statements_summary_by_digest`.`SUM_NO_INDEX_USED` > 0)), '*',
          '')                                                                                                    AS `full_scan`,
       `performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`                                   AS `exec_count`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_ERRORS`                                   AS `err_count`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_WARNINGS`                                 AS `warn_count`,
       format_pico_time(
               `performance_schema`.`events_statements_summary_by_digest`.`SUM_TIMER_WAIT`)                      AS `total_latency`,
       format_pico_time(
               `performance_schema`.`events_statements_summary_by_digest`.`MAX_TIMER_WAIT`)                      AS `max_latency`,
       format_pico_time(
               `performance_schema`.`events_statements_summary_by_digest`.`AVG_TIMER_WAIT`)                      AS `avg_latency`,
       format_pico_time(
               `performance_schema`.`events_statements_summary_by_digest`.`SUM_LOCK_TIME`)                       AS `lock_latency`,
       format_pico_time(
               `performance_schema`.`events_statements_summary_by_digest`.`SUM_CPU_TIME`)                        AS `cpu_latency`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_ROWS_SENT`                                AS `rows_sent`,
       round(ifnull((`performance_schema`.`events_statements_summary_by_digest`.`SUM_ROWS_SENT` /
                     nullif(`performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`, 0)), 0),
             0)                                                                                                  AS `rows_sent_avg`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_ROWS_EXAMINED`                            AS `rows_examined`,
       round(ifnull((`performance_schema`.`events_statements_summary_by_digest`.`SUM_ROWS_EXAMINED` /
                     nullif(`performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`, 0)), 0),
             0)                                                                                                  AS `rows_examined_avg`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_ROWS_AFFECTED`                            AS `rows_affected`,
       round(ifnull((`performance_schema`.`events_statements_summary_by_digest`.`SUM_ROWS_AFFECTED` /
                     nullif(`performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`, 0)), 0),
             0)                                                                                                  AS `rows_affected_avg`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_CREATED_TMP_TABLES`                       AS `tmp_tables`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_CREATED_TMP_DISK_TABLES`                  AS `tmp_disk_tables`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_SORT_ROWS`                                AS `rows_sorted`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_SORT_MERGE_PASSES`                        AS `sort_merge_passes`,
       format_bytes(
               `performance_schema`.`events_statements_summary_by_digest`.`MAX_CONTROLLED_MEMORY`)               AS `max_controlled_memory`,
       format_bytes(
               `performance_schema`.`events_statements_summary_by_digest`.`MAX_TOTAL_MEMORY`)                    AS `max_total_memory`,
       `performance_schema`.`events_statements_summary_by_digest`.`DIGEST`                                       AS `digest`,
       `performance_schema`.`events_statements_summary_by_digest`.`FIRST_SEEN`                                   AS `first_seen`,
       `performance_schema`.`events_statements_summary_by_digest`.`LAST_SEEN`                                    AS `last_seen`
from `performance_schema`.`events_statements_summary_by_digest`
order by `performance_schema`.`events_statements_summary_by_digest`.`SUM_TIMER_WAIT` desc;

create definer = `mysql.sys`@localhost view sys.statements_with_errors_or_warnings as
	select `sys`.`format_statement`(`performance_schema`.`events_statements_summary_by_digest`.`DIGEST_TEXT`)      AS `query`,
       `performance_schema`.`events_statements_summary_by_digest`.`SCHEMA_NAME`                                AS `db`,
       `performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`                                 AS `exec_count`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_ERRORS`                                 AS `errors`,
       (ifnull((`performance_schema`.`events_statements_summary_by_digest`.`SUM_ERRORS` /
                nullif(`performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`, 0)), 0) *
        100)                                                                                                   AS `error_pct`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_WARNINGS`                               AS `warnings`,
       (ifnull((`performance_schema`.`events_statements_summary_by_digest`.`SUM_WARNINGS` /
                nullif(`performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`, 0)), 0) *
        100)                                                                                                   AS `warning_pct`,
       `performance_schema`.`events_statements_summary_by_digest`.`FIRST_SEEN`                                 AS `first_seen`,
       `performance_schema`.`events_statements_summary_by_digest`.`LAST_SEEN`                                  AS `last_seen`,
       `performance_schema`.`events_statements_summary_by_digest`.`DIGEST`                                     AS `digest`
from `performance_schema`.`events_statements_summary_by_digest`
where ((`performance_schema`.`events_statements_summary_by_digest`.`SUM_ERRORS` > 0) or
       (`performance_schema`.`events_statements_summary_by_digest`.`SUM_WARNINGS` > 0))
order by `performance_schema`.`events_statements_summary_by_digest`.`SUM_ERRORS` desc,
         `performance_schema`.`events_statements_summary_by_digest`.`SUM_WARNINGS` desc;

create definer = `mysql.sys`@localhost view sys.statements_with_full_table_scans as
	select `sys`.`format_statement`(`performance_schema`.`events_statements_summary_by_digest`.`DIGEST_TEXT`) AS `query`,
       `performance_schema`.`events_statements_summary_by_digest`.`SCHEMA_NAME`                           AS `db`,
       `performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`                            AS `exec_count`,
       format_pico_time(
               `performance_schema`.`events_statements_summary_by_digest`.`SUM_TIMER_WAIT`)               AS `total_latency`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_NO_INDEX_USED`                     AS `no_index_used_count`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_NO_GOOD_INDEX_USED`                AS `no_good_index_used_count`,
       round((ifnull((`performance_schema`.`events_statements_summary_by_digest`.`SUM_NO_INDEX_USED` /
                      nullif(`performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`, 0)), 0) * 100),
             0)                                                                                           AS `no_index_used_pct`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_ROWS_SENT`                         AS `rows_sent`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_ROWS_EXAMINED`                     AS `rows_examined`,
       round((`performance_schema`.`events_statements_summary_by_digest`.`SUM_ROWS_SENT` /
              `performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`),
             0)                                                                                           AS `rows_sent_avg`,
       round((`performance_schema`.`events_statements_summary_by_digest`.`SUM_ROWS_EXAMINED` /
              `performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`),
             0)                                                                                           AS `rows_examined_avg`,
       `performance_schema`.`events_statements_summary_by_digest`.`FIRST_SEEN`                            AS `first_seen`,
       `performance_schema`.`events_statements_summary_by_digest`.`LAST_SEEN`                             AS `last_seen`,
       `performance_schema`.`events_statements_summary_by_digest`.`DIGEST`                                AS `digest`
from `performance_schema`.`events_statements_summary_by_digest`
where (((`performance_schema`.`events_statements_summary_by_digest`.`SUM_NO_INDEX_USED` > 0) or
        (`performance_schema`.`events_statements_summary_by_digest`.`SUM_NO_GOOD_INDEX_USED` > 0)) and
       (not ((`performance_schema`.`events_statements_summary_by_digest`.`DIGEST_TEXT` like 'SHOW%'))))
order by round((ifnull((`performance_schema`.`events_statements_summary_by_digest`.`SUM_NO_INDEX_USED` /
                        nullif(`performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`, 0)), 0) * 100),
               0) desc,
         format_pico_time(`performance_schema`.`events_statements_summary_by_digest`.`SUM_TIMER_WAIT`) desc;

create definer = `mysql.sys`@localhost view sys.statements_with_runtimes_in_95th_percentile as
	select `sys`.`format_statement`(`stmts`.`DIGEST_TEXT`)                                            AS `query`,
       `stmts`.`SCHEMA_NAME`                                                                      AS `db`,
       if(((`stmts`.`SUM_NO_GOOD_INDEX_USED` > 0) or (`stmts`.`SUM_NO_INDEX_USED` > 0)), '*', '') AS `full_scan`,
       `stmts`.`COUNT_STAR`                                                                       AS `exec_count`,
       `stmts`.`SUM_ERRORS`                                                                       AS `err_count`,
       `stmts`.`SUM_WARNINGS`                                                                     AS `warn_count`,
       format_pico_time(`stmts`.`SUM_TIMER_WAIT`)                                                 AS `total_latency`,
       format_pico_time(`stmts`.`MAX_TIMER_WAIT`)                                                 AS `max_latency`,
       format_pico_time(`stmts`.`AVG_TIMER_WAIT`)                                                 AS `avg_latency`,
       `stmts`.`SUM_ROWS_SENT`                                                                    AS `rows_sent`,
       round(ifnull((`stmts`.`SUM_ROWS_SENT` / nullif(`stmts`.`COUNT_STAR`, 0)), 0), 0)           AS `rows_sent_avg`,
       `stmts`.`SUM_ROWS_EXAMINED`                                                                AS `rows_examined`,
       round(ifnull((`stmts`.`SUM_ROWS_EXAMINED` / nullif(`stmts`.`COUNT_STAR`, 0)), 0),
             0)                                                                                   AS `rows_examined_avg`,
       `stmts`.`FIRST_SEEN`                                                                       AS `first_seen`,
       `stmts`.`LAST_SEEN`                                                                        AS `last_seen`,
       `stmts`.`DIGEST`                                                                           AS `digest`
from (`performance_schema`.`events_statements_summary_by_digest` `stmts`
         join `sys`.`x$ps_digest_95th_percentile_by_avg_us` `top_percentile`
              on ((round((`stmts`.`AVG_TIMER_WAIT` / 1000000), 0) >= `sys`.`top_percentile`.`avg_us`)))
order by `stmts`.`AVG_TIMER_WAIT` desc;

create definer = `mysql.sys`@localhost view sys.statements_with_sorting as
	select `sys`.`format_statement`(`performance_schema`.`events_statements_summary_by_digest`.`DIGEST_TEXT`)        AS `query`,
       `performance_schema`.`events_statements_summary_by_digest`.`SCHEMA_NAME`                                  AS `db`,
       `performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`                                   AS `exec_count`,
       format_pico_time(
               `performance_schema`.`events_statements_summary_by_digest`.`SUM_TIMER_WAIT`)                      AS `total_latency`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_SORT_MERGE_PASSES`                        AS `sort_merge_passes`,
       round(ifnull((`performance_schema`.`events_statements_summary_by_digest`.`SUM_SORT_MERGE_PASSES` /
                     nullif(`performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`, 0)), 0),
             0)                                                                                                  AS `avg_sort_merges`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_SORT_SCAN`                                AS `sorts_using_scans`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_SORT_RANGE`                               AS `sort_using_range`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_SORT_ROWS`                                AS `rows_sorted`,
       round(ifnull((`performance_schema`.`events_statements_summary_by_digest`.`SUM_SORT_ROWS` /
                     nullif(`performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`, 0)), 0),
             0)                                                                                                  AS `avg_rows_sorted`,
       `performance_schema`.`events_statements_summary_by_digest`.`FIRST_SEEN`                                   AS `first_seen`,
       `performance_schema`.`events_statements_summary_by_digest`.`LAST_SEEN`                                    AS `last_seen`,
       `performance_schema`.`events_statements_summary_by_digest`.`DIGEST`                                       AS `digest`
from `performance_schema`.`events_statements_summary_by_digest`
where (`performance_schema`.`events_statements_summary_by_digest`.`SUM_SORT_ROWS` > 0)
order by `performance_schema`.`events_statements_summary_by_digest`.`SUM_TIMER_WAIT` desc;

create definer = `mysql.sys`@localhost view sys.statements_with_temp_tables as
	select `sys`.`format_statement`(`performance_schema`.`events_statements_summary_by_digest`.`DIGEST_TEXT`)        AS `query`,
       `performance_schema`.`events_statements_summary_by_digest`.`SCHEMA_NAME`                                  AS `db`,
       `performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`                                   AS `exec_count`,
       format_pico_time(
               `performance_schema`.`events_statements_summary_by_digest`.`SUM_TIMER_WAIT`)                      AS `total_latency`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_CREATED_TMP_TABLES`                       AS `memory_tmp_tables`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_CREATED_TMP_DISK_TABLES`                  AS `disk_tmp_tables`,
       round(ifnull((`performance_schema`.`events_statements_summary_by_digest`.`SUM_CREATED_TMP_TABLES` /
                     nullif(`performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`, 0)), 0),
             0)                                                                                                  AS `avg_tmp_tables_per_query`,
       round((ifnull((`performance_schema`.`events_statements_summary_by_digest`.`SUM_CREATED_TMP_DISK_TABLES` /
                      nullif(`performance_schema`.`events_statements_summary_by_digest`.`SUM_CREATED_TMP_TABLES`, 0)),
                     0) * 100),
             0)                                                                                                  AS `tmp_tables_to_disk_pct`,
       `performance_schema`.`events_statements_summary_by_digest`.`FIRST_SEEN`                                   AS `first_seen`,
       `performance_schema`.`events_statements_summary_by_digest`.`LAST_SEEN`                                    AS `last_seen`,
       `performance_schema`.`events_statements_summary_by_digest`.`DIGEST`                                       AS `digest`
from `performance_schema`.`events_statements_summary_by_digest`
where (`performance_schema`.`events_statements_summary_by_digest`.`SUM_CREATED_TMP_TABLES` > 0)
order by `performance_schema`.`events_statements_summary_by_digest`.`SUM_CREATED_TMP_DISK_TABLES` desc,
         `performance_schema`.`events_statements_summary_by_digest`.`SUM_CREATED_TMP_TABLES` desc;

create definer = `mysql.sys`@localhost view sys.user_summary as
	select if((`performance_schema`.`accounts`.`USER` is null), 'background',
          `performance_schema`.`accounts`.`USER`)                                                              AS `user`,
       sum(`sys`.`stmt`.`total`)                                                                               AS `statements`,
       format_pico_time(sum(`sys`.`stmt`.`total_latency`))                                                     AS `statement_latency`,
       format_pico_time(ifnull((sum(`sys`.`stmt`.`total_latency`) / nullif(sum(`sys`.`stmt`.`total`), 0)),
                               0))                                                                             AS `statement_avg_latency`,
       sum(`sys`.`stmt`.`full_scans`)                                                                          AS `table_scans`,
       sum(`sys`.`io`.`ios`)                                                                                   AS `file_ios`,
       format_pico_time(sum(`sys`.`io`.`io_latency`))                                                          AS `file_io_latency`,
       sum(`performance_schema`.`accounts`.`CURRENT_CONNECTIONS`)                                              AS `current_connections`,
       sum(`performance_schema`.`accounts`.`TOTAL_CONNECTIONS`)                                                AS `total_connections`,
       count(distinct `performance_schema`.`accounts`.`HOST`)                                                  AS `unique_hosts`,
       format_bytes(sum(`sys`.`mem`.`current_allocated`))                                                      AS `current_memory`,
       format_bytes(sum(`sys`.`mem`.`total_allocated`))                                                        AS `total_memory_allocated`
from (((`performance_schema`.`accounts` left join `sys`.`x$user_summary_by_statement_latency` `stmt` on ((
        if((`performance_schema`.`accounts`.`USER` is null), 'background', `performance_schema`.`accounts`.`USER`) =
        `sys`.`stmt`.`user`))) left join `sys`.`x$user_summary_by_file_io` `io` on ((
        if((`performance_schema`.`accounts`.`USER` is null), 'background', `performance_schema`.`accounts`.`USER`) =
        `sys`.`io`.`user`)))
         left join `sys`.`x$memory_by_user_by_current_bytes` `mem`
                   on ((if((`performance_schema`.`accounts`.`USER` is null), 'background',
                           `performance_schema`.`accounts`.`USER`) = `sys`.`mem`.`user`)))
group by if((`performance_schema`.`accounts`.`USER` is null), 'background', `performance_schema`.`accounts`.`USER`)
order by sum(`sys`.`stmt`.`total_latency`) desc;

create definer = `mysql.sys`@localhost view sys.user_summary_by_file_io as
	select if((`performance_schema`.`events_waits_summary_by_user_by_event_name`.`USER` is null), 'background',
          `performance_schema`.`events_waits_summary_by_user_by_event_name`.`USER`)                              AS `user`,
       sum(
               `performance_schema`.`events_waits_summary_by_user_by_event_name`.`COUNT_STAR`)                   AS `ios`,
       format_pico_time(sum(
               `performance_schema`.`events_waits_summary_by_user_by_event_name`.`SUM_TIMER_WAIT`))              AS `io_latency`
from `performance_schema`.`events_waits_summary_by_user_by_event_name`
where (`performance_schema`.`events_waits_summary_by_user_by_event_name`.`EVENT_NAME` like 'wait/io/file/%')
group by if((`performance_schema`.`events_waits_summary_by_user_by_event_name`.`USER` is null), 'background',
            `performance_schema`.`events_waits_summary_by_user_by_event_name`.`USER`)
order by sum(`performance_schema`.`events_waits_summary_by_user_by_event_name`.`SUM_TIMER_WAIT`) desc;

create definer = `mysql.sys`@localhost view sys.user_summary_by_file_io_type as
	select if((`performance_schema`.`events_waits_summary_by_user_by_event_name`.`USER` is null), 'background',
          `performance_schema`.`events_waits_summary_by_user_by_event_name`.`USER`)                         AS `user`,
       `performance_schema`.`events_waits_summary_by_user_by_event_name`.`EVENT_NAME`                       AS `event_name`,
       `performance_schema`.`events_waits_summary_by_user_by_event_name`.`COUNT_STAR`                       AS `total`,
       format_pico_time(
               `performance_schema`.`events_waits_summary_by_user_by_event_name`.`SUM_TIMER_WAIT`)          AS `latency`,
       format_pico_time(
               `performance_schema`.`events_waits_summary_by_user_by_event_name`.`MAX_TIMER_WAIT`)          AS `max_latency`
from `performance_schema`.`events_waits_summary_by_user_by_event_name`
where ((`performance_schema`.`events_waits_summary_by_user_by_event_name`.`EVENT_NAME` like 'wait/io/file%') and
       (`performance_schema`.`events_waits_summary_by_user_by_event_name`.`COUNT_STAR` > 0))
order by if((`performance_schema`.`events_waits_summary_by_user_by_event_name`.`USER` is null), 'background',
            `performance_schema`.`events_waits_summary_by_user_by_event_name`.`USER`),
         `performance_schema`.`events_waits_summary_by_user_by_event_name`.`SUM_TIMER_WAIT` desc;

create definer = `mysql.sys`@localhost view sys.user_summary_by_stages as
	select if((`performance_schema`.`events_stages_summary_by_user_by_event_name`.`USER` is null), 'background',
          `performance_schema`.`events_stages_summary_by_user_by_event_name`.`USER`)                         AS `user`,
       `performance_schema`.`events_stages_summary_by_user_by_event_name`.`EVENT_NAME`                       AS `event_name`,
       `performance_schema`.`events_stages_summary_by_user_by_event_name`.`COUNT_STAR`                       AS `total`,
       format_pico_time(
               `performance_schema`.`events_stages_summary_by_user_by_event_name`.`SUM_TIMER_WAIT`)          AS `total_latency`,
       format_pico_time(
               `performance_schema`.`events_stages_summary_by_user_by_event_name`.`AVG_TIMER_WAIT`)          AS `avg_latency`
from `performance_schema`.`events_stages_summary_by_user_by_event_name`
where (`performance_schema`.`events_stages_summary_by_user_by_event_name`.`SUM_TIMER_WAIT` <> 0)
order by if((`performance_schema`.`events_stages_summary_by_user_by_event_name`.`USER` is null), 'background',
            `performance_schema`.`events_stages_summary_by_user_by_event_name`.`USER`),
         `performance_schema`.`events_stages_summary_by_user_by_event_name`.`SUM_TIMER_WAIT` desc;

create definer = `mysql.sys`@localhost view sys.user_summary_by_statement_latency as
	select if((`performance_schema`.`events_statements_summary_by_user_by_event_name`.`USER` is null), 'background',
          `performance_schema`.`events_statements_summary_by_user_by_event_name`.`USER`)                              AS `user`,
       sum(
               `performance_schema`.`events_statements_summary_by_user_by_event_name`.`COUNT_STAR`)                   AS `total`,
       format_pico_time(sum(
               `performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_TIMER_WAIT`))              AS `total_latency`,
       format_pico_time(sum(
               `performance_schema`.`events_statements_summary_by_user_by_event_name`.`MAX_TIMER_WAIT`))              AS `max_latency`,
       format_pico_time(sum(
               `performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_LOCK_TIME`))               AS `lock_latency`,
       format_pico_time(sum(
               `performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_CPU_TIME`))                AS `cpu_latency`,
       sum(
               `performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_ROWS_SENT`)                AS `rows_sent`,
       sum(
               `performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_ROWS_EXAMINED`)            AS `rows_examined`,
       sum(
               `performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_ROWS_AFFECTED`)            AS `rows_affected`,
       (sum(`performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_NO_INDEX_USED`) + sum(
               `performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_NO_GOOD_INDEX_USED`))      AS `full_scans`
from `performance_schema`.`events_statements_summary_by_user_by_event_name`
group by if((`performance_schema`.`events_statements_summary_by_user_by_event_name`.`USER` is null), 'background',
            `performance_schema`.`events_statements_summary_by_user_by_event_name`.`USER`)
order by sum(`performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_TIMER_WAIT`) desc;

create definer = `mysql.sys`@localhost view sys.user_summary_by_statement_type as
	select if((`performance_schema`.`events_statements_summary_by_user_by_event_name`.`USER` is null), 'background',
          `performance_schema`.`events_statements_summary_by_user_by_event_name`.`USER`)                         AS `user`,
       substring_index(`performance_schema`.`events_statements_summary_by_user_by_event_name`.`EVENT_NAME`, '/',
                       -(1))                                                                                     AS `statement`,
       `performance_schema`.`events_statements_summary_by_user_by_event_name`.`COUNT_STAR`                       AS `total`,
       format_pico_time(
               `performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_TIMER_WAIT`)          AS `total_latency`,
       format_pico_time(
               `performance_schema`.`events_statements_summary_by_user_by_event_name`.`MAX_TIMER_WAIT`)          AS `max_latency`,
       format_pico_time(
               `performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_LOCK_TIME`)           AS `lock_latency`,
       format_pico_time(
               `performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_CPU_TIME`)            AS `cpu_latency`,
       `performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_ROWS_SENT`                    AS `rows_sent`,
       `performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_ROWS_EXAMINED`                AS `rows_examined`,
       `performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_ROWS_AFFECTED`                AS `rows_affected`,
       (`performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_NO_INDEX_USED` +
        `performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_NO_GOOD_INDEX_USED`)         AS `full_scans`
from `performance_schema`.`events_statements_summary_by_user_by_event_name`
where (`performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_TIMER_WAIT` <> 0)
order by if((`performance_schema`.`events_statements_summary_by_user_by_event_name`.`USER` is null), 'background',
            `performance_schema`.`events_statements_summary_by_user_by_event_name`.`USER`),
         `performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_TIMER_WAIT` desc;

create definer = `mysql.sys`@localhost view sys.version as
	select '2.1.2' AS `sys_version`, version() AS `mysql_version`;

create definer = `mysql.sys`@localhost view sys.wait_classes_global_by_avg_latency as
	select substring_index(`performance_schema`.`events_waits_summary_global_by_event_name`.`EVENT_NAME`, '/',
                       3)                                                                                           AS `event_class`,
       sum(
               `performance_schema`.`events_waits_summary_global_by_event_name`.`COUNT_STAR`)                       AS `total`,
       format_pico_time(cast(sum(
               `performance_schema`.`events_waits_summary_global_by_event_name`.`SUM_TIMER_WAIT`) as unsigned))     AS `total_latency`,
       format_pico_time(min(
               `performance_schema`.`events_waits_summary_global_by_event_name`.`MIN_TIMER_WAIT`))                  AS `min_latency`,
       format_pico_time(ifnull((sum(`performance_schema`.`events_waits_summary_global_by_event_name`.`SUM_TIMER_WAIT`) /
                                nullif(sum(
                                               `performance_schema`.`events_waits_summary_global_by_event_name`.`COUNT_STAR`),
                                       0)),
                               0))                                                                                  AS `avg_latency`,
       format_pico_time(cast(max(
               `performance_schema`.`events_waits_summary_global_by_event_name`.`MAX_TIMER_WAIT`) as unsigned))     AS `max_latency`
from `performance_schema`.`events_waits_summary_global_by_event_name`
where ((`performance_schema`.`events_waits_summary_global_by_event_name`.`SUM_TIMER_WAIT` > 0) and
       (`performance_schema`.`events_waits_summary_global_by_event_name`.`EVENT_NAME` <> 'idle'))
group by `event_class`
order by ifnull((sum(`performance_schema`.`events_waits_summary_global_by_event_name`.`SUM_TIMER_WAIT`) /
                 nullif(sum(`performance_schema`.`events_waits_summary_global_by_event_name`.`COUNT_STAR`), 0)),
                0) desc;

create definer = `mysql.sys`@localhost view sys.wait_classes_global_by_latency as
	select substring_index(`performance_schema`.`events_waits_summary_global_by_event_name`.`EVENT_NAME`, '/',
                       3)                                                                                       AS `event_class`,
       sum(
               `performance_schema`.`events_waits_summary_global_by_event_name`.`COUNT_STAR`)                   AS `total`,
       format_pico_time(sum(
               `performance_schema`.`events_waits_summary_global_by_event_name`.`SUM_TIMER_WAIT`))              AS `total_latency`,
       format_pico_time(min(
               `performance_schema`.`events_waits_summary_global_by_event_name`.`MIN_TIMER_WAIT`))              AS `min_latency`,
       format_pico_time(ifnull((sum(`performance_schema`.`events_waits_summary_global_by_event_name`.`SUM_TIMER_WAIT`) /
                                nullif(sum(
                                               `performance_schema`.`events_waits_summary_global_by_event_name`.`COUNT_STAR`),
                                       0)),
                               0))                                                                              AS `avg_latency`,
       format_pico_time(max(
               `performance_schema`.`events_waits_summary_global_by_event_name`.`MAX_TIMER_WAIT`))              AS `max_latency`
from `performance_schema`.`events_waits_summary_global_by_event_name`
where ((`performance_schema`.`events_waits_summary_global_by_event_name`.`SUM_TIMER_WAIT` > 0) and
       (`performance_schema`.`events_waits_summary_global_by_event_name`.`EVENT_NAME` <> 'idle'))
group by substring_index(`performance_schema`.`events_waits_summary_global_by_event_name`.`EVENT_NAME`, '/', 3)
order by sum(`performance_schema`.`events_waits_summary_global_by_event_name`.`SUM_TIMER_WAIT`) desc;

create definer = `mysql.sys`@localhost view sys.waits_by_host_by_latency as
	select if((`performance_schema`.`events_waits_summary_by_host_by_event_name`.`HOST` is null), 'background',
          `performance_schema`.`events_waits_summary_by_host_by_event_name`.`HOST`)                         AS `host`,
       `performance_schema`.`events_waits_summary_by_host_by_event_name`.`EVENT_NAME`                       AS `event`,
       `performance_schema`.`events_waits_summary_by_host_by_event_name`.`COUNT_STAR`                       AS `total`,
       format_pico_time(
               `performance_schema`.`events_waits_summary_by_host_by_event_name`.`SUM_TIMER_WAIT`)          AS `total_latency`,
       format_pico_time(
               `performance_schema`.`events_waits_summary_by_host_by_event_name`.`AVG_TIMER_WAIT`)          AS `avg_latency`,
       format_pico_time(
               `performance_schema`.`events_waits_summary_by_host_by_event_name`.`MAX_TIMER_WAIT`)          AS `max_latency`
from `performance_schema`.`events_waits_summary_by_host_by_event_name`
where ((`performance_schema`.`events_waits_summary_by_host_by_event_name`.`EVENT_NAME` <> 'idle') and
       (`performance_schema`.`events_waits_summary_by_host_by_event_name`.`SUM_TIMER_WAIT` > 0))
order by if((`performance_schema`.`events_waits_summary_by_host_by_event_name`.`HOST` is null), 'background',
            `performance_schema`.`events_waits_summary_by_host_by_event_name`.`HOST`),
         `performance_schema`.`events_waits_summary_by_host_by_event_name`.`SUM_TIMER_WAIT` desc;

create definer = `mysql.sys`@localhost view sys.waits_by_user_by_latency as
	select if((`performance_schema`.`events_waits_summary_by_user_by_event_name`.`USER` is null), 'background',
          `performance_schema`.`events_waits_summary_by_user_by_event_name`.`USER`)                         AS `user`,
       `performance_schema`.`events_waits_summary_by_user_by_event_name`.`EVENT_NAME`                       AS `event`,
       `performance_schema`.`events_waits_summary_by_user_by_event_name`.`COUNT_STAR`                       AS `total`,
       format_pico_time(
               `performance_schema`.`events_waits_summary_by_user_by_event_name`.`SUM_TIMER_WAIT`)          AS `total_latency`,
       format_pico_time(
               `performance_schema`.`events_waits_summary_by_user_by_event_name`.`AVG_TIMER_WAIT`)          AS `avg_latency`,
       format_pico_time(
               `performance_schema`.`events_waits_summary_by_user_by_event_name`.`MAX_TIMER_WAIT`)          AS `max_latency`
from `performance_schema`.`events_waits_summary_by_user_by_event_name`
where ((`performance_schema`.`events_waits_summary_by_user_by_event_name`.`EVENT_NAME` <> 'idle') and
       (`performance_schema`.`events_waits_summary_by_user_by_event_name`.`USER` is not null) and
       (`performance_schema`.`events_waits_summary_by_user_by_event_name`.`SUM_TIMER_WAIT` > 0))
order by if((`performance_schema`.`events_waits_summary_by_user_by_event_name`.`USER` is null), 'background',
            `performance_schema`.`events_waits_summary_by_user_by_event_name`.`USER`),
         `performance_schema`.`events_waits_summary_by_user_by_event_name`.`SUM_TIMER_WAIT` desc;

create definer = `mysql.sys`@localhost view sys.waits_global_by_latency as
	select `performance_schema`.`events_waits_summary_global_by_event_name`.`EVENT_NAME`                       AS `event`,
       `performance_schema`.`events_waits_summary_global_by_event_name`.`COUNT_STAR`                       AS `total`,
       format_pico_time(
               `performance_schema`.`events_waits_summary_global_by_event_name`.`SUM_TIMER_WAIT`)          AS `total_latency`,
       format_pico_time(
               `performance_schema`.`events_waits_summary_global_by_event_name`.`AVG_TIMER_WAIT`)          AS `avg_latency`,
       format_pico_time(
               `performance_schema`.`events_waits_summary_global_by_event_name`.`MAX_TIMER_WAIT`)          AS `max_latency`
from `performance_schema`.`events_waits_summary_global_by_event_name`
where ((`performance_schema`.`events_waits_summary_global_by_event_name`.`EVENT_NAME` <> 'idle') and
       (`performance_schema`.`events_waits_summary_global_by_event_name`.`SUM_TIMER_WAIT` > 0))
order by `performance_schema`.`events_waits_summary_global_by_event_name`.`SUM_TIMER_WAIT` desc;

create definer = `mysql.sys`@localhost view sys.x$host_summary as
	select if((`performance_schema`.`accounts`.`HOST` is null), 'background',
          `performance_schema`.`accounts`.`HOST`)                      AS `host`,
       sum(`sys`.`stmt`.`total`)                                       AS `statements`,
       sum(`sys`.`stmt`.`total_latency`)                               AS `statement_latency`,
       (sum(`sys`.`stmt`.`total_latency`) / sum(`sys`.`stmt`.`total`)) AS `statement_avg_latency`,
       sum(`sys`.`stmt`.`full_scans`)                                  AS `table_scans`,
       sum(`sys`.`io`.`ios`)                                           AS `file_ios`,
       sum(`sys`.`io`.`io_latency`)                                    AS `file_io_latency`,
       sum(`performance_schema`.`accounts`.`CURRENT_CONNECTIONS`)      AS `current_connections`,
       sum(`performance_schema`.`accounts`.`TOTAL_CONNECTIONS`)        AS `total_connections`,
       count(distinct `performance_schema`.`accounts`.`USER`)          AS `unique_users`,
       sum(`sys`.`mem`.`current_allocated`)                            AS `current_memory`,
       sum(`sys`.`mem`.`total_allocated`)                              AS `total_memory_allocated`
from (((`performance_schema`.`accounts` join `sys`.`x$host_summary_by_statement_latency` `stmt` on ((`performance_schema`.`accounts`.`HOST` = `sys`.`stmt`.`host`))) join `sys`.`x$host_summary_by_file_io` `io` on ((`performance_schema`.`accounts`.`HOST` = `sys`.`io`.`host`)))
         join `sys`.`x$memory_by_host_by_current_bytes` `mem`
              on ((`performance_schema`.`accounts`.`HOST` = `sys`.`mem`.`host`)))
group by if((`performance_schema`.`accounts`.`HOST` is null), 'background', `performance_schema`.`accounts`.`HOST`);

create definer = `mysql.sys`@localhost view sys.x$host_summary_by_file_io as
	select if((`performance_schema`.`events_waits_summary_by_host_by_event_name`.`HOST` is null), 'background',
          `performance_schema`.`events_waits_summary_by_host_by_event_name`.`HOST`)            AS `host`,
       sum(`performance_schema`.`events_waits_summary_by_host_by_event_name`.`COUNT_STAR`)     AS `ios`,
       sum(`performance_schema`.`events_waits_summary_by_host_by_event_name`.`SUM_TIMER_WAIT`) AS `io_latency`
from `performance_schema`.`events_waits_summary_by_host_by_event_name`
where (`performance_schema`.`events_waits_summary_by_host_by_event_name`.`EVENT_NAME` like 'wait/io/file/%')
group by if((`performance_schema`.`events_waits_summary_by_host_by_event_name`.`HOST` is null), 'background',
            `performance_schema`.`events_waits_summary_by_host_by_event_name`.`HOST`)
order by sum(`performance_schema`.`events_waits_summary_by_host_by_event_name`.`SUM_TIMER_WAIT`) desc;

create definer = `mysql.sys`@localhost view sys.x$host_summary_by_file_io_type as
	select if((`performance_schema`.`events_waits_summary_by_host_by_event_name`.`HOST` is null), 'background',
          `performance_schema`.`events_waits_summary_by_host_by_event_name`.`HOST`)       AS `host`,
       `performance_schema`.`events_waits_summary_by_host_by_event_name`.`EVENT_NAME`     AS `event_name`,
       `performance_schema`.`events_waits_summary_by_host_by_event_name`.`COUNT_STAR`     AS `total`,
       `performance_schema`.`events_waits_summary_by_host_by_event_name`.`SUM_TIMER_WAIT` AS `total_latency`,
       `performance_schema`.`events_waits_summary_by_host_by_event_name`.`MAX_TIMER_WAIT` AS `max_latency`
from `performance_schema`.`events_waits_summary_by_host_by_event_name`
where ((`performance_schema`.`events_waits_summary_by_host_by_event_name`.`EVENT_NAME` like 'wait/io/file%') and
       (`performance_schema`.`events_waits_summary_by_host_by_event_name`.`COUNT_STAR` > 0))
order by if((`performance_schema`.`events_waits_summary_by_host_by_event_name`.`HOST` is null), 'background',
            `performance_schema`.`events_waits_summary_by_host_by_event_name`.`HOST`),
         `performance_schema`.`events_waits_summary_by_host_by_event_name`.`SUM_TIMER_WAIT` desc;

create definer = `mysql.sys`@localhost view sys.x$host_summary_by_stages as
	select if((`performance_schema`.`events_stages_summary_by_host_by_event_name`.`HOST` is null), 'background',
          `performance_schema`.`events_stages_summary_by_host_by_event_name`.`HOST`)       AS `host`,
       `performance_schema`.`events_stages_summary_by_host_by_event_name`.`EVENT_NAME`     AS `event_name`,
       `performance_schema`.`events_stages_summary_by_host_by_event_name`.`COUNT_STAR`     AS `total`,
       `performance_schema`.`events_stages_summary_by_host_by_event_name`.`SUM_TIMER_WAIT` AS `total_latency`,
       `performance_schema`.`events_stages_summary_by_host_by_event_name`.`AVG_TIMER_WAIT` AS `avg_latency`
from `performance_schema`.`events_stages_summary_by_host_by_event_name`
where (`performance_schema`.`events_stages_summary_by_host_by_event_name`.`SUM_TIMER_WAIT` <> 0)
order by if((`performance_schema`.`events_stages_summary_by_host_by_event_name`.`HOST` is null), 'background',
            `performance_schema`.`events_stages_summary_by_host_by_event_name`.`HOST`),
         `performance_schema`.`events_stages_summary_by_host_by_event_name`.`SUM_TIMER_WAIT` desc;

create definer = `mysql.sys`@localhost view sys.x$host_summary_by_statement_latency as
	select if((`performance_schema`.`events_statements_summary_by_host_by_event_name`.`HOST` is null), 'background',
          `performance_schema`.`events_statements_summary_by_host_by_event_name`.`HOST`) AS                         `host`,
       sum(
               `performance_schema`.`events_statements_summary_by_host_by_event_name`.`COUNT_STAR`) AS              `total`,
       sum(
               `performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_TIMER_WAIT`) AS          `total_latency`,
       max(
               `performance_schema`.`events_statements_summary_by_host_by_event_name`.`MAX_TIMER_WAIT`) AS          `max_latency`,
       sum(
               `performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_LOCK_TIME`) AS           `lock_latency`,
       sum(
               `performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_CPU_TIME`) AS            `cpu_latency`,
       sum(
               `performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_ROWS_SENT`) AS           `rows_sent`,
       sum(
               `performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_ROWS_EXAMINED`) AS       `rows_examined`,
       sum(
               `performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_ROWS_AFFECTED`) AS       `rows_affected`,
       (sum(`performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_NO_INDEX_USED`) + sum(
               `performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_NO_GOOD_INDEX_USED`)) AS `full_scans`
from `performance_schema`.`events_statements_summary_by_host_by_event_name`
group by if((`performance_schema`.`events_statements_summary_by_host_by_event_name`.`HOST` is null), 'background',
            `performance_schema`.`events_statements_summary_by_host_by_event_name`.`HOST`)
order by sum(`performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_TIMER_WAIT`) desc;

create definer = `mysql.sys`@localhost view sys.x$host_summary_by_statement_type as
	select if((`performance_schema`.`events_statements_summary_by_host_by_event_name`.`HOST` is null), 'background',
          `performance_schema`.`events_statements_summary_by_host_by_event_name`.`HOST`)                 AS `host`,
       substring_index(`performance_schema`.`events_statements_summary_by_host_by_event_name`.`EVENT_NAME`, '/',
                       -(1))                                                                             AS `statement`,
       `performance_schema`.`events_statements_summary_by_host_by_event_name`.`COUNT_STAR`               AS `total`,
       `performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_TIMER_WAIT`           AS `total_latency`,
       `performance_schema`.`events_statements_summary_by_host_by_event_name`.`MAX_TIMER_WAIT`           AS `max_latency`,
       `performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_LOCK_TIME`            AS `lock_latency`,
       `performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_CPU_TIME`             AS `cpu_latency`,
       `performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_ROWS_SENT`            AS `rows_sent`,
       `performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_ROWS_EXAMINED`        AS `rows_examined`,
       `performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_ROWS_AFFECTED`        AS `rows_affected`,
       (`performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_NO_INDEX_USED` +
        `performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_NO_GOOD_INDEX_USED`) AS `full_scans`
from `performance_schema`.`events_statements_summary_by_host_by_event_name`
where (`performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_TIMER_WAIT` <> 0)
order by if((`performance_schema`.`events_statements_summary_by_host_by_event_name`.`HOST` is null), 'background',
            `performance_schema`.`events_statements_summary_by_host_by_event_name`.`HOST`),
         `performance_schema`.`events_statements_summary_by_host_by_event_name`.`SUM_TIMER_WAIT` desc;

create definer = `mysql.sys`@localhost view sys.x$innodb_buffer_stats_by_schema as
	select if((locate('.', `ibp`.`TABLE_NAME`) = 0), 'InnoDB System',
          replace(substring_index(`ibp`.`TABLE_NAME`, '.', 1), '`', ''))                                  AS `object_schema`,
       sum(
               if((`ibp`.`COMPRESSED_SIZE` = 0), 16384, `ibp`.`COMPRESSED_SIZE`))                         AS `allocated`,
       sum(`ibp`.`DATA_SIZE`)                                                                             AS `data`,
       count(`ibp`.`PAGE_NUMBER`)                                                                         AS `pages`,
       count(if((`ibp`.`IS_HASHED` = 'YES'), 1, NULL))                                                    AS `pages_hashed`,
       count(if((`ibp`.`IS_OLD` = 'YES'), 1, NULL))                                                       AS `pages_old`,
       round(ifnull((sum(`ibp`.`NUMBER_RECORDS`) / nullif(count(distinct `ibp`.`INDEX_NAME`), 0)), 0),
             0)                                                                                           AS `rows_cached`
from `information_schema`.`INNODB_BUFFER_PAGE` `ibp`
where (`ibp`.`TABLE_NAME` is not null)
group by `object_schema`
order by sum(if((`ibp`.`COMPRESSED_SIZE` = 0), 16384, `ibp`.`COMPRESSED_SIZE`)) desc;

create definer = `mysql.sys`@localhost view sys.x$innodb_buffer_stats_by_table as
	select if((locate('.', `ibp`.`TABLE_NAME`) = 0), 'InnoDB System',
          replace(substring_index(`ibp`.`TABLE_NAME`, '.', 1), '`', ''))                                  AS `object_schema`,
       replace(substring_index(`ibp`.`TABLE_NAME`, '.', -(1)), '`', '')                                   AS `object_name`,
       sum(
               if((`ibp`.`COMPRESSED_SIZE` = 0), 16384, `ibp`.`COMPRESSED_SIZE`))                         AS `allocated`,
       sum(`ibp`.`DATA_SIZE`)                                                                             AS `data`,
       count(`ibp`.`PAGE_NUMBER`)                                                                         AS `pages`,
       count(if((`ibp`.`IS_HASHED` = 'YES'), 1, NULL))                                                    AS `pages_hashed`,
       count(if((`ibp`.`IS_OLD` = 'YES'), 1, NULL))                                                       AS `pages_old`,
       round(ifnull((sum(`ibp`.`NUMBER_RECORDS`) / nullif(count(distinct `ibp`.`INDEX_NAME`), 0)), 0),
             0)                                                                                           AS `rows_cached`
from `information_schema`.`INNODB_BUFFER_PAGE` `ibp`
where (`ibp`.`TABLE_NAME` is not null)
group by `object_schema`, `object_name`
order by sum(if((`ibp`.`COMPRESSED_SIZE` = 0), 16384, `ibp`.`COMPRESSED_SIZE`)) desc;

create definer = `mysql.sys`@localhost view sys.x$innodb_lock_waits as
	select `r`.`trx_wait_started`                                                                                    AS `wait_started`,
       timediff(now(), `r`.`trx_wait_started`)                                                                   AS `wait_age`,
       timestampdiff(SECOND, `r`.`trx_wait_started`, now())                                                      AS `wait_age_secs`,
       concat(`sys`.`quote_identifier`(`rl`.`OBJECT_SCHEMA`), '.',
              `sys`.`quote_identifier`(`rl`.`OBJECT_NAME`))                                                      AS `locked_table`,
       `rl`.`OBJECT_SCHEMA`                                                                                      AS `locked_table_schema`,
       `rl`.`OBJECT_NAME`                                                                                        AS `locked_table_name`,
       `rl`.`PARTITION_NAME`                                                                                     AS `locked_table_partition`,
       `rl`.`SUBPARTITION_NAME`                                                                                  AS `locked_table_subpartition`,
       `rl`.`INDEX_NAME`                                                                                         AS `locked_index`,
       `rl`.`LOCK_TYPE`                                                                                          AS `locked_type`,
       `r`.`trx_id`                                                                                              AS `waiting_trx_id`,
       `r`.`trx_started`                                                                                         AS `waiting_trx_started`,
       timediff(now(), `r`.`trx_started`)                                                                        AS `waiting_trx_age`,
       `r`.`trx_rows_locked`                                                                                     AS `waiting_trx_rows_locked`,
       `r`.`trx_rows_modified`                                                                                   AS `waiting_trx_rows_modified`,
       `r`.`trx_mysql_thread_id`                                                                                 AS `waiting_pid`,
       `r`.`trx_query`                                                                                           AS `waiting_query`,
       `rl`.`ENGINE_LOCK_ID`                                                                                     AS `waiting_lock_id`,
       `rl`.`LOCK_MODE`                                                                                          AS `waiting_lock_mode`,
       `b`.`trx_id`                                                                                              AS `blocking_trx_id`,
       `b`.`trx_mysql_thread_id`                                                                                 AS `blocking_pid`,
       `b`.`trx_query`                                                                                           AS `blocking_query`,
       `bl`.`ENGINE_LOCK_ID`                                                                                     AS `blocking_lock_id`,
       `bl`.`LOCK_MODE`                                                                                          AS `blocking_lock_mode`,
       `b`.`trx_started`                                                                                         AS `blocking_trx_started`,
       timediff(now(), `b`.`trx_started`)                                                                        AS `blocking_trx_age`,
       `b`.`trx_rows_locked`                                                                                     AS `blocking_trx_rows_locked`,
       `b`.`trx_rows_modified`                                                                                   AS `blocking_trx_rows_modified`,
       concat('KILL QUERY ', `b`.`trx_mysql_thread_id`)                                                          AS `sql_kill_blocking_query`,
       concat('KILL ', `b`.`trx_mysql_thread_id`)                                                                AS `sql_kill_blocking_connection`
from ((((`performance_schema`.`data_lock_waits` `w` join `information_schema`.`INNODB_TRX` `b` on ((`b`.`trx_id` =
                                                                                                    cast(`w`.`BLOCKING_ENGINE_TRANSACTION_ID` as char charset utf8mb4)))) join `information_schema`.`INNODB_TRX` `r` on ((
        `r`.`trx_id` =
        cast(`w`.`REQUESTING_ENGINE_TRANSACTION_ID` as char charset utf8mb4)))) join `performance_schema`.`data_locks` `bl` on ((`bl`.`ENGINE_LOCK_ID` = `w`.`BLOCKING_ENGINE_LOCK_ID`)))
         join `performance_schema`.`data_locks` `rl` on ((`rl`.`ENGINE_LOCK_ID` = `w`.`REQUESTING_ENGINE_LOCK_ID`)))
order by `r`.`trx_wait_started`;

create definer = `mysql.sys`@localhost view sys.x$io_by_thread_by_latency as
	select if((`performance_schema`.`threads`.`PROCESSLIST_ID` is null),
          substring_index(`performance_schema`.`threads`.`NAME`, '/', -(1)),
          concat(`performance_schema`.`threads`.`PROCESSLIST_USER`, '@',
                 convert(`performance_schema`.`threads`.`PROCESSLIST_HOST` using utf8mb4)))      AS `user`,
       sum(`performance_schema`.`events_waits_summary_by_thread_by_event_name`.`COUNT_STAR`)     AS `total`,
       sum(`performance_schema`.`events_waits_summary_by_thread_by_event_name`.`SUM_TIMER_WAIT`) AS `total_latency`,
       min(`performance_schema`.`events_waits_summary_by_thread_by_event_name`.`MIN_TIMER_WAIT`) AS `min_latency`,
       avg(`performance_schema`.`events_waits_summary_by_thread_by_event_name`.`AVG_TIMER_WAIT`) AS `avg_latency`,
       max(`performance_schema`.`events_waits_summary_by_thread_by_event_name`.`MAX_TIMER_WAIT`) AS `max_latency`,
       `performance_schema`.`events_waits_summary_by_thread_by_event_name`.`THREAD_ID`           AS `thread_id`,
       `performance_schema`.`threads`.`PROCESSLIST_ID`                                           AS `processlist_id`
from (`performance_schema`.`events_waits_summary_by_thread_by_event_name`
         left join `performance_schema`.`threads`
                   on ((`performance_schema`.`events_waits_summary_by_thread_by_event_name`.`THREAD_ID` =
                        `performance_schema`.`threads`.`THREAD_ID`)))
where ((`performance_schema`.`events_waits_summary_by_thread_by_event_name`.`EVENT_NAME` like 'wait/io/file/%') and
       (`performance_schema`.`events_waits_summary_by_thread_by_event_name`.`SUM_TIMER_WAIT` > 0))
group by `performance_schema`.`events_waits_summary_by_thread_by_event_name`.`THREAD_ID`,
         `performance_schema`.`threads`.`PROCESSLIST_ID`, `user`
order by sum(`performance_schema`.`events_waits_summary_by_thread_by_event_name`.`SUM_TIMER_WAIT`) desc;

create definer = `mysql.sys`@localhost view sys.x$io_global_by_file_by_bytes as
	select `performance_schema`.`file_summary_by_instance`.`FILE_NAME`                                                   AS `file`,
       `performance_schema`.`file_summary_by_instance`.`COUNT_READ`                                                  AS `count_read`,
       `performance_schema`.`file_summary_by_instance`.`SUM_NUMBER_OF_BYTES_READ`                                    AS `total_read`,
       ifnull((`performance_schema`.`file_summary_by_instance`.`SUM_NUMBER_OF_BYTES_READ` /
               nullif(`performance_schema`.`file_summary_by_instance`.`COUNT_READ`, 0)),
              0)                                                                                                     AS `avg_read`,
       `performance_schema`.`file_summary_by_instance`.`COUNT_WRITE`                                                 AS `count_write`,
       `performance_schema`.`file_summary_by_instance`.`SUM_NUMBER_OF_BYTES_WRITE`                                   AS `total_written`,
       ifnull((`performance_schema`.`file_summary_by_instance`.`SUM_NUMBER_OF_BYTES_WRITE` /
               nullif(`performance_schema`.`file_summary_by_instance`.`COUNT_WRITE`, 0)),
              0.00)                                                                                                  AS `avg_write`,
       (`performance_schema`.`file_summary_by_instance`.`SUM_NUMBER_OF_BYTES_READ` +
        `performance_schema`.`file_summary_by_instance`.`SUM_NUMBER_OF_BYTES_WRITE`)                                 AS `total`,
       ifnull(round((100 - ((`performance_schema`.`file_summary_by_instance`.`SUM_NUMBER_OF_BYTES_READ` / nullif(
               (`performance_schema`.`file_summary_by_instance`.`SUM_NUMBER_OF_BYTES_READ` +
                `performance_schema`.`file_summary_by_instance`.`SUM_NUMBER_OF_BYTES_WRITE`), 0)) * 100)), 2),
              0.00)                                                                                                  AS `write_pct`
from `performance_schema`.`file_summary_by_instance`
order by (`performance_schema`.`file_summary_by_instance`.`SUM_NUMBER_OF_BYTES_READ` +
          `performance_schema`.`file_summary_by_instance`.`SUM_NUMBER_OF_BYTES_WRITE`) desc;

create definer = `mysql.sys`@localhost view sys.x$io_global_by_file_by_latency as
	select `performance_schema`.`file_summary_by_instance`.`FILE_NAME`       AS `file`,
       `performance_schema`.`file_summary_by_instance`.`COUNT_STAR`      AS `total`,
       `performance_schema`.`file_summary_by_instance`.`SUM_TIMER_WAIT`  AS `total_latency`,
       `performance_schema`.`file_summary_by_instance`.`COUNT_READ`      AS `count_read`,
       `performance_schema`.`file_summary_by_instance`.`SUM_TIMER_READ`  AS `read_latency`,
       `performance_schema`.`file_summary_by_instance`.`COUNT_WRITE`     AS `count_write`,
       `performance_schema`.`file_summary_by_instance`.`SUM_TIMER_WRITE` AS `write_latency`,
       `performance_schema`.`file_summary_by_instance`.`COUNT_MISC`      AS `count_misc`,
       `performance_schema`.`file_summary_by_instance`.`SUM_TIMER_MISC`  AS `misc_latency`
from `performance_schema`.`file_summary_by_instance`
order by `performance_schema`.`file_summary_by_instance`.`SUM_TIMER_WAIT` desc;

create definer = `mysql.sys`@localhost view sys.x$io_global_by_wait_by_bytes as
	select substring_index(`performance_schema`.`file_summary_by_event_name`.`EVENT_NAME`, '/', -(2)) AS `event_name`,
       `performance_schema`.`file_summary_by_event_name`.`COUNT_STAR`                             AS `total`,
       `performance_schema`.`file_summary_by_event_name`.`SUM_TIMER_WAIT`                         AS `total_latency`,
       `performance_schema`.`file_summary_by_event_name`.`MIN_TIMER_WAIT`                         AS `min_latency`,
       `performance_schema`.`file_summary_by_event_name`.`AVG_TIMER_WAIT`                         AS `avg_latency`,
       `performance_schema`.`file_summary_by_event_name`.`MAX_TIMER_WAIT`                         AS `max_latency`,
       `performance_schema`.`file_summary_by_event_name`.`COUNT_READ`                             AS `count_read`,
       `performance_schema`.`file_summary_by_event_name`.`SUM_NUMBER_OF_BYTES_READ`               AS `total_read`,
       ifnull((`performance_schema`.`file_summary_by_event_name`.`SUM_NUMBER_OF_BYTES_READ` /
               nullif(`performance_schema`.`file_summary_by_event_name`.`COUNT_READ`, 0)), 0)     AS `avg_read`,
       `performance_schema`.`file_summary_by_event_name`.`COUNT_WRITE`                            AS `count_write`,
       `performance_schema`.`file_summary_by_event_name`.`SUM_NUMBER_OF_BYTES_WRITE`              AS `total_written`,
       ifnull((`performance_schema`.`file_summary_by_event_name`.`SUM_NUMBER_OF_BYTES_WRITE` /
               nullif(`performance_schema`.`file_summary_by_event_name`.`COUNT_WRITE`, 0)), 0)    AS `avg_written`,
       (`performance_schema`.`file_summary_by_event_name`.`SUM_NUMBER_OF_BYTES_WRITE` +
        `performance_schema`.`file_summary_by_event_name`.`SUM_NUMBER_OF_BYTES_READ`)             AS `total_requested`
from `performance_schema`.`file_summary_by_event_name`
where ((`performance_schema`.`file_summary_by_event_name`.`EVENT_NAME` like 'wait/io/file/%') and
       (`performance_schema`.`file_summary_by_event_name`.`COUNT_STAR` > 0))
order by (`performance_schema`.`file_summary_by_event_name`.`SUM_NUMBER_OF_BYTES_WRITE` +
          `performance_schema`.`file_summary_by_event_name`.`SUM_NUMBER_OF_BYTES_READ`) desc;

create definer = `mysql.sys`@localhost view sys.x$io_global_by_wait_by_latency as
	select substring_index(`performance_schema`.`file_summary_by_event_name`.`EVENT_NAME`, '/', -(2)) AS `event_name`,
       `performance_schema`.`file_summary_by_event_name`.`COUNT_STAR`                             AS `total`,
       `performance_schema`.`file_summary_by_event_name`.`SUM_TIMER_WAIT`                         AS `total_latency`,
       `performance_schema`.`file_summary_by_event_name`.`AVG_TIMER_WAIT`                         AS `avg_latency`,
       `performance_schema`.`file_summary_by_event_name`.`MAX_TIMER_WAIT`                         AS `max_latency`,
       `performance_schema`.`file_summary_by_event_name`.`SUM_TIMER_READ`                         AS `read_latency`,
       `performance_schema`.`file_summary_by_event_name`.`SUM_TIMER_WRITE`                        AS `write_latency`,
       `performance_schema`.`file_summary_by_event_name`.`SUM_TIMER_MISC`                         AS `misc_latency`,
       `performance_schema`.`file_summary_by_event_name`.`COUNT_READ`                             AS `count_read`,
       `performance_schema`.`file_summary_by_event_name`.`SUM_NUMBER_OF_BYTES_READ`               AS `total_read`,
       ifnull((`performance_schema`.`file_summary_by_event_name`.`SUM_NUMBER_OF_BYTES_READ` /
               nullif(`performance_schema`.`file_summary_by_event_name`.`COUNT_READ`, 0)), 0)     AS `avg_read`,
       `performance_schema`.`file_summary_by_event_name`.`COUNT_WRITE`                            AS `count_write`,
       `performance_schema`.`file_summary_by_event_name`.`SUM_NUMBER_OF_BYTES_WRITE`              AS `total_written`,
       ifnull((`performance_schema`.`file_summary_by_event_name`.`SUM_NUMBER_OF_BYTES_WRITE` /
               nullif(`performance_schema`.`file_summary_by_event_name`.`COUNT_WRITE`, 0)), 0)    AS `avg_written`
from `performance_schema`.`file_summary_by_event_name`
where ((`performance_schema`.`file_summary_by_event_name`.`EVENT_NAME` like 'wait/io/file/%') and
       (`performance_schema`.`file_summary_by_event_name`.`COUNT_STAR` > 0))
order by `performance_schema`.`file_summary_by_event_name`.`SUM_TIMER_WAIT` desc;

create definer = `mysql.sys`@localhost view sys.x$latest_file_io as
	select if((`information_schema`.`processlist`.`ID` is null),
          concat(substring_index(`performance_schema`.`threads`.`NAME`, '/', -(1)), ':',
                 `performance_schema`.`events_waits_history_long`.`THREAD_ID`), convert(
                  concat(`information_schema`.`processlist`.`USER`, '@', `information_schema`.`processlist`.`HOST`, ':',
                         `information_schema`.`processlist`.`ID`) using utf8mb4)) AS `thread`,
       `performance_schema`.`events_waits_history_long`.`OBJECT_NAME`             AS `file`,
       `performance_schema`.`events_waits_history_long`.`TIMER_WAIT`              AS `latency`,
       `performance_schema`.`events_waits_history_long`.`OPERATION`               AS `operation`,
       `performance_schema`.`events_waits_history_long`.`NUMBER_OF_BYTES`         AS `requested`
from ((`performance_schema`.`events_waits_history_long` join `performance_schema`.`threads` on ((
        `performance_schema`.`events_waits_history_long`.`THREAD_ID` = `performance_schema`.`threads`.`THREAD_ID`)))
         left join `information_schema`.`PROCESSLIST`
                   on ((`performance_schema`.`threads`.`PROCESSLIST_ID` = `information_schema`.`processlist`.`ID`)))
where ((`performance_schema`.`events_waits_history_long`.`OBJECT_NAME` is not null) and
       (`performance_schema`.`events_waits_history_long`.`EVENT_NAME` like 'wait/io/file/%'))
order by `performance_schema`.`events_waits_history_long`.`TIMER_START`;

create definer = `mysql.sys`@localhost view sys.x$memory_by_host_by_current_bytes as
	select if((`performance_schema`.`memory_summary_by_host_by_event_name`.`HOST` is null), 'background',
          `performance_schema`.`memory_summary_by_host_by_event_name`.`HOST`) AS                              `host`,
       sum(
               `performance_schema`.`memory_summary_by_host_by_event_name`.`CURRENT_COUNT_USED`) AS           `current_count_used`,
       sum(
               `performance_schema`.`memory_summary_by_host_by_event_name`.`CURRENT_NUMBER_OF_BYTES_USED`) AS `current_allocated`,
       ifnull((sum(`performance_schema`.`memory_summary_by_host_by_event_name`.`CURRENT_NUMBER_OF_BYTES_USED`) /
               nullif(sum(`performance_schema`.`memory_summary_by_host_by_event_name`.`CURRENT_COUNT_USED`), 0)),
              0) AS                                                                                           `current_avg_alloc`,
       max(
               `performance_schema`.`memory_summary_by_host_by_event_name`.`CURRENT_NUMBER_OF_BYTES_USED`) AS `current_max_alloc`,
       sum(`performance_schema`.`memory_summary_by_host_by_event_name`.`SUM_NUMBER_OF_BYTES_ALLOC`) AS        `total_allocated`
from `performance_schema`.`memory_summary_by_host_by_event_name`
group by if((`performance_schema`.`memory_summary_by_host_by_event_name`.`HOST` is null), 'background',
            `performance_schema`.`memory_summary_by_host_by_event_name`.`HOST`)
order by sum(`performance_schema`.`memory_summary_by_host_by_event_name`.`CURRENT_NUMBER_OF_BYTES_USED`) desc;

create definer = `mysql.sys`@localhost view sys.x$memory_by_thread_by_current_bytes as
	select `t`.`THREAD_ID`                                                                                   AS `thread_id`,
       if((`t`.`NAME` = 'thread/sql/one_connection'),
          concat(`t`.`PROCESSLIST_USER`, '@', convert(`t`.`PROCESSLIST_HOST` using utf8mb4)),
          replace(`t`.`NAME`, 'thread/', ''))                                                            AS `user`,
       sum(`mt`.`CURRENT_COUNT_USED`)                                                                    AS `current_count_used`,
       sum(`mt`.`CURRENT_NUMBER_OF_BYTES_USED`)                                                          AS `current_allocated`,
       ifnull((sum(`mt`.`CURRENT_NUMBER_OF_BYTES_USED`) / nullif(sum(`mt`.`CURRENT_COUNT_USED`), 0)),
              0)                                                                                         AS `current_avg_alloc`,
       max(`mt`.`CURRENT_NUMBER_OF_BYTES_USED`)                                                          AS `current_max_alloc`,
       sum(`mt`.`SUM_NUMBER_OF_BYTES_ALLOC`)                                                             AS `total_allocated`
from (`performance_schema`.`memory_summary_by_thread_by_event_name` `mt`
         join `performance_schema`.`threads` `t` on ((`mt`.`THREAD_ID` = `t`.`THREAD_ID`)))
group by `t`.`THREAD_ID`,
         if((`t`.`NAME` = 'thread/sql/one_connection'),
            concat(`t`.`PROCESSLIST_USER`, '@', convert(`t`.`PROCESSLIST_HOST` using utf8mb4)),
            replace(`t`.`NAME`, 'thread/', ''))
order by sum(`mt`.`CURRENT_NUMBER_OF_BYTES_USED`) desc;

create definer = `mysql.sys`@localhost view sys.x$memory_by_user_by_current_bytes as
	select if((`performance_schema`.`memory_summary_by_user_by_event_name`.`USER` is null), 'background',
          `performance_schema`.`memory_summary_by_user_by_event_name`.`USER`) AS                              `user`,
       sum(
               `performance_schema`.`memory_summary_by_user_by_event_name`.`CURRENT_COUNT_USED`) AS           `current_count_used`,
       sum(
               `performance_schema`.`memory_summary_by_user_by_event_name`.`CURRENT_NUMBER_OF_BYTES_USED`) AS `current_allocated`,
       ifnull((sum(`performance_schema`.`memory_summary_by_user_by_event_name`.`CURRENT_NUMBER_OF_BYTES_USED`) /
               nullif(sum(`performance_schema`.`memory_summary_by_user_by_event_name`.`CURRENT_COUNT_USED`), 0)),
              0) AS                                                                                           `current_avg_alloc`,
       max(
               `performance_schema`.`memory_summary_by_user_by_event_name`.`CURRENT_NUMBER_OF_BYTES_USED`) AS `current_max_alloc`,
       sum(`performance_schema`.`memory_summary_by_user_by_event_name`.`SUM_NUMBER_OF_BYTES_ALLOC`) AS        `total_allocated`
from `performance_schema`.`memory_summary_by_user_by_event_name`
group by if((`performance_schema`.`memory_summary_by_user_by_event_name`.`USER` is null), 'background',
            `performance_schema`.`memory_summary_by_user_by_event_name`.`USER`)
order by sum(`performance_schema`.`memory_summary_by_user_by_event_name`.`CURRENT_NUMBER_OF_BYTES_USED`) desc;

create definer = `mysql.sys`@localhost view sys.x$memory_global_by_current_bytes as
	select `performance_schema`.`memory_summary_global_by_event_name`.`EVENT_NAME`                                 AS `event_name`,
       `performance_schema`.`memory_summary_global_by_event_name`.`CURRENT_COUNT_USED`                         AS `current_count`,
       `performance_schema`.`memory_summary_global_by_event_name`.`CURRENT_NUMBER_OF_BYTES_USED`               AS `current_alloc`,
       ifnull((`performance_schema`.`memory_summary_global_by_event_name`.`CURRENT_NUMBER_OF_BYTES_USED` /
               nullif(`performance_schema`.`memory_summary_global_by_event_name`.`CURRENT_COUNT_USED`, 0)),
              0)                                                                                               AS `current_avg_alloc`,
       `performance_schema`.`memory_summary_global_by_event_name`.`HIGH_COUNT_USED`                            AS `high_count`,
       `performance_schema`.`memory_summary_global_by_event_name`.`HIGH_NUMBER_OF_BYTES_USED`                  AS `high_alloc`,
       ifnull((`performance_schema`.`memory_summary_global_by_event_name`.`HIGH_NUMBER_OF_BYTES_USED` /
               nullif(`performance_schema`.`memory_summary_global_by_event_name`.`HIGH_COUNT_USED`, 0)),
              0)                                                                                               AS `high_avg_alloc`
from `performance_schema`.`memory_summary_global_by_event_name`
where (`performance_schema`.`memory_summary_global_by_event_name`.`CURRENT_NUMBER_OF_BYTES_USED` > 0)
order by `performance_schema`.`memory_summary_global_by_event_name`.`CURRENT_NUMBER_OF_BYTES_USED` desc;

create definer = `mysql.sys`@localhost view sys.x$memory_global_total as
	select sum(
               `performance_schema`.`memory_summary_global_by_event_name`.`CURRENT_NUMBER_OF_BYTES_USED`) AS `total_allocated`
from `performance_schema`.`memory_summary_global_by_event_name`;

create definer = `mysql.sys`@localhost view sys.x$processlist as
	select `pps`.`THREAD_ID`                                                                                              AS `thd_id`,
       `pps`.`PROCESSLIST_ID`                                                                                         AS `conn_id`,
       if((`pps`.`NAME` in ('thread/sql/one_connection', 'thread/thread_pool/tp_one_connection')),
          concat(`pps`.`PROCESSLIST_USER`, '@', convert(`pps`.`PROCESSLIST_HOST` using utf8mb4)),
          replace(`pps`.`NAME`, 'thread/', ''))                                                                       AS `user`,
       `pps`.`PROCESSLIST_DB`                                                                                         AS `db`,
       `pps`.`PROCESSLIST_COMMAND`                                                                                    AS `command`,
       `pps`.`PROCESSLIST_STATE`                                                                                      AS `state`,
       `pps`.`PROCESSLIST_TIME`                                                                                       AS `time`,
       `pps`.`PROCESSLIST_INFO`                                                                                       AS `current_statement`,
       `pps`.`EXECUTION_ENGINE`                                                                                       AS `execution_engine`,
       if((`esc`.`END_EVENT_ID` is null), `esc`.`TIMER_WAIT`, NULL)                                                   AS `statement_latency`,
       if((`esc`.`END_EVENT_ID` is null), round((100 * (`estc`.`WORK_COMPLETED` / `estc`.`WORK_ESTIMATED`)), 2),
          NULL)                                                                                                       AS `progress`,
       `esc`.`LOCK_TIME`                                                                                              AS `lock_latency`,
       `esc`.`CPU_TIME`                                                                                               AS `cpu_latency`,
       `esc`.`ROWS_EXAMINED`                                                                                          AS `rows_examined`,
       `esc`.`ROWS_SENT`                                                                                              AS `rows_sent`,
       `esc`.`ROWS_AFFECTED`                                                                                          AS `rows_affected`,
       `esc`.`CREATED_TMP_TABLES`                                                                                     AS `tmp_tables`,
       `esc`.`CREATED_TMP_DISK_TABLES`                                                                                AS `tmp_disk_tables`,
       if(((`esc`.`NO_GOOD_INDEX_USED` > 0) or (`esc`.`NO_INDEX_USED` > 0)), 'YES',
          'NO')                                                                                                       AS `full_scan`,
       if((`esc`.`END_EVENT_ID` is not null), `esc`.`SQL_TEXT`, NULL)                                                 AS `last_statement`,
       if((`esc`.`END_EVENT_ID` is not null), `esc`.`TIMER_WAIT`, NULL)                                               AS `last_statement_latency`,
       `sys`.`mem`.`current_allocated`                                                                                AS `current_memory`,
       `ewc`.`EVENT_NAME`                                                                                             AS `last_wait`,
       if(((`ewc`.`END_EVENT_ID` is null) and (`ewc`.`EVENT_NAME` is not null)), 'Still Waiting',
          `ewc`.`TIMER_WAIT`)                                                                                         AS `last_wait_latency`,
       `ewc`.`SOURCE`                                                                                                 AS `source`,
       `etc`.`TIMER_WAIT`                                                                                             AS `trx_latency`,
       `etc`.`STATE`                                                                                                  AS `trx_state`,
       `etc`.`AUTOCOMMIT`                                                                                             AS `trx_autocommit`,
       `conattr_pid`.`ATTR_VALUE`                                                                                     AS `pid`,
       `conattr_progname`.`ATTR_VALUE`                                                                                AS `program_name`
from (((((((`performance_schema`.`threads` `pps` left join `performance_schema`.`events_waits_current` `ewc` on ((`pps`.`THREAD_ID` = `ewc`.`THREAD_ID`))) left join `performance_schema`.`events_stages_current` `estc` on ((`pps`.`THREAD_ID` = `estc`.`THREAD_ID`))) left join `performance_schema`.`events_statements_current` `esc` on ((`pps`.`THREAD_ID` = `esc`.`THREAD_ID`))) left join `performance_schema`.`events_transactions_current` `etc` on ((`pps`.`THREAD_ID` = `etc`.`THREAD_ID`))) left join `sys`.`x$memory_by_thread_by_current_bytes` `mem` on ((`pps`.`THREAD_ID` = `sys`.`mem`.`thread_id`))) left join `performance_schema`.`session_connect_attrs` `conattr_pid` on ((
        (`conattr_pid`.`PROCESSLIST_ID` = `pps`.`PROCESSLIST_ID`) and (`conattr_pid`.`ATTR_NAME` = '_pid'))))
         left join `performance_schema`.`session_connect_attrs` `conattr_progname`
                   on (((`conattr_progname`.`PROCESSLIST_ID` = `pps`.`PROCESSLIST_ID`) and
                        (`conattr_progname`.`ATTR_NAME` = 'program_name'))))
order by `pps`.`PROCESSLIST_TIME` desc, `last_wait_latency` desc;

create definer = `mysql.sys`@localhost view sys.x$ps_digest_95th_percentile_by_avg_us as
	select `sys`.`s2`.`avg_us`                                                                                       AS `avg_us`,
       ifnull((sum(`sys`.`s1`.`cnt`) /
               nullif((select count(0) from `performance_schema`.`events_statements_summary_by_digest`), 0)),
              0)                                                                                                 AS `percentile`
from (`sys`.`x$ps_digest_avg_latency_distribution` `s1`
         join `sys`.`x$ps_digest_avg_latency_distribution` `s2` on ((`sys`.`s1`.`avg_us` <= `sys`.`s2`.`avg_us`)))
group by `sys`.`s2`.`avg_us`
having (ifnull((sum(`sys`.`s1`.`cnt`) /
                nullif((select count(0) from `performance_schema`.`events_statements_summary_by_digest`), 0)), 0) >
        0.95)
order by `percentile`
limit 1;

create definer = `mysql.sys`@localhost view sys.x$ps_digest_avg_latency_distribution as
	select count(0)                                                                                          AS `cnt`,
       round((`performance_schema`.`events_statements_summary_by_digest`.`AVG_TIMER_WAIT` / 1000000), 0) AS `avg_us`
from `performance_schema`.`events_statements_summary_by_digest`
group by `avg_us`;

create definer = `mysql.sys`@localhost view sys.x$ps_schema_table_statistics_io as
	select `extract_schema_from_file_name`(`performance_schema`.`file_summary_by_instance`.`FILE_NAME`) AS `table_schema`,
       `extract_table_from_file_name`(`performance_schema`.`file_summary_by_instance`.`FILE_NAME`)  AS `table_name`,
       sum(`performance_schema`.`file_summary_by_instance`.`COUNT_READ`)                            AS `count_read`,
       sum(
               `performance_schema`.`file_summary_by_instance`.`SUM_NUMBER_OF_BYTES_READ`)          AS `sum_number_of_bytes_read`,
       sum(`performance_schema`.`file_summary_by_instance`.`SUM_TIMER_READ`)                        AS `sum_timer_read`,
       sum(`performance_schema`.`file_summary_by_instance`.`COUNT_WRITE`)                           AS `count_write`,
       sum(
               `performance_schema`.`file_summary_by_instance`.`SUM_NUMBER_OF_BYTES_WRITE`)         AS `sum_number_of_bytes_write`,
       sum(
               `performance_schema`.`file_summary_by_instance`.`SUM_TIMER_WRITE`)                   AS `sum_timer_write`,
       sum(`performance_schema`.`file_summary_by_instance`.`COUNT_MISC`)                            AS `count_misc`,
       sum(`performance_schema`.`file_summary_by_instance`.`SUM_TIMER_MISC`)                        AS `sum_timer_misc`
from `performance_schema`.`file_summary_by_instance`
group by `table_schema`, `table_name`;

create definer = `mysql.sys`@localhost view sys.x$schema_flattened_keys as
	select `information_schema`.`statistics`.`TABLE_SCHEMA`                                 AS `TABLE_SCHEMA`,
       `information_schema`.`statistics`.`TABLE_NAME`                                   AS `TABLE_NAME`,
       `information_schema`.`statistics`.`INDEX_NAME`                                   AS `INDEX_NAME`,
       max(`information_schema`.`statistics`.`NON_UNIQUE`)                              AS `non_unique`,
       max(if((`information_schema`.`statistics`.`SUB_PART` is null), 0, 1))            AS `subpart_exists`,
       group_concat(`information_schema`.`statistics`.`COLUMN_NAME` order by
                    `information_schema`.`statistics`.`SEQ_IN_INDEX` ASC separator ',') AS `index_columns`
from `information_schema`.`STATISTICS`
where ((`information_schema`.`statistics`.`INDEX_TYPE` = 'BTREE') and
       (`information_schema`.`statistics`.`TABLE_SCHEMA` not in
        ('mysql', 'sys', 'INFORMATION_SCHEMA', 'PERFORMANCE_SCHEMA')))
group by `information_schema`.`statistics`.`TABLE_SCHEMA`, `information_schema`.`statistics`.`TABLE_NAME`,
         `information_schema`.`statistics`.`INDEX_NAME`;

create definer = `mysql.sys`@localhost view sys.x$schema_index_statistics as
	select `performance_schema`.`table_io_waits_summary_by_index_usage`.`OBJECT_SCHEMA`    AS `table_schema`,
       `performance_schema`.`table_io_waits_summary_by_index_usage`.`OBJECT_NAME`      AS `table_name`,
       `performance_schema`.`table_io_waits_summary_by_index_usage`.`INDEX_NAME`       AS `index_name`,
       `performance_schema`.`table_io_waits_summary_by_index_usage`.`COUNT_FETCH`      AS `rows_selected`,
       `performance_schema`.`table_io_waits_summary_by_index_usage`.`SUM_TIMER_FETCH`  AS `select_latency`,
       `performance_schema`.`table_io_waits_summary_by_index_usage`.`COUNT_INSERT`     AS `rows_inserted`,
       `performance_schema`.`table_io_waits_summary_by_index_usage`.`SUM_TIMER_INSERT` AS `insert_latency`,
       `performance_schema`.`table_io_waits_summary_by_index_usage`.`COUNT_UPDATE`     AS `rows_updated`,
       `performance_schema`.`table_io_waits_summary_by_index_usage`.`SUM_TIMER_UPDATE` AS `update_latency`,
       `performance_schema`.`table_io_waits_summary_by_index_usage`.`COUNT_DELETE`     AS `rows_deleted`,
       `performance_schema`.`table_io_waits_summary_by_index_usage`.`SUM_TIMER_DELETE` AS `delete_latency`
from `performance_schema`.`table_io_waits_summary_by_index_usage`
where (`performance_schema`.`table_io_waits_summary_by_index_usage`.`INDEX_NAME` is not null)
order by `performance_schema`.`table_io_waits_summary_by_index_usage`.`SUM_TIMER_WAIT` desc;

create definer = `mysql.sys`@localhost view sys.x$schema_table_lock_waits as
	select `g`.`OBJECT_SCHEMA`                              AS `object_schema`,
       `g`.`OBJECT_NAME`                                AS `object_name`,
       `pt`.`THREAD_ID`                                 AS `waiting_thread_id`,
       `pt`.`PROCESSLIST_ID`                            AS `waiting_pid`,
       `sys`.`ps_thread_account`(`p`.`OWNER_THREAD_ID`) AS `waiting_account`,
       `p`.`LOCK_TYPE`                                  AS `waiting_lock_type`,
       `p`.`LOCK_DURATION`                              AS `waiting_lock_duration`,
       `pt`.`PROCESSLIST_INFO`                          AS `waiting_query`,
       `pt`.`PROCESSLIST_TIME`                          AS `waiting_query_secs`,
       `ps`.`ROWS_AFFECTED`                             AS `waiting_query_rows_affected`,
       `ps`.`ROWS_EXAMINED`                             AS `waiting_query_rows_examined`,
       `gt`.`THREAD_ID`                                 AS `blocking_thread_id`,
       `gt`.`PROCESSLIST_ID`                            AS `blocking_pid`,
       `sys`.`ps_thread_account`(`g`.`OWNER_THREAD_ID`) AS `blocking_account`,
       `g`.`LOCK_TYPE`                                  AS `blocking_lock_type`,
       `g`.`LOCK_DURATION`                              AS `blocking_lock_duration`,
       concat('KILL QUERY ', `gt`.`PROCESSLIST_ID`)     AS `sql_kill_blocking_query`,
       concat('KILL ', `gt`.`PROCESSLIST_ID`)           AS `sql_kill_blocking_connection`
from (((((`performance_schema`.`metadata_locks` `g` join `performance_schema`.`metadata_locks` `p` on ((
        (`g`.`OBJECT_TYPE` = `p`.`OBJECT_TYPE`) and (`g`.`OBJECT_SCHEMA` = `p`.`OBJECT_SCHEMA`) and
        (`g`.`OBJECT_NAME` = `p`.`OBJECT_NAME`) and (`g`.`LOCK_STATUS` = 'GRANTED') and
        (`p`.`LOCK_STATUS` = 'PENDING')))) join `performance_schema`.`threads` `gt` on ((`g`.`OWNER_THREAD_ID` = `gt`.`THREAD_ID`))) join `performance_schema`.`threads` `pt` on ((`p`.`OWNER_THREAD_ID` = `pt`.`THREAD_ID`))) left join `performance_schema`.`events_statements_current` `gs` on ((`g`.`OWNER_THREAD_ID` = `gs`.`THREAD_ID`)))
         left join `performance_schema`.`events_statements_current` `ps` on ((`p`.`OWNER_THREAD_ID` = `ps`.`THREAD_ID`)))
where (`g`.`OBJECT_TYPE` = 'TABLE');

create definer = `mysql.sys`@localhost view sys.x$schema_table_statistics as
	select `pst`.`OBJECT_SCHEMA`                    AS `table_schema`,
       `pst`.`OBJECT_NAME`                      AS `table_name`,
       `pst`.`SUM_TIMER_WAIT`                   AS `total_latency`,
       `pst`.`COUNT_FETCH`                      AS `rows_fetched`,
       `pst`.`SUM_TIMER_FETCH`                  AS `fetch_latency`,
       `pst`.`COUNT_INSERT`                     AS `rows_inserted`,
       `pst`.`SUM_TIMER_INSERT`                 AS `insert_latency`,
       `pst`.`COUNT_UPDATE`                     AS `rows_updated`,
       `pst`.`SUM_TIMER_UPDATE`                 AS `update_latency`,
       `pst`.`COUNT_DELETE`                     AS `rows_deleted`,
       `pst`.`SUM_TIMER_DELETE`                 AS `delete_latency`,
       `sys`.`fsbi`.`count_read`                AS `io_read_requests`,
       `sys`.`fsbi`.`sum_number_of_bytes_read`  AS `io_read`,
       `sys`.`fsbi`.`sum_timer_read`            AS `io_read_latency`,
       `sys`.`fsbi`.`count_write`               AS `io_write_requests`,
       `sys`.`fsbi`.`sum_number_of_bytes_write` AS `io_write`,
       `sys`.`fsbi`.`sum_timer_write`           AS `io_write_latency`,
       `sys`.`fsbi`.`count_misc`                AS `io_misc_requests`,
       `sys`.`fsbi`.`sum_timer_misc`            AS `io_misc_latency`
from (`performance_schema`.`table_io_waits_summary_by_table` `pst`
         left join `sys`.`x$ps_schema_table_statistics_io` `fsbi`
                   on (((`pst`.`OBJECT_SCHEMA` = `sys`.`fsbi`.`table_schema`) and
                        (`pst`.`OBJECT_NAME` = `sys`.`fsbi`.`table_name`))))
order by `pst`.`SUM_TIMER_WAIT` desc;

create definer = `mysql.sys`@localhost view sys.x$schema_table_statistics_with_buffer as
	select `pst`.`OBJECT_SCHEMA`                          AS `table_schema`,
       `pst`.`OBJECT_NAME`                            AS `table_name`,
       `pst`.`COUNT_FETCH`                            AS `rows_fetched`,
       `pst`.`SUM_TIMER_FETCH`                        AS `fetch_latency`,
       `pst`.`COUNT_INSERT`                           AS `rows_inserted`,
       `pst`.`SUM_TIMER_INSERT`                       AS `insert_latency`,
       `pst`.`COUNT_UPDATE`                           AS `rows_updated`,
       `pst`.`SUM_TIMER_UPDATE`                       AS `update_latency`,
       `pst`.`COUNT_DELETE`                           AS `rows_deleted`,
       `pst`.`SUM_TIMER_DELETE`                       AS `delete_latency`,
       `sys`.`fsbi`.`count_read`                      AS `io_read_requests`,
       `sys`.`fsbi`.`sum_number_of_bytes_read`        AS `io_read`,
       `sys`.`fsbi`.`sum_timer_read`                  AS `io_read_latency`,
       `sys`.`fsbi`.`count_write`                     AS `io_write_requests`,
       `sys`.`fsbi`.`sum_number_of_bytes_write`       AS `io_write`,
       `sys`.`fsbi`.`sum_timer_write`                 AS `io_write_latency`,
       `sys`.`fsbi`.`count_misc`                      AS `io_misc_requests`,
       `sys`.`fsbi`.`sum_timer_misc`                  AS `io_misc_latency`,
       `sys`.`ibp`.`allocated`                        AS `innodb_buffer_allocated`,
       `sys`.`ibp`.`data`                             AS `innodb_buffer_data`,
       (`sys`.`ibp`.`allocated` - `sys`.`ibp`.`data`) AS `innodb_buffer_free`,
       `sys`.`ibp`.`pages`                            AS `innodb_buffer_pages`,
       `sys`.`ibp`.`pages_hashed`                     AS `innodb_buffer_pages_hashed`,
       `sys`.`ibp`.`pages_old`                        AS `innodb_buffer_pages_old`,
       `sys`.`ibp`.`rows_cached`                      AS `innodb_buffer_rows_cached`
from ((`performance_schema`.`table_io_waits_summary_by_table` `pst` left join `sys`.`x$ps_schema_table_statistics_io` `fsbi` on ((
        (`pst`.`OBJECT_SCHEMA` = `sys`.`fsbi`.`table_schema`) and (`pst`.`OBJECT_NAME` = `sys`.`fsbi`.`table_name`))))
         left join `sys`.`x$innodb_buffer_stats_by_table` `ibp`
                   on (((`pst`.`OBJECT_SCHEMA` = `sys`.`ibp`.`object_schema`) and
                        (`pst`.`OBJECT_NAME` = `sys`.`ibp`.`object_name`))))
order by `pst`.`SUM_TIMER_WAIT` desc;

create definer = `mysql.sys`@localhost view sys.x$schema_tables_with_full_table_scans as
	select `performance_schema`.`table_io_waits_summary_by_index_usage`.`OBJECT_SCHEMA`  AS `object_schema`,
       `performance_schema`.`table_io_waits_summary_by_index_usage`.`OBJECT_NAME`    AS `object_name`,
       `performance_schema`.`table_io_waits_summary_by_index_usage`.`COUNT_READ`     AS `rows_full_scanned`,
       `performance_schema`.`table_io_waits_summary_by_index_usage`.`SUM_TIMER_WAIT` AS `latency`
from `performance_schema`.`table_io_waits_summary_by_index_usage`
where ((`performance_schema`.`table_io_waits_summary_by_index_usage`.`INDEX_NAME` is null) and
       (`performance_schema`.`table_io_waits_summary_by_index_usage`.`COUNT_READ` > 0))
order by `performance_schema`.`table_io_waits_summary_by_index_usage`.`COUNT_READ` desc;

create definer = `mysql.sys`@localhost view sys.x$session as
	select `sys`.`x$processlist`.`thd_id`                 AS `thd_id`,
       `sys`.`x$processlist`.`conn_id`                AS `conn_id`,
       `sys`.`x$processlist`.`user`                   AS `user`,
       `sys`.`x$processlist`.`db`                     AS `db`,
       `sys`.`x$processlist`.`command`                AS `command`,
       `sys`.`x$processlist`.`state`                  AS `state`,
       `sys`.`x$processlist`.`time`                   AS `time`,
       `sys`.`x$processlist`.`current_statement`      AS `current_statement`,
       `sys`.`x$processlist`.`execution_engine`       AS `execution_engine`,
       `sys`.`x$processlist`.`statement_latency`      AS `statement_latency`,
       `sys`.`x$processlist`.`progress`               AS `progress`,
       `sys`.`x$processlist`.`lock_latency`           AS `lock_latency`,
       `sys`.`x$processlist`.`cpu_latency`            AS `cpu_latency`,
       `sys`.`x$processlist`.`rows_examined`          AS `rows_examined`,
       `sys`.`x$processlist`.`rows_sent`              AS `rows_sent`,
       `sys`.`x$processlist`.`rows_affected`          AS `rows_affected`,
       `sys`.`x$processlist`.`tmp_tables`             AS `tmp_tables`,
       `sys`.`x$processlist`.`tmp_disk_tables`        AS `tmp_disk_tables`,
       `sys`.`x$processlist`.`full_scan`              AS `full_scan`,
       `sys`.`x$processlist`.`last_statement`         AS `last_statement`,
       `sys`.`x$processlist`.`last_statement_latency` AS `last_statement_latency`,
       `sys`.`x$processlist`.`current_memory`         AS `current_memory`,
       `sys`.`x$processlist`.`last_wait`              AS `last_wait`,
       `sys`.`x$processlist`.`last_wait_latency`      AS `last_wait_latency`,
       `sys`.`x$processlist`.`source`                 AS `source`,
       `sys`.`x$processlist`.`trx_latency`            AS `trx_latency`,
       `sys`.`x$processlist`.`trx_state`              AS `trx_state`,
       `sys`.`x$processlist`.`trx_autocommit`         AS `trx_autocommit`,
       `sys`.`x$processlist`.`pid`                    AS `pid`,
       `sys`.`x$processlist`.`program_name`           AS `program_name`
from `sys`.`x$processlist`
where ((`sys`.`x$processlist`.`conn_id` is not null) and (`sys`.`x$processlist`.`command` <> 'Daemon'));

create definer = `mysql.sys`@localhost view sys.x$statement_analysis as
	select `performance_schema`.`events_statements_summary_by_digest`.`DIGEST_TEXT`                                  AS `query`,
       `performance_schema`.`events_statements_summary_by_digest`.`SCHEMA_NAME`                                  AS `db`,
       if(((`performance_schema`.`events_statements_summary_by_digest`.`SUM_NO_GOOD_INDEX_USED` > 0) or
           (`performance_schema`.`events_statements_summary_by_digest`.`SUM_NO_INDEX_USED` > 0)), '*',
          '')                                                                                                    AS `full_scan`,
       `performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`                                   AS `exec_count`,
       `performance_schema`.`events_statements_summary_by_digest`.`COUNT_SECONDARY`                              AS `exec_secondary_count`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_ERRORS`                                   AS `err_count`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_WARNINGS`                                 AS `warn_count`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_TIMER_WAIT`                               AS `total_latency`,
       `performance_schema`.`events_statements_summary_by_digest`.`MAX_TIMER_WAIT`                               AS `max_latency`,
       `performance_schema`.`events_statements_summary_by_digest`.`AVG_TIMER_WAIT`                               AS `avg_latency`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_LOCK_TIME`                                AS `lock_latency`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_CPU_TIME`                                 AS `cpu_latency`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_ROWS_SENT`                                AS `rows_sent`,
       round(ifnull((`performance_schema`.`events_statements_summary_by_digest`.`SUM_ROWS_SENT` /
                     nullif(`performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`, 0)), 0),
             0)                                                                                                  AS `rows_sent_avg`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_ROWS_EXAMINED`                            AS `rows_examined`,
       round(ifnull((`performance_schema`.`events_statements_summary_by_digest`.`SUM_ROWS_EXAMINED` /
                     nullif(`performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`, 0)), 0),
             0)                                                                                                  AS `rows_examined_avg`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_ROWS_AFFECTED`                            AS `rows_affected`,
       round(ifnull((`performance_schema`.`events_statements_summary_by_digest`.`SUM_ROWS_AFFECTED` /
                     nullif(`performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`, 0)), 0),
             0)                                                                                                  AS `rows_affected_avg`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_CREATED_TMP_TABLES`                       AS `tmp_tables`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_CREATED_TMP_DISK_TABLES`                  AS `tmp_disk_tables`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_SORT_ROWS`                                AS `rows_sorted`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_SORT_MERGE_PASSES`                        AS `sort_merge_passes`,
       `performance_schema`.`events_statements_summary_by_digest`.`MAX_CONTROLLED_MEMORY`                        AS `max_controlled_memory`,
       `performance_schema`.`events_statements_summary_by_digest`.`MAX_TOTAL_MEMORY`                             AS `max_total_memory`,
       `performance_schema`.`events_statements_summary_by_digest`.`DIGEST`                                       AS `digest`,
       `performance_schema`.`events_statements_summary_by_digest`.`FIRST_SEEN`                                   AS `first_seen`,
       `performance_schema`.`events_statements_summary_by_digest`.`LAST_SEEN`                                    AS `last_seen`
from `performance_schema`.`events_statements_summary_by_digest`
order by `performance_schema`.`events_statements_summary_by_digest`.`SUM_TIMER_WAIT` desc;

create definer = `mysql.sys`@localhost view sys.x$statements_with_errors_or_warnings as
	select `performance_schema`.`events_statements_summary_by_digest`.`DIGEST_TEXT`                                AS `query`,
       `performance_schema`.`events_statements_summary_by_digest`.`SCHEMA_NAME`                                AS `db`,
       `performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`                                 AS `exec_count`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_ERRORS`                                 AS `errors`,
       (ifnull((`performance_schema`.`events_statements_summary_by_digest`.`SUM_ERRORS` /
                nullif(`performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`, 0)), 0) *
        100)                                                                                                   AS `error_pct`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_WARNINGS`                               AS `warnings`,
       (ifnull((`performance_schema`.`events_statements_summary_by_digest`.`SUM_WARNINGS` /
                nullif(`performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`, 0)), 0) *
        100)                                                                                                   AS `warning_pct`,
       `performance_schema`.`events_statements_summary_by_digest`.`FIRST_SEEN`                                 AS `first_seen`,
       `performance_schema`.`events_statements_summary_by_digest`.`LAST_SEEN`                                  AS `last_seen`,
       `performance_schema`.`events_statements_summary_by_digest`.`DIGEST`                                     AS `digest`
from `performance_schema`.`events_statements_summary_by_digest`
where ((`performance_schema`.`events_statements_summary_by_digest`.`SUM_ERRORS` > 0) or
       (`performance_schema`.`events_statements_summary_by_digest`.`SUM_WARNINGS` > 0))
order by `performance_schema`.`events_statements_summary_by_digest`.`SUM_ERRORS` desc,
         `performance_schema`.`events_statements_summary_by_digest`.`SUM_WARNINGS` desc;

create definer = `mysql.sys`@localhost view sys.x$statements_with_full_table_scans as
	select `performance_schema`.`events_statements_summary_by_digest`.`DIGEST_TEXT`            AS `query`,
       `performance_schema`.`events_statements_summary_by_digest`.`SCHEMA_NAME`            AS `db`,
       `performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`             AS `exec_count`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_TIMER_WAIT`         AS `total_latency`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_NO_INDEX_USED`      AS `no_index_used_count`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_NO_GOOD_INDEX_USED` AS `no_good_index_used_count`,
       round((ifnull((`performance_schema`.`events_statements_summary_by_digest`.`SUM_NO_INDEX_USED` /
                      nullif(`performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`, 0)), 0) * 100),
             0)                                                                            AS `no_index_used_pct`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_ROWS_SENT`          AS `rows_sent`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_ROWS_EXAMINED`      AS `rows_examined`,
       round((`performance_schema`.`events_statements_summary_by_digest`.`SUM_ROWS_SENT` /
              `performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`), 0) AS `rows_sent_avg`,
       round((`performance_schema`.`events_statements_summary_by_digest`.`SUM_ROWS_EXAMINED` /
              `performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`), 0) AS `rows_examined_avg`,
       `performance_schema`.`events_statements_summary_by_digest`.`FIRST_SEEN`             AS `first_seen`,
       `performance_schema`.`events_statements_summary_by_digest`.`LAST_SEEN`              AS `last_seen`,
       `performance_schema`.`events_statements_summary_by_digest`.`DIGEST`                 AS `digest`
from `performance_schema`.`events_statements_summary_by_digest`
where (((`performance_schema`.`events_statements_summary_by_digest`.`SUM_NO_INDEX_USED` > 0) or
        (`performance_schema`.`events_statements_summary_by_digest`.`SUM_NO_GOOD_INDEX_USED` > 0)) and
       (not ((`performance_schema`.`events_statements_summary_by_digest`.`DIGEST_TEXT` like 'SHOW%'))))
order by round((ifnull((`performance_schema`.`events_statements_summary_by_digest`.`SUM_NO_INDEX_USED` /
                        nullif(`performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`, 0)), 0) * 100),
               0) desc, `performance_schema`.`events_statements_summary_by_digest`.`SUM_TIMER_WAIT` desc;

create definer = `mysql.sys`@localhost view sys.x$statements_with_runtimes_in_95th_percentile as
	select `stmts`.`DIGEST_TEXT`                                                                      AS `query`,
       `stmts`.`SCHEMA_NAME`                                                                      AS `db`,
       if(((`stmts`.`SUM_NO_GOOD_INDEX_USED` > 0) or (`stmts`.`SUM_NO_INDEX_USED` > 0)), '*', '') AS `full_scan`,
       `stmts`.`COUNT_STAR`                                                                       AS `exec_count`,
       `stmts`.`SUM_ERRORS`                                                                       AS `err_count`,
       `stmts`.`SUM_WARNINGS`                                                                     AS `warn_count`,
       `stmts`.`SUM_TIMER_WAIT`                                                                   AS `total_latency`,
       `stmts`.`MAX_TIMER_WAIT`                                                                   AS `max_latency`,
       `stmts`.`AVG_TIMER_WAIT`                                                                   AS `avg_latency`,
       `stmts`.`SUM_ROWS_SENT`                                                                    AS `rows_sent`,
       round(ifnull((`stmts`.`SUM_ROWS_SENT` / nullif(`stmts`.`COUNT_STAR`, 0)), 0), 0)           AS `rows_sent_avg`,
       `stmts`.`SUM_ROWS_EXAMINED`                                                                AS `rows_examined`,
       round(ifnull((`stmts`.`SUM_ROWS_EXAMINED` / nullif(`stmts`.`COUNT_STAR`, 0)), 0),
             0)                                                                                   AS `rows_examined_avg`,
       `stmts`.`FIRST_SEEN`                                                                       AS `first_seen`,
       `stmts`.`LAST_SEEN`                                                                        AS `last_seen`,
       `stmts`.`DIGEST`                                                                           AS `digest`
from (`performance_schema`.`events_statements_summary_by_digest` `stmts`
         join `sys`.`x$ps_digest_95th_percentile_by_avg_us` `top_percentile`
              on ((round((`stmts`.`AVG_TIMER_WAIT` / 1000000), 0) >= `sys`.`top_percentile`.`avg_us`)))
order by `stmts`.`AVG_TIMER_WAIT` desc;

create definer = `mysql.sys`@localhost view sys.x$statements_with_sorting as
	select `performance_schema`.`events_statements_summary_by_digest`.`DIGEST_TEXT`                                  AS `query`,
       `performance_schema`.`events_statements_summary_by_digest`.`SCHEMA_NAME`                                  AS `db`,
       `performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`                                   AS `exec_count`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_TIMER_WAIT`                               AS `total_latency`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_SORT_MERGE_PASSES`                        AS `sort_merge_passes`,
       round(ifnull((`performance_schema`.`events_statements_summary_by_digest`.`SUM_SORT_MERGE_PASSES` /
                     nullif(`performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`, 0)), 0),
             0)                                                                                                  AS `avg_sort_merges`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_SORT_SCAN`                                AS `sorts_using_scans`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_SORT_RANGE`                               AS `sort_using_range`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_SORT_ROWS`                                AS `rows_sorted`,
       round(ifnull((`performance_schema`.`events_statements_summary_by_digest`.`SUM_SORT_ROWS` /
                     nullif(`performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`, 0)), 0),
             0)                                                                                                  AS `avg_rows_sorted`,
       `performance_schema`.`events_statements_summary_by_digest`.`FIRST_SEEN`                                   AS `first_seen`,
       `performance_schema`.`events_statements_summary_by_digest`.`LAST_SEEN`                                    AS `last_seen`,
       `performance_schema`.`events_statements_summary_by_digest`.`DIGEST`                                       AS `digest`
from `performance_schema`.`events_statements_summary_by_digest`
where (`performance_schema`.`events_statements_summary_by_digest`.`SUM_SORT_ROWS` > 0)
order by `performance_schema`.`events_statements_summary_by_digest`.`SUM_TIMER_WAIT` desc;

create definer = `mysql.sys`@localhost view sys.x$statements_with_temp_tables as
	select `performance_schema`.`events_statements_summary_by_digest`.`DIGEST_TEXT`                                  AS `query`,
       `performance_schema`.`events_statements_summary_by_digest`.`SCHEMA_NAME`                                  AS `db`,
       `performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`                                   AS `exec_count`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_TIMER_WAIT`                               AS `total_latency`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_CREATED_TMP_TABLES`                       AS `memory_tmp_tables`,
       `performance_schema`.`events_statements_summary_by_digest`.`SUM_CREATED_TMP_DISK_TABLES`                  AS `disk_tmp_tables`,
       round(ifnull((`performance_schema`.`events_statements_summary_by_digest`.`SUM_CREATED_TMP_TABLES` /
                     nullif(`performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`, 0)), 0),
             0)                                                                                                  AS `avg_tmp_tables_per_query`,
       round((ifnull((`performance_schema`.`events_statements_summary_by_digest`.`SUM_CREATED_TMP_DISK_TABLES` /
                      nullif(`performance_schema`.`events_statements_summary_by_digest`.`SUM_CREATED_TMP_TABLES`, 0)),
                     0) * 100),
             0)                                                                                                  AS `tmp_tables_to_disk_pct`,
       `performance_schema`.`events_statements_summary_by_digest`.`FIRST_SEEN`                                   AS `first_seen`,
       `performance_schema`.`events_statements_summary_by_digest`.`LAST_SEEN`                                    AS `last_seen`,
       `performance_schema`.`events_statements_summary_by_digest`.`DIGEST`                                       AS `digest`
from `performance_schema`.`events_statements_summary_by_digest`
where (`performance_schema`.`events_statements_summary_by_digest`.`SUM_CREATED_TMP_TABLES` > 0)
order by `performance_schema`.`events_statements_summary_by_digest`.`SUM_CREATED_TMP_DISK_TABLES` desc,
         `performance_schema`.`events_statements_summary_by_digest`.`SUM_CREATED_TMP_TABLES` desc;

create definer = `mysql.sys`@localhost view sys.x$user_summary as
	select if((`performance_schema`.`accounts`.`USER` is null), 'background',
          `performance_schema`.`accounts`.`USER`)                                            AS `user`,
       sum(`sys`.`stmt`.`total`)                                                             AS `statements`,
       sum(`sys`.`stmt`.`total_latency`)                                                     AS `statement_latency`,
       ifnull((sum(`sys`.`stmt`.`total_latency`) / nullif(sum(`sys`.`stmt`.`total`), 0)), 0) AS `statement_avg_latency`,
       sum(`sys`.`stmt`.`full_scans`)                                                        AS `table_scans`,
       sum(`sys`.`io`.`ios`)                                                                 AS `file_ios`,
       sum(`sys`.`io`.`io_latency`)                                                          AS `file_io_latency`,
       sum(`performance_schema`.`accounts`.`CURRENT_CONNECTIONS`)                            AS `current_connections`,
       sum(`performance_schema`.`accounts`.`TOTAL_CONNECTIONS`)                              AS `total_connections`,
       count(distinct `performance_schema`.`accounts`.`HOST`)                                AS `unique_hosts`,
       sum(`sys`.`mem`.`current_allocated`)                                                  AS `current_memory`,
       sum(`sys`.`mem`.`total_allocated`)                                                    AS `total_memory_allocated`
from (((`performance_schema`.`accounts` left join `sys`.`x$user_summary_by_statement_latency` `stmt` on ((
        if((`performance_schema`.`accounts`.`USER` is null), 'background', `performance_schema`.`accounts`.`USER`) =
        `sys`.`stmt`.`user`))) left join `sys`.`x$user_summary_by_file_io` `io` on ((
        if((`performance_schema`.`accounts`.`USER` is null), 'background', `performance_schema`.`accounts`.`USER`) =
        `sys`.`io`.`user`)))
         left join `sys`.`x$memory_by_user_by_current_bytes` `mem`
                   on ((if((`performance_schema`.`accounts`.`USER` is null), 'background',
                           `performance_schema`.`accounts`.`USER`) = `sys`.`mem`.`user`)))
group by if((`performance_schema`.`accounts`.`USER` is null), 'background', `performance_schema`.`accounts`.`USER`)
order by sum(`sys`.`stmt`.`total_latency`) desc;

create definer = `mysql.sys`@localhost view sys.x$user_summary_by_file_io as
	select if((`performance_schema`.`events_waits_summary_by_user_by_event_name`.`USER` is null), 'background',
          `performance_schema`.`events_waits_summary_by_user_by_event_name`.`USER`)            AS `user`,
       sum(`performance_schema`.`events_waits_summary_by_user_by_event_name`.`COUNT_STAR`)     AS `ios`,
       sum(`performance_schema`.`events_waits_summary_by_user_by_event_name`.`SUM_TIMER_WAIT`) AS `io_latency`
from `performance_schema`.`events_waits_summary_by_user_by_event_name`
where (`performance_schema`.`events_waits_summary_by_user_by_event_name`.`EVENT_NAME` like 'wait/io/file/%')
group by if((`performance_schema`.`events_waits_summary_by_user_by_event_name`.`USER` is null), 'background',
            `performance_schema`.`events_waits_summary_by_user_by_event_name`.`USER`)
order by sum(`performance_schema`.`events_waits_summary_by_user_by_event_name`.`SUM_TIMER_WAIT`) desc;

create definer = `mysql.sys`@localhost view sys.x$user_summary_by_file_io_type as
	select if((`performance_schema`.`events_waits_summary_by_user_by_event_name`.`USER` is null), 'background',
          `performance_schema`.`events_waits_summary_by_user_by_event_name`.`USER`)       AS `user`,
       `performance_schema`.`events_waits_summary_by_user_by_event_name`.`EVENT_NAME`     AS `event_name`,
       `performance_schema`.`events_waits_summary_by_user_by_event_name`.`COUNT_STAR`     AS `total`,
       `performance_schema`.`events_waits_summary_by_user_by_event_name`.`SUM_TIMER_WAIT` AS `latency`,
       `performance_schema`.`events_waits_summary_by_user_by_event_name`.`MAX_TIMER_WAIT` AS `max_latency`
from `performance_schema`.`events_waits_summary_by_user_by_event_name`
where ((`performance_schema`.`events_waits_summary_by_user_by_event_name`.`EVENT_NAME` like 'wait/io/file%') and
       (`performance_schema`.`events_waits_summary_by_user_by_event_name`.`COUNT_STAR` > 0))
order by if((`performance_schema`.`events_waits_summary_by_user_by_event_name`.`USER` is null), 'background',
            `performance_schema`.`events_waits_summary_by_user_by_event_name`.`USER`),
         `performance_schema`.`events_waits_summary_by_user_by_event_name`.`SUM_TIMER_WAIT` desc;

create definer = `mysql.sys`@localhost view sys.x$user_summary_by_stages as
	select if((`performance_schema`.`events_stages_summary_by_user_by_event_name`.`USER` is null), 'background',
          `performance_schema`.`events_stages_summary_by_user_by_event_name`.`USER`)       AS `user`,
       `performance_schema`.`events_stages_summary_by_user_by_event_name`.`EVENT_NAME`     AS `event_name`,
       `performance_schema`.`events_stages_summary_by_user_by_event_name`.`COUNT_STAR`     AS `total`,
       `performance_schema`.`events_stages_summary_by_user_by_event_name`.`SUM_TIMER_WAIT` AS `total_latency`,
       `performance_schema`.`events_stages_summary_by_user_by_event_name`.`AVG_TIMER_WAIT` AS `avg_latency`
from `performance_schema`.`events_stages_summary_by_user_by_event_name`
where (`performance_schema`.`events_stages_summary_by_user_by_event_name`.`SUM_TIMER_WAIT` <> 0)
order by if((`performance_schema`.`events_stages_summary_by_user_by_event_name`.`USER` is null), 'background',
            `performance_schema`.`events_stages_summary_by_user_by_event_name`.`USER`),
         `performance_schema`.`events_stages_summary_by_user_by_event_name`.`SUM_TIMER_WAIT` desc;

create definer = `mysql.sys`@localhost view sys.x$user_summary_by_statement_latency as
	select if((`performance_schema`.`events_statements_summary_by_user_by_event_name`.`USER` is null), 'background',
          `performance_schema`.`events_statements_summary_by_user_by_event_name`.`USER`) AS                         `user`,
       sum(
               `performance_schema`.`events_statements_summary_by_user_by_event_name`.`COUNT_STAR`) AS              `total`,
       sum(
               `performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_TIMER_WAIT`) AS          `total_latency`,
       sum(
               `performance_schema`.`events_statements_summary_by_user_by_event_name`.`MAX_TIMER_WAIT`) AS          `max_latency`,
       sum(
               `performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_LOCK_TIME`) AS           `lock_latency`,
       sum(
               `performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_CPU_TIME`) AS            `cpu_latency`,
       sum(
               `performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_ROWS_SENT`) AS           `rows_sent`,
       sum(
               `performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_ROWS_EXAMINED`) AS       `rows_examined`,
       sum(
               `performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_ROWS_AFFECTED`) AS       `rows_affected`,
       (sum(`performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_NO_INDEX_USED`) + sum(
               `performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_NO_GOOD_INDEX_USED`)) AS `full_scans`
from `performance_schema`.`events_statements_summary_by_user_by_event_name`
group by if((`performance_schema`.`events_statements_summary_by_user_by_event_name`.`USER` is null), 'background',
            `performance_schema`.`events_statements_summary_by_user_by_event_name`.`USER`)
order by sum(`performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_TIMER_WAIT`) desc;

create definer = `mysql.sys`@localhost view sys.x$user_summary_by_statement_type as
	select if((`performance_schema`.`events_statements_summary_by_user_by_event_name`.`USER` is null), 'background',
          `performance_schema`.`events_statements_summary_by_user_by_event_name`.`USER`)                 AS `user`,
       substring_index(`performance_schema`.`events_statements_summary_by_user_by_event_name`.`EVENT_NAME`, '/',
                       -(1))                                                                             AS `statement`,
       `performance_schema`.`events_statements_summary_by_user_by_event_name`.`COUNT_STAR`               AS `total`,
       `performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_TIMER_WAIT`           AS `total_latency`,
       `performance_schema`.`events_statements_summary_by_user_by_event_name`.`MAX_TIMER_WAIT`           AS `max_latency`,
       `performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_LOCK_TIME`            AS `lock_latency`,
       `performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_CPU_TIME`             AS `cpu_latency`,
       `performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_ROWS_SENT`            AS `rows_sent`,
       `performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_ROWS_EXAMINED`        AS `rows_examined`,
       `performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_ROWS_AFFECTED`        AS `rows_affected`,
       (`performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_NO_INDEX_USED` +
        `performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_NO_GOOD_INDEX_USED`) AS `full_scans`
from `performance_schema`.`events_statements_summary_by_user_by_event_name`
where (`performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_TIMER_WAIT` <> 0)
order by if((`performance_schema`.`events_statements_summary_by_user_by_event_name`.`USER` is null), 'background',
            `performance_schema`.`events_statements_summary_by_user_by_event_name`.`USER`),
         `performance_schema`.`events_statements_summary_by_user_by_event_name`.`SUM_TIMER_WAIT` desc;

create definer = `mysql.sys`@localhost view sys.x$wait_classes_global_by_avg_latency as
	select substring_index(`performance_schema`.`events_waits_summary_global_by_event_name`.`EVENT_NAME`, '/',
                       3)                                                                                         AS `event_class`,
       sum(
               `performance_schema`.`events_waits_summary_global_by_event_name`.`COUNT_STAR`)                     AS `total`,
       sum(
               `performance_schema`.`events_waits_summary_global_by_event_name`.`SUM_TIMER_WAIT`)                 AS `total_latency`,
       min(
               `performance_schema`.`events_waits_summary_global_by_event_name`.`MIN_TIMER_WAIT`)                 AS `min_latency`,
       ifnull((sum(`performance_schema`.`events_waits_summary_global_by_event_name`.`SUM_TIMER_WAIT`) /
               nullif(sum(`performance_schema`.`events_waits_summary_global_by_event_name`.`COUNT_STAR`), 0)),
              0)                                                                                                  AS `avg_latency`,
       max(
               `performance_schema`.`events_waits_summary_global_by_event_name`.`MAX_TIMER_WAIT`)                 AS `max_latency`
from `performance_schema`.`events_waits_summary_global_by_event_name`
where ((`performance_schema`.`events_waits_summary_global_by_event_name`.`SUM_TIMER_WAIT` > 0) and
       (`performance_schema`.`events_waits_summary_global_by_event_name`.`EVENT_NAME` <> 'idle'))
group by `event_class`
order by ifnull((sum(`performance_schema`.`events_waits_summary_global_by_event_name`.`SUM_TIMER_WAIT`) /
                 nullif(sum(`performance_schema`.`events_waits_summary_global_by_event_name`.`COUNT_STAR`), 0)),
                0) desc;

create definer = `mysql.sys`@localhost view sys.x$wait_classes_global_by_latency as
	select substring_index(`performance_schema`.`events_waits_summary_global_by_event_name`.`EVENT_NAME`, '/',
                       3)                                                                                         AS `event_class`,
       sum(
               `performance_schema`.`events_waits_summary_global_by_event_name`.`COUNT_STAR`)                     AS `total`,
       sum(
               `performance_schema`.`events_waits_summary_global_by_event_name`.`SUM_TIMER_WAIT`)                 AS `total_latency`,
       min(
               `performance_schema`.`events_waits_summary_global_by_event_name`.`MIN_TIMER_WAIT`)                 AS `min_latency`,
       ifnull((sum(`performance_schema`.`events_waits_summary_global_by_event_name`.`SUM_TIMER_WAIT`) /
               nullif(sum(`performance_schema`.`events_waits_summary_global_by_event_name`.`COUNT_STAR`), 0)),
              0)                                                                                                  AS `avg_latency`,
       max(
               `performance_schema`.`events_waits_summary_global_by_event_name`.`MAX_TIMER_WAIT`)                 AS `max_latency`
from `performance_schema`.`events_waits_summary_global_by_event_name`
where ((`performance_schema`.`events_waits_summary_global_by_event_name`.`SUM_TIMER_WAIT` > 0) and
       (`performance_schema`.`events_waits_summary_global_by_event_name`.`EVENT_NAME` <> 'idle'))
group by substring_index(`performance_schema`.`events_waits_summary_global_by_event_name`.`EVENT_NAME`, '/', 3)
order by sum(`performance_schema`.`events_waits_summary_global_by_event_name`.`SUM_TIMER_WAIT`) desc;

create definer = `mysql.sys`@localhost view sys.x$waits_by_host_by_latency as
	select if((`performance_schema`.`events_waits_summary_by_host_by_event_name`.`HOST` is null), 'background',
          `performance_schema`.`events_waits_summary_by_host_by_event_name`.`HOST`)       AS `host`,
       `performance_schema`.`events_waits_summary_by_host_by_event_name`.`EVENT_NAME`     AS `event`,
       `performance_schema`.`events_waits_summary_by_host_by_event_name`.`COUNT_STAR`     AS `total`,
       `performance_schema`.`events_waits_summary_by_host_by_event_name`.`SUM_TIMER_WAIT` AS `total_latency`,
       `performance_schema`.`events_waits_summary_by_host_by_event_name`.`AVG_TIMER_WAIT` AS `avg_latency`,
       `performance_schema`.`events_waits_summary_by_host_by_event_name`.`MAX_TIMER_WAIT` AS `max_latency`
from `performance_schema`.`events_waits_summary_by_host_by_event_name`
where ((`performance_schema`.`events_waits_summary_by_host_by_event_name`.`EVENT_NAME` <> 'idle') and
       (`performance_schema`.`events_waits_summary_by_host_by_event_name`.`SUM_TIMER_WAIT` > 0))
order by if((`performance_schema`.`events_waits_summary_by_host_by_event_name`.`HOST` is null), 'background',
            `performance_schema`.`events_waits_summary_by_host_by_event_name`.`HOST`),
         `performance_schema`.`events_waits_summary_by_host_by_event_name`.`SUM_TIMER_WAIT` desc;

create definer = `mysql.sys`@localhost view sys.x$waits_by_user_by_latency as
	select if((`performance_schema`.`events_waits_summary_by_user_by_event_name`.`USER` is null), 'background',
          `performance_schema`.`events_waits_summary_by_user_by_event_name`.`USER`)       AS `user`,
       `performance_schema`.`events_waits_summary_by_user_by_event_name`.`EVENT_NAME`     AS `event`,
       `performance_schema`.`events_waits_summary_by_user_by_event_name`.`COUNT_STAR`     AS `total`,
       `performance_schema`.`events_waits_summary_by_user_by_event_name`.`SUM_TIMER_WAIT` AS `total_latency`,
       `performance_schema`.`events_waits_summary_by_user_by_event_name`.`AVG_TIMER_WAIT` AS `avg_latency`,
       `performance_schema`.`events_waits_summary_by_user_by_event_name`.`MAX_TIMER_WAIT` AS `max_latency`
from `performance_schema`.`events_waits_summary_by_user_by_event_name`
where ((`performance_schema`.`events_waits_summary_by_user_by_event_name`.`EVENT_NAME` <> 'idle') and
       (`performance_schema`.`events_waits_summary_by_user_by_event_name`.`USER` is not null) and
       (`performance_schema`.`events_waits_summary_by_user_by_event_name`.`SUM_TIMER_WAIT` > 0))
order by if((`performance_schema`.`events_waits_summary_by_user_by_event_name`.`USER` is null), 'background',
            `performance_schema`.`events_waits_summary_by_user_by_event_name`.`USER`),
         `performance_schema`.`events_waits_summary_by_user_by_event_name`.`SUM_TIMER_WAIT` desc;

create definer = `mysql.sys`@localhost view sys.x$waits_global_by_latency as
	select `performance_schema`.`events_waits_summary_global_by_event_name`.`EVENT_NAME`     AS `event`,
       `performance_schema`.`events_waits_summary_global_by_event_name`.`COUNT_STAR`     AS `total`,
       `performance_schema`.`events_waits_summary_global_by_event_name`.`SUM_TIMER_WAIT` AS `total_latency`,
       `performance_schema`.`events_waits_summary_global_by_event_name`.`AVG_TIMER_WAIT` AS `avg_latency`,
       `performance_schema`.`events_waits_summary_global_by_event_name`.`MAX_TIMER_WAIT` AS `max_latency`
from `performance_schema`.`events_waits_summary_global_by_event_name`
where ((`performance_schema`.`events_waits_summary_global_by_event_name`.`EVENT_NAME` <> 'idle') and
       (`performance_schema`.`events_waits_summary_global_by_event_name`.`SUM_TIMER_WAIT` > 0))
order by `performance_schema`.`events_waits_summary_global_by_event_name`.`SUM_TIMER_WAIT` desc;

create definer = `mysql.sys`@localhost procedure sys.create_synonym_db(IN in_db_name varchar(64), IN in_synonym varchar(64)) comment '
Description
-----------

Takes a source database name and synonym name, and then creates the 
synonym database with views that point to all of the tables within
the source database.

Useful for creating a "ps" synonym for "performance_schema",
or "is" instead of "information_schema", for example.

Parameters
-----------

in_db_name (VARCHAR(64)):
  The database name that you would like to create a synonym for.
in_synonym (VARCHAR(64)):
  The database synonym name.

Example
-----------

mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
| test               |
+--------------------+
5 rows in set (0.00 sec)

mysql> CALL sys.create_synonym_db(''performance_schema'', ''ps'');
+---------------------------------------+
| summary                               |
+---------------------------------------+
| Created 74 views in the `ps` database |
+---------------------------------------+
1 row in set (8.57 sec)

Query OK, 0 rows affected (8.57 sec)

mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| ps                 |
| sys                |
| test               |
+--------------------+
6 rows in set (0.00 sec)

mysql> SHOW FULL TABLES FROM ps;
+------------------------------------------------------+------------+
| Tables_in_ps                                         | Table_type |
+------------------------------------------------------+------------+
| accounts                                             | VIEW       |
| cond_instances                                       | VIEW       |
| events_stages_current                                | VIEW       |
| events_stages_history                                | VIEW       |
...
' security invoker modifies sql data
BEGIN
    DECLARE v_done bool DEFAULT FALSE;
    DECLARE v_db_name_check VARCHAR(64);
    DECLARE v_db_err_msg TEXT;
    DECLARE v_table VARCHAR(64);
    DECLARE v_views_created INT DEFAULT 0;
    DECLARE db_doesnt_exist CONDITION FOR SQLSTATE '42000';
    DECLARE db_name_exists CONDITION FOR SQLSTATE 'HY000';
    DECLARE c_table_names CURSOR FOR 
        SELECT TABLE_NAME 
          FROM INFORMATION_SCHEMA.TABLES 
         WHERE TABLE_SCHEMA = in_db_name;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = TRUE;
    -- Check if the source database exists
    SELECT SCHEMA_NAME INTO v_db_name_check
      FROM INFORMATION_SCHEMA.SCHEMATA
     WHERE SCHEMA_NAME = in_db_name;
    IF v_db_name_check IS NULL THEN
        SET v_db_err_msg = CONCAT('Unknown database ', in_db_name);
        SIGNAL SQLSTATE 'HY000'
            SET MESSAGE_TEXT = v_db_err_msg;
    END IF;
    -- Check if a database of the synonym name already exists
    SELECT SCHEMA_NAME INTO v_db_name_check
      FROM INFORMATION_SCHEMA.SCHEMATA
     WHERE SCHEMA_NAME = in_synonym;
    IF v_db_name_check = in_synonym THEN
        SET v_db_err_msg = CONCAT('Can\'t create database ', in_synonym, '; database exists');
        SIGNAL SQLSTATE 'HY000'
            SET MESSAGE_TEXT = v_db_err_msg;
    END IF;
    -- All good, create the database and views
    SET @create_db_stmt := CONCAT('CREATE DATABASE ', sys.quote_identifier(in_synonym));
    PREPARE create_db_stmt FROM @create_db_stmt;
    EXECUTE create_db_stmt;
    DEALLOCATE PREPARE create_db_stmt;
    SET v_done = FALSE;
    OPEN c_table_names;
    c_table_names: LOOP
        FETCH c_table_names INTO v_table;
        IF v_done THEN
            LEAVE c_table_names;
        END IF;
        SET @create_view_stmt = CONCAT(
            'CREATE SQL SECURITY INVOKER VIEW ',
            sys.quote_identifier(in_synonym),
            '.',
            sys.quote_identifier(v_table),
            ' AS SELECT * FROM ',
            sys.quote_identifier(in_db_name),
            '.',
            sys.quote_identifier(v_table)
        );
        PREPARE create_view_stmt FROM @create_view_stmt;
        EXECUTE create_view_stmt;
        DEALLOCATE PREPARE create_view_stmt;
        SET v_views_created = v_views_created + 1;
    END LOOP;
    CLOSE c_table_names;
    SELECT CONCAT(
        'Created ', v_views_created, ' view',
        IF(v_views_created != 1, 's', ''), ' in the ',
        sys.quote_identifier(in_synonym), ' database'
    ) AS summary;
END;

create definer = `mysql.sys`@localhost procedure sys.diagnostics(IN in_max_runtime int unsigned, IN in_interval int unsigned, IN in_auto_config enum('current', 'medium', 'full')) comment '
Description
-----------

Create a report of the current status of the server for diagnostics purposes. Data collected includes (some items depends on versions and settings):

   * The GLOBAL VARIABLES
   * Several sys schema views including metrics or equivalent (depending on version and settings)
   * Queries in the 95th percentile
   * Several ndbinfo views for MySQL Cluster
   * Replication (both master and slave) information.

Some of the sys schema views are calculated as initial (optional), overall, delta:

   * The initial view is the content of the view at the start of this procedure.
     This output will be the same as the the start values used for the delta view.
     The initial view is included if @sys.diagnostics.include_raw = ''ON''.
   * The overall view is the content of the view at the end of this procedure.
     This output is the same as the end values used for the delta view.
     The overall view is always included.
   * The delta view is the difference from the beginning to the end. Note that for min and max values
     they are simply the min or max value from the end view respectively, so does not necessarily reflect
     the minimum/maximum value in the monitored period.
     Note: except for the metrics views the delta is only calculation between the first and last outputs.

Requires the SUPER privilege for "SET sql_log_bin = 0;".

Parameters
-----------

in_max_runtime (INT UNSIGNED):
  The maximum time to keep collecting data.
  Use NULL to get the default which is 60 seconds, otherwise enter a value greater than 0.
in_interval (INT UNSIGNED):
  How long to sleep between data collections.
  Use NULL to get the default which is 30 seconds, otherwise enter a value greater than 0.
in_auto_config (ENUM(''current'', ''medium'', ''full''))
  Automatically enable Performance Schema instruments and consumers.
  NOTE: The more that are enabled, the more impact on the performance.
  Supported values are:
     * current - use the current settings.
     * medium - enable some settings. This requires the SUPER privilege.
     * full - enables all settings. This will have a big impact on the
              performance - be careful using this option. This requires
              the SUPER privilege.
  If another setting the ''current'' is chosen, the current settings
  are restored at the end of the procedure.


Configuration Options
----------------------

sys.diagnostics.allow_i_s_tables
  Specifies whether it is allowed to do table scan queries on information_schema.TABLES. This can be expensive if there
  are many tables. Set to ''ON'' to allow, ''OFF'' to not allow.
  Default is ''OFF''.

sys.diagnostics.include_raw
  Set to ''ON'' to include the raw data (e.g. the original output of "SELECT * FROM sys.metrics").
  Use this to get the initial values of the various views.
  Default is ''OFF''.

sys.statement_truncate_len
  How much of queries in the process list output to include.
  Default is 64.

sys.debug
  Whether to provide debugging output.
  Default is ''OFF''. Set to ''ON'' to include.


Example
--------

To create a report and append it to the file diag.out:

mysql> TEE diag.out;
mysql> CALL sys.diagnostics(120, 30, ''current'');
...
mysql> NOTEE;
' security invoker reads sql data
BEGIN
    DECLARE v_start, v_runtime, v_iter_start, v_sleep DECIMAL(20,2) DEFAULT 0.0;
    DECLARE v_has_innodb, v_has_ndb, v_has_ps, v_has_replication, v_has_ps_replication VARCHAR(8) CHARSET utf8mb4 DEFAULT 'NO';
    DECLARE v_this_thread_enabled  ENUM('YES', 'NO');
    DECLARE v_table_name, v_banner VARCHAR(64) CHARSET utf8mb4;
    DECLARE v_sql_status_summary_select, v_sql_status_summary_delta, v_sql_status_summary_from, v_no_delta_names TEXT;
    DECLARE v_output_time, v_output_time_prev DECIMAL(20,3) UNSIGNED;
    DECLARE v_output_count, v_count, v_old_group_concat_max_len INT UNSIGNED DEFAULT 0;
    -- The width of each of the status outputs in the summery
    DECLARE v_status_summary_width TINYINT UNSIGNED DEFAULT 50;
    DECLARE v_done BOOLEAN DEFAULT FALSE;
    -- Do not include the following ndbinfo views:
    --    'blocks'                    Static
    --    'config_params'             Static
    --    'dict_obj_types'            Static
    --    'disk_write_speed_base'     Can generate lots of output - only include aggregate views here
    --    'memory_per_fragment'       Can generate lots of output
    --    'memoryusage'               Handled separately
    --    'operations_per_fragment'   Can generate lots of output
    --    'threadblocks'              Only needed once
    DECLARE c_ndbinfo CURSOR FOR
        SELECT TABLE_NAME
          FROM information_schema.TABLES
         WHERE TABLE_SCHEMA = 'ndbinfo'
               AND TABLE_NAME NOT IN (
                  'blocks',
                  'config_params',
                  'dict_obj_types',
                  'disk_write_speed_base',
                  'memory_per_fragment',
                  'memoryusage',
                  'operations_per_fragment',
                  'threadblocks'
               );
    DECLARE c_sysviews_w_delta CURSOR FOR
        SELECT table_name
          FROM tmp_sys_views_delta
         ORDER BY table_name;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = TRUE;
    -- Do not track the current thread - no reason to clutter the output
    SELECT INSTRUMENTED INTO v_this_thread_enabled FROM performance_schema.threads WHERE PROCESSLIST_ID = CONNECTION_ID();
    IF (v_this_thread_enabled = 'YES') THEN
        CALL sys.ps_setup_disable_thread(CONNECTION_ID());
    END IF;
    -- Check options are sane
    IF (in_max_runtime < in_interval) THEN
        SIGNAL SQLSTATE '45000'
           SET MESSAGE_TEXT = 'in_max_runtime must be greater than or equal to in_interval';
    END IF;
    IF (in_max_runtime = 0) THEN
        SIGNAL SQLSTATE '45000'
           SET MESSAGE_TEXT = 'in_max_runtime must be greater than 0';
    END IF;
    IF (in_interval = 0) THEN
        SIGNAL SQLSTATE '45000'
           SET MESSAGE_TEXT = 'in_interval must be greater than 0';
    END IF;
    -- Set configuration options
    IF (@sys.diagnostics.allow_i_s_tables IS NULL) THEN
        SET @sys.diagnostics.allow_i_s_tables = sys.sys_get_config('diagnostics.allow_i_s_tables', 'OFF');
    END IF;
    IF (@sys.diagnostics.include_raw IS NULL) THEN
        SET @sys.diagnostics.include_raw      = sys.sys_get_config('diagnostics.include_raw'     , 'OFF');
    END IF;
    IF (@sys.debug IS NULL) THEN
        SET @sys.debug                        = sys.sys_get_config('debug'                       , 'OFF');
    END IF;
    IF (@sys.statement_truncate_len IS NULL) THEN
        SET @sys.statement_truncate_len       = sys.sys_get_config('statement_truncate_len'      , '64' );
    END IF;
    -- Temporary table are used - disable sql_log_bin if necessary to prevent them replicating
    SET @log_bin := @@sql_log_bin;
    IF ((@log_bin = 1) AND (@@binlog_format = 'STATEMENT')) THEN
        SET sql_log_bin = 0;
    END IF;
    -- Some metrics variables doesn't make sense in delta and rate calculations even if they are numeric
    -- as they really are more like settings or "current" status.
    SET v_no_delta_names = CONCAT('s%{COUNT}.Variable_name NOT IN (',
        '''innodb_buffer_pool_pages_total'', ',
        '''innodb_page_size'', ',
        '''last_query_cost'', ',
        '''last_query_partial_plans'', ',
        '''qcache_total_blocks'', ',
        '''slave_last_heartbeat'', ',
        '''ssl_ctx_verify_depth'', ',
        '''ssl_ctx_verify_mode'', ',
        '''ssl_session_cache_size'', ',
        '''ssl_verify_depth'', ',
        '''ssl_verify_mode'', ',
        '''ssl_version'', ',
        '''buffer_flush_lsn_avg_rate'', ',
        '''buffer_flush_pct_for_dirty'', ',
        '''buffer_flush_pct_for_lsn'', ',
        '''buffer_pool_pages_total'', ',
        '''lock_row_lock_time_avg'', ',
        '''lock_row_lock_time_max'', ',
        '''innodb_page_size''',
    ')');
    IF (in_auto_config <> 'current') THEN
        IF (@sys.debug = 'ON') THEN
            SELECT CONCAT('Updating Performance Schema configuration to ', in_auto_config) AS 'Debug';
        END IF;
        CALL sys.ps_setup_save(0);
        IF (in_auto_config = 'medium') THEN
            -- Enable all consumers except %history and %history_long
            UPDATE performance_schema.setup_consumers
                SET ENABLED = 'YES'
            WHERE NAME NOT LIKE '%\_history%';
            -- Enable all instruments except wait/synch/%
            UPDATE performance_schema.setup_instruments
                SET ENABLED = 'YES',
                    TIMED   = 'YES'
            WHERE NAME NOT LIKE 'wait/synch/%';
        ELSEIF (in_auto_config = 'full') THEN
            UPDATE performance_schema.setup_consumers
                SET ENABLED = 'YES';
            UPDATE performance_schema.setup_instruments
                SET ENABLED = 'YES',
                    TIMED   = 'YES';
        END IF;
        -- Enable all threads except this one
        UPDATE performance_schema.threads
           SET INSTRUMENTED = 'YES'
         WHERE PROCESSLIST_ID <> CONNECTION_ID();
    END IF;
    SET v_start        = UNIX_TIMESTAMP(NOW(2)),
        in_interval    = IFNULL(in_interval, 30),
        in_max_runtime = IFNULL(in_max_runtime, 60);
    -- Get a quick ref with hostname, server UUID, and the time for the report.
    SET v_banner = REPEAT(
                      '-',
                      LEAST(
                         GREATEST(
                            36,
                            CHAR_LENGTH(VERSION()),
                            CHAR_LENGTH(@@global.version_comment),
                            CHAR_LENGTH(@@global.version_compile_os),
                            CHAR_LENGTH(@@global.version_compile_machine),
                            CHAR_LENGTH(@@global.socket),
                            CHAR_LENGTH(@@global.datadir)
                         ),
                         64
                      )
                   );
    SELECT 'Hostname' AS 'Name', @@global.hostname AS 'Value'
    UNION ALL
    SELECT 'Port' AS 'Name', @@global.port AS 'Value'
    UNION ALL
    SELECT 'Socket' AS 'Name', @@global.socket AS 'Value'
    UNION ALL
    SELECT 'Datadir' AS 'Name', @@global.datadir AS 'Value'
    UNION ALL
    SELECT 'Server UUID' AS 'Name', @@global.server_uuid AS 'Value'
    UNION ALL
    SELECT REPEAT('-', 23) AS 'Name', v_banner AS 'Value'
    UNION ALL
    SELECT 'MySQL Version' AS 'Name', VERSION() AS 'Value'
    UNION ALL
    SELECT 'Sys Schema Version' AS 'Name', (SELECT sys_version FROM sys.version) AS 'Value'
    UNION ALL
    SELECT 'Version Comment' AS 'Name', @@global.version_comment AS 'Value'
    UNION ALL
    SELECT 'Version Compile OS' AS 'Name', @@global.version_compile_os AS 'Value'
    UNION ALL
    SELECT 'Version Compile Machine' AS 'Name', @@global.version_compile_machine AS 'Value'
    UNION ALL
    SELECT REPEAT('-', 23) AS 'Name', v_banner AS 'Value'
    UNION ALL
    SELECT 'UTC Time' AS 'Name', UTC_TIMESTAMP() AS 'Value'
    UNION ALL
    SELECT 'Local Time' AS 'Name', NOW() AS 'Value'
    UNION ALL
    SELECT 'Time Zone' AS 'Name', @@global.time_zone AS 'Value'
    UNION ALL
    SELECT 'System Time Zone' AS 'Name', @@global.system_time_zone AS 'Value'
    UNION ALL
    SELECT 'Time Zone Offset' AS 'Name', TIMEDIFF(NOW(), UTC_TIMESTAMP()) AS 'Value';
    -- Are the InnoDB, NDBCluster, and Performance Schema storage engines present?
    SET v_has_innodb         = IFNULL((SELECT SUPPORT FROM information_schema.ENGINES WHERE ENGINE = 'InnoDB'), 'NO'),
        v_has_ndb            = IFNULL((SELECT SUPPORT FROM information_schema.ENGINES WHERE ENGINE = 'NDBCluster'), 'NO'),
        v_has_ps             = IFNULL((SELECT SUPPORT FROM information_schema.ENGINES WHERE ENGINE = 'PERFORMANCE_SCHEMA'), 'NO'),
        v_has_ps_replication = v_has_ps,
        v_has_replication    = IF(v_has_ps_replication = 'YES', IF((SELECT COUNT(*) FROM performance_schema.replication_connection_status) > 0, 'YES', 'NO'),
                                  IF(@@master_info_repository = 'TABLE', IF((SELECT COUNT(*) FROM mysql.slave_master_info) > 0, 'YES', 'NO'),
                                     IF(@@relay_log_info_repository = 'TABLE', IF((SELECT COUNT(*) FROM mysql.slave_relay_log_info) > 0, 'YES', 'NO'),
                                        'MAYBE')));
    IF (@sys.debug = 'ON') THEN
       SELECT v_has_innodb AS 'Has_InnoDB', v_has_ndb AS 'Has_NDBCluster',
              v_has_ps AS 'Has_Performance_Schema',
              v_has_ps_replication 'AS Has_P_S_Replication', v_has_replication AS 'Has_Replication';
    END IF;
    IF (v_has_innodb IN ('DEFAULT', 'YES')) THEN
        -- Need to use prepared statement as just having the query as a plain command
        -- will generate an error if the InnoDB storage engine is not present
        SET @sys.diagnostics.sql = 'SHOW ENGINE InnoDB STATUS';
        PREPARE stmt_innodb_status FROM @sys.diagnostics.sql;
    END IF;
    IF (v_has_ps = 'YES') THEN
        -- Need to use prepared statement as just having the query as a plain command
        -- will generate an error if the InnoDB storage engine is not present
        SET @sys.diagnostics.sql = 'SHOW ENGINE PERFORMANCE_SCHEMA STATUS';
        PREPARE stmt_ps_status FROM @sys.diagnostics.sql;
    END IF;
    IF (v_has_ndb IN ('DEFAULT', 'YES')) THEN
        -- Need to use prepared statement as just having the query as a plain command
        -- will generate an error if the NDBCluster storage engine is not present
        SET @sys.diagnostics.sql = 'SHOW ENGINE NDBCLUSTER STATUS';
        PREPARE stmt_ndbcluster_status FROM @sys.diagnostics.sql;
    END IF;
    SET @sys.diagnostics.sql_gen_query_template = 'SELECT CONCAT(
           ''SELECT '',
           GROUP_CONCAT(
               CASE WHEN (SUBSTRING(TABLE_NAME, 3), COLUMN_NAME) IN (
                                (''io_global_by_file_by_bytes'', ''total''),
                                (''io_global_by_wait_by_bytes'', ''total_requested'')
                         )
                         THEN CONCAT(''format_bytes('', COLUMN_NAME, '') AS '', COLUMN_NAME)
                    WHEN COLUMN_NAME LIKE ''%latency''
                         THEN CONCAT(''format_pico_time('', COLUMN_NAME, '') AS '', COLUMN_NAME)
                    WHEN SUBSTRING(COLUMN_NAME, -7) = ''_memory'' OR SUBSTRING(COLUMN_NAME, -17) = ''_memory_allocated''
                         OR ((SUBSTRING(COLUMN_NAME, -5) = ''_read'' OR SUBSTRING(COLUMN_NAME, -8) = ''_written'' OR SUBSTRING(COLUMN_NAME, -6) = ''_write'') AND SUBSTRING(COLUMN_NAME, 1, 6) <> ''COUNT_'')
                         THEN CONCAT(''format_bytes('', COLUMN_NAME, '') AS '', COLUMN_NAME)
                    ELSE COLUMN_NAME
               END
               ORDER BY ORDINAL_POSITION
               SEPARATOR '',\n       ''
           ),
           ''\n  FROM tmp_'', SUBSTRING(TABLE_NAME FROM 3), ''_%{OUTPUT}''
       ) AS Query INTO @sys.diagnostics.sql_select
  FROM information_schema.COLUMNS
 WHERE TABLE_SCHEMA = ''sys'' AND TABLE_NAME = ?
 GROUP BY TABLE_NAME';
    SET @sys.diagnostics.sql_gen_query_delta = 'SELECT CONCAT(
           ''SELECT '',
           GROUP_CONCAT(
               CASE WHEN FIND_IN_SET(COLUMN_NAME COLLATE utf8mb3_general_ci, diag.pk)
                         THEN COLUMN_NAME
                    WHEN diag.TABLE_NAME = ''io_global_by_file_by_bytes'' AND COLUMN_NAME COLLATE utf8mb3_general_ci = ''write_pct''
                         THEN CONCAT(''IFNULL(ROUND(100-(((e.total_read-IFNULL(s.total_read, 0))'',
                                     ''/NULLIF(((e.total_read-IFNULL(s.total_read, 0))+(e.total_written-IFNULL(s.total_written, 0))), 0))*100), 2), 0.00) AS '',
                                     COLUMN_NAME)
                    WHEN (diag.TABLE_NAME, COLUMN_NAME) IN (
                                (''io_global_by_file_by_bytes'', ''total''),
                                (''io_global_by_wait_by_bytes'', ''total_requested'')
                         )
                         THEN CONCAT(''format_bytes(e.'', COLUMN_NAME, ''-IFNULL(s.'', COLUMN_NAME, '', 0)) AS '', COLUMN_NAME)
                    WHEN SUBSTRING(COLUMN_NAME, 1, 4) IN (''max_'', ''min_'') AND SUBSTRING(COLUMN_NAME, -8) = ''_latency''
                         THEN CONCAT(''format_pico_time(e.'', COLUMN_NAME, '') AS '', COLUMN_NAME)
                    WHEN COLUMN_NAME COLLATE utf8mb3_general_ci = ''avg_latency''
                         THEN CONCAT(''format_pico_time((e.total_latency - IFNULL(s.total_latency, 0))'',
                                     ''/NULLIF(e.total - IFNULL(s.total, 0), 0)) AS '', COLUMN_NAME)
                    WHEN SUBSTRING(COLUMN_NAME, -12) = ''_avg_latency''
                         THEN CONCAT(''format_pico_time((e.'', SUBSTRING(COLUMN_NAME FROM 1 FOR CHAR_LENGTH(COLUMN_NAME)-12), ''_latency - IFNULL(s.'', SUBSTRING(COLUMN_NAME FROM 1 FOR CHAR_LENGTH(COLUMN_NAME)-12), ''_latency, 0))'',
                                     ''/NULLIF(e.'', SUBSTRING(COLUMN_NAME FROM 1 FOR CHAR_LENGTH(COLUMN_NAME)-12), ''s - IFNULL(s.'', SUBSTRING(COLUMN_NAME FROM 1 FOR CHAR_LENGTH(COLUMN_NAME)-12), ''s, 0), 0)) AS '', COLUMN_NAME)
                    WHEN COLUMN_NAME LIKE ''%latency''
                         THEN CONCAT(''format_pico_time(e.'', COLUMN_NAME, '' - IFNULL(s.'', COLUMN_NAME, '', 0)) AS '', COLUMN_NAME)
                    WHEN COLUMN_NAME IN (''avg_read'', ''avg_write'', ''avg_written'')
                         THEN CONCAT(''format_bytes(IFNULL((e.total_'', IF(COLUMN_NAME = ''avg_read'', ''read'', ''written''), ''-IFNULL(s.total_'', IF(COLUMN_NAME = ''avg_read'', ''read'', ''written''), '', 0))'',
                                     ''/NULLIF(e.count_'', IF(COLUMN_NAME = ''avg_read'', ''read'', ''write''), ''-IFNULL(s.count_'', IF(COLUMN_NAME = ''avg_read'', ''read'', ''write''), '', 0), 0), 0)) AS '',
                                     COLUMN_NAME)
                    WHEN SUBSTRING(COLUMN_NAME, -7) = ''_memory'' OR SUBSTRING(COLUMN_NAME, -17) = ''_memory_allocated''
                         OR ((SUBSTRING(COLUMN_NAME, -5) = ''_read'' OR SUBSTRING(COLUMN_NAME, -8) = ''_written'' OR SUBSTRING(COLUMN_NAME, -6) = ''_write'') AND SUBSTRING(COLUMN_NAME, 1, 6) <> ''COUNT_'')
                         THEN CONCAT(''format_bytes(e.'', COLUMN_NAME, '' - IFNULL(s.'', COLUMN_NAME, '', 0)) AS '', COLUMN_NAME)
                    ELSE CONCAT(''(e.'', COLUMN_NAME, '' - IFNULL(s.'', COLUMN_NAME, '', 0)) AS '', COLUMN_NAME)
               END
               ORDER BY ORDINAL_POSITION
               SEPARATOR '',\n       ''
           ),
           ''\n  FROM tmp_'', diag.TABLE_NAME, ''_end e
       LEFT OUTER JOIN tmp_'', diag.TABLE_NAME, ''_start s USING ('', diag.pk, '')''
       ) AS Query INTO @sys.diagnostics.sql_select
  FROM tmp_sys_views_delta diag
       INNER JOIN information_schema.COLUMNS c ON c.TABLE_NAME COLLATE utf8mb3_general_ci = CONCAT(''x$'', diag.TABLE_NAME)
 WHERE c.TABLE_SCHEMA = ''sys'' AND diag.TABLE_NAME = ?
 GROUP BY diag.TABLE_NAME';
    IF (v_has_ps = 'YES') THEN
        -- Create temporary table with the ORDER BY clauses. Will be required both for the initial (if included) and end queries
        DROP TEMPORARY TABLE IF EXISTS tmp_sys_views_delta;
        CREATE TEMPORARY TABLE tmp_sys_views_delta (
            TABLE_NAME varchar(64) NOT NULL,
            order_by text COMMENT 'ORDER BY clause for the initial and overall views',
            order_by_delta text COMMENT 'ORDER BY clause for the delta views',
            where_delta text COMMENT 'WHERE clause to use for delta views to only include rows with a "count" > 0',
            limit_rows int unsigned COMMENT 'The maximum number of rows to include for the view',
            pk varchar(128) COMMENT 'Used with the FIND_IN_SET() function so use comma separated list without whitespace',
            PRIMARY KEY (TABLE_NAME)
        );
        -- %{OUTPUT} will be replace by the suffix used for the output.
        IF (@sys.debug = 'ON') THEN
            SELECT 'Populating tmp_sys_views_delta' AS 'Debug';
        END IF;
        INSERT INTO tmp_sys_views_delta
        VALUES ('host_summary'                       , '%{TABLE}.statement_latency DESC',
                                                       '(e.statement_latency-IFNULL(s.statement_latency, 0)) DESC',
                                                       '(e.statements - IFNULL(s.statements, 0)) > 0', NULL, 'host'),
               ('host_summary_by_file_io'            , '%{TABLE}.io_latency DESC',
                                                       '(e.io_latency-IFNULL(s.io_latency, 0)) DESC',
                                                       '(e.ios - IFNULL(s.ios, 0)) > 0', NULL, 'host'),
               ('host_summary_by_file_io_type'       , '%{TABLE}.host, %{TABLE}.total_latency DESC',
                                                       'e.host, (e.total_latency-IFNULL(s.total_latency, 0)) DESC',
                                                       '(e.total - IFNULL(s.total, 0)) > 0', NULL, 'host,event_name'),
               ('host_summary_by_stages'             , '%{TABLE}.host, %{TABLE}.total_latency DESC',
                                                       'e.host, (e.total_latency-IFNULL(s.total_latency, 0)) DESC',
                                                       '(e.total - IFNULL(s.total, 0)) > 0', NULL, 'host,event_name'),
               ('host_summary_by_statement_latency'  , '%{TABLE}.total_latency DESC',
                                                       '(e.total_latency-IFNULL(s.total_latency, 0)) DESC',
                                                       '(e.total - IFNULL(s.total, 0)) > 0', NULL, 'host'),
               ('host_summary_by_statement_type'     , '%{TABLE}.host, %{TABLE}.total_latency DESC',
                                                       'e.host, (e.total_latency-IFNULL(s.total_latency, 0)) DESC',
                                                       '(e.total - IFNULL(s.total, 0)) > 0', NULL, 'host,statement'),
               ('io_by_thread_by_latency'            , '%{TABLE}.total_latency DESC',
                                                       '(e.total_latency-IFNULL(s.total_latency, 0)) DESC',
                                                       '(e.total - IFNULL(s.total, 0)) > 0', NULL, 'user,thread_id,processlist_id'),
               ('io_global_by_file_by_bytes'         , '%{TABLE}.total DESC',
                                                       '(e.total-IFNULL(s.total, 0)) DESC',
                                                       '(e.total - IFNULL(s.total, 0)) > 0', 100, 'file'),
               ('io_global_by_file_by_latency'       , '%{TABLE}.total_latency DESC',
                                                       '(e.total_latency-IFNULL(s.total_latency, 0)) DESC',
                                                       '(e.total - IFNULL(s.total, 0)) > 0', 100, 'file'),
               ('io_global_by_wait_by_bytes'         , '%{TABLE}.total_requested DESC',
                                                       '(e.total_requested-IFNULL(s.total_requested, 0)) DESC',
                                                       '(e.total - IFNULL(s.total, 0)) > 0', NULL, 'event_name'),
               ('io_global_by_wait_by_latency'       , '%{TABLE}.total_latency DESC',
                                                       '(e.total_latency-IFNULL(s.total_latency, 0)) DESC',
                                                       '(e.total - IFNULL(s.total, 0)) > 0', NULL, 'event_name'),
               ('schema_index_statistics'            , '(%{TABLE}.select_latency+%{TABLE}.insert_latency+%{TABLE}.update_latency+%{TABLE}.delete_latency) DESC',
                                                       '((e.select_latency+e.insert_latency+e.update_latency+e.delete_latency)-IFNULL(s.select_latency+s.insert_latency+s.update_latency+s.delete_latency, 0)) DESC',
                                                       '((e.rows_selected+e.insert_latency+e.rows_updated+e.rows_deleted)-IFNULL(s.rows_selected+s.rows_inserted+s.rows_updated+s.rows_deleted, 0)) > 0',
                                                       100, 'table_schema,table_name,index_name'),
               ('schema_table_statistics'            , '%{TABLE}.total_latency DESC',
                                                       '(e.total_latency-IFNULL(s.total_latency, 0)) DESC',
                                                       '(e.total_latency-IFNULL(s.total_latency, 0)) > 0', 100, 'table_schema,table_name'),
               ('schema_tables_with_full_table_scans', '%{TABLE}.rows_full_scanned DESC',
                                                       '(e.rows_full_scanned-IFNULL(s.rows_full_scanned, 0)) DESC',
                                                       '(e.rows_full_scanned-IFNULL(s.rows_full_scanned, 0)) > 0', 100, 'object_schema,object_name'),
               ('user_summary'                       , '%{TABLE}.statement_latency DESC',
                                                       '(e.statement_latency-IFNULL(s.statement_latency, 0)) DESC',
                                                       '(e.statements - IFNULL(s.statements, 0)) > 0', NULL, 'user'),
               ('user_summary_by_file_io'            , '%{TABLE}.io_latency DESC',
                                                       '(e.io_latency-IFNULL(s.io_latency, 0)) DESC',
                                                       '(e.ios - IFNULL(s.ios, 0)) > 0', NULL, 'user'),
               ('user_summary_by_file_io_type'       , '%{TABLE}.user, %{TABLE}.latency DESC',
                                                       'e.user, (e.latency-IFNULL(s.latency, 0)) DESC',
                                                       '(e.total - IFNULL(s.total, 0)) > 0', NULL, 'user,event_name'),
               ('user_summary_by_stages'             , '%{TABLE}.user, %{TABLE}.total_latency DESC',
                                                       'e.user, (e.total_latency-IFNULL(s.total_latency, 0)) DESC',
                                                       '(e.total - IFNULL(s.total, 0)) > 0', NULL, 'user,event_name'),
               ('user_summary_by_statement_latency'  , '%{TABLE}.total_latency DESC',
                                                       '(e.total_latency-IFNULL(s.total_latency, 0)) DESC',
                                                       '(e.total - IFNULL(s.total, 0)) > 0', NULL, 'user'),
               ('user_summary_by_statement_type'     , '%{TABLE}.user, %{TABLE}.total_latency DESC',
                                                       'e.user, (e.total_latency-IFNULL(s.total_latency, 0)) DESC',
                                                       '(e.total - IFNULL(s.total, 0)) > 0', NULL, 'user,statement'),
               ('wait_classes_global_by_avg_latency' , 'IFNULL(%{TABLE}.total_latency / NULLIF(%{TABLE}.total, 0), 0) DESC',
                                                       'IFNULL((e.total_latency-IFNULL(s.total_latency, 0)) / NULLIF((e.total - IFNULL(s.total, 0)), 0), 0) DESC',
                                                       '(e.total - IFNULL(s.total, 0)) > 0', NULL, 'event_class'),
               ('wait_classes_global_by_latency'     , '%{TABLE}.total_latency DESC',
                                                       '(e.total_latency-IFNULL(s.total_latency, 0)) DESC',
                                                       '(e.total - IFNULL(s.total, 0)) > 0', NULL, 'event_class'),
               ('waits_by_host_by_latency'           , '%{TABLE}.host, %{TABLE}.total_latency DESC',
                                                       'e.host, (e.total_latency-IFNULL(s.total_latency, 0)) DESC',
                                                       '(e.total - IFNULL(s.total, 0)) > 0', NULL, 'host,event'),
               ('waits_by_user_by_latency'           , '%{TABLE}.user, %{TABLE}.total_latency DESC',
                                                       'e.user, (e.total_latency-IFNULL(s.total_latency, 0)) DESC',
                                                       '(e.total - IFNULL(s.total, 0)) > 0', NULL, 'user,event'),
               ('waits_global_by_latency'            , '%{TABLE}.total_latency DESC',
                                                       '(e.total_latency-IFNULL(s.total_latency, 0)) DESC',
                                                       '(e.total - IFNULL(s.total, 0)) > 0', NULL, 'events')
        ;
    END IF;
    SELECT '

=======================

     Configuration

=======================

' AS '';
    -- Get the configuration.
    SELECT 'GLOBAL VARIABLES' AS 'The following output is:';
    SELECT LOWER(VARIABLE_NAME) AS Variable_name, VARIABLE_VALUE AS Variable_value FROM performance_schema.global_variables ORDER BY VARIABLE_NAME;
    IF (v_has_ps = 'YES') THEN
        -- Overview of the Performance Schema dynamic settings used for this report.
        SELECT 'Performance Schema Setup - Actors' AS 'The following output is:';
        SELECT * FROM performance_schema.setup_actors;
        SELECT 'Performance Schema Setup - Consumers' AS 'The following output is:';
        SELECT NAME AS Consumer, ENABLED, sys.ps_is_consumer_enabled(NAME) AS COLLECTS
          FROM performance_schema.setup_consumers;
        SELECT 'Performance Schema Setup - Instruments' AS 'The following output is:';
        SELECT SUBSTRING_INDEX(NAME, '/', 2) AS 'InstrumentClass',
               ROUND(100*SUM(IF(ENABLED = 'YES', 1, 0))/COUNT(*), 2) AS 'EnabledPct',
               ROUND(100*SUM(IF(TIMED = 'YES', 1, 0))/COUNT(*), 2) AS 'TimedPct'
          FROM performance_schema.setup_instruments
         GROUP BY SUBSTRING_INDEX(NAME, '/', 2)
         ORDER BY SUBSTRING_INDEX(NAME, '/', 2);
        SELECT 'Performance Schema Setup - Objects' AS 'The following output is:';
        SELECT * FROM performance_schema.setup_objects;
        SELECT 'Performance Schema Setup - Threads' AS 'The following output is:';
        SELECT `TYPE` AS ThreadType, COUNT(*) AS 'Total', ROUND(100*SUM(IF(INSTRUMENTED = 'YES', 1, 0))/COUNT(*), 2) AS 'InstrumentedPct'
          FROM performance_schema.threads
        GROUP BY TYPE;
    END IF;
    IF (v_has_replication = 'NO') THEN
        SELECT 'No Replication Configured' AS 'Replication Status';
    ELSE
        -- No guarantee that replication is actually configured, but we can't really know
        SELECT CONCAT('Replication Configured: ', v_has_replication, ' - Performance Schema Replication Tables: ', v_has_ps_replication) AS 'Replication Status';
        IF (v_has_ps_replication = 'YES') THEN
            SELECT 'Replication - Connection Configuration' AS 'The following output is:';
            SELECT * FROM performance_schema.replication_connection_configuration ORDER BY CHANNEL_NAME;
        END IF;
        IF (v_has_ps_replication = 'YES') THEN
            SELECT 'Replication - Applier Configuration' AS 'The following output is:';
            SELECT * FROM performance_schema.replication_applier_configuration ORDER BY CHANNEL_NAME;
        END IF;
        IF (@@master_info_repository = 'TABLE') THEN
            SELECT 'Replication - Master Info Repository Configuration' AS 'The following output is:';
            -- Can't just do SELECT *  as the password may be present in plain text
            -- Don't include binary log file and position as that will be determined in each iteration as well
            SELECT Channel_name, Host, User_name, Port, Connect_retry,
                   Enabled_ssl, Ssl_ca, Ssl_capath, Ssl_cert, Ssl_cipher, Ssl_key, Ssl_verify_server_cert,
                   Heartbeat, Bind, Ignored_server_ids, Uuid, Retry_count, Ssl_crl, Ssl_crlpath,
                   Tls_version, Enabled_auto_position
              FROM mysql.slave_master_info ORDER BY Channel_name;
        END IF;
        IF (@@relay_log_info_repository = 'TABLE') THEN
            SELECT 'Replication - Relay Log Repository Configuration' AS 'The following output is:';
            SELECT Channel_name, Sql_delay, Number_of_workers, Id
              FROM mysql.slave_relay_log_info ORDER BY Channel_name;
        END IF;
    END IF;
    IF (v_has_ndb IN ('DEFAULT', 'YES')) THEN
       SELECT 'Cluster Thread Blocks' AS 'The following output is:';
       SELECT * FROM ndbinfo.threadblocks;
    END IF;
    -- For a number of sys views as well as events_statements_summary_by_digest,
    -- just get the start data and then at the end output the overall and delta values
    IF (v_has_ps = 'YES') THEN
        IF (@sys.diagnostics.include_raw = 'ON') THEN
            SELECT '

========================

     Initial Status

========================

' AS '';
        END IF;
        DROP TEMPORARY TABLE IF EXISTS tmp_digests_start;
        CALL sys.statement_performance_analyzer('create_tmp', 'tmp_digests_start', NULL);
        CALL sys.statement_performance_analyzer('snapshot', NULL, NULL);
        CALL sys.statement_performance_analyzer('save', 'tmp_digests_start', NULL);
        -- Loop over the sys views where deltas should be calculated.
        IF (@sys.diagnostics.include_raw = 'ON') THEN
            SET @sys.diagnostics.sql = REPLACE(@sys.diagnostics.sql_gen_query_template, '%{OUTPUT}', 'start');
            IF (@sys.debug = 'ON') THEN
                SELECT 'The following query will be used to generate the query for each sys view' AS 'Debug';
                SELECT @sys.diagnostics.sql AS 'Debug';
            END IF;
            PREPARE stmt_gen_query FROM @sys.diagnostics.sql;
        END IF;
        SET v_done = FALSE;
        OPEN c_sysviews_w_delta;
        c_sysviews_w_delta_loop: LOOP
            FETCH c_sysviews_w_delta INTO v_table_name;
            IF v_done THEN
                LEAVE c_sysviews_w_delta_loop;
            END IF;
            IF (@sys.debug = 'ON') THEN
                SELECT CONCAT('The following queries are for storing the initial content of ', v_table_name) AS 'Debug';
            END IF;
            CALL sys.execute_prepared_stmt(CONCAT('DROP TEMPORARY TABLE IF EXISTS `tmp_', v_table_name, '_start`'));
            CALL sys.execute_prepared_stmt(CONCAT('CREATE TEMPORARY TABLE `tmp_', v_table_name, '_start` SELECT * FROM `sys`.`x$', v_table_name, '`'));
            IF (@sys.diagnostics.include_raw = 'ON') THEN
                SET @sys.diagnostics.table_name = CONCAT('x$', v_table_name);
                EXECUTE stmt_gen_query USING @sys.diagnostics.table_name;
                -- If necessary add ORDER BY and LIMIT
                SELECT CONCAT(@sys.diagnostics.sql_select,
                              IF(order_by IS NOT NULL, CONCAT('\n ORDER BY ', REPLACE(order_by, '%{TABLE}', CONCAT('tmp_', v_table_name, '_start'))), ''),
                              IF(limit_rows IS NOT NULL, CONCAT('\n LIMIT ', limit_rows), '')
                       )
                  INTO @sys.diagnostics.sql_select
                  FROM tmp_sys_views_delta
                 WHERE TABLE_NAME COLLATE utf8mb4_0900_as_ci = v_table_name;
                SELECT CONCAT('Initial ', v_table_name) AS 'The following output is:';
                CALL sys.execute_prepared_stmt(@sys.diagnostics.sql_select);
            END IF;
        END LOOP;
        CLOSE c_sysviews_w_delta;
        IF (@sys.diagnostics.include_raw = 'ON') THEN
            DEALLOCATE PREPARE stmt_gen_query;
        END IF;
    END IF;
    -- If in_include_status_summary is TRUE then a temporary table is required to store the data
    SET v_sql_status_summary_select = 'SELECT Variable_name',
        v_sql_status_summary_delta  = '',
        v_sql_status_summary_from   = '';
    -- Start the loop
    REPEAT
        SET v_output_count = v_output_count + 1;
        IF (v_output_count > 1) THEN
            -- Don't sleep on the first execution
            SET v_sleep = in_interval-(UNIX_TIMESTAMP(NOW(2))-v_iter_start);
            SELECT NOW() AS 'Time', CONCAT('Going to sleep for ', v_sleep, ' seconds. Please do not interrupt') AS 'The following output is:';
            DO SLEEP(in_interval);
        END IF;
        SET v_iter_start = UNIX_TIMESTAMP(NOW(2));
        SELECT NOW(), CONCAT('Iteration Number ', IFNULL(v_output_count, 'NULL')) AS 'The following output is:';
        -- Even in 5.7 there is no way to get all the info from SHOW MASTER|SLAVE STATUS using the Performance Schema or
        -- other tables, so include them even though they are no longer optimal solutions and if present get the additional
        -- information from the other tables available.
        IF (@@log_bin = 1) THEN
            SELECT 'SHOW MASTER STATUS' AS 'The following output is:';
            SHOW MASTER STATUS;
        END IF;
        IF (v_has_replication <> 'NO') THEN
            SELECT 'SHOW SLAVE STATUS' AS 'The following output is:';
            SHOW SLAVE STATUS;
            IF (v_has_ps_replication = 'YES') THEN
                SELECT 'Replication Connection Status' AS 'The following output is:';
                SELECT * FROM performance_schema.replication_connection_status;
                SELECT 'Replication Applier Status' AS 'The following output is:';
                SELECT * FROM performance_schema.replication_applier_status ORDER BY CHANNEL_NAME;
                SELECT 'Replication Applier Status - Coordinator' AS 'The following output is:';
                SELECT * FROM performance_schema.replication_applier_status_by_coordinator ORDER BY CHANNEL_NAME;
                SELECT 'Replication Applier Status - Worker' AS 'The following output is:';
                SELECT * FROM performance_schema.replication_applier_status_by_worker ORDER BY CHANNEL_NAME, WORKER_ID;
            END IF;
            IF (@@master_info_repository = 'TABLE') THEN
                SELECT 'Replication - Master Log Status' AS 'The following output is:';
                SELECT Master_log_name, Master_log_pos FROM mysql.slave_master_info;
            END IF;
            IF (@@relay_log_info_repository = 'TABLE') THEN
                SELECT 'Replication - Relay Log Status' AS 'The following output is:';
                SELECT sys.format_path(Relay_log_name) AS Relay_log_name, Relay_log_pos, Master_log_name, Master_log_pos FROM mysql.slave_relay_log_info;
                SELECT 'Replication - Worker Status' AS 'The following output is:';
                SELECT Id, sys.format_path(Relay_log_name) AS Relay_log_name, Relay_log_pos, Master_log_name, Master_log_pos,
                       sys.format_path(Checkpoint_relay_log_name) AS Checkpoint_relay_log_name, Checkpoint_relay_log_pos,
                       Checkpoint_master_log_name, Checkpoint_master_log_pos, Checkpoint_seqno, Checkpoint_group_size,
                       HEX(Checkpoint_group_bitmap) AS Checkpoint_group_bitmap, Channel_name
                  FROM mysql.slave_worker_info
              ORDER BY Channel_name, Id;
            END IF;
        END IF;
        -- We need one table per output as a temporary table cannot be opened twice in the same query, and we need to
        -- join the outputs in the summary at the end.
        SET v_table_name = CONCAT('tmp_metrics_', v_output_count);
        CALL sys.execute_prepared_stmt(CONCAT('DROP TEMPORARY TABLE IF EXISTS ', v_table_name));
        -- Currently information_schema.GLOBAL_STATUS has VARIABLE_VALUE as varchar(1024)
        CALL sys.execute_prepared_stmt(CONCAT('CREATE TEMPORARY TABLE ', v_table_name, ' (
  Variable_name VARCHAR(193) NOT NULL,
  Variable_value VARCHAR(1024),
  Type VARCHAR(225) NOT NULL,
  Enabled ENUM(''YES'', ''NO'', ''PARTIAL'') NOT NULL,
  PRIMARY KEY (Type, Variable_name)
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4'));
        SET @sys.diagnostics.sql = CONCAT(
            'INSERT INTO ', v_table_name,
            ' SELECT Variable_name, REPLACE(Variable_value, ''\n'', ''\\\\n'') AS Variable_value, Type, Enabled FROM sys.metrics'
        );
        CALL sys.execute_prepared_stmt(@sys.diagnostics.sql);
        -- Prepare the query to retrieve the summary
        CALL sys.execute_prepared_stmt(
            CONCAT('(SELECT Variable_value INTO @sys.diagnostics.output_time FROM ', v_table_name, ' WHERE Type = ''System Time'' AND Variable_name = ''UNIX_TIMESTAMP()'')')
        );
        SET v_output_time = @sys.diagnostics.output_time;
        -- Limit each value to v_status_summary_width chars (when v_has_ndb = TRUE the values can be very wide - refer to the output here for the full values)
        -- v_sql_status_summary_select, v_sql_status_summary_delta, v_sql_status_summary_from
        SET v_sql_status_summary_select = CONCAT(v_sql_status_summary_select, ',
       CONCAT(
           LEFT(s', v_output_count, '.Variable_value, ', v_status_summary_width, '),
           IF(', REPLACE(v_no_delta_names, '%{COUNT}', v_output_count), ' AND s', v_output_count, '.Variable_value REGEXP ''^[0-9]+(\\\\.[0-9]+)?$'', CONCAT('' ('', ROUND(s', v_output_count, '.Variable_value/', v_output_time, ', 2), ''/sec)''), '''')
       ) AS ''Output ', v_output_count, ''''),
            v_sql_status_summary_from   = CONCAT(v_sql_status_summary_from, '
',
                                                    IF(v_output_count = 1, '  FROM ', '       INNER JOIN '),
                                                    v_table_name, ' s', v_output_count,
                                                    IF (v_output_count = 1, '', ' USING (Type, Variable_name)'));
        IF (v_output_count > 1) THEN
            SET v_sql_status_summary_delta  = CONCAT(v_sql_status_summary_delta, ',
       IF(', REPLACE(v_no_delta_names, '%{COUNT}', v_output_count), ' AND s', (v_output_count-1), '.Variable_value REGEXP ''^[0-9]+(\\\\.[0-9]+)?$'' AND s', v_output_count, '.Variable_value REGEXP ''^[0-9]+(\\\\.[0-9]+)?$'',
          CONCAT(IF(s', (v_output_count-1), '.Variable_value REGEXP ''^[0-9]+\\\\.[0-9]+$'' OR s', v_output_count, '.Variable_value REGEXP ''^[0-9]+\\\\.[0-9]+$'',
                    ROUND((s', v_output_count, '.Variable_value-s', (v_output_count-1), '.Variable_value), 2),
                    (s', v_output_count, '.Variable_value-s', (v_output_count-1), '.Variable_value)
                   ),
                 '' ('', ROUND((s', v_output_count, '.Variable_value-s', (v_output_count-1), '.Variable_value)/(', v_output_time, '-', v_output_time_prev, '), 2), ''/sec)''
          ),
          ''''
       ) AS ''Delta (', (v_output_count-1), ' -> ', v_output_count, ')''');
        END IF;
        SET v_output_time_prev = v_output_time;
        IF (@sys.diagnostics.include_raw = 'ON') THEN
            SELECT 'SELECT * FROM sys.metrics' AS 'The following output is:';
            -- Ensures that the output here is the same as the one used in the status summary at the end
            CALL sys.execute_prepared_stmt(CONCAT('SELECT Type, Variable_name, Enabled, Variable_value FROM ', v_table_name, ' ORDER BY Type, Variable_name'));
        END IF;
        -- InnoDB
        IF (v_has_innodb IN ('DEFAULT', 'YES')) THEN
            SELECT 'SHOW ENGINE INNODB STATUS' AS 'The following output is:';
            EXECUTE stmt_innodb_status;
            SELECT 'InnoDB - Transactions' AS 'The following output is:';
            SELECT * FROM information_schema.INNODB_TRX;
        END IF;
        -- NDBCluster
        IF (v_has_ndb IN ('DEFAULT', 'YES')) THEN
            SELECT 'SHOW ENGINE NDBCLUSTER STATUS' AS 'The following output is:';
            EXECUTE stmt_ndbcluster_status;
            SELECT 'ndbinfo.memoryusage' AS 'The following output is:';
            SELECT node_id, memory_type, format_bytes(used) AS used, used_pages, format_bytes(total) AS total, total_pages,
                   ROUND(100*(used/total), 2) AS 'Used %'
            FROM ndbinfo.memoryusage;
            -- Loop over the ndbinfo tables (except memoryusage which was handled separately above).
            -- The exact tables available are version dependent, so get the list from the Information Schema.
            SET v_done = FALSE;
            OPEN c_ndbinfo;
            c_ndbinfo_loop: LOOP
                FETCH c_ndbinfo INTO v_table_name;
                IF v_done THEN
                LEAVE c_ndbinfo_loop;
                END IF;
                SELECT CONCAT('SELECT * FROM ndbinfo.', v_table_name) AS 'The following output is:';
                CALL sys.execute_prepared_stmt(CONCAT('SELECT * FROM `ndbinfo`.`', v_table_name, '`'));
            END LOOP;
            CLOSE c_ndbinfo;
            SELECT * FROM information_schema.FILES;
        END IF;
        SELECT 'SELECT * FROM sys.processlist' AS 'The following output is:';
        SELECT processlist.* FROM sys.processlist;
        IF (v_has_ps = 'YES') THEN
            -- latest_file_io
            IF (sys.ps_is_consumer_enabled('events_waits_history_long') = 'YES') THEN
                SELECT 'SELECT * FROM sys.latest_file_io' AS 'The following output is:';
                SELECT * FROM sys.latest_file_io;
            END IF;
            -- current memory usage
            IF (EXISTS(SELECT 1 FROM performance_schema.setup_instruments WHERE NAME LIKE 'memory/%' AND ENABLED = 'YES')) THEN
                SELECT 'SELECT * FROM sys.memory_by_host_by_current_bytes' AS 'The following output is:';
                SELECT * FROM sys.memory_by_host_by_current_bytes;
                SELECT 'SELECT * FROM sys.memory_by_thread_by_current_bytes' AS 'The following output is:';
                SELECT * FROM sys.memory_by_thread_by_current_bytes;
                SELECT 'SELECT * FROM sys.memory_by_user_by_current_bytes' AS 'The following output is:';
                SELECT * FROM sys.memory_by_user_by_current_bytes;
                SELECT 'SELECT * FROM sys.memory_global_by_current_bytes' AS 'The following output is:';
                SELECT * FROM sys.memory_global_by_current_bytes;
            END IF;
        END IF;
        SET v_runtime = (UNIX_TIMESTAMP(NOW(2)) - v_start);
    UNTIL (v_runtime + in_interval >= in_max_runtime) END REPEAT;
    -- Get Performance Schema status
    IF (v_has_ps = 'YES') THEN
        SELECT 'SHOW ENGINE PERFORMANCE_SCHEMA STATUS' AS 'The following output is:';
        EXECUTE stmt_ps_status;
    END IF;
    -- Deallocate prepared statements
    IF (v_has_innodb IN ('DEFAULT', 'YES')) THEN
        DEALLOCATE PREPARE stmt_innodb_status;
    END IF;
    IF (v_has_ps = 'YES') THEN
        DEALLOCATE PREPARE stmt_ps_status;
    END IF;
    IF (v_has_ndb IN ('DEFAULT', 'YES')) THEN
        DEALLOCATE PREPARE stmt_ndbcluster_status;
    END IF;
    SELECT '

============================

     Schema Information

============================

' AS '';
    SELECT COUNT(*) AS 'Total Number of Tables' FROM information_schema.TABLES;
    -- The cost of information_schema.TABLES.DATA_LENGTH depends mostly on the number of tables
    IF (@sys.diagnostics.allow_i_s_tables = 'ON') THEN
        SELECT 'Storage Engine Usage' AS 'The following output is:';
        SELECT ENGINE, COUNT(*) AS NUM_TABLES,
                format_bytes(SUM(DATA_LENGTH)) AS DATA_LENGTH,
                format_bytes(SUM(INDEX_LENGTH)) AS INDEX_LENGTH,
                format_bytes(SUM(DATA_LENGTH+INDEX_LENGTH)) AS TOTAL
            FROM information_schema.TABLES
            GROUP BY ENGINE;
        SELECT 'Schema Object Overview' AS 'The following output is:';
        SELECT * FROM sys.schema_object_overview;
        SELECT 'Tables without a PRIMARY KEY' AS 'The following output is:';
        SELECT TABLES.TABLE_SCHEMA, ENGINE, COUNT(*) AS NumTables
          FROM information_schema.TABLES
               LEFT OUTER JOIN information_schema.STATISTICS ON STATISTICS.TABLE_SCHEMA = TABLES.TABLE_SCHEMA
                                                                AND STATISTICS.TABLE_NAME = TABLES.TABLE_NAME
                                                                AND STATISTICS.INDEX_NAME = 'PRIMARY'
         WHERE STATISTICS.TABLE_NAME IS NULL
               AND TABLES.TABLE_SCHEMA NOT IN ('mysql', 'information_schema', 'performance_schema', 'sys')
               AND TABLES.TABLE_TYPE = 'BASE TABLE'
         GROUP BY TABLES.TABLE_SCHEMA, ENGINE;
    END IF;
    IF (v_has_ps = 'YES') THEN
        SELECT 'Unused Indexes' AS 'The following output is:';
        SELECT object_schema, COUNT(*) AS NumUnusedIndexes
          FROM performance_schema.table_io_waits_summary_by_index_usage
         WHERE index_name IS NOT NULL
               AND count_star = 0
               AND object_schema NOT IN ('mysql', 'sys')
               AND index_name != 'PRIMARY'
         GROUP BY object_schema;
    END IF;
    IF (v_has_ps = 'YES') THEN
        SELECT '

=========================

     Overall Status

=========================

' AS '';
        SELECT 'CALL sys.ps_statement_avg_latency_histogram()' AS 'The following output is:';
        CALL sys.ps_statement_avg_latency_histogram();
        CALL sys.statement_performance_analyzer('snapshot', NULL, NULL);
        CALL sys.statement_performance_analyzer('overall', NULL, 'with_runtimes_in_95th_percentile');
        SET @sys.diagnostics.sql = REPLACE(@sys.diagnostics.sql_gen_query_template, '%{OUTPUT}', 'end');
        IF (@sys.debug = 'ON') THEN
            SELECT 'The following query will be used to generate the query for each sys view' AS 'Debug';
            SELECT @sys.diagnostics.sql AS 'Debug';
        END IF;
        PREPARE stmt_gen_query FROM @sys.diagnostics.sql;
        SET v_done = FALSE;
        OPEN c_sysviews_w_delta;
        c_sysviews_w_delta_loop: LOOP
            FETCH c_sysviews_w_delta INTO v_table_name;
            IF v_done THEN
                LEAVE c_sysviews_w_delta_loop;
            END IF;
            IF (@sys.debug = 'ON') THEN
                SELECT CONCAT('The following queries are for storing the final content of ', v_table_name) AS 'Debug';
            END IF;
            CALL sys.execute_prepared_stmt(CONCAT('DROP TEMPORARY TABLE IF EXISTS `tmp_', v_table_name, '_end`'));
            CALL sys.execute_prepared_stmt(CONCAT('CREATE TEMPORARY TABLE `tmp_', v_table_name, '_end` SELECT * FROM `sys`.`x$', v_table_name, '`'));
            SET @sys.diagnostics.table_name = CONCAT('x$', v_table_name);
            EXECUTE stmt_gen_query USING @sys.diagnostics.table_name;
            -- If necessary add ORDER BY and LIMIT
            SELECT CONCAT(@sys.diagnostics.sql_select,
                            IF(order_by IS NOT NULL, CONCAT('\n ORDER BY ', REPLACE(order_by, '%{TABLE}', CONCAT('tmp_', v_table_name, '_end'))), ''),
                            IF(limit_rows IS NOT NULL, CONCAT('\n LIMIT ', limit_rows), '')
                    )
                INTO @sys.diagnostics.sql_select
                FROM tmp_sys_views_delta
                WHERE TABLE_NAME COLLATE utf8mb4_0900_as_ci = v_table_name;
            SELECT CONCAT('Overall ', v_table_name) AS 'The following output is:';
            CALL sys.execute_prepared_stmt(@sys.diagnostics.sql_select);
        END LOOP;
        CLOSE c_sysviews_w_delta;
        DEALLOCATE PREPARE stmt_gen_query;
        SELECT '

======================

     Delta Status

======================

' AS '';
        CALL sys.statement_performance_analyzer('delta', 'tmp_digests_start', 'with_runtimes_in_95th_percentile');
        CALL sys.statement_performance_analyzer('cleanup', NULL, NULL);
        DROP TEMPORARY TABLE tmp_digests_start;
        -- @sys.diagnostics.sql_gen_query_delta is defined near the to together with @sys.diagnostics.sql_gen_query_template
        IF (@sys.debug = 'ON') THEN
            SELECT 'The following query will be used to generate the query for each sys view delta' AS 'Debug';
            SELECT @sys.diagnostics.sql_gen_query_delta AS 'Debug';
        END IF;
        PREPARE stmt_gen_query_delta FROM @sys.diagnostics.sql_gen_query_delta;
        SET v_old_group_concat_max_len = @@session.group_concat_max_len;
        SET @@session.group_concat_max_len = 2048;
        SET v_done = FALSE;
        OPEN c_sysviews_w_delta;
        c_sysviews_w_delta_loop: LOOP
            FETCH c_sysviews_w_delta INTO v_table_name;
            IF v_done THEN
                LEAVE c_sysviews_w_delta_loop;
            END IF;
            SET @sys.diagnostics.table_name = v_table_name;
            EXECUTE stmt_gen_query_delta USING @sys.diagnostics.table_name;
            -- If necessary add WHERE, ORDER BY, and LIMIT
            SELECT CONCAT(@sys.diagnostics.sql_select,
                            IF(where_delta IS NOT NULL, CONCAT('\n WHERE ', where_delta), ''),
                            IF(order_by_delta IS NOT NULL, CONCAT('\n ORDER BY ', order_by_delta), ''),
                            IF(limit_rows IS NOT NULL, CONCAT('\n LIMIT ', limit_rows), '')
                    )
                INTO @sys.diagnostics.sql_select
                FROM tmp_sys_views_delta
                WHERE TABLE_NAME COLLATE utf8mb4_0900_as_ci = v_table_name;
            SELECT CONCAT('Delta ', v_table_name) AS 'The following output is:';
            CALL sys.execute_prepared_stmt(@sys.diagnostics.sql_select);
            CALL sys.execute_prepared_stmt(CONCAT('DROP TEMPORARY TABLE `tmp_', v_table_name, '_end`'));
            CALL sys.execute_prepared_stmt(CONCAT('DROP TEMPORARY TABLE `tmp_', v_table_name, '_start`'));
        END LOOP;
        CLOSE c_sysviews_w_delta;
        SET @@session.group_concat_max_len = v_old_group_concat_max_len;
        DEALLOCATE PREPARE stmt_gen_query_delta;
        DROP TEMPORARY TABLE tmp_sys_views_delta;
    END IF;
    SELECT 'SELECT * FROM sys.metrics' AS 'The following output is:';
    CALL sys.execute_prepared_stmt(
        CONCAT(v_sql_status_summary_select, v_sql_status_summary_delta, ', Type, s1.Enabled', v_sql_status_summary_from,
               '
 ORDER BY Type, Variable_name'
        )
    );
    -- Remove all the metrics temporary tables again
    SET v_count = 0;
    WHILE (v_count < v_output_count) DO
        SET v_count = v_count + 1;
        SET v_table_name = CONCAT('tmp_metrics_', v_count);
        CALL sys.execute_prepared_stmt(CONCAT('DROP TEMPORARY TABLE IF EXISTS ', v_table_name));
    END WHILE;
    IF (in_auto_config <> 'current') THEN
        CALL sys.ps_setup_reload_saved();
        IF ((@log_bin = 1) AND (@@binlog_format = 'STATEMENT')) THEN
            SET sql_log_bin = @log_bin;
        END IF;
    END IF;
    -- Reset the @sys.diagnostics.% user variables internal to this procedure
    SET @sys.diagnostics.output_time            = NULL,
        @sys.diagnostics.sql                    = NULL,
        @sys.diagnostics.sql_gen_query_delta    = NULL,
        @sys.diagnostics.sql_gen_query_template = NULL,
        @sys.diagnostics.sql_select             = NULL,
        @sys.diagnostics.table_name             = NULL;
    -- Restore INSTRUMENTED for this thread
    IF (v_this_thread_enabled = 'YES') THEN
        CALL sys.ps_setup_enable_thread(CONNECTION_ID());
    END IF;
    IF ((@log_bin = 1) AND (@@binlog_format = 'STATEMENT')) THEN
        SET sql_log_bin = @log_bin;
    END IF;
END;

create definer = `mysql.sys`@localhost procedure sys.execute_prepared_stmt(IN in_query longtext) comment '
Description
-----------

Takes the query in the argument and executes it using a prepared statement. The prepared statement is deallocated,
so the procedure is mainly useful for executing one off dynamically created queries.

The sys_execute_prepared_stmt prepared statement name is used for the query and is required not to exist.


Parameters
-----------

in_query (longtext CHARACTER SET UTF8MB4):
  The query to execute.


Configuration Options
----------------------

sys.debug
  Whether to provide debugging output.
  Default is ''OFF''. Set to ''ON'' to include.


Example
--------

mysql> CALL sys.execute_prepared_stmt(''SELECT * FROM sys.sys_config'');
+------------------------+-------+---------------------+--------+
| variable               | value | set_time            | set_by |
+------------------------+-------+---------------------+--------+
| statement_truncate_len | 64    | 2015-06-30 13:06:00 | NULL   |
+------------------------+-------+---------------------+--------+
1 row in set (0.00 sec)

Query OK, 0 rows affected (0.00 sec)
' security invoker reads sql data
BEGIN
    -- Set configuration options
    IF (@sys.debug IS NULL) THEN
        SET @sys.debug = sys.sys_get_config('debug', 'OFF');
    END IF;
    -- Verify the query exists
    -- The shortest possible query is "DO 1"
    IF (in_query IS NULL OR LENGTH(in_query) < 4) THEN
       SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = "The @sys.execute_prepared_stmt.sql must contain a query";
    END IF;
    SET @sys.execute_prepared_stmt.sql = in_query;
    IF (@sys.debug = 'ON') THEN
        SELECT @sys.execute_prepared_stmt.sql AS 'Debug';
    END IF;
    PREPARE sys_execute_prepared_stmt FROM @sys.execute_prepared_stmt.sql;
    EXECUTE sys_execute_prepared_stmt;
    DEALLOCATE PREPARE sys_execute_prepared_stmt;
    SET @sys.execute_prepared_stmt.sql = NULL;
END;

create definer = `mysql.sys`@localhost function sys.extract_schema_from_file_name(path varchar(512)) returns varchar(64) comment '
Description
-----------

Takes a raw file path, and attempts to extract the schema name from it.

Useful for when interacting with Performance Schema data 
concerning IO statistics, for example.

Currently relies on the fact that a table data file will be within a 
specified database directory (will not work with partitions or tables
that specify an individual DATA_DIRECTORY).

Parameters
-----------

path (VARCHAR(512)):
  The full file path to a data file to extract the schema name from.

Returns
-----------

VARCHAR(64)

Example
-----------

mysql> SELECT sys.extract_schema_from_file_name(''/var/lib/mysql/employees/employee.ibd'');
+----------------------------------------------------------------------------+
| sys.extract_schema_from_file_name(''/var/lib/mysql/employees/employee.ibd'') |
+----------------------------------------------------------------------------+
| employees                                                                  |
+----------------------------------------------------------------------------+
1 row in set (0.00 sec)
' deterministic security invoker no sql
BEGIN
    RETURN LEFT(SUBSTRING_INDEX(SUBSTRING_INDEX(REPLACE(path, '\\', '/'), '/', -2), '/', 1), 64);
END;

create definer = `mysql.sys`@localhost function sys.extract_table_from_file_name(path varchar(512)) returns varchar(64) comment '
Description
-----------

Takes a raw file path, and extracts the table name from it.

Useful for when interacting with Performance Schema data 
concerning IO statistics, for example.

Parameters
-----------

path (VARCHAR(512)):
  The full file path to a data file to extract the table name from.

Returns
-----------

VARCHAR(64)

Example
-----------

mysql> SELECT sys.extract_table_from_file_name(''/var/lib/mysql/employees/employee.ibd'');
+---------------------------------------------------------------------------+
| sys.extract_table_from_file_name(''/var/lib/mysql/employees/employee.ibd'') |
+---------------------------------------------------------------------------+
| employee                                                                  |
+---------------------------------------------------------------------------+
1 row in set (0.02 sec)
' deterministic security invoker no sql
BEGIN
    RETURN LEFT(SUBSTRING_INDEX(REPLACE(SUBSTRING_INDEX(REPLACE(path, '\\', '/'), '/', -1), '@0024', '$'), '.', 1), 64);
END;

create definer = `mysql.sys`@localhost function sys.format_bytes(bytes text) returns text comment '
Description
-----------

Takes a raw bytes value, and converts it to a human readable format.

Parameters
-----------

bytes (TEXT):
  A raw bytes value.

Returns
-----------

TEXT

Example
-----------

mysql> SELECT sys.format_bytes(2348723492723746) AS size;
+----------+
| size     |
+----------+
| 2.09 PiB |
+----------+
1 row in set (0.00 sec)

mysql> SELECT sys.format_bytes(2348723492723) AS size;
+----------+
| size     |
+----------+
| 2.14 TiB |
+----------+
1 row in set (0.00 sec)

mysql> SELECT sys.format_bytes(23487234) AS size;
+-----------+
| size      |
+-----------+
| 22.40 MiB |
+-----------+
1 row in set (0.00 sec)
' deterministic security invoker no sql
BEGIN
  IF (bytes IS NULL) THEN
    RETURN NULL;
  ELSE
    RETURN format_bytes(bytes);
  END IF;
END;

create definer = `mysql.sys`@localhost function sys.format_path(in_path varchar(512)) returns varchar(512) comment '
Description
-----------

Takes a raw path value, and strips out the datadir or tmpdir
replacing with @@datadir and @@tmpdir respectively.

Also normalizes the paths across operating systems, so backslashes
on Windows are converted to forward slashes

Parameters
-----------

path (VARCHAR(512)):
  The raw file path value to format.

Returns
-----------

VARCHAR(512) CHARSET UTF8MB4

Example
-----------

mysql> select @@datadir;
+-----------------------------------------------+
| @@datadir                                     |
+-----------------------------------------------+
| /Users/mark/sandboxes/SmallTree/AMaster/data/ |
+-----------------------------------------------+
1 row in set (0.06 sec)

mysql> select format_path(''/Users/mark/sandboxes/SmallTree/AMaster/data/mysql/proc.MYD'') AS path;
+--------------------------+
| path                     |
+--------------------------+
| @@datadir/mysql/proc.MYD |
+--------------------------+
1 row in set (0.03 sec)
' deterministic security invoker no sql
BEGIN
  DECLARE v_path VARCHAR(512);
  DECLARE v_undo_dir VARCHAR(1024);
  DECLARE path_separator CHAR(1) DEFAULT '/';
  IF @@global.version_compile_os LIKE 'win%' THEN
    SET path_separator = '\\';
  END IF;
  -- OSX hides /private/ in variables, but Performance Schema does not
  IF in_path LIKE '/private/%' THEN
    SET v_path = REPLACE(in_path, '/private', '');
  ELSE
    SET v_path = in_path;
  END IF;
  -- @@global.innodb_undo_directory is only set when separate undo logs are used
  SET v_undo_dir = IFNULL((SELECT VARIABLE_VALUE FROM performance_schema.global_variables WHERE VARIABLE_NAME = 'innodb_undo_directory'), '');
  IF v_path IS NULL THEN
    RETURN NULL;
  ELSEIF v_path LIKE CONCAT(@@global.datadir, IF(SUBSTRING(@@global.datadir, -1) = path_separator, '%', CONCAT(path_separator, '%'))) ESCAPE '|' THEN
    SET v_path = REPLACE(v_path, @@global.datadir, CONCAT('@@datadir', IF(SUBSTRING(@@global.datadir, -1) = path_separator, path_separator, '')));
  ELSEIF v_path LIKE CONCAT(@@global.tmpdir, IF(SUBSTRING(@@global.tmpdir, -1) = path_separator, '%', CONCAT(path_separator, '%'))) ESCAPE '|' THEN
    SET v_path = REPLACE(v_path, @@global.tmpdir, CONCAT('@@tmpdir', IF(SUBSTRING(@@global.tmpdir, -1) = path_separator, path_separator, '')));
  ELSEIF v_path LIKE CONCAT(@@global.replica_load_tmpdir, IF(SUBSTRING(@@global.replica_load_tmpdir, -1) = path_separator, '%', CONCAT(path_separator, '%'))) ESCAPE '|' THEN
    SET v_path = REPLACE(v_path, @@global.replica_load_tmpdir, CONCAT('@@replica_load_tmpdir', IF(SUBSTRING(@@global.replica_load_tmpdir, -1) = path_separator, path_separator, '')));
  ELSEIF v_path LIKE CONCAT(@@global.innodb_data_home_dir, IF(SUBSTRING(@@global.innodb_data_home_dir, -1) = path_separator, '%', CONCAT(path_separator, '%'))) ESCAPE '|' THEN
    SET v_path = REPLACE(v_path, @@global.innodb_data_home_dir, CONCAT('@@innodb_data_home_dir', IF(SUBSTRING(@@global.innodb_data_home_dir, -1) = path_separator, path_separator, '')));
  ELSEIF v_path LIKE CONCAT(@@global.innodb_log_group_home_dir, IF(SUBSTRING(@@global.innodb_log_group_home_dir, -1) = path_separator, '%', CONCAT(path_separator, '%'))) ESCAPE '|' THEN
    SET v_path = REPLACE(v_path, @@global.innodb_log_group_home_dir, CONCAT('@@innodb_log_group_home_dir', IF(SUBSTRING(@@global.innodb_log_group_home_dir, -1) = path_separator, path_separator, '')));
  ELSEIF v_path LIKE CONCAT(v_undo_dir, IF(SUBSTRING(v_undo_dir, -1) = path_separator, '%', CONCAT(path_separator, '%'))) ESCAPE '|' THEN
    SET v_path = REPLACE(v_path, v_undo_dir, CONCAT('@@innodb_undo_directory', IF(SUBSTRING(v_undo_dir, -1) = path_separator, path_separator, '')));
  ELSEIF v_path LIKE CONCAT(@@global.basedir, IF(SUBSTRING(@@global.basedir, -1) = path_separator, '%', CONCAT(path_separator, '%'))) ESCAPE '|' THEN
    SET v_path = REPLACE(v_path, @@global.basedir, CONCAT('@@basedir', IF(SUBSTRING(@@global.basedir, -1) = path_separator, path_separator, '')));
  END IF;
  RETURN v_path;
END;

create definer = `mysql.sys`@localhost function sys.format_statement(statement longtext) returns longtext comment '
Description
-----------

Formats a normalized statement, truncating it if it is > 64 characters long by default.

To configure the length to truncate the statement to by default, update the `statement_truncate_len`
variable with `sys_config` table to a different value. Alternatively, to change it just for just 
your particular session, use `SET @sys.statement_truncate_len := <some new value>`.

Useful for printing statement related data from Performance Schema from 
the command line.

Parameters
-----------

statement (LONGTEXT): 
  The statement to format.

Returns
-----------

LONGTEXT

Example
-----------

mysql> SELECT sys.format_statement(digest_text)
    ->   FROM performance_schema.events_statements_summary_by_digest
    ->  ORDER by sum_timer_wait DESC limit 5;
+-------------------------------------------------------------------+
| sys.format_statement(digest_text)                                 |
+-------------------------------------------------------------------+
| CREATE SQL SECURITY INVOKER VI ... KE ? AND `variable_value` > ?  |
| CREATE SQL SECURITY INVOKER VI ... ait` IS NOT NULL , `esc` . ... |
| CREATE SQL SECURITY INVOKER VI ... ait` IS NOT NULL , `sys` . ... |
| CREATE SQL SECURITY INVOKER VI ...  , `compressed_size` ) ) DESC  |
| CREATE SQL SECURITY INVOKER VI ... LIKE ? ORDER BY `timer_start`  |
+-------------------------------------------------------------------+
5 rows in set (0.00 sec)
' deterministic security invoker no sql
BEGIN
  -- Check if we have the configured length, if not, init it
  IF @sys.statement_truncate_len IS NULL THEN
      SET @sys.statement_truncate_len = sys_get_config('statement_truncate_len', 64);
  END IF;
  IF CHAR_LENGTH(statement) > @sys.statement_truncate_len THEN
      RETURN REPLACE(CONCAT(LEFT(statement, (@sys.statement_truncate_len/2)-2), ' ... ', RIGHT(statement, (@sys.statement_truncate_len/2)-2)), '\n', ' ');
  ELSE 
      RETURN REPLACE(statement, '\n', ' ');
  END IF;
END;

create definer = `mysql.sys`@localhost function sys.format_time(picoseconds text) returns text comment '
Description
-----------

Takes a raw picoseconds value, and converts it to a human readable form.

Picoseconds are the precision that all latency values are printed in
within Performance Schema, however are not user friendly when wanting
to scan output from the command line.

Parameters
-----------

picoseconds (TEXT):
  The raw picoseconds value to convert.

Returns
-----------

TEXT CHARSET UTF8MB4

Example
-----------

mysql> select format_time(342342342342345);
+------------------------------+
| format_time(342342342342345) |
+------------------------------+
| 00:05:42                     |
+------------------------------+
1 row in set (0.00 sec)

mysql> select format_time(342342342);
+------------------------+
| format_time(342342342) |
+------------------------+
| 342.34 us              |
+------------------------+
1 row in set (0.00 sec)

mysql> select format_time(34234);
+--------------------+
| format_time(34234) |
+--------------------+
| 34.23 ns           |
+--------------------+
1 row in set (0.00 sec)
' deterministic security invoker no sql
BEGIN
  IF picoseconds IS NULL THEN RETURN NULL;
  ELSEIF picoseconds >= 604800000000000000 THEN RETURN CONCAT(ROUND(picoseconds / 604800000000000000, 2), ' w');
  ELSEIF picoseconds >= 86400000000000000 THEN RETURN CONCAT(ROUND(picoseconds / 86400000000000000, 2), ' d');
  ELSEIF picoseconds >= 3600000000000000 THEN RETURN CONCAT(ROUND(picoseconds / 3600000000000000, 2), ' h');
  ELSEIF picoseconds >= 60000000000000 THEN RETURN CONCAT(ROUND(picoseconds / 60000000000000, 2), ' m');
  ELSEIF picoseconds >= 1000000000000 THEN RETURN CONCAT(ROUND(picoseconds / 1000000000000, 2), ' s');
  ELSEIF picoseconds >= 1000000000 THEN RETURN CONCAT(ROUND(picoseconds / 1000000000, 2), ' ms');
  ELSEIF picoseconds >= 1000000 THEN RETURN CONCAT(ROUND(picoseconds / 1000000, 2), ' us');
  ELSEIF picoseconds >= 1000 THEN RETURN CONCAT(ROUND(picoseconds / 1000, 2), ' ns');
  ELSE RETURN CONCAT(picoseconds, ' ps');
  END IF;
END;

create definer = `mysql.sys`@localhost function sys.list_add(in_list text, in_add_value text) returns text comment '
Description
-----------

Takes a list, and a value to add to the list, and returns the resulting list.

Useful for altering certain session variables, like sql_mode or optimizer_switch for instance.

Parameters
-----------

in_list (TEXT):
  The comma separated list to add a value to

in_add_value (TEXT):
  The value to add to the input list

Returns
-----------

TEXT

Example
--------

mysql> select @@sql_mode;
+-----------------------------------------------------------------------------------+
| @@sql_mode                                                                        |
+-----------------------------------------------------------------------------------+
| ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION |
+-----------------------------------------------------------------------------------+
1 row in set (0.00 sec)

mysql> set sql_mode = sys.list_add(@@sql_mode, ''ANSI_QUOTES'');
Query OK, 0 rows affected (0.06 sec)

mysql> select @@sql_mode;
+-----------------------------------------------------------------------------------------------+
| @@sql_mode                                                                                    |
+-----------------------------------------------------------------------------------------------+
| ANSI_QUOTES,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION |
+-----------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)

' deterministic security invoker
BEGIN
    IF (in_add_value IS NULL) THEN
        SIGNAL SQLSTATE '02200'
           SET MESSAGE_TEXT = 'Function sys.list_add: in_add_value input variable should not be NULL',
               MYSQL_ERRNO = 1138;
    END IF;
    IF (in_list IS NULL OR LENGTH(in_list) = 0) THEN
        -- return the new value as a single value list
        RETURN in_add_value;
    END IF;
    RETURN (SELECT CONCAT(TRIM(BOTH ',' FROM TRIM(in_list)), ',', in_add_value));
END;

create definer = `mysql.sys`@localhost function sys.list_drop(in_list text, in_drop_value text) returns text comment '
Description
-----------

Takes a list, and a value to attempt to remove from the list, and returns the resulting list.

Useful for altering certain session variables, like sql_mode or optimizer_switch for instance.

Parameters
-----------

in_list (TEXT):
  The comma separated list to drop a value from

in_drop_value (TEXT):
  The value to drop from the input list

Returns
-----------

TEXT

Example
--------

mysql> select @@sql_mode;
+-----------------------------------------------------------------------------------------------+
| @@sql_mode                                                                                    |
+-----------------------------------------------------------------------------------------------+
| ANSI_QUOTES,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION |
+-----------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)

mysql> set sql_mode = sys.list_drop(@@sql_mode, ''ONLY_FULL_GROUP_BY'');
Query OK, 0 rows affected (0.03 sec)

mysql> select @@sql_mode;
+----------------------------------------------------------------------------+
| @@sql_mode                                                                 |
+----------------------------------------------------------------------------+
| ANSI_QUOTES,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION |
+----------------------------------------------------------------------------+
1 row in set (0.00 sec)

' deterministic security invoker
BEGIN
    IF (in_drop_value IS NULL) THEN
        SIGNAL SQLSTATE '02200'
           SET MESSAGE_TEXT = 'Function sys.list_drop: in_drop_value input variable should not be NULL',
               MYSQL_ERRNO = 1138;
    END IF;
    IF (in_list IS NULL OR LENGTH(in_list) = 0) THEN
        -- return the list as it was passed in
        RETURN in_list;
    END IF;
    -- ensure that leading / trailing commas are remove, support values with either spaces or not between commas
    RETURN (SELECT TRIM(BOTH ',' FROM REPLACE(REPLACE(CONCAT(',', in_list), CONCAT(',', in_drop_value), ''), CONCAT(', ', in_drop_value), '')));
END;

create definer = `mysql.sys`@localhost function sys.ps_is_account_enabled(in_host varchar(255), in_user varchar(32)) returns enum('YES', 'NO') comment '
Description
-----------

Determines whether instrumentation of an account is enabled 
within Performance Schema.

Parameters
-----------

in_host VARCHAR(255): 
  The hostname of the account to check.
in_user VARCHAR(32):
  The username of the account to check.

Returns
-----------

ENUM(''YES'', ''NO'', ''PARTIAL'')

Example
-----------

mysql> SELECT sys.ps_is_account_enabled(''localhost'', ''root'');
+------------------------------------------------+
| sys.ps_is_account_enabled(''localhost'', ''root'') |
+------------------------------------------------+
| YES                                            |
+------------------------------------------------+
1 row in set (0.01 sec)
' deterministic security invoker reads sql data
BEGIN
    RETURN IF(EXISTS(SELECT 1
                       FROM performance_schema.setup_actors
                      WHERE (`HOST` = '%' OR in_host LIKE `HOST`)
                        AND (`USER` = '%' OR `USER` = in_user)
                        AND (`ENABLED` = 'YES')
                    ),
              'YES', 'NO'
           );
END;

create definer = `mysql.sys`@localhost function sys.ps_is_consumer_enabled(in_consumer varchar(64)) returns enum('YES', 'NO') comment '
Description
-----------

Determines whether a consumer is enabled (taking the consumer hierarchy into consideration)
within the Performance Schema.

An exception with errno 3047 is thrown if an unknown consumer name is passed to the function.
A consumer name of NULL returns NULL.

Parameters
-----------

in_consumer VARCHAR(64): 
  The name of the consumer to check.

Returns
-----------

ENUM(''YES'', ''NO'')

Example
-----------

mysql> SELECT sys.ps_is_consumer_enabled(''events_stages_history'');
+-----------------------------------------------------+
| sys.ps_is_consumer_enabled(''events_stages_history'') |
+-----------------------------------------------------+
| NO                                                  |
+-----------------------------------------------------+
1 row in set (0.00 sec)
' deterministic security invoker reads sql data
BEGIN
    DECLARE v_is_enabled ENUM('YES', 'NO') DEFAULT NULL;
    DECLARE v_error_msg VARCHAR(128);
    -- Return NULL for a NULL argument.
    IF (in_consumer IS NULL) THEN
        RETURN NULL;
    END IF;
    SET v_is_enabled = (
        SELECT (CASE
                   WHEN c.NAME = 'global_instrumentation' THEN c.ENABLED
                   WHEN c.NAME = 'thread_instrumentation' THEN IF(cg.ENABLED = 'YES' AND c.ENABLED = 'YES', 'YES', 'NO')
                   WHEN c.NAME LIKE '%\_digest'           THEN IF(cg.ENABLED = 'YES' AND c.ENABLED = 'YES', 'YES', 'NO')
                   WHEN c.NAME LIKE '%\_current'          THEN IF(cg.ENABLED = 'YES' AND ct.ENABLED = 'YES' AND c.ENABLED = 'YES', 'YES', 'NO')
                   ELSE IF(cg.ENABLED = 'YES' AND ct.ENABLED = 'YES' AND c.ENABLED = 'YES'
                           AND ( SELECT cc.ENABLED FROM performance_schema.setup_consumers cc WHERE NAME = CONCAT(SUBSTRING_INDEX(c.NAME, '_', 2), '_current')
                               ) = 'YES', 'YES', 'NO')
                END) AS IsEnabled
          FROM performance_schema.setup_consumers c
               INNER JOIN performance_schema.setup_consumers cg
               INNER JOIN performance_schema.setup_consumers ct
         WHERE cg.NAME       = 'global_instrumentation'
               AND ct.NAME   = 'thread_instrumentation'
               AND c.NAME    = in_consumer
        );
    IF (v_is_enabled IS NOT NULL) THEN
        RETURN v_is_enabled;
    ELSE
        -- A value of NULL here means it is an unknown consumer name that was passed as an argument.
        -- Only an input value of NULL is allowed to return a NULL result value, to throw a signal instead.
        SET v_error_msg = CONCAT('Invalid argument error: ', in_consumer, ' in function sys.ps_is_consumer_enabled.');
        SIGNAL SQLSTATE 'HY000'
           SET MESSAGE_TEXT = v_error_msg,
               MYSQL_ERRNO  = 3047;
    END IF;
END;

create definer = `mysql.sys`@localhost function sys.ps_is_instrument_default_enabled(in_instrument varchar(128)) returns enum('YES', 'NO') comment '
Description
-----------

Returns whether an instrument is enabled by default in this version of MySQL.

Parameters
-----------

in_instrument VARCHAR(128): 
  The instrument to check.

Returns
-----------

ENUM(''YES'', ''NO'')

Example
-----------

mysql> SELECT sys.ps_is_instrument_default_enabled(''statement/sql/select'');
+--------------------------------------------------------------+
| sys.ps_is_instrument_default_enabled(''statement/sql/select'') |
+--------------------------------------------------------------+
| YES                                                          |
+--------------------------------------------------------------+
1 row in set (0.00 sec)
' deterministic security invoker reads sql data
BEGIN
    DECLARE v_enabled ENUM('YES', 'NO');
    IF (in_instrument LIKE 'stage/%') THEN
    BEGIN
      /* Stages are enabled by default if the progress property is set. */
      SET v_enabled = (SELECT
                        IF(find_in_set("progress", PROPERTIES) != 0, 'YES', 'NO')
                        FROM performance_schema.setup_instruments
                        WHERE NAME = in_instrument);
      SET v_enabled = IFNULL(v_enabled, 'NO');
    END;
    ELSE
      SET v_enabled = IF(in_instrument LIKE 'wait/synch/%'
                         OR in_instrument LIKE 'wait/io/socket/%'
                        ,
                         'NO',
                         'YES'
                      );
    END IF;
    RETURN v_enabled;
END;

create definer = `mysql.sys`@localhost function sys.ps_is_instrument_default_timed(in_instrument varchar(128)) returns enum('YES', 'NO') comment '
Description
-----------

Returns whether an instrument is timed by default in this version of MySQL.

Parameters
-----------

in_instrument VARCHAR(128): 
  The instrument to check.

Returns
-----------

ENUM(''YES'', ''NO'')

Example
-----------

mysql> SELECT sys.ps_is_instrument_default_timed(''statement/sql/select'');
+------------------------------------------------------------+
| sys.ps_is_instrument_default_timed(''statement/sql/select'') |
+------------------------------------------------------------+
| YES                                                        |
+------------------------------------------------------------+
1 row in set (0.00 sec)
' deterministic security invoker reads sql data
BEGIN
    DECLARE v_timed ENUM('YES', 'NO');
    IF (in_instrument LIKE 'stage/%') THEN
    BEGIN
      -- Stages are timed by default if the progress property is set.
      SET v_timed = (SELECT
                      IF(find_in_set("progress", PROPERTIES) != 0, 'YES', 'NO')
                      FROM performance_schema.setup_instruments
                      WHERE NAME = in_instrument);
      SET v_timed = IFNULL(v_timed, 'NO');
    END;
    ELSE
      -- Mutex, rwlock, prlock, sxlock, cond are not timed by default
      -- Memory instruments are never timed.
      SET v_timed = IF(in_instrument LIKE 'wait/synch/%'
                       OR in_instrument LIKE 'memory/%'
                      ,
                       'NO',
                       'YES'
                    );
    END IF;
    RETURN v_timed;
END;

create definer = `mysql.sys`@localhost function sys.ps_is_thread_instrumented(in_connection_id bigint unsigned) returns enum('YES', 'NO', 'UNKNOWN') comment '
Description
-----------

Checks whether the provided connection id is instrumented within Performance Schema.

Parameters
-----------

in_connection_id (BIGINT UNSIGNED):
  The id of the connection to check.

Returns
-----------

ENUM(''YES'', ''NO'', ''UNKNOWN'')

Example
-----------

mysql> SELECT sys.ps_is_thread_instrumented(CONNECTION_ID());
+------------------------------------------------+
| sys.ps_is_thread_instrumented(CONNECTION_ID()) |
+------------------------------------------------+
| YES                                            |
+------------------------------------------------+
' security invoker reads sql data
BEGIN
    DECLARE v_enabled ENUM('YES', 'NO', 'UNKNOWN');
    IF (in_connection_id IS NULL) THEN
        RETURN NULL;
    END IF;
    SELECT INSTRUMENTED INTO v_enabled
      FROM performance_schema.threads 
     WHERE PROCESSLIST_ID = in_connection_id;
    IF (v_enabled IS NULL) THEN
        RETURN 'UNKNOWN';
    ELSE
        RETURN v_enabled;
    END IF;
END;

create definer = `mysql.sys`@localhost procedure sys.ps_setup_disable_background_threads() comment '
Description
-----------

Disable all background thread instrumentation within Performance Schema.

Parameters
-----------

None.

Example
-----------

mysql> CALL sys.ps_setup_disable_background_threads();
+--------------------------------+
| summary                        |
+--------------------------------+
| Disabled 18 background threads |
+--------------------------------+
1 row in set (0.00 sec)
' security invoker modifies sql data
BEGIN
    UPDATE performance_schema.threads
       SET instrumented = 'NO'
     WHERE type = 'BACKGROUND';
    SELECT CONCAT('Disabled ', @rows := ROW_COUNT(), ' background thread', IF(@rows != 1, 's', '')) AS summary;
END;

create definer = `mysql.sys`@localhost procedure sys.ps_setup_disable_consumer(IN consumer varchar(128)) comment '
Description
-----------

Disables consumers within Performance Schema 
matching the input pattern.

Parameters
-----------

consumer (VARCHAR(128)):
  A LIKE pattern match (using "%consumer%") of consumers to disable

Example
-----------

To disable all consumers:

mysql> CALL sys.ps_setup_disable_consumer('''');
+--------------------------+
| summary                  |
+--------------------------+
| Disabled 15 consumers    |
+--------------------------+
1 row in set (0.02 sec)

To disable just the event_stage consumers:

mysql> CALL sys.ps_setup_disable_comsumers(''stage'');
+------------------------+
| summary                |
+------------------------+
| Disabled 3 consumers   |
+------------------------+
1 row in set (0.00 sec)
' security invoker modifies sql data
BEGIN
    UPDATE performance_schema.setup_consumers
       SET enabled = 'NO'
     WHERE name LIKE CONCAT('%', consumer, '%');
    SELECT CONCAT('Disabled ', @rows := ROW_COUNT(), ' consumer', IF(@rows != 1, 's', '')) AS summary;
END;

create definer = `mysql.sys`@localhost procedure sys.ps_setup_disable_instrument(IN in_pattern varchar(128)) comment '
Description
-----------

Disables instruments within Performance Schema 
matching the input pattern.

Parameters
-----------

in_pattern (VARCHAR(128)):
  A LIKE pattern match (using "%in_pattern%") of events to disable

Example
-----------

To disable all mutex instruments:

mysql> CALL sys.ps_setup_disable_instrument(''wait/synch/mutex'');
+--------------------------+
| summary                  |
+--------------------------+
| Disabled 155 instruments |
+--------------------------+
1 row in set (0.02 sec)

To disable just a specific TCP/IP based network IO instrument:

mysql> CALL sys.ps_setup_disable_instrument(''wait/io/socket/sql/server_tcpip_socket'');
+------------------------+
| summary                |
+------------------------+
| Disabled 1 instruments |
+------------------------+
1 row in set (0.00 sec)

To disable all instruments:

mysql> CALL sys.ps_setup_disable_instrument('''');
+--------------------------+
| summary                  |
+--------------------------+
| Disabled 547 instruments |
+--------------------------+
1 row in set (0.01 sec)
' security invoker modifies sql data
BEGIN
    UPDATE performance_schema.setup_instruments
       SET enabled = 'NO', timed = 'NO'
     WHERE name LIKE CONCAT('%', in_pattern, '%');
    SELECT CONCAT('Disabled ', @rows := ROW_COUNT(), ' instrument', IF(@rows != 1, 's', '')) AS summary;
END;

create definer = `mysql.sys`@localhost procedure sys.ps_setup_disable_thread(IN in_connection_id bigint) comment '
Description
-----------

Disable the given connection/thread in Performance Schema.

Parameters
-----------

in_connection_id (BIGINT):
  The connection ID (PROCESSLIST_ID from performance_schema.threads
  or the ID shown within SHOW PROCESSLIST)

Example
-----------

mysql> CALL sys.ps_setup_disable_thread(3);
+-------------------+
| summary           |
+-------------------+
| Disabled 1 thread |
+-------------------+
1 row in set (0.01 sec)

To disable the current connection:

mysql> CALL sys.ps_setup_disable_thread(CONNECTION_ID());
+-------------------+
| summary           |
+-------------------+
| Disabled 1 thread |
+-------------------+
1 row in set (0.00 sec)
' security invoker modifies sql data
BEGIN
    UPDATE performance_schema.threads
       SET instrumented = 'NO'
     WHERE processlist_id = in_connection_id;
    SELECT CONCAT('Disabled ', @rows := ROW_COUNT(), ' thread', IF(@rows != 1, 's', '')) AS summary;
END;

create definer = `mysql.sys`@localhost procedure sys.ps_setup_enable_background_threads() comment '
Description
-----------

Enable all background thread instrumentation within Performance Schema.

Parameters
-----------

None.

Example
-----------

mysql> CALL sys.ps_setup_enable_background_threads();
+-------------------------------+
| summary                       |
+-------------------------------+
| Enabled 18 background threads |
+-------------------------------+
1 row in set (0.00 sec)
' security invoker modifies sql data
BEGIN
    UPDATE performance_schema.threads
       SET instrumented = 'YES'
     WHERE type = 'BACKGROUND';
    SELECT CONCAT('Enabled ', @rows := ROW_COUNT(), ' background thread', IF(@rows != 1, 's', '')) AS summary;
END;

create definer = `mysql.sys`@localhost procedure sys.ps_setup_enable_consumer(IN consumer varchar(128)) comment '
Description
-----------

Enables consumers within Performance Schema 
matching the input pattern.

Parameters
-----------

consumer (VARCHAR(128)):
  A LIKE pattern match (using "%consumer%") of consumers to enable

Example
-----------

To enable all consumers:

mysql> CALL sys.ps_setup_enable_consumer('''');
+-------------------------+
| summary                 |
+-------------------------+
| Enabled 10 consumers    |
+-------------------------+
1 row in set (0.02 sec)

Query OK, 0 rows affected (0.02 sec)

To enable just "waits" consumers:

mysql> CALL sys.ps_setup_enable_consumer(''waits'');
+-----------------------+
| summary               |
+-----------------------+
| Enabled 3 consumers   |
+-----------------------+
1 row in set (0.00 sec)

Query OK, 0 rows affected (0.00 sec)
' security invoker modifies sql data
BEGIN
    UPDATE performance_schema.setup_consumers
       SET enabled = 'YES'
     WHERE name LIKE CONCAT('%', consumer, '%');
    SELECT CONCAT('Enabled ', @rows := ROW_COUNT(), ' consumer', IF(@rows != 1, 's', '')) AS summary;
END;

create definer = `mysql.sys`@localhost procedure sys.ps_setup_enable_instrument(IN in_pattern varchar(128)) comment '
Description
-----------

Enables instruments within Performance Schema 
matching the input pattern.

Parameters
-----------

in_pattern (VARCHAR(128)):
  A LIKE pattern match (using "%in_pattern%") of events to enable

Example
-----------

To enable all mutex instruments:

mysql> CALL sys.ps_setup_enable_instrument(''wait/synch/mutex'');
+-------------------------+
| summary                 |
+-------------------------+
| Enabled 155 instruments |
+-------------------------+
1 row in set (0.02 sec)

Query OK, 0 rows affected (0.02 sec)

To enable just a specific TCP/IP based network IO instrument:

mysql> CALL sys.ps_setup_enable_instrument(''wait/io/socket/sql/server_tcpip_socket'');
+-----------------------+
| summary               |
+-----------------------+
| Enabled 1 instruments |
+-----------------------+
1 row in set (0.00 sec)

Query OK, 0 rows affected (0.00 sec)

To enable all instruments:

mysql> CALL sys.ps_setup_enable_instrument('''');
+-------------------------+
| summary                 |
+-------------------------+
| Enabled 547 instruments |
+-------------------------+
1 row in set (0.01 sec)

Query OK, 0 rows affected (0.01 sec)
' security invoker modifies sql data
BEGIN
    UPDATE performance_schema.setup_instruments
       SET enabled = 'YES', timed = 'YES'
     WHERE name LIKE CONCAT('%', in_pattern, '%');
    SELECT CONCAT('Enabled ', @rows := ROW_COUNT(), ' instrument', IF(@rows != 1, 's', '')) AS summary;
END;

create definer = `mysql.sys`@localhost procedure sys.ps_setup_enable_thread(IN in_connection_id bigint) comment '
Description
-----------

Enable the given connection/thread in Performance Schema.

Parameters
-----------

in_connection_id (BIGINT):
  The connection ID (PROCESSLIST_ID from performance_schema.threads
  or the ID shown within SHOW PROCESSLIST)

Example
-----------

mysql> CALL sys.ps_setup_enable_thread(3);
+------------------+
| summary          |
+------------------+
| Enabled 1 thread |
+------------------+
1 row in set (0.01 sec)

To enable the current connection:

mysql> CALL sys.ps_setup_enable_thread(CONNECTION_ID());
+------------------+
| summary          |
+------------------+
| Enabled 1 thread |
+------------------+
1 row in set (0.00 sec)
' security invoker modifies sql data
BEGIN
    UPDATE performance_schema.threads
       SET instrumented = 'YES'
     WHERE processlist_id = in_connection_id;
    SELECT CONCAT('Enabled ', @rows := ROW_COUNT(), ' thread', IF(@rows != 1, 's', '')) AS summary;
END;

create definer = `mysql.sys`@localhost procedure sys.ps_setup_reload_saved() comment '
Description
-----------

Reloads a saved Performance Schema configuration,
so that you can alter the setup for debugging purposes, 
but restore it to a previous state.

Use the companion procedure - ps_setup_save(), to 
save a configuration.

Requires the SUPER privilege for "SET sql_log_bin = 0;".

Parameters
-----------

None.

Example
-----------

mysql> CALL sys.ps_setup_save();
Query OK, 0 rows affected (0.08 sec)

mysql> UPDATE performance_schema.setup_instruments SET enabled = ''YES'', timed = ''YES'';
Query OK, 547 rows affected (0.40 sec)
Rows matched: 784  Changed: 547  Warnings: 0

/* Run some tests that need more detailed instrumentation here */

mysql> CALL sys.ps_setup_reload_saved();
Query OK, 0 rows affected (0.32 sec)
' security invoker modifies sql data
BEGIN
    DECLARE v_done bool DEFAULT FALSE;
    DECLARE v_lock_result INT;
    DECLARE v_lock_used_by BIGINT;
    DECLARE v_signal_message TEXT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SIGNAL SQLSTATE VALUE '90001'
           SET MESSAGE_TEXT = 'An error occurred, was sys.ps_setup_save() run before this procedure?';
    END;
    SET @log_bin := @@sql_log_bin;
    SET sql_log_bin = 0;
    SELECT IS_USED_LOCK('sys.ps_setup_save') INTO v_lock_used_by;
    IF (v_lock_used_by != CONNECTION_ID()) THEN
        SET v_signal_message = CONCAT('The sys.ps_setup_save lock is currently owned by ', v_lock_used_by);
        SIGNAL SQLSTATE VALUE '90002'
           SET MESSAGE_TEXT = v_signal_message;
    END IF;
    DELETE FROM performance_schema.setup_actors;
    INSERT INTO performance_schema.setup_actors SELECT * FROM tmp_setup_actors;
    BEGIN
        -- Workaround for http://bugs.mysql.com/bug.php?id=70025
        DECLARE v_name varchar(64);
        DECLARE v_enabled enum('YES', 'NO');
        DECLARE c_consumers CURSOR FOR SELECT NAME, ENABLED FROM tmp_setup_consumers;
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = TRUE;
        SET v_done = FALSE;
        OPEN c_consumers;
        c_consumers_loop: LOOP
            FETCH c_consumers INTO v_name, v_enabled;
            IF v_done THEN
               LEAVE c_consumers_loop;
            END IF;
            UPDATE performance_schema.setup_consumers
               SET ENABLED = v_enabled
             WHERE NAME = v_name;
         END LOOP;
         CLOSE c_consumers;
    END;
    UPDATE performance_schema.setup_instruments
     INNER JOIN tmp_setup_instruments USING (NAME)
       SET performance_schema.setup_instruments.ENABLED = tmp_setup_instruments.ENABLED,
           performance_schema.setup_instruments.TIMED   = tmp_setup_instruments.TIMED;
    BEGIN
        -- Workaround for http://bugs.mysql.com/bug.php?id=70025
        DECLARE v_thread_id bigint unsigned;
        DECLARE v_instrumented enum('YES', 'NO');
        DECLARE c_threads CURSOR FOR SELECT THREAD_ID, INSTRUMENTED FROM tmp_threads;
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = TRUE;
        SET v_done = FALSE;
        OPEN c_threads;
        c_threads_loop: LOOP
            FETCH c_threads INTO v_thread_id, v_instrumented;
            IF v_done THEN
               LEAVE c_threads_loop;
            END IF;
            UPDATE performance_schema.threads
               SET INSTRUMENTED = v_instrumented
             WHERE THREAD_ID = v_thread_id;
        END LOOP;
        CLOSE c_threads;
    END;
    UPDATE performance_schema.threads
       SET INSTRUMENTED = IF(PROCESSLIST_USER IS NOT NULL,
                             sys.ps_is_account_enabled(PROCESSLIST_HOST, PROCESSLIST_USER),
                             'YES')
     WHERE THREAD_ID NOT IN (SELECT THREAD_ID FROM tmp_threads);
    DROP TEMPORARY TABLE tmp_setup_actors;
    DROP TEMPORARY TABLE tmp_setup_consumers;
    DROP TEMPORARY TABLE tmp_setup_instruments;
    DROP TEMPORARY TABLE tmp_threads;
    SELECT RELEASE_LOCK('sys.ps_setup_save') INTO v_lock_result;
    SET sql_log_bin = @log_bin; 
END;

create definer = `mysql.sys`@localhost procedure sys.ps_setup_reset_to_default(IN in_verbose tinyint(1)) comment '
Description
-----------

Resets the Performance Schema setup to the default settings.

Parameters
-----------

in_verbose (BOOLEAN):
  Whether to print each setup stage (including the SQL) whilst running.

Example
-----------

mysql> CALL sys.ps_setup_reset_to_default(true)\G
*************************** 1. row ***************************
status: Resetting: setup_actors
DELETE
FROM performance_schema.setup_actors
 WHERE NOT (HOST = ''%'' AND USER = ''%'' AND `ROLE` = ''%'')
1 row in set (0.00 sec)

*************************** 1. row ***************************
status: Resetting: setup_actors
INSERT IGNORE INTO performance_schema.setup_actors
VALUES (''%'', ''%'', ''%'')
1 row in set (0.00 sec)
...

mysql> CALL sys.ps_setup_reset_to_default(false)\G
Query OK, 0 rows affected (0.00 sec)
' security invoker modifies sql data
BEGIN
    SET @query = 'DELETE
                    FROM performance_schema.setup_actors
                   WHERE NOT (HOST = ''%'' AND USER = ''%'' AND `ROLE` = ''%'')';
    IF (in_verbose) THEN
        SELECT CONCAT('Resetting: setup_actors\n', REPLACE(@query, '  ', '')) AS status;
    END IF;
    PREPARE reset_stmt FROM @query;
    EXECUTE reset_stmt;
    DEALLOCATE PREPARE reset_stmt;
    SET @query = 'INSERT IGNORE INTO performance_schema.setup_actors
                  VALUES (''%'', ''%'', ''%'', ''YES'', ''YES'')';
    IF (in_verbose) THEN
        SELECT CONCAT('Resetting: setup_actors\n', REPLACE(@query, '  ', '')) AS status;
    END IF;
    PREPARE reset_stmt FROM @query;
    EXECUTE reset_stmt;
    DEALLOCATE PREPARE reset_stmt;
    SET @query = 'UPDATE performance_schema.setup_instruments
                     SET ENABLED = sys.ps_is_instrument_default_enabled(NAME),
                         TIMED   = sys.ps_is_instrument_default_timed(NAME)';
    IF (in_verbose) THEN
        SELECT CONCAT('Resetting: setup_instruments\n', REPLACE(@query, '  ', '')) AS status;
    END IF;
    PREPARE reset_stmt FROM @query;
    EXECUTE reset_stmt;
    DEALLOCATE PREPARE reset_stmt;
    SET @query = 'UPDATE performance_schema.setup_consumers
                     SET ENABLED = IF(NAME IN (''events_statements_current'', ''events_transactions_current'', ''global_instrumentation'', ''thread_instrumentation'', ''statements_digest''), ''YES'', ''NO'')';
    IF (in_verbose) THEN
        SELECT CONCAT('Resetting: setup_consumers\n', REPLACE(@query, '  ', '')) AS status;
    END IF;
    PREPARE reset_stmt FROM @query;
    EXECUTE reset_stmt;
    DEALLOCATE PREPARE reset_stmt;
    SET @query = 'DELETE
                    FROM performance_schema.setup_objects
                   WHERE NOT (OBJECT_TYPE IN (''EVENT'', ''FUNCTION'', ''PROCEDURE'', ''TABLE'', ''TRIGGER'') AND OBJECT_NAME = ''%'' 
                     AND (OBJECT_SCHEMA = ''mysql''              AND ENABLED = ''NO''  AND TIMED = ''NO'' )
                      OR (OBJECT_SCHEMA = ''performance_schema'' AND ENABLED = ''NO''  AND TIMED = ''NO'' )
                      OR (OBJECT_SCHEMA = ''information_schema'' AND ENABLED = ''NO''  AND TIMED = ''NO'' )
                      OR (OBJECT_SCHEMA = ''%''                  AND ENABLED = ''YES'' AND TIMED = ''YES''))';
    IF (in_verbose) THEN
        SELECT CONCAT('Resetting: setup_objects\n', REPLACE(@query, '  ', '')) AS status;
    END IF;
    PREPARE reset_stmt FROM @query;
    EXECUTE reset_stmt;
    DEALLOCATE PREPARE reset_stmt;
    SET @query = 'INSERT IGNORE INTO performance_schema.setup_objects
                  VALUES (''EVENT''    , ''mysql''             , ''%'', ''NO'' , ''NO'' ),
                         (''EVENT''    , ''performance_schema'', ''%'', ''NO'' , ''NO'' ),
                         (''EVENT''    , ''information_schema'', ''%'', ''NO'' , ''NO'' ),
                         (''EVENT''    , ''%''                 , ''%'', ''YES'', ''YES''),
                         (''FUNCTION'' , ''mysql''             , ''%'', ''NO'' , ''NO'' ),
                         (''FUNCTION'' , ''performance_schema'', ''%'', ''NO'' , ''NO'' ),
                         (''FUNCTION'' , ''information_schema'', ''%'', ''NO'' , ''NO'' ),
                         (''FUNCTION'' , ''%''                 , ''%'', ''YES'', ''YES''),
                         (''PROCEDURE'', ''mysql''             , ''%'', ''NO'' , ''NO'' ),
                         (''PROCEDURE'', ''performance_schema'', ''%'', ''NO'' , ''NO'' ),
                         (''PROCEDURE'', ''information_schema'', ''%'', ''NO'' , ''NO'' ),
                         (''PROCEDURE'', ''%''                 , ''%'', ''YES'', ''YES''),
                         (''TABLE''    , ''mysql''             , ''%'', ''NO'' , ''NO'' ),
                         (''TABLE''    , ''performance_schema'', ''%'', ''NO'' , ''NO'' ),
                         (''TABLE''    , ''information_schema'', ''%'', ''NO'' , ''NO'' ),
                         (''TABLE''    , ''%''                 , ''%'', ''YES'', ''YES''),
                         (''TRIGGER''  , ''mysql''             , ''%'', ''NO'' , ''NO'' ),
                         (''TRIGGER''  , ''performance_schema'', ''%'', ''NO'' , ''NO'' ),
                         (''TRIGGER''  , ''information_schema'', ''%'', ''NO'' , ''NO'' ),
                         (''TRIGGER''  , ''%''                 , ''%'', ''YES'', ''YES'')';
    IF (in_verbose) THEN
        SELECT CONCAT('Resetting: setup_objects\n', REPLACE(@query, '  ', '')) AS status;
    END IF;
    PREPARE reset_stmt FROM @query;
    EXECUTE reset_stmt;
    DEALLOCATE PREPARE reset_stmt;
    SET @query = 'UPDATE performance_schema.threads
                     SET INSTRUMENTED = ''YES''';
    IF (in_verbose) THEN
        SELECT CONCAT('Resetting: threads\n', REPLACE(@query, '  ', '')) AS status;
    END IF;
    PREPARE reset_stmt FROM @query;
    EXECUTE reset_stmt;
    DEALLOCATE PREPARE reset_stmt;
END;

create definer = `mysql.sys`@localhost procedure sys.ps_setup_save(IN in_timeout int) comment '
Description
-----------

Saves the current configuration of Performance Schema, 
so that you can alter the setup for debugging purposes, 
but restore it to a previous state.

Use the companion procedure - ps_setup_reload_saved(), to 
restore the saved config.

The named lock "sys.ps_setup_save" is taken before the
current configuration is saved. If the attempt to get the named
lock times out, an error occurs.

The lock is released after the settings have been restored by
calling ps_setup_reload_saved().

Requires the SUPER privilege for "SET sql_log_bin = 0;".

Parameters
-----------

in_timeout INT
  The timeout in seconds used when trying to obtain the lock.
  A negative timeout means infinite timeout.

Example
-----------

mysql> CALL sys.ps_setup_save(-1);
Query OK, 0 rows affected (0.08 sec)

mysql> UPDATE performance_schema.setup_instruments 
    ->    SET enabled = ''YES'', timed = ''YES'';
Query OK, 547 rows affected (0.40 sec)
Rows matched: 784  Changed: 547  Warnings: 0

/* Run some tests that need more detailed instrumentation here */

mysql> CALL sys.ps_setup_reload_saved();
Query OK, 0 rows affected (0.32 sec)
' security invoker modifies sql data
BEGIN
    DECLARE v_lock_result INT;
    SET @log_bin := @@sql_log_bin;
    SET sql_log_bin = 0;
    SELECT GET_LOCK('sys.ps_setup_save', in_timeout) INTO v_lock_result;
    IF v_lock_result THEN
        DROP TEMPORARY TABLE IF EXISTS tmp_setup_actors;
        DROP TEMPORARY TABLE IF EXISTS tmp_setup_consumers;
        DROP TEMPORARY TABLE IF EXISTS tmp_setup_instruments;
        DROP TEMPORARY TABLE IF EXISTS tmp_threads;
        CREATE TEMPORARY TABLE tmp_setup_actors SELECT * FROM performance_schema.setup_actors LIMIT 0;
        CREATE TEMPORARY TABLE tmp_setup_consumers LIKE performance_schema.setup_consumers;
        CREATE TEMPORARY TABLE tmp_setup_instruments LIKE performance_schema.setup_instruments;
        CREATE TEMPORARY TABLE tmp_threads (THREAD_ID bigint unsigned NOT NULL PRIMARY KEY, INSTRUMENTED enum('YES','NO') NOT NULL);
        INSERT INTO tmp_setup_actors SELECT * FROM performance_schema.setup_actors;
        INSERT INTO tmp_setup_consumers SELECT * FROM performance_schema.setup_consumers;
        INSERT INTO tmp_setup_instruments SELECT * FROM performance_schema.setup_instruments;
        INSERT INTO tmp_threads SELECT THREAD_ID, INSTRUMENTED FROM performance_schema.threads;
    ELSE
        SIGNAL SQLSTATE VALUE '90000'
           SET MESSAGE_TEXT = 'Could not lock the sys.ps_setup_save user lock, another thread has a saved configuration';
    END IF;
    SET sql_log_bin = @log_bin;
END;

create definer = `mysql.sys`@localhost procedure sys.ps_setup_show_disabled(IN in_show_instruments tinyint(1), IN in_show_threads tinyint(1)) comment '
Description
-----------

Shows all currently disable Performance Schema configuration.

Disabled users is only available for MySQL 5.7.6 and later.
In earlier versions it was only possible to enable users.

Parameters
-----------

in_show_instruments (BOOLEAN):
  Whether to print disabled instruments (can print many items)

in_show_threads (BOOLEAN):
  Whether to print disabled threads

Example
-----------

mysql> CALL sys.ps_setup_show_disabled(TRUE, TRUE);
+----------------------------+
| performance_schema_enabled |
+----------------------------+
|                          1 |
+----------------------------+
1 row in set (0.00 sec)

+--------------------+
| disabled_users     |
+--------------------+
| ''mark''@''localhost'' |
+--------------------+
1 row in set (0.00 sec)

+-------------+----------------------+---------+-------+
| object_type | objects              | enabled | timed |
+-------------+----------------------+---------+-------+
| EVENT       | mysql.%              | NO      | NO    |
| EVENT       | performance_schema.% | NO      | NO    |
| EVENT       | information_schema.% | NO      | NO    |
| FUNCTION    | mysql.%              | NO      | NO    |
| FUNCTION    | performance_schema.% | NO      | NO    |
| FUNCTION    | information_schema.% | NO      | NO    |
| PROCEDURE   | mysql.%              | NO      | NO    |
| PROCEDURE   | performance_schema.% | NO      | NO    |
| PROCEDURE   | information_schema.% | NO      | NO    |
| TABLE       | mysql.%              | NO      | NO    |
| TABLE       | performance_schema.% | NO      | NO    |
| TABLE       | information_schema.% | NO      | NO    |
| TRIGGER     | mysql.%              | NO      | NO    |
| TRIGGER     | performance_schema.% | NO      | NO    |
| TRIGGER     | information_schema.% | NO      | NO    |
+-------------+----------------------+---------+-------+
15 rows in set (0.00 sec)

+----------------------------------+
| disabled_consumers               |
+----------------------------------+
| events_stages_current            |
| events_stages_history            |
| events_stages_history_long       |
| events_statements_history        |
| events_statements_history_long   |
| events_transactions_history      |
| events_transactions_history_long |
| events_waits_current             |
| events_waits_history             |
| events_waits_history_long        |
+----------------------------------+
10 rows in set (0.00 sec)

Empty set (0.00 sec)

+---------------------------------------------------------------------------------------+-------+
| disabled_instruments                                                                  | timed |
+---------------------------------------------------------------------------------------+-------+
| wait/synch/mutex/sql/TC_LOG_MMAP::LOCK_tc                                             | NO    |
| wait/synch/mutex/sql/LOCK_des_key_file                                                | NO    |
| wait/synch/mutex/sql/MYSQL_BIN_LOG::LOCK_commit                                       | NO    |
...
| memory/sql/servers_cache                                                              | NO    |
| memory/sql/udf_mem                                                                    | NO    |
| wait/lock/metadata/sql/mdl                                                            | NO    |
+---------------------------------------------------------------------------------------+-------+
547 rows in set (0.00 sec)

Query OK, 0 rows affected (0.01 sec)
' security invoker reads sql data
BEGIN
    SELECT @@performance_schema AS performance_schema_enabled;
    SELECT CONCAT('\'', user, '\'@\'', host, '\'') AS disabled_users
      FROM performance_schema.setup_actors
     WHERE enabled = 'NO'
     ORDER BY disabled_users;
    SELECT object_type,
           CONCAT(object_schema, '.', object_name) AS objects,
           enabled,
           timed
      FROM performance_schema.setup_objects
     WHERE enabled = 'NO'
     ORDER BY object_type, objects;
    SELECT name AS disabled_consumers
      FROM performance_schema.setup_consumers
     WHERE enabled = 'NO'
     ORDER BY disabled_consumers;
    IF (in_show_threads) THEN
        SELECT IF(name = 'thread/sql/one_connection', 
                  CONCAT(processlist_user, '@', processlist_host), 
                  REPLACE(name, 'thread/', '')) AS disabled_threads,
        TYPE AS thread_type
          FROM performance_schema.threads
         WHERE INSTRUMENTED = 'NO'
         ORDER BY disabled_threads;
    END IF;
    IF (in_show_instruments) THEN
        SELECT name AS disabled_instruments,
               timed
          FROM performance_schema.setup_instruments
         WHERE enabled = 'NO'
         ORDER BY disabled_instruments;
    END IF;
END;

create definer = `mysql.sys`@localhost procedure sys.ps_setup_show_disabled_consumers() comment '
Description
-----------

Shows all currently disabled consumers.

Parameters
-----------

None

Example
-----------

mysql> CALL sys.ps_setup_show_disabled_consumers();

+---------------------------+
| disabled_consumers        |
+---------------------------+
| events_statements_current |
| global_instrumentation    |
| thread_instrumentation    |
| statements_digest         |
+---------------------------+
4 rows in set (0.05 sec)
' deterministic security invoker reads sql data
BEGIN
    SELECT name AS disabled_consumers
      FROM performance_schema.setup_consumers
     WHERE enabled = 'NO'
     ORDER BY disabled_consumers;
END;

create definer = `mysql.sys`@localhost procedure sys.ps_setup_show_disabled_instruments() comment '
Description
-----------

Shows all currently disabled instruments.

Parameters
-----------

None

Example
-----------

mysql> CALL sys.ps_setup_show_disabled_instruments();
' deterministic security invoker reads sql data
BEGIN
    SELECT name AS disabled_instruments, timed
      FROM performance_schema.setup_instruments
     WHERE enabled = 'NO'
     ORDER BY disabled_instruments;
END;

create definer = `mysql.sys`@localhost procedure sys.ps_setup_show_enabled(IN in_show_instruments tinyint(1), IN in_show_threads tinyint(1)) comment '
Description
-----------

Shows all currently enabled Performance Schema configuration.

Parameters
-----------

in_show_instruments (BOOLEAN):
  Whether to print enabled instruments (can print many items)

in_show_threads (BOOLEAN):
  Whether to print enabled threads

Example
-----------

mysql> CALL sys.ps_setup_show_enabled(TRUE, TRUE);
+----------------------------+
| performance_schema_enabled |
+----------------------------+
|                          1 |
+----------------------------+
1 row in set (0.00 sec)

+---------------+
| enabled_users |
+---------------+
| ''%''@''%''       |
+---------------+
1 row in set (0.01 sec)

+-------------+---------+---------+-------+
| object_type | objects | enabled | timed |
+-------------+---------+---------+-------+
| EVENT       | %.%     | YES     | YES   |
| FUNCTION    | %.%     | YES     | YES   |
| PROCEDURE   | %.%     | YES     | YES   |
| TABLE       | %.%     | YES     | YES   |
| TRIGGER     | %.%     | YES     | YES   |
+-------------+---------+---------+-------+
5 rows in set (0.01 sec)

+---------------------------+
| enabled_consumers         |
+---------------------------+
| events_statements_current |
| global_instrumentation    |
| thread_instrumentation    |
| statements_digest         |
+---------------------------+
4 rows in set (0.05 sec)

+---------------------------------+-------------+
| enabled_threads                 | thread_type |
+---------------------------------+-------------+
| sql/main                        | BACKGROUND  |
| sql/thread_timer_notifier       | BACKGROUND  |
| innodb/io_ibuf_thread           | BACKGROUND  |
| innodb/io_log_thread            | BACKGROUND  |
| innodb/io_read_thread           | BACKGROUND  |
| innodb/io_read_thread           | BACKGROUND  |
| innodb/io_write_thread          | BACKGROUND  |
| innodb/io_write_thread          | BACKGROUND  |
| innodb/page_cleaner_thread      | BACKGROUND  |
| innodb/srv_lock_timeout_thread  | BACKGROUND  |
| innodb/srv_error_monitor_thread | BACKGROUND  |
| innodb/srv_monitor_thread       | BACKGROUND  |
| innodb/srv_master_thread        | BACKGROUND  |
| innodb/srv_purge_thread         | BACKGROUND  |
| innodb/srv_worker_thread        | BACKGROUND  |
| innodb/srv_worker_thread        | BACKGROUND  |
| innodb/srv_worker_thread        | BACKGROUND  |
| innodb/buf_dump_thread          | BACKGROUND  |
| innodb/dict_stats_thread        | BACKGROUND  |
| sql/signal_handler              | BACKGROUND  |
| sql/compress_gtid_table         | FOREGROUND  |
| root@localhost                  | FOREGROUND  |
+---------------------------------+-------------+
22 rows in set (0.01 sec)

+-------------------------------------+-------+
| enabled_instruments                 | timed |
+-------------------------------------+-------+
| wait/io/file/sql/map                | YES   |
| wait/io/file/sql/binlog             | YES   |
...
| statement/com/Error                 | YES   |
| statement/com/                      | YES   |
| idle                                | YES   |
+-------------------------------------+-------+
210 rows in set (0.08 sec)

Query OK, 0 rows affected (0.89 sec)
' deterministic security invoker reads sql data
BEGIN
    SELECT @@performance_schema AS performance_schema_enabled;
    SELECT CONCAT('\'', user, '\'@\'', host, '\'') AS enabled_users
      FROM performance_schema.setup_actors
     WHERE enabled = 'YES'
     ORDER BY enabled_users;
    SELECT object_type,
           CONCAT(object_schema, '.', object_name) AS objects,
           enabled,
           timed
      FROM performance_schema.setup_objects
     WHERE enabled = 'YES'
     ORDER BY object_type, objects;
    SELECT name AS enabled_consumers
      FROM performance_schema.setup_consumers
     WHERE enabled = 'YES'
     ORDER BY enabled_consumers;
    IF (in_show_threads) THEN
        SELECT IF(name = 'thread/sql/one_connection', 
                  CONCAT(processlist_user, '@', processlist_host), 
                  REPLACE(name, 'thread/', '')) AS enabled_threads,
        TYPE AS thread_type
          FROM performance_schema.threads
         WHERE INSTRUMENTED = 'YES'
         ORDER BY enabled_threads;
    END IF;
    IF (in_show_instruments) THEN
        SELECT name AS enabled_instruments,
               timed
          FROM performance_schema.setup_instruments
         WHERE enabled = 'YES'
         ORDER BY enabled_instruments;
    END IF;
END;

create definer = `mysql.sys`@localhost procedure sys.ps_setup_show_enabled_consumers() comment '
Description
-----------

Shows all currently enabled consumers.

Parameters
-----------

None

Example
-----------

mysql> CALL sys.ps_setup_show_enabled_consumers();

+---------------------------+
| enabled_consumers         |
+---------------------------+
| events_statements_current |
| global_instrumentation    |
| thread_instrumentation    |
| statements_digest         |
+---------------------------+
4 rows in set (0.05 sec)
' deterministic security invoker reads sql data
BEGIN
    SELECT name AS enabled_consumers
      FROM performance_schema.setup_consumers
     WHERE enabled = 'YES'
     ORDER BY enabled_consumers;
END;

create definer = `mysql.sys`@localhost procedure sys.ps_setup_show_enabled_instruments() comment '
Description
-----------

Shows all currently enabled instruments.

Parameters
-----------

None

Example
-----------

mysql> CALL sys.ps_setup_show_enabled_instruments();
' deterministic security invoker reads sql data
BEGIN
    SELECT name AS enabled_instruments, timed
      FROM performance_schema.setup_instruments
     WHERE enabled = 'YES'
     ORDER BY enabled_instruments;
END;

create definer = `mysql.sys`@localhost procedure sys.ps_statement_avg_latency_histogram() comment '
Description
-----------

Outputs a textual histogram graph of the average latency values
across all normalized queries tracked within the Performance Schema
events_statements_summary_by_digest table.

Can be used to show a very high level picture of what kind of 
latency distribution statements running within this instance have.

Parameters
-----------

None.

Example
-----------

mysql> CALL sys.ps_statement_avg_latency_histogram()\G
*************************** 1. row ***************************
Performance Schema Statement Digest Average Latency Histogram:

  . = 1 unit
  * = 2 units
  # = 3 units

(0 - 38ms)     240 | ################################################################################
(38 - 77ms)    38  | ......................................
(77 - 115ms)   3   | ...
(115 - 154ms)  62  | *******************************
(154 - 192ms)  3   | ...
(192 - 231ms)  0   |
(231 - 269ms)  0   |
(269 - 307ms)  0   |
(307 - 346ms)  0   |
(346 - 384ms)  1   | .
(384 - 423ms)  1   | .
(423 - 461ms)  0   |
(461 - 499ms)  0   |
(499 - 538ms)  0   |
(538 - 576ms)  0   |
(576 - 615ms)  1   | .

  Total Statements: 350; Buckets: 16; Bucket Size: 38 ms;
' security invoker reads sql data
BEGIN
SELECT CONCAT('\n',
       '\n  . = 1 unit',
       '\n  * = 2 units',
       '\n  # = 3 units\n',
       @label := CONCAT(@label_inner := CONCAT('\n(0 - ',
                                               ROUND((@bucket_size := (SELECT ROUND((MAX(avg_us) - MIN(avg_us)) / (@buckets := 16)) AS size
                                                                         FROM sys.x$ps_digest_avg_latency_distribution)) / (@unit_div := 1000)),
                                                (@unit := 'ms'), ')'),
                        REPEAT(' ', (@max_label_size := ((1 + LENGTH(ROUND((@bucket_size * 15) / @unit_div)) + 3 + LENGTH(ROUND(@bucket_size * 16) / @unit_div)) + 1)) - LENGTH(@label_inner)),
                        @count_in_bucket := IFNULL((SELECT SUM(cnt)
                                                      FROM sys.x$ps_digest_avg_latency_distribution AS b1 
                                                     WHERE b1.avg_us <= @bucket_size), 0)),
       REPEAT(' ', (@max_label_len := (@max_label_size + LENGTH((@total_queries := (SELECT SUM(cnt) FROM sys.x$ps_digest_avg_latency_distribution)))) + 1) - LENGTH(@label)), '| ',
       IFNULL(REPEAT(IF(@count_in_bucket < (@one_unit := 40), '.', IF(@count_in_bucket < (@two_unit := 80), '*', '#')), 
       	             IF(@count_in_bucket < @one_unit, @count_in_bucket,
       	             	IF(@count_in_bucket < @two_unit, @count_in_bucket / 2, @count_in_bucket / 3))), ''),
       @label := CONCAT(@label_inner := CONCAT('\n(', ROUND(@bucket_size / @unit_div), ' - ', ROUND((@bucket_size * 2) / @unit_div), @unit, ')'),
                        REPEAT(' ', @max_label_size - LENGTH(@label_inner)),
                        @count_in_bucket := IFNULL((SELECT SUM(cnt)
                                                      FROM sys.x$ps_digest_avg_latency_distribution AS b1 
                                                     WHERE b1.avg_us > @bucket_size AND b1.avg_us <= @bucket_size * 2), 0)),
       REPEAT(' ', @max_label_len - LENGTH(@label)), '| ',
       IFNULL(REPEAT(IF(@count_in_bucket < @one_unit, '.', IF(@count_in_bucket < @two_unit, '*', '#')), 
       	             IF(@count_in_bucket < @one_unit, @count_in_bucket,
       	             	IF(@count_in_bucket < @two_unit, @count_in_bucket / 2, @count_in_bucket / 3))), ''),
       @label := CONCAT(@label_inner := CONCAT('\n(', ROUND((@bucket_size * 2) / @unit_div), ' - ', ROUND((@bucket_size * 3) / @unit_div), @unit, ')'),
                        REPEAT(' ', @max_label_size - LENGTH(@label_inner)),
                        @count_in_bucket := IFNULL((SELECT SUM(cnt)
                                                      FROM sys.x$ps_digest_avg_latency_distribution AS b1 
                                                     WHERE b1.avg_us > @bucket_size * 2 AND b1.avg_us <= @bucket_size * 3), 0)),
       REPEAT(' ', @max_label_len - LENGTH(@label)), '| ',
       IFNULL(REPEAT(IF(@count_in_bucket < @one_unit, '.', IF(@count_in_bucket < @two_unit, '*', '#')), 
       	             IF(@count_in_bucket < @one_unit, @count_in_bucket,
       	             	IF(@count_in_bucket < @two_unit, @count_in_bucket / 2, @count_in_bucket / 3))), ''),
       @label := CONCAT(@label_inner := CONCAT('\n(', ROUND((@bucket_size * 3) / @unit_div), ' - ', ROUND((@bucket_size * 4) / @unit_div), @unit, ')'),
                        REPEAT(' ', @max_label_size - LENGTH(@label_inner)),
                        @count_in_bucket := IFNULL((SELECT SUM(cnt)
                                                      FROM sys.x$ps_digest_avg_latency_distribution AS b1 
                                                     WHERE b1.avg_us > @bucket_size * 3 AND b1.avg_us <= @bucket_size * 4), 0)),
       REPEAT(' ', @max_label_len - LENGTH(@label)), '| ',
       IFNULL(REPEAT(IF(@count_in_bucket < @one_unit, '.', IF(@count_in_bucket < @two_unit, '*', '#')), 
       	             IF(@count_in_bucket < @one_unit, @count_in_bucket,
       	             	IF(@count_in_bucket < @two_unit, @count_in_bucket / 2, @count_in_bucket / 3))), ''),
       @label := CONCAT(@label_inner := CONCAT('\n(', ROUND((@bucket_size * 4) / @unit_div), ' - ', ROUND((@bucket_size * 5) / @unit_div), @unit, ')'),
                        REPEAT(' ', @max_label_size - LENGTH(@label_inner)),
                        @count_in_bucket := IFNULL((SELECT SUM(cnt)
                                                      FROM sys.x$ps_digest_avg_latency_distribution AS b1 
                                                     WHERE b1.avg_us > @bucket_size * 4 AND b1.avg_us <= @bucket_size * 5), 0)),
       REPEAT(' ', @max_label_len - LENGTH(@label)), '| ',
       IFNULL(REPEAT(IF(@count_in_bucket < @one_unit, '.', IF(@count_in_bucket < @two_unit, '*', '#')), 
       	             IF(@count_in_bucket < @one_unit, @count_in_bucket,
       	             	IF(@count_in_bucket < @two_unit, @count_in_bucket / 2, @count_in_bucket / 3))), ''),
       @label := CONCAT(@label_inner := CONCAT('\n(', ROUND((@bucket_size * 5) / @unit_div), ' - ', ROUND((@bucket_size * 6) / @unit_div), @unit, ')'),
                        REPEAT(' ', @max_label_size - LENGTH(@label_inner)),
                        @count_in_bucket := IFNULL((SELECT SUM(cnt)
                                                      FROM sys.x$ps_digest_avg_latency_distribution AS b1 
                                                     WHERE b1.avg_us > @bucket_size * 5 AND b1.avg_us <= @bucket_size * 6), 0)),
       REPEAT(' ', @max_label_len - LENGTH(@label)), '| ',
       IFNULL(REPEAT(IF(@count_in_bucket < @one_unit, '.', IF(@count_in_bucket < @two_unit, '*', '#')), 
       	             IF(@count_in_bucket < @one_unit, @count_in_bucket,
       	             	IF(@count_in_bucket < @two_unit, @count_in_bucket / 2, @count_in_bucket / 3))), ''),
       @label := CONCAT(@label_inner := CONCAT('\n(', ROUND((@bucket_size * 6) / @unit_div), ' - ', ROUND((@bucket_size * 7) / @unit_div), @unit, ')'),
                        REPEAT(' ', @max_label_size - LENGTH(@label_inner)),
                        @count_in_bucket := IFNULL((SELECT SUM(cnt)
                                                      FROM sys.x$ps_digest_avg_latency_distribution AS b1 
                                                     WHERE b1.avg_us > @bucket_size * 6 AND b1.avg_us <= @bucket_size * 7), 0)),
       REPEAT(' ', @max_label_len - LENGTH(@label)), '| ',
       IFNULL(REPEAT(IF(@count_in_bucket < @one_unit, '.', IF(@count_in_bucket < @two_unit, '*', '#')), 
       	             IF(@count_in_bucket < @one_unit, @count_in_bucket,
       	             	IF(@count_in_bucket < @two_unit, @count_in_bucket / 2, @count_in_bucket / 3))), ''),
       @label := CONCAT(@label_inner := CONCAT('\n(', ROUND((@bucket_size * 7) / @unit_div), ' - ', ROUND((@bucket_size * 8) / @unit_div), @unit, ')'),
                        REPEAT(' ', @max_label_size - LENGTH(@label_inner)),
                        @count_in_bucket := IFNULL((SELECT SUM(cnt)
                                                      FROM sys.x$ps_digest_avg_latency_distribution AS b1 
                                                     WHERE b1.avg_us > @bucket_size * 7 AND b1.avg_us <= @bucket_size * 8), 0)),
       REPEAT(' ', @max_label_len - LENGTH(@label)), '| ',
       IFNULL(REPEAT(IF(@count_in_bucket < @one_unit, '.', IF(@count_in_bucket < @two_unit, '*', '#')), 
       	             IF(@count_in_bucket < @one_unit, @count_in_bucket,
       	             	IF(@count_in_bucket < @two_unit, @count_in_bucket / 2, @count_in_bucket / 3))), ''),
       @label := CONCAT(@label_inner := CONCAT('\n(', ROUND((@bucket_size * 8) / @unit_div), ' - ', ROUND((@bucket_size * 9) / @unit_div), @unit, ')'),
                        REPEAT(' ', @max_label_size - LENGTH(@label_inner)),
                        @count_in_bucket := IFNULL((SELECT SUM(cnt)
                                                      FROM sys.x$ps_digest_avg_latency_distribution AS b1 
                                                     WHERE b1.avg_us > @bucket_size * 8 AND b1.avg_us <= @bucket_size * 9), 0)),
       REPEAT(' ', @max_label_len - LENGTH(@label)), '| ',
       IFNULL(REPEAT(IF(@count_in_bucket < @one_unit, '.', IF(@count_in_bucket < @two_unit, '*', '#')), 
       	             IF(@count_in_bucket < @one_unit, @count_in_bucket,
       	             	IF(@count_in_bucket < @two_unit, @count_in_bucket / 2, @count_in_bucket / 3))), ''),
       @label := CONCAT(@label_inner := CONCAT('\n(', ROUND((@bucket_size * 9) / @unit_div), ' - ', ROUND((@bucket_size * 10) / @unit_div), @unit, ')'),
                         REPEAT(' ', @max_label_size - LENGTH(@label_inner)),
                         @count_in_bucket := IFNULL((SELECT SUM(cnt)
                                                       FROM sys.x$ps_digest_avg_latency_distribution AS b1 
                                                      WHERE b1.avg_us > @bucket_size * 9 AND b1.avg_us <= @bucket_size * 10), 0)),
       REPEAT(' ', @max_label_len - LENGTH(@label)), '| ',
       IFNULL(REPEAT(IF(@count_in_bucket < @one_unit, '.', IF(@count_in_bucket < @two_unit, '*', '#')), 
       	             IF(@count_in_bucket < @one_unit, @count_in_bucket,
       	             	IF(@count_in_bucket < @two_unit, @count_in_bucket / 2, @count_in_bucket / 3))), ''),
       @label := CONCAT(@label_inner := CONCAT('\n(', ROUND((@bucket_size * 10) / @unit_div), ' - ', ROUND((@bucket_size * 11) / @unit_div), @unit, ')'),
                        REPEAT(' ', @max_label_size - LENGTH(@label_inner)),
                        @count_in_bucket := IFNULL((SELECT SUM(cnt)
                                                      FROM sys.x$ps_digest_avg_latency_distribution AS b1 
                                                     WHERE b1.avg_us > @bucket_size * 10 AND b1.avg_us <= @bucket_size * 11), 0)),
       REPEAT(' ', @max_label_len - LENGTH(@label)), '| ',
       IFNULL(REPEAT(IF(@count_in_bucket < @one_unit, '.', IF(@count_in_bucket < @two_unit, '*', '#')), 
       	             IF(@count_in_bucket < @one_unit, @count_in_bucket,
       	             	IF(@count_in_bucket < @two_unit, @count_in_bucket / 2, @count_in_bucket / 3))), ''),
       @label := CONCAT(@label_inner := CONCAT('\n(', ROUND((@bucket_size * 11) / @unit_div), ' - ', ROUND((@bucket_size * 12) / @unit_div), @unit, ')'),
                        REPEAT(' ', @max_label_size - LENGTH(@label_inner)),
                        @count_in_bucket := IFNULL((SELECT SUM(cnt)
                                                      FROM sys.x$ps_digest_avg_latency_distribution AS b1 
                                                     WHERE b1.avg_us > @bucket_size * 11 AND b1.avg_us <= @bucket_size * 12), 0)),
       REPEAT(' ', @max_label_len - LENGTH(@label)), '| ',
       IFNULL(REPEAT(IF(@count_in_bucket < @one_unit, '.', IF(@count_in_bucket < @two_unit, '*', '#')), 
       	             IF(@count_in_bucket < @one_unit, @count_in_bucket,
       	             	IF(@count_in_bucket < @two_unit, @count_in_bucket / 2, @count_in_bucket / 3))), ''),
       @label := CONCAT(@label_inner := CONCAT('\n(', ROUND((@bucket_size * 12) / @unit_div), ' - ', ROUND((@bucket_size * 13) / @unit_div), @unit, ')'),
                        REPEAT(' ', @max_label_size - LENGTH(@label_inner)),
                        @count_in_bucket := IFNULL((SELECT SUM(cnt)
                                                      FROM sys.x$ps_digest_avg_latency_distribution AS b1 
                                                     WHERE b1.avg_us > @bucket_size * 12 AND b1.avg_us <= @bucket_size * 13), 0)),
       REPEAT(' ', @max_label_len - LENGTH(@label)), '| ',
       IFNULL(REPEAT(IF(@count_in_bucket < @one_unit, '.', IF(@count_in_bucket < @two_unit, '*', '#')), 
       	             IF(@count_in_bucket < @one_unit, @count_in_bucket,
       	             	IF(@count_in_bucket < @two_unit, @count_in_bucket / 2, @count_in_bucket / 3))), ''),
       @label := CONCAT(@label_inner := CONCAT('\n(', ROUND((@bucket_size * 13) / @unit_div), ' - ', ROUND((@bucket_size * 14) / @unit_div), @unit, ')'),
                        REPEAT(' ', @max_label_size - LENGTH(@label_inner)),
                        @count_in_bucket := IFNULL((SELECT SUM(cnt)
                                                      FROM sys.x$ps_digest_avg_latency_distribution AS b1 
                                                     WHERE b1.avg_us > @bucket_size * 13 AND b1.avg_us <= @bucket_size * 14), 0)),
       REPEAT(' ', @max_label_len - LENGTH(@label)), '| ',
       IFNULL(REPEAT(IF(@count_in_bucket < @one_unit, '.', IF(@count_in_bucket < @two_unit, '*', '#')), 
       	             IF(@count_in_bucket < @one_unit, @count_in_bucket,
       	             	IF(@count_in_bucket < @two_unit, @count_in_bucket / 2, @count_in_bucket / 3))), ''),
       @label := CONCAT(@label_inner := CONCAT('\n(', ROUND((@bucket_size * 14) / @unit_div), ' - ', ROUND((@bucket_size * 15) / @unit_div), @unit, ')'),
                        REPEAT(' ', @max_label_size - LENGTH(@label_inner)),
                        @count_in_bucket := IFNULL((SELECT SUM(cnt)
                                                      FROM sys.x$ps_digest_avg_latency_distribution AS b1 
                                                     WHERE b1.avg_us > @bucket_size * 14 AND b1.avg_us <= @bucket_size * 15), 0)),
       REPEAT(' ', @max_label_len - LENGTH(@label)), '| ',
       IFNULL(REPEAT(IF(@count_in_bucket < @one_unit, '.', IF(@count_in_bucket < @two_unit, '*', '#')), 
       	             IF(@count_in_bucket < @one_unit, @count_in_bucket,
       	             	IF(@count_in_bucket < @two_unit, @count_in_bucket / 2, @count_in_bucket / 3))), ''),
       @label := CONCAT(@label_inner := CONCAT('\n(', ROUND((@bucket_size * 15) / @unit_div), ' - ', ROUND((@bucket_size * 16) / @unit_div), @unit, ')'),
                        REPEAT(' ', @max_label_size - LENGTH(@label_inner)),
                        @count_in_bucket := IFNULL((SELECT SUM(cnt)
                                                      FROM sys.x$ps_digest_avg_latency_distribution AS b1 
                                                     WHERE b1.avg_us > @bucket_size * 15 AND b1.avg_us <= @bucket_size * 16), 0)),
       REPEAT(' ', @max_label_len - LENGTH(@label)), '| ',
       IFNULL(REPEAT(IF(@count_in_bucket < @one_unit, '.', IF(@count_in_bucket < @two_unit, '*', '#')), 
       	             IF(@count_in_bucket < @one_unit, @count_in_bucket,
       	             	IF(@count_in_bucket < @two_unit, @count_in_bucket / 2, @count_in_bucket / 3))), ''),
       '\n\n  Total Statements: ', @total_queries, '; Buckets: ', @buckets , '; Bucket Size: ', ROUND(@bucket_size / @unit_div) , ' ', @unit, ';\n'
      ) AS `Performance Schema Statement Digest Average Latency Histogram`;
END;

create definer = `mysql.sys`@localhost function sys.ps_thread_account(in_thread_id bigint unsigned) returns text comment '
Description
-----------

Return the user@host account for the given Performance Schema thread id.

Parameters
-----------

in_thread_id (BIGINT UNSIGNED):
  The id of the thread to return the account for.

Example
-----------

mysql> select thread_id, processlist_user, processlist_host from performance_schema.threads where type = ''foreground'';
+-----------+------------------+------------------+
| thread_id | processlist_user | processlist_host |
+-----------+------------------+------------------+
|        23 | NULL             | NULL             |
|        30 | root             | localhost        |
|        31 | msandbox         | localhost        |
|        32 | msandbox         | localhost        |
+-----------+------------------+------------------+
4 rows in set (0.00 sec)

mysql> select sys.ps_thread_account(31);
+---------------------------+
| sys.ps_thread_account(31) |
+---------------------------+
| msandbox@localhost        |
+---------------------------+
1 row in set (0.00 sec)
' security invoker reads sql data
BEGIN
    RETURN (SELECT IF(
                      type = 'FOREGROUND',
                      CONCAT(processlist_user, '@', processlist_host),
                      type
                     ) AS account
              FROM `performance_schema`.`threads`
             WHERE thread_id = in_thread_id);
END;

create definer = `mysql.sys`@localhost function sys.ps_thread_id(in_connection_id bigint unsigned) returns bigint unsigned comment '
Description
-----------

Return the Performance Schema THREAD_ID for the specified connection ID.

Parameters
-----------

in_connection_id (BIGINT UNSIGNED):
  The id of the connection to return the thread id for. If NULL, the current
  connection thread id is returned.

Example
-----------

mysql> SELECT sys.ps_thread_id(79);
+----------------------+
| sys.ps_thread_id(79) |
+----------------------+
|                   98 |
+----------------------+
1 row in set (0.00 sec)

mysql> SELECT sys.ps_thread_id(CONNECTION_ID());
+-----------------------------------+
| sys.ps_thread_id(CONNECTION_ID()) |
+-----------------------------------+
|                                98 |
+-----------------------------------+
1 row in set (0.00 sec)
' security invoker reads sql data
BEGIN
  IF (in_connection_id IS NULL) THEN
    RETURN ps_current_thread_id();
  ELSE
    RETURN ps_thread_id(in_connection_id);
  END IF;
END;

create definer = `mysql.sys`@localhost function sys.ps_thread_stack(thd_id bigint unsigned, debug tinyint(1)) returns longtext comment '
Description
-----------

Outputs a JSON formatted stack of all statements, stages and events
within Performance Schema for the specified thread.

Parameters
-----------

thd_id (BIGINT UNSIGNED):
  The id of the thread to trace. This should match the thread_id
  column from the performance_schema.threads table.
in_verbose (BOOLEAN):
  Include file:lineno information in the events.

Example
-----------

(line separation added for output)

mysql> SELECT sys.ps_thread_stack(37, FALSE) AS thread_stack\G
*************************** 1. row ***************************
thread_stack: {"rankdir": "LR","nodesep": "0.10","stack_created": "2014-02-19 13:39:03",
"mysql_version": "5.7.3-m13","mysql_user": "root@localhost","events": 
[{"nesting_event_id": "0", "event_id": "10", "timer_wait": 256.35, "event_info": 
"sql/select", "wait_info": "select @@version_comment limit 1\nerrors: 0\nwarnings: 0\nlock time:
...
' security invoker reads sql data
BEGIN
    DECLARE json_objects LONGTEXT;
    -- Do not track the current thread, it will kill the stack
    UPDATE performance_schema.threads
       SET instrumented = 'NO'
     WHERE processlist_id = CONNECTION_ID();
    SET SESSION group_concat_max_len=@@global.max_allowed_packet;
    -- Select the entire stack of events
    SELECT GROUP_CONCAT(CONCAT( '{'
              , CONCAT_WS( ', '
              , CONCAT('"nesting_event_id": "', IF(nesting_event_id IS NULL, '0', nesting_event_id), '"')
              , CONCAT('"event_id": "', event_id, '"')
              -- Convert from picoseconds to microseconds
              , CONCAT( '"timer_wait": ', ROUND(timer_wait/1000000, 2))  
              , CONCAT( '"event_info": "'
                  , CASE
                        WHEN event_name NOT LIKE 'wait/io%' THEN REPLACE(SUBSTRING_INDEX(event_name, '/', -2), '\\', '\\\\')
                        WHEN event_name NOT LIKE 'wait/io/file%' OR event_name NOT LIKE 'wait/io/socket%' THEN REPLACE(SUBSTRING_INDEX(event_name, '/', -4), '\\', '\\\\')
                        ELSE event_name
                    END
                  , '"'
              )
              -- Always dump the extra wait information gathered for statements
              , CONCAT( '"wait_info": "', IFNULL(wait_info, ''), '"')
              -- If debug is enabled, add the file:lineno information for waits
              , CONCAT( '"source": "', IF(true AND event_name LIKE 'wait%', IFNULL(wait_info, ''), ''), '"')
              -- Depending on the type of event, name it appropriately
              , CASE 
                     WHEN event_name LIKE 'wait/io/file%'      THEN '"event_type": "io/file"'
                     WHEN event_name LIKE 'wait/io/table%'     THEN '"event_type": "io/table"'
                     WHEN event_name LIKE 'wait/io/socket%'    THEN '"event_type": "io/socket"'
                     WHEN event_name LIKE 'wait/synch/mutex%'  THEN '"event_type": "synch/mutex"'
                     WHEN event_name LIKE 'wait/synch/cond%'   THEN '"event_type": "synch/cond"'
                     WHEN event_name LIKE 'wait/synch/rwlock%' THEN '"event_type": "synch/rwlock"'
                     WHEN event_name LIKE 'wait/lock%'         THEN '"event_type": "lock"'
                     WHEN event_name LIKE 'statement/%'        THEN '"event_type": "stmt"'
                     WHEN event_name LIKE 'stage/%'            THEN '"event_type": "stage"'
                     WHEN event_name LIKE '%idle%'             THEN '"event_type": "idle"'
                     ELSE '' 
                END                   
            )
            , '}'
          )
          ORDER BY event_id ASC SEPARATOR ',') event
    INTO json_objects
    FROM (
          -- Select all statements, with the extra tracing information available
          (SELECT thread_id, event_id, event_name, timer_wait, timer_start, nesting_event_id, 
                  CONCAT(sql_text, '\\n',
                         'errors: ', errors, '\\n',
                         'warnings: ', warnings, '\\n',
                         'lock time: ', ROUND(lock_time/1000000, 2),'us\\n',
                         'rows affected: ', rows_affected, '\\n',
                         'rows sent: ', rows_sent, '\\n',
                         'rows examined: ', rows_examined, '\\n',
                         'tmp tables: ', created_tmp_tables, '\\n',
                         'tmp disk tables: ', created_tmp_disk_tables, '\\n',
                         'select scan: ', select_scan, '\\n',
                         'select full join: ', select_full_join, '\\n',
                         'select full range join: ', select_full_range_join, '\\n',
                         'select range: ', select_range, '\\n',
                         'select range check: ', select_range_check, '\\n', 
                         'sort merge passes: ', sort_merge_passes, '\\n',
                         'sort rows: ', sort_rows, '\\n',
                         'sort range: ', sort_range, '\\n',
                         'sort scan: ', sort_scan, '\\n',
                         'no index used: ', IF(no_index_used, 'TRUE', 'FALSE'), '\\n',
                         'no good index used: ', IF(no_good_index_used, 'TRUE', 'FALSE'), '\\n'
                         ) AS wait_info
             FROM performance_schema.events_statements_history_long WHERE thread_id = thd_id)
          UNION 
          -- Select all stages
          (SELECT thread_id, event_id, event_name, timer_wait, timer_start, nesting_event_id, null AS wait_info
             FROM performance_schema.events_stages_history_long WHERE thread_id = thd_id) 
          UNION
          -- Select all events, adding information appropriate to the event
          (SELECT thread_id, event_id, 
                  CONCAT(event_name , 
                         IF(event_name NOT LIKE 'wait/synch/mutex%', IFNULL(CONCAT(' - ', operation), ''), ''), 
                         IF(number_of_bytes IS NOT NULL, CONCAT(' ', number_of_bytes, ' bytes'), ''),
                         IF(event_name LIKE 'wait/io/file%', '\\n', ''),
                         IF(object_schema IS NOT NULL, CONCAT('\\nObject: ', object_schema, '.'), ''), 
                         IF(object_name IS NOT NULL, 
                            IF (event_name LIKE 'wait/io/socket%',
                                -- Print the socket if used, else the IP:port as reported
                                CONCAT(IF (object_name LIKE ':0%', @@socket, object_name)),
                                object_name),
                            ''),
                         IF(index_name IS NOT NULL, CONCAT(' Index: ', index_name), ''),'\\n'
                         ) AS event_name,
                  timer_wait, timer_start, nesting_event_id, source AS wait_info
             FROM performance_schema.events_waits_history_long WHERE thread_id = thd_id)) events 
    ORDER BY event_id;
    RETURN CONCAT('{', 
                  CONCAT_WS(',', 
                            '"rankdir": "LR"',
                            '"nodesep": "0.10"',
                            CONCAT('"stack_created": "', NOW(), '"'),
                            CONCAT('"mysql_version": "', VERSION(), '"'),
                            CONCAT('"mysql_user": "', CURRENT_USER(), '"'),
                            CONCAT('"events": [', IFNULL(json_objects,''), ']')
                           ),
                  '}');
END;

create definer = `mysql.sys`@localhost function sys.ps_thread_trx_info(in_thread_id bigint unsigned) returns longtext comment '
Description
-----------

Returns a JSON object with info on the given threads current transaction, 
and the statements it has already executed, derived from the
performance_schema.events_transactions_current and
performance_schema.events_statements_history tables (so the consumers 
for these also have to be enabled within Performance Schema to get full
data in the object).

When the output exceeds the default truncation length (65535), a JSON error
object is returned, such as:

{ "error": "Trx info truncated: Row 6 was cut by GROUP_CONCAT()" }

Similar error objects are returned for other warnings/and exceptions raised
when calling the function.

The max length of the output of this function can be controlled with the
ps_thread_trx_info.max_length variable set via sys_config, or the
@sys.ps_thread_trx_info.max_length user variable, as appropriate.

Parameters
-----------

in_thread_id (BIGINT UNSIGNED):
  The id of the thread to return the transaction info for.

Example
-----------

SELECT sys.ps_thread_trx_info(48)\G
*************************** 1. row ***************************
sys.ps_thread_trx_info(48): [
  {
    "time": "790.70 us",
    "state": "COMMITTED",
    "mode": "READ WRITE",
    "autocommitted": "NO",
    "gtid": "AUTOMATIC",
    "isolation": "REPEATABLE READ",
    "statements_executed": [
      {
        "sql_text": "INSERT INTO info VALUES (1, ''foo'')",
        "time": "471.02 us",
        "schema": "trx",
        "rows_examined": 0,
        "rows_affected": 1,
        "rows_sent": 0,
        "tmp_tables": 0,
        "tmp_disk_tables": 0,
        "sort_rows": 0,
        "sort_merge_passes": 0
      },
      {
        "sql_text": "COMMIT",
        "time": "254.42 us",
        "schema": "trx",
        "rows_examined": 0,
        "rows_affected": 0,
        "rows_sent": 0,
        "tmp_tables": 0,
        "tmp_disk_tables": 0,
        "sort_rows": 0,
        "sort_merge_passes": 0
      }
    ]
  },
  {
    "time": "426.20 us",
    "state": "COMMITTED",
    "mode": "READ WRITE",
    "autocommitted": "NO",
    "gtid": "AUTOMATIC",
    "isolation": "REPEATABLE READ",
    "statements_executed": [
      {
        "sql_text": "INSERT INTO info VALUES (2, ''bar'')",
        "time": "107.33 us",
        "schema": "trx",
        "rows_examined": 0,
        "rows_affected": 1,
        "rows_sent": 0,
        "tmp_tables": 0,
        "tmp_disk_tables": 0,
        "sort_rows": 0,
        "sort_merge_passes": 0
      },
      {
        "sql_text": "COMMIT",
        "time": "213.23 us",
        "schema": "trx",
        "rows_examined": 0,
        "rows_affected": 0,
        "rows_sent": 0,
        "tmp_tables": 0,
        "tmp_disk_tables": 0,
        "sort_rows": 0,
        "sort_merge_passes": 0
      }
    ]
  }
]
1 row in set (0.03 sec)
' security invoker reads sql data
BEGIN
    DECLARE v_output LONGTEXT DEFAULT '{}';
    DECLARE v_msg_text TEXT DEFAULT '';
    DECLARE v_signal_msg TEXT DEFAULT '';
    DECLARE v_mysql_errno INT;
    DECLARE v_max_output_len BIGINT;
    -- Capture warnings/errors such as group_concat truncation
    -- and report as JSON error objects
    DECLARE EXIT HANDLER FOR SQLWARNING, SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_msg_text = MESSAGE_TEXT,
            v_mysql_errno = MYSQL_ERRNO;
        IF v_mysql_errno = 1260 THEN
            SET v_signal_msg = CONCAT('{ "error": "Trx info truncated: ', v_msg_text, '" }');
        ELSE
            SET v_signal_msg = CONCAT('{ "error": "', v_msg_text, '" }');
        END IF;
        RETURN v_signal_msg;
    END;
    -- Set configuration options
    IF (@sys.ps_thread_trx_info.max_length IS NULL) THEN
        SET @sys.ps_thread_trx_info.max_length = sys.sys_get_config('ps_thread_trx_info.max_length', 65535);
    END IF;
    IF (@sys.ps_thread_trx_info.max_length != @@session.group_concat_max_len) THEN
        SET @old_group_concat_max_len = @@session.group_concat_max_len;
        -- Convert to int value for the SET, and give some surrounding space
        SET v_max_output_len = (@sys.ps_thread_trx_info.max_length - 5);
        SET SESSION group_concat_max_len = v_max_output_len;
    END IF;
    SET v_output = (
        SELECT CONCAT('[', IFNULL(GROUP_CONCAT(trx_info ORDER BY event_id), ''), '\n]') AS trx_info
          FROM (SELECT trxi.thread_id, 
                       trxi.event_id,
                       GROUP_CONCAT(
                         IFNULL(
                           CONCAT('\n  {\n',
                                  '    "time": "', IFNULL(format_pico_time(trxi.timer_wait), ''), '",\n',
                                  '    "state": "', IFNULL(trxi.state, ''), '",\n',
                                  '    "mode": "', IFNULL(trxi.access_mode, ''), '",\n',
                                  '    "autocommitted": "', IFNULL(trxi.autocommit, ''), '",\n',
                                  '    "gtid": "', IFNULL(trxi.gtid, ''), '",\n',
                                  '    "isolation": "', IFNULL(trxi.isolation_level, ''), '",\n',
                                  '    "statements_executed": [', IFNULL(s.stmts, ''), IF(s.stmts IS NULL, ' ]\n', '\n    ]\n'),
                                  '  }'
                           ), 
                           '') 
                         ORDER BY event_id) AS trx_info
                  FROM (
                        (SELECT thread_id, event_id, timer_wait, state,access_mode, autocommit, gtid, isolation_level
                           FROM performance_schema.events_transactions_current
                          WHERE thread_id = in_thread_id
                            AND end_event_id IS NULL)
                        UNION
                        (SELECT thread_id, event_id, timer_wait, state,access_mode, autocommit, gtid, isolation_level
                           FROM performance_schema.events_transactions_history
                          WHERE thread_id = in_thread_id)
                       ) AS trxi
                  LEFT JOIN (SELECT thread_id,
                                    nesting_event_id,
                                    GROUP_CONCAT(
                                      IFNULL(
                                        CONCAT('\n      {\n',
                                               '        "sql_text": "', IFNULL(sys.format_statement(REPLACE(sql_text, '\\', '\\\\')), ''), '",\n',
                                               '        "time": "', IFNULL(format_pico_time(timer_wait), ''), '",\n',
                                               '        "schema": "', IFNULL(current_schema, ''), '",\n',
                                               '        "rows_examined": ', IFNULL(rows_examined, ''), ',\n',
                                               '        "rows_affected": ', IFNULL(rows_affected, ''), ',\n',
                                               '        "rows_sent": ', IFNULL(rows_sent, ''), ',\n',
                                               '        "tmp_tables": ', IFNULL(created_tmp_tables, ''), ',\n',
                                               '        "tmp_disk_tables": ', IFNULL(created_tmp_disk_tables, ''), ',\n',
                                               '        "sort_rows": ', IFNULL(sort_rows, ''), ',\n',
                                               '        "sort_merge_passes": ', IFNULL(sort_merge_passes, ''), '\n',
                                               '      }'), '') ORDER BY event_id) AS stmts
                               FROM performance_schema.events_statements_history
                              WHERE sql_text IS NOT NULL
                                AND thread_id = in_thread_id
                              GROUP BY thread_id, nesting_event_id
                            ) AS s 
                    ON trxi.thread_id = s.thread_id 
                   AND trxi.event_id = s.nesting_event_id
                 WHERE trxi.thread_id = in_thread_id
                 GROUP BY trxi.thread_id, trxi.event_id
                ) trxs
          GROUP BY thread_id
    );
    IF (@old_group_concat_max_len IS NOT NULL) THEN
        SET SESSION group_concat_max_len = @old_group_concat_max_len;
    END IF;
    RETURN v_output;
END;

create definer = `mysql.sys`@localhost procedure sys.ps_trace_statement_digest(IN in_digest varchar(64), IN in_runtime int, IN in_interval decimal(2,2), IN in_start_fresh tinyint(1), IN in_auto_enable tinyint(1)) comment '
Description
-----------

Traces all instrumentation within Performance Schema for a specific
Statement Digest.

When finding a statement of interest within the
performance_schema.events_statements_summary_by_digest table, feed
the DIGEST value in to this procedure, set how long to poll for,
and at what interval to poll, and it will generate a report of all
statistics tracked within Performance Schema for that digest for the
interval.

It will also attempt to generate an EXPLAIN for the longest running
example of the digest during the interval. Note this may fail, as:

   * Performance Schema truncates long SQL_TEXT values (and hence the
     EXPLAIN will fail due to parse errors)
   * the default schema is sys (so tables that are not fully qualified
     in the query may not be found)
   * some queries such as SHOW are not supported in EXPLAIN.

When the EXPLAIN fails, the error will be ignored and no EXPLAIN
output generated.

Requires the SUPER privilege for "SET sql_log_bin = 0;".

Parameters
-----------

in_digest (VARCHAR(64)):
  The statement digest identifier you would like to analyze
in_runtime (INT):
  The number of seconds to run analysis for
in_interval (DECIMAL(2,2)):
  The interval (in seconds, may be fractional) at which to try
  and take snapshots
in_start_fresh (BOOLEAN):
  Whether to TRUNCATE the events_statements_history_long and
  events_stages_history_long tables before starting
in_auto_enable (BOOLEAN):
  Whether to automatically turn on required consumers

Example
-----------

mysql> call ps_trace_statement_digest(''891ec6860f98ba46d89dd20b0c03652c'', 10, 0.1, true, true);
+--------------------+
| SUMMARY STATISTICS |
+--------------------+
| SUMMARY STATISTICS |
+--------------------+
1 row in set (9.11 sec)

+------------+-----------+-----------+-----------+---------------+------------+------------+
| executions | exec_time | lock_time | rows_sent | rows_examined | tmp_tables | full_scans |
+------------+-----------+-----------+-----------+---------------+------------+------------+
|         21 | 4.11 ms   | 2.00 ms   |         0 |            21 |          0 |          0 |
+------------+-----------+-----------+-----------+---------------+------------+------------+
1 row in set (9.11 sec)

+------------------------------------------+-------+-----------+
| event_name                               | count | latency   |
+------------------------------------------+-------+-----------+
| stage/sql/checking query cache for query |    16 | 724.37 us |
| stage/sql/statistics                     |    16 | 546.92 us |
| stage/sql/freeing items                  |    18 | 520.11 us |
| stage/sql/init                           |    51 | 466.80 us |
...
| stage/sql/cleaning up                    |    18 | 11.92 us  |
| stage/sql/executing                      |    16 | 6.95 us   |
+------------------------------------------+-------+-----------+
17 rows in set (9.12 sec)

+---------------------------+
| LONGEST RUNNING STATEMENT |
+---------------------------+
| LONGEST RUNNING STATEMENT |
+---------------------------+
1 row in set (9.16 sec)

+-----------+-----------+-----------+-----------+---------------+------------+-----------+
| thread_id | exec_time | lock_time | rows_sent | rows_examined | tmp_tables | full_scan |
+-----------+-----------+-----------+-----------+---------------+------------+-----------+
|    166646 | 618.43 us | 1.00 ms   |         0 |             1 |          0 |         0 |
+-----------+-----------+-----------+-----------+---------------+------------+-----------+
1 row in set (9.16 sec)

// Truncated for clarity...
+-----------------------------------------------------------------+
| sql_text                                                        |
+-----------------------------------------------------------------+
| select hibeventhe0_.id as id1382_, hibeventhe0_.createdTime ... |
+-----------------------------------------------------------------+
1 row in set (9.17 sec)

+------------------------------------------+-----------+
| event_name                               | latency   |
+------------------------------------------+-----------+
| stage/sql/init                           | 8.61 us   |
| stage/sql/Waiting for query cache lock   | 453.23 us |
| stage/sql/init                           | 331.07 ns |
| stage/sql/checking query cache for query | 43.04 us  |
...
| stage/sql/freeing items                  | 30.46 us  |
| stage/sql/cleaning up                    | 662.13 ns |
+------------------------------------------+-----------+
18 rows in set (9.23 sec)

+----+-------------+--------------+-------+---------------+-----------+---------+-------------+------+-------+
| id | select_type | table        | type  | possible_keys | key       | key_len | ref         | rows | Extra |
+----+-------------+--------------+-------+---------------+-----------+---------+-------------+------+-------+
|  1 | SIMPLE      | hibeventhe0_ | const | fixedTime     | fixedTime | 775     | const,const |    1 | NULL  |
+----+-------------+--------------+-------+---------------+-----------+---------+-------------+------+-------+
1 row in set (9.27 sec)

Query OK, 0 rows affected (9.28 sec)
' security invoker modifies sql data
BEGIN
    DECLARE v_start_fresh BOOLEAN DEFAULT false;
    DECLARE v_auto_enable BOOLEAN DEFAULT false;
    DECLARE v_explain     BOOLEAN DEFAULT true;
    DECLARE v_this_thread_enabed ENUM('YES', 'NO');
    DECLARE v_runtime INT DEFAULT 0;
    DECLARE v_start INT DEFAULT 0;
    DECLARE v_found_stmts INT;
    SET @log_bin := @@sql_log_bin;
    SET sql_log_bin = 0;
    -- Do not track the current thread, it will kill the stack
    SELECT INSTRUMENTED INTO v_this_thread_enabed FROM performance_schema.threads WHERE PROCESSLIST_ID = CONNECTION_ID();
    CALL sys.ps_setup_disable_thread(CONNECTION_ID());
    DROP TEMPORARY TABLE IF EXISTS stmt_trace;
    CREATE TEMPORARY TABLE stmt_trace (
        thread_id BIGINT UNSIGNED,
        timer_start BIGINT UNSIGNED,
        event_id BIGINT UNSIGNED,
        sql_text longtext,
        timer_wait BIGINT UNSIGNED,
        lock_time BIGINT UNSIGNED,
        errors BIGINT UNSIGNED,
        mysql_errno INT,
        rows_sent BIGINT UNSIGNED,
        rows_affected BIGINT UNSIGNED,
        rows_examined BIGINT UNSIGNED,
        created_tmp_tables BIGINT UNSIGNED,
        created_tmp_disk_tables BIGINT UNSIGNED,
        no_index_used BIGINT UNSIGNED,
        PRIMARY KEY (thread_id, timer_start)
    );
    DROP TEMPORARY TABLE IF EXISTS stmt_stages;
    CREATE TEMPORARY TABLE stmt_stages (
       event_id BIGINT UNSIGNED,
       stmt_id BIGINT UNSIGNED,
       event_name VARCHAR(128),
       timer_wait BIGINT UNSIGNED,
       PRIMARY KEY (event_id)
    );
    SET v_start_fresh = in_start_fresh;
    IF v_start_fresh THEN
        TRUNCATE TABLE performance_schema.events_statements_history_long;
        TRUNCATE TABLE performance_schema.events_stages_history_long;
    END IF;
    SET v_auto_enable = in_auto_enable;
    IF v_auto_enable THEN
        CALL sys.ps_setup_save(0);
        UPDATE performance_schema.threads
           SET INSTRUMENTED = IF(PROCESSLIST_ID IS NOT NULL, 'YES', 'NO');
        -- Only the events_statements_history_long and events_stages_history_long tables and their ancestors are needed
        UPDATE performance_schema.setup_consumers
           SET ENABLED = 'YES'
         WHERE NAME NOT LIKE '%\_history'
               AND NAME NOT LIKE 'events_wait%'
               AND NAME NOT LIKE 'events_transactions%'
               AND NAME <> 'statements_digest';
        UPDATE performance_schema.setup_instruments
           SET ENABLED = 'YES',
               TIMED   = 'YES'
         WHERE NAME LIKE 'statement/%' OR NAME LIKE 'stage/%';
    END IF;
    WHILE v_runtime < in_runtime DO
        SELECT UNIX_TIMESTAMP() INTO v_start;
        INSERT IGNORE INTO stmt_trace
        SELECT thread_id, timer_start, event_id, sql_text, timer_wait, lock_time, errors, mysql_errno, 
               rows_sent, rows_affected, rows_examined, created_tmp_tables, created_tmp_disk_tables, no_index_used
          FROM performance_schema.events_statements_history_long
        WHERE digest = in_digest;
        INSERT IGNORE INTO stmt_stages
        SELECT stages.event_id, stmt_trace.event_id,
               stages.event_name, stages.timer_wait
          FROM performance_schema.events_stages_history_long AS stages
          JOIN stmt_trace ON stages.nesting_event_id = stmt_trace.event_id;
        SELECT SLEEP(in_interval) INTO @sleep;
        SET v_runtime = v_runtime + (UNIX_TIMESTAMP() - v_start);
    END WHILE;
    SELECT "SUMMARY STATISTICS";
    SELECT COUNT(*) executions,
           format_pico_time(SUM(timer_wait)) AS exec_time,
           format_pico_time(SUM(lock_time)) AS lock_time,
           SUM(rows_sent) AS rows_sent,
           SUM(rows_affected) AS rows_affected,
           SUM(rows_examined) AS rows_examined,
           SUM(created_tmp_tables) AS tmp_tables,
           SUM(no_index_used) AS full_scans
      FROM stmt_trace;
    SELECT event_name,
           COUNT(*) as count,
           format_pico_time(SUM(timer_wait)) as latency
      FROM stmt_stages
     GROUP BY event_name
     ORDER BY SUM(timer_wait) DESC;
    SELECT "LONGEST RUNNING STATEMENT";
    SELECT thread_id,
           format_pico_time(timer_wait) AS exec_time,
           format_pico_time(lock_time) AS lock_time,
           rows_sent,
           rows_affected,
           rows_examined,
           created_tmp_tables AS tmp_tables,
           no_index_used AS full_scan
      FROM stmt_trace
     ORDER BY timer_wait DESC LIMIT 1;
    SELECT sql_text
      FROM stmt_trace
     ORDER BY timer_wait DESC LIMIT 1;
    SELECT sql_text, event_id INTO @sql, @sql_id
      FROM stmt_trace
    ORDER BY timer_wait DESC LIMIT 1;
    IF (@sql_id IS NOT NULL) THEN
        SELECT event_name,
               format_pico_time(timer_wait) as latency
          FROM stmt_stages
         WHERE stmt_id = @sql_id
         ORDER BY event_id;
    END IF;
    DROP TEMPORARY TABLE stmt_trace;
    DROP TEMPORARY TABLE stmt_stages;
    IF (@sql IS NOT NULL) THEN
        SET @stmt := CONCAT("EXPLAIN FORMAT=JSON ", @sql);
        BEGIN
            -- Not all queries support EXPLAIN, so catch the cases that are
            -- not supported. Currently that includes cases where the table
            -- is not fully qualified and is not in the default schema for this
            -- procedure as it's not possible to change the default schema inside
            -- a procedure.
            --
            -- Errno = 1064: You have an error in your SQL syntax
            -- Errno = 1146: Table '...' doesn't exist
            DECLARE CONTINUE HANDLER FOR 1064, 1146 SET v_explain = false;
            PREPARE explain_stmt FROM @stmt;
        END;
        IF (v_explain) THEN
            EXECUTE explain_stmt;
            DEALLOCATE PREPARE explain_stmt;
        END IF;
    END IF;
    IF v_auto_enable THEN
        CALL sys.ps_setup_reload_saved();
    END IF;
    -- Restore INSTRUMENTED for this thread
    IF (v_this_thread_enabed = 'YES') THEN
        CALL sys.ps_setup_enable_thread(CONNECTION_ID());
    END IF;
    SET sql_log_bin = @log_bin;
END;

create definer = `mysql.sys`@localhost procedure sys.ps_trace_thread(IN in_thread_id bigint unsigned, IN in_outfile varchar(255), IN in_max_runtime decimal(20,2), IN in_interval decimal(20,2), IN in_start_fresh tinyint(1), IN in_auto_setup tinyint(1), IN in_debug tinyint(1)) comment '
Description
-----------

Dumps all data within Performance Schema for an instrumented thread,
to create a DOT formatted graph file. 

Each resultset returned from the procedure should be used for a complete graph

Requires the SUPER privilege for "SET sql_log_bin = 0;".

Parameters
-----------

in_thread_id (BIGINT UNSIGNED):
  The thread that you would like a stack trace for
in_outfile  (VARCHAR(255)):
  The filename the dot file will be written to
in_max_runtime (DECIMAL(20,2)):
  The maximum time to keep collecting data.
  Use NULL to get the default which is 60 seconds.
in_interval (DECIMAL(20,2)): 
  How long to sleep between data collections. 
  Use NULL to get the default which is 1 second.
in_start_fresh (BOOLEAN):
  Whether to reset all Performance Schema data before tracing.
in_auto_setup (BOOLEAN):
  Whether to disable all other threads and enable all consumers/instruments. 
  This will also reset the settings at the end of the run.
in_debug (BOOLEAN):
  Whether you would like to include file:lineno in the graph

Example
-----------

mysql> CALL sys.ps_trace_thread(25, CONCAT(''/tmp/stack-'', REPLACE(NOW(), '' '', ''-''), ''.dot''), NULL, NULL, TRUE, TRUE, TRUE);
+-------------------+
| summary           |
+-------------------+
| Disabled 1 thread |
+-------------------+
1 row in set (0.00 sec)

+---------------------------------------------+
| Info                                        |
+---------------------------------------------+
| Data collection starting for THREAD_ID = 25 |
+---------------------------------------------+
1 row in set (0.03 sec)

+-----------------------------------------------------------+
| Info                                                      |
+-----------------------------------------------------------+
| Stack trace written to /tmp/stack-2014-02-16-21:18:41.dot |
+-----------------------------------------------------------+
1 row in set (60.07 sec)

+-------------------------------------------------------------------+
| Convert to PDF                                                    |
+-------------------------------------------------------------------+
| dot -Tpdf -o /tmp/stack_25.pdf /tmp/stack-2014-02-16-21:18:41.dot |
+-------------------------------------------------------------------+
1 row in set (60.07 sec)

+-------------------------------------------------------------------+
| Convert to PNG                                                    |
+-------------------------------------------------------------------+
| dot -Tpng -o /tmp/stack_25.png /tmp/stack-2014-02-16-21:18:41.dot |
+-------------------------------------------------------------------+
1 row in set (60.07 sec)

+------------------+
| summary          |
+------------------+
| Enabled 1 thread |
+------------------+
1 row in set (60.32 sec)
' security invoker modifies sql data
BEGIN
    DECLARE v_done bool DEFAULT FALSE;
    DECLARE v_start, v_runtime DECIMAL(20,2) DEFAULT 0.0;
    DECLARE v_min_event_id bigint unsigned DEFAULT 0;
    DECLARE v_this_thread_enabed ENUM('YES', 'NO');
    DECLARE v_event longtext;
    DECLARE c_stack CURSOR FOR
        SELECT CONCAT(IF(nesting_event_id IS NOT NULL, CONCAT(nesting_event_id, ' -> '), ''), 
                    event_id, '; ', event_id, ' [label="',
                    -- Convert from picoseconds to microseconds
                    '(', format_pico_time(timer_wait), ') ',
                    IF (event_name NOT LIKE 'wait/io%', 
                        SUBSTRING_INDEX(event_name, '/', -2), 
                        IF (event_name NOT LIKE 'wait/io/file%' OR event_name NOT LIKE 'wait/io/socket%',
                            SUBSTRING_INDEX(event_name, '/', -4),
                            event_name)
                        ),
                    -- Always dump the extra wait information gathered for transactions and statements
                    IF (event_name LIKE 'transaction', IFNULL(CONCAT('\\n', wait_info), ''), ''),
                    IF (event_name LIKE 'statement/%', IFNULL(CONCAT('\\n', wait_info), ''), ''),
                    -- If debug is enabled, add the file:lineno information for waits
                    IF (in_debug AND event_name LIKE 'wait%', wait_info, ''),
                    '", ', 
                    -- Depending on the type of event, style appropriately
                    CASE WHEN event_name LIKE 'wait/io/file%' THEN 
                           'shape=box, style=filled, color=red'
                         WHEN event_name LIKE 'wait/io/table%' THEN 
                           'shape=box, style=filled, color=green'
                         WHEN event_name LIKE 'wait/io/socket%' THEN
                           'shape=box, style=filled, color=yellow'
                         WHEN event_name LIKE 'wait/synch/mutex%' THEN
                           'style=filled, color=lightskyblue'
                         WHEN event_name LIKE 'wait/synch/cond%' THEN
                           'style=filled, color=darkseagreen3'
                         WHEN event_name LIKE 'wait/synch/rwlock%' THEN
                           'style=filled, color=orchid'
                         WHEN event_name LIKE 'wait/synch/sxlock%' THEN
                           'style=filled, color=palevioletred' 
                         WHEN event_name LIKE 'wait/lock%' THEN
                           'shape=box, style=filled, color=tan'
                         WHEN event_name LIKE 'statement/%' THEN
                           CONCAT('shape=box, style=bold',
                                  -- Style statements depending on COM vs SQL
                                  CASE WHEN event_name LIKE 'statement/com/%' THEN
                                         ' style=filled, color=darkseagreen'
                                       ELSE
                                         -- Use long query time from the server to
                                         -- flag long running statements in red
                                         IF((timer_wait/1000000000000) > @@long_query_time, 
                                            ' style=filled, color=red', 
                                            ' style=filled, color=lightblue')
                                  END
                           )
                         WHEN event_name LIKE 'transaction' THEN
                           'shape=box, style=filled, color=lightblue3'
                         WHEN event_name LIKE 'stage/%' THEN
                           'style=filled, color=slategray3'
                         -- IDLE events are on their own, call attention to them
                         WHEN event_name LIKE '%idle%' THEN
                           'shape=box, style=filled, color=firebrick3'
                         ELSE '' END,
                     '];\n'
                   ) event, event_id
        FROM (
             -- Select all transactions
             (SELECT thread_id, event_id, event_name, timer_wait, timer_start, nesting_event_id,
                     CONCAT('trx_id: ',  IFNULL(trx_id, ''), '\\n',
                            'gtid: ', IFNULL(gtid, ''), '\\n',
                            'state: ', state, '\\n',
                            'mode: ', access_mode, '\\n',
                            'isolation: ', isolation_level, '\\n',
                            'autocommit: ', autocommit, '\\n',
                            'savepoints: ', number_of_savepoints, '\\n'
                     ) AS wait_info
                FROM performance_schema.events_transactions_history_long
               WHERE thread_id = in_thread_id AND event_id > v_min_event_id)
             UNION
             -- Select all statements, with the extra tracing information available
             (SELECT thread_id, event_id, event_name, timer_wait, timer_start, nesting_event_id, 
                     CONCAT('statement: ', sql_text, '\\n',
                            'errors: ', errors, '\\n',
                            'warnings: ', warnings, '\\n',
                            'lock time: ', format_pico_time(lock_time),'\\n',
                            'rows affected: ', rows_affected, '\\n',
                            'rows sent: ', rows_sent, '\\n',
                            'rows examined: ', rows_examined, '\\n',
                            'tmp tables: ', created_tmp_tables, '\\n',
                            'tmp disk tables: ', created_tmp_disk_tables, '\\n'
                            'select scan: ', select_scan, '\\n',
                            'select full join: ', select_full_join, '\\n',
                            'select full range join: ', select_full_range_join, '\\n',
                            'select range: ', select_range, '\\n',
                            'select range check: ', select_range_check, '\\n', 
                            'sort merge passes: ', sort_merge_passes, '\\n',
                            'sort rows: ', sort_rows, '\\n',
                            'sort range: ', sort_range, '\\n',
                            'sort scan: ', sort_scan, '\\n',
                            'no index used: ', IF(no_index_used, 'TRUE', 'FALSE'), '\\n',
                            'no good index used: ', IF(no_good_index_used, 'TRUE', 'FALSE'), '\\n'
                     ) AS wait_info
                FROM performance_schema.events_statements_history_long
               WHERE thread_id = in_thread_id AND event_id > v_min_event_id)
             UNION
             -- Select all stages
             (SELECT thread_id, event_id, event_name, timer_wait, timer_start, nesting_event_id, null AS wait_info
                FROM performance_schema.events_stages_history_long 
               WHERE thread_id = in_thread_id AND event_id > v_min_event_id)
             UNION 
             -- Select all events, adding information appropriate to the event
             (SELECT thread_id, event_id, 
                     CONCAT(event_name, 
                            IF(event_name NOT LIKE 'wait/synch/mutex%', IFNULL(CONCAT(' - ', operation), ''), ''), 
                            IF(number_of_bytes IS NOT NULL, CONCAT(' ', number_of_bytes, ' bytes'), ''),
                            IF(event_name LIKE 'wait/io/file%', '\\n', ''),
                            IF(object_schema IS NOT NULL, CONCAT('\\nObject: ', object_schema, '.'), ''), 
                            IF(object_name IS NOT NULL, 
                               IF (event_name LIKE 'wait/io/socket%',
                                   -- Print the socket if used, else the IP:port as reported
                                   CONCAT('\\n', IF (object_name LIKE ':0%', @@socket, object_name)),
                                   object_name),
                               ''
                            ),
                            IF(index_name IS NOT NULL, CONCAT(' Index: ', index_name), ''), '\\n'
                     ) AS event_name,
                     timer_wait, timer_start, nesting_event_id, source AS wait_info
                FROM performance_schema.events_waits_history_long
               WHERE thread_id = in_thread_id AND event_id > v_min_event_id)
           ) events 
       ORDER BY event_id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = TRUE;
    SET @log_bin := @@sql_log_bin;
    SET sql_log_bin = 0;
    -- Do not track the current thread, it will kill the stack
    SELECT INSTRUMENTED INTO v_this_thread_enabed FROM performance_schema.threads WHERE PROCESSLIST_ID = CONNECTION_ID();
    CALL sys.ps_setup_disable_thread(CONNECTION_ID());
    IF (in_auto_setup) THEN
        CALL sys.ps_setup_save(0);
        -- Ensure only the thread to create the stack trace for is instrumented and that we instrument everything.
        DELETE FROM performance_schema.setup_actors;
        UPDATE performance_schema.threads
           SET INSTRUMENTED = IF(THREAD_ID = in_thread_id, 'YES', 'NO');
        -- only the %_history_long tables and it ancestors are needed
        UPDATE performance_schema.setup_consumers
           SET ENABLED = 'YES'
         WHERE NAME NOT LIKE '%\_history';
        UPDATE performance_schema.setup_instruments
           SET ENABLED = 'YES',
               TIMED   = 'YES';
    END IF;
    IF (in_start_fresh) THEN
        TRUNCATE performance_schema.events_transactions_history_long;
        TRUNCATE performance_schema.events_statements_history_long;
        TRUNCATE performance_schema.events_stages_history_long;
        TRUNCATE performance_schema.events_waits_history_long;
    END IF;
    DROP TEMPORARY TABLE IF EXISTS tmp_events;
    CREATE TEMPORARY TABLE tmp_events (
      event_id bigint unsigned NOT NULL,
      event longblob,
      PRIMARY KEY (event_id)
    );
    -- Print headers for a .dot file
    INSERT INTO tmp_events VALUES (0, CONCAT('digraph events { rankdir=LR; nodesep=0.10;\n',
                                             '// Stack created .....: ', NOW(), '\n',
                                             '// MySQL version .....: ', VERSION(), '\n',
                                             '// MySQL hostname ....: ', @@hostname, '\n',
                                             '// MySQL port ........: ', @@port, '\n',
                                             '// MySQL socket ......: ', @@socket, '\n',
                                             '// MySQL user ........: ', CURRENT_USER(), '\n'));
    SELECT CONCAT('Data collection starting for THREAD_ID = ', in_thread_id) AS 'Info';
    SET v_min_event_id = 0,
        v_start        = UNIX_TIMESTAMP(),
        in_interval    = IFNULL(in_interval, 1.00),
        in_max_runtime = IFNULL(in_max_runtime, 60.00);
    WHILE (v_runtime < in_max_runtime
           AND (SELECT INSTRUMENTED FROM performance_schema.threads WHERE THREAD_ID = in_thread_id) = 'YES') DO
        SET v_done = FALSE;
        OPEN c_stack;
        c_stack_loop: LOOP
            FETCH c_stack INTO v_event, v_min_event_id;
            IF v_done THEN
                LEAVE c_stack_loop;
            END IF;
            IF (LENGTH(v_event) > 0) THEN
                INSERT INTO tmp_events VALUES (v_min_event_id, v_event);
            END IF;
        END LOOP;
        CLOSE c_stack;
        SELECT SLEEP(in_interval) INTO @sleep;
        SET v_runtime = (UNIX_TIMESTAMP() - v_start);
    END WHILE;
    INSERT INTO tmp_events VALUES (v_min_event_id+1, '}');
    SET @query = CONCAT('SELECT event FROM tmp_events ORDER BY event_id INTO OUTFILE ''', in_outfile, ''' FIELDS ESCAPED BY '''' LINES TERMINATED BY ''''');
    PREPARE stmt_output FROM @query;
    EXECUTE stmt_output;
    DEALLOCATE PREPARE stmt_output;
    SELECT CONCAT('Stack trace written to ', in_outfile) AS 'Info';
    SELECT CONCAT('dot -Tpdf -o /tmp/stack_', in_thread_id, '.pdf ', in_outfile) AS 'Convert to PDF';
    SELECT CONCAT('dot -Tpng -o /tmp/stack_', in_thread_id, '.png ', in_outfile) AS 'Convert to PNG';
    DROP TEMPORARY TABLE tmp_events;
    -- Reset the settings for the performance schema
    IF (in_auto_setup) THEN
        CALL sys.ps_setup_reload_saved();
    END IF;
    -- Restore INSTRUMENTED for this thread
    IF (v_this_thread_enabed = 'YES') THEN
        CALL sys.ps_setup_enable_thread(CONNECTION_ID());
    END IF;
    SET sql_log_bin = @log_bin;
END;

create definer = `mysql.sys`@localhost procedure sys.ps_truncate_all_tables(IN in_verbose tinyint(1)) comment '
Description
-----------

Truncates all summary tables within Performance Schema, 
resetting all aggregated instrumentation as a snapshot.

Parameters
-----------

in_verbose (BOOLEAN):
  Whether to print each TRUNCATE statement before running

Example
-----------

mysql> CALL sys.ps_truncate_all_tables(false);
+---------------------+
| summary             |
+---------------------+
| Truncated 44 tables |
+---------------------+
1 row in set (0.10 sec)

Query OK, 0 rows affected (0.10 sec)
' deterministic security invoker modifies sql data
BEGIN
    DECLARE v_done INT DEFAULT FALSE;
    DECLARE v_total_tables INT DEFAULT 0;
    DECLARE v_ps_table VARCHAR(64);
    DECLARE ps_tables CURSOR FOR
        SELECT table_name 
          FROM INFORMATION_SCHEMA.TABLES 
         WHERE table_schema = 'performance_schema' 
           AND (table_name LIKE '%summary%' 
            OR table_name LIKE '%history%');
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = TRUE;
    OPEN ps_tables;
    ps_tables_loop: LOOP
        FETCH ps_tables INTO v_ps_table;
        IF v_done THEN
          LEAVE ps_tables_loop;
        END IF;
        SET @truncate_stmt := CONCAT('TRUNCATE TABLE performance_schema.', v_ps_table);
        IF in_verbose THEN
            SELECT CONCAT('Running: ', @truncate_stmt) AS status;
        END IF;
        PREPARE truncate_stmt FROM @truncate_stmt;
        EXECUTE truncate_stmt;
        DEALLOCATE PREPARE truncate_stmt;
        SET v_total_tables = v_total_tables + 1;
    END LOOP;
    CLOSE ps_tables;
    SELECT CONCAT('Truncated ', v_total_tables, ' tables') AS summary;
END;

create definer = `mysql.sys`@localhost function sys.quote_identifier(in_identifier text) returns text comment '
Description
-----------

Takes an unquoted identifier (schema name, table name, etc.) and
returns the identifier quoted with backticks.

Parameters
-----------

in_identifier (TEXT):
  The identifier to quote.

Returns
-----------

TEXT CHARSET UTF8MB4

Example
-----------

mysql> SELECT sys.quote_identifier(''my_identifier'') AS Identifier;
+-----------------+
| Identifier      |
+-----------------+
| `my_identifier` |
+-----------------+
1 row in set (0.00 sec)

mysql> SELECT sys.quote_identifier(''my`idenfier'') AS Identifier;
+----------------+
| Identifier     |
+----------------+
| `my``idenfier` |
+----------------+
1 row in set (0.00 sec)
' deterministic security invoker no sql
BEGIN
    RETURN CONCAT('`', REPLACE(in_identifier, '`', '``'), '`');
END;

create definer = `mysql.sys`@localhost procedure sys.statement_performance_analyzer(IN in_action enum('snapshot', 'overall', 'delta', 'create_table', 'create_tmp', 'save', 'cleanup'), IN in_table varchar(129), IN in_views set('with_runtimes_in_95th_percentile', 'analysis', 'with_errors_or_warnings', 'with_full_table_scans', 'with_sorting', 'with_temp_tables', 'custom')) comment '
Description
-----------

Create a report of the statements running on the server.

The views are calculated based on the overall and/or delta activity.

Requires the SUPER privilege for "SET sql_log_bin = 0;".

Parameters
-----------

in_action (ENUM(''snapshot'', ''overall'', ''delta'', ''create_tmp'', ''create_table'', ''save'', ''cleanup'')):
  The action to take. Supported actions are:
    * snapshot      Store a snapshot. The default is to make a snapshot of the current content of
                    performance_schema.events_statements_summary_by_digest, but by setting in_table
                    this can be overwritten to copy the content of the specified table.
                    The snapshot is stored in the sys.tmp_digests temporary table.
    * overall       Generate analyzis based on the content specified by in_table. For the overall analyzis,
                    in_table can be NOW() to use a fresh snapshot. This will overwrite an existing snapshot.
                    Use NULL for in_table to use the existing snapshot. If in_table IS NULL and no snapshot
                    exists, a new will be created.
                    See also in_views and @sys.statement_performance_analyzer.limit.
    * delta         Generate a delta analysis. The delta will be calculated between the reference table in
                    in_table and the snapshot. An existing snapshot must exist.
                    The action uses the sys.tmp_digests_delta temporary table.
                    See also in_views and @sys.statement_performance_analyzer.limit.
    * create_table  Create a regular table suitable for storing the snapshot for later use, e.g. for
                    calculating deltas.
    * create_tmp    Create a temporary table suitable for storing the snapshot for later use, e.g. for
                    calculating deltas.
    * save          Save the snapshot in the table specified by in_table. The table must exists and have
                    the correct structure.
                    If no snapshot exists, a new is created.
    * cleanup       Remove the temporary tables used for the snapshot and delta.

in_table (VARCHAR(129)):
  The table argument used for some actions. Use the format ''db1.t1'' or ''t1'' without using any backticks (`)
  for quoting. Periods (.) are not supported in the database and table names.

  The meaning of the table for each action supporting the argument is:

    * snapshot      The snapshot is created based on the specified table. Set to NULL or NOW() to use
                    the current content of performance_schema.events_statements_summary_by_digest.
    * overall       The table with the content to create the overall analyzis for. The following values
                    can be used:
                      - A table name - use the content of that table.
                      - NOW()        - create a fresh snapshot and overwrite the existing snapshot.
                      - NULL         - use the last stored snapshot.
    * delta         The table name is mandatory and specified the reference view to compare the currently
                    stored snapshot against. If no snapshot exists, a new will be created.
    * create_table  The name of the regular table to create.
    * create_tmp    The name of the temporary table to create.
    * save          The name of the table to save the currently stored snapshot into.

in_views (SET (''with_runtimes_in_95th_percentile'', ''analysis'', ''with_errors_or_warnings'',
               ''with_full_table_scans'', ''with_sorting'', ''with_temp_tables'', ''custom''))
  Which views to include:

    * with_runtimes_in_95th_percentile  Based on the sys.statements_with_runtimes_in_95th_percentile view
    * analysis                          Based on the sys.statement_analysis view
    * with_errors_or_warnings           Based on the sys.statements_with_errors_or_warnings view
    * with_full_table_scans             Based on the sys.statements_with_full_table_scans view
    * with_sorting                      Based on the sys.statements_with_sorting view
    * with_temp_tables                  Based on the sys.statements_with_temp_tables view
    * custom                            Use a custom view. This view must be specified in @sys.statement_performance_analyzer.view to an existing view or a query

Default is to include all except ''custom''.


Configuration Options
----------------------

sys.statement_performance_analyzer.limit
  The maximum number of rows to include for the views that does not have a built-in limit (e.g. the 95th percentile view).
  If not set the limit is 100.

sys.statement_performance_analyzer.view
  Used together with the ''custom'' view. If the value contains a space, it is considered a query, otherwise it must be
  an existing view querying the performance_schema.events_statements_summary_by_digest table. There cannot be any limit
  clause including in the query or view definition if @sys.statement_performance_analyzer.limit > 0.
  If specifying a view, use the same format as for in_table.

sys.debug
  Whether to provide debugging output.
  Default is ''OFF''. Set to ''ON'' to include.


Example
--------

To create a report with the queries in the 95th percentile since last truncate of performance_schema.events_statements_summary_by_digest
and the delta for a 1 minute period:

   1. Create a temporary table to store the initial snapshot.
   2. Create the initial snapshot.
   3. Save the initial snapshot in the temporary table.
   4. Wait one minute.
   5. Create a new snapshot.
   6. Perform analyzis based on the new snapshot.
   7. Perform analyzis based on the delta between the initial and new snapshots.

mysql> CALL sys.statement_performance_analyzer(''create_tmp'', ''mydb.tmp_digests_ini'', NULL);
Query OK, 0 rows affected (0.08 sec)

mysql> CALL sys.statement_performance_analyzer(''snapshot'', NULL, NULL);
Query OK, 0 rows affected (0.02 sec)

mysql> CALL sys.statement_performance_analyzer(''save'', ''mydb.tmp_digests_ini'', NULL);
Query OK, 0 rows affected (0.00 sec)

mysql> DO SLEEP(60);
Query OK, 0 rows affected (1 min 0.00 sec)

mysql> CALL sys.statement_performance_analyzer(''snapshot'', NULL, NULL);
Query OK, 0 rows affected (0.02 sec)

mysql> CALL sys.statement_performance_analyzer(''overall'', NULL, ''with_runtimes_in_95th_percentile'');
+-----------------------------------------+
| Next Output                             |
+-----------------------------------------+
| Queries with Runtime in 95th Percentile |
+-----------------------------------------+
1 row in set (0.05 sec)

...

mysql> CALL sys.statement_performance_analyzer(''delta'', ''mydb.tmp_digests_ini'', ''with_runtimes_in_95th_percentile'');
+-----------------------------------------+
| Next Output                             |
+-----------------------------------------+
| Queries with Runtime in 95th Percentile |
+-----------------------------------------+
1 row in set (0.03 sec)

...


To create an overall report of the 95th percentile queries and the top 10 queries with full table scans:

mysql> CALL sys.statement_performance_analyzer(''snapshot'', NULL, NULL);
Query OK, 0 rows affected (0.01 sec)

mysql> SET @sys.statement_performance_analyzer.limit = 10;
Query OK, 0 rows affected (0.00 sec)

mysql> CALL sys.statement_performance_analyzer(''overall'', NULL, ''with_runtimes_in_95th_percentile,with_full_table_scans'');
+-----------------------------------------+
| Next Output                             |
+-----------------------------------------+
| Queries with Runtime in 95th Percentile |
+-----------------------------------------+
1 row in set (0.01 sec)

...

+-------------------------------------+
| Next Output                         |
+-------------------------------------+
| Top 10 Queries with Full Table Scan |
+-------------------------------------+
1 row in set (0.09 sec)

...


Use a custom view showing the top 10 query sorted by total execution time refreshing the view every minute using
the watch command in Linux.

mysql> CREATE OR REPLACE VIEW mydb.my_statements AS
    -> SELECT sys.format_statement(DIGEST_TEXT) AS query,
    ->        SCHEMA_NAME AS db,
    ->        COUNT_STAR AS exec_count,
    ->        format_pico_time(SUM_TIMER_WAIT) AS total_latency,
    ->        format_pico_time(AVG_TIMER_WAIT) AS avg_latency,
    ->        ROUND(IFNULL(SUM_ROWS_SENT / NULLIF(COUNT_STAR, 0), 0)) AS rows_sent_avg,
    ->        ROUND(IFNULL(SUM_ROWS_EXAMINED / NULLIF(COUNT_STAR, 0), 0)) AS rows_examined_avg,
    ->        ROUND(IFNULL(SUM_ROWS_AFFECTED / NULLIF(COUNT_STAR, 0), 0)) AS rows_affected_avg,
    ->        DIGEST AS digest
    ->   FROM performance_schema.events_statements_summary_by_digest
    -> ORDER BY SUM_TIMER_WAIT DESC;
Query OK, 0 rows affected (0.01 sec)

mysql> CALL sys.statement_performance_analyzer(''create_table'', ''mydb.digests_prev'', NULL);
Query OK, 0 rows affected (0.10 sec)

shell$ watch -n 60 "mysql sys --table -e "
> SET @sys.statement_performance_analyzer.view = ''mydb.my_statements'';
> SET @sys.statement_performance_analyzer.limit = 10;
> CALL statement_performance_analyzer(''snapshot'', NULL, NULL);
> CALL statement_performance_analyzer(''delta'', ''mydb.digests_prev'', ''custom'');
> CALL statement_performance_analyzer(''save'', ''mydb.digests_prev'', NULL);
> ""

Every 60.0s: mysql sys --table -e "                                                                                                   ...  Mon Dec 22 10:58:51 2014

+----------------------------------+
| Next Output                      |
+----------------------------------+
| Top 10 Queries Using Custom View |
+----------------------------------+
+-------------------+-------+------------+---------------+-------------+---------------+-------------------+-------------------+----------------------------------+
| query             | db    | exec_count | total_latency | avg_latency | rows_sent_avg | rows_examined_avg | rows_affected_avg | digest                           |
+-------------------+-------+------------+---------------+-------------+---------------+-------------------+-------------------+----------------------------------+
...
' security invoker
BEGIN
    DECLARE v_table_exists, v_tmp_digests_table_exists, v_custom_view_exists ENUM('', 'BASE TABLE', 'VIEW', 'TEMPORARY') DEFAULT '';
    DECLARE v_this_thread_enabled ENUM('YES', 'NO');
    DECLARE v_force_new_snapshot BOOLEAN DEFAULT FALSE;
    DECLARE v_digests_table VARCHAR(133);
    DECLARE v_quoted_table, v_quoted_custom_view VARCHAR(133) DEFAULT '';
    DECLARE v_table_db, v_table_name, v_custom_db, v_custom_name VARCHAR(64);
    DECLARE v_digest_table_template, v_checksum_ref, v_checksum_table text;
    DECLARE v_sql longtext;
    -- Maximum supported length for MESSAGE_TEXT with the SIGNAL command is 128 chars.
    DECLARE v_error_msg VARCHAR(128);
    DECLARE v_old_group_concat_max_len INT UNSIGNED DEFAULT 0;
    -- Don't instrument this thread
    SELECT INSTRUMENTED INTO v_this_thread_enabled FROM performance_schema.threads WHERE PROCESSLIST_ID = CONNECTION_ID();
    IF (v_this_thread_enabled = 'YES') THEN
        CALL sys.ps_setup_disable_thread(CONNECTION_ID());
    END IF;
    -- Temporary table are used - disable sql_log_bin if necessary to prevent them replicating
    SET @log_bin := @@sql_log_bin;
    IF ((@log_bin = 1) AND (@@binlog_format = 'STATEMENT')) THEN
        SET sql_log_bin = 0;
    END IF;
    -- Set configuration options
    IF (@sys.statement_performance_analyzer.limit IS NULL) THEN
        SET @sys.statement_performance_analyzer.limit = sys.sys_get_config('statement_performance_analyzer.limit', '100');
    END IF;
    IF (@sys.debug IS NULL) THEN
        SET @sys.debug                                = sys.sys_get_config('debug'                               , 'OFF');
    END IF;
    -- If in_table is set, break in_table into a db and table component and check whether it exists
    -- in_table = NOW() is considered like it's not set.
    IF (in_table = 'NOW()') THEN
        SET v_force_new_snapshot = TRUE,
            in_table             = NULL;
    ELSEIF (in_table IS NOT NULL) THEN
        IF (NOT INSTR(in_table, '.')) THEN
            -- No . in the table name - use current database
            -- DATABASE() will be the database of the procedure
            SET v_table_db   = DATABASE(),
                v_table_name = in_table;
        ELSE
            SET v_table_db   = SUBSTRING_INDEX(in_table, '.', 1);
            SET v_table_name = SUBSTRING(in_table, CHAR_LENGTH(v_table_db)+2);
        END IF;
        SET v_quoted_table = CONCAT('`', v_table_db, '`.`', v_table_name, '`');
        IF (@sys.debug = 'ON') THEN
            SELECT CONCAT('in_table is: db = ''', v_table_db, ''', table = ''', v_table_name, '''') AS 'Debug';
        END IF;
        IF (v_table_db = DATABASE() AND (v_table_name = 'tmp_digests' OR v_table_name = 'tmp_digests_delta')) THEN
            SET v_error_msg = CONCAT('Invalid value for in_table: ', v_quoted_table, ' is reserved table name.');
            SIGNAL SQLSTATE '45000'
               SET MESSAGE_TEXT = v_error_msg;
        END IF;
        CALL sys.table_exists(v_table_db, v_table_name, v_table_exists);
        IF (@sys.debug = 'ON') THEN
            SELECT CONCAT('v_table_exists = ', v_table_exists) AS 'Debug';
        END IF;
        IF (v_table_exists = 'BASE TABLE') THEN
            SET v_old_group_concat_max_len = @@session.group_concat_max_len;
            SET @@session.group_concat_max_len = 2048;
            -- Verify that the table has the correct table definition
            -- This can only be done for base tables as temporary aren't in information_schema.COLUMNS.
            -- This also minimises the risk of using a production table.
            SET v_checksum_ref = (
                 SELECT GROUP_CONCAT(CONCAT(COLUMN_NAME, COLUMN_TYPE) ORDER BY ORDINAL_POSITION) AS Checksum
                   FROM information_schema.COLUMNS
                  WHERE TABLE_SCHEMA = 'performance_schema' AND TABLE_NAME = 'events_statements_summary_by_digest'
                ),
                v_checksum_table = (
                 SELECT GROUP_CONCAT(CONCAT(COLUMN_NAME, COLUMN_TYPE) ORDER BY ORDINAL_POSITION) AS Checksum
                   FROM information_schema.COLUMNS
                  WHERE TABLE_SCHEMA = v_table_db AND TABLE_NAME = v_table_name
                );
            SET @@session.group_concat_max_len = v_old_group_concat_max_len;
            IF (v_checksum_ref <> v_checksum_table) THEN
                -- The table does not have the correct definition, so abandon
                SET v_error_msg = CONCAT('The table ',
                                         IF(CHAR_LENGTH(v_quoted_table) > 93, CONCAT('...', SUBSTRING(v_quoted_table, -90)), v_quoted_table),
                                         ' has the wrong definition.');
                SIGNAL SQLSTATE '45000'
                   SET MESSAGE_TEXT = v_error_msg;
            END IF;
        END IF;
    END IF;
    IF (in_views IS NULL OR in_views = '') THEN
        -- Set to default
        SET in_views = 'with_runtimes_in_95th_percentile,analysis,with_errors_or_warnings,with_full_table_scans,with_sorting,with_temp_tables';
    END IF;
    -- Validate settings
    CALL sys.table_exists(DATABASE(), 'tmp_digests', v_tmp_digests_table_exists);
    IF (@sys.debug = 'ON') THEN
        SELECT CONCAT('v_tmp_digests_table_exists = ', v_tmp_digests_table_exists) AS 'Debug';
    END IF;
    CASE
        WHEN in_action IN ('snapshot', 'overall') THEN
            -- in_table must be NULL, NOW(), or an existing table
            IF (in_table IS NOT NULL) THEN
                IF (NOT v_table_exists IN ('TEMPORARY', 'BASE TABLE')) THEN
                    SET v_error_msg = CONCAT('The ', in_action, ' action requires in_table to be NULL, NOW() or specify an existing table.',
                                             ' The table ',
                                             IF(CHAR_LENGTH(v_quoted_table) > 16, CONCAT('...', SUBSTRING(v_quoted_table, -13)), v_quoted_table),
                                             ' does not exist.');
                    SIGNAL SQLSTATE '45000'
                       SET MESSAGE_TEXT = v_error_msg;
                END IF;
            END IF;
        WHEN in_action IN ('delta', 'save') THEN
            -- in_table must be an existing table
            IF (v_table_exists NOT IN ('TEMPORARY', 'BASE TABLE')) THEN
                SET v_error_msg = CONCAT('The ', in_action, ' action requires in_table to be an existing table.',
                                         IF(in_table IS NOT NULL, CONCAT(' The table ',
                                             IF(CHAR_LENGTH(v_quoted_table) > 39, CONCAT('...', SUBSTRING(v_quoted_table, -36)), v_quoted_table),
                                             ' does not exist.'), ''));
                SIGNAL SQLSTATE '45000'
                   SET MESSAGE_TEXT = v_error_msg;
            END IF;
            IF (in_action = 'delta' AND v_tmp_digests_table_exists <> 'TEMPORARY') THEN
                SIGNAL SQLSTATE '45000'
                   SET MESSAGE_TEXT = 'An existing snapshot generated with the statement_performance_analyzer() must exist.';
            END IF;
        WHEN in_action = 'create_tmp' THEN
            -- in_table must not exists as a temporary table
            IF (v_table_exists = 'TEMPORARY') THEN
                SET v_error_msg = CONCAT('Cannot create the table ',
                                         IF(CHAR_LENGTH(v_quoted_table) > 72, CONCAT('...', SUBSTRING(v_quoted_table, -69)), v_quoted_table),
                                         ' as it already exists.');
                SIGNAL SQLSTATE '45000'
                   SET MESSAGE_TEXT = v_error_msg;
            END IF;
        WHEN in_action = 'create_table' THEN
            -- in_table must not exists at all
            IF (v_table_exists <> '') THEN
                SET v_error_msg = CONCAT('Cannot create the table ',
                                         IF(CHAR_LENGTH(v_quoted_table) > 52, CONCAT('...', SUBSTRING(v_quoted_table, -49)), v_quoted_table),
                                         ' as it already exists',
                                         IF(v_table_exists = 'TEMPORARY', ' as a temporary table.', '.'));
                SIGNAL SQLSTATE '45000'
                   SET MESSAGE_TEXT = v_error_msg;
            END IF;
        WHEN in_action = 'cleanup' THEN
            -- doesn't use any of the arguments
            DO (SELECT 1);
        ELSE
            SIGNAL SQLSTATE '45000'
               SET MESSAGE_TEXT = 'Unknown action. Supported actions are: cleanup, create_table, create_tmp, delta, overall, save, snapshot';
    END CASE;
    SET v_digest_table_template = 'CREATE %{TEMPORARY}TABLE %{TABLE_NAME} (
  `SCHEMA_NAME` varchar(64) DEFAULT NULL,
  `DIGEST` varchar(64) DEFAULT NULL,
  `DIGEST_TEXT` longtext,
  `COUNT_STAR` bigint unsigned NOT NULL,
  `SUM_TIMER_WAIT` bigint unsigned NOT NULL,
  `MIN_TIMER_WAIT` bigint unsigned NOT NULL,
  `AVG_TIMER_WAIT` bigint unsigned NOT NULL,
  `MAX_TIMER_WAIT` bigint unsigned NOT NULL,
  `SUM_LOCK_TIME` bigint unsigned NOT NULL,
  `SUM_ERRORS` bigint unsigned NOT NULL,
  `SUM_WARNINGS` bigint unsigned NOT NULL,
  `SUM_ROWS_AFFECTED` bigint unsigned NOT NULL,
  `SUM_ROWS_SENT` bigint unsigned NOT NULL,
  `SUM_ROWS_EXAMINED` bigint unsigned NOT NULL,
  `SUM_CREATED_TMP_DISK_TABLES` bigint unsigned NOT NULL,
  `SUM_CREATED_TMP_TABLES` bigint unsigned NOT NULL,
  `SUM_SELECT_FULL_JOIN` bigint unsigned NOT NULL,
  `SUM_SELECT_FULL_RANGE_JOIN` bigint unsigned NOT NULL,
  `SUM_SELECT_RANGE` bigint unsigned NOT NULL,
  `SUM_SELECT_RANGE_CHECK` bigint unsigned NOT NULL,
  `SUM_SELECT_SCAN` bigint unsigned NOT NULL,
  `SUM_SORT_MERGE_PASSES` bigint unsigned NOT NULL,
  `SUM_SORT_RANGE` bigint unsigned NOT NULL,
  `SUM_SORT_ROWS` bigint unsigned NOT NULL,
  `SUM_SORT_SCAN` bigint unsigned NOT NULL,
  `SUM_NO_INDEX_USED` bigint unsigned NOT NULL,
  `SUM_NO_GOOD_INDEX_USED` bigint unsigned NOT NULL,
  `SUM_CPU_TIME` bigint unsigned NOT NULL,
  `MAX_CONTROLLED_MEMORY` bigint unsigned NOT NULL,
  `MAX_TOTAL_MEMORY` bigint unsigned NOT NULL,
  `COUNT_SECONDARY` bigint unsigned NOT NULL,
  `FIRST_SEEN` timestamp(6) NULL DEFAULT NULL,
  `LAST_SEEN` timestamp(6) NULL DEFAULT NULL,
  `QUANTILE_95` bigint unsigned NOT NULL,
  `QUANTILE_99` bigint unsigned NOT NULL,
  `QUANTILE_999` bigint unsigned NOT NULL,
  `QUERY_SAMPLE_TEXT` longtext,
  `QUERY_SAMPLE_SEEN` timestamp(6) NULL DEFAULT NULL,
  `QUERY_SAMPLE_TIMER_WAIT` bigint unsigned NOT NULL,
  INDEX (SCHEMA_NAME, DIGEST)
) DEFAULT CHARSET=utf8mb4';
    -- Do the action
    -- The actions snapshot, ... requires a fresh snapshot - create it now
    IF (v_force_new_snapshot
           OR in_action = 'snapshot'
           OR (in_action = 'overall' AND in_table IS NULL)
           OR (in_action = 'save' AND v_tmp_digests_table_exists <> 'TEMPORARY')
       ) THEN
        IF (v_tmp_digests_table_exists = 'TEMPORARY') THEN
            IF (@sys.debug = 'ON') THEN
                SELECT 'DROP TEMPORARY TABLE IF EXISTS tmp_digests' AS 'Debug';
            END IF;
            DROP TEMPORARY TABLE IF EXISTS tmp_digests;
        END IF;
        CALL sys.execute_prepared_stmt(REPLACE(REPLACE(v_digest_table_template, '%{TEMPORARY}', 'TEMPORARY '), '%{TABLE_NAME}', 'tmp_digests'));
        SET v_sql = CONCAT('INSERT INTO tmp_digests SELECT * FROM ',
                           IF(in_table IS NULL OR in_action = 'save', 'performance_schema.events_statements_summary_by_digest', v_quoted_table));
        CALL sys.execute_prepared_stmt(v_sql);
    END IF;
    -- Go through the remaining actions
    IF (in_action IN ('create_table', 'create_tmp')) THEN
        IF (in_action = 'create_table') THEN
            CALL sys.execute_prepared_stmt(REPLACE(REPLACE(v_digest_table_template, '%{TEMPORARY}', ''), '%{TABLE_NAME}', v_quoted_table));
        ELSE
            CALL sys.execute_prepared_stmt(REPLACE(REPLACE(v_digest_table_template, '%{TEMPORARY}', 'TEMPORARY '), '%{TABLE_NAME}', v_quoted_table));
        END IF;
    ELSEIF (in_action = 'save') THEN
        CALL sys.execute_prepared_stmt(CONCAT('DELETE FROM ', v_quoted_table));
        CALL sys.execute_prepared_stmt(CONCAT('INSERT INTO ', v_quoted_table, ' SELECT * FROM tmp_digests'));
    ELSEIF (in_action = 'cleanup') THEN
        DROP TEMPORARY TABLE IF EXISTS sys.tmp_digests;
        DROP TEMPORARY TABLE IF EXISTS sys.tmp_digests_delta;
    ELSEIF (in_action IN ('overall', 'delta')) THEN
        -- These are almost the same - for delta calculate the delta in tmp_digests_delta and use that instead of tmp_digests.
        -- And overall allows overriding the table to use.
        IF (in_action = 'overall') THEN
            IF (in_table IS NULL) THEN
                SET v_digests_table = 'tmp_digests';
            ELSE
                SET v_digests_table = v_quoted_table;
            END IF;
        ELSE
            SET v_digests_table = 'tmp_digests_delta';
            DROP TEMPORARY TABLE IF EXISTS tmp_digests_delta;
            CREATE TEMPORARY TABLE tmp_digests_delta LIKE tmp_digests;
            SET v_sql = CONCAT('INSERT INTO tmp_digests_delta
SELECT `d_end`.`SCHEMA_NAME`,
       `d_end`.`DIGEST`,
       `d_end`.`DIGEST_TEXT`,
       `d_end`.`COUNT_STAR`-IFNULL(`d_start`.`COUNT_STAR`, 0) AS ''COUNT_STAR'',
       `d_end`.`SUM_TIMER_WAIT`-IFNULL(`d_start`.`SUM_TIMER_WAIT`, 0) AS ''SUM_TIMER_WAIT'',
       `d_end`.`MIN_TIMER_WAIT` AS ''MIN_TIMER_WAIT'',
       IFNULL((`d_end`.`SUM_TIMER_WAIT`-IFNULL(`d_start`.`SUM_TIMER_WAIT`, 0))/NULLIF(`d_end`.`COUNT_STAR`-IFNULL(`d_start`.`COUNT_STAR`, 0), 0), 0) AS ''AVG_TIMER_WAIT'',
       `d_end`.`MAX_TIMER_WAIT` AS ''MAX_TIMER_WAIT'',
       `d_end`.`SUM_LOCK_TIME`-IFNULL(`d_start`.`SUM_LOCK_TIME`, 0) AS ''SUM_LOCK_TIME'',
       `d_end`.`SUM_ERRORS`-IFNULL(`d_start`.`SUM_ERRORS`, 0) AS ''SUM_ERRORS'',
       `d_end`.`SUM_WARNINGS`-IFNULL(`d_start`.`SUM_WARNINGS`, 0) AS ''SUM_WARNINGS'',
       `d_end`.`SUM_ROWS_AFFECTED`-IFNULL(`d_start`.`SUM_ROWS_AFFECTED`, 0) AS ''SUM_ROWS_AFFECTED'',
       `d_end`.`SUM_ROWS_SENT`-IFNULL(`d_start`.`SUM_ROWS_SENT`, 0) AS ''SUM_ROWS_SENT'',
       `d_end`.`SUM_ROWS_EXAMINED`-IFNULL(`d_start`.`SUM_ROWS_EXAMINED`, 0) AS ''SUM_ROWS_EXAMINED'',
       `d_end`.`SUM_CREATED_TMP_DISK_TABLES`-IFNULL(`d_start`.`SUM_CREATED_TMP_DISK_TABLES`, 0) AS ''SUM_CREATED_TMP_DISK_TABLES'',
       `d_end`.`SUM_CREATED_TMP_TABLES`-IFNULL(`d_start`.`SUM_CREATED_TMP_TABLES`, 0) AS ''SUM_CREATED_TMP_TABLES'',
       `d_end`.`SUM_SELECT_FULL_JOIN`-IFNULL(`d_start`.`SUM_SELECT_FULL_JOIN`, 0) AS ''SUM_SELECT_FULL_JOIN'',
       `d_end`.`SUM_SELECT_FULL_RANGE_JOIN`-IFNULL(`d_start`.`SUM_SELECT_FULL_RANGE_JOIN`, 0) AS ''SUM_SELECT_FULL_RANGE_JOIN'',
       `d_end`.`SUM_SELECT_RANGE`-IFNULL(`d_start`.`SUM_SELECT_RANGE`, 0) AS ''SUM_SELECT_RANGE'',
       `d_end`.`SUM_SELECT_RANGE_CHECK`-IFNULL(`d_start`.`SUM_SELECT_RANGE_CHECK`, 0) AS ''SUM_SELECT_RANGE_CHECK'',
       `d_end`.`SUM_SELECT_SCAN`-IFNULL(`d_start`.`SUM_SELECT_SCAN`, 0) AS ''SUM_SELECT_SCAN'',
       `d_end`.`SUM_SORT_MERGE_PASSES`-IFNULL(`d_start`.`SUM_SORT_MERGE_PASSES`, 0) AS ''SUM_SORT_MERGE_PASSES'',
       `d_end`.`SUM_SORT_RANGE`-IFNULL(`d_start`.`SUM_SORT_RANGE`, 0) AS ''SUM_SORT_RANGE'',
       `d_end`.`SUM_SORT_ROWS`-IFNULL(`d_start`.`SUM_SORT_ROWS`, 0) AS ''SUM_SORT_ROWS'',
       `d_end`.`SUM_SORT_SCAN`-IFNULL(`d_start`.`SUM_SORT_SCAN`, 0) AS ''SUM_SORT_SCAN'',
       `d_end`.`SUM_NO_INDEX_USED`-IFNULL(`d_start`.`SUM_NO_INDEX_USED`, 0) AS ''SUM_NO_INDEX_USED'',
       `d_end`.`SUM_NO_GOOD_INDEX_USED`-IFNULL(`d_start`.`SUM_NO_GOOD_INDEX_USED`, 0) AS ''SUM_NO_GOOD_INDEX_USED'',
       `d_end`.`SUM_CPU_TIME`-IFNULL(`d_start`.`SUM_CPU_TIME`, 0) AS ''SUM_CPU_TIME'',
       `d_end`.`MAX_CONTROLLED_MEMORY` AS ''MAX_CONTROLLED_MEMORY'',
       `d_end`.`MAX_TOTAL_MEMORY` AS ''MAX_TOTAL_MEMORY'',
       `d_end`.`COUNT_SECONDARY`-IFNULL(`d_start`.`COUNT_SECONDARY`, 0) AS ''COUNT_SECONDARY'',
       `d_end`.`FIRST_SEEN`,
       `d_end`.`LAST_SEEN`,
       `d_end`.`QUANTILE_95`,
       `d_end`.`QUANTILE_99`,
       `d_end`.`QUANTILE_999`,
       `d_end`.`QUERY_SAMPLE_TEXT`,
       `d_end`.`QUERY_SAMPLE_SEEN`,
       `d_end`.`QUERY_SAMPLE_TIMER_WAIT`
  FROM tmp_digests d_end
       LEFT OUTER JOIN ', v_quoted_table, ' d_start ON `d_start`.`DIGEST` = `d_end`.`DIGEST`
                                                    AND (`d_start`.`SCHEMA_NAME` = `d_end`.`SCHEMA_NAME`
                                                          OR (`d_start`.`SCHEMA_NAME` IS NULL AND `d_end`.`SCHEMA_NAME` IS NULL)
                                                        )
 WHERE `d_end`.`COUNT_STAR`-IFNULL(`d_start`.`COUNT_STAR`, 0) > 0');
            CALL sys.execute_prepared_stmt(v_sql);
        END IF;
        IF (FIND_IN_SET('with_runtimes_in_95th_percentile', in_views)) THEN
            SELECT 'Queries with Runtime in 95th Percentile' AS 'Next Output';
            DROP TEMPORARY TABLE IF EXISTS tmp_digest_avg_latency_distribution1;
            DROP TEMPORARY TABLE IF EXISTS tmp_digest_avg_latency_distribution2;
            DROP TEMPORARY TABLE IF EXISTS tmp_digest_95th_percentile_by_avg_us;
            CREATE TEMPORARY TABLE tmp_digest_avg_latency_distribution1 (
              cnt bigint unsigned NOT NULL,
              avg_us decimal(21,0) NOT NULL,
              PRIMARY KEY (avg_us)
            ) ENGINE=InnoDB;
            SET v_sql = CONCAT('INSERT INTO tmp_digest_avg_latency_distribution1
SELECT COUNT(*) cnt,
       ROUND(avg_timer_wait/1000000) AS avg_us
  FROM ', v_digests_table, '
 GROUP BY avg_us');
            CALL sys.execute_prepared_stmt(v_sql);
            CREATE TEMPORARY TABLE tmp_digest_avg_latency_distribution2 LIKE tmp_digest_avg_latency_distribution1;
            INSERT INTO tmp_digest_avg_latency_distribution2 SELECT * FROM tmp_digest_avg_latency_distribution1;
            CREATE TEMPORARY TABLE tmp_digest_95th_percentile_by_avg_us (
              avg_us decimal(21,0) NOT NULL,
              percentile decimal(46,4) NOT NULL,
              PRIMARY KEY (avg_us)
            ) ENGINE=InnoDB;
            SET v_sql = CONCAT('INSERT INTO tmp_digest_95th_percentile_by_avg_us
SELECT s2.avg_us avg_us,
       IFNULL(SUM(s1.cnt)/NULLIF((SELECT COUNT(*) FROM ', v_digests_table, '), 0), 0) percentile
  FROM tmp_digest_avg_latency_distribution1 AS s1
       JOIN tmp_digest_avg_latency_distribution2 AS s2 ON s1.avg_us <= s2.avg_us
 GROUP BY s2.avg_us
HAVING percentile > 0.95
 ORDER BY percentile
 LIMIT 1');
            CALL sys.execute_prepared_stmt(v_sql);
            SET v_sql =
                REPLACE(
                    REPLACE(
                        (SELECT VIEW_DEFINITION
                           FROM information_schema.VIEWS
                          WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'statements_with_runtimes_in_95th_percentile'
                        ),
                        '`performance_schema`.`events_statements_summary_by_digest`',
                        v_digests_table
                    ),
                    'sys.x$ps_digest_95th_percentile_by_avg_us',
                    '`sys`.`x$ps_digest_95th_percentile_by_avg_us`'
              );
            CALL sys.execute_prepared_stmt(v_sql);
            DROP TEMPORARY TABLE tmp_digest_avg_latency_distribution1;
            DROP TEMPORARY TABLE tmp_digest_avg_latency_distribution2;
            DROP TEMPORARY TABLE tmp_digest_95th_percentile_by_avg_us;
        END IF;
        IF (FIND_IN_SET('analysis', in_views)) THEN
            SELECT CONCAT('Top ', @sys.statement_performance_analyzer.limit, ' Queries Ordered by Total Latency') AS 'Next Output';
            SET v_sql =
                REPLACE(
                    (SELECT VIEW_DEFINITION
                       FROM information_schema.VIEWS
                      WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'statement_analysis'
                    ),
                    '`performance_schema`.`events_statements_summary_by_digest`',
                    v_digests_table
                );
            IF (@sys.statement_performance_analyzer.limit > 0) THEN
                SET v_sql = CONCAT(v_sql, ' LIMIT ', @sys.statement_performance_analyzer.limit);
            END IF;
            CALL sys.execute_prepared_stmt(v_sql);
        END IF;
        IF (FIND_IN_SET('with_errors_or_warnings', in_views)) THEN
            SELECT CONCAT('Top ', @sys.statement_performance_analyzer.limit, ' Queries with Errors') AS 'Next Output';
            SET v_sql =
                REPLACE(
                    (SELECT VIEW_DEFINITION
                       FROM information_schema.VIEWS
                      WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'statements_with_errors_or_warnings'
                    ),
                    '`performance_schema`.`events_statements_summary_by_digest`',
                    v_digests_table
                );
            IF (@sys.statement_performance_analyzer.limit > 0) THEN
                SET v_sql = CONCAT(v_sql, ' LIMIT ', @sys.statement_performance_analyzer.limit);
            END IF;
            CALL sys.execute_prepared_stmt(v_sql);
        END IF;
        IF (FIND_IN_SET('with_full_table_scans', in_views)) THEN
            SELECT CONCAT('Top ', @sys.statement_performance_analyzer.limit, ' Queries with Full Table Scan') AS 'Next Output';
            SET v_sql =
                REPLACE(
                    (SELECT VIEW_DEFINITION
                       FROM information_schema.VIEWS
                      WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'statements_with_full_table_scans'
                    ),
                    '`performance_schema`.`events_statements_summary_by_digest`',
                    v_digests_table
                );
            IF (@sys.statement_performance_analyzer.limit > 0) THEN
                SET v_sql = CONCAT(v_sql, ' LIMIT ', @sys.statement_performance_analyzer.limit);
            END IF;
            CALL sys.execute_prepared_stmt(v_sql);
        END IF;
        IF (FIND_IN_SET('with_sorting', in_views)) THEN
            SELECT CONCAT('Top ', @sys.statement_performance_analyzer.limit, ' Queries with Sorting') AS 'Next Output';
            SET v_sql =
                REPLACE(
                    (SELECT VIEW_DEFINITION
                       FROM information_schema.VIEWS
                      WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'statements_with_sorting'
                    ),
                    '`performance_schema`.`events_statements_summary_by_digest`',
                    v_digests_table
                );
            IF (@sys.statement_performance_analyzer.limit > 0) THEN
                SET v_sql = CONCAT(v_sql, ' LIMIT ', @sys.statement_performance_analyzer.limit);
            END IF;
            CALL sys.execute_prepared_stmt(v_sql);
        END IF;
        IF (FIND_IN_SET('with_temp_tables', in_views)) THEN
            SELECT CONCAT('Top ', @sys.statement_performance_analyzer.limit, ' Queries with Internal Temporary Tables') AS 'Next Output';
            SET v_sql =
                REPLACE(
                    (SELECT VIEW_DEFINITION
                       FROM information_schema.VIEWS
                      WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'statements_with_temp_tables'
                    ),
                    '`performance_schema`.`events_statements_summary_by_digest`',
                    v_digests_table
                );
            IF (@sys.statement_performance_analyzer.limit > 0) THEN
                SET v_sql = CONCAT(v_sql, ' LIMIT ', @sys.statement_performance_analyzer.limit);
            END IF;
            CALL sys.execute_prepared_stmt(v_sql);
        END IF;
        IF (FIND_IN_SET('custom', in_views)) THEN
            SELECT CONCAT('Top ', @sys.statement_performance_analyzer.limit, ' Queries Using Custom View') AS 'Next Output';
            IF (@sys.statement_performance_analyzer.view IS NULL) THEN
                SET @sys.statement_performance_analyzer.view = sys.sys_get_config('statement_performance_analyzer.view', NULL);
            END IF;
            IF (@sys.statement_performance_analyzer.view IS NULL) THEN
                SIGNAL SQLSTATE '45000'
                   SET MESSAGE_TEXT = 'The @sys.statement_performance_analyzer.view user variable must be set with the view or query to use.';
            END IF;
            IF (NOT INSTR(@sys.statement_performance_analyzer.view, ' ')) THEN
                -- No spaces, so can't be a query
                IF (NOT INSTR(@sys.statement_performance_analyzer.view, '.')) THEN
                    -- No . in the table name - use current database
                    -- DATABASE() will be the database of the procedure
                    SET v_custom_db   = DATABASE(),
                        v_custom_name = @sys.statement_performance_analyzer.view;
                ELSE
                    SET v_custom_db   = SUBSTRING_INDEX(@sys.statement_performance_analyzer.view, '.', 1);
                    SET v_custom_name = SUBSTRING(@sys.statement_performance_analyzer.view, CHAR_LENGTH(v_custom_db)+2);
                END IF;
                CALL sys.table_exists(v_custom_db, v_custom_name, v_custom_view_exists);
                IF (v_custom_view_exists <> 'VIEW') THEN
                    SIGNAL SQLSTATE '45000'
                       SET MESSAGE_TEXT = 'The @sys.statement_performance_analyzer.view user variable is set but specified neither an existing view nor a query.';
                END IF;
                SET v_sql =
                    REPLACE(
                        (SELECT VIEW_DEFINITION
                           FROM information_schema.VIEWS
                          WHERE TABLE_SCHEMA = v_custom_db AND TABLE_NAME = v_custom_name
                        ),
                        '`performance_schema`.`events_statements_summary_by_digest`',
                        v_digests_table
                    );
            ELSE
                SET v_sql = REPLACE(@sys.statement_performance_analyzer.view, '`performance_schema`.`events_statements_summary_by_digest`', v_digests_table);
            END IF;
            IF (@sys.statement_performance_analyzer.limit > 0) THEN
                SET v_sql = CONCAT(v_sql, ' LIMIT ', @sys.statement_performance_analyzer.limit);
            END IF;
            CALL sys.execute_prepared_stmt(v_sql);
        END IF;
    END IF;
    -- Restore INSTRUMENTED for this thread
    IF (v_this_thread_enabled = 'YES') THEN
        CALL sys.ps_setup_enable_thread(CONNECTION_ID());
    END IF;
    IF ((@log_bin = 1) AND (@@binlog_format = 'STATEMENT')) THEN
        SET sql_log_bin = @log_bin;
    END IF;
END;

create definer = `mysql.sys`@localhost function sys.sys_get_config(in_variable_name varchar(128), in_default_value varchar(128)) returns varchar(128) comment '
Description
-----------

Returns the value for the requested variable using the following logic:

   1. If the option exists in sys.sys_config return the value from there.
   2. Else fall back on the provided default value.

Notes for using sys_get_config():

   * If the default value argument to sys_get_config() is NULL and case 2. is reached, NULL is returned.
     It is then expected that the caller is able to handle NULL for the given configuration option.
   * The convention is to name the user variables @sys.<name of variable>. It is <name of variable> that
     is stored in the sys_config table and is what is expected as the argument to sys_get_config().
   * If you want to check whether the configuration option has already been set and if not assign with
     the return value of sys_get_config() you can use IFNULL(...) (see example below). However this should
     not be done inside a loop (e.g. for each row in a result set) as for repeated calls where assignment
     is only needed in the first iteration using IFNULL(...) is expected to be significantly slower than
     using an IF (...) THEN ... END IF; block (see example below).

Parameters
-----------

in_variable_name (VARCHAR(128)):
  The name of the config option to return the value for.

in_default_value (VARCHAR(128)):
  The default value to return if the variable does not exist in sys.sys_config.

Returns
-----------

VARCHAR(128)

Example
-----------

-- Get the configuration value from sys.sys_config falling back on 128 if the option is not present in the table.
mysql> SELECT sys.sys_get_config(''statement_truncate_len'', 128) AS Value;
+-------+
| Value |
+-------+
| 64    |
+-------+
1 row in set (0.00 sec)

-- Check whether the option is already set, if not assign - IFNULL(...) one liner example.
mysql> SET @sys.statement_truncate_len = IFNULL(@sys.statement_truncate_len, sys.sys_get_config(''statement_truncate_len'', 64));
Query OK, 0 rows affected (0.00 sec)

-- Check whether the option is already set, if not assign - IF ... THEN ... END IF example.
IF (@sys.statement_truncate_len IS NULL) THEN
    SET @sys.statement_truncate_len = sys.sys_get_config(''statement_truncate_len'', 64);
END IF;
' deterministic security invoker reads sql data
BEGIN
    DECLARE v_value VARCHAR(128) DEFAULT NULL;
    -- Check if we have the variable in the sys.sys_config table
    SET v_value = (SELECT value FROM sys.sys_config WHERE variable = in_variable_name);
    -- Protection against the variable not existing in sys_config
    IF (v_value IS NULL) THEN
        SET v_value = in_default_value;
    END IF;
    RETURN v_value;
END;

create definer = `mysql.sys`@localhost procedure sys.table_exists(IN in_db varchar(64), IN in_table varchar(64), OUT out_exists enum('', 'BASE TABLE', 'VIEW', 'TEMPORARY')) comment '
Description
-----------

Tests whether the table specified in in_db and in_table exists either as a regular
table, or as a temporary table. The returned value corresponds to the table that
will be used, so if there''s both a temporary and a permanent table with the given
name, then ''TEMPORARY'' will be returned.

Parameters
-----------

in_db (VARCHAR(64)):
  The database name to check for the existance of the table in.

in_table (VARCHAR(64)):
  The name of the table to check the existance of.

out_exists ENUM('''', ''BASE TABLE'', ''VIEW'', ''TEMPORARY''):
  The return value: whether the table exists. The value is one of:
    * ''''           - the table does not exist neither as a base table, view, nor temporary table.
    * ''BASE TABLE'' - the table name exists as a permanent base table table.
    * ''VIEW''       - the table name exists as a view.
    * ''TEMPORARY''  - the table name exists as a temporary table.

Example
--------

mysql> CREATE DATABASE db1;
Query OK, 1 row affected (0.07 sec)

mysql> use db1;
Database changed
mysql> CREATE TABLE t1 (id INT PRIMARY KEY);
Query OK, 0 rows affected (0.08 sec)

mysql> CREATE TABLE t2 (id INT PRIMARY KEY);
Query OK, 0 rows affected (0.08 sec)

mysql> CREATE view v_t1 AS SELECT * FROM t1;
Query OK, 0 rows affected (0.00 sec)

mysql> CREATE TEMPORARY TABLE t1 (id INT PRIMARY KEY);
Query OK, 0 rows affected (0.00 sec)

mysql> CALL sys.table_exists(''db1'', ''t1'', @exists); SELECT @exists;
Query OK, 0 rows affected (0.00 sec)

+------------+
| @exists    |
+------------+
| TEMPORARY  |
+------------+
1 row in set (0.00 sec)

mysql> CALL sys.table_exists(''db1'', ''t2'', @exists); SELECT @exists;
Query OK, 0 rows affected (0.00 sec)

+------------+
| @exists    |
+------------+
| BASE TABLE |
+------------+
1 row in set (0.01 sec)

mysql> CALL sys.table_exists(''db1'', ''v_t1'', @exists); SELECT @exists;
Query OK, 0 rows affected (0.00 sec)

+---------+
| @exists |
+---------+
| VIEW    |
+---------+
1 row in set (0.00 sec)

mysql> CALL sys.table_exists(''db1'', ''t3'', @exists); SELECT @exists;
Query OK, 0 rows affected (0.01 sec)

+---------+
| @exists |
+---------+
|         |
+---------+
1 row in set (0.00 sec)
' security invoker
BEGIN
    DECLARE v_error BOOLEAN DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR 1050 SET v_error = TRUE;
    DECLARE CONTINUE HANDLER FOR 1146 SET v_error = TRUE;
    SET out_exists = '';
    -- Verify whether the table name exists as a normal table
    IF (EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = in_db AND TABLE_NAME = in_table)) THEN
        -- Unfortunately the only way to determine whether there is also a temporary table is to try to create
        -- a temporary table with the same name. If it succeeds the table didn't exist as a temporary table.
        SET @sys.tmp.table_exists.SQL = CONCAT('CREATE TEMPORARY TABLE `', in_db, '`.`', in_table, '` (id INT PRIMARY KEY)');
        PREPARE stmt_create_table FROM @sys.tmp.table_exists.SQL;
        EXECUTE stmt_create_table;
        DEALLOCATE PREPARE stmt_create_table;
        IF (v_error) THEN
            SET out_exists = 'TEMPORARY';
        ELSE
            -- The temporary table was created, i.e. it didn't exist. Remove it again so we don't leave garbage around.
            SET @sys.tmp.table_exists.SQL = CONCAT('DROP TEMPORARY TABLE `', in_db, '`.`', in_table, '`');
            PREPARE stmt_drop_table FROM @sys.tmp.table_exists.SQL;
            EXECUTE stmt_drop_table;
            DEALLOCATE PREPARE stmt_drop_table;
            SET out_exists = (SELECT TABLE_TYPE FROM information_schema.TABLES WHERE TABLE_SCHEMA = in_db AND TABLE_NAME = in_table);
        END IF;
    ELSE
        -- Check whether a temporary table exists with the same name.
        -- If it does it's possible to SELECT from the table without causing an error.
        -- If it does not exist even a PREPARE using the table will fail.
        SET @sys.tmp.table_exists.SQL = CONCAT('SELECT COUNT(*) FROM `', in_db, '`.`', in_table, '`');
        PREPARE stmt_select FROM @sys.tmp.table_exists.SQL;
        IF (NOT v_error) THEN
            DEALLOCATE PREPARE stmt_select;
            SET out_exists = 'TEMPORARY';
        END IF;
    END IF;
END;

create definer = `mysql.sys`@localhost function sys.version_major() returns tinyint unsigned comment '
Description
-----------

Returns the major version of MySQL Server.

Returns
-----------

TINYINT UNSIGNED

Example
-----------

mysql> SELECT VERSION(), sys.version_major();
+--------------------------------------+---------------------+
| VERSION()                            | sys.version_major() |
+--------------------------------------+---------------------+
| 5.7.9-enterprise-commercial-advanced | 5                   |
+--------------------------------------+---------------------+
1 row in set (0.00 sec)
' security invoker no sql
BEGIN
    RETURN SUBSTRING_INDEX(SUBSTRING_INDEX(VERSION(), '-', 1), '.', 1);
END;

create definer = `mysql.sys`@localhost function sys.version_minor() returns tinyint unsigned comment '
Description
-----------

Returns the minor (release series) version of MySQL Server.

Returns
-----------

TINYINT UNSIGNED

Example
-----------

mysql> SELECT VERSION(), sys.server_minor();
+--------------------------------------+---------------------+
| VERSION()                            | sys.version_minor() |
+--------------------------------------+---------------------+
| 5.7.9-enterprise-commercial-advanced | 7                   |
+--------------------------------------+---------------------+
1 row in set (0.00 sec)
' security invoker no sql
BEGIN
    RETURN SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(VERSION(), '-', 1), '.', 2), '.', -1);
END;

create definer = `mysql.sys`@localhost function sys.version_patch() returns tinyint unsigned comment '
Description
-----------

Returns the patch release version of MySQL Server.

Returns
-----------

TINYINT UNSIGNED

Example
-----------

mysql> SELECT VERSION(), sys.version_patch();
+--------------------------------------+---------------------+
| VERSION()                            | sys.version_patch() |
+--------------------------------------+---------------------+
| 5.7.9-enterprise-commercial-advanced | 9                   |
+--------------------------------------+---------------------+
1 row in set (0.00 sec)
' security invoker no sql
BEGIN
    RETURN SUBSTRING_INDEX(SUBSTRING_INDEX(VERSION(), '-', 1), '.', -1);
END;

