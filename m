Return-Path: <linux-can+bounces-3272-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B26C9A749A3
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 13:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64C653A5BC3
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 12:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F1821ADC5;
	Fri, 28 Mar 2025 12:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="BcIL1Ctx"
X-Original-To: linux-can@vger.kernel.org
Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0DE17548;
	Fri, 28 Mar 2025 12:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.32.210.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743164076; cv=none; b=prbOrD3X4Ut51lIaFMc9xBwqD9PhpAMUeWiqg1rd9MwXSkAiKcvpW81jyPIcimlHMAhtLlPt3yr0v4zH6jHbGlXnaR1DDq/x1OXOzIPlWOxyomjzXrGSlqFbKkiBXX5vNlr4wBYhSSO59eUJ/LjNohY8SVmKu8dr5T8T5GHcuvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743164076; c=relaxed/simple;
	bh=Ucm13fCiSshLuUcnGV0HCmY/7MtsmmITV5GU3sbapkI=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:MIME-Version:
	 Content-Type:Message-Id; b=N3NLtCRhknpUBVVCQ9iijj6F4FH2MyUmx+IDHcYH1jLiFXOl9juo4vQK7d3zlPauZHNtU7i1MoN/9k7jHbfBvTFt91pv7jVw7PfIgwHptOfQYRNKArvy+HXoYo+9a90Thsv61Pn4aB30A+QaqsBKy4ZEsLARslFwfCyaqc8fogI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz; spf=pass smtp.mailfrom=fel.cvut.cz; dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b=BcIL1Ctx; arc=none smtp.client-ip=147.32.210.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fel.cvut.cz
Received: from localhost (unknown [192.168.200.27])
	by smtpx.fel.cvut.cz (Postfix) with ESMTP id E67721122F;
	Fri, 28 Mar 2025 13:04:23 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Authentication-Results: cerokez-250.feld.cvut.cz (amavis);
 dkim=pass (2048-bit key) header.d=fel.cvut.cz
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id 8PUps5n5czOi; Fri, 28 Mar 2025 13:04:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1743163462;
	bh=aK4PJilP2fnKMENOtf1zQeOEHBfkpG/UwnGNj5y7j30=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
	b=BcIL1CtxW42FmrNkRzGHVUCRT4bmuz0U+P5LTUNL7ufLYlWK4E/It+AEXqYfuQnBD
	 WrXDK1/PUfvvoj4/St/fMVBUvy78BeBsSulY4Fs/Vk72Wne05IYvk5tRGJmvZfVAMc
	 DGTaspT+xUb2H2dl8g4/spC7GjiPkx/9/bVMs7qdUJM+C29bZKHa7hbNmVsXhEAecl
	 cAXaSvdfLl31lUb2DVP5ao/ZAUxpnhbEuqIhPH/pSoQvCqUIsxRgLPBK3i9WwsOH/t
	 +TG1xRwy4oyKewo8QTm/QGAUbmb0zvCA7OGeysRJT3KtG/ponGhd2SAc6Fgo2MIMur
	 lYqghpuaR+9tw==
Received: from baree.pikron.com (static-84-242-78-234.bb.vodafone.cz [84.242.78.234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pisa)
	by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 8E8E91131B;
	Fri, 28 Mar 2025 13:04:21 +0100 (CET)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Marc Kleine-Budde" <mkl@pengutronix.de>
Subject: CAN latency measuremet on AMD/Xilinx Zynq with PREEMP_RT - added threaded NAPI configuration
Date: Fri, 28 Mar 2025 13:04:47 +0100
User-Agent: KMail/1.9.10
Cc: linux-rt-users@vger.kernel.org,
 Carsten Emde <c.emde@osadl.org>,
 linux-can@vger.kernel.org,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Jan Altenberg <Jan.Altenberg@osadl.org>,
 Pavel Hronek <hronepa1@fel.cvut.cz>
References: <202501281629.27139.pisa@fel.cvut.cz> <20250129101709.XQuo8Jle@linutronix.de> <202501291304.15901.pisa@fel.cvut.cz>
In-Reply-To: <202501291304.15901.pisa@fel.cvut.cz>
X-KMail-QuotePrefix: > 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_fBp5nAI/1+kFsSO"
Message-Id: <202503281304.47808.pisa@fel.cvut.cz>

--Boundary-00=_fBp5nAI/1+kFsSO
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Marc and Sebastian,

thanks for suggestions and discussion at FOSDEM 2025.

We are slow, sorry, I have teaching, we have worked
on new NuttX boot loader, pysmCoder and RTEMS, etc..

But there is some partial progress for our Linux
CAN/CAN FD latency benchmarking

  https://canbus.pages.fel.cvut.cz/#can-bus-channels-mutual-latency-testing

On Saturday 01 of February 2025 14:56:49 you wrote:
> On 27.01.2025 00:27:02, Pavel Pisa wrote:
> > May it be that there is even some problem in our RT kernel
> > configuration. But I have not found which option could
> > be problematic. I would send config files if you want to look
> > at them.

Thanks to Sebastian for review which did not reveal
something suspicious.

> Try switching the CAN interfaces to threaded NAPI:
>
>     echo 1 | sudo tee /sys/class/net/canX/threaded
>
> and configure the priorities of the can interface NAPI thread. You might
> also switch the Ethernet interfaces to threaded NAPI and give them a
> different/lower prio.

Pavel Hronek has found some time on his Erasmus stay in Italy
and added Threaded NAPI into options of our CAN testing matrix.

The scripts to set paramaters for CAN interfaces on the device
under the test (DUT) are located in the directory device-scripts
of our latency automation repository
 
  https://gitlab.fel.cvut.cz/canbus/can-benchmark/can-latester-automation/-/tree/master/device-scripts

The scripts are attached as well for easier review.

The set-can-threaded.sh sets

  echo $1 > /sys/class/net/canX/threaded

and I have added increase of the napi/canX-Y
treads priority to it on this Monday (March 24)

  chrt -f --pid 80 $pid

This setup logs are selected by option "Threaded NAPI"

The classical boost of CAN interfaces IRQ threads
is under switch "RT priority set", which locates
irq/[0-9]+-can[0-9] and sets

  chrt -f --pid 90 $pid

The final state of the system in the threaded config show

  ps Hxa --sort rtprio -o pid,policy,rtprio,state,tname,time,command

   16 FF       1 S ?        00:00:13 [ktimers/0]
   17 FF       1 I ?        00:00:01 [rcu_preempt]
   18 FF       1 S ?        00:00:00 [rcub/0]
   20 FF       1 S ?        00:00:02 [rcuc/0]
   23 FF       1 S ?        00:00:04 [irq_work/0]
   26 FF       1 S ?        00:00:01 [irq_work/1]
   28 FF       1 S ?        00:00:02 [rcuc/1]
   29 FF       1 S ?        00:00:05 [ktimers/1]
   48 FF      50 S ?        00:00:00 [watchdogd]
   63 FF      50 S ?        00:00:00 [irq/29-f8003000.dmac]
   ...
   72 FF      50 S ?        00:01:19 [irq/40-eth%d]
   75 FF      50 S ?        00:00:00 [irq/41-e0002000.usb]
   78 FF      50 S ?        00:00:00 [irq/44-f8007100.adc]
   80 FF      50 S ?        00:00:00 [irq/42-mmc0]
   81 FF      50 S ?        00:00:00 [irq/42-s-mmc0]
   84 FF      50 S ?        00:00:00 [irq/47-f8007000.devcfg]
  410 FF      50 S ?        00:00:00 [irq/26-xuartps]
 1907 FF      80 S ?        00:00:00 [napi/can2-19]
 1908 FF      80 S ?        00:00:13 [napi/can3-20]
 1909 FF      80 S ?        00:00:09 [napi/can4-21]
 1910 FF      80 S ?        00:00:08 [napi/can5-22]
  355 FF      90 S ?        00:00:12 [irq/48-can2]
  364 FF      90 S ?        00:00:20 [irq/49-can3]
  369 FF      90 S ?        00:00:14 [irq/50-can4]
  376 FF      90 S ?        00:00:14 [irq/51-can5]
   22 FF      99 S ?        00:00:00 [migration/0]
   27 FF      99 S ?        00:00:00 [migration/1]

There is recorded significant change when the respective
NAPI threads priority has been increased and policy
changed from default TS to FF. We are starting to get
maximal times under one millisecond in the most cases

CAN FD messages, flood, system under network load,
CAN gateway (retransmit all messages to the secondary
intreface on DUT) kernel

  https://canbus.pages.fel.cvut.cz/can-latester/inspect.html?kernel=rt&load=1&prio=1&flood=1&fd=1&thrd=1&kern=1

For standard CAN messages

  https://canbus.pages.fel.cvut.cz/can-latester/inspect.html?kernel=rt&load=1&prio=1&flood=1&fd=0&thrd=1&kern=1

You can switch on and of other options to see how the latency
profiles vary. Suspicious is the series from run

  run-250326-05****-hist+6.14.0-rc1-rt1-gecdc0d0bb42d+***.json

Which should be after priority boost but maximal latency
are high still for more combinations. But it could be some
interference. Our daily mainline and RT kernel data starts from
April 2023 (Archives available under Data range), so we will
be more certain what is the result of the current setup
after some months.

> MY coworker Lucas mentioned another option would be to stay with
> traditional soft IRQ based NAPI but reduce the NAPI weight for the
> "unimportant" interfaces to 1.

OK, we will keep that on our list of the experiments to try.
I hope that our tests could help to enhance CAN users situation
on GNU/Linux when they use it for control. The result can
be even manual how to setup priorities and interfaces for
reliable operation. We already provide toolong to obtain
some confidence in the given setup because all our tooling
can be run by everybody on their setup.

May it be we can catch something which can be enhanced in the
mainline kernel code as well...

For sure, deeper ftrace based analysis is on our list as well,
but it could be art of some studnet thesis or some joint debug
session with somebody from you. I probably do not find time
to study that deeper without guidance soon.

> > RTEMS behavior on same HW experiences maximal latency about 60 usec
> > even with networking and other load, sources, documentation, reports
> >
> >  
> > https://canbus.pages.fel.cvut.cz/#cancan-fd-subsystem-and-drivers-for-rtems
> >
> > The CiA article is already available to public and referenced from our
> > page same as the Michal Lenc's Master's thesis.

Some update to above mentioned project of our complete new CAN/CAN FD stack
for RTEMS. It has been mainlined in January and documentation propagated
to the online site in March

  https://ftp.rtems.org/pub/rtems/people/amar/docs1/bsp-howto/can.html

Best wishes,

                Pavel

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

--Boundary-00=_fBp5nAI/1+kFsSO
Content-Type: text/x-shellscript;
  charset="iso-8859-15";
  name="set-can-threaded.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="set-can-threaded.sh"

#!/bin/bash

NAPI_PRIO=80

if (( $# != 1 )); then
  echo "Need 1 argument (value 0 or 1)" >&2
  exit 1
fi

for ifc in can2 can3 can4 can5 ; do
  echo $1 > /sys/class/net/$ifc/threaded
done

if [ $1 -eq 1 ] ; then
  PIDS=$(ps -e | grep -E napi/can[0-9]+-[0-9] | tr -s ' ' | cut -d ' ' -f2)
  for pid in $PIDS ; do
    echo "Setting RT priority $NAPI_PRIO for $pid"
    chrt -f --pid $NAPI_PRIO $pid
  done
fi

--Boundary-00=_fBp5nAI/1+kFsSO
Content-Type: text/x-shellscript;
  charset="iso-8859-15";
  name="set-irq-prio.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="set-irq-prio.sh"

#!/bin/bash
if [ ! -z $1 ] ; then
PRIO=$1
else
PRIO=90
fi

PIDS=$(ps -e | grep -E irq/[0-9]+-can[0-9] | tr -s ' ' | cut -d ' ' -f2)
for pid in $PIDS ; do
	echo "Setting RT priority $PRIO for $pid"
	chrt -f --pid $PRIO $pid
done

--Boundary-00=_fBp5nAI/1+kFsSO--

