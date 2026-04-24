from django import forms

from accounts.models import AccountProfile
from applications.models import JobApplication
from jobs.models import JobPost
from .models import FeedbackTicket


class ReportFilterForm(forms.Form):
    start_date = forms.DateField(
        required=False,
        widget=forms.DateInput(attrs={'type': 'date', 'class': 'form-control'}),
    )
    end_date = forms.DateField(
        required=False,
        widget=forms.DateInput(attrs={'type': 'date', 'class': 'form-control'}),
    )
    status = forms.ChoiceField(
        required=False,
        choices=[('', 'All Statuses')] + JobApplication.STATUS_CHOICES,
        widget=forms.Select(attrs={'class': 'form-select'}),
    )
    role = forms.ChoiceField(
        required=False,
        choices=[('', 'All Applicant Roles')] + AccountProfile.ROLE_CHOICES,
        widget=forms.Select(attrs={'class': 'form-select'}),
    )
    job_type = forms.ChoiceField(
        required=False,
        choices=[('', 'All Job Types')] + JobPost.JOB_TYPE_CHOICES,
        widget=forms.Select(attrs={'class': 'form-select'}),
    )

    def clean(self):
        cleaned_data = super().clean()
        start_date = cleaned_data.get('start_date')
        end_date = cleaned_data.get('end_date')

        if start_date and end_date and start_date > end_date:
            self.add_error('end_date', 'End date must be greater than or equal to start date.')

        return cleaned_data


class FeedbackTicketForm(forms.ModelForm):
    class Meta:
        model = FeedbackTicket
        fields = ['subject', 'message']
        widgets = {
            'message': forms.Textarea(attrs={'rows': 5}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['subject'].widget.attrs.update(
            {
                'class': 'form-control',
                'placeholder': 'Short title for your issue or suggestion',
            }
        )
        self.fields['message'].widget.attrs.update(
            {
                'class': 'form-control',
                'placeholder': 'Describe your issue or suggestion in detail...',
            }
        )

    def clean_subject(self):
        subject = self.cleaned_data['subject'].strip()
        if len(subject) < 5:
            raise forms.ValidationError('Subject must be at least 5 characters long.')
        return subject

    def clean_message(self):
        message = self.cleaned_data['message'].strip()
        if len(message) < 10:
            raise forms.ValidationError('Message must be at least 10 characters long.')
        return message
