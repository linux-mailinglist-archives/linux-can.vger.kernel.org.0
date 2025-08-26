Return-Path: <linux-can+bounces-4375-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E27AEB35758
	for <lists+linux-can@lfdr.de>; Tue, 26 Aug 2025 10:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8813A1B67153
	for <lists+linux-can@lfdr.de>; Tue, 26 Aug 2025 08:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49002FCC02;
	Tue, 26 Aug 2025 08:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFxPlCPZ"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2BC2F6593;
	Tue, 26 Aug 2025 08:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756197500; cv=none; b=R1d/i3ixVkIs+xPF3AlTMtzFWB77p39bxY7Ue2em04br2I2bsW9Tl0khD/yzJJtxpQ81EtMW5vm2uRXT/rYNOeEwppUhrxnXaV+dDIK9orotQHwIEAP+0+b7HQDeKJcSaQdpeEvtXWtDqweUBrbbWW2ah2ayl45ihYNUSQbt/Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756197500; c=relaxed/simple;
	bh=E65/gjqtNsdMp9tNjbPt1mcwuhd3WPTzK62QUEL0sL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BYLOI6svr41I14LIMSud799ug5/2kSsptQexb6vNISB2yuCdM9q5Y+C6isk/JIu+sbPPOF0skjG6TQBWlS1PoTZ9O4W0EutImp7q5NeGwpZ22/lnfg7iqWV4lLvMctZaAuJ5dU0ccDM1bwPSgZghiVOkxdWK4wjjD/9PBLUAv6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFxPlCPZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DC9C4CEF4;
	Tue, 26 Aug 2025 08:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756197500;
	bh=E65/gjqtNsdMp9tNjbPt1mcwuhd3WPTzK62QUEL0sL4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fFxPlCPZCBL8NyDQ6c+osTqPaASXkGti3theq+1zUicxEalwXgy9dSCbawiwWWZGz
	 NvTC2pu0Y7ShYxosjynL7Ne6Qe3c3VYvBnvlVn2ZyUV0s90mJVi7Xsouc/7k+5wkIW
	 GjwpxzrHdrRHpofFJS1dbzjLr+cCdy6BZYWyGJm+3O2c8srIdHbijgHRZ6B9RJaT1F
	 8++RS832UQwwnmGZMWTgAxeq2wIGXV5EJ5BxBGtJT/1J7gFkdd1QFlCbJxCMhG/50G
	 /4iMVHhQ/47/a4Tv7aS/WnUwTG+qy8ixZcyEnVlQg1wjRP68R17MoSlUSq4rDWRmjH
	 jPVmXmN0HHQ7g==
Message-ID: <6b6ba240-e13a-4e99-ae76-500a7b530238@kernel.org>
Date: Tue, 26 Aug 2025 17:38:17 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] can: m_can: use us_to_ktime() in m_can_set_coalesce()
To: Markus Elfring <Markus.Elfring@web.de>, Xichao Zhao
 <zhao.xichao@vivo.com>, linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Chandrasekar Ramakrishnan <rcsekar@samsung.com>
References: <20250826025131.112900-1-zhao.xichao@vivo.com>
 <735d62ba-51b5-4dc2-a8e4-0701ffb01f9a@web.de>
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
In-Reply-To: <735d62ba-51b5-4dc2-a8e4-0701ffb01f9a@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/08/2025 at 14:43, Markus Elfring wrote:
>> Replace the if-else statement with a ternary operator to
>> set cdev->irq_timer_wait. Use us_to_ktime() instead of
>> ns_to_ktime() with NSEC_PER_USEC multiplication. Simplify
> …
> 
> You should occasionally use more than 57 characters in text lines
> of such a change description.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.17-rc3#n638
> 
> 
> Will an enumeration become helpful here?
> 
> 
> …> +++ b/drivers/net/can/m_can/m_can.c
>> @@ -2211,13 +2211,9 @@ static int m_can_set_coalesce(struct net_device *dev,
> …> +	cdev->irq_timer_wait = us_to_ktime(cdev->rx_coalesce_usecs_irq ?
>> +					   cdev->rx_coalesce_usecs_irq :
>> +					   cdev->tx_coalesce_usecs_irq);
> …
> 
> I am curious how coding style preferences will evolve further also for
> the usage of the conditional operator at such a place.

The preferred style in the kernel is actually to *not* use the conditional
operator in such case and to use an explicit if/else. I appreciate that the
conditional operator is more succinct, but squeezing the code is not a goal. The
priority is readability, and the if/else does a better job at this.

And I this is not my personnal opinion. For example, see this message from Greg:

  https://lore.kernel.org/all/20250311150130.7a875e63@bahia/

TLDR; the v1 was better than the v2. Speaking of the format, the only nitpick I
might have is that after your change, the code fits in one line without
exceeding the 80th column:

	if (cdev->rx_coalesce_usecs_irq)
		cdev->irq_timer_wait = us_to_ktime(cdev->rx_coalesce_usecs_irq);
 	else
		cdev->irq_timer_wait = us_to_ktime(cdev->tx_coalesce_usecs_irq);


Yours sincerely,
Vincent Mailhol


