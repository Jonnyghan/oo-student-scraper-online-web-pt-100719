require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
  school = Nokogiri::HTML(open(index_url))
    students = []

    school.css("div.student-card").each do |student|
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      profile_url = student.css("a").attribute("href").value
      student_info = {:name => name,
                :location => location,
                :profile_url => profile_url}
      students << student_info
      end
    students
  end

  def self.scrape_profile_page(profile_url)
   school = Nokogiri::HTML(open(profile_url))
      student = {}

      container = school.css(".social-icon-container a").collect{|icon| icon.attribute("href").value}
      container.each do |link|
        if link.include?("twitter")
          student[:twitter] = link
        elsif link.include?("linkedin")
          student[:linkedin] = link
        elsif link.include?("github")
          student[:github] = link
        elsif link.include?(".com")
          student[:blog] = link
        end
      end
      student[:profile_quote] = school.css(".profile-quote").text
      student[:bio] = school.css("div.description-holder p").text
      student
  end  
  

end

