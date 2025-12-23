Return-Path: <linux-can+bounces-5923-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 329ACCDA721
	for <lists+linux-can@lfdr.de>; Tue, 23 Dec 2025 21:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C10C93013E89
	for <lists+linux-can@lfdr.de>; Tue, 23 Dec 2025 20:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFC028C5AA;
	Tue, 23 Dec 2025 20:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8hd7jkE"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DC3274FEF;
	Tue, 23 Dec 2025 20:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766520939; cv=none; b=GYuvWhe0CZBA7J/0cGf/sjiNBcj4R1Oghg1DZjR6x08a50cp+QF5FV8Q5Q19nqxhN6AijhsXxD9oym+5GGk13IJdlznkYbWppzU1PcqS10BBVBSWYWhP1nqO48jmMoEfU78If/7dRDbnlkdrGXwR6GPYotl1DDZfYpMLUtN62OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766520939; c=relaxed/simple;
	bh=3PFlhs5YYRajRpWAJuAsrqB7+2uVEOOje6GiLyxybMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FyESisrQgqCpWRuIIM8N2qVQWrXMmUUygcMqW9O2F129Kk9sB8GsSPoTTjqr8Ezr2Ia8kDRTmXwl0P3heqn6nLwyCSDNoBRB2eBrynQEweJ+CYxWmmBvkGANi933NGTxKFj7l0LB7nWKzvqxThOdqmloHnkKQliZdXlXEiD2aN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8hd7jkE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6945AC116B1;
	Tue, 23 Dec 2025 20:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766520938;
	bh=3PFlhs5YYRajRpWAJuAsrqB7+2uVEOOje6GiLyxybMs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u8hd7jkEHg/187zQaWV39zHqiEpR4B+DYBhxAH7fStmi+Gy3yUNLVSYuvcIFT5A2H
	 lKZgdgCRvvAXy0FefrrTWmpqkJazjoNGTZns+qAJLQ8wNHr8eXrYjvMa9K79qjIDnY
	 F3kCYWaDhzuMDn+wnEZEk2qFEl8O+b5mDd2VPeNe7Um0qJUkvkCqm2QEygnnmWB1he
	 s3LoVdYrCIYK6syERPwf2ci6mWlUCewwyx+gsO4oTMgNjEgwtyAQ8Gyhq4IMdN+lNc
	 /kSB964yxgLwQu72ghGH8TPhtTa2tYL2RtWakRuL6CGo4Dp0gmkCZs+1iu9lhZZvLI
	 VGN+d9QsDpFGg==
Message-ID: <3ebbe8cb-6041-4aac-a789-de04e612d2a8@kernel.org>
Date: Tue, 23 Dec 2025 21:15:34 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] can: etas_es58x: allow partial RX URB allocation to
 succeed
To: Szymon Wilczek <swilczek.lx@gmail.com>, mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+e8cb6691a7cf68256cb8@syzkaller.appspotmail.com
References: <20251222154208.22117-1-swilczek.lx@gmail.com>
 <20251223011732.39361-1-swilczek.lx@gmail.com>
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
In-Reply-To: <20251223011732.39361-1-swilczek.lx@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/12/2025 at 02:17, Szymon Wilczek wrote:
> When es58x_alloc_rx_urbs() fails to allocate the requested number of
> URBs but succeeds in allocating some, it returns an error code.
> This causes es58x_open() to return early, skipping the cleanup label
> 'free_urbs', which leads to the anchored URBs being leaked.
> 
> As pointed out by maintainer Vincent Mailhol, the driver is designed
> to handle partial URB allocation gracefully. Therefore, partial
> allocation should not be treated as a fatal error.
> 
> Modify es58x_alloc_rx_urbs() to return 0 if at least one URB has been
> allocated, restoring the intended behavior and preventing the leak
> in es58x_open().
> 
> Fixes: 8537257874e9 ("can: etas_es58x: add core support for ETAS ES58X CAN USB interfaces")
> Reported-by: syzbot+e8cb6691a7cf68256cb8@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e8cb6691a7cf68256cb8
> Signed-off-by: Szymon Wilczek <swilczek.lx@gmail.com>

Thanks for the fix!

Reviewed-by: Vincent Mailhol <mailhol@kernel.org>


Yours sincerely,
Vincent Mailhol


