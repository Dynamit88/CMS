<?php
class Database {
    // SERVER SETTINGS
    private $servername = "localhost";
    private $username = "root";
    private $password = "root";
    private $dbname = "database";
    private static $db;
    private $connection;

    private function __construct() {
        $this->connection = mysqli_connect($this->servername, $this->username, $this->password, $this->dbname);
        if (mysqli_connect_errno()){
            echo "Failed to connect to MySQL: ".mysqli_connect_error();
            return null;
            exit;
        }
    }

    function __destruct() {
        mysqli_close($this->connection);
    }

    public static function getConnection() {
        if (self::$db == null) {
            self::$db = new Database();
        }
        return self::$db->connection;
    }
}


// MESSAGE CODES
$msg_codes = array (
    "100" => "OK",
    // Directories
    "650" => "Directory has been successfully created.",
    "651" => "Could not create directory.",
    // Uploads
    "700" => "File has been successfully uploaded.",
    "701" => "Sorry, there was an error uploading your file.",
    "702" => "File with such a name already exists.",
    "703" => "The uploaded file size exceeds the limit",
    "704" => "File extension not allowed",
    "705" => "Failed to write file to disk.",
    // Thumbnails
    "750" => "Image thumbnais have been successfully generated.",
    "751" => "Could not define image type.",
    "752" => "Could not generate thumbnails.",
    // SQL
    "800" => "New record created successfully.",
    "801" => "Could not create new record in the database.",
    "802" => "No values to insert.",   
    "803" => "Selector id is not specified.",   
    "804" => "Supplied array of values is empty.",
    "805" => "Database table is not specified.",
    "806" => "Table entry already exists.",
    "807" => "Couldn't retrieve database row info",
    "850" => "Record has been updated successfully.",
    "851" => "Could not update database record.",
    "852" => "No fields to modify.",
    "853" => "Can't update table which has not been created yet.",
    "870" => "jointWith and/or joinOn walues not specified.",
    "901" => "Can't get table row which does not exist.",
    "902" => "Primary key value has not been specified.",
    "903" => "Select value has not been specified.",
    "904" => "Primary key and primary key value parameters must be strings.",
    "905" => "Value or(and) search query has not been specified.",
    "906" => "Value and search query must be strings.",
    "907" => "Tag text is not set.",
    "908" => "Invalid tag table name.",
    "909" => "Item id to assign tag to is not specified.",
    "951" => "SQL WHERE value has not been specified.",
    "952" => "Can't remove row which does not exist.",
    "953" => "Couldn't retrieve data from the table.",
    "954" => "Couldn't delete row from the table.",
    "955" => "Invalid input."
);

// FILE UPLOAD SETTINGS
$filesSizeLimit = 20000000; // 20Mb
$target_dir = "medias/";
$extensions = array(
    "images" => array(
        'image/png',
        'image/jpeg',
        'image/gif',
        'image/bmp',
        'image/svg+xml'
    ),
    "icons" => array(
        'image/vnd.microsoft.icon',
        
    ),
    "videos" => array(
        'video/quicktime',
        'video/x-flv',
        'application/octet-stream'
    ),
    "audios" => array(
                'audio/mpeg',

    ),
    "docs" => array(
        'text/plain',
        'application/pdf',
        'application/msword',
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
        'application/rtf',
        'application/vnd.ms-excel',
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        'application/vnd.ms-powerpoint',
        'application/vnd.openxmlformats-officedocument.presentationml.presentation',
        'application/vnd.oasis.opendocument.text',
        'application/vnd.oasis.opendocument.spreadsheet'
    ),
    "other" => array(
        'text/html',
        'application/zip', 
        'application/x-rar-compressed', 
        'application/x-msdownload', 
        'application/vnd.ms-cab-compressed',
        'application/x-shockwave-flash',
        'image/vnd.adobe.photoshop',
        'application/postscript'
    )
);

$thumbSizes = array(480, 640, 920);



if (isset($_POST["action"]) && !empty($_POST["action"])){ //FILES MANAGEMENT
    switch ($_POST["action"]){
        case "upload": receiveFiles(); break;
        case "override": receiveFiles(true); break; 
        case "keep": receiveFiles(false, true); break;   
        case "receive": sendFiles(); break;
        case "saveItem": saveItem(); break; //Content/Template data
        case "createItem": createItem(); break;
    }
}
else if (isset($_GET) && !empty($_GET)){
    switch ($_GET["action"]){
        // Files and searching    
        case "info": getFileInfo(); break;
        case "updateInfo": updateFileInfo(); break;
        case "search": findMatches(); break;  
        case "delete": deleteFiles(); break;  
        // Taxonomy    
        case "addTag": addTag(); break;     
        case "getTags": getTags(); break;     
        case "removeTag": removeTag(); break;  
        // Retriving data     
        case "getRowsCount": sqlGetNumberOfRows(); break;
        case "getRows": getRows(); break;
        case "getItemsList": getItemsList(); break;
        case "getItem": getItem(); break;
        case "deleteItem": deleteItem(); break;
        // Generating static HTML    
        case "generatePage": generatePage(); break;
    }
}





//else if (isset($_FILES) && !empty($_FILES)){ // File upload
//    switch ($_FILES["action"]){
//        case "upload": receiveFiles(); break;
//        case "override": receiveFiles(true); break;   
//        case "keep": receiveFiles(false, true); break;   
//    }
//};











function console($data) {
    $output = $data;
    if (is_array($output))
        $output = implode( ',', $output);
    echo "<script>console.log('PHP: ".$output."');</script>";
}

function printAr($array){
    echo "<pre>",print_r($array),"</pre>";
}

function printFiles($path){
    $files = glob($path);
    printAr($files);
}

function getDir (){
    return dirname(__FILE__);  
}


function generateUniqueId (){
    return md5(time() . mt_rand(1,1000000));
}






/* 
 * Checks whether such a row exists and desides whether to
 * to insert or update. 
 * $tableName - String name of the table to modify
 * $array - fields to process
 */
function toDB($tableName, $array, $where){
    if (sqlRowExists($tableName, $where, false) == "true"){
        $sqlQueryResponse = sqlUpdate($tableName, $array, $where);
    }
    else{
        $sqlQueryResponse = sqlInsert($tableName, $array, $where);
    }
    sendJSON($sqlQueryResponse);
}
    

function createItem(){
    $name = $_POST["name"];
    $cat = $_POST["cat"];
    $templ = $_POST["templ"]; //Id of an item template of which we want to use
    
    
    if($name && $cat){
        $currentDate = date("Y-m-d");
        $currentTime = date("H:i:s");

        $db = Database::getConnection();
        $db->query("INSERT INTO items (name, category, authorId, version, dateCreated, timeCreated) VALUES ('$name', $cat, 1, 1, '$currentDate', '$currentTime')");

    }
    
    $newItemId = $db->insert_id;
    
    

    //Copy template over
    if($templ && $templ != 0 && $templ != "0"){
        $template = $db->query("SELECT template FROM items WHERE id=$templ")->fetch_assoc()["template"];
        $db->query("UPDATE items SET template = '$template' WHERE id=$newItemId");
        
        //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>I don't know why query below doesn't work =(
        //        $db->query("UPDATE items SET template = 'templ'
        //                FROM (SELECT template FROM items WHERE id=$templ) templ
        //                WHERE id=$newItemId");
    }
    sendJSON(100, $newItemId); 
}



function generatePage(){
    $itemId = $_GET["id"];
    $projectDir = "projects/first_project/";
   
        
    if (!$itemId){
        sendJSON(803);
        return 1;
    }
    //Get item data from the DB
    $db = Database::getConnection();
    $sqlResult = $db->query("SELECT name, content, template FROM items WHERE id=$itemId");
    $data = $sqlResult->fetch_assoc();
    $data["content"] = unserialize($data["content"]);
    $data["template"] = unserialize($data["template"]);
    $pageUrl = $projectDir. preg_replace('/\s+/', '-', $data["name"]).".html";
    $db = null;    
        
    //Make dirs if not made yet
    if (!is_dir($projectDir."img/")) { 
        mkdir($projectDir."img/", 0777, true);
    }
    if (!is_dir($projectDir."js/")) { 
        mkdir($projectDir."js/", 0777, true);
    }
    if (!is_dir($projectDir."css/")) { 
        mkdir($projectDir."css/", 0777, true);
    }
    
    //Generate page
    $html = "<!DOCTYPE html>
            <html lang='en'>
            <head>
                <meta charset='UTF-8'>
                <title>".$data["name"]."</title>
            </head>
            <body>";
            
    foreach ($data["template"] as &$block) {
        switch($block["type"]){
            case "fwb":
                $html .= "<div class='fwb'>";
                break; 
            case "col":
                $html .= "<div class='col'>";
                break;
        }
        
        switch($block["subtype"]) {
            case "wysiwyg":
                $html .= $data["content"][$block["blockId"]];
                break; 
            case "img":
                $imgData = $data["content"][$block["blockId"]];
                
                //Generate unique image name
//                while(file_exists($projectDir."img/".$imagesNameCounter.".".$imgData["format"])){
//                    $imagesNameCounter++; 
//                }
//               
                //                $newSrc = "img/".$imgData["fullName"];

                $newSrc = "img/".$imgData["title"].".".$imgData["format"];
               
                //Copy image over
                copy ($imgData["medium"], $projectDir.$newSrc);
                //Append HTML
                $html .= "<img alt='".$imgData["alt"]."' src='".$newSrc."'>";
                break;
        }
        $html .= "</div>";
    }
    
    $html .= "</body></html>";
   
    //Save HTML document
    file_put_contents ($pageUrl, $html);
    sendJSON(100, $pageUrl);
}




function getItem (){
    $itemId = $_GET["id"];
    if (!$itemId){
        sendJSON(803);
        return 1;
    }
    $db = Database::getConnection();
    
    
    $sql = "SELECT * FROM items WHERE id=$itemId";
    
    $sqlResult = $db->query($sql);
    
    if ($sqlResult->num_rows > 0) {
        $data = $sqlResult->fetch_assoc();
        $data["content"] = unserialize($data["content"]);
        $data["template"] = unserialize($data["template"]);
        
//        echo $data["content"];
        sendJSON(100, $data);
    } 
    else {
         sendJSON(851, null, $db->error); //Could not update database record
    }
    $db = null;
}


function saveItem (){
    $itemId = $_POST["id"];
    $data = $_POST["data"];
    $blockIdCounter = $_POST["blockIdCounter"];
    $notEmpty = false;
    
    if (!$data || empty($data)){
        sendJSON(804);
        return 1;
    }
    if (!$itemId){
        sendJSON(803);
        return 1;
    }
    
    $db = Database::getConnection();
    
    
    
    
    
    if(!empty($data["template"])){
        //Serialize data
        $serializedTemplate = serialize($data["template"]);
    }
    else{
        $serializedTemplate = "";
    }
    
    if(!empty($data["content"])) {
        //Escape quotation marks
        foreach ($data["content"] as &$content) {
            $content = str_replace(array("\"", "'"), "\"", $content);
        }
        //Serialize data
        $serializedContent = serialize($data["content"]);
    }
    else{
        $serializedContent = "";
    }
    
    
   
    $sql = "UPDATE items SET template='$serializedTemplate', content='$serializedContent', blockIdCounter='$blockIdCounter' WHERE id=$itemId";



    if ($db->query($sql) === TRUE) {
    sendJSON(100);
    } 
    else {
         sendJSON(851, null, $db->error); //Could not update database record
    }
    $db = null;
}



function deleteItem(){
    $itemId = $_GET["id"]; 
    $result = sqlDelete("items", "id=".$itemId);
    sendJSON($result["code"], null, $result["data"]); //Could not update database record
}




/* 
 * $tableName - String name of the table to modify
 * $array - $_POST data to process
 * $dateStamp - bool insert dateCreated row 
 */
function sqlInsert($tableName, $array, $dateStamp = true){
    $return = array("code" => "", "data" => null);
    if (!$tableName){
        $return["code"] = 805;
        return $return;
    }
    if (!$array || empty($array)){
        $return["code"] = 804;
        return $return;
    }
        
    $db = Database::getConnection();
    $columns = "";
    $values = "";

    foreach($array as $key=>$value) {
        if($value){
            $columns .= $key.", ";
            $values .= "'$value', " ;
        }
    }
    if($values != ""){
        if($dateStamp){ // If inserting datestamp
            $currentDate = date("Y-m-d");
            $currentTime = date("H:i:s");
            $columns .=  'dateCreated, timeCreated';
            $values .= "'$currentDate', '$currentTime'";
        } else{
            $columns = rtrim($columns, ', ');
            $values = rtrim($values, ', ');
        }

        $sql = "INSERT INTO $tableName ($columns) VALUES ($values)";

        if ($db->query($sql) === TRUE) {
            $return["code"] = 100;
            $return["data"] = $db->insert_id;
            return $return;
        } 
        else {
            echo($sql."\n\nERROR: ".$db->error);
            $return["code"] = 801;
            return $return;
        }
    }
    else{
        $return["code"] = 802;
        return $return;
    }
}
   


/* 
 * $tableName - String name of the table to modify
 * $array - $_POST data to process
 */
function sqlUpdate($tableName, $array, $where){
    if (!$tableName){
        $return["code"] = 805;
        return $return;
    }
    if (empty($array)){
        $return["code"] = 804;
        return $return;
    }
    if (!$where){
        $return["code"] = 803;
        return $return;
    }
    
    $return = array("code" => "", "data" => null);
    $pairs = "";
    $db = Database::getConnection();

    // Check incoming values
    foreach($array as $key=>$value) {
        if($value){
            $sql = "SELECT $key FROM $tableName WHERE $where";
            $sqlResult = $db->query($sql)->fetch_assoc();
            //If value received is different to the value in in the database
            if ($array[$key] != $sqlResult[$key]){
//                $pairs .= $key."='$value', ";
                $pairs .= $key.'= "'.str_replace ('"', "'",$value).'", ';
            }
        }
    }
    // If there are values that have passed the check
    if ($pairs != ""){
        $pairs = rtrim($pairs, ", ");
        $sql = "UPDATE $tableName SET $pairs WHERE $where";
        if ($db->query($sql) === TRUE) {
            $return["code"] = 100;
            return $return;
        } 
        else {
            echo($sql."\n\nERROR: ".$db->error);
            $return["code"] = 851;
            return $return;
        }
    }
    else {
        $return["code"] = 852;
        return $return;
    }
    $db = null;
}
  

                                         
                                         

                                         
                                         
function sqlGet($tableName, $select, $where = null, $custom = null) {   
    if (!$tableName){  
        $return["code"] = 805;
        return $return;
    }
    
    if (!$select){
       $return["code"] = 903;
       return $return;
    }   
        
    $return = array("code" => "", "data" => null);
    $db = Database::getConnection();
    $data = array();
    $sql = "SELECT $select FROM $tableName";
    if($where){
        $sql .= " WHERE $where";
    }
    else if ($custom){
        $sql .= " $custom";
    }
//    echo $sql;
    $sqlResult = $db->query($sql);     
    if ($sqlResult->num_rows > 0) {
        while($item = $sqlResult->fetch_assoc()) {
            array_push($data, $item);
        }
        $return["code"] = 100;
        $return["data"] = $data;
    }
    else{
        $return["code"] = 901;
    }

    $db = null;
    return $return;
}


function sqlDelete($tableName, $where) {   
    if (!$tableName){
        $return["code"] = 805;
        return $return;
    } 
    
    if (!$where){   
       $return["code"] = 951;
       return $return;
    }  
    $return = array("code" => "");    
    $db = Database::getConnection();

    $sql = "DELETE FROM $tableName WHERE $where";
    $sqlResult = $db->query($sql);

    $return["code"] = 100;
    return $return;
    $db = null;
}


                                         
function sqlSearch($tableName, $select, $search, $like){   
    return $sql = sqlGet($tableName, $select, "$search LIKE '%{$like}%'");
}

         


//function sqlGetNumberOfRows (){
//    $sql = sqlGet($_GET["tableName"], "COUNT(1) AS 'count'");
//    if ($sql["code"] == 100){
//        sendJSON(100, $sql["data"][0]);
//    }
//    else{
//        sendJSON($sql["code"]);
//    }                                                           
//}

function sqlGetNumberOfRows (){
    $tableName = $_GET["tableName"];
    
    ////////SEARCHING///////
    $search = $_GET["search"];
    $like = $_GET["like"];
    ////////////////////////
    
    ////////FILETER///////
    $where = $_GET["where"];
    $whereValue = $_GET["whereValue"];
    ////////////////////////
    
    
    
    $whereClause = "";
    if($where != NULL && $whereValue != NULL ){
            $whereClause .= $where. "=". $whereValue." ";
        if($search != NULL && $like != NULL){
             $whereClause .= "AND $search LIKE '%{$like}%' ";
        }
    }
    else if($search != NULL && $like != NULL) {
        $whereClause .= "$search LIKE '%{$like}%' ";
    }
    
    $custom = "";
    if($orderBy){
        $custom .= "ORDER BY $orderBy ";
        if($desc && $desc != "false"){
            $custom .= "DESC ";
        }
    }
    if($quantity){
         $custom .= "LIMIT $quantity ";
    }
    if($offset){
         $custom .= "OFFSET $offset ";
    }
    

//    echo $whereClause;
//    echo $custom;
    
    $sql = sqlGet($tableName, "COUNT(1) AS 'count'", $whereClause, $custom);
    
    if ($sql["code"] == 100){
        sendJSON(100, $sql["data"][0]);
    }
    else{
        sendJSON($sql["code"]);
    }           
}



// Ger rows = used to retrive paginated items.


function getRows (){
    $tableName = $_GET["tableName"];
    $offset = $_GET["offset"];
    $quantity = $_GET["quantity"];
    $orderBy = $_GET["orderBy"];
    $desc = $_GET["desc"]; // desc/asc

    ////////SEARCHING///////
    $search = $_GET["search"];
    $like = $_GET["like"];
    ////////////////////////
    
    ////////FILETER///////
    $where = $_GET["where"];
    $whereValue = $_GET["whereValue"];
    ////////////////////////
    
    $custom = "";
    
    if($where != NULL && $whereValue != NULL ){
            $custom .= "WHERE ". $where. "=". $whereValue." ";
        if($search != NULL && $like != NULL){
             $custom .= "AND $search LIKE '%{$like}%' ";
        }
    }
    else if($search != NULL && $like != NULL) {
        $custom .= "WHERE $search LIKE '%{$like}%' ";
    }
    if($orderBy){
        $custom .= "ORDER BY $orderBy ";
        if($desc && $desc != "false"){
            $custom .= "DESC ";
        }
    }
    if($quantity){
         $custom .= "LIMIT $quantity ";
    }
    if($offset){
         $custom .= "OFFSET $offset ";
    }

    $sql = sqlGet($tableName, "*", null, $custom);
    
    if ($sql["code"] == 100){
        sendJSON(100, $sql["data"]);
    }
    else{
        sendJSON($sql["code"]);
    }           
}


// Get "items" (pages/posts/block contents) from the DB
function getItemsList (){
    $offset = $_GET["offset"];
    $quantity = $_GET["quantity"];
    $orderBy = $_GET["orderBy"];
    $desc = $_GET["desc"]; // desc/asc

    ////////SEARCHING///////
    $search = $_GET["search"];
    $like = $_GET["like"];
    ////////////////////////
    
    ////////FILETER/////////
    $where = $_GET["where"];
    $whereValue = $_GET["whereValue"];
    ////////////////////////
    
    $custom = "";
    
    
    if ($where && $whereValue) {
        $custom .= "AND ". $where. "=". $whereValue." ";
    }
    
    if ($search && $like) {
        $custom .= "AND $search LIKE '%{$like}%' ";
    }

    if ($orderBy) {
        $custom .= "ORDER BY $orderBy ";
        if($desc && $desc != "false"){
            $custom .= "DESC ";
        }
    }
    
    if ($quantity) {
         $custom .= "LIMIT $quantity ";
    }
    
    if ($offset) {
         $custom .= "OFFSET $offset ";
    }

    $db = Database::getConnection();

    $sqlResult = $db->query(
    "SELECT I.*, C.catName, U.username
    FROM items I, categories C, users U
    WHERE C.id=I.category AND U.id=I.authorId ".$custom);     

    
    $rows = array();
    while($r = $sqlResult->fetch_assoc()) {
        $rows[] = $r;
    }
    $db = NULL;
    sendJSON(100, $rows);
}



function getItemsListShort (){
    $db = Database::getConnection();
    $sqlResult = $db->query(
    "SELECT id, name
    FROM items");     

    
    $rows = array();
    while($r = $sqlResult->fetch_assoc()) {
        $rows[] = $r;
    }
    $db = NULL;
    return $rows;
}









                                       
function sqlRowExists ($tableName, $where, $closeConnection = true){
    // Check if the table row already exists
    $db = Database::getConnection();
    $sql = "SELECT IF(COUNT(*) > 0, 'true', 'false') as 'exists' FROM $tableName";
    if($where){
        $sql .= " WHERE $where";
    }
    
    $rowExists = $db->query($sql)->fetch_assoc()['exists'];
    if ($closeConnection){
        $db = null;
    }
    return $rowExists;
}






function getTags (){
    $tableName = $_GET["tableName"];
    $itemId = $_GET["itemId"];
    $sql = sqlGet("$tableName N, tags T" , "tid, tag", "N.iid = $itemId AND N.tid = T.id");
    if ($sql["code"] == 100){
        sendJSON(100, $sql["data"]);
    }
    else{
        sendJSON($sql["code"]);
    }
}




function addTag (){
    $tagText = $_GET["tagText"];
    if(!$tagText){
        sendJSON(907); 
        exit();
    }

    $tableName = $_GET["tableName"];
    if(!$tableName){
        sendJSON(805); //Table not specified
        exit(); 
    }
    
    $itemId = $_GET["itemId"];
    if(!$itemId){
        sendJSON(909); //Item not specified
        exit();  
    }
    
    $tagId = $_GET["tagId"];
    if(!$tagId){ //if id not specified assume its a new tag
        //Check if tag already exists
        $getTag = sqlGet("tags", "id", "tag ='$tagText'"); // Get tag id
         
        if($getTag["code"] == 100){ 
            $tagId = $getTag["data"][0]["id"];
        }
        else{
            $insertTag = sqlInsert("tags", array ("tag" => $tagText), false);
           
            if($insertTag["code"] == 100){
                $tagId = $insertTag["data"];
                 
            }
            else{
                sendJSON($insertTag["code"]);
                exit();
            }
        }
    }    

    $array = array("iid" => $itemId, "tid" => $tagId );
    switch ($tableName){
        case "images_tags": 
            $sql = sqlInsert($tableName, $array, false);
            sendJSON($sql["code"],$tagId);
            break;
        default:
            sendJSON(908); //Unknown table
            exit(); 
    }
}


function removeTag (){
    $tableName = $_GET["tableName"];
    $tagId = $_GET["tagId"];
    $sql = sqlDelete($tableName, "tid = '$tagId'");
    sendJSON($sql["code"]);
}




//////////////////////////////SEARCH DB/////////////////////////////

function findMatches (){
    $sql = sqlSearch($_GET["tableName"], "*", $_GET["search"], $_GET["like"]);
    sendJSON($sql["code"], $sql["data"]);
}

//////////////////////////////GET FILE INFO/////////////////////////////
function getFileInfo (){
    $tableName = $_GET["tableName"];
    $id = $_GET["id"];
    $sql = sqlGet($tableName, "*", "id = $id");
    sendJSON($sql["code"], $sql["data"]);
}

//////////////////////////////UPDATE FILE INFO/////////////////////////////
function updateFileInfo (){
    $id = $_GET["id"];
    if(isset($_GET["tableName"]) && !empty($_GET["tableName"]) && isset($id) && !empty($id) && isset($_GET["fields"]) && !empty($_GET["fields"]) && isset($_GET["values"]) && !empty($_GET["values"])){
        $sql = sqlUpdate($_GET["tableName"], array_combine ($_GET["fields"], $_GET["values"]), "id = $id");
        sendJSON($sql["code"], $sql["data"]);
    }
}




//////////////////////////////FILE RETREIVING/////////////////////////////
function sendFiles (){
    $tableName = $_POST["tableName"];
    $select = $_POST["return"];
    $sql = sqlGet($tableName, $select);
    sendJSON($sql["code"], $sql["data"]);
}


function deleteFiles (){
    $tableName = $_GET["tableName"];
    $idsString = implode(",", $_GET["id"]);
    $filesToDelete = []; 
    
    if($tableName == "images"){ 
        $filePaths = sqlGet($tableName, "src, thumb, medium, large", "id IN ($idsString)");
        foreach($filePaths["data"] as $file){
            array_push($filesToDelete, $file["src"], $file["thumb"], $file["medium"], $file["large"]);
        }
    }
    else{
        $filePaths = sqlGet($tableName, "src", "id IN ($idsString)"); 
        foreach($filePaths["data"] as $file){
            array_push($filesToDelete, $file["src"]);
        }
    }
    
    if($filePaths["code"] != 100){
        sendJSON($filePaths["code"]);
        exit();   
    }
    
    
    foreach ($filesToDelete as $file){
        unlink($file);
    }
       
    $sql = sqlDelete($tableName, "id IN ($idsString)");
    sendJSON($sql["code"]);
}





//////////////////////////////FILE UPLOADS/////////////////////////////


function receiveFiles($override = false, $keepBoth = false) {
    global $filesSizeLimit, $extensions, $target_dir;
    $file = $_FILES["file"];
    $tmpFile = $file["tmp_name"];
    if ($file["error"] > 0) { // Check if there is any errors
        sendJSON(500, null, $fileStatus);
        return null;
    }
    if ($file["size"] > $filesSizeLimit){ 
        sendJSON (703);// File size is over the limit
        return null;
    }
    
    $fileFullName = cleanFileName($file["name"]);
    
    
    
    $fileName = substr($fileFullName, 0, strrpos($fileFullName, "."));
    $fileMime = getMimeType($tmpFile);
    $dir = $target_dir;
    $SQL_table = "";
    $data = array (
        'name' => $fileFullName,
        'title' => $fileName,
        'format' => pathinfo($file["name"], PATHINFO_EXTENSION),
        'size' => $file["size"]
    );
    
    //////////////CHAECK EXTENSION///////////////
    if(in_array($fileMime, $extensions["images"])){ 
        $dir .= "images/";
        $SQL_table = "images";
        
    }
    else if(in_array($fileMime, $extensions["videos"])){
        if (in_array($data["format"], array("mp4", "mpg", "wmv", "avi" ,"flv", "mov"))){ 
            $dir .= "videos/";
            $SQL_table = "videos"; 
        }
        else{
            sendJSON (704); // File extension not allowed 
            return null;
        }
    }   
    else if(in_array($fileMime, $extensions["docs"])){
        $dir .= "docs/"; 
        $SQL_table = "docs";
    }    
    else if(in_array($fileMime, $extensions["other"])){
        $dir .= "other/"; 
        $SQL_table = "otherfiles";
    }   
    else{
        sendJSON (704); // File extension not allowed
        return null;
    }
    $data["type"] = $SQL_table;
    
    
    ////////////////RESOLVE COLLISIONS////////////////
    if(file_exists($dir.$fileFullName)){ // if file already exist
        if(!$override && !$keepBoth){
            $info = getExistingFileInfo ($SQL_table, "*", "name='$fileFullName'");
            sendJSON (702, $info); 
            return null;
        }
        else if ($keepBoth){
            $newFileNameOk = false;
            $i = 0;
            while (!$newFileNameOk){
                $i++;
                $newFileName = $data["title"]."($i).".$data["format"];
                if(!file_exists($dir.$newFileName)){
                   $newFileNameOk = true; 
                }
            }
            $fileFullName = $newFileName;
            $data["name"] = $newFileName;
            $data["title"] .= "($i)";
        }
    }
    $data["src"] = $dir.$fileFullName;
   
    ////////////////SAVE FILE////////////////
    $saveFile = saveFile($tmpFile, $dir, $fileFullName, $override);
    if ($saveFile !== 100){ // File wasn't saved
        sendJSON ($saveFile); // send status
        return null;
    }
    
    
    
    if($SQL_table === "images"){ //CREATE THUMBNAILS
        if($fileMime === "image/svg+xml"){ // SVG - no thumbs
            $data["thumb"] = $dir.$fileFullName;
        }
        else{
            $thumbDirs = generateThumbs($dir, $fileFullName, null, true);
            if ($thumbDirs != 751 && $thumbDirs != 752){
                $imageResolution = getimagesize($dir.$fileFullName);
                $data = $data + array (
                    'width' => $imageResolution[0],
                    'height' => $imageResolution[1],
                    'alt' => '',
                    'large' => $thumbDirs[2],
                    'medium' => $thumbDirs[1],
                    'thumb' => $thumbDirs[0],
                    'tags' => '',
                );
            }
            else{
                sendJSON ($thumbDirs); // Couldn't create Thumbnails
                unlink($dir.$fileFullName); //Delete original image
                return null;
            }  
        }
    }
    
    
        
    
    
    
    
    
    ////////////////SAVE DB DATA////////////////
    if(!$override){
        $sqlQuery = sqlInsert($SQL_table, $data);
    }
    else{
        unset($data['title']);
        $sqlQuery = sqlUpdate($SQL_table, $data, "name = '$fileFullName'");
    }

    if($sqlQuery["code"] == 100){
        $data["id"] = $sqlQuery["data"]; // Should return ID
        sendJSON (100, $data); 
        return true;
    }
    else{
        // UNSUCCESSFUL QUERY HERE
        sendJSON ($sqlQuery["code"]);
        unlink($dir.$fileFullName);
        if($SQL_table == "images"){
            unlink($thumbDirs[2]);
            unlink($thumbDirs[1]);
            unlink($thumbDirs[0]);
        }
        return null;
    }
}








// Returning data about the existing file to the user
function getExistingFileInfo ($tableName, $select, $where){
 $sql = sqlGet($tableName, $select, $where);
    if ($sql["code"] == 100){
        return $sql["data"][0];
    }
    else{
        sendJSON($sql["code"]);
        return null;
    }
}


function sendJSON ($code = 100, $data = null, $msg = null ) {
    global $msg_codes;
    $results = array(
        "code" => $code,
    );
    
    if($code != 100){
       $results["msg"] = $msg_codes["$code"];
    }
    
    if ($msg){
        $results["msg"] = $msg;
    }
    $results["data"] = $data;
    
    echo json_encode($results);
}


function getMimeType ($tmpFile){
    $finfo = finfo_open(FILEINFO_MIME_TYPE);
    $mimetype = finfo_file($finfo, $tmpFile);
    finfo_close($finfo);
    return $mimetype;
}


function isExtensionAllowed ($tmpFile){
    global $extensions;
    $ext = getMimeType($tmpFile);
    foreach ($extensions as $extArr){
        if(in_array($ext, $extArr)){
            return true;
        }
    }
    return false;
}

function pushDirectory ($dir){
   if (!is_dir($dir)) { // Check id directory exists
        if(mkdir($dir, 0777, true)){
           return 100;
        }
        return 651;
    } 
}


function saveFile ($tmpFile, $dir, $fileName, $override = false){
    pushDirectory ($dir);
    if(!$override){
        if(file_exists($dir.$fileName)){ // Check if a file with such a name already exists
             return 702; // File already exists
        }
    }
    if (move_uploaded_file($tmpFile, $dir.$fileName)) {
        return 100;
    } else {
        return 705; // Couldn't write
    }
}

















//////////////////////////////THUMBNAILS/////////////////////////////

/* 
 * $dir - directory to save generated thumbs
 * $fileName - the name of original image
 * $tmpFile - http upload file (optional)
 * $createSubDir - create directory for each thumb size (bool)
 * return: an array with path to every thumb image
 */
function generateThumbs($dir, $fileName, $tmpFile = null, $createSubDir = false, $targetHeight = null) {
    $imgSrc = $tmpFile ? : $dir.$fileName; 
    $type = exif_imagetype($imgSrc);
    $thumbSizeNames = array ("thumb", "medium", "large");
    global $thumbSizes;
    if (!$type) {
        return 751;
    }
   
    switch ($type) {
    case IMAGETYPE_JPEG:
        $image = imagecreatefromjpeg($imgSrc);
        break;
    case IMAGETYPE_PNG:
        $image = imagecreatefrompng($imgSrc);
        break;
    case IMAGETYPE_GIF:
        $image = imagecreatefromgif($imgSrc);
        break;
    }

    if (!$image) {
        return 752;
    }
    
    $width = imagesx($image);
    $height = imagesy($image);
    $ratio = $width / $height;
    $ext = pathinfo($fileName, PATHINFO_EXTENSION);
    $return = array();
    
    foreach ($thumbSizes as $index=>$targetWidth){
        if ($targetHeight == null) { // Maintain aspect ratio when no height set
            if ($width > $height) { // Landscape
                $targetHeight = floor($targetWidth / $ratio);
            }
            else { // Portrait
                $targetHeight = $targetWidth;
                $targetWidth = floor($targetWidth * $ratio);
            }
        }

        $thumbnail = imagecreatetruecolor($targetWidth, $targetHeight); //Create new image

        if ($type == IMAGETYPE_GIF || $type == IMAGETYPE_PNG) {// Set transparency options for GIFs and PNGs
            imagecolortransparent( // Make image transparent
                $thumbnail,
                imagecolorallocate($thumbnail, 0, 0, 0)
            );
            if ($type == IMAGETYPE_PNG) { // Additional settings for PNGs
                imagealphablending($thumbnail, false);
                imagesavealpha($thumbnail, true);
            }
        }

        imagecopyresampled( // Resize and apply parameters
            $thumbnail,
            $image,
            0, 0, 0, 0,
            $targetWidth, $targetHeight,
            $width, $height
        );
        $subDir = "";
        
        if($index < 3){
            $resolution = "($thumbSizeNames[$index])";
            if ($createSubDir){
                $subDir = "$thumbSizeNames[$index]/";
            }
        }
        else{
            $resolution = "($targetWidth x $targetHeight)";
             if ($createSubDir){
                 $subDir = "$targetWidth"."x"."$targetHeight/";
             }
        }
        pushDirectory ($dir.$subDir);
        $targetHeight = null;
        $saveDir = $dir.$subDir.basename($fileName, ".$ext") . $resolution .".". $ext;
        

        switch ($type) {
            case IMAGETYPE_JPEG:
                imagejpeg($thumbnail, $saveDir ,100);
                break;
            case IMAGETYPE_PNG:
                imagepng($thumbnail, $saveDir, 0);
                break;
            case IMAGETYPE_GIF:
                imagegif($thumbnail, $saveDir);
                break;
        }
        array_push($return, $saveDir);
    }
    imagedestroy($image);
    return $return;
}













function cleanFileName($string) {
    //Lower case everything
//    $string = strtolower($string);
    //  (removes all other characters)
//    $string = preg_replace("/[^A-z0-9_.()\s-]/", "", $string);
    //Clean up multiple dashes or whitespaces
//    $string = preg_replace("/[\s-]+/", " ", $string);
    //Convert whitespaces and underscore to dash
    $string = preg_replace("/[\s]/", "_", $string);
    return $string;
}







//gzcompress($string); - Compress strings
?>
