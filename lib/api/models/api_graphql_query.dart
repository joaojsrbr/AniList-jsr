const String queryRes = r'''
query ($id: Int, $page: Int, $perPage: Int, $search: String, $type: MediaType, $countryOfOrigin: CountryCode, $sort: [MediaSort], $idMal: Int,$pageR: Int, $perPageR: Int) {
  Page (page: $page, perPage: $perPage) {
    pageInfo {
      total
      currentPage
      lastPage
      hasNextPage
      perPage
    }

    media (id: $id, search: $search, type:$type, countryOfOrigin: $countryOfOrigin, sort: $sort, idMal: $idMal) {
      description
        id
      bannerImage
#       staff{
#         nodes{
#           id
#         	 name{
#             middle
#             native
#             alternative
#           }
#         }
#       }
      status
      endDate{	
        year
        month
        day
        }
    	startDate {
        year
        month
       	day
    		}
      meanScore
      popularity
      favourites
      format
      source
      genres
      synonyms
			coverImage{
        large
        extraLarge
        medium
        color
      }
      type
      episodes
      recommendations(page: $pageR, perPage: $perPageR){
        pageInfo{
        total
     	 	currentPage
      	lastPage
      	hasNextPage
      	perPage
        }
			nodes{
        mediaRecommendation{
          idMal
          id
          type
          episodes
          description
          meanScore
      		popularity
      		favourites
      		format
      		source
      		genres
          status
					endDate{
            year
            month
            day
          }
    			startDate {
        		year
        		month
       			day
    		  }
      		synonyms
          coverImage{
            large
            color
            extraLarge
            medium
            __typename
          }
          bannerImage
          title{
            english
            romaji
            native
          }
        }
      }	
      }
      idMal
      averageScore
      countryOfOrigin
      title {
        english
        romaji
        native
      }
    }
  }
}
''';
