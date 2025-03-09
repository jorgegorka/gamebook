module ChaptersHelper
  def chapter_statuses_for_select
    [
      [ Chapter::STATUS_DRAFT, t("chapters.status.draft") ],
      [ Chapter::STATUS_EDITING,t( "chapters.status.editing") ],
      [ Chapter::STATUS_READY, t("chapters.status.ready") ]
    ]
  end
end
