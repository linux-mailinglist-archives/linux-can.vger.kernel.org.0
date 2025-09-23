Return-Path: <linux-can+bounces-4904-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05357B95460
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 11:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65C9A1903D39
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 09:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B78B320A26;
	Tue, 23 Sep 2025 09:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7V9y+Ic"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24169320A10;
	Tue, 23 Sep 2025 09:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620204; cv=none; b=CQ5XRsiTc15rNma8ha83j4MAz1P5FJt+pJ2oZiYt6ENHMnL1jaMiFspsvzc0G5OgTT4onNV5S4+nfkSfPQczJGeZdhneYpx1y39NqDKwJagMrkjc9BL6YDk8hhg0Qf4eSEfqNVWJ3jZd63RoZO+qn7MvaH0LIQLfWBjeJs7agak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620204; c=relaxed/simple;
	bh=e8XU199UYL7i9jjXvBMXYaDGxB2cTsLVSLpPL9wMVoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=idNPRk8MGREC+/1YZAWUpj/67BHcs0SU2soD/t2FLNMXO4QTfBj0utymnUmPCc+8p6DEP1P3fNP+D2pck12E1Yt5QG5PKMrTL1ArLUNHwtZ3L8do2RJY7q9ImXcgws8H5BPqfKZI5foWfdP0aHAiEoslgigH0b3r3K1bAFjnYKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7V9y+Ic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D552EC116B1;
	Tue, 23 Sep 2025 09:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758620204;
	bh=e8XU199UYL7i9jjXvBMXYaDGxB2cTsLVSLpPL9wMVoU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t7V9y+Icc/EBZ1dYb92mcrp9FObovYjl0ahkmEPqliHtpRY06Z7qEH4Krrv+yYOKV
	 Nq/2kyx4QRTHszTBHLHL34DSjkHAxJmVI6ld0h2p5IFPaYvZXlqwFud3r5yIZU2MOo
	 aERhnmAZ/SmV8hLm2WRrEq3omolQOXcl2f6Jb1E9j7rf4+2iiMS8YerCCPcTPyxFKK
	 jpYThqqPP7FoigeqWY+MRfZYTdoNZ9Co7xAT7bifCQO+8cyklEPI1KDACRQT3YSFuq
	 ltwmpngqZeNmg1JMBrJiKa39fQoYxzLqqCe6wsY66Xr13Hd847B9jcDm8rnm9IxoQZ
	 ZuAmFA2c3bVPQ==
Message-ID: <062cee74-2223-4814-bc23-647a2291aa45@kernel.org>
Date: Tue, 23 Sep 2025 18:36:41 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/20] can: netlink: refactor
 CAN_CTRLMODE_TDC_{AUTO,MANUAL} flag reset logic
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
 =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250910-canxl-netlink-prep-v2-0-f128d4083721@kernel.org>
 <20250910-canxl-netlink-prep-v2-7-f128d4083721@kernel.org>
 <f9854748-78c1-4852-a610-e839e9c91df3@kernel.org>
 <20250922-amber-spider-of-control-90be7c-mkl@pengutronix.de>
 <9cfdcf56-2f47-4cfd-9fd6-2c6fa4476752@kernel.org>
 <20250922-rational-mastodon-of-sufficiency-6b49f1-mkl@pengutronix.de>
 <2528d3d7-2807-4ef6-8269-5e20de57cc41@kernel.org>
 <20250923-bald-indigo-coati-2c3613-mkl@pengutronix.de>
Content-Language: en-US
From: Vincent Mailhol <mailhol@kernel.org>
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20250923-bald-indigo-coati-2c3613-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/09/2025 at 18:08, Marc Kleine-Budde wrote:
> On 23.09.2025 16:04:41, Vincent Mailhol wrote:
>>>> I will resend my two series in the next few days as soon as the MTU fix appears
>>>> in net-next.
>>>
>>> I don't know how much time we have between the merge of net into
>>> net-next and the acceptance of the last PR by the network team for the
>>> next merge window. We will see.
>>
>> With the pull request to net/main being delayed, I decided to finally remove the
>> patch which was in conflict and send the rest:
>>
>> https://lore.kernel.org/linux-can/20250923-can-fix-mtu-v3-0-581bde113f52@kernel.org/
>>
>> and:
>>
>> https://lore.kernel.org/linux-can/20250923-canxl-netlink-prep-v4-0-e720d28f66fe@kernel.org/
>>
>> These are my last two series for this development window (to be applied in order).
>>
>> Also, sorry for the noise when sending those twice.
> 
> I've merged both series to linux-can-next. Thanks. b4 was a bit
> confused, it took the canxl-netlink-prep when asked to merge the
> can-fix-mtu series and it added the prerequisite patches when merging
> canxl-netlink-prep on top of can-fix-mtu.

Yeh, I also had a lot of trouble on my side as you could see. This is the first
time I deal with such a complex series, at least, I am happy it is now merge.

> My next net-next PR is prepared as linux-can-next-for-6.18-20250923. Can
> you check if I took the correct patches?

I just checked, everything is there and my WIP CAN XL patches rebase nicely on
top. All good, thanks!


Yours sincerely,
Vincent Mailhol


