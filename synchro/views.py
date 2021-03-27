from django.shortcuts import render

# Create your views here.
from . models import SynchroAlg


def index(request):
    algos = SynchroAlg.objects.filter(demourl="sem")
    context = {'algos': algos}
    return render(request, 'semaphores/index.html', context=context)


def socket(request):
    algos = SynchroAlg.objects.filter(demourl="tcp")
    context = {'algos': algos}
    return render(request, 'semaphores/socket_index.html', context=context)


def deadlocks(request):
    return render(request, 'semaphores/bankerindex.html')


def bankalgo(request):
    return render(request, 'semaphores/bankers.html')


def demo(request, pk):
    if(pk == '1'):
        return render(request, 'semaphores/prodcon2.html')
    if(pk == '2'):
        return render(request, 'semaphores/readerwriter.html')
    if(pk == '3'):
        return render(request, 'semaphores/diningphils.html')
    if(pk == '4'):
        return render(request, 'semaphores/sleepingbarber.html')
