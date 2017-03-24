{#

OPNsense® is Copyright © 2014 – 2015 by Deciso B.V.
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1.  Redistributions of source code must retain the above copyright notice,
this list of conditions and the following disclaimer.

2.  Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED “AS IS” AND ANY EXPRESS OR IMPLIED WARRANTIES,
INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.

---------------------------------------------------------------------------------------------------------------
Generate input dialog, uses the following parameters (as associative array):

fields          :   list of field type objects, see form_input_tr tag for details
id              :   form id, used as unique id for this form.
apply_btn_id    :   id to use for apply button (leave empty to ignore)
data_title      :   data-title to set on form

#}

{# Find if there are help supported or advanced field on this page #}
{% set base_form_id=id %}
{% set help=false %}
{% set advanced=false %}
{% for field in fields|default({})%}
{%     for name,element in field %}
{%         if name=='help' %}
{%             set help=true %}
{%         endif %}
{%         if name=='advanced' %}
{%             set advanced=true %}
{%         endif %}
{%     endfor %}
{%     if help|default(false) and advanced|default(false) %}
{%         break %}
{%     endif %}
{% endfor %}
<form id="{{base_form_id}}" class="form-inline" data-title="{{data_title|default('')}}">
  <div class="table-responsive">
    <table class="table table-striped table-condensed">
        <colgroup>
            <col class="col-md-3"/>
            <col class="col-md-4"/>
            <col class="col-md-5"/>
        </colgroup>
        <tbody>
        <tr>
            <td align="left">{% if advanced|default(false) %}<a href="#"><i class="fa fa-toggle-off text-danger" id="show_advanced_{{base_form_id}}" type="button"></i> </a><small>{{ lang._('advanced mode') }} </small>{% endif %}</td>
            <td colspan="2" align="right">
                {% if help|default(false) %}<small>{{ lang._('full help') }} </small><a href="#"><i class="fa fa-toggle-off text-danger" id="show_all_help_{{base_form_id}}" type="button"></i></a>{% endif %}
            </td>
        </tr>
        {% set advanced=false %}
        {% set help=false %}
        {% set style=false %}
        {% set hint=false %}
        {% set style=false %}
        {% set maxheight=false %}
        {% set width=false %}
        {% set allownew=false %}
        {% for field in fields|default({})%}
            {% if field['type'] == 'header' %}
              {# close table and start new one with header #}

{#- macro base_dialog_header(field) #}
      </tbody>
    </table>
  </div>
  <div class="table-responsive {% if field['style'] %}{{field['style']}}{% endif %}">
    <table class="table table-striped table-condensed table-responsive">
        <colgroup>
            <col class="col-md-3"/>
            <col class="col-md-4"/>
            <col class="col-md-5"/>
        </colgroup>
        <thead>
          <tr colspan="3">
            <th><h2>{{field['label']}}</h2></th>
          </tr>
        </thead>
        <tbody>
{#- endmacro #}

            {% else %}
              {{ partial("layout_partials/form_input_tr",field)}}
            {% endif %}

            {# looks a bit buggy in the volt templates, field parameters won't reset properly here #}
            {% set advanced=false %}
            {% set help=false %}
            {% set style=false %}
            {% set hint=false %}
            {% set style=false %}
            {% set maxheight=false %}
            {% set width=false %}
            {% set allownew=false %}
        {% endfor %}
        {% if apply_btn_id|default('') != '' %}
        <tr>
            <td colspan="3"><button class="btn btn-primary" id="{{apply_btn_id}}" type="button"><b>{{ lang._('Apply') }} </b><i id="{{base_form_id}}_progress" class=""></i></button></td>
        </tr>
        {% endif %}
        </tbody>
    </table>
  </div>
</form>
