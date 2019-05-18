<?php 


//    function injectCustomItem() {
//        // Page contents
//        $contents = array(0 => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", 1 => array ( "id" => 1008, "fullName" => "Wallpapers.jpg", "name" => "Wallpapers", "title" => "Wallpapers", "format" => "jpg", "size" => 307959, "width" => 1366, "height" => 768, "type" => "images", "alt" => "", "src" => "medias/images/Wallpapers.jpg", "thumb" => "medias/images/thumb/Wallpapers(thumb).jpg", "medium" => "medias/images/medium/Wallpapers(medium).jpg", "large" => "medias/images/large/Wallpapers(large).jpg", "description" =>"", "dateCreated" => "2018-10-18", "timeCreated" => "01:45:29"));
//        // Page template
//        $template = array (0 => array ( "blockId" => 0, "type" => "fwb", "subtype" => "wysiwyg", "options" => ""), 1 => array ( "blockId" => 1, "type" => "fwb", "subtype" => "img", "options" => ""));
//
//        $item = array("data" => array ("content" => $contents, "template" => $template));
//
//        // Set header with GET parameter & value
//        header("Location: template-editor.php?loadThis=".json_encode($item));
//        exit;
//    }



    require_once("functions.php");
    function testFileUploads (){
        ////TESTING IMAGE UPLOAD
        // Read local image file in binary mode
        $imagefile = fopen("test_image212.jpg","rb");
        
        // Check if file exisits in the system
        $fileExists = getExistingFileInfo("images", "id", "WHERE name='test_image212.jpg'");
        if($fileExists){
            echo "File already exists";
            return 1;
        }

        // Set file upload array value
        $_FILES["file"] = $imagefile_name;
        $isFileUploaded = receiveFiles();
        
        // Check if file exists in DB now
        $isFileExists = getExistingFileInfo("images", "id", "WHERE name='test_image212.jpg'");
        
        // Check if file save locally
        $isFileSaved = file_exists("medias/images/test_image212.jpg.jpg");
        
        // Print test results
        echo ("Testing image upload: ". ($isFileUploaded && $isFileExists && $isFileSaved) ? "SUCCESS" : "FAIL";
        
        
        ////TESTING FILES OVER SIZE LIMIT
        $overLimitFile = fopen("archive111.rar","rb");
        
        // Check if file exisits in the system
        $fileExists = getExistingFileInfo("other", "id", "WHERE name='archive111.rar'");
        if($fileExists){
            echo "File already exists";
            return 2;
        }
        
        $_FILES["file"] = $overLimitFile;
        $isFileUploaded = receiveFiles();
              
        // Print test results
        echo ("Testing over limit file upload: ". $isFileUploaded ? "FAIL": "SUCCESS";
              
              
        ////TESTING PROHIBITED EXTENSION FILE
        $malFile = fopen("malFile.ptrs","rb");
        // Check if file exisits in the system
        $fileExists = getExistingFileInfo("other", "id", "WHERE name='malFile.ptrs'");
        if($fileExists){
            echo "File already exists";
            return 3;
        }
        
        $_FILES["file"] = $malFile;
        $isFileUploaded = receiveFiles();
              
        // Print test results
        echo ("Testing uploading file with prohibited extension: ". $isFileUploaded ? "SUCCESS" : "FAIL";
        return 0;
    }
    



function testImageThumbnails (){
    
    //TESTING IMAGE UPLOAD
    // Read local image file in binary mode
    $imagefile = fopen("image(1080px)r2.jpg","rb");

    // Check if file exisits in the system
    $fileExists = getExistingFileInfo("images", "id", "WHERE name='image(1080px)r2.jpg'");
    if($fileExists){
        echo "File already exists";
        return 1;
    }

    // Set file upload array value
    $_FILES["file"] = $imagefile_name;
    $isFileUploaded = receiveFiles();

    // Check if file exists now
    $isFileExists = getExistingFileInfo("images", "id", "WHERE name='test_image212.jpg'");

    
    $areThumbnailsGenerated = (
    file_exists("medias/images/image(1080px)r2.jpg") &&
    file_exists("medias/images/large/image(1080px)r2(large).jpg") &&
    file_exists("medias/images/medium/image(1080px)r2(medium).jpg") &&
    file_exists("medias/images/thumb/image(1080px)r2(thumb).jpg")); 
        
        
    // Print test results
    echo ("Testing thumbnail generation upload: ". ($areThumbnailsGenerated && $isFileExists) ? "SUCCESS" : "FAIL";
    
    
    
}
    

?>



<!--
<script src="js/jQuery.js"></script>
<script src="js/js_tagbox.js"></script>
<script src="js/js_loader.js"></script>
<script src="js/file_manager.js"></script>
<script src="js/js_select.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
-->









<?php 
//    require_once('functions.php');
//    include('modules/jasmine_include.php');







//<a class='btn btn-edit' href='template-editor.php?loadI=" + itemsArray[i].id + "'>
//$customItem =
   
    
    
//   

?>


<!--
<body>
    <?php 
//include('modules/cms-menu.php')
?>
    <main>

        <div id="pane"></div>
        <div id="tb"></div>
        <div id="fm" style="height:100px; background-color:brown;"></div>
        
        
        
        
        
    </main>



    
    
    

    <?php 
//    include('modules/footer.php') 
?>
</body>
-->

<script>
    ///////////////////////////TESTING////////////
    /**
     * AJAX callback. Once SQL rows are retrieved, this method iterates through results
     * and creates an instance of Item, which in turn displays item on the item pane.
     * @param {JSON} json - server response. 
     */
    //    function showItems(json) {
    //        var itemsArray = json.data;
    //        if (itemsArray && itemsArray.length > 0) {
    //            var i = 0;
    //            var l = itemsArray.length;
    //            for (i; i < l; i++) {
    //                /*
    //                No references to this object.
    //                Will be removed by garbage collector.
    //                */
    //                $pane.append("<div class='itemlist-item' data-id='" + itemsArray[i].id + "'><h3 class='itemlist-name'>" + itemsArray[i].name + "</h3><h4 class='itemlist-type'><strong>Category: </strong><span>" + itemsArray[i].catName + "<span></h4><div class='itemlist-btns'><button class='btn-delete'>Delete</button><button class='btn-view'>View</button><a class='btn btn-edit' href='template-editor.php?loadI=" + itemsArray[i].id + "'>Edit</a></div><ul class='itemlist-dates'><li><strong>Created: </strong>" + itemsArray[i].dateCreated + "<strong> At: </strong>" + itemsArray[i].timeCreated + "<strong> By: </strong>" + itemsArray[i].username + "</li><li><strong>Modified: </strong>" + itemsArray[i].dateModified + "<strong> At: </strong>" + itemsArray[i].timeModified + "<strong> By: </strong>" + itemsArray[i].username + "</li></ul></div>");
    //            }
    //        } else {
    //            console.log("Error");
    //        }
    //    }
    //
    //
    //    var $pane = $("#pane");
    //    var $fileManagerDiv = $("#fm");
    //    var $tagboxDiv = $("#tb");









    //        describe("Testing loader module", function() {
    //            
    //            function isEmpty(el) {
    //                return !$.trim(el.html());
    //            }
    //            
    //            var $loader = $pane.js_loader(showItems, {
    //                mode: 3, //Pagination,
    //                tableName: "items",
    //                serverAction: "getItemsList",
    //                itemsPerPage: 10,
    //                orderBy: "id",
    //                desc: true,
    //            });
    //    
    //            it("Get items count", function() {
    //                expect($loader.getRowsCount()).toEqual(36);
    //            });
    //            
    //            it("Show specific page", function() {
    //                $loader.showPage(1)
    //                expect($loader.getCurrentPage()).toEqual(1);
    //            });
    //    
    //            it("Go to next page", function() {
    //                $loader.next();
    //                expect($loader.getCurrentPage()).toEqual(2);
    //            });
    //    
    //            it("Go to previous page", function() {
    //                $loader.prev();
    //                expect($loader.getCurrentPage()).toEqual(1);
    //            });
    //    
    //            it("Page beyond 0", function() {
    //                $loader.showPage(-1);
    //                expect($loader.getCurrentPage()).not.toEqual(-1);
    //            });
    //    
    //            it("Non-existing page", function() {
    //                $loader.showPage(99);
    //                expect($loader.getCurrentPage()).not.toEqual(99);
    //            });
    //    
    //    
    //            it("Getting SQL table value", function() {
    //                expect($loader.getSQLTable()).toBe("items");
    //            });
    //    
    //            it("Setting new SQL table value", function() {
    //                $loader.setSQLTable("bubbles");
    //                expect($loader.getSQLTable()).toBe("bubbles");
    //                $loader.setSQLTable("items"); //Restore
    //            });
    //    
    //            it("Emptying item pane", function() {
    //                $loader.emptyPane();
    //                expect(isEmpty($pane)).toBe(true);
    //            });
    //    
    //            it("Refresh item pane", function() {
    //                $loader.refresh();
    //                expect(isEmpty($pane)).toBe(false);
    //            });
    //    
    //        });
    //
    //
    //
    //        describe("Testing file manager module", function() {
    //            var $fm = $fileManagerDiv.js_fm({
    //            mode: 2,
    //            thumbContainer: "this",
    //            fireEvent: true
    //            });
    //            
    //            it("Get selected item data", function() {
    //                $fm.selectItem(4);
    //                var itemData = {
    //                    "id": "1015",
    //                    "fullName": "348622(1).jpg",
    //                    "name": "348622(1)",
    //                    "title": "546546546gfdf",
    //                    "format": "jpg",
    //                    "size": "710999",
    //                    "width": "2560",
    //                    "height": "1600",
    //                    "type": "images",
    //                    "alt": "",
    //                    "src": "medias/images/348622(1).jpg",
    //                    "thumb": "medias/images/thumb/348622(1)(thumb).jpg",
    //                    "medium": "medias/images/medium/348622(1)(medium).jpg",
    //                    "large": "medias/images/large/348622(1)(large).jpg",
    //                    "description": "",
    //                    "dateCreated": "2018-12-27",
    //                    "timeCreated": "23:31:49"
    //                }
    //                expect($fm.getSelected()).toEqual(itemData);
    //            });
    //    
    //            it("Searching for an item", function() {
    //                $fm.searchItem("moj");
    //                expect($fm.getItems()[0].name).toEqual("Mojave");
    //            });
    //    
    //            it("Destroying file manager", function() {
    //                $fm.destroy();
    //                expect($fm).toEqual(null);
    //            });
    //    
    //        });
    //
    //
    //    describe("Testing tagbox module", function() {
    //        var $tagBox = $tagboxDiv.js_tb("itemsTags", 452);
    //
    //        it("Adding a new tag"function() {
    //            expect($tagBox.hasTag("new_tag")).toEqual(false);
    //            expect($tagBox.addTag("new_tag")).toBe(true);
    //            expect($tagBox.hasTag("new_tag")).toEqual(true);
    //        });
    //
    //        it("Testing get tags"function() {
    //            expect($.inArray("new_tag", $tagBox.getTags()).toBe(true);)
    //        });
    //
    //        it("Assigning tag which already assigned to the item"function() {
    //            expect($tagBox.hasTag("new_tag")).toEqual(true);
    //            expect($tagBox.addTag("new_tag")).toBe(false);
    //        });
    //
    //        it("Removing tag"function() {
    //            expect($tagBox.hasTag("new_tag")).toEqual(true);
    //            expect($tagBox.removeTag("new_tag")).toBe(true);
    //            expect($tagBox.hasTag("new_tag")).toEqual(false);
    //        });
    //
    //        it("Assigning category"function() {
    //            expect($tagBox.hasCat("new_category")).toEqual(false);
    //            expect($tagBox.assignCat("new_category")).toBe(true);
    //            expect($tagBox.hasCat("new_category")).toEqual(true);
    //        });
    //
    //        it("Testing get category"function() {
    //            expect($tagBox.getCat()).toEqual("new_category");
    //        });
    //
    //        it("Removing category"function() {
    //            expect($tagBox.hasCat("new_category")).toEqual(true);
    //            expect($tagBox.removeCat("new_category")).toBe(true);
    //            expect($tagBox.hasCat("new_category")).toEqual(false);
    //        });
    //    });



    function testFileManager() {
        // Dummy image data
        var itemData = {
            "id": "1015",
            "fullName": "348622(1).jpg",
            "name": "348622(1)",
            "title": "546546546gfdf",
            "format": "jpg",
            "size": "710999",
            "width": "2560",
            "height": "1600",
            "type": "images",
            "alt": "",
            "src": "medias/images/348622(1).jpg",
            "thumb": "medias/images/thumb/348622(1)(thumb).jpg",
            "medium": "medias/images/medium/348622(1)(medium).jpg",
            "large": "medias/images/large/348622(1)(large).jpg",
            "description": "",
            "dateCreated": "2018-12-27",
            "timeCreated": "23:31:49"
        }

        // Set up file manager module
        var $fm = $fileManagerDiv.js_fm({
            mode: 2,
            thumbContainer: "this",
            fireEvent: true
        });


        // Set up event listener 
        $fileManagerDiv.addEventListener("js_fu_done", function(e) {
            var returnedItemData = $Fm.getSelected();

            // Check if the expected data is returned from the module
            var isCorrectData = isEqualJSON(returnedItemData, itemData);

            // Check if background thumb has been set to the container
            var isBackgroundThumbAttached = $fileManagerDiv.css('background-image') == itemData.thumb;

            var result = (isCorrectData && isBackgroundThumbAttached) ? "SUCCESS" : "FAIL";
            // Print the results
            console.log("File manager test: " + result);
        }, false);

        // Select an item
        $fm.selectItem(4);


        // Helper function
        function isEqualJSON(obj1, obj2) {
            var flag = true;
            if (Object.keys(obj1).length == Object.keys(obj2).length) {
                for (key in obj1) {
                    if (obj1[key] == obj2[key]) {
                        continue;
                    } else {
                        flag = false;
                        break;
                    }
                }
            } else {
                flag = false;
            }
            return flag;
        }
    }







    function testTaxonomy() {
        var newTag = "Taxonomy test";
        var $tagBox = $tagboxDiv.js_tb("itemsTags", 452);
        var tags = $tagBox.getTags();

        // Check if this tag already assigned
        var alreadyAssigned = $.inArray(newTag, tags);

        // Assign new tag 
        $tagBox.addTag(newTag);

        // Check if new tag is assigned
        var assignSuccess = !alreadyAssigned && $.inArray(newTag, $tagBox.getTags());

        //Remove tag
        $tagBox.removeTag(newTag);

        // Check if new tag has been removed
        var removeSuccess = !$.inArray(newTag, $tagBox.getTags());

        return assignSuccess && removeSuccess;
    }





    function testBlocksOrder() {
        // Get an array of blocks in the pane
        var blocks = blocksPane.getElementsByClassName("js_te_block");

        // Get ids of the first two blocks
        var id1 = blocks[0].getAttribute("data-id"); //Id of the first block
        var id2 = blocks[1].getAttribute("data-id"); //Id of the second block

        // Get subtypes of the two blocks (asuming that they have different subtypes)
        var subtype1 = blockObjects[id1].subtype;
        var subtype2 = blockObjects[id2].subtype;

        // Swap the two blocks over
        var tmp = blocks[1];
        blocks[1].remove();
        blocksPane.prepend(tmp);

        // Prepare template for an export
        var template = exportPageData().template;

        // Check if template blocks follow the correct oreder
        return template[0].subtype == subtype2 && template[1].subtype == subtype1;
    }



    function saveCustomItem() {
        var item = { // Custom item
            template: [{
                "blockId": 0,
                "type": "fwb",
                "subtype": "wysiwyg",
                "options": ""
            }, {
                "blockId": 1,
                "type": "fwb",
                "subtype": "img",
                "options": ""
            }],
            content: [
                "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                {
                    "id": 1008,
                    "fullName": "Wallpapers.jpg",
                    "name": "Wallpapers",
                    "title": "Wallpapers",
                    "format": "jpg",
                    "size": 307959,
                    "width": 1366,
                    "height": 768,
                    "type": "images",
                    "alt": "",
                    "src": "medias/images/Wallpapers.jpg",
                    "thumb": "medias/images/thumb/Wallpapers(thumb).jpg",
                    "medium": "medias/images/medium/Wallpapers(medium).jpg",
                    "large": "medias/images/large/Wallpapers(large).jpg",
                    "description": "",
                    "dateCreated": "2018-10-18",
                    "timeCreated": "01:45:29"
                }
            ]
        }

        // Store custom item to the DB
        AJAX("POST", {
            action: "saveItem",
            id: 100,
            blockIdCounter: 2, //Store ID counter to DB
            data: item
        }, onSaveCallback);


        // Retrieve item from the DB
        AJAX("GET", {
            action: "getItem",
            id: 100,
        }, onItemLoadCallback);

        // Compare original item with the one retrieve from the DB
        function onItemLoadCallback(json) {
            $("main").append((isEqualJSON(item.template, json.data.template) && isEqualJSON(item.content, json.data.content)) ? "SUCCESS" : "FAIL");
        }

        // Helper function
        function isEqualJSON(obj1, obj2) {
            var flag = true;
            if (Object.keys(obj1).length == Object.keys(obj2).length) {
                for (key in obj1) {
                    if (obj1[key] == obj2[key]) {
                        continue;
                    } else {
                        flag = false;
                        break;
                    }
                }
            } else {
                flag = false;
            }
            return flag;
        }

    }

</script>
