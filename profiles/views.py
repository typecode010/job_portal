from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.shortcuts import render

from .forms import ProfileForm, ResumeUploadForm
from .models import ResumeDocument, UserProfile


@login_required
def profile_view(request):
	profile, _ = UserProfile.objects.get_or_create(user=request.user)

	if request.method == 'POST':
		form = ProfileForm(request.POST, instance=profile)
		if form.is_valid():
			form.save()
			messages.success(request, 'Profile updated successfully.')
	else:
		form = ProfileForm(instance=profile)

	return render(request, 'profiles/profile.html', {'form': form})


@login_required
def resume_upload_view(request):
	latest_resume = ResumeDocument.objects.filter(user=request.user, is_active=True).first()

	if request.method == 'POST':
		form = ResumeUploadForm(request.POST, request.FILES)
		if form.is_valid():
			ResumeDocument.objects.filter(user=request.user, is_active=True).update(is_active=False)
			resume = form.save(commit=False)
			resume.user = request.user
			resume.is_active = True
			resume.save()
			messages.success(request, 'Resume uploaded successfully.')
			latest_resume = resume
			form = ResumeUploadForm()
	else:
		form = ResumeUploadForm()

	return render(
		request,
		'profiles/resume_upload.html',
		{
			'form': form,
			'latest_resume': latest_resume,
		},
	)
