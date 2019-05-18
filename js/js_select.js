;
(function ($, undefined) { // Unonymous function to protect $

    function js_select_init(selects) {
        var i = 0;
        var l = selects.length;
        for (i; i < l; i++) {
            init(selects[i]);
        }

        function init(defaultSelect) {
            defaultSelect.style.display = "none";
            var defaultOptons = defaultSelect.getElementsByTagName("option");
            ///*CREATING NEW SELECT*///
            var $newSelect = $(document.createElement("div")).addClass("js_select").text(defaultOptons[0].text);

            ///*CREATING WRAPPER DIV*///
            var $wrapper = $(document.createElement("div")).addClass("js_select_wrapper");

            ///*CREATING NEW OPTIONS*///
            var $optionsList = $(document.createElement("div")).addClass("js_select_list").hide();

            ///*ADDING CLICK HANDLERS*///
            $optionsList.on("click", ".js_select_option", handleOptionClick($newSelect, $optionsList, defaultSelect));
            $newSelect.click(handleSelectClick($newSelect, $optionsList, $wrapper));

            ///*COPYING OPTIONS OVER*///
            var i = 0;
            var l = defaultOptons.length;
            for (i; i < l; i++) {
                $(document.createElement("div")).addClass("js_select_option").html(defaultOptons[i].innerHTML).attr("value", defaultOptons[i].value).appendTo($optionsList);
            }
            l > 6 && $optionsList.addClass("js_select_list_scrollable");

            $(defaultSelect).after($wrapper.append($newSelect, $optionsList)).data("js_select_initiated", true);
        }

        function handleSelectClick($newSelect, $optionsList, $wrapper) {
            return function () {
                $optionsList.slideToggle("fast");
                $newSelect.toggleClass("js_select_oppened");

                // On click outside
                if ($newSelect.hasClass("js_select_oppened")) {
                    $wrapper.onClickOutside(function () {
                        $optionsList.slideUp("fast");
                        $newSelect.removeClass("js_select_oppened");
                    });
                }
                return false;
            };
        }

        function handleOptionClick($newSelect, $optionsList, defaultSelect) {
            return function () {
                //Set ne value
                defaultSelect.value = this.getAttribute("value");
                //Triger change event on original select element
                defaultSelect.dispatchEvent(new Event("change")); // Dispatch it.
                //Do other stuff
                $newSelect.removeClass("js_select_oppened").html(this.innerHTML);
                $optionsList.slideUp("fast");
                return false;
            };
        }
    }


    $(function () { // Document ready 
        js_select_init(document.getElementsByTagName("select"));
    });

    $.fn.js_select = function () {
        if (this.data("js_select_initiated")) {
            console.warn("Js Select already initiated");
        } else {
            js_select_init(this);
        }
    };

    $.fn.onClickOutside = function (callback) {
        var $element = $(this);
        $(document).on("mouseup.outsideClick", function (e) {
            if (!$element.is(e.target) && $element.has(e.target).length === 0) {
                callback();
            }
            $(document).off(".outsideClick");
        });
        return $element;
    };

})(jQuery);
