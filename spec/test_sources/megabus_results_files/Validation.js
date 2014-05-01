
///////////////////////////////////////////////////////////////////////////////////

function updateBasketItemCount() {
    var basketItemCount = document.forms[0].Welcome1_hdnBasketItemCount.value;
    document.forms[0].Welcome1_hdnBasketItemCount.value = basketItemCount - 1;
    //document.forms[0].Welcome1_hlViewBasket.innerHTML = 'Basket Items (' + document.forms[0].Welcome1_hdnBasketItemCount.value + ')';

    var isIE = document.all ? true : false;
    var isNS4 = document.layers ? true : false;
    var isNS6 = navigator.userAgent.indexOf("Gecko") != -1 ? true : false;

    var _obj = null;
    if (isIE || isNS6) _obj = document.getElementById('Welcome1_hlViewBasket');
    if (_obj) {
        _obj.innerHTML = 'Basket Items (' + document.forms[0].Welcome1_hdnBasketItemCount.value + ')';
    }
}

///////////////////////////////////////////////////////////////////////////////////

function ValidateDates() {
    var dateOutward = document.forms[0].SearchAndBuy1$txtOutwardDate.value;
    if (dateOutward == "")
        return true
    var dateReturn = document.forms[0].SearchAndBuy1$txtReturnDate.value;
    if (dateReturn == "")
        return true

    // manipulate input datetime format 's' e.g. 2008-03-09T16:05:07
    var dateOutwardArray = new Array();
    dateOutwardArray = dateOutward.split('-');

    var dateReturnArray = new Array();
    dateReturnArray = dateReturn.split('-');

    var DateO = new Date(dateOutwardArray[0], dateOutwardArray[1], dateOutwardArray[2].substring(0, 2));
    var DateR = new Date(dateReturnArray[0], dateReturnArray[1], dateReturnArray[2].substring(0, 2));

    if (DateO > DateR) {
        alert("Return date cannot preceed outbound date");
        return false
    }
    return true
}


////////////////////////////////////////////////////////////////////

function validateRange() {
    // SearchAndBuy1$ddlLeavingFrom
    var s = document.forms[0].SearchAndBuy1$txtPassengers.value;
    var A = 1;
    var B = 99;

    switch (isIntegerInRange(s, A, B)) {
        case true:
            //alert(s + " is in range from " + A + " to " + B)
            //document.forms[0].SearchAndBuy1$ddlLeavingFrom.disabled = false;
            return true;
            break;
        case false:
            alert("Please enter a number between " + A + " and " + B)
            //document.forms[0].SearchAndBuy1$ddlLeavingFrom.disabled = true;
            return false;
    }
}

// isIntegerInRange (STRING s, INTEGER a, INTEGER b)
function isIntegerInRange(s, a, b) {
    if (isEmpty(s))
        if (isIntegerInRange.arguments.length == 1) return false;
    else return (isIntegerInRange.arguments[1] == true);

    // Catch non-integer strings to avoid creating a NaN below,
    // which isn't available on JavaScript 1.0 for Windows.
    if (!isInteger(s, false)) return false;

    // Now, explicitly change the type to integer via parseInt
    // so that the comparison code below will work both on
    // JavaScript 1.2 (which typechecks in equality comparisons)
    // and JavaScript 1.1 and before (which doesn't).
    var num = parseInt(s);
    return ((num >= a) && (num <= b));
}

function isInteger(s) {
    var i;

    if (isEmpty(s))
        if (isInteger.arguments.length == 1) return 0;
    else return (isInteger.arguments[1] == true);

    for (i = 0; i < s.length; i++) {
        var c = s.charAt(i);

        if (!isDigit(c)) return false;
    }

    return true;
}

function isEmpty(s) {
    return ((s == null) || (s.length == 0))
}

function isDigit(c) {
    return ((c >= "0") && (c <= "9"))
}

/////////////////////////////////////////////////////////////

function calendarPicker(strField) {

    window.open("Calendar.aspx?field=" + strField, 'Calendar', "width=260,height=290,resizable=no,top=200,toolbars=no,status=no");
}

///////////////////////////////////////////////////////////

function openPopup(strOpen) {
    open(strOpen, "Info", "status=1, width=300, height=200, top=100, left=300");
}

////////////////////////////////////////////////////////////

function setHourglass() {
    document.body.style.cursor = 'wait';
}

function setCursorToDefault() {
    document.body.style.cursor = 'default';
}

////////////////////////////////////////////////////////////

function setButtonEnabled(buttonID, checkboxID, image, txtEmailID, txtEmailConfirmID, txtPasswordID, txtPasswordConfirmID) {

    checkbox = document.getElementById(checkboxID);
    button = document.getElementById(buttonID);

    txtEmail = document.getElementById(txtEmailID);
    txtEmailConfirm = document.getElementById(txtEmailConfirmID);
    txtPassword = document.getElementById(txtPasswordID);
    txtPasswordConfirm = document.getElementById(txtPasswordConfirmID);

    if (txtEmail.value == "" || txtEmailConfirm.value == "" || txtPassword.value == "" || txtPasswordConfirm.value == "" || txtEmail.value != txtEmailConfirm.value || txtPassword.value != txtPasswordConfirm.value) {
        button.disabled = true;
        button.src = 'images/' + image + '_off.png';
    }
    else {
        if (checkbox.checked == true) {
            button.disabled = false;
            button.src = 'images/' + image + '.png';
        }
        else {
            button.disabled = true;
            button.src = 'images/' + image + '_off.png';
        }
    }
}

//////////////////////////////////////////////////////////////

function setLoginEnabled(buttonID, txtEmailID, txtPasswordID, image) {

    button = document.getElementById(buttonID);
    txtEmail = document.getElementById(txtEmailID);
    txtPassword = document.getElementById(txtPasswordID);

    if (txtEmail.value == "" || txtPassword.value == "") {
        button.disabled = true;
        button.src = 'images/' + image + '_off.png';
    }
    else {
        button.disabled = false;
        button.src = 'images/' + image + '.png';
        //button.focus();
    }
}


//////////////////////////////////////////////////////////////

function enableSubmitButton(txtNameID, txtEmailID, ddlSubjectId, btnSubmitId, imageName) {

    txtName = document.getElementById(txtNameID);
    txtEmail = document.getElementById(txtEmailID);
    ddlSubject = document.getElementById(ddlSubjectId);
    button = document.getElementById(btnSubmitId);

    if (txtEmail.value == "" || txtName.value == "" || ddlSubject.value == "0") {
        button.disabled = true;
        button.src = 'images/' + imageName + '_off.png';
    }
    else {
        button.disabled = false;
        button.src = 'images/' + imageName + '_on.png';
    }
}

//////////////////////////////////////////////////////////////

function enableAuthenticateButton(txtAuthCodeID, btnSubmitId, imageName) {

    txtAuthCode = document.getElementById(txtAuthCodeID);
    button = document.getElementById(btnSubmitId);

    if (txtAuthCode.value == "") {
        button.disabled = true;
        button.src = 'images/' + imageName + '.gif'; // '_off.png'
    }
    else {
        button.disabled = false;
        button.src = 'images/' + imageName + '.gif';
    }
}

////////////////////////////////////////////////////////////////

function setPayButtonEnabled(buttonID, checkboxID, image) {

    checkbox = document.getElementById(checkboxID);
    button = document.getElementById(buttonID);

    if (checkbox.checked == true) {
        button.disabled = false;
        button.src = 'images/' + image + '_on.png';
    }
    else {
        button.disabled = true;
        button.src = 'images/' + image + '_off.png';
    }
}

//////////////////////////////////////////////////////////////

function setCookie(name, value, expires, path, domain, secure) {
    var curCookie = name + "=" + value +
      ((expires) ? "; expires=" + expires : "") +
      ((path) ? "; path=" + path : "") +
      ((domain) ? "; domain=" + domain : "") +
      ((secure) ? "; secure" : "");
    document.cookie = curCookie;
}

///////////////////////////////////////////////////////////////

function setCurrentDate(clientID) {
    var d_names = new Array("Sunday", "Monday", "Tuesday",
"Wednesday", "Thursday", "Friday", "Saturday");

    var m_names = new Array("January", "February", "March",
"April", "May", "June", "July", "August", "September",
"October", "November", "December");

    var d = new Date();
    var curr_day = d.getDay();
    var curr_date = d.getDate();
    var sup = "";
    if (curr_date == 1 || curr_date == 21 || curr_date == 31) {
        sup = "st";
    }
    else if (curr_date == 2 || curr_date == 22) {
        sup = "nd";
    }
    else if (curr_date == 3 || curr_date == 23) {
        sup = "rd";
    }
    else {
        sup = "th";
    }
    var curr_month = d.getMonth();
    var curr_year = d.getFullYear();

    var date = d_names[curr_day] + " " + curr_date +
    //"<SUP>" + sup + "</SUP>" 
    + " " + m_names[curr_month] + " " + curr_year;

    document.getElementById(clientID).value = date;
}

///////////////////////////////////////////////////////////////

// add event to a control to override Page.MaintainScrollPositionOnPostBack = true;
function SetScrollEvent() {
    window.scrollTo(0, 0);
} 