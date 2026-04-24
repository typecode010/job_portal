from django import forms


class MessageForm(forms.Form):
    body = forms.CharField(
        max_length=1000,
        widget=forms.Textarea(
            attrs={
                'class': 'form-control',
                'rows': 3,
                'placeholder': 'Type your message...',
            }
        ),
    )

    def clean_body(self):
        body = self.cleaned_data['body'].strip()
        if not body:
            raise forms.ValidationError('Message body is required.')
        if len(body) > 1000:
            raise forms.ValidationError('Message body cannot exceed 1000 characters.')
        return body
