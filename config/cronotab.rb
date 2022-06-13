# cronotab.rb — Crono configuration file
#
# Here you can specify periodic jobs and schedule.
# You can use ActiveJob's jobs from `app/jobs/`
# You can use any class. The only requirement is that
# class should have a method `perform` without arguments.
#
# class TestJob
#   def perform
#     puts 'Test!'
#   end
# end
#
# Crono.perform(TestJob).every 2.days, at: '15:30'
#

class CryptoCron
  def perform
    puts 'UPDATE STARTING'
    CryptoCurrencyApiService.new.update_bulk_cryptocurrency_data
    puts 'UPDATE FINISHED'
  end
end

Crono.perform(CryptoCron).every 5.seconds