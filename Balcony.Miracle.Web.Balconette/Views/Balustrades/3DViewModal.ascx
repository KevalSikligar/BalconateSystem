﻿<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<div class="modal-header">
 <h3 class="modal-title" id="modal-title">Modal Window Example</h3>
</div>
<div class="modal-body" id="modal-body">

 Here Modal Body goes!!!!
</div>
<div class="modal-footer">
 <button class="btn btn-primary" type="button" ng-click="ok()">Ok</button>
 <button class="btn btn-warning" type="button" ng-click="cancelModal()">Cancel</button>

</div>