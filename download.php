<?php
// Lara Maia <lara@craft.net.br> 2013 (GPLv3)

$file = $_SERVER['DOCUMENT_ROOT'] . '/../../download/' . basename($_SERVER['REQUEST_URI']);
$fileextension = pathinfo($file, PATHINFO_EXTENSION);
$blockextensions = array('php', 'swf');
if (!@file_exists($file)){
	header($_SERVER['SERVER_PROTOCOL'] . ' 404 Not Found');
	print('<!DOCTYPE html><html><body><header>');
	print('<meta http-equiv="content-type" ');
	print('content="text/html; charset=utf-8" />');
	//print('<p>' . $file . '</p>');
	print('<h1>404</h1>');
	print('<h1>Arquivo não encontrado</h1>');
	print('<h1>File not found</h1>');
	print('<h1>Archivo no encontrado</h1>');
	print('<h1>File non trovato</h1>');
	print('</header></body></html>');
	exit(0);
}
foreach($blockextensions as $blockextension) {
	//print('block: ' . $blockextension . "<br />");
	//print('file: ' . $fileextension . "<br /><br />");
	if($blockextension == $fileextension) {
		header($_SERVER['SERVER_PROTOCOL'] . ' 401 Unauthorized');
		print('<!-- Eu não faria isso se fosse você! -->' . "\n");
		print('<!DOCTYPE html><html><body><header>');
		print('<meta http-equiv="content-type" ');
		print('content="text/html; charset=utf-8" />');
		print('<h1>401</h1>');
		print('<h1>UNAUTHORIZED</h1>');
		print('</header></body></html>');
		exit(1);
	}
}

$date = date('d/m/Y');  
$time = date('H:i:s');

$server = 'http://api.easyjquery.com/ips/?ip=';
$ipaddress = $_SERVER['REMOTE_ADDR'];  
$localinfo = file_get_contents($server . $ipaddress . "&full=true");
$json = json_decode($localinfo, true);

$logfile = 'aur-download.log';
$logging = fopen($logfile, 'a');
fwrite($logging, '---- ' . $date . '-' . $time . "+2h\n");
fwrite($logging, 'IP: ' . $json['IP'] . "\n");
fwrite($logging, 'Continente: ' . $json['continentName'] . "\n");
fwrite($logging, 'Pais: ' . $json['countryName'] . "\n");
fwrite($logging, 'Localtime: ' . $json['localTime'] . "\n");
fwrite($logging, 'arquivo: ' . $file . "\n\n");
fclose($logging);

$countfile = 'logs/' . basename($file) . '_down.count';
$hit_count = @file_get_contents($countfile);
if ($hit_count == Null) { $hit_count=1; } else { $hit_count++; }
@file_put_contents($countfile, $hit_count);

function readfile_chunked($filename,$retbytes=true) {
   $chunksize = 1*(1024*1024); // how many bytes per chunk
   $buffer = '';
   $cnt =0;
   $handle = fopen($filename, 'rb');
   if ($handle === false) {
       return false;
   }
   while (!feof($handle)) {
       $buffer = fread($handle, $chunksize);
      // echo $buffer;
      ob_flush();
      flush();
       if ($retbytes) {
           $cnt += strlen($buffer);
       }
   }
       $status = fclose($handle);
   if ($retbytes && $status) {
       return $cnt; // return num. bytes delivered like readfile() does.
   }
   return $status;

}

header($_SERVER['SERVER_PROTOCOL'] . ' 200 OK');
header('Content-Description: File Transfer');
header('Content-Type: application/octet-stream');
header('Content-Disposition: attachment; filename='.basename($file));
header('Content-Transfer-Encoding: binary');
header('Expires: 0');
header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
header('Pragma: public');
header('Content-Length: ' . filesize($file));
ob_clean();
flush();
readfile($file);
?>
