# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require_relative '../exceptions/command_failed'
require_relative '../models/domain'

module GoodData
  module Command
    # Low level access to GoodData API
    class Domain
      attr_reader :name

      class << self
        def add_user(domain, login, password, opts = { :client => GoodData.connection })
          data = {
            :domain => domain,
            :login => login,
            :password => password
          }
          GoodData::Domain.add_user(data.merge(opts))
        end

        def list_users(domain_name, options = { :client => GoodData.connection })
          client = GoodData.connect(options)
          domain = client.domain(domain_name)

          rows = domain.users.to_a.map do |user|
            [user.email, user.full_name]
          end

          table = Terminal::Table.new :headings => ['Email', 'Full Name'], :rows => rows
          puts table
        end
      end
    end
  end
end
