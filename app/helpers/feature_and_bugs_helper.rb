module FeatureAndBugsHelper
  def feature_status_options
    [ "new", "started", "completed" ]
  end

  def bug_status_options
    [ "new", "started", "resolved" ]
  end

  def status_to_string(status, item_type)
    if item_type == "feature"
      feature_status_options[status]
    elsif item_type == "bug"
      bug_status_options[status]
    else
      "unknown"
    end
  end
end
