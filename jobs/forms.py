from django import forms

from .models import JobPost


class JobPostForm(forms.ModelForm):
    class Meta:
        model = JobPost
        fields = [
            'title',
            'company_name',
            'location',
            'job_type',
            'required_skills',
            'description',
        ]
        widgets = {
            'required_skills': forms.Textarea(attrs={'rows': 3}),
            'description': forms.Textarea(attrs={'rows': 6}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for name, field in self.fields.items():
            if name == 'job_type':
                field.widget.attrs['class'] = 'form-select'
            else:
                field.widget.attrs['class'] = 'form-control'


class JobFilterForm(forms.Form):
    q = forms.CharField(required=False)
    location = forms.CharField(required=False)
    skills = forms.CharField(required=False)
    job_type = forms.ChoiceField(
        required=False,
        choices=[('', 'All Job Types')] + JobPost.JOB_TYPE_CHOICES,
    )

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['q'].widget.attrs.update(
            {
                'class': 'form-control',
                'placeholder': 'Search by title, company, keyword...',
            }
        )
        self.fields['location'].widget.attrs.update(
            {
                'class': 'form-control',
                'placeholder': 'Filter by location',
            }
        )
        self.fields['skills'].widget.attrs.update(
            {
                'class': 'form-control',
                'placeholder': 'Filter by skills (e.g. python,django)',
            }
        )
        self.fields['job_type'].widget.attrs.update({'class': 'form-select'})
