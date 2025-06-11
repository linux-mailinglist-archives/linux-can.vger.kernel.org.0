Return-Path: <linux-can+bounces-3806-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A60FAD53F9
	for <lists+linux-can@lfdr.de>; Wed, 11 Jun 2025 13:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33C9E3AD235
	for <lists+linux-can@lfdr.de>; Wed, 11 Jun 2025 11:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90862749CF;
	Wed, 11 Jun 2025 11:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="NUaUeKq0"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-72.smtpout.orange.fr [193.252.22.72])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC9A25BEEB
	for <linux-can@vger.kernel.org>; Wed, 11 Jun 2025 11:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749641384; cv=none; b=O9Vyi9FhDfSqH5A3M/4MN8GqLubcaXjuKJEGyBQs/EXpXCeMzReLgzesdB9cFjUFTzJSGrh6E6mZE0O5Z42ecAoMvMmWXhQjnINEFf+oPAwqKKiBOz6KZy+n9+uaz1/Rr2zobuvSBFjpTyM8uIdXqUQrF1OQ3p08E+oCEkkOTqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749641384; c=relaxed/simple;
	bh=noXnaxvovc2FXna1it6isbBNaDeUSF4moo+dwFr0YSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NG/u6BVFVYS1+iA+ufc/iSP/9jAyPQ4ggN81OaEnG7NMXloF14YB7up5aLFaITQ6ROLvj1S4+QoSzTzaBCGxBQFsxCbDtC0Dv9R+rkRUIBnrcpYnQ+GQg2ksO1eLV+mVhrASSFf+4NDrT++sdBpx66YhIuGpLBgJNxD5m4XetVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=NUaUeKq0; arc=none smtp.client-ip=193.252.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id PJe9uh7fVtcjXPJeBuFFGN; Wed, 11 Jun 2025 13:29:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1749641377;
	bh=7GZ9jQCw6ZulAUrcs5dpTi+u+XVZF9V9UQBrDi0siOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=NUaUeKq0UDAnkQyHOM3lcdAJ/LaDONt3DReh9Q+IjS7Lv62sZ6i5DwCEvKpI74kTe
	 Zgw1I1tVMtGUZ6twBYePkhhTCYVO5v1i/QJ7S+13kazEjxUxsYzu98qoZwPoHtxAWa
	 zgzjO687j5JrGJ9yqR0aHDOqVVz7XGl6IBf+vqQ7H4RbvtFfsj0owP96xAWGi5eWFX
	 Rlmvrp3Ib1rp3WrtdVuUEI1Tsk8r7T3CRq6+W0OFmOH3UQUBosWnBH+IwBh6zo4dWg
	 rAsGJUSlPRPOqa1uNnrnZDb3XbAJMCJV4S8iNf3zXq5e6GAMctxuTJGrPWPbU3vv7U
	 MBbvXCQIS0eaw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 11 Jun 2025 13:29:37 +0200
X-ME-IP: 124.33.176.97
Message-ID: <e2ae158d-eb43-4883-b4c3-90fd23d1ee1f@wanadoo.fr>
Date: Wed, 11 Jun 2025 20:29:32 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] can: netlink: replace tabulation by space in
 assignment
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
References: <20250527195625.65252-1-socketcan@hartkopp.net>
 <20250527195625.65252-2-socketcan@hartkopp.net>
 <20250528-quirky-ultra-hawk-37000f-mkl@pengutronix.de>
 <77c5a904-8b2c-4a78-890d-2777ddefe250@wanadoo.fr>
 <20250528-bronze-penguin-of-joviality-0ce1a8-mkl@pengutronix.de>
 <20250611-just-degu-of-virtuosity-933b17-mkl@pengutronix.de>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20250611-just-degu-of-virtuosity-933b17-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/06/2025 at 16:10, Marc Kleine-Budde wrote:
> On 28.05.2025 18:12:53, Marc Kleine-Budde wrote:
>>>> The patches 2...5 look good to me. If Oliver adds his S-o-b, I can take
>>>> them for linux-can-next.
>>>
>>> If you prefer, I already submitted those in the past in a dedicated series with
>>> a proper cover letter:
>>>
>>> https://lore.kernel.org/linux-can/20241112165118.586613-7-mailhol.vincent@wanadoo.fr/
>>
>> Even better.
> 
> These are in net-next now \o/
> 
>>> Because I got zero answers, I split it even further. This is why only one patch
>>> got merge in for 6.15. I was planning to resend those clean-up patches anyway,
>>> but if you are OK to take them directly from my previous series, go ahead.
>>> Nothing has changed for these since November, except from the first patch with
>>> was merged separately.
>>
>> I've adjusted the cover letter, as patch 1 is already mainline, and
>> taken the rest of the series to can-next/testing. Note, once -rc1 is
>> out, I'll rebase this branch.
> 
> I've rebased the remaining can-xl patches to current net-next/main and
> pushed it to my b4/can-xl branch:
> 
> | https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/?h=b4/can-xl

Yes, I saw the pull request.

I actually started to tidy up my previous work. So nice timing.

For the next step, I plan to split the CAN-XL series in two:

  1. One more preparation series that will do all the netlink.c refactor

  2. The actual stuff that will modify the uapi and add the CAN XL netlink
     interface

For point 1., it will be patch 6 to 11 and patch 13 of the original RFC:


https://lore.kernel.org/linux-can/20241110155902.72807-16-mailhol.vincent@wanadoo.fr/

Actually, I already have it ready in my local tree, I just need to double check
before sending.

I intend to have the preparation series 1. merged first before sending series 2.

On a different topic, I know have my kernel.org account. I do not know what is
the most convenient for you, but I could also create my own branch on
git.kernel.org. Or, if gitolite allows it, maybe you can give me write access to
your b4/can-xl branch? (I didn't check yet what gitolite offers in term of
access control…)


Yours sincerely,
Vincent Mailhol


