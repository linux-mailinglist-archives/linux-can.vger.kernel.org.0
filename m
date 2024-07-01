Return-Path: <linux-can+bounces-917-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC7591DED2
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 14:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1457EB22ACE
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 12:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66509129E93;
	Mon,  1 Jul 2024 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="H7bMJYQo"
X-Original-To: linux-can@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E574664C6;
	Mon,  1 Jul 2024 12:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719835988; cv=none; b=lz4VdTPcaUOHjHWFxAbJ7+ACCCDjglwxGw701swKfsqJ0yCy4ZjhYXJmvhD1LDISjYRQRqEr3/cbnES6r+GxeZ3TSfGj/rluie9+eFX2HMu73tPvB5VtZ4ODr7GVj3NmmGO0Cvo7wHq6rMEHYDRuAntudRR4TTPGbYS3DOC1hXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719835988; c=relaxed/simple;
	bh=Y4zVJ4xfJdxCJO2uOyRE9CjN3rspmO3rce9CIk7rvxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kyIwajOgI6uwLdtCBT9hnPvSahDdRqu7+16RTxTSKvbjAqOTGxj1P5Ptl4upEKd0E7WqkLa8XRnF+V8u875RSD4aff0BkbYB9OD83TfdyNwO9Eb4qWuaLRvksTmahM/hctakLIDXYfnFSmVrMWXYHB1Lj6JbkC28HPdqBvDLUXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=H7bMJYQo; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=s0SQSY2/qlwdSn2Ne62QkwvKmp6lPNA13idmIDBlXko=;
	t=1719835986; x=1720267986; b=H7bMJYQo+acxT/MFT40LuTU9RZ6ksOuW+VKrMjaNuW6/6mo
	Q40czHwmGgT2gyCWjzbMLmErFgMvEXCIEHJgwRBH1QcMK7bHjBL23uMK0ThetwfZewmR/ef5AAK+f
	9vk1Obx0ZJsDrrp43YZ3SzkC1oX0olIqVWRx/i21q2MFkfjK76sL3/OoaIAysHi3N3wRfzAMrr0Rv
	UoRiK65dHEVBj3RO1lWk13G7bK7wNw9XynQSKJDrxp+Qsn0x8zu+WpxZ6YYE47WvNNL+tZToavrBL
	JDHBwmkFw0f90JaBWgVbshS+w+2nDTSZNpS/A+PS1Pgdtf14ZJ6ZzI8V0LX5qbZw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sOFtw-000089-AO; Mon, 01 Jul 2024 14:12:56 +0200
Message-ID: <c93ab2cc-d8e9-41ba-9f56-51acb331ae38@leemhuis.info>
Date: Mon, 1 Jul 2024 14:12:55 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Kernel hang caused by commit "can: m_can: Start/Cancel polling
 timer together with interrupts"
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Tony Lindgren <tony@atomide.com>, Judith Mendez <jm@ti.com>,
 linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <e72771c75988a2460fa8b557b0e2d32e6894f75d.camel@ew.tq-group.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <e72771c75988a2460fa8b557b0e2d32e6894f75d.camel@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1719835986;baec6e98;
X-HE-SMSGID: 1sOFtw-000089-AO

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
for once, to make this easily accessible to everyone.

Hmm, looks like there was not even a single reply to below regression
report. But also seens Markus hasn't posted anything archived on Lore
since about three weeks now, so he might be on vacation.

Marc, do you might have an idea what's wrong with the culprit? Or do we
expected Markus to be back in action soon?

Ciao, Thorsten

On 18.06.24 18:12, Matthias Schiffer wrote:
> Hi Markus,
> 
> we've found that recent kernels hang on the TI AM62x SoC (where no m_can interrupt is available and
> thus the polling timer is used), always a few seconds after the CAN interfaces are set up.
> 
> I have bisected the issue to commit a163c5761019b ("can: m_can: Start/Cancel polling timer together
> with interrupts"). Both master and 6.6 stable (which received a backport of the commit) are
> affected. On 6.6 the commit is easy to revert, but on master a lot has happened on top of that
> change.
> 
> As far as I can tell, the reason is that hrtimer_cancel() tries to cancel the timer synchronously,
> which will deadlock when called from the hrtimer callback itself (hrtimer_callback -> m_can_isr ->
> m_can_disable_all_interrupts -> hrtimer_cancel).
> 
> I can try to come up with a fix, but I think you are much more familiar with the driver code. Please
> let me know if you need any more information.
> 
> Best regards,
> Matthias
> 
> 

