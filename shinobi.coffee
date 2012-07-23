jQuery ($) ->
  window.Shinobi = 
    
    init: ->

      # Module clicks on word page
      $('ul.examples a').live 'click', ->
        Shinobi.report "ExampleSource", "click", $(this).data('source')
        Shinobi.report "ExampleURL", "click", $(this).attr('href')

      # List and ListedWord creation from word page
      $('.module.lists form#new_list').live 'submit', ->
        Shinobi.report "List", "create", 'from_word_page'
        Shinobi.report "ListedWord", "createFirst", 'from_word_page'

      # List creation from lists/new
      $('form#new_list.standalone').live 'submit', ->
        Shinobi.report "List", "create", 'from_list_form'

      # ListedWord toggling from word page
      $('a.toggle_listage').live 'click', ->
        if $(this).hasClass 'active'
          Shinobi.report "ListedWord", "delete", 'from_word_page'
        else
          Shinobi.report "ListedWord", "create", 'from_word_page'

      # ListedWord creation from list page
      $('#lists form#new_word').live 'submit', ->
        Shinobi.report "ListedWord", "create", 'from_list_page'

      # Word un/loveage      
      $("form#toggle_favor").live "submit", ->
        if $("h1#headword").hasClass('loved')
          Shinobi.report "Word", "unlove", 'from_word_page'
        else
          Shinobi.report "Word", "love", 'from_word_page'
          
      # List un/loveage      
      $("form#toggle_favorite_list").live "submit", ->
        if $("h1#headword").hasClass('loved')
          Shinobi.report "List", "unlove", 'from_list_page'
        else
          Shinobi.report "List", "love", 'from_list_page'

      # Word audio pronunciations
      $('a.play_sound').live 'click', ->
        Shinobi.report "Word", "hear", 'from_word_page'


    report: (category, action, label) ->
      # _trackEvent(category, action, opt_label, opt_value, opt_noninteraction)
      # http://code.google.com/apis/analytics/docs/tracking/eventTrackerGuide.html    
      # category (required) - The name you supply for the group of objects you want to track.
      # action (required) - A string that is uniquely paired with each category, and commonly used to define the type of user interaction for the web object.
      # label (optional) - An optional string to provide additional dimensions to the event data.
      # value (optional) - An integer that you can use to provide numerical data about the user event.

      log "Shinobi: #{category}, #{action}, #{label}"
      _gaq.push ['_trackEvent', category, action, label]