;
(function ($, undefined) { // Unonymous function to protect $
    ////////////////MODES/////////////////
    var FM_MODE_GALLERY = 0; // Editing items info, uploading files (no ability to select multiples or to extract selected data)
    var FM_MODE_GENERAL = 1; // Item category tabs shown (all)
    var FM_MODE_IMG = 2; // Images
    var FM_MODE_VIDEO = 3; // Videos
    var FM_MODE_DOC = 4; // Documents

    ////////////////SETTINGS/////////////////
    var settings;

    ///////////////FUNCTIONAL VARS///////////////////
    var $Fm; //FM object which has all the public methods
    var $loader = null; // Instance of js_loader plugin      
    var fmInitiated = false; // File Manager initiation flag (Single instance per page)
    var cache = {}; // Instances of Item are stored here (hashing for quick look-up)
    var uploadModeEntered = false; //Upload mode flag. Once uploadig is initiated, FM enters a special state. 
    var currentFMMode; //Current mode
    var $listOfCallerElements = [] // An array of references to all the elements on which FM is opening
    var $thisCallerElement; // DOM element on which FM is opening
    var currentSQLTable; // The SQL table items of which are currently displayed
    var $itemDatails; //Details about current item (including detail table, description textarea, tagbox and action buttons)
    var selectedItmes = []; // An array of elements which have been selected. 
    var $fileInput = null; // input[type="file"] 
    var dragCounter = 0; // For drag&drop functionality
    var currentTab = null; // File tab oppened (images/videos/etc...)


    ///////////////VISUAL ELEMENTS///////////////////
    var $container; // DOM FU container element (paddings)
    var $fmWindow // DOM FU element (main window) 
    var $fmTitle; // DOM File uploader's main title
    var $fmHideBtn; //Button to close FM window
    var $itemsContainer; // DOM Pane with all the Items
    var $detailContainer; // DOM Item detail pane
    var $selectButton; // Button which approves selection 
    var $menuPanel; // Menu 


    /////////////////////MENU////////////////////////
    var $menuUploadBtn; // Click to upload file 
    var $menuOrderBtn //Click to change order of items
    var $menuOrderContainer; // Contains sorting options
    var $menuFileTabs = null; // File types selection
    var $menuSearchInput; // Input type=text for seraching items within current table
    var $menuResetSearchBtn; // Reset search button
    var $menuBackBtn; // Click to return from upload mode 

    ///////////////DETAIL CONTAINER//////////////////
    var $detailPaneDeleteItemBtn;


    var defaults = {
        ///////////SETTINGS///////////
        mode: FM_MODE_GALLERY,
        multiselect: false,
        fireEvent: false, // Fire "js_fu_done" event once done selecting
        thumbContainer: false, // DOM element; Once a file selected, set thumb background to this element
        centerImagesVertically: true,
        showUploadProgressPecentage: false,

        ///////////SERVER///////////
        serverURL: "functions.php",
        SQL_imagesTable: "images",
        SQL_videosTable: "videos",
        SQL_documentsTable: "docs",
        SQL_otherFilesTable: "otherfiles",

        ////////////BUTTONS////////////
        textBtnDeleteFile: "Delete",
        textBtnDownloadFile: "Download",
        textBtnSelect: "Select",
        textBtnBack: "Back",
        textBtnUploadFiles: "Choose Files",
        textOrderNewest: "Newest first",
        textOrderOldest: "Oldest first",
        textBtnImages: "Images",
        textBtnVideos: "Videos",
        textBtnDocuments: "Docs",
        textBtnOtherFiles: "Other",

        /////////////MISC//////////////
        textDescriptionPlaceholder: "Description...",
        textEmpty: "No items here",
        textSelectFiles: "Select files",
        textDragHere: "Drag here",
        textUploading: "Uploading",

        /////////USER MESSAGES/////////
        textFileReplaced: "Image has been replaced.",
        textFileNotReplaced: "Image couldn't be replaced.",
        textFileSaved: "File has been saved.",
        textFileNotSaved: "File couldn't be saved."
    };



    ///////////////////////////////////////////////////////////////////////
    ///////////////////////INITIATION///////INITIATION/////////////////////
    ///////////////////////////////////////////////////////////////////////

    /**
     * Initiates variables and appends File Manager vindow to the HTML body
     */
    function init() {
        currentFMMode = settings.mode;
        currentSQLTable = settings.SQL_imagesTable;
        $selectButton = $("<button>", {
            id: "js_fu_selectBtn",
            class: "disabled",
            disabled: "",
            text: settings.textBtnSelect
        });

        //Creating container div
        $container = $("<div>", {
            id: 'js_fu_container',
        }).on({
            dragover: function (e) {
                e.stopPropagation();
                e.preventDefault();
            },
            dragenter: function (e) {
                e.stopPropagation();
                e.preventDefault();
                dragCounter++;
                $fmTitle.text(settings.textDragHere);
            },
            dragleave: function (e) {
                e.stopPropagation();
                e.preventDefault();
                dragCounter--;
                if (dragCounter === 0) {
                    $fmTitle.text(settings.textSelectFiles);
                }
            },
            drop: function (e) {
                e.stopPropagation();
                e.preventDefault();
                enterUploadMode();
                fuUpload(e.originalEvent.dataTransfer.files);
                dragCounter = 0;
            }
        });

        //File uploader DOM element
        $fmWindow = $("<table>", {
            id: 'js_fu_pane',
        });

        //Creating top panel
        (function () {
            var $fuTopPanel = $("<tr>");

            $fmTitle = $("<div>", {
                id: 'js_fu_title',
                text: settings.textSelectFiles
            });

            $fmHideBtn = $("<div>", {
                id: 'js_fu_closeBtn',
                click: fmHide
            });

            $fuTopPanel.append($("<td>", {
                id: 'js_fu_topPanel',
                colspan: "2"
            }).append($fmTitle, $fmHideBtn));
            $fmWindow.append($fuTopPanel);
        })();



        //Creating item && detail panes
        (function () {
            //FILE INPUT 
            $fileInput = $("<input>", {
                type: "file",
                multiple: "",
                id: "js_fu_fileInput",
                change: function () {
                    if (this.files.length) {
                        enterUploadMode();
                        fuUpload(this.files);
                    }
                }
            });
            //MENU
            $menuPanel = $("<td>", {
                id: 'js_fu_menuPanel'
            });
            constructMenuPanel();
            // ITEMS CONTAINER
            $itemsContainer = $("<div>", {
                id: "js_fu_itemContainer"
            }).on("click", ".js_itemInfo", onItemClick);

            // DETAIL CONTAINER
            $detailContainer = $("<td>", {
                id: 'js_fu_detailContainer',
                rowspan: "2"
            });

            $fmWindow.append($("<tr>").append($menuPanel, $detailContainer.append($selectButton)), $("<tr>").append($("<td>", {
                id: "js_fu_mainPane"
            }).append($itemsContainer)));
        })();

        //Detail Container
        $detailPaneDeleteItemBtn = $("<button>", {
            class: "js_fu_deleteFileBtn",
            text: settings.textBtnDeleteFile,

        });

        /**
         * File manager's object wich contains all the public methods. A single 
         * instance per page, which can be opened in mutiple modes. 
         */
        $Fm = {
            open: function (mode, $callerElement) {
                currentFMMode = mode;
                $thisCallerElement = $callerElement;

                // Display/hide selection button
                if (currentFMMode === FM_MODE_GALLERY) {
                    $selectButton.hide();
                } else {
                    $selectButton.show();
                }
                // Set SQL table for JS loader to load appropriate items
                switch (currentFMMode) {
                    case FM_MODE_IMG:
                        currentSQLTable = settings.SQL_imagesTable;
                        break;
                    case FM_MODE_VIDEO:
                        currentSQLTable = settings.SQL_videosTable;
                        break;
                    case FM_MODE_DOC:
                        currentSQLTable = settings.SQL_documentsTable;
                        break;
                }

                //Initiate js_loader or load appropriate items 
                if (!$loader) { // If js_loader is not initialized yet, do so
                    initJS_loader();
                } else if ($loader.getSQLTable() !== currentSQLTable) {
                    $loader.setSQLTable(currentSQLTable).refresh();
                }
                //Show or hide file type tabs (Mark appropriate tab as active)
                updateFileTabs($menuFileTabs[0].querySelector("[data-table='" + currentSQLTable + "']"));
                $container.show();
            },
            close: function () {
                fmHide();
            },
            getSelected: function () {
                var data = [];
                if (selectedItmes.length) { // If there are some items
                    if (settings.multiselect) { //If multiselect enabled
                        var i = 0;
                        var l = selectedItmes.length;
                        for (i; i < l; i++) {
                            var $tmp = JSON.parse(JSON.stringify(cache[selectedItmes[i]])); //Make a copy
                            delete $tmp.$elem; // Remove reference to DOM element
                            data.push($tmp);
                        }
                        return data;
                    }
                    // If multiselect disable, we return only one item    
                    var $tmp = JSON.parse(JSON.stringify(cache[selectedItmes[0]])); //Make a copy
                    delete $tmp.$elem; // Remove reference to DOM element
                    return $tmp;
                }

            },
            refresh: function () {
                $loader.refresh();
            },
            destroy: function () {
                //Remove listeners
                var i = 0,
                    l = $listOfCallerElements.length;
                for (i; i < l; i++) {
                    $listOfCallerElements[i].removeData("fmInitiated").off("click");
                }

                $fmHideBtn.off("click", fmHide);
                $itemsContainer.off("click", ".js_itemInfo", onItemClick);
                $container.off("dragover dragenter dragleave drop");
                $menuOrderContainer.off("click", ".js_fu_orderOptn");
                $menuFileTabs.off("click", "li");
                $menuSearchInput.off("keyup");
                $menuResetSearchBtn.off("click");
                $menuBackBtn.off("click", exitUploadMode);
                $menuUploadBtn.off("click");
                $detailPaneDeleteItemBtn.off("click");
                $selectButton.off("click", selectionDone);


                //Clear variables
                settings = null;
                $loader.destroy();
                $loader = null;
                fmInitiated = null;
                cache = {};
                uploadModeEntered = null;
                currentFMMode = null;
                $listOfCallerElements = [];
                $thisCallerElement = null;
                currentSQLTable = null;
                $itemDatails = null;
                selectedItmes = [];
                $fileInput = null;
                dragCounter = 0;
                currentTab = null;
                $fmWindow = null;
                $fmTitle = null;
                $fmHideBtn = null;
                $itemsContainer = null;
                $detailContainer = null;
                $selectButton = null;
                $menuPanel = null;
                $menuUploadBtn = null;
                $menuOrderBtn = null;
                $menuOrderContainer = null;
                $menuFileTabs = null;
                $menuSearchInput = null;
                $menuResetSearchBtn = null;
                $menuBackBtn = null;
                $detailPaneDeleteItemBtn = null;
                $container.remove();
                $container = null;
                $Fm = null;
            }
        }



        $('body').append($container.append($fmWindow).hide());
        fmInitiated = true;
    }

    /**
     * Helper function to construct menu panel. Includes sorting seraching 
     * and file type tabs.
     */
    function constructMenuPanel() {
        $menuUploadBtn = $("<button>", {
            text: settings.textBtnUploadFiles,
            id: "js_fu_uploadBtn",
            click: function () {
                $fileInput.click();
            }
        });
        $menuOrderBtn = $("<div>", {
            text: settings.textOrderNewest,
            id: "js_fu_orderBtn"
        });
        $menuOrderContainer = $("<div>", {
            id: "js_fu_order"
        }).append($menuOrderBtn, "<div id='js_fu_orderList'><div class='js_fu_orderOptn' data-order='desc'>" + settings.textOrderNewest + "</div><div class='js_fu_orderOptn' data-order='asc'>" + settings.textOrderOldest + "</div></div>").on("click", ".js_fu_orderOptn", function () {
            $menuOrderBtn.text(this.textContent);
            clearSelection();
            switch (this.getAttribute("data-order")) { //>>>>>>>>>>>>Can add other sorting opetions
                case "asc":
                    $loader.desc(false);
                    break;
                case "desc":
                    $loader.desc(true);
                    break;
            }
        });

        // FILE TABS
        $menuFileTabs = $("<ul>", {
            id: "js_fu_fileTabs"
        }).append("<li class='active' data-table='" + settings.SQL_imagesTable + "'>" + settings.textBtnImages + "</li><li data-table='" + settings.SQL_videosTable + "'>" + settings.textBtnVideos + "</li><li data-table='" + settings.SQL_documentsTable + "'>" + settings.textBtnDocuments + "</li><li data-table='" + settings.SQL_otherFilesTable + "'>" + settings.textBtnOtherFiles + "</li>").on("click", "li", function () {
            //            var $this = $(this);

            if (!this.classList.contains("active")) { //If not already opened
                currentSQLTable = this.getAttribute("data-table");
                $itemsContainer.removeClass("js_fu_empty");
                clearSelection();
                updateFileTabs(this);
                cache = {}; //Empty cache because items from a different table may have the same ids
                $loader.setSQLTable(currentSQLTable).refresh();
            }
        });

        currentTab = $menuFileTabs[0].getElementsByTagName("li")[0]; //Set first tab as opened


        $menuSearchInput = $("<input>", {
            id: "js_fu_search",
            type: "text",
            keyup: function () {
                clearSelection();
                $loader.search("title", this.value);
                if (this.value !== "") {
                    $menuResetSearchBtn.addClass("active");
                } else {
                    $menuResetSearchBtn.removeClass("active");
                }
            }
        });

        $menuResetSearchBtn = $("<span>", { // Search reset button
            id: "js_fu_searchBtn"
        }).on("click", function () {
            if (this.classList.contains("active")) {
                $loader.resetSearch();
                $menuSearchInput.val("");
                clearSelection();
                this.classList.remove("active");
            }
        });
        $menuBackBtn = $("<button>", {
            text: settings.textBtnBack,
            id: "js_fu_backBtn",
            css: {
                display: "none"
            },
            click: exitUploadMode
        });

        $menuPanel.append($menuUploadBtn, $menuFileTabs, $("<div>", {
            id: "js_fu_searchContainer"
        }).append($menuSearchInput, $menuResetSearchBtn), $menuOrderContainer, $menuBackBtn);
    }









    ///////////////////////////////////////////////////////////////////////
    ////////////////ACTION HANDLERS///////ACTION HANDLERS//////////////////
    ///////////////////////////////////////////////////////////////////////




    /**
     * Helper function to hide FM
     */
    function fmHide() {
        if (uploadModeEntered) { //If FM is in upload mode
            exitUploadMode();
        }
        clearSelection();
        $itemsContainer.scrollTop(0);
        $container.hide();
    }

    /**
     * Deselects all items, resets "select" button, and clears detail container.
     */
    var clearSelection = function () {
        //Clear array of selected items
        if (selectedItmes.length) {
            var i = 0,
                l = selectedItmes.length;
            for (i; i < l; i++) {
                cache[selectedItmes[i]].$elem.removeClass("js_fu_selectedItem");
            }
            selectedItmes = [];
        }


        //        updateSelectButton();
        if (currentFMMode != FM_MODE_GALLERY) { // If select button is relevant
            $selectButton.addClass("disabled").attr("disabled", "").off("click"); //Disable it
        }

        removeItemInfo();
    }



    /**
     * Update state of file caterories buttons (images, vides, etc..)
     * @param {DOM} activeTab - tab to be set as active
     */
    function updateFileTabs(activeTab) {
        if (currentFMMode === FM_MODE_GALLERY || currentFMMode === FM_MODE_GENERAL) { //If file tabs should be visible
            currentTab.classList.remove("active");
            activeTab.classList.add("active");
            currentTab = activeTab;
            $menuFileTabs.show();
        } else {
            $menuFileTabs.hide();
        }
    }






    /**
     * Once and Item is clicked, it is pushed to the array of selected elements 
     * for any further operations.
     * @param {int} itemId - id of an Item (matches database id as well as id 
     * in cache object)
     */
    function selectItem(itemId) {
        //If multiselct disabled, deselect previous item
        if (!settings.multiselect && selectedItmes.length) {
            deselectItem(selectedItmes[0]);
        }
        selectedItmes.push(itemId);
    }


    /**
     * Remove Item from the array of selected elements and unmark corresponding DOM element.
     * @param {int} itemId - id of an Item (matches database id as well as id 
     * in cache object)
     */
    function deselectItem(itemId) {
        selectedItmes.splice($.inArray(itemId, selectedItmes), 1);
        cache[itemId].$elem.removeClass("js_fu_selectedItem");
    }








    /**
     * Select button click handler. If have thumbContainer set, then the thumb of selected 
     * Item will be applied as background image to the element assigned to thumbContainer. 
     * If thumbContainer is set to "this" string, then background will be set to elemetn on 
     * which Fm is opened. If fireEvent is set, js_fu_done event will be fired on the document.
     * After this FM is hidden. 
     */
    function selectionDone() {
        if (!$selectButton.attr("disabled")) {
            if (settings.thumbContainer) {
                if (settings.thumbContainer === "this") { //if thumb has to be set to the element on which FM is called
                    $thisCallerElement.css("background-image", "url('" + cache[selectedItmes[0]].thumb + "')").addClass("js_fu_selectionDone");
                } else {
                    $(settings.thumbContainer).css("background-image", "url('" + cache[selectedItmes[0]].thumb + "')").addClass("js_fu_selectionDone");
                }
            }
            if (settings.fireEvent) {
                $thisCallerElement[0].dispatchEvent(new Event("js_fu_done"));
            }
            fmHide();
        }
    }


    /**
     * Displays information about an Item on the $detailContainer.
     * @param {Item} $item - object generated by Item constructor.
     */
    function showItemInfo($item) {
        var $infoTable = $("<table>", {
            class: "js_fu_infoTable"
        });
        var $itemPreview = "";

        var $rows = [{
            th: "Title",
            td: $item.title,
            dbrow: 'title',
            edit: true
                    }, {
            th: "Format",
            td: $item.format,
                    }, {
            th: "Size",
            td: fuConvertSize($item.size),
                    }];


        if ($item.type === "images") {
            $rows.push({
                th: "Width",
                td: $item.width + "px",
            }, {
                th: "Height",
                td: $item.height + "px",
            });
            $itemPreview = "<div class='js_fu_itemPreview'><img src='" + $item.thumb + "' alt='item preview image' draggable='false' /></div>";
        }



        $.each($rows, function (index, row) { //Append rows to the table
            if (!row.edit) {
                $infoTable.append(
                    "<tr><th>" + row.th + "</th><td>" + row.td + "</td></tr>"
                );
            } else {
                // If edditing is permitted
                $infoTable.append(
                    $("<tr>").append($("<th>", {
                        text: row.th
                    }), $("<td>", {
                        class: "js_fu_editableField"
                    }).append($("<input>", {
                        type: "text",
                        val: row.td,
                        focusout: function () {
                            saveField(this, row.dbrow);
                        }
                    })))
                );
            }
        });


        //===================* TAGBOX PLUGIN *====================//
        var $tagBox = $(document.createElement("div"));
        if (typeof $tagBox.js_tb !== "undefined" && $.isFunction($tagBox.js_tb)) {
            $tagBox.js_tb("images_tags", $item.id);
        }

        //===================* APPENDING STUFF *====================//


        $detailPaneDeleteItemBtn.on("click", onDeleteItemClick);

        $itemDatails = $("<div>", {
            class: "js_fu_itemDetails"
        }).append($itemPreview, $infoTable, $("<div>", {
            id: "js_fu_fileManagementBox"
        }).append("<a class='btn js_fu_downloadFileBtn' draggable='false' href='" + $item.src + "' download>" + settings.textBtnDownloadFile + "</a>", $detailPaneDeleteItemBtn));

        if ($item.type === "images") {
            $itemDatails.append($("<textarea>", {
                class: "js_fu_textarea",
                placeholder: settings.textDescriptionPlaceholder,
                text: $item.description,
                focusout: function () {
                    saveField(this, "description")
                }
            }), $tagBox);

        }
        $detailContainer.prepend($itemDatails);


        //===================* HELPER FUNCTIONS *====================//
        function saveField(input, DB_rowName) {
            if ($item[DB_rowName] != input.value) {
                fuAJAX("GET", {
                    action: "updateInfo",
                    tableName: $item.type,
                    id: $item.id,
                    fields: [DB_rowName],
                    values: [input.value]
                } /*, echo*/ ); //Uncoment echo to output server messages to console
                cache[$item.id][DB_rowName] = input.value;
            }
            return false;
        }

        function onDeleteItemClick() {
            clearSelection(); //Will remove delete btn handler as well
            deleteFiles($item.type, [$item.id]);
        }
    }


    /**
     * Removes information about an Item from the $detailContainer.
     */
    function removeItemInfo() {
        $detailPaneDeleteItemBtn.off("click");
        if ($itemDatails) {
            $itemDatails.remove();
            $itemDatails = null;
        }

        //====================================>> Destroy Tagbox?
        return $detailContainer;
    }
    /**
     * Displays a message to the user on the $detailContainer.
     * @parm {int} messageType - type of message
     * @parm {string} text - message
     * @parm {boolean} permanent - if set to true, message will be displayed peramanently
     */
    function fuShowMessage(messageType, text, permanent) {
        var messageClass = null;
        switch (messageType) {
            case 0:
            case "success":
                messageClass = "msg_success";
                break;

            case 1:
            case "error":
                messageClass = "msg_error";
                break;

            case 2:
            case "warning":
                messageClass = "msg_warning";
                break;

            case 3:
            case "info":
                messageClass = "msg_info";
                break;
        }

        if (!permanent) {
            $detailContainer.prepend($("<p>", {
                class: messageClass,
                text: text,
                css: {
                    display: "none"
                }
            }).fadeIn().delay(3000).fadeOut(function () {
                this.remove();
            }));
        } else {
            $detailContainer.prepend("<p class='" + messageClass + "'>" + text + "</p>");
        }
    }



    function displayNoItemsMsg() {
        $itemsContainer.addClass("js_fu_empty").append("<h1 class='js_fu_emptyMsg'>" + settings.textEmpty + "</h1>");
    }


    /**
     * Function that hadles whats happaning upon click on an Item DOM element.
     */
    var onItemClick = function () { // Item click event handling here
        var $this = $(this);
        var itemId = this.getAttribute("data-did");
        $itemDatails && $itemDatails.remove(); // If item detail are shown, remove them. 

        if (!$this.hasClass("js_fu_selectedItem")) {
            selectItem(itemId);
            showItemInfo(cache[itemId]);
            $this.addClass("js_fu_selectedItem");
        } else {
            deselectItem(itemId);
            removeItemInfo();

        }

        //Update select button
        if (currentFMMode != FM_MODE_GALLERY) { // If select button is relevant
            if (selectedItmes.length && cache[itemId].type === currentSQLTable) { //If there are selected items and they are of an appropriate type
                $selectButton.removeClass("disabled").removeAttr("disabled").on("click", selectionDone);
            } else {
                $selectButton.addClass("disabled").attr("disabled", "").off("click", selectionDone);
            }
        }
        return false;
    }

    ///////////////////////////////////////////////////////////////////////
    //////////////SERVER INTERACTION///////SERVER INTERACTION//////////////
    ///////////////////////////////////////////////////////////////////////

    /**
     * Creates new instance of JS_loader plugin on the items pane DOM element. 
     * @param {String} SQL_table - SQL database table name to load rows from
     */
    function initJS_loader() {
        if (typeof $itemsContainer.js_loader !== "undefined" && $.isFunction($itemsContainer.js_loader)) {
            $loader = $itemsContainer.js_loader(showItems, {
                mode: 1,
                tableName: currentSQLTable,
                itemsPerPage: 20,
                distanceToLoadMore: 100,
                orderBy: "id",
                desc: true,
            });
        } else {
            throw new Error("For correct work of this plugin, js_loader plugin is required.");
        }
    }

    /**
     * Function to enter FM into upload mode. 
     */
    function enterUploadMode() {
        uploadModeEntered = true;
        clearSelection();
        if ($loader) { //If js_loader plugin is initiated, destroy it
            $loader.emptyPane().destroy();
            $loader = null;
        }

        $menuOrderContainer.hide();
        $menuFileTabs.hide();
        $menuSearchInput.hide();
        $menuResetSearchBtn.hide();
        $menuBackBtn.show();
    }

    /**
     * Function to exit upload mode. 
     */
    function exitUploadMode() {
        uploadModeEntered = false;
        clearSelection();
        $itemsContainer.removeClass("js_fu_empty").empty();
        cache = {}; // Items have to be reloaded anew
        initJS_loader();
        $menuOrderContainer.show();
        if (currentFMMode === FM_MODE_GALLERY || currentFMMode === FM_MODE_GENERAL) { //If file tabs should be visible
            $menuFileTabs.show();
        }
        $menuSearchInput.show();
        $menuResetSearchBtn.show();
        $menuBackBtn.hide();

    }

    /**
     * This function recursively sends files to the server.
     * @param {dataTransfer.files} files - files to be uploaded. 
     * @param {int} i - iterative flag for recursion. Leave this parameter empty.  
     */
    function fuUpload(files, i) {
        var n = i || 0; // file number 
        var fd = new FormData();
        fd.append("file", files[n]);
        fd.append('action', 'upload');
        fuAJAX("POST", fd, fileUploadCallback, new Item(null, true), true, true);

        //SET TITLE TEXT
        $fmTitle.text(settings.textUploading + " " + files[n].name);


        function fileUploadCallback(json, $newItem) {
            $newItem.removeProgressBar();
            switch (json.code) {
                case 100:
                    $newItem.attachData(json.data);
                    break;
                case 702: // Name collision
                    fuResolveCollision($newItem, files[n], json.msg, json.data)
                    break;
                default:
                    console.log("Code: " + json.code + "\nServer message: " + json.msg);
                    //>>>>>>>>>>>>>>>>>>>>>>>>>>
            }
            $fmTitle.text(settings.textSelectFiles);
            n++;
            if (files.length > n) { // If there is more files, upload them one by one
                fuUpload(files, n)
            }
        }
    }




    /**
     * AJAX callback. Once SQL rows are retrieved, this method iterates through results
     * and creates an instance of Item, which in turn displays item on the item pane.
     * @param {JSON} json - php response. 
     */
    function showItems(json) {
        var itemsArray = json.data;
        if (itemsArray && itemsArray.length > 0) {
            var i = 0;
            var l = itemsArray.length;
            for (i; i < l; i++) {
                /*
                No references to this object.
                Will be removed by garbage collector.
                */
                new Item(itemsArray[i]);
            }
        } else {
            displayNoItemsMsg();
        }
    }



    /**
     * This is the constructor for all the items appearing in the window with files.
     * @param {associative array} $data - sql data about the item returned by server. The entire
     * data collection is attached to the item variable via JQ .data() method. Besides that, 
     * database id of the item is attached to the DOM element through "data-did" attribute. 
     * @param {boolean} prepend  - by default all the new items will be appended to the window,
     * set this to true if you want new items to be prepended.
     * @param {function} onThumbLoadCallback - function to be executed once thumb image has been loaded
     */


    function Item($data, prepend, onThumbLoadCallback) {
        this.$elem = $(document.createElement("div")).addClass("js_fu_item js_itemInfo col-xs-6 col-sm-4 col-md-4 col-lg-3");
        this.$progressBarContainer = null;
        this.$progressBar = null;
        this.$thumb = null;
        this.id = null;
        this.onThumbLoad = onThumbLoadCallback;
        //Save cache data and attach thumb image (if needed)
        $data && this.attachData($data);

        //Attach new Item to the items container
        if (prepend) {
            this.$elem.prependTo($itemsContainer);
        } else {
            this.$elem.appendTo($itemsContainer);
        }

        return this;
    }

    Item.prototype = {
        attachData: function ($data) {
            this.$elem.attr("data-did", $data.id);
            cache[$data.id] = $data;
            cache[$data.id].$elem = this.$elem;
            // Attaching thumb images to different content types
            switch ($data.type) {
                case settings.SQL_imagesTable: // If item is an image
                    this.$elem.addClass("js_fu_imageItem");
                    this.attachThumb($data.thumb);
                    break;
                case settings.SQL_videosTable:
                    this.$elem.addClass("js_fu_videoItem");
                    this.attachThumb("img/js_fu/blank_bkgrnd.png");
                    cache[$data.id].thumb = "img/js_fu/blank_bkgrnd.png";
                    break;
                case settings.SQL_documentsTable:
                    this.$elem.addClass("js_fu_documentItem");
                    this.attachThumb("img/js_fu/docs/" + $data.format + ".png");
                    cache[$data.id].thumb = "img/js_fu/docs/" + $data.format + ".png";
                    break;
                    //>>>>>>>>>>>>>>>>>>>>>>>>>>
            }
            return this;
        },
        attachThumb: function (thumbSrc) {
            var $that = this;
            this.$thumb = $("<img>", {
                src: thumbSrc,
                alt: "thumb image",
                draggable: "false",
                css: {
                    display: "none"
                }
            }).on("load", function () {
                $that.$elem.removeClass("loading");
                if (this.naturalWidth < this.naturalHeight) {
                    $that.$elem.addClass("js_fu_portraitItem");
                }
                if ($that.onThumbLoad) {
                    $that.onThumbLoad();
                    $that.onThumbLoad = null;
                }
                $(this).off("load").fadeIn();
            });
            this.$elem.append($("<div>", {
                class: "js_fu_thumbWrapper"
            }).append(settings.centerImagesVertically ? $("<span>", {
                class: "vertical-centre-helper"
            }) : "", this.$thumb));
            return this.$thumb;
        },
        addClass: function (classString) {
            this.$elem.addClass(classString);
            return this.$elem;
        },
        removeClass: function (classString) {
            this.$elem.removeClass(classString);
            return this.$elem;
        },
        getElement: function () {
            return this.$elem;
        },
        addProgressBar: function () {
            this.$progressBarContainer = $("<div>", {
                class: 'fu-prog-bar-container',
            });
            this.$progressBar = $("<div>", {
                class: 'fu-progress-bar',
            });
            this.$elem.append(this.$progressBarContainer.append(this.$progressBar));
        },
        updateProgress: function (loaded, total) {
            var percent = Math.floor(loaded / total * 100);
            this.$progressBar.width(percent + '%');
            if (settings.showUploadProgressPecentage) {
                this.$progressBar.html(percent + '%');
            }
            //>>>>>>>>>>>>>>>>>>Chnage to animate with if(progress == 100)
        },
        removeProgressBar: function () {
            this.$progressBarContainer.remove();
            this.$elem.addClass("loading");
            this.$progressBarContainer = null;
            this.$progressBar = null;
        },
        destroy: function () {
            delete cache[this.id];
            this.$elem.remove();
            delete this;
        }
    }





    function fuResolveCollision($newItem, file, message, infoData) {
        var $comparisonTable, newThumbSrc;
        var reader = new FileReader();
        reader.readAsDataURL(file); // Process file; onload event trigerred once complete
        $newItem.removeClass("js_itemInfo").addClass("js_fu_itemWithError").click(onErrorItemClick);


        reader.onloadend = function (e) { // Once filereader has processed the image
            newThumbSrc = e.target.result;
            $newItem.attachThumb(newThumbSrc).on("load", onThumbLoad);
        };

        function onThumbLoad() {
            // Create comparison table. Onload listener required to capture width and height of the thumb.
            $comparisonTable = "<table class='js_fu_comparison'><tr><th colspan='3'><span class='left'>New</span><span class='right'>Existing</span></th></tr><tr><td colspan='3'><img class='left' draggable='false' src='" + newThumbSrc + "' alt='new'><img class='right' draggable='false' src='" + infoData.thumb + "' alt='exisitng'></td></tr><tr><td>" + file.name.substr(0, file.name.lastIndexOf('.')) + "</td><th>Title</th><td>" + infoData.title + "</td></tr><tr><td>" + fuConvertSize(file.size) + "</td><th>Size</th><td>" + fuConvertSize(infoData.size) + "</td></tr><tr><td>" + this.naturalWidth + "px</td><th>Width</th><td>" + infoData.width + "px</td></tr><tr><td>" + this.naturalHeight + "px</td><th>Height</th><td>" + infoData.height + "px</td></tr><tr><td>" + convertDate(file.lastModifiedDate) + "</td><th>Modified</th><td>" + infoData.dateCreated + "<br>" + infoData.timeCreated + "</td></tr></table>";
            this.removeEventListener("load", onThumbLoad);
        }


        function onErrorItemClick() {
            clearSelection();
            addBtnClickHandlers();
            $itemDatails = $("<div>", {
                class: "js_fu_itemDetails"
            }).append($comparisonTable, $("<div>", {
                id: "js_fu_errorOptionsBox"
            }).append($replaceBtn, $keepBtn, $cancelBtn));

            $detailContainer.append($itemDatails);
            fuShowMessage(1, message);
            return false;
        }





        //===================* BUTTONS *====================//
        var $replaceBtn = $("<button>", {
            text: "Replace"
        });

        var $keepBtn = $("<button>", {
            text: "Keep Both"
        });

        var $cancelBtn = $("<button>", {
            text: "Cancel"
        });




        //===================* AJAX CALLBACKS *====================//

        /**
         * This is a callback function wich is executed after AJAX receives server responce. 
         * @param {json} json - data returned by the server including responce code, 
         * id of the newly uploaded item and thumbnail url for it. 
         */
        function replaceCallback(json) {
            switch (json.code) {
                case 100:
                case 852:
                    removeItemInfo();
                    fuShowMessage(0, settings.textFileReplaced); // Show response message
                    // Remove error item
                    $newItem.getElement().off("click", onErrorItemClick).fadeOut(function () {
                        $newItem.destroy();
                        $newItem = null;
                    });
                    // Replace image on the pane
                    $itemsContainer.find("[data-did='" + infoData.id + "']").find("img").attr("src", newThumbSrc);
                    break;
                default:
                    fuShowMessage(1, settings.textFileNotReplaced);
                    console.error(json.msg);
            }
        }


        /**
         * This is a callback function wich is executed after AJAX receives server responce. 
         * @param {json} json - data returned by the server including responce code, 
         * id of the newly uploaded item and thumbnail url for it. 
         */
        function keepCallback(json) {
            switch (json.code) {
                case 100:
                    removeItemInfo();
                    fuShowMessage(0, settings.textFileSaved);
                    $newItem.attachData(json.data).getElement().off("click", onErrorItemClick).removeClass("js_fu_itemWithError").addClass("js_itemInfo");
                    break;
                default:
                    fuShowMessage(1, settings.textFileNotSaved);
                    console.error(json.msg);
            }
        }


        //===================* HELPER FUNCTIONS *====================//
        function convertDate(date) { // Converts date to readable format
            var d = date.getUTCDate();
            var m = date.getUTCMonth();
            var y = date.getFullYear();
            var h = date.getHours();
            var mi = date.getMinutes();
            var s = date.getSeconds();
            return y + "-" + ((m.toString().length < 2) ? "0" + m : m) + "-" + ((d.toString().length < 2) ? "0" + d : d) + "<br>" + ((h.toString().length < 2) ? "0" + h : h) + ":" + ((mi.toString().length < 2) ? "0" + mi : mi) + ":" + ((s.toString().length < 2) ? "0" + s : s);
        }

        function addBtnClickHandlers() {
            $replaceBtn.on("click", onReplaceClick);
            $keepBtn.on("click", onKeepBothClick);
            $cancelBtn.on("click", onCancelClick);
        }

        function removeBtnClickHandlers() {
            $replaceBtn.off("click", onReplaceClick);
            $keepBtn.off("click", onKeepBothClick);
            $cancelBtn.off("click", onCancelClick);
        }


        //===================* BUTTON CLICK HANDLERS *====================//
        function onReplaceClick() {
            removeBtnClickHandlers();
            var fd = new FormData();
            fd.append("file", file);
            fd.append("action", "override");
            fuAJAX("POST", fd, replaceCallback, $newItem, true, false);
        }

        function onKeepBothClick() {
            removeBtnClickHandlers();
            var fd = new FormData();
            fd.append("file", file);
            fd.append("action", "keep");
            fuAJAX("POST", fd, keepCallback, $newItem, true, false);
            //                        fuAJAX_keepFile(file, tmpImage, infoData.id);
        }

        function onCancelClick() {
            removeBtnClickHandlers();
            $newItem.getElement().off("click", onErrorItemClick).fadeOut(function () {
                $newItem.destroy();
                $newItem = null;
                removeItemInfo();
            });
        }

    }




    /**
     * AJAX function for interactions with server.  
     * @param {string} method - either POST or GET. 
     * @param {FormData/Array} data - data that has to be send to server. 
     * @param {function} callback - a function which gets executed in case of positive response from server.
     * Responce data receved from the server passed as a 'response' {json} parameter to the callback function.
     * @param {Item} $newItem - object generated by Item constructor. 
     * $newItem gets passed over to the callback function for farther manipulations. 
     * @param {boolean} upload - set this to true if uplading something to server. 
     * @param {boolean} progbar - upload progress bar.
     * 
     */
    function fuAJAX(method, data, callback, $newItem, upload, progbar) {
        $.ajax({
            url: settings.serverURL,
            //  cache: false,
            type: method,
            data: data,
            processData: upload ? false : true,
            contentType: upload ? false : "application/x-www-form-urlencoded; charset=UTF-8",
            xhr: progbar ? function () {
                // Progress bar
                var xhr = $.ajaxSettings.xhr();
                $newItem.addProgressBar();
                xhr.upload.addEventListener('progress', onXHRProgress, false);
                xhr.upload.addEventListener('load', onXHRLoad, false);
                return xhr;
            } : $.ajaxSettings.xhr,
            complete: function (serverResponse) {
                if (callback) {
                    try {
                        callback(JSON.parse(serverResponse.responseText), $newItem);
                    } catch (error) {
                        console.log(error + "\n\nServer Message: " + serverResponse);
                    }
                }
            },
        });

        function onXHRProgress(e) {
            if (e.lengthComputable) {
                $newItem.updateProgress(e.loaded, e.total);
            }
        }

        function onXHRLoad(e) {
            this.removeEventListener('progress', onXHRProgress, false);
            this.removeEventListener('load', onXHRLoad, false);
        }
    }


    /**
     * Removes files as well as associated database entries.
     * @param {string} tableName - database table name. 
     * @param {array} ids - an array of element ids. 
     */
    function deleteFiles(tableName, ids) {
        var i = 0;
        var l = ids.length;
        fuAJAX("GET", {
            action: "delete",
            tableName: tableName,
            id: ids,
        }, echo);
        for (i; i < l; i++) {
            $itemsContainer.find("[data-did='" + ids[i] + "']").fadeOut(function () {
                this.remove();
                if (!$itemsContainer.find(".js_fu_item").length) {
                    displayNoItemsMsg();
                }
            });
        }

    }


    ///////////////////////////////////////////////////////////////////////
    ////////////////OBJECT EXTENSION///////OBJECT EXTENSION////////////////
    ///////////////////////////////////////////////////////////////////////


    //If not initialising plugin on DOM element set noCallerElement = true option. 
    $.fn.js_fm = function (options) {
        if (!fmInitiated) { // Check if file uploader initiated
            settings = $.extend({}, defaults, options);
            init(); // Settings are set only once per page
        }
        if (!options.noCallerElement) { // if there is a DOM element to initialise plugin to
            var $callerElement = $(this);
            $listOfCallerElements.push($callerElement); // save this element to the list to remove .data and listener upon FM destruction
            if (!$callerElement.data("fmInitiated")) { // If caller DOM element is not initiated yet
                $callerElement.on("click", function (e) {
                    e.stopPropagation();
                    $Fm.open(options.mode ? options.mode : FM_MODE_GALLERY, $callerElement);
                    return false;
                });
                $callerElement.data("fmInitiated", true);
            }
        }
        return $Fm;
    };


    ///////////////////////////////////////////////////////////////////////
    /////////////////////////MISC/////////////////MISC/////////////////////
    ///////////////////////////////////////////////////////////////////////


    function fuConvertSize(bytes) {
        if (bytes === 0) {
            return '0 Bytes';
        }
        var sizes = ['Bytes', 'Kb', 'Mb', 'Gb', 'Tb'];
        var i = parseInt(Math.floor(Math.log(bytes) / Math.log(1024)));
        return (bytes / Math.pow(1024, i)).toFixed(2) + ' ' + sizes[i];
    }


    $.fn.onImgLoad = function (callback) {
        return this.each(function () {
            if (callback) {
                if (this.complete || /*for IE 10-*/ $(this).height() > 0) {
                    callback.apply(this);
                } else {
                    $(this).on('load', function () {
                        callback.apply(this);
                    });
                }
            }
        });
    };


    function sizeOfObject(object) {

        var objectList = [];
        var stack = [object];
        var bytes = 0;

        while (stack.length) {
            var value = stack.pop();

            if (typeof value === 'boolean') {
                bytes += 4;
            } else if (typeof value === 'string') {
                bytes += value.length * 2;
            } else if (typeof value === 'number') {
                bytes += 8;
            } else if (
                typeof value === 'object' &&
                objectList.indexOf(value) === -1
            ) {
                objectList.push(value);

                for (var i in value) {
                    stack.push(value[i]);
                }
            }
        }
        return fuConvertSize(bytes);
    }




    function echo(text) {
        console.log(text);
    }

    function echoo(JSON) {
        //        console.log("<pre>"+ JSON.stringify(JSON) +"</pre>");
        console.dir(JSON);
    }

})(jQuery);
