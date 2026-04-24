from django import forms

from .models import ResumeDocument, UserProfile
from .validators import validate_resume_pdf_file


class ProfileForm(forms.ModelForm):
    class Meta:
        model = UserProfile
        fields = [
            'phone',
            'location',
            'education_summary',
            'skills_text',
            'experience_summary',
            'visibility',
        ]
        widgets = {
            'education_summary': forms.Textarea(attrs={'rows': 3}),
            'skills_text': forms.Textarea(attrs={'rows': 3}),
            'experience_summary': forms.Textarea(attrs={'rows': 3}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for name, field in self.fields.items():
            if name == 'visibility':
                field.widget.attrs['class'] = 'form-select'
            else:
                field.widget.attrs['class'] = 'form-control'


class ResumeUploadForm(forms.ModelForm):
    class Meta:
        model = ResumeDocument
        fields = ['file']

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['file'].widget.attrs['class'] = 'form-control'
        self.fields['file'].widget.attrs['accept'] = '.pdf'

    def clean_file(self):
        resume_file = self.cleaned_data['file']
        validate_resume_pdf_file(resume_file)
        return resume_file
