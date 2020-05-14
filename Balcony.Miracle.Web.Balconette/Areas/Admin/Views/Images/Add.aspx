<%@ Page Language="C#" MasterPageFile="~/Areas/Admin/Views/Shared/Admin.Master" Inherits="ViewPage<dynamic>" %>



<asp:Content ContentPlaceHolderID="HeadStart" runat="server">
    <title>Add Images</title>
</asp:Content>

<asp:Content ContentPlaceHolderID="HeadEnd" runat="server">
    <link rel="stylesheet" type="text/css" href="/content/uploadify/uploadify.css" />
    <style type="text/css">
        #uploaer {
            float: left;
            width: 300px;
        }

        #rightcol {
            float: left;
            margin-left: 10px;
        }

        #results {
            border-left: 1px solid rgb(123, 123, 123);            
        }
        #prog1 {
            display: none;
        }
    </style>
</asp:Content>

<asp:Content ContentPlaceHolderID="BodyContent" runat="server">
    <h1>Add Images</h1>
   
    <div id="uploaer">
        <input type="file" name="file_upload" id="file_upload" />   
        <div>
            <img id="prog1" src="/images/prog1.gif" alt="progress" />    
        </div>   
    </div>
        
    <div id="rightcol">
        <button class="k-button" id="save">Save</button>
        <div id="results"></div>
    </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FooterEnd" runat="server">
    <script src="/scripts/jquery.uploadify.min.js" type="text/javascript"></script>
    <script src="/scripts/kendo.treeview.min.js" type="text/javascript"></script>
    

    <script type="text/javascript">
        $(function () {
            $('#save').click(function () {
                $("#prog1").show();
                saveEditableImages("<%=Url.Action("bulkedit")%>", function () {
                    $("#prog1").hide();
                    alert("save ok");
                });
            });


            $('#file_upload').uploadify({
                swf: '/content/uploadify/uploadify.swf',
                uploader: '<%=Url.Action("upload")%>',
                auto: true,
                fileTypeDesc: 'Image Files',
                fileTypeExts: '*.gif; *.jpg; *.png',
                buttonClass: 'k-button',
                buttonText: 'Add Images',
                onUploadError: function(file, errorCode, errorMsg, errorString) {
                    alert('The file ' + file.name + ' could not be uploaded: ' + errorString + "(" + errorCode + ")" + errorMsg);
                },
                onQueueComplete: function (queueData) {
                    //alert(queueData.uploadsSuccessful + ' files were successfully uploaded.');
                },
                onUploadSuccess: function (file, data, response) {
                    var getTagsUrl = "<%=Url.Action("gettags", "tags", new { area = "" })%>";
                    var obj = jQuery.parseJSON(data);
                    var div = createEditableImage(getTagsUrl, obj);
                    div.appendTo($("#results"));
                }
                
            });
            

            $(".uploadify-button").css("height", "");
            $(".uploadify-button").css("line-height", "");
            $(".uploadify-button").css("width", "");
        });
              
       
    </script>
</asp:Content>