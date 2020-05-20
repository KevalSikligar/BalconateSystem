<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>
<html lang="en" ng-app="app">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <title>Glass Balustrades - Drawing</title>

    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    

    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,400italic">
    <link href="https://ajax.googleapis.com/ajax/libs/angular_material/1.1.12/angular-material.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/hammer.js/2.0.8/hammer.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/p5@1.0.0/lib/p5.min.js"></script>



    <style type="text/css">
        .balustradeDrawing {
        }

            .balustradeDrawing .sectionsTableRow md-input-container {
                margin: 0;
            }

            .balustradeDrawing .md-errors-spacer {
                display: none;
            }

        md-input-container {
            margin: 18px 10px 0 0;
        }

        /* prevent jumping when opening select menus */
        body {
            overflow-y: scroll;
        }

        @media (hover: hover) {
            .balustradeDrawing .sectionsTableRow .removeSectionButton {
                visibility: hidden;
            }

            .balustradeDrawing .sectionsTableRow:hover .removeSectionButton {
                visibility: visible;
            }
        }

        .balustradeDrawing .header {
            height: 50px;
            box-shadow: 0px -13px 24px 15px rgba(138,138,138,0.84);
            line-height: 50px;
            vertical-align: middle;
        }

        .balustradeDrawing .wrap {
            min-height: calc(100vh - 50px);
        }

            .balustradeDrawing .wrap .top {
                min-height: calc((100vh - 50px) * 0.3);
            }

            .balustradeDrawing .wrap .bottom {
                min-height: calc((100vh - 50px) * 0.7);
                background: #fff;
                position: relative;
            }

        body .balustradeDrawing .btnHelp {
            margin: 0;
            padding: 0;
            min-height: 0;
            line-height: 24px;
            height: 24px;
            width: 24px;
        }

        body .balustradeDrawing .inputHelp {
            position: absolute;
            right: -37px;
            top: 1px;
        }

        .help-img {
            max-width: 100%;
        }

        .balustradeDrawing .h-padding {
            padding: 0 15px;
        }

        .balustradeDrawing .ready-model {
            cursor: pointer;
            user-select: none;
            border: #adadad 1px solid;
            margin: 15px 0 15px 15px;
        }

            .balustradeDrawing .ready-model:hover {
                box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.75);
            }

        .balustradeDrawing .viewSelection {
            position: absolute;
            left: 10px;
            top: 10px;
        }

        .balustradeDrawing .legend {
            position: absolute;
            top: 10px;
            right: 0;
        }

        .balustradeDrawing .priceContainer {
            line-height: 19px;
            padding-top: 5px;
        }

        .balustradeDrawing .purchaseForm md-checkbox {
            margin-bottom: 0px;
        }

        .balustradeDrawing .purchaseForm md-input-container {
            margin: 0;
        }

        .balustradeDrawing .chbLink {
            color: rgb(83, 109, 254);
            cursor: pointer;
            text-decoration: underline;
        }

            .balustradeDrawing .chbLink:visited {
                color: rgb(83, 109, 254);
            }

        .balustradeDrawing .cartForm .md-checked {
            background-color: #f0e3fd;
        }

        .balustradeDrawing .cartForm .cartTypeOption > div {
            padding: 12px;
        }

        .balustradeDrawing .cartForm md-radio-button {
            margin-bottom: 0;
        }

        .panel-welcome {
            background: white;
            border-radius: 4px;
            width: 250px;
            padding: 10px;
            box-shadow: 0 7px 8px -4px rgba(0, 0, 0, 0.2), 0 13px 19px 2px rgba(0, 0, 0, 0.14), 0 5px 24px 4px rgba(0, 0, 0, 0.12);
        }

        .legendPanel {
            background: white;
            border-radius: 4px;
            max-width: 95vw;
            box-shadow: 0 7px 8px -4px rgba(0, 0, 0, 0.2), 0 13px 19px 2px rgba(0, 0, 0, 0.14), 0 5px 24px 4px rgba(0, 0, 0, 0.12);
        }

            .legendPanel > div {
                padding: 10px;
            }

                .legendPanel > div > div {
                    line-height: 25px;
                }

        md-tooltip {
            font-size: 14px !important;
        }
    </style>

    <% Html.RenderPartial("GoogleAnalytics"); %>
</head>
<body>
    <div class="balustradeDrawing">
        <div ng-cloak>
            <div ng-controller="DrawingController as vm">
                <div class="header" layout="row">
                    <div>
                        <a href="/" target="_blank">
                            <img style="height: 45px; margin-left: 6px; margin-top: 3px;" src="/images/balconette-logo-1116.jpg" alt="Glass Balustrades, Juliette Balconies &amp; Railings - Balcony Systems" id="logo">
                        </a>
                    </div>
                    <div hide-xs>
                        <md-button class="md-raised md-accent" ng-click="vm.openFromFile()">
                            <md-tooltip>Open an existing drawing file you previously saved</md-tooltip>
                            Open Drawing
                        </md-button>
                    </div>
                    <div hide-xs>
                        <md-button class="md-raised md-accent" ng-disabled="!vm.isValid() || vm.drawingInProgress" ng-click="vm.saveToFile()">
                            <md-tooltip>Save this drawing as a file you can later open</md-tooltip>
                            Save Drawing
                        </md-button>
                    </div>
                    <div hide-xs ng-if="vm.cartCount">
                        <md-button class="md-raised md-accent" href="/customer/cart?areas=Balustrades">
                            View Cart
                        </md-button>
                    </div>
                    <div flex hide-xs>
                    </div>
                    <div hide-xs>
                        <md-button class="md-raised md-accent btn-tutorial" href="/glass-balustrade/drawing-tutorial" target="_blank">
                            Tutorial
                        </md-button>
                    </div>
                    <div flex>
                    </div>
                    <div class="priceContainer" ng-if="vm.isValid() && vm.price" hide-xs>
                        <div>
                            <div>{{vm.price | currency:"£":2}} <span style="font-size: 11px;">+ VAT</span></div>
                            <div><span style="font-weight: bold;">{{vm.getPriceWithVAT() | currency:"£":2}}</span> <span style="font-size: 11px;">(inc VAT)</span></div>
                        </div>
                    </div>
                    <div>
                        <md-button class="md-raised md-accent" style="margin-right: 3px;" ng-disabled="!vm.isValid() || vm.drawingInProgress" ng-click="vm.saveAsQuote()">
                            Save as Quote
                        </md-button>
                    </div>
                    <div>
                        <md-button class="md-raised md-primary" ng-disabled="!vm.isValid() || vm.drawingInProgress" ng-click="vm.gotoPurchase()">Purchase</md-button>
                    </div>
                </div>
                <div class="wrap">
                    <div class="top">
                        <md-tabs md-dynamic-height md-center-tabs md-selected="vm.selectedTabIndex">
                            <md-tab label="General Options">
                                <md-content class="h-padding">
                                    <form name="drawingGeneralForm" novalidate>                                        
                                        <div layout="row">
                                            <md-input-container>
                                                <label>System</label>
                                                <md-select ng-model="vm.model.systemId" name="systemId" placeholder="Select System" md-on-open="vm.systemsPromise" required style="min-width: 200px;">
                                                    <md-option ng-value="sys.id" ng-repeat="sys in vm.systems">{{sys.name}}</md-option>
                                                </md-select>
                                                <div class="errors" ng-messages="drawingGeneralForm.systemId.$error">
                                                    <div ng-message="required">Required</div>
                                                </div>
                                            </md-input-container>
                                            <md-input-container style="width: 80px;">
                                                <label>Height</label>
                                                <input ng-model="vm.getSystem().defaultHeight" ng-disabled="true" />
                                            </md-input-container>
                                            <div>
                                                <md-button style="transform: translateY(7px);" ng-disabled="drawingGeneralForm.system.$invalid" class="md-accent md-hue-4 md-raised" ng-click="vm.openImageHelp($event, '/images/balustrade-drawing/sections/b' + vm.model.systemId + '.png')">System Details & Section</md-button>
                                            </div>
                                        </div>
                                        <div layout="row" layout-xs="column">
                                            <md-input-container>
                                                <label>Glass</label>
                                                <md-select ng-model="vm.model.glassId" name="glassId" placeholder="Select Glass" md-on-open="vm.systemsPromise" required style="min-width: 200px;">
                                                    <md-option ng-value="glass.id" ng-repeat="glass in vm.getSystem().glasses">{{glass.name}}</md-option>
                                                </md-select>
                                                <div class="errors" ng-messages="drawingGeneralForm.glassId.$error">
                                                    <div ng-message="required">Required. <span ng-if="!vm.getSystem()">Please select System first</span></div>
                                                </div>
                                            </md-input-container>
                                            <md-input-container>
                                                <label>Colour</label>
                                                <md-select ng-change="vm.getColorId(vm.model)" ng-model="vm.model.colorId" name="colorId" placeholder="Select Colour" md-on-open="vm.systemsPromise" required style="min-width: 200px;">
                                                    <md-option ng-value="color.id" ng-repeat="color in vm.getSystem().colors">{{color.name}}</md-option>
                                                </md-select>
                                                <div class="errors" ng-messages="drawingGeneralForm.colorId.$error">
                                                    <div ng-message="required">Required. <span ng-if="!vm.getSystem()">Please select System first</span></div>
                                                </div>
                                                <input type="hidden" id="colorId"/> 
                                                <md-button class="md-icon-button inputHelp" ng-click="vm.openImageHelp($event, '/images/balustrade-drawing/colors/' + vm.model.colorId + '.png')">
                                                    <md-icon md-font-set="material-icons">help_outline</md-icon>
                                                </md-button>
                                            </md-input-container>

                                        </div>
                                        <div layout="row" layout-xs="column">
                                            <md-button class="md-raised md-primary" type="submit" ng-click="vm.generalNextClick()">Next</md-button>
                                            <md-button class="md-raised md-accent" type="submit" ng-click="vm.startAgain()">Start again</md-button>
                                        </div>   
                                                                         
                                    </form>
                                </md-content>
                            </md-tab>
                            <md-tab label="Models" ng-disabled="drawingGeneralForm.$invalid">
                                <md-content class="h-padding">
                                    <div>
                                        <div layout="row" layout-xs="column" layout-align="start start">
                                            <ready-model model="mdl" ng-repeat="mdl in vm.models" class="ready-model" ng-click="vm.selectModel(mdl)">                                                
                                            </ready-model>
                                        </div>
                                    </div>
                                </md-content>
                            </md-tab>                            
                            <md-tab label="Sections" ng-disabled="drawingGeneralForm.$invalid">
                                <md-content class="h-padding" style="padding-top: 10px;">
                                    <form name="drawingSectionsForm" novalidate>
                                        <div layout="row" layout-xs="column">
                                            <div>
                                                <div ng-show="vm.sections.length <= 0">
                                                    Please add one or more sections
                                                </div>
                                                
                                                <div layout="row" layout-xs="column" layout-align="start start">
                                                    <div style="margin-right: 20px;">
                                                        <div style="text-align: center;">
                                                            <md-button class="md-fab md-primary" ng-click="vm.addSectionClick()">
                                                                <md-tooltip>Add Balustrade Section</md-tooltip>
                                                                <md-icon md-font-set="material-icons">add</md-icon>
                                                            </md-button>
                                                        </div>
                                                        <div style="position: relative;">
                                                            <md-button class="md-accent md-hue-4 md-raised" ng-click="vm.mirrorSections()">Mirror</md-button>
                                                            <md-button class="md-icon-button " style="position: absolute; top: 4px; right: -34px;" ng-click="vm.openImageHelp($event, '/images/balustrade-drawing/mirror-help.png')">
                                                                <md-icon md-font-set="material-icons">help_outline</md-icon>
                                                            </md-button>
                                                        </div>
                                                       <!-- 
                                                        <div style="position: relative;">
                                                            <md-button class="md-accent md-hue-4 md-raised" ng-click="vm.invertSections()">Invert</md-button>
                                                            <md-button class="md-icon-button" style="position: absolute; top: 4px; right: -34px;" ng-click="vm.openImageHelp($event, '/images/balustrade-drawing/invert-help.png')">
                                                                <md-icon md-font-set="material-icons">help_outline</md-icon>
                                                            </md-button>
                                                        </div>
                                                       -->
                                                    </div>
                                                    <div flex>
                                                        <div style="font-weight: bold; margin-left: 10px;">
                                                            Section dimensions
                                                        </div>
                                                        <div class="sectionsTableRow" layout="row" layout-xs="column" layout-align="start start" style="font-weight: bold; background-color: #fafafa;">
                                                            <div style="width: 40px;">
                                                                <div style="padding: 0 20px 0 0; text-align: right;">#</div>
                                                            </div>
                                                            <div style="width: 100px;">Length (mm)</div>
                                                            <div style="width: 90px; margin-left: 10px;">
                                                                Angle
                                                                <md-button class="md-icon-button btnHelp" style="margin: 0;" ng-click="vm.openImageHelp($event, '/images/balustrade-drawing/drawing-angle-axis.png')">
                                                                    <md-icon md-font-set="material-icons">help_outline</md-icon>
                                                                </md-button>
                                                            </div>
                                                            <div style="width: 90px; margin-left: 10px;">
                                                                Offset
                                                                <md-button class="md-icon-button btnHelp" style="margin: 0;" ng-click="vm.openImageHelp($event, '/images/balustrade-drawing/offset-help/b' + vm.model.systemId + '.png')">
                                                                    <md-icon md-font-set="material-icons">help_outline</md-icon>
                                                                </md-button>
                                                            </div>
                                                            <div></div>
                                                            <div></div>
                                                        </div>
                                                        <div id="sectionsScrollWrapper" style="max-height: calc((100vh - 187px) * 0.3 - 70px); overflow-y: auto; flex-grow: 1; margin: 0 10px 10px 0; overflow-x: hidden;">
                                                            <div class="sectionsTableRow" layout="row" layout-xs="column" layout-align="start start" ng-repeat="section in vm.model.sections track by $index">
                                                                <div style="width: 40px;">
                                                                    <div style="padding: 8px 20px 0 0; font-weight: bold; text-align: right;">{{$index + 1}}</div>
                                                                </div>
                                                                <md-input-container style="width: 100px;">
                                                                    <input ng-model="section.length" name="sectionLength{{$index}}" required type="number" min="200" max="99999" step="1" only-numbers />
                                                                    <div class="errors" ng-messages="drawingSectionsForm['sectionLength' + $index].$error">
                                                                        <div ng-message="required">Required.</div>
                                                                        <div ng-message="min">Length must be higher than 199</div>
                                                                        <div ng-message="max">Length must be lower than 100000</div>
                                                                    </div>
                                                                </md-input-container>
                                                                <md-input-container style="width: 90px; margin-left: 10px;">
                                                                    <input ng-model="section.angle" name="sectionAngle{{$index}}" required type="number" ng-pattern="/^-?\d+(\.\d+)?$/" />
                                                                    <div class="errors" ng-messages="drawingSectionsForm['sectionAngle' + $index].$error">
                                                                        <div ng-message="required">Required.</div>
                                                                        <div ng-message="pattern">
                                                                            Please provide a number
                                                                        </div>
                                                                    </div>
                                                                </md-input-container>
                                                                <md-input-container style="width: 90px; margin-left: 10px;">
                                                                    <input ng-model="section.ofst" name="sectionOffset{{$index}}" type="number" ng-pattern="/^-?\d+(\.\d+)?$/" />
                                                                    <div class="errors" ng-messages="drawingSectionsForm['sectionOffset' + $index].$error">
                                                                        <div ng-message="pattern">
                                                                            Please provide a number
                                                                        </div>
                                                                    </div>
                                                                </md-input-container>
                                                                <div>
                                                                    <md-button class="md-icon-button md-warn removeSectionButton" style="margin: 0;" ng-click="vm.removeSectionClick($index)">
                                                                        <md-icon md-font-set="material-icons">clear</md-icon>
                                                                    </md-button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div style="display: flex;align-items: center;justify-content: space-between; width: 100%;" >
                                                <div>
                                                    <div style="font-weight: bold;">
                                                        Walls/Ends Details
                                                    </div>
                                                    <div layout="row" layout-xs="column" layout-align="start start">
                                                        <md-input-container style="width: 150px;margin-right: 30px;">
                                                            <label>Start Type</label>
                                                            <md-select ng-model="vm.model.startType" name="startType" placeholder="Select Start Type" style="min-width: 120px;" required>
                                                                <md-option ng-value="'Wall'">Wall</md-option>
                                                                <md-option ng-value="'EndPost'">Post</md-option>
                                                            </md-select>
                                                            <div class="errors" ng-messages="drawingSectionsForm.startType.$error">
                                                                <div ng-message="required">Required.</div>
                                                            </div>
                                                        </md-input-container>
                                                        <md-input-container style="width: 150px;margin-right: 30px;">
                                                            <label>End Type</label>
                                                            <md-select ng-model="vm.model.endType" name="endType" placeholder="Select End Type" style="min-width: 120px;" required>
                                                                <md-option ng-value="'Wall'">Wall</md-option>
                                                                <md-option ng-value="'EndPost'">Post</md-option>
                                                            </md-select>
                                                            <div class="errors" ng-messages="drawingSectionsForm.endType.$error">
                                                                <div ng-message="required">Required.</div>
                                                            </div>
                                                            <md-button class="md-icon-button inputHelp" ng-click="vm.openImageHelp($event, '/images/balustrade-drawing/finish-type-help/b' + vm.model.systemId + '.png')">
                                                                <md-icon md-font-set="material-icons">help_outline</md-icon>
                                                            </md-button>
                                                        </md-input-container>
                                                    </div>
                                                    <div layout="row" layout-xs="column" layout-align="start start">
                                                        <md-input-container style="width: 150px;margin-right: 30px;">
                                                            <label>Start Wall Angle</label>
                                                            <input ng-model="vm.model.startWallAngle" name="startWallAngle" type="number" />
                                                            <div class="errors" ng-messages="drawingSectionsForm.startWallAngle.$error">
                                                            </div>
                                                        </md-input-container>
                                                        <md-input-container style="width: 150px;margin-right: 30px;">
                                                            <label>End Wall Angle</label>
                                                            <input ng-model="vm.model.endWallAngle" name="endWallAngle" type="number" />
                                                            <div class="errors" ng-messages="drawingSectionsForm.endWallAngle.$error">
                                                            </div>
                                                            <md-button class="md-icon-button inputHelp" ng-click="vm.openImageHelp($event, '/images/balustrade-drawing/wall-angle-help/b' + vm.model.systemId + '.png')">
                                                                <md-icon md-font-set="material-icons">help_outline</md-icon>
                                                            </md-button>
                                                        </md-input-container>

                                                    </div>
                                                </div>
                                                <div>
                                                
                                                     <img  onclick="javascript:showModal()" title="Preview 3D View" id="imgPreview" height="200" width="300"/>
                                            </div>  
                                            </div>
                                        </div>
                                    </form>
                                </md-content>
                            </md-tab>         
                            <!-- 
                            <md-tab label="Advanced" ng-disabled="drawingGeneralForm.$invalid">
                                <md-content class="h-padding">
                                    <form name="drawingAdvancedForm" novalidate>
                                        <div>                                            
                                            <div layout="row" layout-align="start start">
                                                <md-input-container style="width: 225px;">
                                                    <label>Wall - Bottomrail Distance (mm)</label>
                                                    <input ng-model="vm.model.hrbr" name="hrbr" type="number" min="0" max="100" />
                                                    <div class="errors" ng-messages="drawingAdvancedForm.hrbr.$error">
                                                        <div ng-message="min">Must be higher than 0</div>
                                                        <div ng-message="max">Must be lower than 101</div>
                                                    </div>
                                                </md-input-container>
                                                <md-input-container style="width: 225px;">
                                                    <label>Bottomrail - Wall Distance (mm)</label>
                                                    <input ng-model="vm.model.brhr" name="brhr" type="number" min="0" max="100" />
                                                    <div class="errors" ng-messages="drawingAdvancedForm.brhr.$error">
                                                        <div ng-message="min">Must be higher than 0</div>
                                                        <div ng-message="max">Must be lower than 101</div>
                                                    </div>
                                                </md-input-container>
                                            </div>
                                            <div layout="row" layout-align="start start">
                                                <md-input-container style="width: 225px;">
                                                    <label>Wall - Glass Distance (mm)</label>
                                                    <input ng-model="vm.model.wg" name="wg" type="number" min="10" max="90" />
                                                    <div class="errors" ng-messages="drawingAdvancedForm.wg.$error">
                                                        <div ng-message="min">Must be higher than 9</div>
                                                        <div ng-message="max">Must be lower than 91</div>
                                                    </div>
                                                </md-input-container>
                                                <md-input-container style="width: 225px;">
                                                    <label>Glass - Wall Distance (mm)</label>
                                                    <input ng-model="vm.model.gw" name="gw" type="number" min="10" max="90" />
                                                    <div class="errors" ng-messages="drawingAdvancedForm.gw.$error">
                                                        <div ng-message="min">Must be higher than 9</div>
                                                        <div ng-message="max">Must be lower than 91</div>
                                                    </div>
                                                </md-input-container>
                                            </div>                                            
                                        </div>
                                    </form>
                                </md-content>
                            </md-tab>   
                            -->
                            <md-tab label="Purchase" ng-disabled="!vm.isValid() || !vm.price">
                                <md-content class="h-padding cartForm">
                                    <div style="font-weight: bold;">
                                        Please choose one of the following options:
                                    </div>
                                    <div>
                                        <md-radio-group ng-model="vm.cartType" >
                                            <div class="row cartTypeOption">
                                                <div flex layout="row" layout-align="start center" >
                                                    <md-radio-button ng-value="'Full'" class="md-primary" >
                                                        <span>Complete Full Design & Approval Online</span>
                                                        <span ng-if="vm.price != vm.getFullDrawingPrice()">: 
                                                            <span style="font-weight: bold; color: #00be06;">(Save {{vm.onlineDrawingDiscount | number:0}}% {{vm.getFullDrawingDiscountWithVAT() | currency:"£":2}} inc Vat)</span> 
                                                            <span style="font-weight: bold;">{{vm.getFullDrawingPrice() | currency:"£":2}}</span> + VAT ({{vm.getFullDrawingPriceWithVAT() | currency:"£":2}} inc VAT)
                                                        </span>
                                                    </md-radio-button>
                                                    <md-button class="md-icon-button btnHelp" style="margin-left: 10px;" ng-click="vm.openImageHelp($event, '/images/balustrade-drawing/purchase-full-help.png')">
                                                        <md-icon md-font-set="material-icons">help_outline</md-icon>
                                                    </md-button>
                                                </div>
                                            </div>
                                            <div class="row cartTypeOption">
                                                <div flex layout="row" layout-align="start center" >
                                                    <md-radio-button ng-value="'Partial'" class="md-primary" >
                                                        Order & Complete Design Offline with our technical team <span style="font-weight: bold;">{{vm.price | currency:"£":2}}</span> + VAT ({{vm.getPriceWithVAT() | currency:"£":2}} inc VAT)
                                                    </md-radio-button>
                                                    <md-button class="md-icon-button btnHelp" style="margin-left: 10px;" ng-click="vm.openImageHelp($event, '/images/balustrade-drawing/purchase-partial-help.png')">
                                                        <md-icon md-font-set="material-icons">help_outline</md-icon>
                                                    </md-button>

                                                </div>
                                            </div>
                                        </md-radio-group>
                                    </div>
                                    <div>
                                        <div ng-show="vm.cartType == 'Full'">
                                            <md-button class="md-raised md-primary" ng-click="vm.gotoApproval()">
                                                Next
                                            </md-button>
                                        </div>
                                        <div layout="row" ng-show="vm.cartType != 'Full'">
                                            <md-input-container style="width: 80px;">
                                                <label>Quantity</label>
                                                <input ng-model="vm.quantity" name="quantity" type="number" step="1" min="1" max="100" />                                                
                                            </md-input-container>
                                            <md-button class="md-raised md-primary" ng-disabled="vm.addToCartInProgress" ng-click="vm.addToCart($event)">
                                                Add to Cart
                                            </md-button>
                                        </div>
                                    </div>
                                </md-content>
                            </md-tab>
                            <md-tab label="Approval" ng-disabled="!vm.approvalTabVisible || !vm.isValid() || (vm.selectedTabIndex != 3 && vm.selectedTabIndex != 4) || vm.cartType != 'Full'">
                                <div class="h-padding purchaseForm">
                                    <form name="purchaseForm" novalidate>
                                        <div>
                                            <div style="background-color: #f0e3fd; padding: 4px 12px;">
                                                <span ng-if="vm.price != vm.getFullDrawingPrice()">
                                                    Unit Price:
                                                    <span style="font-weight: bold; color: #00be06;">(Save {{vm.onlineDrawingDiscount | number:0}}% {{vm.getFullDrawingDiscountWithVAT() | currency:"£":2}} inc Vat)</span> 
                                                    <span style="font-weight: bold;">{{vm.getFullDrawingPrice() | currency:"£":2}}</span> + VAT ({{vm.getFullDrawingPriceWithVAT() | currency:"£":2}} inc VAT)
                                                </span>
                                            </div>
                                            <div layout="row" layout-xs="column" layout-align="start start">
                                                <div style="margin-left: 10px;">
                                                    <md-input-container class="md-block">
                                                        <md-checkbox name="confirm1" ng-model="vm.confirm.c1" required>
                                                            System colour is {{vm.getColor().name}}
                                                        </md-checkbox>
                                                    </md-input-container>
                                                    <md-input-container class="md-block">
                                                        <md-checkbox name="confirm2" ng-model="vm.confirm.c2" required>
                                                            Glass is {{vm.getGlass().name}}
                                                        </md-checkbox>
                                                    </md-input-container>
                                                    <md-input-container class="md-block" ng-if="!vm.getSystem() || !vm.getSystem().noHandrail">
                                                        <md-checkbox name="confirm3" ng-model="vm.confirm.c3" required>
                                                            <a class="chbLink" ng-href="{{vm.getDrawingUrl(1)}}" onclick="event.stopPropagation()" target="_blank" onclick="event.stopPropagation()">Handrail & Posts Dimensions</a> Approved 
                                                        </md-checkbox>
                                                    </md-input-container>
                                                    <md-input-container class="md-block">
                                                        <md-checkbox name="confirm4" ng-model="vm.confirm.c4" required>
                                                            <a class="chbLink" ng-href="{{vm.getDrawingUrl(2)}}" onclick="event.stopPropagation()" target="_blank" onclick="event.stopPropagation()">Bottom Rail Dimensions </a>Approved
                                                        </md-checkbox>
                                                    </md-input-container>
                                                    <md-input-container class="md-block">
                                                        <md-checkbox name="confirm5" ng-model="vm.confirm.c5" required>
                                                            <a class="chbLink" ng-href="{{vm.getDrawingUrl(3)}}" onclick="event.stopPropagation()" target="_blank" onclick="event.stopPropagation()">Glass Dimensions</a> Approved
                                                        </md-checkbox>
                                                    </md-input-container>
                                                    <md-input-container class="md-block">
                                                        <md-checkbox name="confirm6" ng-model="vm.confirm.c6" required>
                                                            <a class="chbLink" target="_blank" ng-href="/pdfs/balustrade-drawing/system-sections/{{vm.model.systemId}}.pdf" onclick="event.stopPropagation()">Height & System Section</a> Approved
                                                        </md-checkbox>
                                                    </md-input-container>
                                                </div>
                                                <div style="margin-left: 10px;">
                                                    <md-input-container class="md-block">
                                                        <md-checkbox name="confirm7" ng-model="vm.confirm.c7" ng-if="vm.withPosts" required>
                                                            <a class="chbLink" target="_blank" ng-href="/pdfs/balustrade-drawing/post-sections/{{vm.model.systemId}}.pdf" onclick="event.stopPropagation()">Post Section</a> Approved
                                                        </md-checkbox>
                                                    </md-input-container>
                                                    <md-input-container class="md-block">
                                                        <md-checkbox name="confirm8" ng-model="vm.confirm.c8" required>
                                                            <a class="chbLink" target="_blank" ng-href="/pdfs/balustrade-drawing/{{vm.getFinishPdfName('start')}}/{{vm.model.systemId}}.pdf" onclick="event.stopPropagation()">Wall/End Detail (Left)</a> Approved
                                                        </md-checkbox>
                                                    </md-input-container>
                                                    <md-input-container class="md-block">
                                                        <md-checkbox name="confirm9" ng-model="vm.confirm.c9" required>
                                                            <a class="chbLink" target="_blank" ng-href="/pdfs/balustrade-drawing/{{vm.getFinishPdfName('end')}}/{{vm.model.systemId}}.pdf" onclick="event.stopPropagation()">Wall/End Detail (Right)</a> Approved
                                                        </md-checkbox>
                                                    </md-input-container>
                                                    <md-input-container class="md-block">
                                                        <md-checkbox name="confirm10" ng-model="vm.confirm.c10" required>
                                                            <a class="chbLink" target="_blank" href="/pdfs/balustrade-drawing/technical-and-delivery-appendix.pdf" onclick="event.stopPropagation()">Technical & Delivery Appendix</a> Approved
                                                        </md-checkbox>
                                                    </md-input-container>
                                                    <div style="margin-top: 5px;">
                                                        <div layout="row">
                                                            <md-input-container style="width: 80px; margin-top: 10px;">
                                                                <label>Quantity</label>
                                                                <input ng-model="vm.quantity" name="quantity" type="number" required step="1" min="1" max="100" />                                                
                                                            </md-input-container>
                                                            <md-button class="md-raised md-primary" type="submit" ng-disabled="!purchaseForm.$valid || vm.addToCartInProgress" ng-click="vm.addToCart($event)">
                                                                Add to cart Approved Balustrade
                                                            </md-button>
                                                            <md-button class="md-icon-button" style="width: 40px; min-width: 0; margin: 0; height: unset;" ng-click="vm.openImageHelp($event, '/images/balustrade-drawing/approval-full-add-to-cart-help.png')">
                                                                <md-icon md-font-set="material-icons">help_outline</md-icon>
                                                            </md-button>
                                                        </div>
                                                        <div>
                                                            <span ng-if="!purchaseForm.$valid">
                                                                Please review and approve each of the checkboxes in order to proceed
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </md-tab>          
                        </md-tabs>
                    </div>
                    <div class="bottom" style="display: flex; flex-direction: column;">
                        <div style="height: 5px; border-top: rgb(156,39,176) 1px solid;">
                            <md-progress-linear md-mode="query" ng-show="vm.drawingInProgress"></md-progress-linear>
                        </div>
                        <div style="flex-grow: 1; display: flex; flex-direction: column;">
                            <drawing-panel svg="vm.svg" style="flex-grow: 1; display: flex; flex-direction: column;" ng-show="vm.isValid()"></drawing-panel>
                        </div>
                        <div class="viewSelection">
                            <md-input-container style="min-width: 181px;">
                                <label>DRAWING VIEW OPTIONS</label>
                                <md-select ng-model="vm.model.viewIndex" style="margin: 0;" name="viewIndex">
                                    <md-option ng-value="$index" ng-if="viewName" ng-repeat="viewName in vm.getViews()">{{viewName}}</md-option>
                                </md-select>
                            </md-input-container>
                        </div>
                        <div class="legend">
                            <md-button class="md-accent md-hue-4 md-raised" style="margin-right: 0;" ng-href="{{vm.getDrawingUrl(vm.model.viewIndex)}}" ng-disabled="!vm.isValid() || vm.drawingInProgress" target="_blank">Create PDF</md-button>
                            <md-button class="md-accent md-hue-4 md-raised" ng-click="vm.openLegend($event)">Legend</md-button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.7.6/angular.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.7.6/angular-animate.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.7.6/angular-aria.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.7.6/angular-messages.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.7.6/angular-sanitize.min.js"></script>
    <script src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/t-114/svg-assets-cache.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angular_material/1.1.12/angular-material.min.js"></script>
    <script src="/scripts/svg-pan-zoom.min.js"></script>

    <script type="text/javascript">
                    var angleArray=[];

        (function () {

            function DrawingController($http, $scope, $timeout, $sce, $q, $mdDialog, $mdPanel, $mdToast) {
                var that = this;
                this.$http = $http;
                this.$mdDialog = $mdDialog;
                this.$q = $q;
                this.$scope = $scope;
                this.$timeout = $timeout;
                this.$mdPanel = $mdPanel;
                this.cartCount = eval(<%=Context.CartCount()%>);

                this.selectedTabIndex = 0;
                this.systems = null;
                this.systemsIndex = {};

                this.lastReqId = 0;
                this.price = null;
                this.vatPercent = null;
                this.onlineDrawingDiscount = null;

                this.withPosts = false;

                this.reset();

                var balUser = this.getCookie('balUser');
                if (!balUser) {
                    this.$timeout(function () {

                        var position = that.$mdPanel.newPanelPosition()
                            .relativeTo($('.btn-tutorial')[0])
                            .addPanelPosition(that.$mdPanel.xPosition.ALIGN_START, that.$mdPanel.yPosition.BELOW);

                        var config = {
                            attachTo: angular.element(document.body),
                            controllerAs: 'ctrl',
                            template:
                                '<div><div>If this is your first time here why not start with a Tutorial to help understand all the options available here</div></div>',
                            panelClass: 'panel-welcome',
                            position: position,
                            hasBackdrop: true,
                            clickOutsideToClose: true,
                            escapeToClose: true,
                            focusOnOpen: false,
                            zIndex: 2
                        };

                        that.$mdPanel.open(config);

                    }, 4000);

                    this.setCookie('balUser', '{}');
                }

                this.models = [
                    {
                        "sections": [{ "length": 4000, "angle": 0 }],
                    },
                    {
                        "sections": [{ "length": 4000, "angle": 0 }, { "angle": 270, "length": 1500 }],
                    },
                    {
                        "sections": [{ "angle": 90, "length": 1500 }, { "length": 4000, "angle": 0 }],
                    },
                    {
                        "sections": [{ "angle": 90, "length": 1501 }, { "length": 4000, "angle": 0 }, { "angle": 270, "length": 1502 }],
                    },
                    {
                        "sections": [{ "angle": 90, "length": 1501 }, { "length": 3000, "angle": 0 }, { "angle": 270, "length": 1502 }, { "angle": 0, "length": 2000 }],
                    },
                    {
                        "sections": [{ "angle": 0, "length": 2000 }, { "angle": 90, "length": 1502 }, { "length": 3000, "angle": 0 }, { "angle": 270, "length": 1501 }],
                    },
                    {
                        "sections": [{ "angle": 90, "length": 1001 }, { "length": 1002, "angle": 45 }, { "angle": 0, "length": 1003 }, { "angle": 315, "length": 1004 }, { "angle": 270, "length": 1005 }],
                    },
                    {
                        "sections": [{ "angle": 90, "length": 1001 }, { "length": 1002, "angle": 45 }, { "angle": 0, "length": 1003 }, { "angle": 315, "length": 1004 }, { "angle": 270, "length": 1005 }, { "angle": 0, "length": 1006 }],
                    },
                    {
                        "sections": [{ "angle": 0, "length": 1006 }, { "angle": 90, "length": 1005 }, { "angle": 45, "length": 1004 }, { "angle": 0, "length": 1003 }, { "length": 1002, "angle": 315 }, { "angle": 270, "length": 1001 }],
                    },
                    {
                        "sections": [{ "angle": 0, "length": 1007 }, { "angle": 90, "length": 1006 }, { "angle": 45, "length": 1005 }, { "angle": 0, "length": 1004 }, { "length": 1003, "angle": 315 }, { "angle": 270, "length": 1002 }, { "angle": 0, "length": 1001 }],
                    },
                    {
                        "sections": [{ "angle": 90, "length": 1001 }, { "angle": 68, "length": 1002 }, { "angle": 45, "length": 1003 }, { "angle": 22, "length": 1004 }, { "length": 1005, "angle": 0 }, { "angle": -22, "length": 1006 }, { "angle": -45, "length": 1007 }, { "angle": -68, "length": 1008 }, { "angle": -90, "length": 1009 }],
                    },
                    {
                        "sections": [{ "angle": 90, "length": 1001 }, { "angle": 70, "length": 1002 }, { "angle": 50, "length": 1003 }, { "angle": 30, "length": 1004 }, { "length": 1005, "angle": 10 }, { "angle": -10, "length": 1006 }, { "angle": -30, "length": 1007 }, { "angle": -50, "length": 1008 }, { "angle": -70, "length": 1009 }, { "angle": -90, "length": 1010 }],
                    }
                ];

                var lastModelJson = this.getCookie('balLastModel');
                if (lastModelJson) {
                    try {
                        jQuery.extend(true, this.model, JSON.parse(lastModelJson));
                    }
                    catch (e) { }
                }

                this.drawingInProgress = false;
                this.svg = null;

                this.systemsPromise = this.$http.get('/glass-balustrade/get-systems')
                    .then(function (response) {
                        that.systems = response.data;
                        that.systems.forEach(function (sys) {
                            that.systemsIndex[sys.id] = sys;
                        });

                        that.drawAndSaveIfValid();
                    });

            }

            DrawingController.prototype.getCookie = function (cname) {
                var name = cname + "=";
                var decodedCookie = decodeURIComponent(document.cookie);
                var ca = decodedCookie.split(';');
                for (var i = 0; i < ca.length; i++) {
                    var c = ca[i];
                    while (c.charAt(0) == ' ') {
                        c = c.substring(1);
                    }
                    if (c.indexOf(name) == 0) {
                        return c.substring(name.length, c.length);
                    }
                }
                return "";
            }

            DrawingController.prototype.setCookie = function (cookieName, value) {
                var now = new Date();
                now.setMonth(now.getMonth() + 12);
                document.cookie = cookieName + '=' + value + ";expires=" + now.toUTCString() + ";";
            }

            DrawingController.prototype.$onInit = function () {
                var that = this;

                this.$scope.$watch(function () {
                    angleArray = that.model.sections;
                    return that.model.systemId;
                }, function (newValue, oldValue) {
                    debugger;
                    //var oldSystem = that.getSystem(oldValue);
                    var newSystem = that.getSystem(newValue);

                  

                    //if (newSystem && (that.height === null || that.height === undefined || (oldSystem && that.height === oldSystem.defaultHeight))) {
                    //    that.model.height = newSystem.defaultHeight;
                    //}

                    if (oldValue !== undefined && oldValue !== newValue) {

                        if (newSystem.glasses.filter(function (g) { return g.id === that.model.glassId; }).length == 0) {
                            that.model.glassId = null;
                        }
                        if (newSystem.colors.filter(function (c) { return c.id === that.model.colorId; }).length == 0) {
                            that.model.colorId = null;
                        }

                        that.model.viewIndex = 0;
                    }
                });

                this.$scope.$watch('drawingSectionsForm', function (newValue, oldValue) {
                    if (!oldValue && newValue) {
                        newValue.$setValidity('sectionsCount', that.model.sections.length >= 1);
                    }
                });

                this.$scope.$watch(function () { return that.model; }, function (newValue, oldValue) {
                    if (that.$scope.drawingSectionsForm) {
                        that.$scope.drawingSectionsForm.$setValidity('sectionsCount', that.model.sections.length >= 1);
                    }

                    // reset all confirmations
                    that.confirm = {};

                    that.$timeout(function () {

                        that.drawAndSaveIfValid();

                    }, 1);

                }, true);
            };

            DrawingController.prototype.getPriceWithVAT = function () {
                if (this.vatPercent === null)
                    return this.price;

                return this.price * (1 + (this.vatPercent / 100));
            }

            DrawingController.prototype.getFullDrawingPrice = function () {
                if (this.onlineDrawingDiscount === null)
                    return this.price;

                return this.price * (1 - (this.onlineDrawingDiscount / 100));
            }

            DrawingController.prototype.getFinishPdfName = function (direction) {
                var endType = this.model[direction + 'Type'] === 'Wall' ? 'wall' : 'endpost';
                var angleType = this.model[direction + 'WallAngle'] === null ? '90' : 'other';
                return endType + '-' + direction + '-' + angleType;
            }

            DrawingController.prototype.getFullDrawingPriceWithVAT = function () {
                if (this.onlineDrawingDiscount === null)
                    return this.getPriceWithVAT();

                return this.getFullDrawingPrice() * (1 + (this.vatPercent / 100));
            }

            DrawingController.prototype.getFullDrawingDiscountWithVAT = function () {
                return this.getPriceWithVAT() - this.getFullDrawingPriceWithVAT();
            }

            DrawingController.prototype.gotoPurchase = function () {
                this.selectedTabIndex = 3;
            }

            DrawingController.prototype.openLegend = function (e) {
                var position = this.$mdPanel.newPanelPosition()
                    .relativeTo(e.target)
                    .addPanelPosition(this.$mdPanel.xPosition.ALIGN_END, this.$mdPanel.yPosition.BELOW);

                var config = {
                    attachTo: angular.element(document.body),
                    controllerAs: 'ctrl',
                    template:
                        '<div style="text-align: center; min-width: 400px;">' +
                        '<img src="/images/balustrade-drawing/legend.png" />' +
                        '</div>',
                    panelClass: 'legendPanel',
                    position: position,
                    openFrom: e,
                    clickOutsideToClose: true,
                    escapeToClose: true,
                    focusOnOpen: false,
                    zIndex: 2
                };

                this.$mdPanel.open(config);
            };

            DrawingController.prototype.openFromFile = function () {
                var that = this;

                if (!confirm("Are you sure you want to open a new file?"))
                    return;

                function clickElem(elem) {
                    // Thx user1601638 on Stack Overflow (6/6/2018 - https://stackoverflow.com/questions/13405129/javascript-create-and-save-file )
                    var eventMouse = document.createEvent("MouseEvents");
                    eventMouse.initMouseEvent("click", true, false, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);
                    elem.dispatchEvent(eventMouse);
                }

                function openFile(func) {
                    readFile = function (e) {
                        var file = e.target.files[0];
                        if (!file) {
                            return;
                        }
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            var contents = e.target.result;
                            fileInput.func(contents);
                            document.body.removeChild(fileInput);
                        }
                        reader.readAsText(file);
                    }

                    fileInput = document.createElement("input");
                    fileInput.type = 'file';
                    fileInput.style.display = 'none';
                    fileInput.onchange = readFile;
                    fileInput.func = func;
                    document.body.appendChild(fileInput);
                    clickElem(fileInput);
                }

                openFile(function (contents) {
                    try {

                        var model = JSON.parse(contents);

                        that.$scope.$apply(function () {
                            that.model = model;
                        });

                    } catch (e) {
                        alert("Error opening the file");
                    }
                });
            }

            DrawingController.prototype.openImageHelp = function (ev, src) {
                var that = this;
                var img = new Image();

                img.onload = function () {

                    function DialogController($scope, $mdDialog) {

                        $scope.answer = function (answer) {
                            $mdDialog.hide(answer);
                        };
                    }

                    that.$mdDialog.show({
                        controller: DialogController,
                        template:
                            '<md-dialog-content class="md-dialog-content">' +
                            '<div><img class="help-img" src="' + src + '"></div>' +
                            '</md-dialog-content>' +
                            '<md-dialog-actions style="text-align: right;">' +
                            '<md-button class="md-raised md-accent" target="blank" ng-href="' + src + '">Open in a new tab</md-button>' +
                            '<md-button class="md-raised md-primary" ng-disabled="isDisabled" ng-click="answer(1)">OK</md-button></md-dialog-actions>' +
                            '</md-dialog-actions>',
                        parent: angular.element(document.body),
                        targetEvent: ev,
                        clickOutsideToClose: false
                    });


                };

                img.src = src;
            }
            DrawingController.prototype.openModel = function (ev) {
                console.log("function called")
                var that = this;
                // var img = new Image();

                // img.onload = function () {

                function DialogController($scope, $mdDialog) {

                    $scope.answer = function (answer) {
                        $mdDialog.hide(answer);
                    };
                }

                that.$mdDialog.show({
                    controller: DialogController,
                    templateUrl: "/3DModelPOC.html",
                    parent: angular.element(document.body),
                    targetEvent: ev,
                    clickOutsideToClose: false
                });


                // };

                //img.src = src;
            }
            DrawingController.prototype.saveAsQuote = function () {
                this.drawingInProgress = true;

                this.$http({
                    method: 'POST',
                    url: '/glass-balustrade/create-quote-from-drawing',
                    data: this.model
                }).then(function (response) {
                    window.location.href = "/customer/create-quote?areas=Balustrades";
                });
            }

            DrawingController.prototype.addToCart = function ($event) {
                var that = this;

                var model = jQuery.extend({}, this.model);

                model.quantity = this.quantity;
                model.cartType = this.cartType;

                function DialogController($scope, $mdDialog) {

                    $scope.isDisabled = false;

                    $scope.gotoCart = function () {
                        $scope.isDisabled = true;
                        window.location.href = "/customer/cart?areas=Balustrades";
                    };

                    $scope.answer = function (answer) {
                        $mdDialog.hide(answer);
                    };
                }

                this.drawingInProgress = true;
                this.addToCartInProgress = true;

                this.$http({
                    method: 'POST',
                    url: '/glass-balustrade/add-drawing-to-cart',
                    data: model
                }).then(function (response) {
                    that.cartCount += 1;
                    that.$mdDialog.show({
                        controller: DialogController,
                        template:
                            '<md-dialog-content class="md-dialog-content" style="width: 350px; text-align: center;">' +
                            '<div style="font-weight: bold; font-size: 1.4rem; margin-bottom: 20px;">Great! The balustrade was added to your cart.</div>' +
                            '<div style="font-weight: bold; font-size: 1.2rem; margin-bottom: 15px;">What would you like to do next:</div>' +
                            '<div><md-button class="md-raised md-primary" style="width: 250px;" ng-disabled="isDisabled" ng-click="gotoCart()">Go to Cart</md-button></div>' +
                            '<div><md-button class="md-raised md-accent" style="width: 250px;" ng-disabled="isDisabled" ng-click="answer(1)">Draw a New Balustrade</md-button></div>' +
                            '<div><md-button class="md-raised md-accent" style="width: 250px;" ng-disabled="isDisabled" ng-click="answer()">Duplicate this Balustrade</md-button></div>' +
                            '</md-dialog-content>',
                        parent: angular.element(document.body),
                        targetEvent: $event,
                        clickOutsideToClose: false
                    })
                        .then(function (answer) {
                            if (answer) {
                                that.reset();
                            } else {
                                that.resetView();
                            }
                        });

                }).finally(function () {
                    that.drawingInProgress = false;
                    that.addToCartInProgress = false;
                });
            }

            DrawingController.prototype.saveToFile = function () {

                function download(data, filename, type) {

                    var file = new Blob([data], { type: type });
                    if (window.navigator.msSaveOrOpenBlob) // IE10+
                        window.navigator.msSaveOrOpenBlob(file, filename);
                    else { // Others
                        var a = document.createElement("a"),
                            url = URL.createObjectURL(file);
                        a.href = url;
                        a.download = filename;
                        document.body.appendChild(a);
                        a.click();
                        setTimeout(function () {
                            document.body.removeChild(a);
                            window.URL.revokeObjectURL(url);
                        }, 0);
                    }
                }

                download(JSON.stringify(this.model), "drawing_" + (new Date().valueOf()), "application/json");
            }

            DrawingController.prototype.getDrawingUrl = function (viewIndex) {

                var model = jQuery.extend({}, this.model);
                model.viewIndex = viewIndex;
                return '/glass-balustrade/draw?f=pdf&m=' + btoa(JSON.stringify(model));
            }

            DrawingController.prototype.drawAndSaveIfValid = function () {
                var that = this;

                /*console.log('drawAndSaveIfValid',
                    that.$scope.drawingGeneralForm,
                    that.$scope.drawingGeneralForm.$valid,
                    that.$scope.drawingGeneralForm.systemId.$valid,
                    that.$scope.drawingGeneralForm.colorId.$valid,
                    that.$scope.drawingGeneralForm.glassId.$valid,
                    that.model.systemId,
                    that.model.colorId,
                    that.model.glassId
                    );*/

                if (that.isValid()) {

                    that.saveModelToCookie();
                    that.draw();
                }
            };

            DrawingController.prototype.gotoApproval = function () {
                var that = this;
                this.approvalTabVisible = true;
                this.$timeout(function () {
                    that.selectedTabIndex += 1;
                }, 50);
            }

            DrawingController.prototype.getSystem = function (id) {
                return this.systemsIndex[id === undefined ? this.model.systemId : id];
            }

            DrawingController.prototype.getColor = function (id) {
                var that = this;
                var system = this.getSystem();
                var colors = system && system.colors.filter(function (c) { return c.id === that.model.colorId; });
                return colors && colors.length ? colors[0] : null;
            }

            DrawingController.prototype.getGlass = function (id) {
                var that = this;
                var system = this.getSystem();
                var glasses = system && system.glasses.filter(function (g) { return g.id === that.model.glassId; });
                return glasses && glasses.length ? glasses[0] : null;
            }

            DrawingController.prototype.getViews = function () {
                var system = this.getSystem();;
                var noHandlrail = system && system.noHandrail;
                if (noHandlrail) {
                    return ['Overview', "", 'Bottomrail dimensions', 'Glass dimensions'];
                }
                return ['Overview', 'Handrail dimensions', 'Bottomrail dimensions', 'Glass dimensions'];
            };

            DrawingController.prototype.isValid = function () {
                var that = this;
                return that.model.systemId != undefined && that.model.glassId != undefined && that.model.colorId != undefined &&
                    that.$scope.drawingSectionsForm &&
                    that.$scope.drawingSectionsForm.$valid;
            }

            DrawingController.prototype.resetView = function () {
                this.approvalTabVisible = false;
                this.cartType = 'Full';
                this.quantity = 1;
                this.confirm = {};
            };

            DrawingController.prototype.reset = function () {
                this.resetView();

                this.model = {
                    viewIndex: 0,
                    systemId: null,
                    glassId: null,
                    colorId: null,
                    startType: 'Wall',
                    endType: 'Wall',
                    startWallAngle: null,
                    endWallAngle: null,

                    hrbr: null,
                    brhr: null,
                    wg: null,
                    gw: null,
                    sections: [],

                };
            };

            DrawingController.prototype.startAgain = function () {
                if (!confirm("Are you sure you want to clear the current drawing?"))
                    return;

                this.reset();
            }

            DrawingController.prototype.mirrorSections = function () {
                var that = this;
                this.model.sections.reverse();
                this.model.sections.forEach(function (section) {
                    section.angle = that.cdeg(section.angle * -1);
                });

                var temp = this.model.startType;
                this.model.startType = this.model.endType;
                this.model.endType = temp;

                temp = this.model.startWallAngle;
                this.model.startWallAngle = this.model.endWallAngle !== null ? this.model.endWallAngle * -1 : null;
                this.model.endWallAngle = temp !== null ? temp * -1 : null;

                temp = this.model.hrbr;
                this.model.hrbr = this.model.brhr;
                this.model.brhr = temp;
            };

            //DrawingController.prototype.invertSections = function () {
            //    var that = this;
            //    this.model.sections.reverse();
            //    this.model.sections.forEach(function(section) {
            //        section.angle = that.cdeg(section.angle - 180);
            //        section.ofst = section.ofst ? 0 : that.getSystem().handrailSystemWidth
            //    });

            //    var temp = this.model.startType;
            //    this.model.startType = this.model.endType;
            //    this.model.endType = temp;

            //    temp = this.model.startWallAngle;
            //    this.model.startWallAngle = this.model.endWallAngle;
            //    this.model.endWallAngle = temp;

            //    temp = this.model.hrbr;
            //    this.model.hrbr = this.model.brhr;
            //    this.model.brhr = temp;
            //};

            DrawingController.prototype.cdeg = function (deg) {
                
                var res = deg % 360;
                if (res < 0) {
                    res = 360 + res;
                }
                return res;
            };

            DrawingController.prototype.draw = function () {

                var that = this;
                this.drawingInProgress = true;

                this.lastReqId += 1;
                var req = this.lastReqId;

                if (this.drawingCanceler) {
                    this.drawingCanceler.resolve();
                }

                this.drawingCanceler = this.$q.defer();

                this.$http({
                    method: 'GET',
                    url: '/glass-balustrade/draw?m=' + btoa(JSON.stringify(this.model)),
                    timeout: this.drawingCanceler.promise
                }).then(function (response) {
                    if (req === that.lastReqId) {
                        that.svg = response.data.svg;

                        that.price = response.data.price;
                        that.vatPercent = response.data.vatPercent;
                        that.onlineDrawingDiscount = response.data.onlineDrawingDiscount;

                        that.withPosts = response.data.withPosts;
                    }
                }).finally(function () {
                    if (req === that.lastReqId) {
                        that.drawingInProgress = false;
                    }
                });
            };

            DrawingController.prototype.addSectionClick = function () {
                var that = this;

                if (this.model.sections.length >= 10)
                    return;

                var lastAngle = this.model.sections.length > 0 ? this.model.sections[this.model.sections.length - 1].angle : 90;
                this.model.sections.push({
                    angle: this.cdeg(lastAngle - 90)
                });

                this.$timeout(function () {
                    var objDiv = document.getElementById("sectionsScrollWrapper");
                    objDiv.scrollTop = objDiv.scrollHeight;

                    $('[name="sectionLength' + (that.model.sections.length - 1) + '"]').focus();

                }, 500);
            };

            DrawingController.prototype.removeSectionClick = function (index) {
                this.model.sections.splice(index, 1);
            };

            DrawingController.prototype.selectModel = function (mdl) {

                var that = this;

                if (that.model.sections.length > 0 && JSON.stringify(that.model.sections.map(function (s) {
                    return s.angle;
                })) !== JSON.stringify(mdl.sections.map(function (s) {
                    return s.angle;
                }))) {
                    if (!confirm("Are you sure you want to change the model?"))
                        return;
                }

                that.model.sections = jQuery.extend(true, [], mdl.sections);

                that.model.startType = 'Wall';
                that.model.endType = 'Wall';
                that.model.startWallAngle = null;
                that.model.endWallAngle = null;
                that.model.hrbr = null;
                that.model.brhr = null;
                that.model.wg = null;
                that.model.gw = null;
                document.getElementById("colorId").value = that.model.colorId;
               
                
                that.selectedTabIndex = 2;
            };

            DrawingController.prototype.saveModelToCookie = function () {
                this.setCookie('balLastModel', JSON.stringify(this.model));
            }

            DrawingController.prototype.generalNextClick = function (index) {
                if (this.$scope.drawingGeneralForm.$invalid)
                    return;

                this.saveModelToCookie();
                this.selectedTabIndex = 1;
            };

            DrawingController.prototype.getColorId = function (res) {
                var that = this;
                document.getElementById("colorId").value = that.model.colorId;
                
                //vm.getSystem().colors 
            }

            function DrawingPanelController($scope, $element, $attrs) {

                var that = this;

                var wrap = $($element).find('.svgWrap');

                $scope.$watch(function () { return that.svg; }, function (newValue, oldValue) {

                    if (newValue) {
                        wrap.html(newValue);
                        var svg = wrap.find('svg');
                        svg.css('width', '100%');
                        //svg.css('min-height', '300px');
                        svg.css('background-color', '#fff');
                        svg.css('flex-grow', '1');


                        that.svgPanZoom = svgPanZoom(svg[0], {
                            zoomEnabled: true,
                            controlIconsEnabled: true,
                            fit: true,
                            center: true,
                            minZoom: 0.01,
                            maxZoom: 1000
                        });
                    }

                });
            }

            function ReadyModelController($scope, $element, $attrs, $timeout) {

                var that = this;

                var wrap = $($element).find('svg');

                function degrees_to_radians(degrees) {
                    var pi = Math.PI;
                    return degrees * (pi / 180);
                }

                $scope.$watch(function () { return that.model; }, function (newValue, oldValue) {

                    if (newValue) {

                        var path = 'M0 0 ';

                        newValue.sections.forEach(function (section) {

                            var angle = degrees_to_radians(section.angle);
                            var x = Math.round(section.length * Math.cos(angle));
                            var y = -Math.round(section.length * Math.sin(angle));

                            path += 'l' + x + ' ' + y + ' ';

                        });

                        wrap.html('<path d="' + path + '" fill="rgba(0,0,0,0)" stroke="#000" stroke-width="40"></path>');

                        $timeout(function () {
                            that.svgPanZoom = svgPanZoom(wrap[0],
                                {
                                    fit: true,
                                    center: true,
                                    panEnabled: false,
                                    zoomEnabled: false
                                });

                            that.svgPanZoom.zoom(0.9);
                        }, 500);
                    }

                }, true);
            }

            function OnlyNumbersDirective() {
                return {
                    restrict: 'A',
                    link: function (scope, elm, attrs, ctrl) {
                        elm.on('keypress',
                            function (e) {
                                var charCode = (e.keyCode ? e.keyCode : e.which);
                                if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                                    e.preventDefault();
                                    return false;
                                }
                                return true;
                            });
                    }
                }
            }

            angular.module('app', ['ngAnimate', 'ngMaterial', 'ngMessages', 'material.svgAssetsCache', 'ngSanitize'])
                .config(function ($mdThemingProvider) {
                    $mdThemingProvider.theme('default')
                        .primaryPalette('purple')
                        .accentPalette('indigo')
                        .warnPalette('red')
                        .backgroundPalette('grey');

                })
                .controller('DrawingController', DrawingController)
                .component('drawingPanel',
                    {
                        template: '<div class="svgWrap" style="flex-grow: 1; display: flex; flex-direction: column;"></div>',
                        controller: DrawingPanelController,
                        bindings: {
                            svg: '<'
                        }
                    })
                .component('readyModel',
                    {
                        template: '<svg xmlns="http://www.w3.org/2000/svg" width="200" height="100" version="1.1"></svg></div>',
                        controller: ReadyModelController,
                        bindings: {
                            model: '<'
                        }
                    })

                .directive('onlyNumbers', OnlyNumbersDirective);

        })();


        function showModal() {
            $('#myModal').modal('show');
        }
        function convertToImg(canvasObj) {
            var image = new Image();
            //image.src = canvasObj.toDataURL("image/png");
            //return image;
            $('#imgPreview').attr("src", canvasObj.toDataURL("image/png"));

           // $("#height").text($("#input_15").val());

            //console.log(image);
        }

         
        function railingColor()
        {
            var val = document.getElementById("colorId").value;

            var r=0;
            var g=0;
            var b=0;
            var chrome=0
            if(val==1)
            {
                r=250;
                g=250;
                b=250;
            }
            else if(val==2)
            {
                r=125;
                g=108;
                b=95;
            }
           else if(val==3)
            {
               r=180;
               g=180;
               b=180;
            }
           else if(val==4)
            {
               r=150;
               g=150;
               b = 150;
                chrome=1;
               
            }

            var color=[r,g,b,chrome]
            return color;           

        }

        let angle = 0;
        let bg;
        let img;
        var sacleObj = 1.5;
        var scalePoint = 1;
        var isdummyCanvas = true;
        let nutrual = 180;
        let newAngle = 0;
        let myFont;

        $(document).on('click', '#btnzoomin', function () {
            var val = document.getElementById("colorId").value;
           

            if (scalePoint > 0.95) {
                scalePoint = .95;
            }
            else
            {
                scalePoint *= 1.05;
            }

        });
        $(document).on('click', '#btnzoomout', function () {
            if (scalePoint <= 0.5) {
                scalePoint = 0.5;
            }
            else
            {
                scalePoint *= 0.95;
            }
            scalePoint = scalePoint - 1 * 0.05;
        });
        $(document).on('click', '#btnreset', function () {
            scalePoint = 1;
        });
        $("#myModal").on("hidden.bs.modal", function () {
            scalePoint = 1;
        });

        function draw3D(recX,recY,recWidth,recHeight,translate_x,translate_y,translate_z,angle) 
      {
		for (i=0; i<= angle.length-1; i++)
		{
		
			if(i==0)
			{
			
				//SECOND  [0]
                translate(-190,0,0);     

				fill(179, 204, 255);
				translate(translate_x,translate_y,translate_z);     
				rotateY(radians(angle[i].angle));
				newAngle = nutrual - (angle[i].angle);
				stroke(51);
				rect(recX,recY,recWidth,recHeight);
			}
			else
			{
                //THIRD
                fill(179, 204, 255);
				translate(translate_x,translate_y,translate_z);
				rotateY(radians(angle[i].angle - (nutrual - newAngle)));
				newAngle = nutrual - (angle[i].angle);
				stroke(51);
				rect(recX,recY,recWidth,recHeight);						
			}
			
		}	 
 }        
        function setup() {
             //create dummy canvas            
            let dummyCanvas = createCanvas(864, 100, WEBGL);
            dummyCanvas.id('dummycanvas');

            let cnv = createCanvas(864, 500, WEBGL);
            cnv.id('mycanvas');
            cnv.parent("#canvas");

            //fill('#ED225D');
            textFont(myFont);
            textSize(15);
            text('p5*js', 10, 50);
           
        }
        function preload() {
          myFont = loadFont('../../Asset/Inconsolata.otf');
        }
        function draw() {
           var railingcolor= railingColor();
            dummycanvas = mycanvas;
            if(isdummyCanvas)
            convertToImg(dummycanvas);
            
            //for zoom the canvas
            scale(sacleObj);
            scale(scalePoint);

            background(230);
            fill(0);
            push();

           
            //main line
            line(-170, -60, -170, 60);
            triangle(-175, -60, -170, -70, -165, -60);

            triangle(-175,60,-170,70,-165,60);

            push();
            let height = $("#input_15").val();
            textSize(12);
            rotate(10.99);
            text('Height:'+height,-30, -175);
            fill(0, 102, 153);
            pop();
            

            rotateY(mouseX * 0.01);
            //rotateX(mouseY *0.01);
            

            let locX = mouseX - height / 2;
            let locY = mouseY - width / 2;
            //ambientLight(60, 60, 60);
            //pointLight(255, 255, 255, 0, -200, 100);

            ambientLight(224, 224, 235);
		    pointLight(179, 204, 255, mouseX, mouseY, 100);
		
            //Rectengle
		     var recX=0;
		     var recY=0;
		     var recWidth=55;
		     var recHeight=55;
		     
		     //Translation
		     var translate_x=56;
		     var translate_y=0;
		     var translate_z=0;
		     
		     //Angles	
	         //var angle=[90,68,45,22,0,-22,-45,-68,-90];
	         var angle=[0,90,45,0,315,270];    
           
		     draw3D(recX,recY,recWidth,recHeight,translate_x,translate_y,translate_z,angleArray);
    

                
                 //panel 1
            //push();
            //translate(0, -50, 0);
            //rotateX(PI / 2);
            //if (railingcolor[3] == 1)
            //{
            //    specularMaterial(railingcolor[0], railingcolor[1], railingcolor[2]);
            //}
            //else
            //{
            //    ambientMaterial(railingcolor[0], railingcolor[1], railingcolor[2]);
            //}
                      
            //cylinder(3, 90, 100);
            //pop();

            //push();
            //translate(0, 0, 0);
            //  fill(73, 129, 230, 50);
            
            //box(3, 100, 80, 100);

            ////panel 2
            //pop();
            //push();
            //translate(-31, -50, 75);
            //rotateY(-PI / 4);
            //rotateX(PI / 2);
            //if (railingcolor[3] == 1) {
            //    specularMaterial(railingcolor[0], railingcolor[1], railingcolor[2]);
            //}
            //else 
            //{
            //    ambientMaterial(railingcolor[0], railingcolor[1], railingcolor[2]);
            //}
            //cylinder(3, 90, 100);
            //pop();
            //push();
            //translate(-31, 0, 75);
            //fill(73, 129, 230, 50);
            //rotateY(-PI / 4);
            //box(3, 100, 80, 100);

            ////pane1 3
            //pop();

            //push();
            //translate(-31, -50, -75);
            //rotateY(radians(45));
            //rotateX(PI / 2);
         
            //if (railingcolor[3] == 1)
            //{
            //    specularMaterial(railingcolor[0], railingcolor[1], railingcolor[2]);
            //}
            //else
            //{
            //    ambientMaterial(railingcolor[0], railingcolor[1], railingcolor[2]);
            //}
            //cylinder(3, 90, 100);
            //pop();
            //push();
            //translate(-31, 0, -75);
            //fill(73, 129, 230, 50);
            //rotateY(PI / 4);
            //box(3, 100, 80, 100)
            //pop();

            //angle = angle + 1;
           
        }   


        window.addEventListener("wheel", function (e) {
            isdummyCanvas = false;
            this.console.log("scalepoint" + scalePoint);
            if (e.deltaY > 0) {

                //If size is increase 
                if (scalePoint > 0.95) {
                    scalePoint = 0.95;
                }
                scalePoint *= 1.05;

            }
            else if (scalePoint <= 0.50)
                 scalePoint = 0.50;
            else
                scalePoint *= 0.95;
        });

    </script>




 <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog" >
    <div class="modal-dialog modal-lg">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">3D View</h4>
        </div>
        <div class="modal-body">
           <%-- <label>Height:</label>
            <label id="height"></label>--%>
        <div id="canvas"></div> 
        </div>
        <div class="modal-footer">
            <button type="button" id="btnzoomin" class="btn"  style="background-color: gray; color: white;font-weight: bold;" >+</button>
            <button type="button" id="btnreset"  class="btn"  style="background-color: gray; color: white;font-weight: bold;"  >RESET</button>
            <button type="button" id="btnzoomout"  class="btn"  style="background-color: gray; color: white;font-weight: bold;"  >-</button>

         <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>

   
</body>
</html>
