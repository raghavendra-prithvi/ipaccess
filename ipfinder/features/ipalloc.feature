Feature: Ip Allocation Service

  Scenario: Allocating Ip to device
    Given I assign "1.2.2.44" to "device255"
    When I call 1.2.2.44
    Then I should see "device255"
    
  Scenario: Changing Ip to device
    Given I assign "1.2.2.44" to "device222"
    When I call 1.2.2.44
    Then I should see "device222"
  
  Scenario: Calling the IpAddress which is not allocated
    When I call 1.2.3.4
    Then I should see "NotFound"
  
  Scenario: Allocating with wrong IPadress Format
    When I call "1.2.2.266"
    Then I should see "InvalidInput"
  
    
    