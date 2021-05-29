from datetime import datetime, timedelta
from django.http import HttpResponse
from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from allauth.socialaccount.models import SocialToken, SocialAccount
from django.contrib import messages
import requests
import json
from django.conf import settings

def home(request):
    return render(request, 'leaf/login.html')

def admin(request):
    return render(request, 'leaf/admin_leaf.html')

def verker(request):
    return render(request, 'leaf/werker.html')

def vorarbeiter(request):
    return render(request, 'leaf/vorarbeiter.html')

def nfmwerker(request):
	return render(request, 'leaf/nfmwerker.html')

@login_required(login_url='wzlapplocal_login')
def nfmadmin(request):
	return render(request, 'leaf/nfmadmin.html')

@login_required(login_url='wzlapplocal_login')
def datenbank(request):
    access_token = SocialToken.objects.get(account__user=request.user, account__provider='wzlapplocal')
    r = requests.get(settings.URL_PCC+'/api/leaf?access_token=' + access_token.token)
    if r.status_code != 200:#not success
        return render(request, 'leaf/denied.html')
    else:
        context = {
            'data': json.dumps(r.json()['data'])
        }
    #    print(context)
        return render(request, 'leaf/datenbank.html', context=context)

def nfmvorarbeiter(request):
	return render(request, 'leaf/nfmvorarbeiter.html')

def sample(request):
	return render(request, 'leaf/sample.html')

def fmedit(request):#print("<------------- entering fmedit function -------------->")
    return render(request, 'leaf/fmedit.html')

@login_required(login_url='wzlapplocal_login')
def fmedit_id(request, fm_id):
    if not is_leaf_admin(request):#return render(request, 'leaf/datenbank.html') #if not admin then send him back
        return render(request,'leaf/denied.html')# redirect to the denied access page
    #print("<------------- entering fmedit_id with fm_id being "+str(fm_id)+"------------>")
    access_token = SocialToken.objects.get(account__user=request.user, account__provider='wzlapplocal')
    thetoken = access_token.token
    #access_token = SocialToken.objects.get(account__user=request.user, account__provider='wzlapp')
    #if not is_leaf_admin():#return render(request, 'leaf/datenbank.html') #if not admin then send him back
    #    print("<------------- user is not an admin ------------>")
    #    return render(request, 'leaf/denied.html')# redirect to the denied access page
    #print("<------------- user is an admin ------------>")
    #print(thetoken)
    initial_request = requests.get(settings.URL_PCC+'/api/leaf/'+ str(fm_id) +'?access_token=' + thetoken)
    initial_request_content=(initial_request.content)
    #print(initial_request_content)
    #print("JSON (type is bytes) to dict")
    vals_as_dict_all=json.loads(initial_request_content)
    #print("type is: "+str(type(vals_as_dict_all)))
    #print(vals_as_dict_all)
    initial_values = vals_as_dict_all["record"]
    #print(initial_values)
    #if not initial_values["recoverable"]:#better way to preset the checkbox:{% if initial_values.recoverable %} checked{% endif %}
    #    del initial_values["recoverable"]
    initial_values['fm_id'] = fm_id
    #print(initial_values)
    return render(request, 'leaf/fmedit.html', context={"initial_values": initial_values})

def nfmpreprocessing(request):
    request.POST._mutable = True
    #print("<------------- mutable on -------------->")
    #print("<------------- init status -------------->")
    #for key, value in request.POST.lists():
    #    print ("%s %s" % (key, value))
    #print("<------------- append recoverable -------------->")
    if request.POST.__contains__('customRadio') or request.POST.__contains__('customRadio2'):
        if request.POST.__contains__('customRadio') and request.POST['customRadio'] == "on":
            request.POST.update({'recoverable': "true"})
        elif request.POST.__contains__('customRadio2') and request.POST['customRadio2'] == "on":
            request.POST.update({'recoverable': "false"})
    else:
        request.POST.update({'recoverable': "false"})
    #print("<------------- datetime -------------->")
    time_without_hours_minutes = datetime.strptime(request.POST['error_datetime'], '%d/%m/%Y')
    time_without_year_month_date = datetime.strptime(request.POST['nfdate3'],'%H:%M %p').time()
    #print("<------------- time_without_hours_minutes -------------->")
    #print(time_without_hours_minutes)
    #print("<------------- time_without_year_month_date -------------->")
    #print(time_without_year_month_date)
    #print("<------------- datetime replace -------------->")
    #print("<------------- time_without_hours_minutes -------------->")
    time_without_hours_minutes = time_without_hours_minutes.replace(hour=time_without_year_month_date.hour, minute=time_without_year_month_date.minute,second=0)
    #print(time_without_hours_minutes)
    time_without_hours_minutes = time_without_hours_minutes.strftime('%Y-%m-%dT%H:%M:%S')
    #print(time_without_hours_minutes)
    request.POST['error_datetime']=time_without_hours_minutes
    #print("<------------- append access_token -------------->")
    access_token = SocialToken.objects.get(account__user=request.user, account__provider='wzlapplocal')
    request.POST.update({"access_token": access_token})
    request.POST.update({"measures" : "Wiederholen"})
    #print("<------------- results -------------->")
    #for key, value in request.POST.lists():
    #    print ("%s %s" % (key, value))
    request.POST._mutable = False
    #data = {'error_datetime': '2020-04-14T02:03:00', 'nfdate3': '2:03 PM', 'status': 'Offen', 'activity': 'Arbeitsvorbereitung', 'failure': 'Hilfstoffe hoch nicht geliefert', 'cause': 'Kurzfristige Liefertermine nicht haltbar', 'description': '345', 'customRadio': 'on', 'nfbild': '', 'recoverable': True, 'measures': 'Wiederholen'}
    data = request.POST
    #print(data)
    #print("<------------- mutable off -------------->")
    response = requests.post(settings.URL_PCC+'/api/leaf/add_record?access_token=' + access_token.token, data=data)
    #                        settings.URL_PCC+'/api/leaf/add_record'
    #print("<------------- status_code -------------->")
    #print(response.status_code)
    if response.status_code == 200:#success
        return render(request, 'leaf/nfmsuccess.html')
    #if response.status_code == 401:#unvalid token
    else:
        return render(request, 'leaf/denied.html')
def is_leaf_admin(request):##extra_data = {"id": 13, "email": "a.toure@wzl.rwth-aachen.de", "created_at": "2020-04-03T09:28:59.034Z", "updated_at": "2020-04-14T14:09:38.191Z", "firstname": "Sebastien Abbas", "lastname": "Tour\u00e9", "site_role": "user", "role_data": {"LeaF": ["werker", "vorarbeiter", "admin"]}}
    #SocialAccount_object_got=SocialAccount.objects.get(account__user=request.user,account__provider='wzlapp')
    #print("<--------------- entering is_leaf_admin()--------------------->")
    SocialAccount_object_got=SocialAccount.objects.get(user=request.user,provider='wzlapplocal')
    #for key, value in SocialAccount_object_got:
    #    print ("%s %s" % (key, value))
    #print("SocialAccount_object_got")
    #print(SocialAccount_object_got)
    extra_data_all = SocialAccount_object_got.extra_data
    #print("extra_data_all")
    #print(extra_data_all)
    retrieved_role = extra_data_all['role_data'] #"role_data": {"LeaF": ["werker", "vorarbeiter", "admin"]}
    #print("retrieved_role")
    #print(retrieved_role)
    for user_role_iteration in retrieved_role['LeaF']:#print(type(user_role_iteration))
        if user_role_iteration == "admin":#print("<---------------Current user is admin.--------------------->")
            return True
    #print("<---------------Current user is NOT admin.--------------------->")
    return False


def is_creator(request,id_to_check):#SocialToken_object_gotten=SocialAccount.objects.get(account__user=request.user,account__provider='wzlapp')
    #print("<--------------- entering is_creator()--------------------->")
    SocialAccount_object_got=SocialAccount.objects.get(user=request.user,provider='wzlapplocal')
    #for key, value in SocialAccount_object_got:
    #    print ("%s %s" % (key, value))
    #print(SocialAccount_object_got)
    extra_data_all = SocialAccount_object_got.extra_data
    retrieved_personal_id= extra_data_all["id"]
    if retrieved_personal_id != id_to_check:
        return False
    else:
         return True

@login_required(login_url='wzlapplocal_login')
def fmeditpreprocessing(request,fm_id):#fmeditpreprocessing
    if not is_leaf_admin(request):#return render(request, 'leaf/datenbank.html') #if not admin then send him back
        return render(request,'leaf/denied.html')# redirect to the denied access page
    #print("<--------------- entering fmeditpreprocessing--------------------->")
    #for key, value in request.POST.lists():
    #    print ("%s %s" % (key, value))
    data=request.POST.copy()#to have a mutable copy
    #print(data)
    #PUT: settings.URL_PCC+'/api/leaf/1/update'
    access_token = SocialToken.objects.get(account__user=request.user, account__provider='wzlapplocal')
    #print("access_token.token is type: "+str(type(access_token.token)))
    #print("fm_id is type: "+str(type(fm_id)))
    #print("data is type: "+str(type(data)))
    if "customRadio" in data:#recoverable checkbox
        data.update({'recoverable': "true"})#as string for the backend! python boolean type in this form not compatible with backend!
    #    print("recoverable True")
    else:
        data.update({'recoverable': "false"})
    #    print("recoverable False")
    response = requests.put(settings.URL_PCC+'/api/leaf/'+ str(fm_id) +'/update?access_token=' + access_token.token, data=data)
    #print("put response"+str(response))
    #print(data)
    if response.status_code == 200:
        messages.success(request, 'Fehlermeldung '+str(fm_id)+' wurde erfolgreich editiert!')
        return render(request, 'leaf/admin_leaf.html')
    elif response.status_code == 500:
        messages.error(request, 'Sie sind nicht berechtigt, versuchte Änderungen durchzuführen!')
        return render(request, 'leaf/denied.html')
    else:
        messages.error(request, 'Änderung nicht erfolgreich. Fehlercode: '+str(response.status_code))
        return render(request, 'leaf/fmeditnothingchanged.html')

def fmeditsubmit(request, initial_request):#momentarily unused, but some parts will maybe be used in the future
    if not is_leaf_admin():#return render(request, 'leaf/datenbank.html') #if not admin then send him back
        return render(request, 'leaf/denied.html') # redirect to the denied access page
    changed_values = []
    for key_outer, value_outer in request.POST.lists():#compare entered values to the initial form
        for key_inner, value_inner in initial_request.lists():
            if key_inner is key_outer and value_outer is not value_inner:
                changed_values.update({key_outer: value_outer})
    if not changed_values.len() > 0: #skip preprocessing if nothing was changed
        return render(request, 'fmeditnothingchanged.html')
    if changed_values.__contains__('customRadio') or changed_values.__contains__('customRadio2'):
        if changed_values.__contains__('customRadio') and changed_values['customRadio'] == "on":
            changed_values.update({'recoverable': True})
        elif changed_values.__contains__('customRadio2') and changed_values['customRadio2'] == "on":
            changed_values.update({'recoverable': False})
    values_to_consider = ["nfdate3"]#"error_datetime","measures","status","activity","failure","cause","description","nfbild"]
    #for key in values_to_consider:
    #    if changed_values.__contains__(key):
    if changed_values.__contains__('nfdate3'):
        #print("<------------- datetime -------------->")
        time_without_hours_minutes = datetime.strptime(initial_request.POST['error_datetime'], '%d/%m/%Y')
        time_without_year_month_date = datetime.strptime(changed_values['nfdate3'],'%H:%M %p').time()
        #print("<------------- time_without_hours_minutes -------------->")
        #print(time_without_hours_minutes)
        #print("<------------- time_without_year_month_date -------------->")
        #print(time_without_year_month_date)
        #print("<------------- datetime replace -------------->")
        #print("<------------- time_without_hours_minutes -------------->")
        time_without_hours_minutes = time_without_hours_minutes.replace(hour=time_without_year_month_date.hour, minute=time_without_year_month_date.minute,second=0)
        #print(time_without_hours_minutes)
        time_without_hours_minutes = time_without_hours_minutes.strftime('%Y-%m-%dT%H:%M:%S')
        #print(time_without_hours_minutes)
        changed_values['error_datetime']=time_without_hours_minutes
    #put/patch to the record
    response = requests.post(settings.URL_PCC+'/api/leaf/' + id + '/update?access_token=' + access_token.token, data=changed_values)
    if response.status_code == 200:#success
        return render(request, 'fmeditsuccess.html')
    #if response.status_code == 401:#unvalid token
    else:
        return render(request, 'leaf/denied.html')
def index(request):
    return render(request, 'leaf/index.html')
def processinglogout(request):
    we_say_bye_to= request.user
    session_storage_length = 0
    temp = []
    for i in request.session.keys():
        session_storage_length += 1
        print("we find: "+str(request.session[i]))
        print("session_storage_length ="+str(session_storage_length))
        temp.append(i)
#        del request.session[i]
    for i in temp:
        print("we delete: "+str(request.session[i]))
        request.session.pop(i)
#    messages.success(request, str(we_say_bye_to)+' wurde ausgeloggt!')
    messages.success(request, ' Erfolgreich abgemeldet!')
    return render(request, 'leaf/admin_leaf.html')

@login_required(login_url='wzlapplocal_login')
def profilepage(request):
    return render(request, 'leaf/profile.html')
