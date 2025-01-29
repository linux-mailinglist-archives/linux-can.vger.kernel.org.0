Return-Path: <linux-can+bounces-2705-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ACEA21CEA
	for <lists+linux-can@lfdr.de>; Wed, 29 Jan 2025 13:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F9F93A4A08
	for <lists+linux-can@lfdr.de>; Wed, 29 Jan 2025 12:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3536B1B4230;
	Wed, 29 Jan 2025 12:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="LTEwPzkl"
X-Original-To: linux-can@vger.kernel.org
Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365C325A641;
	Wed, 29 Jan 2025 12:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.32.210.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738152281; cv=none; b=pFrufeZlCbvQ+y5aTytmknOw4aZ3OtPyF819cd5VqRyaYTIivr01RoOwmjGG3lMR5yIyqyNA6lITWHuD8AfjImzb6zDrEnL4bmECdmwYhn+K68ybLDywWwWRyAm87ybvs/IS7ybb9B/ZOSNZJdtB9mH44z0MDv29Ehrbds5Z9NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738152281; c=relaxed/simple;
	bh=hz+KvWR60wivbOWkIa1s68pktcH9jpUkX7R448U6Uyk=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:MIME-Version:
	 Content-Type:Content-Disposition:Message-Id; b=Co09nrbAsjjAYJriz0xfZj2cbVL1255WweNxdKKGGrPHz3s3fklgNVv5duLzWLfVL6gIly3GKeaPveTHB+51dMsx0Xv64nxWd9Bln75jXYo/hIQM6w+gqtLl8C8x/9i6/JA3RIeNtH1XmPAkr5nkMGhAaAxKE9iCRYuTbMmUzMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz; spf=pass smtp.mailfrom=fel.cvut.cz; dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b=LTEwPzkl; arc=none smtp.client-ip=147.32.210.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fel.cvut.cz
Received: from localhost (unknown [192.168.200.27])
	by smtpx.fel.cvut.cz (Postfix) with ESMTP id BCC404261F;
	Wed, 29 Jan 2025 13:04:34 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Authentication-Results: cerokez-250.feld.cvut.cz (amavis);
 dkim=pass (2048-bit key) header.d=fel.cvut.cz
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id a0Tm8kutOFsR; Wed, 29 Jan 2025 13:04:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1738152272;
	bh=Z5fs9aQ4xbUuXVS16IPag2uuEqT5gnYnvHLm2hQQ15w=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
	b=LTEwPzklAfxR62OeZy/JW8rRl7KLJ0H9rrvCSKvbo89xsb8ntuMoifJRvS1OZXoeI
	 ByhMEhiFxdNvR2ZJkS4YBh2U1pLYjZDOjkWuNtfb8rrlCEYV3lreAu5F/aRapKCxt/
	 Za4Q2uhI3Wrvj0YQa+19SN1DrCw37JcFp+JFvGU6mPuU+DrJjGlBqknHvzPW0aSbBW
	 t+pva+8f3hWa/ePgwSPlfwzr0L00X2qY/wgDhUPxvzx/cTpTg5RY1UPCEcAkRfZVKL
	 U5hp9aDS2F4cYLvxz8sHGkIzMusoScFdstsoZOKghtQgNmOHZ5pqkfZVJoTdom0AiD
	 7sLWgSQpfW2hg==
Received: from [147.32.86.192] (unknown [147.32.86.192])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pisa)
	by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 5599A425B9;
	Wed, 29 Jan 2025 13:04:32 +0100 (CET)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Question for AMD/Xilinx Zynq PREEMP_RT configuration check, CAN latency measuremet and FOSDEM 2025
Date: Wed, 29 Jan 2025 13:04:15 +0100
User-Agent: KMail/1.9.10
Cc: linux-rt-users@vger.kernel.org,
 Carsten Emde <c.emde@osadl.org>,
 linux-can@vger.kernel.org,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Jan Altenberg <Jan.Altenberg@osadl.org>,
 Pavel Hronek <hronepa1@fel.cvut.cz>
References: <202501281629.27139.pisa@fel.cvut.cz> <20250129101709.XQuo8Jle@linutronix.de>
In-Reply-To: <20250129101709.XQuo8Jle@linutronix.de>
X-KMail-QuotePrefix: > 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202501291304.15901.pisa@fel.cvut.cz>

Hello Sebastian,

On Wednesday 29 of January 2025 11:17:09 Sebastian Andrzej Siewior wrote:
> On 2025-01-28 16:29:27 [+0100], Pavel Pisa wrote:
> > Please check if you find some problematic choices.
>
> I didn't find anything obviously wrong. Assuming your CPU is busy in
> general you could remove NO_HZ in favour of PERIODIC. This is however
> not to cause spikes you describe below.

Great, thanks much for review by expert.

> > The cyclic test worked well, and we have even delivered two systems
> > to OSADL QA real-time farm
> >
> >   https://www.osadl.org/?id=4109
>
> It shows "IRQ work interrupts". Not sure what causes them.

I am not sure either. That list is from old kernel
in long term testing setup at OSADL.

The actual one show none IRQ work interrupts
after last reboot and overnigh test

Linux mzapo 6.13.0-rc6-rt3-dut #1 SMP PREEMPT_RT
Wed Jan 29 04:46:40 CET 2025 armv7l GNU/Linux

           CPU0       CPU1
 24:          0          0 GIC-0  27 Edge      gt
 25:     700822     327164 GIC-0  29 Edge      twd
 26:        300          0 GIC-0  59 Level     xuartps
 29:          0          0 GIC-0  45 Level     f8003000.dmac
 30:          0          0 GIC-0  46 Level     f8003000.dmac
 31:          0          0 GIC-0  47 Level     f8003000.dmac
 32:          0          0 GIC-0  48 Level     f8003000.dmac
 33:          0          0 GIC-0  49 Level     f8003000.dmac
 34:          0          0 GIC-0  72 Level     f8003000.dmac
 35:          0          0 GIC-0  73 Level     f8003000.dmac
 36:          0          0 GIC-0  74 Level     f8003000.dmac
 37:          0          0 GIC-0  75 Level     f8003000.dmac
 40:     460330          0 GIC-0  54 Level     end0
 41:          0          0 GIC-0  53 Level     e0002000.usb
 42:        356          0 GIC-0  56 Level     mmc0
 43:          0          0 GIC-0  43 Level     ttc_clockevent
 44:         25          0 GIC-0  39 Level     f8007100.adc
 45:          0          0 GIC-0  37 Level     arm-pmu
 46:          0          0 GIC-0  38 Level     arm-pmu
 47:        128          0 GIC-0  40 Level     f8007000.devcfg
 48:     314697          0 GIC-0  61 Level     can2
 49:     314597          0 GIC-0  62 Level     can3
 50:     314759          0 GIC-0  63 Level     can4
 51:     311516          0 GIC-0  64 Level     can5
IPI0:          0          0  CPU wakeup interrupts
IPI1:          0          0  Timer broadcast interrupts
IPI2:      17849     292126  Rescheduling interrupts
IPI3:       5923      11315  Function call interrupts
IPI4:          0          0  CPU stop interrupts
IPI5:     271078      74040  IRQ work interrupts
IPI6:          0          0  completion interrupts
Err:          0

So this seems as no cause.

> > However, the CAN/CAN FD communication latency measured on the CTU CAN FD
> > IP core is far from optimal. Some runs under load with
> > 10 msec latency. Our own CAN FD stack for RTEMS keeps with no exception
> > under 60 usec on the same hardware.
> >
> > I understand that the Linux socket layer and networking
> > stack are complex, and many optimizations are ahead.
> > We will be happy to contribute where we can and find time
> > and even some resources to engage more students etc...
> >
> > But I would like to be sure that the bad results are not
> > caused by our mistakes in configuration.
>
> You have CAN and "regular networking". My guess would be that regular
> networking blocks blocks BH and so your CAN. You could try to have all
> interrupts serviced on CPU0 and move CAN to CPU1. If so this should 
> improve then. Other than that, I would suggest to get some tracing to
> see what delays your CAN interrupts and/ or handling in general.

Yes, I think that design mixing regular networking packet
processing with CAN is the problem. We test even with setup where
CAN interrupts priority is boosted to 90

    echo "-> Rise CAN irq priorities"
    PIDS=$(ps -e | grep -E irq/[0-9]+-can[3-4] | tr -s ' ' | cut -d ' ' -f2)
    TXPID=$(ps -e | grep -E irq/[0-9]+-can2 | tr -s ' ' | cut -d ' ' -f2)
    chrt -f --pid 80 $TXPID
    for pid in $PIDS ; do
        chrt -f --pid 85 $pid
    done

ps Hxa --sort rtprio -o pid,policy,rtprio,state,tname,time,command

...
   70 FF      50 S ?        00:00:00 [irq/37-f8003000.dmac]
   71 FF      50 S ?        00:00:38 [irq/40-eth%d]
...
  405 FF      50 S ?        00:00:00 [irq/26-xuartps]
  355 FF      90 S ?        00:00:06 [irq/48-can2]
  361 FF      90 S ?        00:00:13 [irq/49-can3]
  366 FF      90 S ?        00:00:07 [irq/50-can4]
  371 FF      90 S ?        00:00:06 [irq/51-can5]
   22 FF      99 S ?        00:00:00 [migration/0]
   27 FF      99 S ?        00:00:00 [migration/1]

Even this setup is problematic under load.
The situation with CAN IRQ priority 50 and 90 can be compared
by clicking on "RT priority set" option

https://canbus.pages.fel.cvut.cz/can-latester/inspect.html?kernel=rt&prio=1&load=1&flood=1&fd=1

The switch between in kernel CAN gateway and userpace one
is controlled by "Kernel GW".

User CAN gateway is run with priority 80

  chrt -r 80 ugw -f can3 can2

I spot interesting trend after

  run-250103-045322-hist+6.13.0-rc1-rt1-g5374fecd2695+flood-prio-fd-load.json

that user gateway case, simple copy of frames from can3 to can2
has never exceed 1.4 ms almost for one month.
It could be interesting to corelate that with kernel changes.

We use branch

  for-kbuild-bot/current-stable

from

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git

to run daily testing. We can consider even something different,
but this choice has been given by interest in something
functional for each day and ahead of mainline merges to
catch some problems in advance.

It is interesting than in kernel gateway is significantly worse
now. It does not overhead of switching to userspace. But I am not
sure if it is not invoked in some kernel worker which
has lower or same real time priority than Ethenet networking.

In general, I think that the problem is that incommin
packets (CAN and Ethernet) load the same per CPU
worker. There are even backlog_napi threads per CPU

   46 TS       - S ?        00:00:00 [backlog_napi/0]
   47 TS       - S ?        00:00:00 [backlog_napi/1]

It has even TS priority. If I remember well, there has been
added option to allocate separate RX packets processing
therad (instead for default per CPU one) for given interface.
But I have no experience with such configuration.

Do you have or somebody else have idea how to achieve
that and if it is legal to boost such kernel therad
priority. It could help, because my general experience
with PREEMPT_RT even on this target is very positive
for tasks mapping HW directly and doing RT control.
Same for latency tester. No spikes under load over
250 usec or less.

> > I will be happy to meet you and discuss Linux and other
> > control and real-time areas at FOSDEM 2025.
>
> I should be able to make it.

Great, I would be happy to meet at FOSDEM or discuss
these topic later at some event.

> > Slides in English which I want to update/correct for FOSDEM
> >
> >  
> > https://talks.openalt.cz/media/openalt-2024/submissions/3XTMDF/resources/
> >openalt24_linux_for_rt-reduced_FbZPuS0.pdf
>
> looks good. If you want additional history points, I have some at
> 	https://files.speakerdeck.com/presentations/0620b5b3a00b42fc91fba6cc4092d2
>78/KR_2024_PREEMPT_RT_over_the_years.pdf Slide 11 - 21.

Thanks much for the input

> However you have most of the pieces so.
>

Best wishes,

                Pavel
-- 
                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://control.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    social:     https://social.kernel.org/ppisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    RISC-V education: https://comparch.edu.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home

