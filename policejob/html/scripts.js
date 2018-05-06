$(document).ready(function(){  // Mouse Controls
  var documentWidth = document.documentElement.clientWidth;
  var documentHeight = document.documentElement.clientHeight;
  var lstWarrants = [];
  var lstMDT = [];

  // Partial Functions
  function closeMain() {
    $(".home").css("display", "none");
  }
  function openMain() {
    $(".home").css("display", "block");
  }
  function closeAll() {
    $(".body").css("display", "none");
    // Clear input boxes
    $("#warrant-notes").val('');

    $("#newWarrant-form #name").val('');
    $("#newWarrant-form #loc").val('');
    $("#newWarrant-form #notes").val('');
  }
  function openContainer() {
    $(".warrants-container").css("display", "block");
  }
  function closeContainer() {
    $(".warrants-container").css("display", "none");
  }
  function openWarrants() {
    $(".history-container").css("display", "block");
  }
  function openMDT() {
    $(".mdt-container").css("display", "block");
  }
  function openWarrantRead(id, name, loc, notes) {
    $(".warrant-container").css("display", "block");
    $("#warrant-name").html(name);
    $("#warrant-loc").html(loc);
    $("#warrant-notes").val(notes);
    $("#warrant-id").val(id);
  }
  function openmdtRead(id, time, officer, name, jailfine, jailtime, charges, fineticketamount) {
    $(".mdt-view-container").css("display", "block");
    $("#mdt-officer").html(officer);
    $("#mdt-time").html(time);
    $("#mdt-offender").html(name);
    $("#mdt-jailfine").html(jailfine);
    $("#mdt-jailtime").html(jailtime);
    $("#mdt-charges").html(charges);
    $("#mdt-fine").html(fineticketamount);
    $("#mdt-id").val(id);
  }
  function openNewWarrant() {
    $(".newWarrant-container").css("display", "block");
  }
  function openNewMDT() {
    $(".newMDT-container").css("display", "block");
  }
  function openNewWarrantReply(number) {
    $(".newWarrant-container").css("display", "block");
    $("#newWarrant-form #number").val(number);
  }
  function openContacts() {
    $(".contacts-container").css("display", "block");
  }
  function openNewContact() {
    $(".newContact-container").css("display", "block");
  }
  function openAlerts() {
    $(".alerts-container").css("display", "block");
  }

  function addWarrant(item) {
    // Check if warrant is already added
    if (lstWarrants.some(function(e) { return e.id == item.id; })) {
      return;
    }

    lstWarrants.push(item);
    var element = $('<li id="warrant-' + item.id + '"><div class="name">' + item.name + ':</div> <div class="notes">' + item.notes + '</div></li>');  
    element.id = lstWarrants.length;  
    element.click(function(){  
      $.post('http://policejob/warrantRead', JSON.stringify({id: item.id, name: item.name, loc: item.loc, notes: item.notes}));  
    });  
    $(".lstWarrants").prepend(element);
  }

  function addMDT(item) {
    // Check if warrant is already added
    if (lstMDT.some(function(e) { return e.id == item.id; })) {
      return;
    }

    lstMDT.push(item);
    var element = $('<li id="mdt-' + item.id + '"><div class="time">' + item.time + '</div> │ Officer: <div class="officer">' + item.officer + '</div> │ Offender: <div class="offender">' + item.name + '</div> │ Jail Time: <div class="jt">' + item.jailtime + '</div>seconds │ Fine: $<div class="finea">' + item.fineticketamount + '</div> │ Charges: <div class="charges">' + item.charges + '</div></li>');
    //var element = $('<li id="mdt-' + item.id + '">' + item.time + ' | Officer: ' + item.officer + ' | Offender: ' + item.name + ' | Charges: ' + item.charges + '</li>');
    element.id = lstMDT.length;  
    element.click(function(){  
      $.post('http://policejob/mdtRead', JSON.stringify({id: item.id, time: item.time, officer: item.officer, name: item.name, jailfine: item.jailfine, jailtime: '' + item.jailtime + ' seconds', charges: item.charges, fineticketamount: '$' + item.fineticketamount + ''}));  
    });  
    $(".lstMDT").prepend(element);
  }

  // Listen for NUI Events
  window.addEventListener('message', function(event){
    var item = event.data;
    // Trigger adding a new warrant to the log and create its display
    if (item.newWarrant === true) {
      addWarrant(item.warrant);
    }
    if (item.newMDT === true) {
      addMDT(item.mdt);
    }
    // Open & Close main warrants window
    if(item.openWarrants === true) {
      openContainer();
      openMain();
    }
    if(item.openWarrants === false) {
      closeContainer();
      closeMain();
    }
    // Open sub-windows / partials
    if(item.openSection == "warrants") {
      lstWarrants.length = 0;
      $(".lstWarrants").empty();
      if (item.list && Object.keys(item.list).length > 0) {
        for(let warrant of item.list) {
          if (warrant && warrant.name && warrant.loc && warrant.notes) {
            addWarrant(warrant);
          }
        }
      }
      closeAll();
      openWarrants();
    }
    if(item.openSection == "warrantRead") {
      closeAll();
      openWarrantRead(item.id, item.name, item.loc, item.notes);
    }
    if(item.openSection == "mdtRead") {
      closeAll();
      openmdtRead(item.id, item.time, item.officer, item.name, item.jailfine, item.jailtime, item.charges, item.fineticketamount);
    }
    if(item.openSection == "newWarrant") {
      closeAll();
      openNewWarrant();
      if (item.location) {        
        $("#newWarrant-form #loc").val(item.location);
      }
    }
    if(item.openSection == "mdt") {
      lstMDT.length = 0;
      $(".lstMDT").empty();
      if (item.list && Object.keys(item.list).length > 0) {
        for(let mdt of item.list) {
          if (mdt && mdt.time && mdt.officer && mdt.name && mdt.jailfine && mdt.jailtime && mdt.charges && mdt.fineticketamount) {
            addMDT(mdt);
          }
        }
      }
      closeAll();
      openMDT();
    }
    if(item.openSection == "newMDT") {
      closeAll();
      openNewMDT();
    }
    if(item.openSection == "autofillMDT") {
      $("#officer").val(item.officer);
      $("#Jailtime").val(item.time);
      $("#Charges").val(item.charges);
      $("#FineTicketAmount").val(item.cost);
      $("#offender").val(item.offender);
    }
  });

  // On 'Esc' call close method
  document.onkeyup = function (data) {
    if (data.which == 27 ) {
      $.post('http://policejob/close', JSON.stringify({}));
    }
  };

  // Handle Button Presses
  $(".btnHome").click(function(){
      closeAll();
      openMain();
  });
  $(".btnClose").click(function(){
      $.post('http://policejob/close', JSON.stringify({}));
  });
  $(".btnWarrants").click(function(){
      $.post('http://policejob/loadWarrants', JSON.stringify({}));
  });
  $(".btnMDT").click(function(){
      $.post('http://policejob/loadMDT', JSON.stringify({}));
  });
  $(".btnRemove").click(function(){
    if (confirm('Are you sure you want permanently delete this warrant?') === true) {
      $.post('http://policejob/warrantDelete', JSON.stringify({
          id: $("#warrant-id").val(),
          name: $("warrant-name").val(),
      }));
      setTimeout(function(){
        closeAll();
        openMain();
      }, 500);
    }
  });
  $(".btnRemove2").click(function(){
    if (confirm('Are you sure you want permanently delete this record?') === true) {
      $.post('http://policejob/mdtDelete', JSON.stringify({
          id: $("#mdt-id").val(),
          time: $("mdt-time").val(),
          offender: $("mdt-offender").val(),
      }));
      setTimeout(function(){
        closeAll();
        openMain();
      }, 500);
    }
  });
  $(".btnNewWarrant").click(function(){
      $.post('http://policejob/newWarrant', JSON.stringify({}));
  });
  
  // Handle Form Submits
  $("#newWarrant-form").submit(function(e) {
      e.preventDefault();
      $.post('http://policejob/newWarrantSubmit', JSON.stringify({
          name: $("#newWarrant-form #name").val(),
          loc: $("#newWarrant-form #loc").val(),
          notes: $("#newWarrant-form #notes").val()
      }));
      $("#newWarrant-form #name").prop('disabled', true);
      $("#newWarrant-form #loc").prop('disabled', true);
      $("#newWarrant-form #notes").prop('disabled', true);
      $("#newWarrant-form #submit").css('display', 'none');
      setTimeout(function(){
        $("#newWarrant-form #name").prop('disabled', false);
        $("#newWarrant-form #loc").prop('disabled', false);
        $("#newWarrant-form #notes").prop('disabled', false);
        $("#newWarrant-form #name").val('');
        $("#newWarrant-form #loc").val('');
        $("#newWarrant-form #notes").val('');
        $("#newWarrant-form #submit").css('display', 'block');
        $.post('http://policejob/close', JSON.stringify({}));
      }, 1500);
  });
  $(".btnNewMDT").click(function(){
      $.post('http://policejob/newMDT', JSON.stringify({}));
  });
  $("#newMDT-form").submit(function(e) {
      e.preventDefault();
      $.post('http://policejob/newMDTSubmit', JSON.stringify({
          officer: $("#newMDT-form #officer").val(),
          name: $("#newMDT-form #offender").val(),
          jailfine: $("#newMDT-form #JailorTicket").val(),
          jailtime: $("#newMDT-form #Jailtime").val(),
          charges: $("#newMDT-form #Charges").val(),
          fineticketamount: $("#newMDT-form #FineTicketAmount").val(),
      }));
      $("#newMDT-form #officer").prop('disabled', true);
      $("#newMDT-form #offender").prop('disabled', true);
      $("#newMDT-form #JailorTicket").prop('disabled', true);
      $("#newMDT-form #Jailtime").prop('disabled', true);
      $("#newMDT-form #Charges").prop('disabled', true);
      $("#newMDT-form #FineTicketAmount").prop('disabled', true);
      $("#newMDT-form #submit2").css('display', 'none');
      setTimeout(function(){
        $("#newMDT-form #officer").prop('disabled', false);
        $("#newMDT-form #offender").prop('disabled', false);
        $("#newMDT-form #JailorTicket").prop('disabled', false);
        $("#newMDT-form #Jailtime").prop('disabled', false);
        $("#newMDT-form #Charges").prop('disabled', false);
        $("#newMDT-form #FineTicketAmount").prop('disabled', false);
        $("#newMDT-form #submit2").css('display', 'block');
        $("#newMDT-form #officer").val('');
        $("#newMDT-form #offender").val('');
        $("#newMDT-form #JailorTicket").val('');
        $("#newMDT-form #Jailtime").val('');
        $("#newMDT-form #Charges").val('');
        $("#newMDT-form #FineTicketAmount").val('');
        $.post('http://policejob/close', JSON.stringify({}));
      }, 1500);
  });
  $(".btnMDTAutofill").click(function(){
      $.post('http://policejob/autofillMDT', JSON.stringify({}));
  });
  // Handle warrant search filtering
  $("#search").bind('input', function(elem){
    var search = elem.target.value.trim();
    $(".lstWarrants").find("li[id*='warrant-']").each(function(i, el){  
      if (search.length === 0) {
          el.style.display = "block";
          return;
      }
      
      var name = el.children[0].innerHTML;
      var reg = new RegExp('(.*)' + search + '(.*)', 'ig');
      if (!reg.test(name)) {
        el.style.display = "none";
      }
    });
  });

  $("#search_mdt").bind('input', function(elem){
    var search2 = elem.target.value.trim();
    $(".lstMDT").find("li[id*='mdt-']").each(function(i, el){  
      if (search2.length === 0) {
          el.style.display = "block";
          return;
      }
      
      var name2 = el.children[2].innerHTML;
      var reg2 = new RegExp('(.*)' + search2 + '(.*)', 'ig');
      if (!reg2.test(name2)) {
        el.style.display = "none";
      }
    });
  });
  $("#search").keypress(function(event) {
      if (event.keyCode == 13) {
          event.preventDefault();
      }
  });
  $("#search_mdt").keypress(function(event) {
      if (event.keyCode == 13) {
          event.preventDefault();
      }
  });
});