Return-Path: <linux-can+bounces-5872-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCCDCC9B22
	for <lists+linux-can@lfdr.de>; Wed, 17 Dec 2025 23:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5DA5300A219
	for <lists+linux-can@lfdr.de>; Wed, 17 Dec 2025 22:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EFE309DCF;
	Wed, 17 Dec 2025 22:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMP32+eZ"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB65287276;
	Wed, 17 Dec 2025 22:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766010250; cv=none; b=KG+bDyFy9M7n8mFuVwgsX2oxjZL/bqa4u68k6za4U8CUjYjYXZ7WZzGtdxyw0hqEY5HZCHLOMuZV+WUu/Ri3Jxr4hzM9zOdzvqtDHrzLQKTflUWhoHcDpWglNY/i6wGbmouRKVHtoxcWxa1EtjAzbKZqfJ+sv5uHzqkFO8bJirg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766010250; c=relaxed/simple;
	bh=YMfyKeiy39gUsXNs7ANnTUQBxnWcdk/taMmERHGVvP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qaID0wRROIzQTY8r+Pa7eCFQ3VM+N6s/qtkllDeVARWr00zwqZAkJuvJNLvGzsMW2Vq0phr1i7OS94oH+Y146q2fkLbF9Ql5yKDFrVzhR4WD+Jo8du+EVHBaB1GzojaW8TYDc0UZtN0qrdJNPVpOmwUP1D8vBPgMl+E8ez1H6xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMP32+eZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026ADC4CEF5;
	Wed, 17 Dec 2025 22:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766010249;
	bh=YMfyKeiy39gUsXNs7ANnTUQBxnWcdk/taMmERHGVvP0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KMP32+eZdRMdbUMOZMzlPuO/tnDKLotKccYCnG5NtVscoDaiUBgH6uPiEPsgRdDOJ
	 M2B661/dOiOkA92j1WY1caqvm4iPcBVvQ9wq/71ISRun6trfYbLAN9FyIaLbEYev7x
	 L0GENAZCoS7hU+de0bwqj0NNL44C3Ao25uVrHnl5RALS1ExtCWT8c/AQBJXOyb6yY1
	 qD/SjQa3MaSCEVJF0YGoGdQ5xtOIi0Pp0DkGayGOJuxScR1isybRInmzHfvMQsxzqU
	 YK6YfICCwE3f/ksXQOmhW66pAT+lmsmjkH40aozBVlU3bbemms2ztoz+favHjjhEBi
	 2f/Z9X5yI7iVA==
Message-ID: <f188b330-8bf5-4509-a2fc-712c20160167@kernel.org>
Date: Wed, 17 Dec 2025 23:24:05 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH can] can: fix build dependency
To: Marc Kleine-Budde <mkl@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20251217-can-fix-dependency-v1-1-fd2d4f2a2bf5@pengutronix.de>
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
In-Reply-To: <20251217-can-fix-dependency-v1-1-fd2d4f2a2bf5@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/12/2025 at 10:45, Marc Kleine-Budde wrote:
> Arnd Bergmann's patch [1] fixed the build dependency problem introduced by
> bugfix commit cb2dc6d2869a ("can: Kconfig: select CAN driver infrastructure
> by default"). This ended up as commit 6abd4577bccc ("can: fix build
> dependency"), but I broke Arnd's fix by removing a dependency that we
> thought was superfluous.

And my comment subverted you into doing so. I think half of the blame goes to me
here.

> [1] https://lore.kernel.org/all/20251204100015.1033688-1-arnd@kernel.org/
> 
> Meanwhile the problem was also found by intel's kernel test robot,
> complaining about undefined symbols:
> 
> | ERROR: modpost: "m_can_class_unregister" [drivers/net/can/m_can/m_can_platform.ko] undefined!
> | ERROR: modpost: "m_can_class_free_dev" [drivers/net/can/m_can/m_can_platform.ko] undefined!
> | ERROR: modpost: "m_can_class_allocate_dev" [drivers/net/can/m_can/m_can_platform.ko] undefined!
> | ERROR: modpost: "m_can_class_get_clocks" [drivers/net/can/m_can/m_can_platform.ko] undefined!
> | ERROR: modpost: "m_can_class_register" [drivers/net/can/m_can/m_can_platform.ko] undefined!
> 
> To fix this problem, add the missing dependency again.
> 
> Cc: Vincent Mailhol <mailhol@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202512132253.vO9WFDJK-lkp@intel.com/
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Closes: https://lore.kernel.org/all/7427949a-ea7d-4854-9fe4-e01db7d878c7@app.fastmail.com/
> Fixes: 6abd4577bccc ("can: fix build dependency")
> Fixes: cb2dc6d2869a ("can: Kconfig: select CAN driver infrastructure by default")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Acked-by: Vincent Mailhol <mailhol@kernel.org>


Yours sincerely,
Vincent Mailhol


