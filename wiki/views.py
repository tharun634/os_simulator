from django.shortcuts import render

# Create your views here.


def bankers(request):
    return render(request, 'wiki/bankers.html')


def disk(request):
    return render(request, 'wiki/disk.html')


def mem(request):
    return render(request, 'wiki/Mem.html')


def pra(request):
    return render(request, 'wiki/PRA.html')


def process(request):
    return render(request, 'wiki/Process.html')


def semaphore(request):
    return render(request, 'wiki/Semaphore.html')


def socket(request):
    return render(request, 'wiki/Socket.html')


def file(request):
    return render(request, 'wiki/FileStructure.html')
