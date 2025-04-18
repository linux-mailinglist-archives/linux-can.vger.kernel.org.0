Return-Path: <linux-can+bounces-3441-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A49B3A93F05
	for <lists+linux-can@lfdr.de>; Fri, 18 Apr 2025 22:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C39189AD67
	for <lists+linux-can@lfdr.de>; Fri, 18 Apr 2025 20:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293BA23E344;
	Fri, 18 Apr 2025 20:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Fb85cM3j";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Tad8pO2L"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CE422F145;
	Fri, 18 Apr 2025 20:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.160
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745008991; cv=pass; b=oPi39bjD4A1ALYo5wPQqEDZKqLqjq7h6XpclYP4AcjrD+k82uiistWSP4Mv7ZcSeIAXMMXmd5P00MtbXAxSjN3JZAbeF4vCsDpREb+3vlmK7bNuuesvkYWSWvDzoO57TXBfxT75dhcwIJB0GuuiSSsxRxXqfTcL3FZq2UDl6qtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745008991; c=relaxed/simple;
	bh=zMVQa/cI5OMQ2ufGb9D4LDVAwKw4bXIim0l5a+67D+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NxnsUua2obeWBDSnNL5b0g4h20xoBrNaYJkMmaCF6rE9/i1cb4k2JQllrL9l4KU0NKrdyHHo1yuItMS2fatwAc4rh4tUZeh5VJyjchkQXlBF3eosfuBNT/cAqeZsZZEWx0F0nHndbdC8oXwMIGQeRe6VotTqflTf5BVG1MqaIpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Fb85cM3j; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Tad8pO2L; arc=pass smtp.client-ip=81.169.146.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1745007544; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=sdZu+RD0qhVTU+AxL1BNLPbseLm++XuZaXaX94N1x++wrRkzuICaUoFTdzu2jFTm9L
    t9hIrj+plLO/p0kf3Z0G+iFyCjvQwmkWWJvtV+Liswgg88R6pOmfX/7IZdbZID2gMEq9
    KHXnFAc1ShkgeqHcWk1FeAztuQAgFG7TykjjWvkcubpXXA1+hB1qogB6/40Q6W85WrOG
    OIPDaG/0tS+DcFd/dzwIbBbiAGdErL7rxH3qGIZPqnKm1lvJobaTHKeebpW3LCOeGeIe
    gSkWV4eBs/YreMy7ntYROvMSKzyi08KyHGWaCeIvBIHD/mGUf9yOJVo+SSR0XvyIRgBQ
    eRow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1745007544;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=W1HtbmF37/wvTd29yHqTJ9MZFtAFNYgtwB3Y4/qybxI=;
    b=d4wk8V6A+gbbpehejAFDE9PpfP6cBZDPDB6hBnCnU4aRI5Sew29eJWnjLYZ0hmrdMO
    ptz5c5L5pHXleUgfUJUB3kGmMy6ipAn7CPjM6/aEyECMvuF4oJw1Ej0vK06Hl4Hg9Yit
    gDRuC/rbRKNihE6oLe0ULO2j1rgFRuUzuKJE229blOvcVznbL1R8if23ZzF6B9uoMAzA
    nJ/eXYwXZ5Cm2MOGM3mqoPqOpXOJcGUXcggmuYpPYG55J2mL5iaGpoT8qHOWUxBQ7wU+
    pHpWFdR6SrTtuCK+nTgY5oU6ZjAo1M8nr5LQyENFchvzBXF8Vxv87dCdNMh6a0JzDvKi
    Hxdw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1745007544;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=W1HtbmF37/wvTd29yHqTJ9MZFtAFNYgtwB3Y4/qybxI=;
    b=Fb85cM3jk9cu+duU2JboOpC7kkYTMeTQI1D8R3ZwdtHZ/3mIzV9TTW98kLWGrqAZjE
    9kwoKxdWY735CqL9LYNlE98jEfBzeEpiiyWvJGBQSiv4g4F2EJdVu9u2+TwGIudwNvuZ
    JsGSY7YHt2wLQGrdMb9Vov0S8VEFvyZMa7DtaOteLi4D7aAlX6pgdmdUpBTA0OvZOrFQ
    gvN9xIUg7UZYwFqi2WNsLrp+mTThfb/PrkQ9YM4HBV75Bv/jGHiSdWMnZf4I+5b8U76V
    Khdnt+mQAHAq+pghOxFol4NL/n7dyy+4KyEH/V+xDuovwv5HhbnhtgZ5vBFBt770GmHU
    g34w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1745007544;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=W1HtbmF37/wvTd29yHqTJ9MZFtAFNYgtwB3Y4/qybxI=;
    b=Tad8pO2LJm6JNqxS5L586IuKcJ7L3FUvbHVZwGhsFwv50JAaK8lPYIyqZ3yBmpNeHX
    6YbB0nEFk7YkOwRWDoAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrJozOHkwxtwKntYe0tiGXErB1gqPcLcuhJte3JoL7vYU9DBc"
Received: from [IPV6:2a01:a380:9c0:a0dc:5c2a:492a:c692:baa4]
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K2a3e513IKJ3pQu
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 18 Apr 2025 22:19:03 +0200 (CEST)
Message-ID: <f21186eb-d03e-42b7-9117-7d886ad55666@hartkopp.net>
Date: Fri, 18 Apr 2025 22:18:56 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CAN latency measuremet on AMD/Xilinx Zynq with PREEMP_RT - added
 threaded NAPI configuration
To: Pavel Pisa <pisa@fel.cvut.cz>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-rt-users@vger.kernel.org,
 Carsten Emde <c.emde@osadl.org>, linux-can@vger.kernel.org,
 Jan Altenberg <Jan.Altenberg@osadl.org>, Pavel Hronek <hronepa1@fel.cvut.cz>
References: <202501281629.27139.pisa@fel.cvut.cz>
 <202503281304.47808.pisa@fel.cvut.cz> <20250417081254.EUqrBagT@linutronix.de>
 <202504181212.22699.pisa@fel.cvut.cz>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <202504181212.22699.pisa@fel.cvut.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Pavel,

On 18.04.25 12:12, Pavel Pisa wrote:
> Hello Sebastian,
> 
> On Thursday 17 of April 2025 10:12:54 Sebastian Andrzej Siewior wrote:
>> The IRQ thread should be limited to one CPU which is the same where the
>> IRQ it itself is set to. I don't think that this done the NAPI thread
>> automatically so it is probably free floating in the system.
> 
> you are right, I have added
> 
>    taskset -p 1 $pid
> 
> in can-latester-automation/device-scripts/set-can-threaded.sh
> 
> the effect can be seen after some days on the midnight
> build and testing records.
> 
> Our system is small and simple and all CAN IRQs are
> mapped to CPU0 now. But I have looked if I can find some
> easy way how to find affinity of the IRQ thread from
> /sys/class/net/canX and have not succeed a much.
> There is queues/rx-0/rps_cpus but it is probably another
> level.
> 
> There is easy way to find matching kernel driver task
> and copy affinity to NAPI task. But I am not sure how
> much naming match is guaranteed if some interfaces aliasing
> etc. is in effect. I see next names now
> 
>    [irq/48-can2]
>    [irq/49-can3]
>    [irq/50-can4]
>    [irq/51-can5]
> 
> and
> 
>   [napi/can2-19]
>   [napi/can3-20]
>   [napi/can4-21]
>   [napi/can5-22]
> 
> One question to Oliver, in which thread/callaback context
> is running kernel CAN gateway? I think that it does not
> use separate task. Because with threaded NAPI it seems
> that simple user space "gateway" (task to forward all
> messages from one interface to another) has more stable
> results than routing of messages directly in kernel.

The can_gw get's the CAN frames via NET_RX softirq like all other (CAN) 
network protocols.

The original reason for can_gw was, that an existing user space gateway 
was not able to cope with high CAN traffic loads due to scheduling and 
buffer overflows. That was with a standard kernel and might be different 
with PREEMPT_RT now.

Best regards,
Oliver

> 
> Some side note, project implementing FlexCAN controller
> emulation for QEMU (initial target sabrelite iMX6)
> is moving forward. And as Bernhard Beschow submitted
> iMX8 platform support into mainline QEMU, the FlexCAN
> emulation support can be extended to it in future as well.
> If somebody is interested then we can somehow join
> resources. Foe example if some funding is found
> I would discuse if the studnet working on the thesis
> project finalized by submitting iMX6 support would
> be willing to continue on iMX8 or other targets support.
> 
> Best wishes,
> 
>                  Pavel Pisa
>      phone:      +420 603531357
>      e-mail:     pisa@cmp.felk.cvut.cz
>      Department of Control Engineering FEE CVUT
>      Karlovo namesti 13, 121 35, Prague 2
>      university: http://control.fel.cvut.cz/
>      personal:   http://cmp.felk.cvut.cz/~pisa
>      social:     https://social.kernel.org/ppisa
>      projects:   https://www.openhub.net/accounts/ppisa
>      CAN related:http://canbus.pages.fel.cvut.cz/
>      RISC-V education: https://comparch.edu.cvut.cz/
>      Open Technologies Research Education and Exchange Services
>      https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home


