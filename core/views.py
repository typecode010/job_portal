from django.shortcuts import redirect, render


def home(request):
    if request.user.is_authenticated:
        return redirect('dashboard:home')

    return render(request, 'core/home.html')
