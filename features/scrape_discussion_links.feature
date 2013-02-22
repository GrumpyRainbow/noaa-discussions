Feature: Scrape Discussion Links

    Scenario Outline: Need to initialize array of links to scrape

        Given a NOAA website "<website>"

        When the script is ran

        Then the output should be an array of urls "<url_array>"
        
        Examples:
            | website | url_array |
            | HPC     | []        |