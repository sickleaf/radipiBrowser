
function loadConfig(elementID,configBase,valueType,textType){
	var configInfo = Radipi[configBase];
	var configLength =configInfo.length;
	var element = document.getElementById(elementID);
	
	for (var i=0;i< configLength;i++){
		var option = document.createElement('option');
		var configItem = configInfo[i];
		option.value = configItem[valueType];
		option.text = configItem[textType];
		element.appendChild(option);
	}
}

function playFM(){
	var stationList = document.getElementById("fmID");
	var stationIndex = stationList.selectedIndex;
	var stationValue = stationList.options[stationIndex].value;
	var stationText = stationList.options[stationIndex].text;

	document.getElementById(Radipi.nowplayingID).innerHTML=stationText;
        doCommand(Radipi.scriptPath + Radipi.fmScript + " -n " +  stationValue );
}

function onAreaSelected(parentListId,childListId){
	var parentList = document.getElementById(parentListId);
	var childList = document.getElementById(childListId);

	
	var stationLength = Radipi.fmListInfo.length;
	var parentIndex = parentList.selectedIndex;
	var parentAreaID = parentList.options[parentIndex].value;
	
	
	if ( parentIndex == 0 ){
		for (var i=0;i< stationLength;i++){
			var option = document.createElement('option');
			var stationItem = Radipi.fmListInfo[i];
			option.text = stationItem[Radipi.fmText];
			option.value = stationItem[Radipi.fmValue];
			childList.appendChild(option);
		}
	}else{
		while (childList.childNodes.length) {
			childList.removeChild(childList.lastChild);
		}

		for (var i=0;i< stationLength;i++){
			var option = document.createElement('option');
			var stationItem = Radipi.fmListInfo[i];
			if (stationItem[Radipi.areaValue] == parentAreaID ){
				option.text = stationItem[Radipi.fmText];
				option.value = stationItem[Radipi.fmValue];
				childList.appendChild(option);
			}
		}


	}
}


