<!-- Add a new user permission rule -->
<div id="formadd">
	<form id="add">
		
		<label for="val">User Login</label>
		<input name="val" id="val" />
		
		<label for="type">Role</label>
		<select name="type">
			<% 	for( var r=0; r<rls.length; r++ )
				{
			%>	<option value="<%=rls[r].code%>"><%=rls[r].desc%></option>
			<%
				}
			%>
		</select>
		<br />
		<br />
		<input type="submit" class="btn btn-large btn-primary pull-right" value="Add permission" />
		<button id="btncancel" class="btn btn-large btn-danger pull-left">Cancel</button>
	</form>
</div>

<!-- add a new role/group -->
<div id="divRole" class="hiddenform">
	<form id="fRole">
		<input type="hidden" name="ix" value="" />
		
		<label for="desc">Role Description</label>
		<input type="text" name="desc" id="desc" />
		
		<label for="code">Code</label>
		<input type="text" name="code" id="code" style="width: 50px;"/>
		<span class="help-block">Two digit unique code for this role.</span>
		
		<label for="classname">Class Name</label>
		<input type="text" name="classname" id="classname" />
		<span class="help-block">No spaces. Used on global <em>$roles</em> object.</span>
		
		<br />
		<br />
		<input type="submit" class="btn btn-large btn-primary pull-right" value="Submit" />
		<button id="bcancel" class="btn btn-large btn-danger pull-left">Cancel</button>
	</form>
</div>

<!-- add a new page permission -->
<div id="divPagePerm" class="hiddenform">
	<form id="fPagePerm">
		<input type="hidden" name="ix" />
		
		<label for="page">Page</label>
		<input type="text" name="page" id="page" />
		<span class="help-block">ASP page with file extension.</span>
		
		<label for="allow">Allowed Groups</label>
		<input type="text" name="allow" id="allow" />
		<span class="help-block">Use role group classname.</span>
		
		<br />
		<br />
		<input type="submit" class="btn btn-large btn-primary pull-right" value="Submit" />
		<button id="bpagecancel" class="btn btn-large btn-danger pull-left">Cancel</button>
	</form>
</div>

<!-- add a new setting -->
<div id="divCreateSetting" class="hiddenform">
	<form id="fCreateSetting">
		
		<label for="s_id">Setting</label>
		<input type="text" name="s_id" id="s_id" />
		<span class="help-block">No spaces or special characters except underscore.</span>
		
		<label for="s_ex">Description</label>
		<input type="text" name="s_ex" id="s_ex" />
		<span class="help-block">Description of this setting, including expected values.</span>
		
		<label for="s_v">Value</label>
		<input type="text" name="s_v" id="s_v" />
		<span class="help-block">Initial value for this setting.</span>
		
		<br />
		<br />
		<input type="submit" class="btn btn-large btn-primary pull-right" value="Submit" />
		<button id="bCancelSetting" class="btn btn-large btn-danger pull-left">Cancel</button>
	</form>
</div>