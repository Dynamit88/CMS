/*
 * Template Editor
 * @Author: Ivan Mykolenko
 * @Date: 28.01.2019
 */


/*
1)Full width block
2)Columns
3)Tabs
4)Accordion)


Sub:
 i)text
 ii)image
 iii)video
 iv)js_loader

*/




;
(function ($, undefined) { // Anonymous function to protect $
    ////////////////////SETTINGS/////////////////////
    var settings;
    ///////////////FUNCTIONAL VARS///////////////////

    var $Te; // Instace of our plugin


    var $Fm; // Instance of File Manager plugin
    var teInitiated = false; // Flag to indicate that plugin has been initialised
    var initiationElement; // DOM element on which plugin is initiated
    var $initiationElement; // DOM JQ element on which plugin is initiated
    var blockObjects = {}; // Object of blocks
    var blockID = 0; // Counter to assign unique ids to blocks
    var currentItemId; //DB id of template currently loaded in
    var currentItemId; //DB id of an item currently loaded in
    ///////////////VISUAL ELEMENTS///////////////////
    var $cmsMenu; // CMS menu bar
    var $saveBtn; // Btn to save work
    var $viewBtn; // Btn to view page
    var blocksPane; // Construction blocks container
    var $blocksPane // Construction blocks container JQ
    var $menu; //Main blocks menu


    var defaults = { // Default settings 
        mode: 1, //1 - template and contnet edditing, 2 - template editing, 3 - content population    
        serverURL: "functions.php",
        textBtnAddBlock: "Add New Block +",
        textBtnSave: "Save",
        textBtnSaved: "Saved",
        textBtnGView: "Generate & View",
        textBtnView: "View Page",
        trubowyg: {
            lang: 'fr',
            removeformatPasted: true, //If you don't want styles pasted from clipboard (from Word or other webpage for example)
            tagsToRemove: ['script'], //Sanitize the code
            imageWidthModalEdit: true, //Allow users to set the image width
        }
    }




    ///////////////////////////////////////////////////////////////////////
    ///////////////////////INITIATION///////INITIATION/////////////////////
    ///////////////////////////////////////////////////////////////////////

    /**
     * Initiator for the plugin
     * @param {DOM} initElement - an element of DOM for the plugin to be initialised on
     */
    function init($initElement) {
        $initiationElement = $initElement; //JQ
        initiationElement = $initElement[0]; //JS
        //Construction blocks container
        blocksPane = document.createElement("DIV");
        blocksPane.id = "js_te_blocksPane";
        $blocksPane = $(blocksPane); //JQ

        //Find CMS menu
        $cmsMenu = $("#cms-menu");

        $saveBtn = $("<button/>", {
            id: "js_te_saveBtn",
            text: settings.textBtnSave,
            click: onSaveBtnClick
        });
        $viewBtn = $("<button/>", {
            id: "js_te_viewBtn",
            text: settings.textBtnGView,
            click: onViewBtnClick
        });


        $cmsMenu.append($saveBtn, $viewBtn);

        //Create layout menu
        $menu = $("<div/>", {
            id: "js_te_menu"
        }).append($("<ul/>").append("<li id='js_te_fwbBtn' data-type='1'></li><li id='js_te_colBtn' data-type='2'></li><li id='js_te_tabBtn' data-type='3'></li><li id='js_te_accBtn' data-type='4'></li>"), "<span>" + settings.textBtnAddBlock + "<span>").on("click", "li", onBlocksMenuClick);


        // Drag sort Dragula
        if (typeof dragula() === "object") {
            dragula([blocksPane], {
                invalid: function (el, handle) {
                    return el.classList.contains('js_te_blockInnerContainer'); // don't allow draggin block toolbar
                }
            });
        }
        // File manager plugin
        $Fm = $.fn.js_fm({
            noCallerElement: true,
            fireEvent: true
        });


        $Te = {
            loadItem: function (itemId) { //Display contents on associated template
                currentItemId = itemId;
                AJAX("GET", {
                    action: "getItem",
                    id: itemId,
                }, onItemLoadCallback);
                return this;
            },
            loadThis: function (item) { //Load tempate/contents directly
                if (typeof item === 'string' || item instanceof String) {
                    onItemLoadCallback(JSON.parse(item));
                } else {
                    onItemLoadCallback(item);
                }
                //                echo (item);
            }
        }

        //Attach delegated listeners
        $blocksPane.on("click", ".js_te_btn_rmblock", onBtnDeleteBlockClick).on("click", ".js_te_btn_blockSettings", onBtnSettingsClick);

        //Append menu and add blocks delete button listener
        $initiationElement.append($blocksPane, $menu);
        teInitiated = true; // Set initiation flag
    }



    ///////////////////////////////////////////////////////////////////////
    ////////////////ACTION HANDLERS///////ACTION HANDLERS//////////////////
    ///////////////////////////////////////////////////////////////////////


    function onViewBtnClick() {
        AJAX("GET", {
            action: "generatePage",
            id: currentItemId,
        }, function (json) {
            openInNewTab(json.data);
        });

    }




    function onItemLoadCallback(json) {
        var blocks = json.data.template;
        var contents = json.data.content;
        //        blockID = json.data.blockIdCounter; //Update counter of unique block ids
        var i = 0,
            l = blocks.length;


        for (i; i < l; i++) { //Through every block in template
            switch (blocks[i].type) { //Create block
                case "fwb": // Full Width Block
                    blockObjects[blockID] = new FWB(false);
                    break;
                case "col": //Columns
                    break;

            }


            //            Populate content
            switch (blocks[i].subtype) {
                case "wysiwyg": // Text
                    makeTextBlock(blockObjects[blockID], contents[blocks[i].blockId]);
                    break;
                case "img": // Image
                    makeImageBlock(blockObjects[blockID], contents[blocks[i].blockId]);
                    break;
                case "vid": // Video
                    break;
                case "loader": // js_loader
                    break;
            }
            blockID++;
        }
    }




    //    js_template_editor.js: 455 {
    //        "code": 100,
    //        "data": {
    //            "id": "6",
    //            "name": "Lollipop candy",
    //            "category": "4",
    //            "content": {
    //                "1": {
    //                    "id": "1034",
    //                    "fullName": "88923_14big.jpg",
    //                    "name": "88923_14big",
    //                    "title": "88923_14big",
    //                    "format": "jpg",
    //                    "size": "168671",
    //                    "width": "1024",
    //                    "height": "683",
    //                    "type": "images",
    //                    "alt": "",
    //                    "src": "medias\/images\/88923_14big.jpg",
    //                    "thumb": "medias\/images\/thumb\/88923_14big(thumb).jpg",
    //                    "medium": "medias\/images\/medium\/88923_14big(medium).jpg",
    //                    "large": "medias\/images\/large\/88923_14big(large).jpg",
    //                    "description": "",
    //                    "dateCreated": "2019-02-20",
    //                    "timeCreated": "21:05:16"
    //                }
    //            },
    //            "template": [{
    //                "blockId": "0",
    //                "type": "fwb",
    //                "subtype": "wysiwyg",
    //                "options": ""
    //            }, {
    //                "blockId": "1",
    //                "type": "fwb",
    //                "subtype": "img",
    //                "options": ""
    //            }],
    //            "authorId": "1",
    //            "groupId": "5",
    //            "version": "1",
    //            "blockIdCounter": "3",
    //            "dateCreated": "2019-03-04",
    //            "timeCreated": "28:12:00",
    //            "dateModified": "2019-03-14",
    //            "timeModified": "29:09:00"
    //        }
    //    }



    






    function onSaveBtnClick() {


        //        echo (JSON.stringify(exportPageData()["content"]));
        AJAX("POST", {
            action: "saveItem",
            id: currentItemId,
            blockIdCounter: blockID, //Store ID counter to DB
            data: exportPageData()
        }, onSaveCallback);
    }


    /**
     * Prepare array with page template and contents to the DB
     * @param {boolean} doMenu - attach inner menu (true by default)
     */
    function exportPageData() {
        var blocks = blocksPane.getElementsByClassName("js_te_block");
        var i = 0,
            l = blocks.length;
        var blocksArray = [];
        var contentsJSON = {};

        for (i; i < l; i++) {
            var id = blocks[i].getAttribute("data-id");
            if (blockObjects[id].subtype) { //If block has been given a subtype e.g image, text(it is not empty)

                //SAVE TEMPLATE
                var tmp = {};
                tmp.blockId = blockObjects[id].id;
                tmp.type = blockObjects[id].type;
                tmp.subtype = blockObjects[id].subtype;
                tmp.options = blockObjects[id].options; //stores all the styles
                blocksArray.push(tmp);

                //SAVE CONTENTS
                switch (blockObjects[id].subtype) {
                    case "wysiwyg":
                        var wysiwygContent = blockObjects[id].$innerContainer.trumbowyg("html");
                        if (wysiwygContent && wysiwygContent !== " ") {
                            contentsJSON[id] = wysiwygContent; //Save content to associated id
                        }
                        break;
                    case "img":
                        contentsJSON[id] = blockObjects[id].itemData;
                        break;
                }


            }
        }
        return {
            template: blocksArray,
            content: contentsJSON
        };
    }


    function onBtnDeleteBlockClick() {
        var id = this.getAttribute("data-id"),
            i = 0;
        //Call block's close function to destroy any plugins
        blockObjects[id].$elem.fadeOut(function () {
            this.remove();
        });
        blockObjects[id].destroy();
        //Delete DOM element
        delete blockObjects[id]; //Remove JSON object
    }





    function onSaveCallback(json) {
        $saveBtn.off("click", onSaveBtnClick).addClass("js_te_saved").text(settings.textBtnSaved);
        setTimeout(function () {
            $saveBtn.on("click", onSaveBtnClick).removeClass("js_te_saved").text(settings.textBtnSave);
        }, 1300);
    }


    function AJAX(method, data, callback) {
        $.ajax({
            url: settings.serverURL,
            type: method,
            data: data,
            success: function (message) {
                var json = null;
                try {
                    json = JSON.parse(message);
                } catch (error) {
                    console.log(error + "\n\nServer Message: " + message);
                }
                if (json && json.code == 100) {
                    callback && callback(json);
                }
            }
            //                        ,
            //                        complete: function (message) {
            //                            echo(message.responseText);
            //                        }
        });
    }





    var onBlocksMenuClick = function () {
        var type = this.getAttribute("data-type");
        switch (type) {
            case "1":
                blockObjects[blockID] = new FWB();
                break;
            case "2":
                break;
            case "3":
                break;
            case "4":
                break;
        }
        blockID++;
    }

    /**
     * Constructor for the full width blocks
     * @param {boolean} doMenu - attach inner menu (true by default)
     */
    function FWB(doMenu) {
        if (doMenu === undefined) {
            doMenu = true;
        }
        var $that = this;
        this.id = blockID;
        this.type = "fwb";
        this.subtype = null;
        this.content = null; //Content (text, image, etc...)
        this.options = null; //Block's options (styles e.g. width, height, colors)
        this.$elem = $("<div/>", {
            class: "js_te_fwb js_te_block",
            "data-id": blockID
        });
        this.$innerContainer = $("<div/>", {
            class: "js_te_blockInnerContainer"
        });

        this.toolBar = $("<div/>", {
            class: "js_te_block_toolbar"
        }).append("<button class='js_te_toolbarBtn js_te_btn_rmblock' data-id='" + this.id + "'></button><button class='js_te_toolbarBtn js_te_btn_blockSettings' data-id='" + this.id + "'></button>");

        if (doMenu) {
            this.$menu = $("<ul/>", {
                class: "js_te_innerMenu"
            }).append("<li class='js_te_txtBtn' data-type='1'></li><li class='js_te_imgBtn' data-type='2'></li><li class='js_te_videoBtn' data-type='3'></li><li class='js_te_loaderBtn' data-type='4'></li>").on("click", "li", function () {
                onInnerMenuClick($that, this)
            });

            //Function to empty block once it is initialized to some plugin
            this.removeInnerMenu = function () {
                if (this.$menu) {
                    this.$menu.off("click", "li").remove();
                    this.$menu = null;
                }
            }


        }

        //Function to be defined once block has been initialised to some plugin (e.g. Wysiwyg plugin).
        // If initialised, this function will be called as part of destroy function. 
        this.destroyPlugins = null;
        this.destroy = function () {
            if (doMenu) {
                this.removeInnerMenu();
            }
            this.destroyPlugins && this.destroyPlugins(); //If any plugins to be destroyed
            this.$elem.fadeOut(function () {
                this.remove();
            });

            (function ($this) {
                $that = null;
            })(this);
        };
        $blocksPane.append(this.$elem.hide().append(this.toolBar, this.$innerContainer.append(this.$menu)));
        this.$elem.slideDown();
    }



    function onInnerMenuClick(block, subMenuItem) {
        block.removeInnerMenu();
        switch (subMenuItem.getAttribute("data-type")) {
            case "1": // Text
                makeTextBlock(block);
                break;
            case "2": // Image
                makeImageBlock(block);
                break;
            case "3": // Video
                break;
            case "4": // js_loader
                break;
        }

    }




    function makeTextBlock(block, content) {
        block.$elem.addClass("no_min_height bgrnd_white");
        block.$innerContainer.addClass("js_te_wysiwygContainer js_te_resizableY").trumbowyg(settings.trubowyg); // Init wysiwyg editor with options
        block.subtype = "wysiwyg"; //Set block's subtype
        //Update block's object destroy function to destroy wysiwyg plugin
        block.destroyPlugins = function () {
            block.$innerContainer.trumbowyg("destroy");
        }
        if (content) {
            block.$innerContainer.trumbowyg("html", content);
        }
    }

    function makeImageBlock(block, content) {
        block.$innerContainer.js_fm({
            mode: 2
        });
        block.subtype = "img"; //Set block's subtype
        block.$innerContainer[0].addEventListener("js_fu_done", function (e) {
            block.itemData = $Fm.getSelected();
            block.$innerContainer.empty().append("<img class='js_te_image' alt='" + block.itemData.alt + "' src='" + block.itemData.medium + "'/>");
        }, false);
        if (content) {
            block.itemData = content;
            block.$innerContainer.empty().append("<img class='js_te_image' alt='" + content.alt + "' src='" + content.medium + "'/>");
        }
    }


    function onBtnSettingsClick() {
        var id = this.getAttribute("data-id");
        if (!blockObjects[id].settingsOpened) {
            var imageQuality = "<section class='js_te_radioBtns'><label><input name='quality' type='radio'/><span>Thumb</span></label><label><input name='quality' type='radio' checked/><span>Medium</span></label><label><input name='quality' type='radio'/><span>High</span></label><label><input name='quality' type='radio'/><span>Original</span></label></section>";
            var imageHeight = "<section class='js_te_textInp'><label><input name='height' type='text'/><span>Height</span></label></section>";
            var imageWidth = "<section class='js_te_textInp'><label><input name='width' type='text'/><span>Width</span></label></section>";
            blockObjects[id].$elem.append("<div class='js_te_settingsOverlay'>" + imageQuality + imageHeight + imageWidth + "</div>");
            blockObjects[id].settingsOpened = true;
        }
    }









    $.fn.js_te = function (options) {
        if (!teInitiated) { // Check if editor is initiated
            if (this !== null && typeof this !== "undefined" && this.length !== 0) {
                settings = $.extend({}, defaults, options); // Settings are set only once per page
                init($(this));
            }
        } else {
            console.warn("Already initiated!");
        }
        return $Te;
    }


    function echo(txt) {
        console.log(txt);
    }


    /**
     * Not used
     */
    function reverse(a) {
        var tmp = [],
            i = 0,
            al = a.length,
            j = al - 1;
        while (i < al) {
            tmp[i] = a[j];
            i++;
            j--;
        }
        return (tmp);
    }
    //============HELPERS==========//
    /**
     * This functions assings a class to an elementen and removes it after 2 seconds. 
     * @param {DOM} $element - element to assign class to. 
     * @param {string} classText - class. 
     */
    function tmpClass($element, classText) {
        $element.addClass(classText);
        setTimeout(function () {
            $element.removeClass(classText);
        }, 2000);
    }


    function openInNewTab(url) {
        var win = window.open(url, '_blank');
        win.focus();
    }
})(jQuery);
