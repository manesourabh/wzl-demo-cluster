$(".custom-file-input").on("change", function() {
  var fileName = $(this).val().split("\\").pop();
  $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
});

var date = new Date();
var today = new Date(date.getFullYear(), date.getMonth(), date.getDate());
var end = new Date(date.getFullYear(), date.getMonth(), date.getDate());

$('#datepicker1').datepicker({
  format: "dd/mm/yyyy",
  todayHighlight: true,
  startDate: today,
  endDate: end,
  autoclose: true
});

$('#datepicker1').datepicker('setDate', today);

$(function () {
    $('#datetimepicker3').datetimepicker({
        format: 'LT',
        icons: {
          time: "fa fa-clock-o",
          up: "fa fa-chevron-up",
          down: "fa fa-chevron-down"
        }
    });
});

/*JSON Data*/
data = {
  "base": "Bitte wählen Sie oben",
  "Arbeitsvorbereitung":"Hilfstoffe hoch nicht geliefert,Hilfsstoffe nicht vorraetig,Reihung falsch",
  "Ausschneiden":"Falscher Durchmesser geschnitten,Nicht sauber geschnitten,Unrund",
  "Drehen":"Falsche Anzahl Runden,Klammern an schlechter Position,Zu stramm / zu locker",
  "Falten naehen":"Falsche Falte,Falsche Nahtposition,Keine Naht/ Nahtfehler,Nadelbruch",
  "Heften":"Druck zu hoch/ niedrig,Falscher Heftkreisdurchmesser,Maschine unzuverlässig/ unrund,Schlechtes Heftbild Unterseite",
  "KerneHeften":"Falsche Anzahl GP",
  "Pressen":"Klammern nicht sauber umgelegt,Ring nicht mittig positioniert",
  "RollenSchneiden":"Falsche Breite",
  "SchlauchNaehen":"Nicht zu genaeht",
  "SchlauchSchneiden":"Falsches Material",
  "Uebernaehen":"Falsche Lagenzahl,Falsche Nahtposition,Keine Naht/ Nahtfehler,Material verlaufen,Nadelbruch",
  "Reihung falsch":"Aenderungen auf Wunsch von Kunden,Kundenbesuchen,Zusammenfassen von Auftraegen",
  "NeuerFehler":"Druck zu hoch/ niedrig,Falsche Anzahl GP,Falsche Anzahl Runden,Falsche Breite,Falsche Falte,Falsche Lagenzahl,Falsche Nahtposition,Falscher Durchmesser geschnitten,Falscher Heftkreisdurchmesser,Falsches Material,Hilfsstoffe nicht vorraetig,Hilfstoffe hoch nicht geliefert,Keine Naht/ Nahtfehler,Klammern an schlechter Position,Klammern nicht sauber umgelegt,Maschine unzuverlässig/ unrund,Material verlaufen,Nadelbruch,Neuer Fehler,Nicht sauber geschnitten,Nicht zu genaeht,Reihung falsch,Ring nicht mittig positioniert,Schlechtes Heftbild Unterseite,Unrund,Zu stramm / zu locker",
  "Hilfstoffe hoch nicht geliefert":"Kurzfristige Liefertermine nicht haltbar",
  "Hilfsstoffe nicht vorraetig":"Kurzfrisitge Liefertermine nicht einhaltbar",
  "Reihung falsch":"Aenderungen auf Wunsch von Kunden,Kundenbesuchen,Zusammenfassen von Auftraegen",
  "Falscher Durchmesser geschnitten":"Ruestfehler,Werkerfehler",
  "Nicht sauber geschnitten":"Maschinenfehler (Anpressdruck vom Drehteller nicht korrekt),Maschinenfehler (Hilfspappe verschlissen),Maschinenfehler (Messdruck nicht korrekt),Maschinenfehler (Messerposition stimmt nicht),Maschinenfehler (stumpfes Messer),Werkerfehler",
  "Falsche Anzahl Runden":"Werkerfehler",
  "Klammern an schlechter Position":"",
  "Zu stramm / zu locker":"",
  "Falsche Falte":"Einstellungsfehler",
  "Falsche Nahtposition":"Arbeitsdokument nicht korrekt gelesen oder Position beim Einrichten nicht geprueft",
  "Keine Naht/ Nahtfehler":"Nadelbruch",
  "Druck zu hoch/ niedrig":"",
  "Falscher Heftkreisdurchmesser":"Werkerfehler",
  "Maschine unzuverlässig/ unrund":"",
  "Schlechtes Heftbild Unterseite":"Klammerlaenge zu lang/ kurz",
  "Falsche Anzahl GP":"Werkerfehler",
  "Klammern nicht sauber umgelegt":"Ruestfehler oder Fehler vom Heften",
  "Ring nicht mittig positioniert":"Werkerfehler",
  "Falsche Breite":"Arbeitsdokument nicht korrekt gelesen",
  "Nicht zu genaeht":"Garn abgerissen,Garn leer gelaufen,Maschinenbediener nicht sauber gearbeitet,Nadel gebrochen",
  "Falsches Material":"Arbeitsdokument nicht korrekt gelesen",
  "Falsche Lagenzahl":"Arbeitsdokument nicht korrekt gelesen",
  "Falsche Nahtposition":"Arbeitsdokument nicht korrekt gelesen oder Position beim Einrichten nicht geprueft",
  "Keine Naht/ Nahtfehler":"Nadelbruch",
  "Material verlaufen":"Maschine nicht richtig eingestellt",
  "Nadelbruch":"",
  "Neuer Fehler":"Aenderungen auf Wunsch von Kunden,Arbeitsdokument nicht korrekt gelesen,Arbeitsdokument nicht korrekt gelesen oder Position beim Einrichten nicht geprueft,Einstellungsfehler,Garn abgerissen,Garn leer gelaufen,Klammerlaenge zu lang/ kurz,Kundenbesuchen,Kurzfrisitge Liefertermine nicht einhaltbar,Kurzfristige Liefertermine nicht haltbar,Maschine nicht richtig eingestellt,Maschinenbediener nicht sauber gearbeitet,Maschinenfehler (Anpressdruck vom Drehteller nicht korrekt),Maschinenfehler (Hilfspappe verschlissen),Maschinenfehler (Messdruck nicht korrekt),Maschinenfehler (Messerposition stimmt nicht),Maschinenfehler (stumpfes Messer),Nadel gebrochen,Nadelbruch,Neuer Fehler,Ruestfehler,Ruestfehler oder Fehler vom Heften,Werkerfehler,Zusammenfassen von Auftraegen",
}


$("#first-choice").change(function() {
  var $dropdown = $(this);
  
  var key = $dropdown.val();
  var vals = [];
            
  switch(key) {
    case 'Arbeitsvorbereitung':
      vals = data.Arbeitsvorbereitung.split(",");
      break;
    case 'Ausschneiden':
      vals = data.Ausschneiden.split(",");
      break;
    case 'Drehen':
      vals = data.Drehen.split(",");
      break;
    case 'FaltenNaehen':
      vals = data.FaltenNaehen.split(",");
      break;
    case 'Heften':
      vals = data.Heften.split(",");
      break;
    case 'KerneHeften':
      vals = data.KerneHeften.split(",");
      break;
    case 'NeuerFehler':
      vals = data.NeuerFehler.split(",");
      break;
    case 'Pressen':
      vals = data.Pressen.split(",");
      break;
    case 'RollenSchneiden':
      vals = data.RollenSchneiden.split(",");
      break;
    case 'SchlauchNaehen':
      vals = data.SchlauchNaehen.split(",");
      break;
    case 'SchlauchSchneiden':
      vals = data.SchlauchSchneiden.split(",");
      break;
    case 'Uebernaehen':
      vals = data.Uebernaehen.split(",");
      break;    
    case 'base':
      vals = ['Bitte wählen Sie oben'];
  }
  
  var $secondChoice = $("#second-choice");
  $secondChoice.empty();
  $.each(vals, function(index, value) {
    $secondChoice.append("<option>" + value + "</option>");
  });

  
  if(key!='base') {
    var $thirdChoice = $("#third-choice");
    $thirdChoice.empty();
    var dd2value = $secondChoice.val();
    var values = data[dd2value].split(",");
    $.each(values, function(index, value) {
      $thirdChoice.append("<option>" + value + "</option>");
    });
  }

  else {
    var $thirdChoice = $("#third-choice");
    $thirdChoice.empty();
    var values = data.base;
    $thirdChoice.append("<option>" + values + "</option>");
  }
});


$("#second-choice").change(function() {

  var $dropdown = $(this);

  var key = $dropdown.val();
  var vals = [];
              
  switch(key) {
    case 'Hilfstoffe hoch nicht geliefert':
      vals = data[$("#second-choice").val()].split(",");
      break;
    case 'Hilfsstoffe nicht vorraetig':
      vals = data[$("#second-choice").val()].split(",");
      break;
    case 'Reihung falsch':
      vals = data[$("#second-choice").val()].split(",");
      break;
    case 'Falscher Durchmesser geschnitten':
      vals = data[$("#second-choice").val()].split(",");
      break;
    case 'Nicht sauber geschnitten':
      vals = data[$("#second-choice").val()].split(",");
      break;
    case 'Falsche Anzahl Runden':
      vals = data[$("#second-choice").val()].split(",");
      break;
    case 'Klammern an schlechter Position':
      vals = data[$("#second-choice").val()].split(",");
      break;
    case 'Zu stramm / zu locker':
      vals = data[$("#second-choice").val()].split(",");
      break;
    case 'Falsche Falte':
      vals = data[$("#second-choice").val()].split(",");
      break;
    case 'Falsche Nahtposition':
      vals = data[$("#second-choice").val()].split(",");
      break;
    case 'Keine Naht/ Nahtfehler':
      vals = data[$("#second-choice").val()].split(",");
      break;
    case 'Druck zu hoch/ niedrig':
      vals = data[$("#second-choice").val()].split(",");
      break;
    case 'Falscher Heftkreisdurchmesser':
      vals = data[$("#second-choice").val()].split(",");
      break;
    case 'Maschine unzuverlässig/ unrund':
      vals = data[$("#second-choice").val()].split(",");
      break;
    case 'Schlechtes Heftbild Unterseite':
      vals = data[$("#second-choice").val()].split(",");
      break;
    case 'Falsche Anzahl GP':
      vals = data[$("#second-choice").val()].split(",");
      break;
    case 'Klammern nicht sauber umgelegt':
      vals = data[$("#second-choice").val()].split(",");
      break;
    case 'Ring nicht mittig positioniert':
      vals = data[$("#second-choice").val()].split(",");
      break;
    case 'Falsche Breite':
      vals = data[$("#second-choice").val()].split(",");
      break;
    case 'Nicht zu genaeht':
      vals = data[$("#second-choice").val()].split(",");
      break;
    case 'Falsches Material':
      vals = data[$("#second-choice").val()].split(",");
      break;
    case 'Falsche Lagenzahl':
      vals = data[$("#second-choice").val()].split(",");
      break;
    case 'Falsche Nahtposition':
      vals = data[$("#second-choice").val()].split(",");
      break;
    case 'Falsche Nahtposition':
      vals = data[$("#second-choice").val()].split(",");
      break;
    case 'Keine Naht/ Nahtfehler':
      vals = data[$("#second-choice").val()].split(",");
      break;
    case 'Material verlaufen':
      vals = data[$("#second-choice").val()].split(",");
      break;
    case 'Nadelbruch':
      vals = data[$("#second-choice").val()].split(",");
      break;
    case 'Neuer Fehler':
      vals = data[$("#second-choice").val()].split(",");
      break;
    case 'base':
      vals = ['Bitte wählen Sie oben'];
  }
  
  var $thirdChoice = $("#third-choice");
  $thirdChoice.empty();
  $.each(vals, function(index, value) {
    $thirdChoice.append("<option>" + value + "</option>");
  });
});


/*Validation*/
function validation() {
  var dropdown = $("#first-choice").val();
  var inputValue = $("#validationDefaultDesc").val();
  var status = $('#inputStatus').val();

  if(dropdown === "base") {
      //"Do your number validation here
      document.getElementById('first-choice').value=null;
      document.getElementById("validationDefaultDesc").required = true;

  } else if(dropdown === "NeuerFehler") {
      //Do your text validation here
      document.getElementById("validationDefaultDesc").required = true;
      if(inputValue == "") {
        document.getElementById("validationDefaultDesc").setCustomValidity('Dieses Feld wird benötigt.');
      }
      else {
        document.getElementById("validationDefaultDesc").setCustomValidity('');
      }
  } else {
      //Do your float validation here
      document.getElementById("validationDefaultDesc").required = false;
      document.getElementById("validationDefaultDesc").setCustomValidity('');
  }
}


function savenewfehler() {
  newfehler = $("#addfehler").val();
  var secondchoice = document.getElementById("second-choice");
  var option = document.createElement("option");
  option.text = newfehler;
  secondchoice.add(option,0);
  document.getElementById("second-choice").value = option.text;
}

function savenewgrund() {
  newgrund = $("#addgrund").val();
  var thirdchoice = document.getElementById("third-choice");
  var option = document.createElement("option");
  option.text = newgrund;
  thirdchoice.add(option,0);
  document.getElementById("third-choice").value = option.text;  
}

