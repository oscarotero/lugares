<?php

include 'vendor/autoload.php';

use SimpleCrud\SimpleCrud;

$argv = $_SERVER['argv'];
array_shift($argv);

// Create the database
if ($argv) {
	$dbname = array_shift($argv);
	$user = array_shift($argv) ?: 'root';
	$pass = array_shift($argv) ?: '';

	$db = new SimpleCrud(new PDO('mysql:host=localhost', $user, $pass));

	$db->execute('DROP DATABASE IF EXISTS '.$dbname);
	$db->execute('CREATE DATABASE '.$dbname);
	$db->execute('USE '.$dbname);

	$scheme = 'mysql.sql';
} else {
	$db = new SimpleCrud(new PDO('sqlite::memory:'));
	$scheme = 'sqlite.sql';
}

$scheme = array_filter(array_map('trim', explode(';', file_get_contents('schemes/'.$scheme))));

foreach ($scheme as $query) {
	$db->execute($query);
}

// Import data
foreach (['community', 'province', 'municipality', 'place'] as $table) {
	$f = fopen(__DIR__.'/data/'.$table.'.csv', 'r');
	$fields = null;

	while (($row = fgetcsv($f)) !== false) {
		if (!$fields) {
			$fields = $row;
			continue;
		}

		$db->$table->insert()
			->data(array_combine($fields, $row))
			->run();
	}
}

// Test relations
$result = $db->community->select()
	->one()
	->by('name', 'Galicia')
	->run()
		->province()
		->one()
		->by('name', 'Coruña, A')
		->run()
			->municipality()
			->one()
			->by('name', 'Tordoia')
			->run()
				->place()
				->one()
				->by('name', 'Gorgullos (Santa Eulalia)')
				->run();

if ($result === $db->place[29329]) {
	echo 'Everything is OK!'.PHP_EOL;
}

echo $result;