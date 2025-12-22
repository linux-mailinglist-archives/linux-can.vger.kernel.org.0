Return-Path: <linux-can+bounces-5904-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A07CD6EDD
	for <lists+linux-can@lfdr.de>; Mon, 22 Dec 2025 20:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 204553014DAE
	for <lists+linux-can@lfdr.de>; Mon, 22 Dec 2025 19:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588DF3346B2;
	Mon, 22 Dec 2025 19:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmtMi1JM"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31890307AD5;
	Mon, 22 Dec 2025 19:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766430455; cv=none; b=eUldV+52m5RJFr4FU9sLlyqCDbKcYTrtzcGMb9Bp7IdxM+RAcYqjv/oHlnB3Yxz8CDDXmmlGWRfs2MTCN7ndqOgeMw64kZpHmaK3nILSEB/YK53gpPQpTkOPRyvgj752UbqWCqqc/bPxpDz6Dl6vcO4D5/D6hZO9VaI1S5Kd1Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766430455; c=relaxed/simple;
	bh=Vu5vALg1M/2KAok+4KJ9fPm8f3i+N1+0aUv7FYLOG0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eOpsTWyVEh6JJKHqL0f+Cg5KSFA0Ge4zdjNWFQzQ9l9OKG22ymtrjsU0V6ekR/EXn/MhA2zaHaDL1GHJzBUeAnv2kPz12mnla62iVFBxadvdswpsjd6nSGmWGkcMVKUGa7dNGa7ytmIpu4H2ukB6F4Jbxc7gQispsYLTKGUbUVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmtMi1JM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016FEC4CEF1;
	Mon, 22 Dec 2025 19:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766430454;
	bh=Vu5vALg1M/2KAok+4KJ9fPm8f3i+N1+0aUv7FYLOG0Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bmtMi1JMIoqwneGyznNn7XPruiVrIPBDSH8tJPtv4ot1D05UlqY7S01zBevockmWy
	 pZuoR7+AxylGiqEoJsafdscV7fGXqmZ2efujfNSdXW4vhLJdrE1wPZf9K/Qq1bbT0b
	 Do5EbGfAFgfN6yfNfZ0WqKu5lN03xQtQ2IJyljooJQxJoLLxb/llky5eatHSBJJNQ+
	 GzftpjMETrXEKPHLbzAdzscznzOXU/xbZGDrxARPPymn381TOc1M0Y55X7lddiOprV
	 vGLLaij45iuNVueSh7we4/AitBTKHM586xmhTkZQEfN9vQRhsLxSMXy0F0UOzTCJ2f
	 MbY/jeHRddGNg==
Message-ID: <f76805be-c4fb-4846-9fc9-56af859da537@kernel.org>
Date: Mon, 22 Dec 2025 20:07:30 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: etas_es58x: fix memory leak in es58x_open()
To: Szymon Wilczek <swilczek.lx@gmail.com>, mkl@pengutronix.de
Cc: arunachalam.santhanam@in.bosch.com, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+e8cb6691a7cf68256cb8@syzkaller.appspotmail.com
References: <20251222154208.22117-1-swilczek.lx@gmail.com>
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
In-Reply-To: <20251222154208.22117-1-swilczek.lx@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Szymon,

Thanks for the patch.

On 22/12/2025 at 16:42, Szymon Wilczek wrote:
> When es58x_alloc_rx_urbs() fails partway through allocating RX URBs
> (e.g., if usb_submit_urb() fails at iteration i), the function returns
> an error but leaves any previously allocated and anchored URBs leaked.
> 
> The issue is that es58x_open() returns directly on es58x_alloc_rx_urbs()
> failure instead of jumping to the free_urbs label, which would call
> es58x_free_urbs() to clean up any anchored URBs.

The intended logic is that if es58x_alloc_rx_urbs() only partially
succeeds (i.e. submits at least one URB), then you are still able
to continue.

To keep the intended logic, the final:

  return ret;

of es58x_alloc_rx_urbs() should be changed to:

  return 0;

> Fix this by changing 'return ret' to 'goto free_urbs' to ensure proper
> cleanup of all allocated URBs on failure.

If you want to treat a partial allocation of the URBs as a
non-recoverable error, then fine, but this fix is not elegant.

In that case, please do the clean-up in es58x_alloc_rx_urbs() and
update the error message accordingly.

> Fixes: 8537257874e9 ("can: etas_es58x: add core support for ETAS ES58X CAN USB interfaces")
> Reported-by: syzbot+e8cb6691a7cf68256cb8@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e8cb6691a7cf68256cb8
> Signed-off-by: Szymon Wilczek <swilczek.lx@gmail.com>
> ---
>  drivers/net/can/usb/etas_es58x/es58x_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
> index f799233c2b72..d92c37f277d5 100644
> --- a/drivers/net/can/usb/etas_es58x/es58x_core.c
> +++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
> @@ -1784,7 +1784,7 @@ static int es58x_open(struct net_device *netdev)
>  	if (!es58x_dev->opened_channel_cnt) {
>  		ret = es58x_alloc_rx_urbs(es58x_dev);
>  		if (ret)
> -			return ret;
> +			goto free_urbs;
>  
>  		ret = es58x_set_realtime_diff_ns(es58x_dev);
>  		if (ret)

Yours sincerely,
Vincent Mailhol

