
 (setq diary-file "~/emacs/diary")

;; Para que mi calendario sea más bello

 (setq view-diary-entries-initially t
       mark-diary-entries-in-calendar t
       number-of-diary-entries 7)
 (add-hook 'diary-display-hook 'fancy-diary-display)
 (add-hook 'today-visible-calendar-hook 'calendar-mark-today)

;; Para que mi calendario este en mi idioma

(setq calendar-week-start-day 1
          calendar-day-name-array
          ["Domingo" "Lunes" "Martes" 
           "Miercoles" "Jueves" "Viernes" "Sábado"]
          calendar-month-name-array
          ["Enero" "Febrero" "Marzo" "Abril"
           "Mayo" "Junio" "Julio" "Agosto" "Septiembre"
           "Octubre" "Noviembre" "Diciembre"])

;; Para poder exportar todo aquello que está en mi calendario usando el estándar ical

 (autoload 'icalendar-import-buffer "icalendar"
           "Import iCalendar data from current buffer" t)
 (autoload 'icalendar-import-file "icalendar"
           "Import iCalendar data from a file" t)
 (autoload 'icalendar-export-file "icalendar"
           "Export diary data in a file" t)
 (autoload 'icalendar-export-region "icalendar"
           "Export diary data in a region" t)

