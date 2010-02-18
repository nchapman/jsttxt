// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var jstxt = {
  insertTag: function(textarea, start, end) {
    textarea = $(textarea);
    
    if(!end) end = '';
    
    if(document.selection) {
      textarea.focus(); 
      sel = document.selection.createRange(); 
      sel.text = start + sel.text + end; 
      textarea.focus()
    }
    else if(textarea.selectionStart || textarea.selectionStart == '0') {
      var startPos = textarea.selectionStart; 
      var endPos = textarea.selectionEnd; 
      var cursorPos = endPos; 
      var scrollTop = textarea.scrollTop; 
      textarea.value = textarea.value.substring(0, startPos) + start + textarea.value.substring(startPos, endPos) + end + textarea.value.substring(endPos, textarea.value.length); 
      cursorPos += start.length + end.length; 
      textarea.focus(); 
      textarea.selectionStart = cursorPos; 
      textarea.selectionEnd = cursorPos; 
      textarea.scrollTop = scrollTop
    }
    else {
      textarea.value += start; 
      textarea.value += end; 
      textarea.focus()
    }
  },
  
  filters: [],
  
  addTextFilter: function(filter) {
    this.filters.push(filter);
  },
  
  applyTextFilters: function() {
    var body_html = $("note_body").innerHTML;

    for (var i = 0; i < this.filters.length; i++) {
      body_html = this.filters[i](body_html);
    }
    
    $("note_body").innerHTML = body_html;
  }
};

// activate links
jstxt.addTextFilter(function(body_html) {
  return text.replace(/(https?:\/\/[^\s]+)/g, "<a href=\"$1\">$1</a>");
});

// UPS tracking
jstxt.addTextFilter(function(body_html) {
  pattern = /\b(1Z ?[0-9A-Z]{3} ?[0-9A-Z]{3} ?[0-9A-Z]{2} ?[0-9A-Z]{4} ?[0-9A-Z]{3} ?[0-9A-Z]|[\dT]\d\d\d ?\d\d\d\d ?\d\d\d)\b/ig;

  return text.replace(pattern, "<a href=\"http://wwwapps.ups.com/WebTracking/processInputRequest?TypeOfInquiryNumber=T&InquiryNumber1=$1\">$1</a>");
});