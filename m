Return-Path: <linux-can+bounces-944-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3D2923B6A
	for <lists+linux-can@lfdr.de>; Tue,  2 Jul 2024 12:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96F961F22775
	for <lists+linux-can@lfdr.de>; Tue,  2 Jul 2024 10:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF9782D7F;
	Tue,  2 Jul 2024 10:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="YN8Aq/Fz"
X-Original-To: linux-can@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00CA17BBB;
	Tue,  2 Jul 2024 10:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719916222; cv=none; b=o/rWr186LgrEkrTT9E3jiBWFGPS8b8KzV2t4ZWNw9xsp1uH3LRWLY+zVbOxlpWwYZRoY5UwZzSwmvv0ZKwNRoVID8w5snM7slWdEr19bQ5GLOCoFRTnLrvlRP8LvcsAr/h65Hlbnt9tB/DaC/l/ZHM49NlSQjdl0wJ+m2tzfLqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719916222; c=relaxed/simple;
	bh=1B+3GT30ZinzSkjOdYycyY46lYkUK/OOoaS5AOUtjso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QX6Euwz2gy98HWoZaYMh8QInyHYWldaSke4eJinP70qwCGDr591mcIfUxk4OqJeeIy6crrjr+TNzQxU7khlzoIsWFVn7eSBQloHhCxczwfMubYGDNpQk21kmLQj7ZnYULz/GRnzJiM3dflF6ZD0KXR3azLmRAUnfnVkyrBjfKC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=YN8Aq/Fz; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=0qf92CZPlH8uBrIdQYOCZH5zn+O7ufKU3N+Njh8N6FI=;
	t=1719916219; x=1720348219; b=YN8Aq/Fz/3/68OHbPf+/Su+eX0aoDB9+l08kXea9Zte/ctC
	09sHBDuHGIwThUfW7EsKADke7wy7v3ZhJa4MVTEnl7cwDPQx6q89NQx047kaQAKwc12f7KT+HQ9JU
	s3BTXlpC0A4Q7TEUozJs5/McZpps0l7UUv0j6mLbIQvP3tzhH4CHu36mxrwuj+vqF+W8xIlKlrcHM
	jfdlaMRvnU0oOhF8+C90cIvv5jeJmw3qswm5n5draI/JWiEzPHouhB2w0iTYl9AkqiP31llRy2Mmx
	ScqpERsJiWKvY2niAS213K8jJy7kHUa+ETd+zsDZquZMEw4lK0p5PSP0FoOXL6UQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sOam1-000827-BY; Tue, 02 Jul 2024 12:30:09 +0200
Message-ID: <c7bca2f0-1006-45c1-a13d-6d8f19357533@leemhuis.info>
Date: Tue, 2 Jul 2024 12:30:08 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel hang caused by commit "can: m_can: Start/Cancel polling
 timer together with interrupts"
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Tony Lindgren <tony@atomide.com>, Judith Mendez <jm@ti.com>,
 linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@ew.tq-group.com
References: <e72771c75988a2460fa8b557b0e2d32e6894f75d.camel@ew.tq-group.com>
 <c93ab2cc-d8e9-41ba-9f56-51acb331ae38@leemhuis.info>
 <h7lmtmqizoipzlazl36fz37w2f5ow7nbghvya3wu766la5hx6d@3jdesa3ltmuz>
 <08aabeaf-6a81-48a9-9c5b-82a69b071faa@leemhuis.info>
 <734a29a87613b9052fc795d56a30690833e4aba9.camel@ew.tq-group.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <734a29a87613b9052fc795d56a30690833e4aba9.camel@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1719916219;976f19fd;
X-HE-SMSGID: 1sOam1-000827-BY

On 02.07.24 12:03, Matthias Schiffer wrote:
> On Tue, 2024-07-02 at 07:37 +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 01.07.24 16:34, Markus Schneider-Pargmann wrote:
>>> On Mon, Jul 01, 2024 at 02:12:55PM GMT, Linux regression tracking (Thorsten Leemhuis) wrote:
>
>>> @Matthias: Thanks for debugging and sorry for breaking it. If you have a
>>> fix for this, let me know. I have a lot of work right now, so I am not
>>> sure when I will have a proper fix ready. But it is on my todo list.
>>
>> Thx. This made me wonder: is "revert the culprit to resolve this quickly
>> and reapply it later together with a fix" something that we should
>> consider if a proper fix takes some time? Or is this not worth it in
>> this case or extremely hard? Or would it cause a regression on it's own
>> for users of 6.9?
> 
> I think on 6.9 a revert is not easily possible (without reverting several other commits adding new
> features), but it should be considered for 6.6.
>> I don't think further regressions are possible by reverting, as on
6.6 the timer is only used for
> platforms without an m_can IRQ, and on these platforms the current behavior is "the kernel
> reproducibly deadlocks in atomic context", so there is not much room for making it worse.

Often Greg does not revert commits in a stable branches when they cause
the same problem in mainline. But I suspect in this case it is something
different. But I guess he would prefer to hear "please revert
887407b622f8e4 ("can: m_can: Start/Cancel polling timer together with
interrupts")" coming from Markus, hence:

Markus, if you agree that a revert from 6.6.y might be best, could you
simply ask for a revert in a reply to this mail while CCing Greg and the
stable list? tia!

Ciao, Thorsten

> Like Markus, I have writing a proper fix for this on my TODO list, but I'm not sure when I can get
> to it - hopefully next week.
> 
> Best regards,
> Matthias
> 
> 
> 
>>
>>>> On 18.06.24 18:12, Matthias Schiffer wrote:
>>>>> Hi Markus,
>>>>>
>>>>> we've found that recent kernels hang on the TI AM62x SoC (where no m_can interrupt is available and
>>>>> thus the polling timer is used), always a few seconds after the CAN interfaces are set up.
>>>>>
>>>>> I have bisected the issue to commit a163c5761019b ("can: m_can: Start/Cancel polling timer together
>>>>> with interrupts"). Both master and 6.6 stable (which received a backport of the commit) are
>>>>> affected. On 6.6 the commit is easy to revert, but on master a lot has happened on top of that
>>>>> change.
>>>>>
>>>>> As far as I can tell, the reason is that hrtimer_cancel() tries to cancel the timer synchronously,
>>>>> which will deadlock when called from the hrtimer callback itself (hrtimer_callback -> m_can_isr ->
>>>>> m_can_disable_all_interrupts -> hrtimer_cancel).
>>>>>
>>>>> I can try to come up with a fix, but I think you are much more familiar with the driver code. Please
>>>>> let me know if you need any more information.
>>>>>
>>>>> Best regards,
>>>>> Matthias
>>>>>
>>>>>
>>>
>>>
> 

