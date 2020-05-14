<%@ Page Language="C#" MasterPageFile="~/Areas/Admin/Views/Shared/Admin.Master" Inherits="ViewPage<Area>" %>

<asp:Content ContentPlaceHolderID="HeadEnd" runat="server">
    <link rel="stylesheet" type="text/css" href="/content/uploadify/uploadify.css" />
    <style>
        label {
            display: inline-block;
            width: 140px;
            font-weight: bold;
        }

        .leftcol {
            float: left;
            margin-right: 20px;
        }
        .rightcol {
            float: left;            
        }

        .galimg img {
            width: 150px;
        }

        .galimg {
            clear: both;
        }

        hr { clear: both; }
        .qabtn {
            cursor: pointer;
        }
    </style>

</asp:Content>

<asp:Content ContentPlaceHolderID="BodyContent" runat="server">
    <h1>Edit - <%: Model.Name %></h1>
    <div>
    <% using (Html.BeginForm(null, null, FormMethod.Post, new { id = "frm", enctype = "multipart/form-data" })) { %>
    <input type="hidden" name="ID" value="<%=Model.ID %>"/>

    <div class="leftcol">
        <p><%:Html.ActionLink("Back to index", "Index") %></p>
        <p><input type="submit" value="Save" class="k-button" /><%: ViewBag.Msg ?? ""%></p>
        <p>
            <label>Name</label>
            <%: Html.TextBoxFor(m => m.Name, new { @class = "k-textbox", style = "width: 400px;" })%>
            <%: Html.ValidationMessageFor(m => m.Name)%>
        </p>
        <p>
            <label>Title</label>
            <%: Html.TextBoxFor(m => m.HomepageTitle, new { @class = "k-textbox", style = "width: 400px;" })%>
            <%: Html.ValidationMessageFor(m => m.HomepageTitle)%>
        </p>
        <p>
            <label>Footer</label>
            <%: Html.TextBox("footer", Model.FooterLinksID, new { @class = "k-textbox", style="width: 300px;" })%>
        </p>
        <p>
            <label>H1</label>
            <%: Html.TextBoxFor(m => m.HomepageH1, new { @class = "k-textbox", style = "width: 400px;" })%>
            <%: Html.ValidationMessageFor(m => m.HomepageH1)%>
        </p>
        <p>
            <label>Keywords</label>
            <%: Html.TextBoxFor(m => m.HomepageKeywords, new { @class = "k-textbox", style = "width: 400px;" })%>
            <%: Html.ValidationMessageFor(m => m.HomepageKeywords)%>
        </p>
        <p>
            <label>Description</label>
            <%: Html.TextBoxFor(m => m.HomepageDescription, new { @class = "k-textbox", style = "width: 400px;" })%>
            <%:Html.ValidationMessageFor(m => m.HomepageDescription)%>
        </p>
        <p>
            <label>Links Block</label>
            <%:Html.TextBox("flinks", Model.Links != null ? Model.Links.ID.ToString() : "", new { @class = "k-textbox" })%>
        </p>   
             
        <hr/>
        <div>
            <div>
                <label>Photos Title</label>
                <%: Html.TextBoxFor(m => m.PhotosTitle, new { @class = "k-textbox", style = "width: 400px;" })%>
                <%: Html.ValidationMessageFor(m => m.PhotosTitle)%>
            </div>
            <div>
                <label>Photos Keywords</label>
                <%: Html.TextBoxFor(m => m.PhotosKeywords, new { @class = "k-textbox", style = "width: 400px;" })%>
                <%: Html.ValidationMessageFor(m => m.PhotosKeywords)%>
            </div>
            <div>
                <label>Photos Description</label>
                <%: Html.TextBoxFor(m => m.PhotosDescription, new { @class = "k-textbox", style = "width: 400px;" })%>
                <%: Html.ValidationMessageFor(m => m.PhotosDescription)%>
            </div>
            <div>
                <label>Photos HTML:</label>
                <div>
                    <%:Html.TextAreaFor(m => m.PhotosBody, new { id="photos-body-edit", style="width: 100%; height: 100px;" }) %>
                </div>                      
            </div>
            <div>
                <label>Photos Tags:</label>
                <div id="phototags"></div>
            </div>
        </div>
        
        <hr/>
        <div>
            <div>
                <label>Articles Title</label>
                <%: Html.TextBoxFor(m => m.ArticlesTitle, new { @class = "k-textbox", style = "width: 400px;" })%>
                <%: Html.ValidationMessageFor(m => m.ArticlesTitle)%>
            </div>
            <div>
                <label>Articles Keywords</label>
                <%: Html.TextBoxFor(m => m.ArticlesKeywords, new { @class = "k-textbox", style = "width: 400px;" })%>
                <%: Html.ValidationMessageFor(m => m.ArticlesKeywords)%>
            </div>
            <div>
                <label>Articles Description</label>
                <%: Html.TextBoxFor(m => m.ArticlesDescription, new { @class = "k-textbox", style = "width: 400px;" })%>
                <%: Html.ValidationMessageFor(m => m.ArticlesDescription)%>
            </div>
            <div>
                <label>Articles HTML:</label>
                <div>
                    <%:Html.TextAreaFor(m => m.ArticlesBody, new { id="articles-body-edit", style="width: 100%; height: 100px;" }) %>
                </div>                      
            </div>
            <div>
                <label>Articles Tags:</label>
                <div id="aricletags"></div>
            </div>
        </div>        

        <hr/>
        <div>
            <div>
                <label>Case Studies Title</label>
                <%: Html.TextBoxFor(m => m.CaseStudiesTitle, new { @class = "k-textbox", style = "width: 400px;" })%>
                <%: Html.ValidationMessageFor(m => m.CaseStudiesTitle)%>
            </div>
            <div>
                <label>Case Studies Keywords</label>
                <%: Html.TextBoxFor(m => m.CaseStudiesKeywords, new { @class = "k-textbox", style = "width: 400px;" })%>
                <%: Html.ValidationMessageFor(m => m.CaseStudiesKeywords)%>
            </div>
            <div>
                <label>Case Studies Description</label>
                <%: Html.TextBoxFor(m => m.CaseStudiesDescription, new { @class = "k-textbox", style = "width: 400px;" })%>
                <%: Html.ValidationMessageFor(m => m.CaseStudiesDescription)%>
            </div>
            <div>
                <label>Case Studies HTML:</label>
                <div>
                    <%:Html.TextAreaFor(m => m.CaseStudiesBody, new { id="case-studies-body-edit", style="width: 100%; height: 100px;" }) %>
                </div>                      
            </div>
            <div>
                <label>Case Studies Tags:</label>
                <div id="caseStudytags"></div>
            </div>
        </div>

        <hr/>
        <div>
            <div>
                <label>Downloads Title</label>
                <%: Html.TextBoxFor(m => m.DownloadsTitle, new { @class = "k-textbox", style = "width: 400px;" })%>
                <%: Html.ValidationMessageFor(m => m.DownloadsTitle)%>
            </div>
            <div>
                <label>Downloads Keywords</label>
                <%: Html.TextBoxFor(m => m.DownloadsKeywords, new { @class = "k-textbox", style = "width: 400px;" })%>
                <%: Html.ValidationMessageFor(m => m.DownloadsKeywords)%>
            </div>
            <div>
                <label>Downloads Description</label>
                <%: Html.TextBoxFor(m => m.DownloadsDescription, new { @class = "k-textbox", style = "width: 400px;" })%>
                <%: Html.ValidationMessageFor(m => m.DownloadsDescription)%>
            </div>
            <div>
                <label>Downloads HTML:</label>
                <div>
                    <%:Html.TextAreaFor(m => m.DownloadsBody, new { id="downloads-body-edit", style="width: 100%; height: 100px;" }) %>
                </div>                      
            </div>
            <div>
                <label>Downloads Tags:</label>
                <div id="downloadtags"></div>
            </div>
        </div>
                     
        <hr/>
        <div>
            <div>
                <label>Customer Reviews Title</label>
                <%: Html.TextBoxFor(m => m.CustomerReviewsTitle, new { @class = "k-textbox", style = "width: 400px;" })%>
                <%: Html.ValidationMessageFor(m => m.CustomerReviewsTitle)%>
            </div>
            <div>
                <label>Customer Reviews Keywords</label>
                <%: Html.TextBoxFor(m => m.CustomerReviewsKeywords, new { @class = "k-textbox", style = "width: 400px;" })%>
                <%: Html.ValidationMessageFor(m => m.CustomerReviewsKeywords)%>
            </div>
            <div>
                <label>Customer Reviews Description</label>
                <%: Html.TextBoxFor(m => m.CustomerReviewsDescription, new { @class = "k-textbox", style = "width: 400px;" })%>
                <%: Html.ValidationMessageFor(m => m.CustomerReviewsDescription)%>
            </div>
            <div>
                <label>Customer Reviews HTML:</label>
                <div>
                    <%:Html.TextAreaFor(m => m.CustomerReviewsBody, new { id="customer-reviews-body-edit", style="width: 100%; height: 100px;" }) %>
                </div>                      
            </div>
            <div>
                <label>Customer Reviews Tags:</label>
                <div id="customer-reviews-tags"></div>
            </div>
        </div>
        
        <hr/>
        <p>
            <label>Quote Attachment 1:</label>
            <span class="qaname"><%:(!String.IsNullOrEmpty(Model.QuoteAttachment1) ? System.IO.Path.GetFileName(Server.MapPath(Model.QuoteAttachment1)): "")%></span>
            <% if (!String.IsNullOrEmpty(Model.QuoteAttachment1)) { %>
            <a href="<%=Model.QuoteAttachment1 %>" target="_blank">Open</a>
            <% } %>
            <a class="qabtn"><%:String.IsNullOrEmpty(Model.QuoteAttachment1) ? "" : "Delete" %></a>
            <%:Html.HiddenFor(m => m.QuoteAttachment1, new { @class="qafile" }) %>
            <br class="clear"/>
            <input type="file" name="qa1"/>
        </p>
        <p>
            <label>Quote Attachment 2:</label>
            <span class="qaname"><%:(!String.IsNullOrEmpty(Model.QuoteAttachment2) ? System.IO.Path.GetFileName(Server.MapPath(Model.QuoteAttachment2)): "")%></span>
            <% if (!String.IsNullOrEmpty(Model.QuoteAttachment2)) { %>
            <a href="<%=Model.QuoteAttachment2 %>" target="_blank">Open</a>
            <% } %>
            <a class="qabtn"><%:String.IsNullOrEmpty(Model.QuoteAttachment2) ? "" : "Delete" %></a>
            <%:Html.HiddenFor(m => m.QuoteAttachment2, new { @class="qafile" }) %>
            <br class="clear"/>
            <input type="file" name="qa2"/>
        </p>
        <p>
            <label>Quote Attachment 3:</label>
            <span class="qaname"><%:(!String.IsNullOrEmpty(Model.QuoteAttachment3) ? System.IO.Path.GetFileName(Server.MapPath(Model.QuoteAttachment3)): "")%></span>
            <% if (!String.IsNullOrEmpty(Model.QuoteAttachment3)) { %>
            <a href="<%=Model.QuoteAttachment3 %>" target="_blank">Open</a>
            <% } %>
            <a class="qabtn"><%:String.IsNullOrEmpty(Model.QuoteAttachment3) ? "" : "Delete" %></a>
            <%:Html.HiddenFor(m => m.QuoteAttachment3, new { @class="qafile" }) %>
            <br class="clear"/>
            <input type="file" name="qa3"/>
        </p>
        <p>
            <label>Quote Attachment 4:</label>
            <span class="qaname"><%:(!String.IsNullOrEmpty(Model.QuoteAttachment4) ? System.IO.Path.GetFileName(Server.MapPath(Model.QuoteAttachment4)): "")%></span>
            <% if (!String.IsNullOrEmpty(Model.QuoteAttachment4)) { %>
            <a href="<%=Model.QuoteAttachment4 %>" target="_blank">Open</a>
            <% } %>
            <a class="qabtn"><%:String.IsNullOrEmpty(Model.QuoteAttachment4) ? "" : "Delete" %></a>
            <%:Html.HiddenFor(m => m.QuoteAttachment4, new { @class="qafile" }) %>
            <br class="clear"/>
            <input type="file" name="qa4"/>
        </p>
        

        <hr/>
        <div class="clear">
            <label>Large Scroller Images:</label>
            <div>
                <input type="file" id="uploadLargeImages" />    
            </div>
            <div id="largeImages">
                
            </div>
        </div>
        <hr/>
        <div class="clear">
            <label>Small Scroller Images:</label>
            <div>
                <input type="file" id="uploadSmallImages" />    
            </div>
            <div id="smallImages">
                
            </div>
        </div>
        
        <hr/>
        <label>Homepage HTML:</label>
        <div>
            <%:Html.TextAreaFor(m => m.HomepageBody, new { id="homepage-body-edit", style="width: 100%; height: 100px;" }) %>
        </div>                      
        

        <hr/>
        <label>Dropdown HTML:</label>
        <div>
            <%:Html.TextAreaFor(m => m.DropdownBody, new { id="dropdown-body-edit", style="width: 100%; height: 100px;" }) %>
        </div>                      


    </div>
    <% } %>
    </div>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="FooterEnd" runat="server">
<script src="/scripts/kendo.dropdownlist.min.js"></script>
<script src="/scripts/kendo.numerictextbox.min.js"></script>
<script src="/scripts/kendo.treeview.min.js" type="text/javascript"></script>
<script src="/scripts/jquery.uploadify.min.js" type="text/javascript"></script>
<% Html.RenderPartial("CKEditor"); %>
<script type="text/javascript">
    $(document).ready(function () {

        $("a.qabtn").click(function() {
            $(this).parent().find(".qafile").val("");
            $(this).parent().find(".qaname").html("");
            $(this).parent().find("a").hide();
        });

        $("#frm").submit(function () {
            prepareImagesForSave("#largeImages .galimg", "flargeImages");
            prepareImagesForSave("#smallImages .galimg", "fsmallImages");

            
            $("input.chb").each(function (i) {
                $(this).attr("name", "");
                $(this).next().attr("name", "");
            });
            $("input.article_tag:checked").each(function (i) {
                $(this).attr("name", "ArticleTags[" + i + "].ID");
                $(this).next().attr("name", "ArticleTags[" + i + "].Name");
            });
            $("input.download_tag:checked").each(function (i) {
                $(this).attr("name", "DownloadTags[" + i + "].ID");
                $(this).next().attr("name", "DownloadTags[" + i + "].Name");
            });
            $("input.case_study_tag:checked").each(function (i) {
                $(this).attr("name", "CaseStudyTags[" + i + "].ID");
                $(this).next().attr("name", "CaseStudyTags[" + i + "].Name");
            });
            $("input.photo_tag:checked").each(function (i) {
                $(this).attr("name", "PhotoTags[" + i + "].ID");
                $(this).next().attr("name", "PhotoTags[" + i + "].Name");
            });
            $("input.customer_review_tag:checked").each(function (i) {
                $(this).attr("name", "CustomerReviewTags[" + i + "].ID");
                $(this).next().attr("name", "CustomerReviewTags[" + i + "].Name");
            });

        });
        var getTagsUrl = "<%=Url.Action("gettags", "tags", new { area = "" })%>";

        //atricles tags
        var articleTagsDs = [];
        <% foreach(var tag in Model.ArticleTags) { %>
        articleTagsDs.push("<%=tag.ID%>");
        <% } %>
        var articleTagsTree = $("#aricletags").kendoTreeView({
            checkboxes: {
                checkChildren: true,
                template: function (context) {
                    if (context.item.HasTags) {
                        return '<input type="checkbox" />';
                    }
                    return '<input type="checkbox" class="chb article_tag" value="' + context.item.ID + '" /><input type="hidden" value="' + context.item.Name + '" />';
                }
            },
            loadOnDemand: false,
            dataSource: new kendo.data.HierarchicalDataSource({
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
            }),
            dataTextField: "Name"
        });
        articleTagsTree.data("kendoTreeView").bind("dataBound", function (e) {
            for (var i = 0; i < articleTagsDs.length; i++) {
                var c = $(e.node).find(':checkbox[value|="' + articleTagsDs[i] + '"]');
                if (c.length > 0) {
                    articleTagsTree.data("kendoTreeView").expand(e.node);
                    c.click();
                }
            }
        });



        //downloads tags
        var downloadTagsDs = [];
        <% foreach(var tag in Model.DownloadTags) { %>
        downloadTagsDs.push("<%=tag.ID%>");
        <% } %>
        var downloadTagsTree = $("#downloadtags").kendoTreeView({
            checkboxes: {
                checkChildren: true,
                template: function (context) {
                    if (context.item.HasTags) {
                        return '<input type="checkbox" />';
                    }
                    return '<input type="checkbox" class="chb download_tag" value="' + context.item.ID + '" /><input type="hidden" value="' + context.item.Name + '" />';
                }
            },
            loadOnDemand: false,
            dataSource: new kendo.data.HierarchicalDataSource({
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
            }),
            dataTextField: "Name"
        });
        downloadTagsTree.data("kendoTreeView").bind("dataBound", function (e) {
            for (var i = 0; i < downloadTagsDs.length; i++) {
                var c = $(e.node).find(':checkbox[value|="' + downloadTagsDs[i] + '"]');
                if (c.length > 0) {
                    downloadTagsTree.data("kendoTreeView").expand(e.node);
                    c.click();
                }
            }
        });




        //case studies tags
        var caseStudyTagsDs = [];
        <% foreach(var tag in Model.CaseStudyTags) { %>
        caseStudyTagsDs.push("<%=tag.ID%>");
        <% } %>
        var caseStudyTagsTree = $("#caseStudytags").kendoTreeView({
            checkboxes: {
                checkChildren: true,
                template: function (context) {
                    if (context.item.HasTags) {
                        return '<input type="checkbox" />';
                    }
                    return '<input type="checkbox" class="chb case_study_tag" value="' + context.item.ID + '" /><input type="hidden" value="' + context.item.Name + '" />';
                }
            },
            loadOnDemand: false,
            dataSource: new kendo.data.HierarchicalDataSource({
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
            }),
            dataTextField: "Name"
        });
        caseStudyTagsTree.data("kendoTreeView").bind("dataBound", function (e) {
            for (var i = 0; i < caseStudyTagsDs.length; i++) {
                var c = $(e.node).find(':checkbox[value|="' + caseStudyTagsDs[i] + '"]');
                if (c.length > 0) {
                    caseStudyTagsTree.data("kendoTreeView").expand(e.node);
                    c.click();
                }
            }
        });



        //phototags
        var photoTagsDs = [];
        <% foreach(var tag in Model.PhotoTags) { %>
        photoTagsDs.push("<%=tag.ID%>");
        <% } %>
        var photoTagsTree = $("#phototags").kendoTreeView({
            checkboxes: {
                checkChildren: true,
                template: function (context) {
                    if (context.item.HasTags) {
                        return '<input type="checkbox" />';
                    }
                    return '<input type="checkbox" class="chb photo_tag" value="' + context.item.ID + '" /><input type="hidden" value="' + context.item.Name + '" />';
                }
            },
            loadOnDemand: false,
            dataSource: new kendo.data.HierarchicalDataSource({
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
            }),
            dataTextField: "Name"
        });
        photoTagsTree.data("kendoTreeView").bind("dataBound", function (e) {
            for (var i = 0; i < photoTagsDs.length; i++) {
                var c = $(e.node).find(':checkbox[value|="' + photoTagsDs[i] + '"]');
                if (c.length > 0) {
                    photoTagsTree.data("kendoTreeView").expand(e.node);
                    c.click();
                }
            }
        });





        //customer reviews tags
        var customerReviewsTagsDs = [];
        <% foreach(var tag in Model.CustomerReviewTags) { %>
        customerReviewsTagsDs.push("<%=tag.ID%>");
        <% } %>
        var customerReviewsTagsTree = $("#customer-reviews-tags").kendoTreeView({
            checkboxes: {
                checkChildren: true,
                template: function (context) {
                    if (context.item.HasTags) {
                        return '<input type="checkbox" />';
                    }
                    return '<input type="checkbox" class="chb customer_review_tag" value="' + context.item.ID + '" /><input type="hidden" value="' + context.item.Name + '" />';
                }
            },
            loadOnDemand: false,
            dataSource: new kendo.data.HierarchicalDataSource({
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
            }),
            dataTextField: "Name"
        });
        customerReviewsTagsTree.data("kendoTreeView").bind("dataBound", function (e) {
            for (var i = 0; i < customerReviewsTagsDs.length; i++) {
                var c = $(e.node).find(':checkbox[value|="' + customerReviewsTagsDs[i] + '"]');
                if (c.length > 0) {
                    customerReviewsTagsTree.data("kendoTreeView").expand(e.node);
                    c.click();
                }
            }
        });









        $("#flinks").kendoDropDownList({
            dataTextField: "text",
            dataValueField: "value",
            dataSource: [{text: "None", value: ""}<%=((IList<CmsBlock>)ViewBag.CmsBlocks).Select(cmb => String.Format(@"{{ text: ""{0}"", value: ""{1}"" }}", cmb.Name, cmb.ID)).Aggregate("", (s1, s2)=> s1 +  ", " + s2)%>],
            index: 0
        });
        
        $("#footer").kendoDropDownList({
            dataTextField: "text",
            dataValueField: "value",
            dataSource: [{ text: "None", value: "" }<%=((IList<CmsBlock>)ViewBag.CmsBlocks).Select(cmb => String.Format(@"{{ text: ""{0}"", value: ""{1}"" }}", cmb.Name, cmb.ID)).Aggregate("", (s1, s2)=> s1 +  ", " + s2)%>],
            index: 0
        });

        // load images
        $.ajax({
            dataType: "json",
            type: 'POST',
            url: '<%=Url.Action("GetImages")%>',
            data: { id: "<%=Model.ID%>" },
            cache: false,
            success: function (data, textStatus, xhr) {
                var larges = data.large, i, image;
                for (i = 0; i < larges.length; i++) {
                    image = larges[i];
                    createEditableImage(getTagsUrl, image, true, true)
                        .appendTo($("#largeImages"));
                }
                var smalls = data.small;
                for (i = 0; i < smalls.length; i++) {
                    image = smalls[i];
                    createEditableImage(getTagsUrl, image, true, true)
                        .appendTo($("#smallImages"));
                }
            }
        });

        $('#uploadLargeImages').uploadify({
            swf: '/content/uploadify/uploadify.swf',
            uploader: '<%=Url.Action("upload", "images")%>',
            formData: { tsize: 740, tisWidth: true },
            auto: true,
            fileTypeDesc: 'Image Files',
            fileTypeExts: '*.gif; *.jpg; *.png',
            buttonClass: 'k-button',
            buttonText: 'Upload',
            onUploadError: function (file, errorCode, errorMsg, errorString) {
                alert('The file ' + file.name + ' could not be uploaded: ' + errorString);
            },
            onQueueComplete: function (queueData) {
                //alert(queueData.uploadsSuccessful + ' files were successfully uploaded.');
            },
            onUploadSuccess: function (file, data, response) {
                var obj = jQuery.parseJSON(data);
                var div = createEditableImage(getTagsUrl, obj, true, true);
                div.appendTo($("#largeImages"));
            }
        });

        $('#uploadSmallImages').uploadify({
            swf: '/content/uploadify/uploadify.swf',
            uploader: '<%=Url.Action("upload", "images")%>',
            formData: { tsize: 180, tisWidth: true },
            auto: true,
            fileTypeDesc: 'Image Files',
            fileTypeExts: '*.gif; *.jpg; *.png',
            buttonClass: 'k-button',
            buttonText: 'Upload',
            onUploadError: function (file, errorCode, errorMsg, errorString) {
                alert('The file ' + file.name + ' could not be uploaded: ' + errorString);
            },
            onQueueComplete: function (queueData) {
                //alert(queueData.uploadsSuccessful + ' files were successfully uploaded.');
            },
            onUploadSuccess: function (file, data, response) {
                var obj = jQuery.parseJSON(data);
                var div = createEditableImage(getTagsUrl, obj, true, true);
                div.appendTo($("#smallImages"));
            }
        });

        CKEDITOR.replace('homepage-body-edit', {
            height: 700
        });

        CKEDITOR.replace('dropdown-body-edit', {
            height: 700
        });

        CKEDITOR.replace('articles-body-edit', {
            height: 700
        });
        CKEDITOR.replace('photos-body-edit', {
            height: 700
        });
        CKEDITOR.replace('downloads-body-edit', {
            height: 700
        });
        CKEDITOR.replace('case-studies-body-edit', {
            height: 700
        });
        CKEDITOR.replace('customer-reviews-body-edit', {
            height: 700
        });

    });
</script>
    
</asp:Content>