#TODO: move to shared_contexted
shared_examples "has 302 status and redirect to login_path" do
  it do
    expect(response).to have_http_status 302
    expect(response).to redirect_to login_path
  end
end  

