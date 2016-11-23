module MoodleRb
  class Groups
    include HTTParty
    include Utility

    attr_reader :token

    def initialize(token, url)
      @token = token
      self.class.base_uri url
    end

    def course_groups(course_id)
      response = self.class.post(
          '/webservice/rest/server.php',
          {
              :query => query_hash('core_group_get_course_groups', token),
              :body => {
                  :courseid => course_id
              }
          }
      )
      check_for_errors(response)
      response.parsed_response
    end

    def add_group_members(params)
      response = self.class.post(
        '/webservice/rest/server.php',
        {
          :query => query_hash('core_group_add_group_members', token),
          :body => {
            :members => {
              '0' => {
                  :groupid => params[:group_id],
                  :userid => params[:user_id]
              }
            }
          }
        }
      )
      check_for_errors(response)
      response.parsed_response
    end
    
  end
end
