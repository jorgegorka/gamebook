module ApplicationHelper
  def banner_type(type)
    case type.to_s
    when "alert", "error"
      "bg-red-800 text-red-100"
    else
      "bg-indigo-800 text-indigo-100"
    end
  end
end
