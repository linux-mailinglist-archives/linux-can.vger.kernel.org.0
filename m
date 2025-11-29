Return-Path: <linux-can+bounces-5782-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B00C94149
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 16:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5C8C13432CD
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 15:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9851EF091;
	Sat, 29 Nov 2025 15:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0mPbLZA"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA941A9FAC;
	Sat, 29 Nov 2025 15:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764430714; cv=none; b=GUAJGkgFcF5LCP3cdVyF0WLQhSKKKqHOLbnxgyNW9vVRpdhqHAVcWpUuXnhIxWZeEFP9TjtlfrQlZcRfJ/IBa1oqP3tAEqIUfDgwTtEYQrbmvWdX2X20dkf4xYQ7mfuBPw9ix+rVOh9T6pucwkIrdZ6HK8ta6sfZb2WH2n6Y9aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764430714; c=relaxed/simple;
	bh=yOVZrjSgdGUXJCSv0UyYa5kyrQktCFZ8kgydJPtl8do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p3zPyH0Gqgj72UfLPtV5n5Ei/enzEWAlYpWEGBNDy2WuTZ/Ji8v2/P5dR3IE1J8H20YrdvxfooREp1j1qm0vXm/+A9HID9BAI6dxcUtnqm+Kbh3k2C8FsbOyex0EL28KddozN7J1rqfcH5c2RphoGwhmE+YK4cbGYHazpN5KTVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0mPbLZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1C8C4CEF7;
	Sat, 29 Nov 2025 15:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764430714;
	bh=yOVZrjSgdGUXJCSv0UyYa5kyrQktCFZ8kgydJPtl8do=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i0mPbLZAD1sKD8pOlEubg8cyIpry7d/U5YeqLDf4ErE0wPA3kwr/pMp5qD7SJtev4
	 SVZu0Xm44IQncCAhYb+64IV1RZq2BqNbJGDlF2pBSfg8k9WHkojyXvI49KgPNq8XjF
	 O5LRov9XOPRy90290bTAOODie2em3cL6wsr3LImvSANgz9LpurUfanyiNbagFCsbNn
	 aU4nNGSeinBOOX5/em5MvQVcs45ZhAjWHoWrpiYXCNDzwTeh6JAewW54sHiKJ0iMrb
	 aX6otAwMc7nSHETPfBPtFB5DUISZ9hqpxDFJjz3eYWh3+DSbdVZie8HnVVsgOqqg/7
	 +5FrujzQkxlng==
Message-ID: <e2ab2f04-35fc-462f-b4d0-a8429b765111@kernel.org>
Date: Sat, 29 Nov 2025 16:38:25 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] iplink_can: add CAN XL support
To: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>, David Ahern <dsahern@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
References: <20251129-canxl-netlink-v1-0-96f2c0c54011@kernel.org>
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
In-Reply-To: <20251129-canxl-netlink-v1-0-96f2c0c54011@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/11/2025 at 16:29, Vincent Mailhol wrote:
> Support for CAN XL was added to the kernel in [1]. This series is the
> iproute2 counterpart.
> 
> Patches #1 to #3 are clean-ups. They refactor iplink_can's
> print_usage()'s function.
> 
> Patches #4 to #7 add the CAN XL interface to iplink_can.
> 
> [1] commit 113aa9101a91 ("Merge patch series "can: netlink: add CAN XL support")
> Link: https://git.kernel.org/netdev/net-next/c/113aa9101a91
> 
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>

And just after sending, I realized that I forgot to add the "iproute2-next"
prefix in the patch subjects.

Well, I will wait for the comments first and resent on Monday with the correct tag.


Yours sincerely,
Vincent Mailhol


