/**
* Created by Mauriel on 2/9/2016.
*/

function onRoleSelect(event) {
    var el = $(event.target);
    $("#selected_role").text(el.text());
    $("#selected_role")[0].setAttribute("data-role", el[0].getAttribute("data-role"));
}

function onRowRemove(event) {
    var el = $(event.target);
    var pk = el[0].getAttribute("data-pk");
    el.closest("tr").remove();
    var form = $(event.target).closest("form");
    form.submit();
}

// Toggles pointer events on and off for the access control interface
function setPointerEvents(flag) {
    if (!flag) {
        // Disable pointer events
        $(".access-table").css("pointer-events", "none");
        $("#manage-access .modal-content").css("pointer-events", "none");
    }
    else {
        // Enable pointer events
        $(".access-table").css("pointer-events", "auto");
        $("#manage-access .modal-content").css("pointer-events", "auto");
    }
}

// Enables and disables granting access buttons accordingly to the current access level
function updateActionsState(privilege){
    // Set the state of dropdown menu items and remove buttons to false by default
    $("form[data-access-type]").parent().addClass("disabled");
    $("#list-roles a[data-role]").parent().addClass("disabled");
    $(".access-table li.active[data-access-type]").closest("tr").addClass("hide-actions");

    if (privilege == "view") {
        // Dropdown menu items
        $("form[data-access-type='Can view']").parent().removeClass("disabled");
        $("#list-roles a[data-role='view']").parent().removeClass("disabled");

        // Remove buttons
        $(".access-table li.active[data-access-type='Can view']").closest("tr").removeClass("hide-actions");
    }
    else if(privilege == "change") {
        // Dropdown menu items
        $("form[data-access-type='Can view']").parent().removeClass("disabled");
        $("#list-roles a[data-role='view']").parent().removeClass("disabled");

        $("form[data-access-type='Can edit']").parent().removeClass("disabled");
        $("#list-roles a[data-role='edit']").parent().removeClass("disabled");

        // Remove buttons
        $(".access-table li.active[data-access-type='Can view']").closest("tr").removeClass("hide-actions");
        $(".access-table li.active[data-access-type='Can edit']").closest("tr").removeClass("hide-actions");
    }
    else if(privilege == "owner") {
        // Dropdown menu items
        $("form[data-access-type='Can view']").parent().removeClass("disabled");
        $("#list-roles a[data-role='view']").parent().removeClass("disabled");

        $("form[data-access-type='Can edit']").parent().removeClass("disabled");
        $("#list-roles a[data-role='edit']").parent().removeClass("disabled");

        $("form[data-access-type='Is owner']").parent().removeClass("disabled");
        $("#list-roles a[data-role='owner']").parent().removeClass("disabled");

        // Remove buttons
        $(".access-table li.active[data-access-type='Can view']").closest("tr").removeClass("hide-actions");
        $(".access-table li.active[data-access-type='Can edit']").closest("tr").removeClass("hide-actions");
        if ($(".access-table li.active[data-access-type='Is owner']").length > 1) {     // At least one owner constrain
            $(".access-table li.active[data-access-type='Is owner']").closest("tr").removeClass("hide-actions");
        }
    }
}

function onRemoveKeyword(event) {
    $($(this).closest(".tags").parent().find(".btn-primary")[0]).show();    // Show save button
    $(event.target).closest(".tag").remove();
    updateKeywords();
    return false;
}

function onAddKeyword(event) {
    var keyword = $("#txt-keyword").val();
    keyword = keyword.split(",");

    for (var i = 0; i < keyword.length; i++) {
        keyword[i] = keyword[i].trim(); // Remove leading and trailing whitespace
        var exists = false;
        // Check if the keyword already exists
        for (var x = 0; x < $("#lst-tags").find(".tag > span").length; x++) {
            if ($($("#lst-tags").find(".tag > span")[x]).text() == keyword[i]) {
                exists = true;
            }
        }

        // If does not exist, add it
        if (!exists && keyword[i] != "") {
            var li = $("<li class='tag'><span></span></li>");
            li.find('span').text(keyword[i]);
            li.append('&nbsp;<a><span class="glyphicon glyphicon-remove-circle icon-remove"></span></a>')
            $("#lst-tags").append(li);

            $(".icon-remove").click(onRemoveKeyword);
            $(this).closest("form-control").find("button").show();
            updateKeywords();
        }
    }

    $("#txt-keyword").val("");  // Clear text input
    return false;
}

function updateKeywords() {
    var keywords = "";
    var count = $("#lst-tags").find(".tag > span").length;
    for (var x = 0; x < count; x++) {
        keywords += $($("#lst-tags").find(".tag > span")[x]).text();
        if (x != count - 1) {
            keywords += ",";
        }
    }

    $("#id-subject").find("#id_value").val(keywords);
}

function customAlert(msg, duration) {
    var el = document.createElement("div");
    var top = 200;
    var left = ($(window).width() / 2) - 150;
    var style = "top:" + top + "px;left:" + left + "px";
    el.setAttribute("style", style);
    el.setAttribute("class", "custom-alert");
    el.innerHTML = msg;
    setTimeout(function () {
        $(el).fadeOut(300, function () {
            $(this).remove();
        });
    }, duration);
    document.body.appendChild(el);
    $(el).hide().fadeIn(400);
}

$(document).ready(function () {
    // On manage access interface, prevent form submission when pressing the enter key on the search box.
    $('#id_user-autocomplete').keypress(function (e) {
        e = e || event;
        var txtArea = /textarea/i.test((e.target || e.srcElement).tagName);
        return txtArea || (e.keyCode || e.which || e.charCode || 0) !== 13;
    });

    $("#citation-text").on("click", function (e) {
        // document.selection logic is added in for IE 8 and lower
        if (document.selection) {
            document.selection.empty();
            var range = document.body.createTextRange();
            range.moveToElementText(this);
            range.select();
        }
        else if (window.getSelection) {
            // Get the selection object
            var selection = window.getSelection();
            selection.removeAllRanges();
            var range = document.createRange();
            range.selectNode(this);
            selection.addRange(range);
        }
    });

    $("#btn-shareable").on("change", shareable_ajax_submit);
    $("#btnMyResources").click(label_ajax_submit);
    $("#coverageTabBtn").click(function () {
        setTimeout( function(){
            // Call resize to re-render the map since it wasn't visible during load.
            google.maps.event.trigger(coverageMap, "resize");
            // This field is populated if the page is in view mode
            var shapeType = $("#coverageMap")[0].getAttribute("data-shape-type");
            // Center the map
            if (shapeType) {
                deleteAllShapes();
                if (shapeType == "point") {
                    var myLatLng = {
                        lat: parseFloat($("#cov_north").text()),
                        lng: parseFloat($("#cov_east").text())
                    };
                    if (!myLatLng.lat || !myLatLng.lng) {
                        return;
                    }
                    // Define the rectangle and set its editable property to true.
                    var marker = new google.maps.Marker({
                        position: myLatLng,
                        map: coverageMap
                    });
                    allShapes.push(marker);
                    // Center map at new market
                    coverageMap.setCenter(marker.getPosition());
                    $("#resetZoomBtn").click(function () {
                        coverageMap.setCenter(marker.getPosition());
                    });
                }
                else if (shapeType == "box") {
                    var bounds = {
                        north: parseFloat($("#cov_northlimit").text()),
                        south: parseFloat($("#cov_southlimit").text()),
                        east: parseFloat($("#cov_eastlimit").text()),
                        west: parseFloat($("#cov_westlimit").text())
                    };
                    if (!bounds.north || !bounds.south || !bounds.east || !bounds.west) {
                        return;
                    }
                    // Define the rectangle and set its editable property to true.
                    var rectangle = new google.maps.Rectangle({
                        bounds: bounds,
                        editable: false,
                        draggable: false
                    });
                    rectangle.setMap(coverageMap);
                    allShapes.push(rectangle);
                    zoomCoverageMap(bounds);
                    $("#resetZoomBtn").click(function () {
                        zoomCoverageMap(bounds);
                    });
                }
            }
            else {
                if ($("#id_type_1").is(":checked")) {
                    drawRectangleOnTextChange();
                }
                else {
                    drawMarkerOnTextChange();
                }
            }
        }, 200 );   // Gives container enough time to be rendered before the map is rendered.
    });
    $("#id-coverage-spatial input:radio").change(function () {
        if ($(this).val() == "point") {
            $("#div_id_north").show();
            $("#div_id_east").show();
            $("#div_id_elevation").show();
            $("#div_id_northlimit").hide();
            $("#div_id_eastlimit").hide();
            $("#div_id_southlimit").hide();
            $("#div_id_westlimit").hide();
            $("#div_id_uplimit").hide();
            $("#div_id_downlimit").hide();
            drawMarkerOnTextChange();
            drawingManager.setDrawingMode(google.maps.drawing.OverlayType.MARKER);
        }
        else {
            $("#div_id_north").hide();
            $("#div_id_east").hide();
            $("#div_id_elevation").hide();
            $("#div_id_northlimit").show();
            $("#div_id_eastlimit").show();
            $("#div_id_southlimit").show();
            $("#div_id_westlimit").show();
            $("#div_id_uplimit").show();
            $("#div_id_downlimit").show();
            drawRectangleOnTextChange();
            drawingManager.setDrawingMode(google.maps.drawing.OverlayType.RECTANGLE);
        }
        // Show save changes button
        $("#coverage-spatial").find(".btn-primary").show();
    });
    if (sessionStorage.signininfo) {
        $("#sign-in-info").text(sessionStorage.signininfo);
        $("#btn-select-irods-file").show();
    }

    // Apply theme to comment's submit button
    $("#comment input[type='submit']").removeClass()
    $("#comment input[type='submit']").addClass("btn btn-default");

    $(".list-separator").parent().hover(function(){
        $(this).css("text-decoration", "none");
        $(this).css("pointer-events", "none");
    });

    var keywordString = "{% for k, v in subjects_form.initial.iteritems  %}{{ v }}{% endfor %}";
    $("#id-subject").find("#id_value").val(keywordString);

    // Populate keywords field
    var keywords = keywordString.split(",");
    $("#lst-tags").empty();
    for (var i = 0; i < keywords.length; i++) {
        if (keywords[i] != "") {
            var li = $("<li class='tag'><span></span></li>");
            li.find('span').text(keywords[i]);
            li.append('&nbsp;<a><span class="glyphicon glyphicon-remove-circle icon-remove"></span></a>')
            $("#lst-tags").append(li);
        }
    }

    $(".icon-remove").click(onRemoveKeyword);
    $("#btn-add-keyword").click(onAddKeyword);
    $("#txt-keyword").keyup(function (e) {
        e.which = e.which || e.keyCode;
        if (e.which == 13) {
            onAddKeyword();
        }
    });

    $("#list-roles a").click(onRoleSelect);
    $("#id_user-autocomplete").attr("placeholder", "Search by name or username")

    // hide add file button if necessary
    var file_count = $("#file-count").attr('value');
    //set allowed file types
    var file_types = $("#supported-file-types").attr('value');
    if (file_types != ".*") {
        var display_file_types = file_types.substring(0, file_types.length - 2) + ').';
        $("#file-types").text("Only the listed file types can be uploaded: " + display_file_types);
        $("#file-types-irods").text("Only the listed file types can be uploaded: " + display_file_types);
    }
    else {
        $("#file-types").text("Any file type can be uploaded.");
        $("#file-types-irods").text("Any file type can be uploaded.");
    }
    // set if multiple file can be uploaded
    var allow_multiple_file_upload = $("#allow-multiple-file-upload").attr('value');
    if (allow_multiple_file_upload === "True") {
        $("#file-multiple").text("Multiple file upload is allowed.");
        $("#file-multiple-irods").text("Multiple file upload is allowed.");
        $("#btn-add-file").attr('multiple', 'multiple');
        $("#add-file-input").attr('multiple', 'multiple');
    }
    else {
        $("#file-multiple").text("Only one file can be uploaded.");
        $("#file-multiple-irods").text("Only one file can be uploaded.");
        $("#btn-add-file").removeAttr('multiple');
        $("#add-file-input").removeAttr('multiple');
        if (file_count > 0) {
            $("#btn-add-file").hide();
            $("#log-into-irods").hide();
            $("#sign-in-info").hide();
            $("#btn-select-irods-file").hide();
        }
    }
    // hide add file button if file upload is not allowed for the resource type
    if (file_types == "()") {
        $("#btn-add-file").hide();
        $("#log-into-irods").hide();
        $("#sign-in-info").hide();
        $("#btn-select-irods-file").hide();
    }

    // file upload validation when file is selected for upload
    $('#add-file-input').on('change', function () {
        var file_types = $("#supported-file-types").attr('value');
        if (file_types != ".*") {
            file_types = file_types.substring(1, file_types.length - 1).split(",");
        }
        else {
            $("#file-types").text("Any file type can be uploaded.");
            return;
        }
        var fileList = this.files || []
        var ext = ".*";
        for (var i = 0; i < fileList.length; i++) {
            ext = fileList[i].name.match(/\.([^\.]+)$/)[1];
            ext = "'." + ext.toLowerCase() + "'";
            var ext_found = false;
            if (ext === file_types) {
                ext_found = true;
            }
            else {
                var index;
                for (index = 0; index < file_types.length; index++) {
                    if (ext === file_types[index].trim()) {
                        ext_found = true;
                        break;
                    }
                }
            }
            if (!ext_found) {
                //remove user selected files
                this.value = '';
                var err_msg = 'Invalid file type: ' + ext;
                $('#file-type-error').text(err_msg);
                //alert('Invalid file type:' + ext)
            }
            else {
                $('#file-type-error').text('');
            }
        }
    });
    if ($("#id_type_1").is(':checked')) { //box type coverage
        $("#div_id_north").hide();
        $("#div_id_east").hide();
        $("#div_id_elevation").hide();
    }
    if ($("#id_type_2").is(':checked')) { // point type coverage
        $("#div_id_northlimit").hide();
        $("#div_id_eastlimit").hide();
        $("#div_id_southlimit").hide();
        $("#div_id_westlimit").hide();
        $("#div_id_uplimit").hide();
        $("#div_id_downlimit").hide();
    }
    if ($("input:button[value='Delete creator']").length == 1) {
        $("input:button[value='Delete creator']").first().hide();
    }
    // disable all save changes button on load
    $("form").each(function () {
        $save_button = $(this).find("button").first();
        if ($save_button.text() === "Save changes") {
            $save_button.hide();
        }
    });

    $("#select_license").on('change', function () {
        var value = this.value;
        if (value === "other") {
            $(this).closest("form").find("#id_statement").first().text("");
            $(this).closest("form").find("#id_url").first().attr('value', "");
            $(this).closest("form").find("#id_statement").first().attr('readonly', false);
            $(this).closest("form").find("#id_url").first().attr('readonly', false);
            $("#img-badge").first().hide();
        }
        else {
            var text = $(this).find('option:selected').text();
            text = "This resource is shared under the " + text + ".";
            $(this).closest("form").find("#id_statement").first().text(text);
            $(this).closest("form").find("#id_url").first().attr('value', value);
            $(this).closest("form").find("#id_statement").first().attr('readonly', true);
            $(this).closest("form").find("#id_url").first().attr('readonly', true);
            $("#img-badge").first().show();
            if (text == "This resource is shared under the Creative Commons Attribution CC BY.") {
                $(this).closest("form").find("#img-badge").first().attr('src', "{{ STATIC_URL }}img/cc-badges/CC-BY.png");
                $(this).closest("form").find("#img-badge").first().attr('alt', "CC-BY");
            }
            else if (text == "This resource is shared under the Creative Commons Attribution-ShareAlike CC BY-SA.") {
                $(this).closest("form").find("#img-badge").first().attr('src', "{{ STATIC_URL }}img/cc-badges/CC-BY-SA.png");
                $(this).closest("form").find("#img-badge").first().attr('alt', "CC-BY-SA");
            }
            else if (text == "This resource is shared under the Creative Commons Attribution-NoDerivs CC BY-ND.") {
                $(this).closest("form").find("#img-badge").first().attr('src', "{{ STATIC_URL }}img/cc-badges/CC-BY-ND.png");
                $(this).closest("form").find("#img-badge").first().attr('alt', "CC-BY-ND");
            }
            else if (text == "This resource is shared under the Creative Commons Attribution-NoCommercial-ShareAlike CC BY-NC-SA.") {
                $(this).closest("form").find("#img-badge").first().attr('src', "{{ STATIC_URL }}img/cc-badges/CC-BY-NC-SA.png");
                $(this).closest("form").find("#img-badge").first().attr('alt', "CC-BY-NC-SA");
            }
            else if (text == "This resource is shared under the Creative Commons Attribution-NoCommercial CC BY-NC.") {
                $(this).closest("form").find("#img-badge").first().attr('src', "{{ STATIC_URL }}img/cc-badges/CC-BY-NC.png");
                $(this).closest("form").find("#img-badge").first().attr('alt', "CC-BY-NC");
            }
            else if (text == "This resource is shared under the Creative Commons Attribution-NoCommercial-NoDerivs CC BY-NC-ND.") {
                $(this).closest("form").find("#img-badge").first().attr('src', "{{ STATIC_URL }}img/cc-badges/CC-BY-NC-ND.png");
                $(this).closest("form").find("#img-badge").first().attr('alt', "CC-BY-NC-ND");
            }
        }
    });

    // set the selected license in the select license dropdown
    var value_exists = false;
    $("#select_license option").each(function () {
        if (this.value == $("#id_url").attr('value')) {
            $("#select_license").val($("#id_url").attr('value'));
            value_exists = true;
            return;
        }
    });

    if (value_exists == false) {
        // set the selected license type to 'other'
        $("#select_license").val('other');
        if ($("#select_license").attr('readonly') == undefined) {
            $("#select_license").closest("form").find("#id_statement").first().attr('readonly', false);
            $("#select_license").closest("form").find("#id_url").first().attr('readonly', false);
            $("#img-badge").first().hide();
        }
        else {
            $("#select_license").attr('style', "background-color:white;");
            $("#select_license").closest("form").find("#id_statement").first().attr('readonly', true);
            $("#select_license").closest("form").find("#id_url").first().attr('readonly', true);
        }
    }

    // show "Save changes" button when form editing starts
    $(".form-control").each(function () {
        $(this).on('input', function (e) {
            //$(this).css('border-color', 'gray');
            $(this).closest("form").find("button").show();
        });
        $(this).on('change', function (e) {
            //$(this).css('border-color', 'gray');
            $(this).closest("form").find("button").show();
        });
    });

    // Initialize date pickers
    $(".dateinput").each(function () {
        $(this).datepicker({
            format: 'mm-dd-yyyy',
            yearRange: "-1000:+1000",
            changeMonth: true,
            changeYear: true
        });
        $(this).on('change', function () {
            $(this).closest("form").find("button").show();
        });
    });
});