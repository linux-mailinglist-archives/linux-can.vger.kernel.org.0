Return-Path: <linux-can+bounces-942-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E0C91EE61
	for <lists+linux-can@lfdr.de>; Tue,  2 Jul 2024 07:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B6132838F0
	for <lists+linux-can@lfdr.de>; Tue,  2 Jul 2024 05:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B27543AC1;
	Tue,  2 Jul 2024 05:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="N7bKrAr2"
X-Original-To: linux-can@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36513D548;
	Tue,  2 Jul 2024 05:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719898641; cv=none; b=jdFplU/ECBwfugav6HansAePBdmXpfNZIBZLp1yAuT3n1TbrJaU+wXg5GKSmVnD+hO+aE7ckGx7xp7VZMRFc/q41LCMRnXhcpsIQkH0ys4UcV5EJvlJq22J+1IvT69cRh4cFBBRbXXfSFWipzCmh26SQdGjcZJjiFs7rFTX1S5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719898641; c=relaxed/simple;
	bh=16pWVQDlV3oMxIYcAJWP63TGtGj5GzcFV1gJpcFFfU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bqzGakV/Mupa1j1FwbvYIggT7deS7wjpEHP/F3QPRIx++kNfCOZDopnfvlhlhBlUC1g2B+WERTgYzEIMB9npFa/e6qwpfmB1z3eibqKwmCFnRuC8q84PsG9ht58pKGohty3C3xfsh1qvitSxwy7TigR2Ra/cAG/lE01+hQR4VzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=N7bKrAr2; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=DS77JC9w8wcnStim2W/xitvraXik/3HNJqyNkDayJog=;
	t=1719898639; x=1720330639; b=N7bKrAr2jZFhWWJg3MaE1vvqSt9XZbCWHIbSiBIIOWWwuTe
	rNtukRTtpO115hOHSdFI5XF9LlkZbl7e2i0/JV+s4fp6U7NHJcuISmRbYMGMofYmIG8U+2DGNpkY6
	+v77NiPXsblmvgp7DvBRBNQL+SBHFxYKxzhY+LuJy24w/PUANPzOjtGFenImkMKUzCWPzXOVBbdqz
	4R2AcCyKP3/O/ojTLnIc2B7Z77Bvs8Zbm4QVbMz3ENdz74DxbcIyQNvALcTlIE4kzZutXYWT1Gpia
	Nv4qw5VAsKLurRRZ6OZToFyEJf8p3oaLrxZP8xyNJ3RjjITaBqsppX1AfhMMeqgw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sOWCX-0005Ro-VY; Tue, 02 Jul 2024 07:37:14 +0200
Message-ID: <08aabeaf-6a81-48a9-9c5b-82a69b071faa@leemhuis.info>
Date: Tue, 2 Jul 2024 07:37:13 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel hang caused by commit "can: m_can: Start/Cancel polling
 timer together with interrupts"
To: Markus Schneider-Pargmann <msp@baylibre.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
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
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <h7lmtmqizoipzlazl36fz37w2f5ow7nbghvya3wu766la5hx6d@3jdesa3ltmuz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1719898639;2ce6bdd2;
X-HE-SMSGID: 1sOWCX-0005Ro-VY

On 01.07.24 16:34, Markus Schneider-Pargmann wrote:
> On Mon, Jul 01, 2024 at 02:12:55PM GMT, Linux regression tracking (Thorsten Leemhuis) wrote:
>> [CCing the regression list, as it should be in the loop for regressions:
>> https://docs.kernel.org/admin-guide/reporting-regressions.html]
>>
>> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
>> for once, to make this easily accessible to everyone.
>>
>> Hmm, looks like there was not even a single reply to below regression
>> report. But also seens Markus hasn't posted anything archived on Lore
>> since about three weeks now, so he might be on vacation.
>>
>> Marc, do you might have an idea what's wrong with the culprit? Or do we
>> expected Markus to be back in action soon?
> 
> Great, ping here.

Thx for replying!

> @Matthias: Thanks for debugging and sorry for breaking it. If you have a
> fix for this, let me know. I have a lot of work right now, so I am not
> sure when I will have a proper fix ready. But it is on my todo list.

Thx. This made me wonder: is "revert the culprit to resolve this quickly
and reapply it later together with a fix" something that we should
consider if a proper fix takes some time? Or is this not worth it in
this case or extremely hard? Or would it cause a regression on it's own
for users of 6.9?

Ciao, Thorsten

>> On 18.06.24 18:12, Matthias Schiffer wrote:
>>> Hi Markus,
>>>
>>> we've found that recent kernels hang on the TI AM62x SoC (where no m_can interrupt is available and
>>> thus the polling timer is used), always a few seconds after the CAN interfaces are set up.
>>>
>>> I have bisected the issue to commit a163c5761019b ("can: m_can: Start/Cancel polling timer together
>>> with interrupts"). Both master and 6.6 stable (which received a backport of the commit) are
>>> affected. On 6.6 the commit is easy to revert, but on master a lot has happened on top of that
>>> change.
>>>
>>> As far as I can tell, the reason is that hrtimer_cancel() tries to cancel the timer synchronously,
>>> which will deadlock when called from the hrtimer callback itself (hrtimer_callback -> m_can_isr ->
>>> m_can_disable_all_interrupts -> hrtimer_cancel).
>>>
>>> I can try to come up with a fix, but I think you are much more familiar with the driver code. Please
>>> let me know if you need any more information.
>>>
>>> Best regards,
>>> Matthias
>>>
>>>
> 
> 

