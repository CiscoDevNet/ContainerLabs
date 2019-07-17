$(function() {
    $( "#mainTabs" ).tabs({ active: 0 });
    $( "#prodOPTabs" ).tabs();
    $( "#consOPTabs" ).tabs();
    $( "#prodIPTabs" ).tabs();
    $( "#consIPTabs" ).tabs();

    $( "#mainOPAcc" ).accordion({
        heightStyle: "content"
    });
    $( "#mainIPAcc" ).accordion({
        heightStyle: "content"
    });
    $( "#prodOPAcc" ).accordion({
        heightStyle: "content"
    });
    $( "#consOPAcc" ).accordion({
        heightStyle: "content"
    });
    $( "#prodIPAcc" ).accordion({
        heightStyle: "content"
    });
    $( "#consIPAcc" ).accordion({
        heightStyle: "content"
    });

    $( "input[type=submit]" )
        .button()
        .click(function( event ) {
            event.preventDefault();
        });

    $( "#prodOPParamTypes" ).hide();
    $( "#prodOPAccessType" ).change(function(){
        $("#prodOPAccessType option:selected").each(function () {
            if ($(this).text() == "field") {
                $( "#prodOPFieldAccessLabel" ).html("Field Name:");
                $( "#prodOPParamTypeLabel" ).html("Parameter Type:");
                $( "#prodOPParamSelectLabel" ).show();
                $( "#prodOPParamTypes" ).hide();
            } else if ($(this).text() == "method") {
                $( "#prodOPFieldAccessLabel" ).html("Access Method Name:");
                $( "#prodOPParamTypeLabel" ).html("Comma Separated Parameter Types:");
                $( "#prodOPParamSelectLabel" ).hide();
                $( "#prodOPParamTypes" ).show();
            } else if ($(this).text() == "getter-chain") {
                $( "#prodOPFieldAccessLabel" ).html("Access Getter Chain:");
                $( "#prodOPParamTypeLabel" ).html("Comma Separated Parameter Types:");
                $( "#prodOPParamSelectLabel" ).hide();
                $( "#prodOPParamTypes" ).show();
            }
        });
    });

    $( "#consOPParamTypes" ).hide();
    $( "#consOPAccessType" ).change(function(){
        $("#consOPAccessType option:selected").each(function () {
            if ($(this).text() == "field") {
                $( "#consOPFieldAccessLabel" ).html("Field Name:");
                $( "#consOPParamTypeLabel" ).html("Parameter Type:");
                $( "#consOPParamSelectLabel" ).show();
                $( "#consOPParamTypes" ).hide();
            } else if ($(this).text() == "method") {
                $( "#consOPFieldAccessLabel" ).html("Access Method Name:");
                $( "#consOPParamTypeLabel" ).html("Comma Separated Parameter Types:");
                $( "#consOPParamSelectLabel" ).hide();
                $( "#consOPParamTypes" ).show();
            } else if ($(this).text() == "getter-chain") {
                $( "#consOPFieldAccessLabel" ).html("Access Getter Chain:");
                $( "#consOPParamTypeLabel" ).html("Comma Separated Parameter Types:");
                $( "#consOPParamSelectLabel" ).hide();
                $( "#consOPParamTypes" ).show();
            }
        });
    });

    $( "#prodIPParamTypes" ).hide();
    $( "#prodIPAccessType" ).change(function(){
        $("#prodIPAccessType option:selected").each(function () {
            if ($(this).text() == "field") {
                $( "#prodIPFieldAccessLabel" ).html("Field Name:");
                $( "#prodIPParamTypeLabel" ).html("Parameter Type:");
                $( "#prodIPParamSelectLabel" ).show();
                $( "#prodIPParamTypes" ).hide();
            } else if ($(this).text() == "method") {
                $( "#prodIPFieldAccessLabel" ).html("Access Method Name:");
                $( "#prodIPParamTypeLabel" ).html("Comma Separated Parameter Types:");
                $( "#prodIPParamSelectLabel" ).hide();
                $( "#prodIPParamTypes" ).show();
            } else if ($(this).text() == "getter-chain") {
                $( "#prodIPFieldAccessLabel" ).html("Access Getter Chain:");
                $( "#prodIPParamTypeLabel" ).html("Comma Separated Parameter Types:");
                $( "#prodIPParamSelectLabel" ).hide();
                $( "#prodIPParamTypes" ).show();
            }
        });
    });

    $( "#consIPParamTypes" ).hide();
    $( "#consIPAccessType" ).change(function(){
        $("#consIPAccessType option:selected").each(function () {
            if ($(this).text() == "field") {
                $( "#consIPFieldAccessLabel" ).html("Field Name:");
                $( "#consIPParamTypeLabel" ).html("Parameter Type:");
                $( "#consIPParamSelectLabel" ).show();
                $( "#consIPParamTypes" ).hide();
            } else if ($(this).text() == "method") {
                $( "#consIPFieldAccessLabel" ).html("Access Method Name:");
                $( "#consIPParamTypeLabel" ).html("Comma Separated Parameter Types:");
                $( "#consIPParamSelectLabel" ).hide();
                $( "#consIPParamTypes" ).show();
            } else if ($(this).text() == "getter-chain") {
                $( "#consIPFieldAccessLabel" ).html("Access Getter Chain:");
                $( "#consIPParamTypeLabel" ).html("Comma Separated Parameter Types:");
                $( "#consIPParamSelectLabel" ).hide();
                $( "#consIPParamTypes" ).show();
            }
        });
    });

    $( "#prodOPCorrType" ).change(function(){
        $("#prodOPCorrType option:selected").each(function () {
            if ($(this).text() == "Method Parameter at Position") {
                $( "#prodOPPosNoLabel" ).show();
                $( "#prodOPPosNo" ).show();
            } else if ($(this).text() == "Invoked Object") {
                $( "#prodOPPosNoLabel" ).hide();
                $( "#prodOPPosNo" ).hide();
            } else if ($(this).text() == "Return Value") {
                $( "#prodOPPosNoLabel" ).hide();
                $( "#prodOPPosNo" ).hide();
            }
        });
    });

    $( "#consOPCorrType" ).change(function(){
        $("#consOPCorrType option:selected").each(function () {
            if ($(this).text() == "Method Parameter at Position") {
                $( "#consOPPosNoLabel" ).show();
                $( "#consOPPosNo" ).show();
            } else if ($(this).text() == "Invoked Object") {
                $( "#consOPPosNoLabel" ).hide();
                $( "#consOPPosNo" ).hide();
            } else if ($(this).text() == "Return Value") {
                $( "#consOPPosNoLabel" ).hide();
                $( "#consOPPosNo" ).hide();
            }
        });
    });

    $( "#prodIPCorrType" ).change(function(){
        $("#prodIPCorrType option:selected").each(function () {
            if ($(this).text() == "Method Parameter at Position") {
                $( "#prodIPPosNoLabel" ).show();
                $( "#prodIPPosNo" ).show();
            } else if ($(this).text() == "Invoked Object") {
                $( "#prodIPPosNoLabel" ).hide();
                $( "#prodIPPosNo" ).hide();
            } else if ($(this).text() == "Return Value") {
                $( "#prodIPPosNoLabel" ).hide();
                $( "#prodIPPosNo" ).hide();
            }
        });
    });

    $( "#consIPCorrType" ).change(function(){
        $("#consIPCorrType option:selected").each(function () {
            if ($(this).text() == "Method Parameter at Position") {
                $( "#consIPPosNoLabel" ).show();
                $( "#consIPPosNo" ).show();
            } else if ($(this).text() == "Invoked Object") {
                $( "#consIPPosNoLabel" ).hide();
                $( "#consIPPosNo" ).hide();
            } else if ($(this).text() == "Return Value") {
                $( "#consIPPosNoLabel" ).hide();
                $( "#consIPPosNo" ).hide();
            }
        });
    });

    $( "#customExitCorrType" ).change(function(){
        $("#customExitCorrType option:selected").each(function () {
            if ($(this).text() == "Method Parameter at Position") {
                $( "#customExitPosNoLabel" ).show();
                $( "#customExitPosNo" ).show();
            } else if ($(this).text() == "Invoked Object") {
                $( "#customExitPosNoLabel" ).hide();
                $( "#customExitPosNo" ).hide();
            } else if ($(this).text() == "Return Value") {
                $( "#customExitPosNoLabel" ).hide();
                $( "#customExitPosNo" ).hide();
            }
        });
    });

    $( "#customExitTransformerType" ).change(function(){
        $("#customExitTransformerType option:selected").each(function () {
            if ($(this).text() == "Getter Chain") {
                $( "#customExitGetterChainLabel" ).show();
                $( "#customExitGetterChain" ).show();
                $( "#customExitGetterChainLabel" ).html("Getter Chain:");
            } else if ($(this).text() == "ToString") {
                $( "#customExitGetterChainLabel" ).hide();
                $( "#customExitGetterChain" ).hide();
            } else if ($(this).text() == "User Defined Name") {
                $( "#customExitGetterChainLabel" ).show();
                $( "#customExitGetterChain" ).show();
                $( "#customExitGetterChainLabel" ).html("User Defined Name:");
            } else if ($(this).text() == "Simple Class Name") {
                $( "#customExitGetterChainLabel" ).hide();
                $( "#customExitGetterChain" ).hide();
            } else if ($(this).text() == "Field Name") {
                $( "#customExitGetterChainLabel" ).show();
                $( "#customExitGetterChain" ).show();
                $( "#customExitGetterChainLabel" ).html("Field Name:");
            }
        });
    });

    $( "#prodOPTransformerType" ).change(function(){
        $("#prodOPTransformerType option:selected").each(function () {
            if ($(this).text() == "Getter Chain") {
                $( "#prodOPGetterChainLabel" ).show();
                $( "#prodOPGetterChain" ).show();
                $( "#prodOPGetterChainLabel" ).html("Getter Chain:");
            } else if ($(this).text() == "ToString") {
                $( "#prodOPGetterChainLabel" ).hide();
                $( "#prodOPGetterChain" ).hide();
            } else if ($(this).text() == "User Defined Name") {
                $( "#prodOPGetterChainLabel" ).show();
                $( "#prodOPGetterChain" ).show();
                $( "#prodOPGetterChainLabel" ).html("User Defined Name:");
            } else if ($(this).text() == "Simple Class Name") {
                $( "#prodOPGetterChainLabel" ).hide();
                $( "#prodOPGetterChain" ).hide();
            } else if ($(this).text() == "Field Name") {
                $( "#prodOPGetterChainLabel" ).show();
                $( "#prodOPGetterChain" ).show();
                $( "#prodOPGetterChainLabel" ).html("Field Name:");
            }
        });
    });

    $( "#consOPTransformerType" ).change(function(){
        $("#consOPTransformerType option:selected").each(function () {
            if ($(this).text() == "Getter Chain") {
                $( "#consOPGetterChainLabel" ).show();
                $( "#consOPGetterChain" ).show();
                $( "#consOPGetterChainLabel" ).html("Getter Chain:");
            } else if ($(this).text() == "ToString") {
                $( "#consOPGetterChainLabel" ).hide();
                $( "#consOPGetterChain" ).hide();
            } else if ($(this).text() == "User Defined Name") {
                $( "#consOPGetterChainLabel" ).show();
                $( "#consOPGetterChain" ).show();
                $( "#consOPGetterChainLabel" ).html("User Defined Name:");
            } else if ($(this).text() == "Simple Class Name") {
                $( "#consOPGetterChainLabel" ).hide();
                $( "#consOPGetterChain" ).hide();
            } else if ($(this).text() == "Field Name") {
                $( "#consOPGetterChainLabel" ).show();
                $( "#consOPGetterChain" ).show();
                $( "#consOPGetterChainLabel" ).html("Field Name:");
            }
        });
    });

    $( "#prodIPTransformerType" ).change(function(){
        $("#prodIPTransformerType option:selected").each(function () {
            if ($(this).text() == "Getter Chain") {
                $( "#prodIPGetterChainLabel" ).show();
                $( "#prodIPGetterChain" ).show();
                $( "#prodIPGetterChainLabel" ).html("Getter Chain:");
            } else if ($(this).text() == "ToString") {
                $( "#prodIPGetterChainLabel" ).hide();
                $( "#prodIPGetterChain" ).hide();
            } else if ($(this).text() == "User Defined Name") {
                $( "#prodIPGetterChainLabel" ).show();
                $( "#prodIPGetterChain" ).show();
                $( "#prodIPGetterChainLabel" ).html("User Defined Name:");
            } else if ($(this).text() == "Simple Class Name") {
                $( "#prodIPGetterChainLabel" ).hide();
                $( "#prodIPGetterChain" ).hide();
            } else if ($(this).text() == "Field Name") {
                $( "#prodIPGetterChainLabel" ).show();
                $( "#prodIPGetterChain" ).show();
                $( "#prodIPGetterChainLabel" ).html("Field Name:");
            }
        });
    });

    $( "#consIPTransformerType" ).change(function(){
        $("#consIPTransformerType option:selected").each(function () {
            if ($(this).text() == "Getter Chain") {
                $( "#consIPGetterChainLabel" ).show();
                $( "#consIPGetterChain" ).show();
                $( "#consIPGetterChainLabel" ).html("Getter Chain:");
            } else if ($(this).text() == "ToString") {
                $( "#consIPGetterChainLabel" ).hide();
                $( "#consIPGetterChain" ).hide();
            } else if ($(this).text() == "User Defined Name") {
                $( "#consIPGetterChainLabel" ).show();
                $( "#consIPGetterChain" ).show();
                $( "#consIPGetterChainLabel" ).html("User Defined Name:");
            } else if ($(this).text() == "Simple Class Name") {
                $( "#consIPGetterChainLabel" ).hide();
                $( "#consIPGetterChain" ).hide();
            } else if ($(this).text() == "Field Name") {
                $( "#consIPGetterChainLabel" ).show();
                $( "#consIPGetterChain" ).show();
                $( "#consIPGetterChainLabel" ).html("Field Name:");
            }
        });
    });

    $( "#createXML" ).click(function(){
        createXML();
    });

    function createXML() {
        var xw = new XMLWriter('UTF-8');
        xw.formatting = 'indented'; // add indentation and newlines
        xw.indentChar = ' '; // indent with spaces
        xw.indentation = 4; // add 4 spaces per level

        xw.writeStartDocument();
            xw.writeStartElement('activities');
            var activeTab = $( "#mainTabs" ).tabs( "option", "active" );
            if (activeTab == "0") {
                xw.writeStartElement('producer');
                    xw.writeStartElement('instrumentation');
                        xw.writeElementString('class-name', $("#prodOPEPClassName").val());
                        xw.writeElementString('method-name', $("#prodOPEPMethodName").val());
                        xw.writeElementString('match-type', $("#prodOPEPMatchType").val());
                        xw.writeElementString('method-parameter-types', $("#prodOPEPMethodPars").val());
                    xw.writeEndElement();

                    if ($("#customExitPointName").val() != "") {
                        xw.writeStartElement('identifiers');
                            xw.writeStartElement('identifier');
                                xw.writeElementString('name', $("#customExitPointName").val());
                                xw.writeElementString('data-gatherer-type', $("#customExitCorrType").val());
                                if ($("#customExitCorrType").val() == "POSITION") {
                                    xw.writeElementString('position', $("#customExitPosNo").val());
                                }
                                xw.writeElementString('transformer-type', $("#customExitTransformerType").val());
                                if ($("#customExitTransformerType").val() == "GETTER_METHODS") {
                                    xw.writeElementString('getter-chain', $("#customExitGetterChain").val());
                                } else if ($("#customExitTransformerType").val() == "USER_DEFINED_NAME") {
                                    xw.writeElementString('user-defined-name', $("#customExitGetterChain").val());
                                } else if ($("#customExitTransformerType").val() == "FIELD_NAME") {
                                    xw.writeElementString('field-name', $("#customExitGetterChain").val());
                                }
                            xw.writeEndElement();
                        xw.writeEndElement();
                    }

                    xw.writeStartElement('correlation');
                        if ($("#prodOPCPClassName").val() != "") {
                            xw.writeStartElement('instrumentation');
                            xw.writeElementString('class-name', $("#prodOPCPClassName").val());
                            xw.writeElementString('method-name', $("#prodOPCPMethodName").val());
                            xw.writeElementString('match-type', $("#prodOPCPMatchType").val());
                            xw.writeElementString('method-parameter-types', $("#prodOPCPMethodPars").val());
                            xw.writeEndElement();
                        }
                        xw.writeStartElement('payload-pointer');
                            xw.writeElementString('data-gatherer-type', $("#prodOPCorrType").val());
                            if ($("#prodOPCorrType").val() == "POSITION") {
                                xw.writeElementString('position', $("#prodOPPosNo").val());
                            }
                            xw.writeElementString('transformer-type', $("#prodOPTransformerType").val());
                            if ($("#prodOPTransformerType").val() == "GETTER_METHODS") {
                                xw.writeElementString('getter-chain', $("#prodOPGetterChain").val());
                            } else if ($("#prodOPTransformerType").val() == "USER_DEFINED_NAME") {
                                xw.writeElementString('user-defined-name', $("#prodOPGetterChain").val());
                            } else if ($("#prodOPTransformerType").val() == "FIELD_NAME") {
                                xw.writeElementString('field-name', $("#prodOPGetterChain").val());
                            }
                        xw.writeEndElement();
                        xw.writeStartElement('payload-operation');
                            xw.writeElementString('access-type', $("#prodOPAccessType").val());
                            if ( $("#prodOPAccessType").val() == "field") {
                                xw.writeElementString('param-types', $("#prodOPParamType").val());
                                xw.writeElementString('field-name', $("#prodOPFieldAccessName").val());
                            } else {
                                xw.writeElementString('param-types', $("#prodOPParamTypes").val());
                                xw.writeElementString('access-method', $("#prodOPFieldAccessName").val());
                            }
                        xw.writeEndElement();
                    xw.writeEndElement();
                xw.writeEndElement();

                xw.writeStartElement('consumer');
                    var attType=$('input:radio[name=consOPCPType]:checked').val();
                    if ( attType == "pojo-entry") {
                        xw.writeAttributeString(attType, 'true');
                    }
                    if ( attType == "activity-demarcator") {
                        xw.writeAttributeString(attType, 'true');
                    }
                    xw.writeStartElement('instrumentation');
                        xw.writeElementString('class-name', $("#consOPEPClassName").val());
                        xw.writeElementString('method-name', $("#consOPEPMethodName").val());
                        xw.writeElementString('match-type', $("#consOPEPMatchType").val());
                        xw.writeElementString('method-parameter-types', $("#consOPEPMethodPars").val());
                    xw.writeEndElement();

                    xw.writeStartElement('correlation');
                        if ($("#consOPCPClassName").val() != "") {
                            xw.writeStartElement('instrumentation');
                            xw.writeElementString('class-name', $("#consOPCPClassName").val());
                            xw.writeElementString('method-name', $("#consOPCPMethodName").val());
                            xw.writeElementString('match-type', $("#consOPCPMatchType").val());
                            xw.writeElementString('method-parameter-types', $("#consOPCPMethodPars").val());
                            xw.writeEndElement();
                        }
                        xw.writeStartElement('payload-pointer');
                            xw.writeElementString('data-gatherer-type', $("#consOPCorrType").val());
                            if ($("#consOPCorrType").val() == "POSITION") {
                                xw.writeElementString('position', $("#consOPPosNo").val());
                            }
                            xw.writeElementString('transformer-type', $("#consOPTransformerType").val());
                            if ($("#consOPTransformerType").val() == "GETTER_METHODS") {
                                xw.writeElementString('getter-chain', $("#consOPGetterChain").val());
                            } else if ($("#consOPTransformerType").val() == "USER_DEFINED_NAME") {
                                xw.writeElementString('user-defined-name', $("#consOPGetterChain").val());
                            } else if ($("#consOPTransformerType").val() == "FIELD_NAME") {
                                xw.writeElementString('field-name', $("#consOPGetterChain").val());
                            }
                        xw.writeEndElement();
                        xw.writeStartElement('payload-operation');
                            xw.writeElementString('access-type', $("#consOPAccessType").val());
                            if ( $("#consOPAccessType").val() == "field") {
                                xw.writeElementString('param-types', $("#consOPParamType").val());
                                xw.writeElementString('field-name', $("#consOPFieldAccessName").val());
                            } else {
                                xw.writeElementString('param-types', $("#consOPParamTypes").val());
                                xw.writeElementString('access-method', $("#consOPFieldAccessName").val());
                            }
                        xw.writeEndElement();
                    xw.writeEndElement();
                xw.writeEndElement();
            } else {
                xw.writeStartElement('producer');
                    xw.writeAttributeString('in-process', 'true');
                    xw.writeStartElement('instrumentation');
                        xw.writeElementString('class-name', $("#prodIPEPClassName").val());
                        xw.writeElementString('method-name', $("#prodIPEPMethodName").val());
                        xw.writeElementString('match-type', $("#prodIPEPMatchType").val());
                        xw.writeElementString('method-parameter-types', $("#prodIPEPMethodPars").val());
                    xw.writeEndElement();

                    xw.writeStartElement('correlation');
                        if ($("#prodIPCPClassName").val() != "") {
                            xw.writeStartElement('instrumentation');
                            xw.writeElementString('class-name', $("#prodIPCPClassName").val());
                            xw.writeElementString('method-name', $("#prodIPCPMethodName").val());
                            xw.writeElementString('match-type', $("#prodIPCPMatchType").val());
                            xw.writeElementString('method-parameter-types', $("#prodIPCPMethodPars").val());
                            xw.writeEndElement();
                        }
                        xw.writeStartElement('payload-pointer');
                            xw.writeElementString('data-gatherer-type', $("#prodIPCorrType").val());
                            if ($("#prodIPCorrType").val() == "POSITION") {
                                xw.writeElementString('position', $("#prodIPPosNo").val());
                            }
                            xw.writeElementString('transformer-type', $("#prodIPTransformerType").val());
                            if ($("#prodIPTransformerType").val() == "GETTER_METHODS") {
                                xw.writeElementString('getter-chain', $("#prodIPGetterChain").val());
                            } else if ($("#prodIPTransformerType").val() == "USER_DEFINED_NAME") {
                                xw.writeElementString('user-defined-name', $("#prodIPGetterChain").val());
                            } else if ($("#prodIPTransformerType").val() == "FIELD_NAME") {
                                xw.writeElementString('field-name', $("#prodIPGetterChain").val());
                            }
                        xw.writeEndElement();
                        xw.writeStartElement('payload-operation');
                            xw.writeElementString('access-type', $("#prodIPAccessType").val());
                            if ( $("#prodIPAccessType").val() == "field") {
                                xw.writeElementString('param-types', $("#prodIPParamType").val());
                                xw.writeElementString('field-name', $("#prodIPFieldAccessName").val());
                            } else {
                                xw.writeElementString('param-types', $("#prodIPParamTypes").val());
                                xw.writeElementString('access-method', $("#prodIPFieldAccessName").val());
                            }
                        xw.writeEndElement();
                    xw.writeEndElement();
                xw.writeEndElement();

                xw.writeStartElement('consumer');
                xw.writeAttributeString('in-process', 'true');
                    var attType=$('input:checkbox[name=consIPCPType]:checked').val();
                    if ( attType == "activity-processed-in-loop") {
                        xw.writeAttributeString(attType, 'true');
                    }
                    xw.writeStartElement('instrumentation');
                        xw.writeElementString('class-name', $("#consIPEPClassName").val());
                        xw.writeElementString('method-name', $("#consIPEPMethodName").val());
                        xw.writeElementString('match-type', $("#consIPEPMatchType").val());
                        xw.writeElementString('method-parameter-types', $("#consIPEPMethodPars").val());
                    xw.writeEndElement();

                    xw.writeStartElement('correlation');
                        xw.writeStartElement('payload-pointer');
                            xw.writeElementString('data-gatherer-type', $("#consIPCorrType").val());
                            if ($("#consIPCorrType").val() == "POSITION") {
                                xw.writeElementString('position', $("#consIPPosNo").val());
                            }
                            xw.writeElementString('transformer-type', $("#consIPTransformerType").val());
                            if ($("#consIPTransformerType").val() == "GETTER_METHODS") {
                                xw.writeElementString('getter-chain', $("#consIPGetterChain").val());
                            } else if ($("#consIPTransformerType").val() == "USER_DEFINED_NAME") {
                                xw.writeElementString('user-defined-name', $("#consIPGetterChain").val());
                            } else if ($("#consIPTransformerType").val() == "FIELD_NAME") {
                                xw.writeElementString('field-name', $("#consIPGetterChain").val());
                            }
                        xw.writeEndElement();
                        xw.writeStartElement('payload-operation');
                            xw.writeElementString('access-type', $("#consIPAccessType").val());
                            if ( $("#consIPAccessType").val() == "field") {
                                xw.writeElementString('param-types', $("#consIPParamType").val());
                                xw.writeElementString('field-name', $("#consIPFieldAccessName").val());
                            } else {
                                xw.writeElementString('param-types', $("#consIPParamTypes").val());
                                xw.writeElementString('access-method', $("#consIPFieldAccessName").val());
                            }
                        xw.writeEndElement();
                    xw.writeEndElement();
                xw.writeEndElement();
            }
            xw.writeEndElement();
        xw.writeEndDocument();
        $("#xmlArea").text(xw.flush());
    }
});
