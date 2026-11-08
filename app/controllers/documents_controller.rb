class DocumentsController < ApplicationController
  before_action :set_document, only: :show

  def index
    @documents = Current.user.documents.order(created_at: :desc)
  end

  def show
  end

  def new
    @document = Current.user.documents.new
  end

  def create
    @document = Current.user.documents.new(document_params)

    if @document.save
      redirect_to @document, notice: "Document was successfully created."
    else
      render :new, status: :unprocessable_content
    end
  end

  private
    def set_document
      @document = Current.user.documents.find(params[:id])
    end

    def document_params
      params.expect(document: %i[ title body ])
    end
end
