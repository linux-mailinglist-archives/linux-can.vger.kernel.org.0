Return-Path: <linux-can+bounces-1959-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 032DF9C41CC
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2024 16:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2681F21A73
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2024 15:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F6253389;
	Mon, 11 Nov 2024 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="RO7jMzeF"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E764649625
	for <linux-can@vger.kernel.org>; Mon, 11 Nov 2024 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731338807; cv=none; b=K19WRwFAHPJ05y2masElqMubK+0isCveUhOCb91n0s82wIW5Bp9HFAQkaoQouLHDJGc5x62qdPzDg3rBO3PW3eXbdCvDyccwyKrk0rv7j8PMQ3yHeYE8LK/rO8ZkF6zb1TT+yxyWZxhmiLLoe4CXf34xOV5hxN//zuazTlUWHns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731338807; c=relaxed/simple;
	bh=KE4+cU7xFz80BfsC3uxE5D4+XUOTIz8HXcNQDwDw15M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WhOHNyt/mLimr4r+cmTaaF3h5yA8zpI869W34Vht5oMZmHNtpmvyunyjSwGPLWUNuZYWQOv8aReTGXDhrTEqVT1P/s5HBckK6ZE/pqV5Ac+xrx/vmsv7PuKZ8/3cEtryO5vE2fyhH1BmnBf1dQK+TcW8HgPAe1fxcGbqOeeYLnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=RO7jMzeF; arc=none smtp.client-ip=80.12.242.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id AWAetllZv85qlAWAgtCcoT; Mon, 11 Nov 2024 16:17:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731338264;
	bh=f4BksedM3PWtmxb1yM8a6HDNQrP4g8oVYbiRiwYa3Rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=RO7jMzeFI3IK0fW3zB2g5TxDtlbiQTMAxPDfSL68TraGhzfDNikAhDAGH3ebdDTuD
	 hkK48vYcDVBN/QQMGkHOYx1nIhByzheoLOKlLpFqeR8hnGAjryP/+WvV+avkp7RBMb
	 ft1xzIk6pX2rYdoSR9SfUoWybiNrggiSxekvPHr5IsE2GJ1iklLb8YSrVUTvTEW6PI
	 ClTNsLX2v1xUWRvKOU1Zi6dFvWURwsmpz5yoQ26DsjD5KzigantGN6u1xigQ7cumS/
	 tTTJ7Yl9eeib9NHCmuSWMWi+jVgHDa+iIh5Txx5O9rCXAseGUCq18Wk4LJeblJKAnD
	 JeixGYy9fQGkw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 11 Nov 2024 16:17:44 +0100
X-ME-IP: 124.33.176.97
Message-ID: <a9d8eb65-c88d-4bc9-b0c2-c0e0799ea5bd@wanadoo.fr>
Date: Tue, 12 Nov 2024 00:17:39 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/14] can: netlink: add CAN XL
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Robert Nawrath <mbro1689@gmail.com>
References: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
 <ea52eb8f-c59d-445a-bf4d-26f2772f7426@hartkopp.net>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
In-Reply-To: <ea52eb8f-c59d-445a-bf4d-26f2772f7426@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/2024 at 23:08, Oliver Hartkopp wrote:
> Hello Vincent!
>
> Very impressive! Thanks for the effort.
> Together with the example in the dummyxl driver it should become quite 
> easy to integrate the netlink API into my XCANB driver hack for testing.
>
> Picking up the dummyxl driver I wonder if it would make sense to 
> mainline this driver probably as can_nltest driver?!?
> Of course this driver should be disabled or combined with some kernel 
> testing Kconfig stuff. But is it a great testing tool.

Thanks. I do not recall similar things in the netdev subtree. I wonder 
what would be the idiomatic way to introduce such netlink test driver.

@Marc, any thoughts on this?

> From what I can see with the bitrate and tdc configurations the 
> extension for CAN XL is ok.
>
> If you take a look at this manual
>
> https://github.com/linux-can/can-doc/blob/master/x_can/xcan_user_manual_v350.pdf 
>
>
> on page 268/304 you will find the PWM configuration which consists of 
> three values with 6 bits each. I assume this to be similar in all CAN 
> XL controllers.
>
> The PWM feature switches the physical layer for a CAN XL transceiver 
> in the CAN XL data phase. This is a weird feature to do some PWM on 
> the controllers' TX data pin to be able to switch the physical layer 
> while maintaining the CAN transceiver package with 8 pin layout.
>
> Additionally to this PWM configuration register, the PWM CAN XL 
> transceiver switch feature has to be enabled similar to the way we 
> enable 'fd on' or 'xl on' today.
>
> You can see this bit called XLTR in the Operating Mode section on page 
> 269/304 and 270/304 .
>
> E.g. that might be named 'xltrx [on|off]' (default off)
Thanks for the information and the link to the documentation. I will 
also try to see what ISO 11898-1:2024 has to say on the topic. Just be 
patient on this and do not worry if I give no signal for a couple weeks.

Vincent Mailhol


