<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="js/js_tagbox.js"></script>
<script src="js/js_loader.js"></script>
<!--<script src="js/file_uploader.js"></script>-->
<script src="js/file_manager.js"></script>
<script src="js/js_select.js"></script>

<link rel="stylesheet" type="text/css" href="css/main.css">


<?php
require_once('functions.php')

?>
<style>

    form{
        padding: 100px;
        margin: 0;
    }
    p{
        color: white;
    }
    #editor-sbmit-tbn{
        float: right;
    }
    pre{
        padding: 10px;
        font-family: monospace;
        word-break: break-word;
        white-space: pre-line;
        color: white;
    }
    .item-spacer{
        height: 200px;
    }
    .js_fu_fileContainer, .js_fu_thumbContainer{
        float: left;
            margin-right: 15px;
    }
</style>




<form id="editorForm" method="post" enctype="multipart/form-data">
    <legend id="legendTextJS"></legend>
    <p>
        Name
        <input type="text" name="fullName" id="editorFullName" value="" autocomplete="off">
    </p>
    <!--
    <p class="clearfix">
       Abbreviation
        <input type="text" name="shortName" id="editorShortName" value="" autocomplete="off">
    </p>
    <p>
        <label for="editorNation">Country</label>
        <select id="editorNation" name="nation">
            <option value=""></option>
            <option value="ussr">СССР</option>
            <option value="germany">Германия</option>
        </select>
    </p>
-->

    <div class=" item-spacer ">
        <p class="editor-img-box">
            File </p>
        <div id='fu1' class="js_fu_fileContainer"></div>
        <pre id="done1"></pre>
    </div>

    

    <div class=" item-spacer">
        <p class="editor-img-box">
            Photo</p>

        <div id='fu2' class="js_fu_thumbContainer"></div>
            <pre id="done2"></pre>

    </div>


    <p>
        <textarea id="editorFormTechnical" name="technicalInfo" placeholder="Other info"></textarea>
    </p>
    <p>
        <textarea id="editorFormHistory" name="history" placeholder="History"></textarea>
    </p>
    <p>
        <textarea id="editorFormWar" name="combatHistory" placeholder="Main Text"></textarea>
    </p>



    <input name="sbmtBtn" id="editor-sbmit-tbn" type="submit" value="Save" title="Save changes">
</form>



<script>
   var $fm1 = $("#fu1").js_fm({
        mode: 4,
        thumbContainer: "this",
        fireEvent: true
    });
    
    
   
   document.getElementById("fu1").addEventListener("js_fu_done", function(e) {
        $("#done1").html(JSON.stringify($fm1.getSelected()));
    }, false);

    
 

    var $fm2 = $("#fu2").js_fm({
        mode: 2,
        thumbContainer: "this",
        fireEvent: true
    });
    
document.getElementById("fu2").addEventListener("js_fu_done", function(e) {
        $("#done2").html(JSON.stringify($fm2.getSelected()));
    }, false);



    function destroyFM(e) {
        $fm.destroy();
    }


    function initFM() {
        $fm = $("#fu2").js_fm({
            mode: 2,
            thumbContainer: "this",
            fireEvent: true
        });
    }

</script>
