initializeDataTables = ->
  $(".datatables").DataTable
    language:
      url: "/datatables/dataTables.spanish.lang"

jQuery initializeDataTables
$(document).on "page:load", initializeDataTables
