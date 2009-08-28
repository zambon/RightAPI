#!/usr/bin/ruby

##############################################################################
##############################################################################

require 'rubygems'   # not required if ruby >= 1.9

#####
## This is not a complete list of api calls: see API reference
#####

class RightAPI
require 'rest_client'

@apiobject = Object.new
	
attr_accessor :username, :password, :account, :api_version
	def initialize

	@api =	{	:servers		=> "servers" ,
			:deployments		=> "deployments",
			:ebs			=> "ec2_ebs_volumes",
			:snapshots		=> "ec2_ebs_snapshots",
			:alerts			=> "alert_specs",
			:eips			=> "ec2_elastic_ips",
			:securitygroups		=> "ec2_security_groups",
			:sshkeys		=> "ec2_ssh_keys",
			:arrays			=> "server_arrays",
			:s3			=> "s3_buckets",
			:credentials		=> "credentials",
			:macros			=> "macros",
			:servertemplates	=> "server_templates",
			:rightscripts		=> "right_scripts",
			:status			=> "statuses"
		}

		@logged_in=false

	api_version='1.0' if api_version == nil

	end
	
	def	login(username, password, account) 
		@username = username
		@password = password
		@account = account
		RestClient.log = 'rest.log'
		@apiobject = RestClient::Resource.new("https://my.rightscale.com/api/acct/#{@account}",@username,@password)
		@logged_in=true
	end

	def	servers_show_all
		# Get /api/acct/1/servers		
		show_all(:servers)
	end
	
	def	show_all(obj)
		@apiobject[obj].get :x_api_version => '1.0'
	end

	def	show_item(obj,id)

		if obj == :credentials then
		#@apiobject[@api[:credentials]+"/#{id}"].get :x_api_version => '1.0'
		end
	end

	def	arrays_create(params)
		@apiobject[@api[:arrays]].post params, :x_api_version => '1.0'
	end
	
	def	arrays_update(arrayid,params)
		@apiobject[@api[:arrays]+"/#{id}"].put params, :x_api_version => '1.0'
	end
	
	def	arrays_delete(id)
		@apiobject[@api[:arrays]+"/#{id}"].delete :x_api_version => '1.0'
	end
	
	def	arrays_show(id)
		@apiobject[@api[:arrays]+"/#{id}"].get :x_api_version => '1.0'
	end
	
	def	credentials_show_all
		show_all(:credentials)
	end
	
	def	credentials_show(id)
		show_item(:credentials,id)

		#@apiobject[@api[:credentials]+"/#{id}"].get :x_api_version => '1.0'
	end
	
	def	credentials_create(params)
		@apiobject[@api[:credentials]].post params, :x_api_version => '1.0'
	end
	
	def	credentials_update(id)
		params = {}
		@apiobject[@api[:credentials]+"/#{id}"].put params, :x_api_version => '1.0'
	end
	
	def	credentials_delete(id)
		@apiobject[@api[:credentials]+"/#{id}"].delete :x_api_version => '1.0'
	end
	
	def	servertemplates_show_all
		@apiobject[@api[:servertemplates]].get :x_api_version => '1.0'
	end
	
	def	servertemplates_show(id)
		@apiobject[@api[:servertemplates]+"/#{id}"].get :x_api_version => '1.0'
	end
	
	def	arrays_show_all
		show_all(:arrays)
	end
	
	def	s3_show(id)
		@apiobject[@api[:s3]+"/#{id}"].get :x_api_version => '1.0'
	end
	
	def	s3_delete(id)
		@apiobject[@api[:s3]+"/#{id}"].delete :x_api_version => '1.0'
	end
	
	def	s3_create(name)
		params = { "s3_bucket[name]" => name }
		@apiobject[@api[:s3]+"/#{id}"].post params, :x_api_version => '1.0'
	end
	
	def	s3_show_all
		show_all(:s3)	
	end
	
	def	alerts_show_all
		show_all(:alerts)
	end
	
	def	alerts_show(id)
		@apiobject[@api[:alerts]+"/#{id}"].get :x_api_version => '1.0'
	end

	def	eips_show_all
		show_all(:eips)
	end

	def	eips_create
		params = {}
		@apiobject[@api[:eips]].get params, :x_api_version => '1.0'
	end

	def	eips_show(id)
		@apiobject[@api[:eips]+"/#{id}"].get :x_api_version => '1.0'
	end

	def	eips_delete(id)
		@apiobject[@api[:eips]+"/#{id}"].delete :x_api_version => '1.0'
	end

	def	alerts_delete(id)
		@apiobject[@api[:alerts]+"/#{id}"].delete :x_api_version => '1.0'
	end
	
	def	deployments_show_all
		show_all(:deployments)
	end

	def	snapshots_show_all
		show_all(:snapshots)
	end
	
	def	securitygroups_show_all
		show_all(:security_groups)
	end
	
	def	securitygroups_show(id)
		@apiobject[@api[:securitygroups]+"/#{id}"].get :x_api_version => '1.0'
	end
	
	def	securitygroups_delete(id)
		@apiobject[@api[:securitygroups]+"/#{id}"].delete :x_api_version => '1.0'
	end
	
	def	sshkeys_show(id)
		@apiobject[@api[:sshkeys]+"/#{id}"].get :x_api_version => '1.0'
	end
	
	def	sshkeys_create(keyname)
		params = { "ec2_ssh_key[aws_key_name]" => keyname }
		@apiobject[@api[:sshkeys]].post params, :x_api_version => '1.0'
	end
	
	def	sshkeys_delete(id)
		@apiobject[@api[:sshkeys]+"/#{id}"].delete :x_api_version => '1.0'
	end
	
	def	deployments_start_all(id)
                #URL: POST /api/acct/1/deployments/000/start_all
		params = {}
		@apiobject[@api[:deployments]+"/#{id}/start_all"].post params ,:x_api_version => '1.0'
	end

	def	deployments_stop_all(id)
                #URL: POST /api/acct/1/deployments/000/start_all
		params = {}
		@apiobject[@api[:deployments]+"/#{id}/stop_all"].post params, :x_api_version => '1.0'
	end

	def	deployments_create(nickname,description)
		#URL: POST /api/acct/1/deployments
		params = { "deployments[nickname]" => nickname, "deployments[description]" => description }
		@apiobject[@api[:deployments]].post params, :x_api_version => '1.0'
	end

	def	deployments_copy(id)
                #URL: POST /api/acct/1/deployments/000/start_all
		params = {}
		@apiobject[@api[:deployments]+"/#{id}/duplicate"].post params, :x_api_version => '1.0'
	end

	def	deployments_delete(id)
                #URL: POST /api/acct/1/deployments/000/start_all
		@apiobject[@api[:deployments]+"/#{id}"].delete :x_api_version => '1.0'
	end

	def	deployments_show(id)
                #URL: GET /api/acct/1/deployments/1
		@apiobject[@api[:deployments]+"/#{id}"].get :x_api_version => '1.0'
	end

	def	status(id)
		#URL:  GET /api/acct/1/statuses/000
		@apiobject[@api[:status]+"/#{id}"].get :x_api_version => '1.0'
	end
	
	def	ebs_delete(ebsid)
		# URL:  DELETE /api/acct/1/ec2_ebs_volumes/1 
		@apiobject[@api[:ebs]+"/#{ebsid}"].delete :x_api_version => '1.0'
	end

	def	ebs_create(params) 
		#URL: POST /api/acct/1/ec2_ebs_volumes
		@apiobject[@api[:ebs]].post params, :x_api_version => '1.0'
	end

	def 	server_show(serverid)
		@apiobject[@api[:servers]+"/#{serverid}"].get :x_api_version => '1.0'
	end

	def	server_stop(serverid)
		params = {}
		@apiobject[@api[:servers]+"/#{serverid}/stop"].post params, :x_api_version => '1.0'	
	end		

	def	server_start(serverid)
		params = {}
		@apiobject[@api[:servers]+"/#{serverid}/start"].post params, :x_api_version => '1.0'	
	end		

	def	server_update(serverid, params)
		@apiobject[@api[:servers]+"/#{serverid}"].put params, :x_api_version => '1.0'
	end

	def 	run_script(scriptid, serverid)
		params = { "right_script" => "#{scriptid}" }
		puts params.inspect
		#URL: POST /api/acct/1/servers/000/run_script
	
		@apiobject[@api[:servers]+"/#{serverid}/run_script"].post params, :x_api_version => '1.0'
		
	end

	def	server_update_nickname(serverid, name)
		params = { "server[nickname]"	=> "#{name}" }	 
		@apiobject[@api[:servers]+"/#{serverid}"].put params, :x_api_version => '1.0'
	end
	
	def 	show_connection
		puts @apiobject.inspect
	end
	

private :show_all
private :show_item
end
