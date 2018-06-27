module Services::SSO::Commands
  class UnclaimClientCommand
    attr_reader :client_id

    def initialize(client_id)
      @client_id = client_id
    end

    def db_command
      CloudController::ServiceDashboardClient.release_client(client_id)
    end
  end
end
