function createEditableImage(getTagsUrl, obj, notags, inx, delCallback) {
    if (!notags) {
        var ds = new kendo.data.HierarchicalDataSource({
            transport: {
                read: {
                    url: getTagsUrl,
                    dataType: "jsonp"
                }
            },
            schema: {
                model: {
                    id: "ID",
                    hasChildren: "HasTags",
                    children: "Tags"
                }
            }
        });
        var tagsTree = $("<div />")
            .addClass("tags")
            .kendoTreeView({
                checkboxes: {
                    checkChildren: true,
                    template: '<input type="checkbox" class="tags" parent="#=item.HasTags#" value="#=item.ID#" />'
                },
                loadOnDemand: false,
                dataSource: ds,
                dataTextField: "Name"
            });
        //check the relevant check boxes
        tagsTree.data("kendoTreeView").bind("dataBound", function (e) {
            for (var i = 0; i < obj.Tags.length; i++) {
                var c = $(e.node).find(':checkbox[value|="' + obj.Tags[i].ID + '"]');
                if (c.length > 0) {
                    tagsTree.data("kendoTreeView").expand(e.node);
                    c.click();
                }
            }
        });
    }

    var rotateInput = $("<input />")
        .addClass("rotate")
        .attr("type", "hidden")
        .attr("value", "0");

    var img = $("<img />").attr("src", obj.ThumbUrl);

    var finx = null;
    if (inx) {
        finx = $("<div />")
            .addClass("inxcont")
            .append($("<input />")
                .attr("type", "text")
                .addClass("inx")
                .attr("value", obj.Inx));
            
    }

    
    var div = $("<div />")
        .addClass("galimg")
        .attr("rotate", "0")
        .attr("gid", obj.ID)
        .append(img)
        .append($("<div />")
            .addClass("frm")
            .append($("<a />")
                .addClass("btn cw")
                .attr("title", "Rotate Clockwise")
                .click(function() {
                    rot(90);
                    return false;
                }))
            .append($("<a />")
                .addClass("btn acw")
                .attr("title", "Rotate Anti Clockwise")
                .click(function() {
                    rot(270);
                    return false;
                }))
            .append($("<a />")
                .addClass("btn del")
                .attr("title", "Delete")
                .click(function () {
                    div.addClass("del");
                    $(".delfield", div).val("true");
                    div.fadeOut();
                    delCallback();
                    return false;
                }))
            .append($("<a />")
                .addClass(notags ? "" : "btn copy")
                .attr("title", "Copy tags to all others")
                .click(function () {
                    if (notags) return false;
                    var checked = $('input.tags:checked[parent="false"]', div);
                    $(".galimg").not(div).each(function () {
                        var gal = $(this);
                        checked.each(function () {
                            var id = $(this).val();
                            var chb = gal.find(':checkbox[value|="' + id + '"]');
                            if (chb.length == 0) return;
                            if (chb.prop("checked")) return;
                            chb.parents(".k-treeview").data("kendoTreeView").expand(chb.parents(".k-item"));
                            chb.click();
                        });
                    });
                    return false;
                }))
            .append($("<a />")
                .addClass("orglnk")
                .text("Org")
                .attr("href", obj.OrgUrl)
                .attr("target", "_blank"))
            .append($("<a />")
                .addClass("orglnk")
                .text("Thmb")
                .attr("href", obj.ThumbUrl)
                .attr("target", "_blank"))
            .append($("<a />")
                .addClass("orglnk")
                .text("Zoomd")
                .attr("href", obj.ZoomUrl)
                .attr("target", "_blank"))
            .append($("<input />")
                .attr("type", "hidden")
                .addClass("id")
                .attr("value", obj.ID))
            .append($("<input />")
                .attr("type", "hidden")
                .addClass("delfield")                
                .attr("value", "false"))
            .append(rotateInput)
            .append($("<input />")
                .attr("type", "text")
                .addClass("k-textbox name")
                .attr("value", obj.Name)
                .attr("placeholder", "Name"))
            .append($("<input />")
                .attr("type", "text")
                .addClass("k-textbox desc")
                .attr("placeholder", "Description")
                .attr("value", obj.Description))
            .append(finx)
            .append(tagsTree ? tagsTree : null)
        );
    
  
    if (finx) {
        $(".inx", finx).kendoNumericTextBox({ format: "n0" });
    }
    

    function rot(angle) {
        var image = $(img);
        var rotate = parseInt(rotateInput.attr("value"));
        rotate = (rotate + angle) % 360;
        rotateInput.attr("value", rotate);
        image.css("-webkit-transform", "rotate(" + rotate + "deg)");
        image.css("-moz-transform", "rotate(" + rotate + "deg)");
    }

    return div;
}

function createEditableFile(getTagsUrl, obj, notags, inx, delCallback) {
    if (!notags) {
        var ds = new kendo.data.HierarchicalDataSource({
            transport: {
                read: {
                    url: getTagsUrl,
                    dataType: "jsonp"
                }
            },
            schema: {
                model: {
                    id: "ID",
                    hasChildren: "HasTags",
                    children: "Tags"
                }
            }
        });
        var tagsTree = $("<div />")
            .addClass("tags")
            .kendoTreeView({
                checkboxes: {
                    checkChildren: true,
                    template: '<input type="checkbox" class="tags" parent="#=item.HasTags#" value="#=item.ID#" />'
                },
                loadOnDemand: false,
                dataSource: ds,
                dataTextField: "Name"
            });
        //check the relevant check boxes
        tagsTree.data("kendoTreeView").bind("dataBound", function (e) {
            for (var i = 0; i < obj.Tags.length; i++) {
                var c = $(e.node).find(':checkbox[value|="' + obj.Tags[i].ID + '"]');
                if (c.length > 0) {
                    tagsTree.data("kendoTreeView").expand(e.node);
                    c.click();
                }
            }
        });
    }


    var img = $("<img />").attr("src", "/images/file-types/128/" + obj.Extension + ".png");

    var finx = null;
    if (inx) {
        finx = $("<div />")
            .addClass("inxcont")
            .append($("<input />")
                .attr("type", "text")
                .addClass("inx")
                .attr("value", obj.Inx));

    }


    var div = $("<div />")
        .addClass("galimg")
        .attr("gid", obj.ID)
        .append(img)
        .append($("<div />")
            .addClass("frm")
            .append($("<a />")
                .addClass("btn del")
                .attr("title", "Delete")
                .click(function () {
                    div.addClass("del");
                    $(".delfield", div).val("true");
                    div.fadeOut();
                    delCallback();
                    return false;
                }))
            .append($("<a />")
                .addClass(notags ? "" : "btn copy")
                .attr("title", "Copy tags to all others")
                .click(function () {
                    if (notags) return false;
                    var checked = $('input.tags:checked[parent="false"]', div);
                    $(".galimg").not(div).each(function () {
                        var gal = $(this);
                        checked.each(function () {
                            var id = $(this).val();
                            var chb = gal.find(':checkbox[value|="' + id + '"]');
                            if (chb.length == 0) return;
                            if (chb.prop("checked")) return;
                            chb.parents(".k-treeview").data("kendoTreeView").expand(chb.parents(".k-item"));
                            chb.click();
                        });
                    });
                    return false;
                }))
            .append($("<a />")
                .addClass("orglnk")
                .text("Org")
                .attr("href", obj.Url)
                .attr("target", "_blank"))
            .append($("<input />")
                .attr("type", "hidden")
                .addClass("id")
                .attr("value", obj.ID))
            .append($("<input />")
                .attr("type", "hidden")
                .addClass("delfield")
                .attr("value", "false"))
            .append($("<input />")
                .attr("type", "text")
                .addClass("k-textbox name")
                .attr("value", obj.Name)
                .attr("placeholder", "Name"))
            .append($("<input />")
                .attr("type", "text")
                .addClass("k-textbox desc")
                .attr("placeholder", "Description")
                .attr("value", obj.Description))
            .append(finx)
            .append(tagsTree ? tagsTree : null)
        );


    if (finx) {
        $(".inx", finx).kendoNumericTextBox({ format: "n0" });
    }

    return div;
}

function prepareImagesForSave(q, prefix) {
    $(q).each(function (imgIndex) {
        $('.id', this).attr("name", prefix + "[" + imgIndex + "].ID");
        $('.name', this).attr("name", prefix + "[" + imgIndex + "].Name");
        $('.desc', this).attr("name", prefix + "[" + imgIndex + "].Description");
        $('.inx', this).attr("name", prefix + "[" + imgIndex + "].Inx");
        $('.rotate', this).attr("name", prefix + "[" + imgIndex + "].RotateAngle");
        $('.delfield', this).attr("name", prefix + "[" + imgIndex + "].ShouldDelete");
    });
}

function prepareFilesForSave(q, prefix) {
    $(q).each(function (imgIndex) {
        $('.id', this).attr("name", prefix + "[" + imgIndex + "].ID");
        $('.name', this).attr("name", prefix + "[" + imgIndex + "].Name");
        $('.desc', this).attr("name", prefix + "[" + imgIndex + "].Description");
        $('.inx', this).attr("name", prefix + "[" + imgIndex + "].Inx");
        $('.delfield', this).attr("name", prefix + "[" + imgIndex + "].ShouldDelete");
    });
}


function saveEditableImages(postUrl, callback) {
    var fdata = {};
    $('.galimg').each(function (imgIndex) {
        fdata["[" + imgIndex + "].ID"] = $('.id', this).val();
        fdata["[" + imgIndex + "].Name"] = $('.name', this).val();
        fdata["[" + imgIndex + "].Description"] = $('.desc', this).val();
        fdata["[" + imgIndex + "].Inx"] = $('.inx', this).val();
        fdata["[" + imgIndex + "].RotateAngle"] = $('.rotate', this).val();
        fdata["[" + imgIndex + "].ShouldDelete"] = $('.delfield', this).val();
        $('input.tags:checked', this).each(function (tagIndex) {
            fdata["[" + imgIndex + "].Tags[" + tagIndex + "].ID"] = $(this).val();
        });
    });
    $.ajax({
        dataType: "json",
        type: 'POST',
        url: postUrl,
        data: fdata,
        success: callback
    });
}

function saveEditableFiles(postUrl, callback) {
    var fdata = {};
    $('.galimg').each(function (imgIndex) {
        fdata["[" + imgIndex + "].ID"] = $('.id', this).val();
        fdata["[" + imgIndex + "].Name"] = $('.name', this).val();
        fdata["[" + imgIndex + "].Description"] = $('.desc', this).val();
        fdata["[" + imgIndex + "].Inx"] = $('.inx', this).val();
        fdata["[" + imgIndex + "].ShouldDelete"] = $('.delfield', this).val();
        $('input.tags:checked', this).each(function (tagIndex) {
            fdata["[" + imgIndex + "].Tags[" + tagIndex + "].ID"] = $(this).val();
        });
    });
    $.ajax({
        dataType: "json",
        type: 'POST',
        url: postUrl,
        data: fdata,
        success: callback
    });
}

$(window).load(function() {
    $(".only-numbers").on("keypress", function (e) {
        var charCode = (e.keyCode ? e.keyCode : e.which);
        if (charCode > 31 && (charCode < 48 || charCode > 57)) {
            e.preventDefault();
            return false;
        }
        return true;
    });
});


