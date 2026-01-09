Return-Path: <linux-can+bounces-6055-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 55019D07A6A
	for <lists+linux-can@lfdr.de>; Fri, 09 Jan 2026 08:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C83943058BE3
	for <lists+linux-can@lfdr.de>; Fri,  9 Jan 2026 07:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D852E8B78;
	Fri,  9 Jan 2026 07:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGa+e455"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64D723EAAF;
	Fri,  9 Jan 2026 07:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767945013; cv=none; b=CFKUetu+oyVyfgPNP6KBfb0OY98vUxYtol7y0XAOId7iAJlPCNJYhGETaDpO6Gt3p4KCsxf91fdJ6HDLbL6epuMmLMCP2UchOycs6VkXrVbAtsp3E6LPlBR1xoVn7T5JNLIx9KP/9IcP2DYuHKJ+LvvJithnu7M1rl2vVSCAhKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767945013; c=relaxed/simple;
	bh=Rj3x4q25lUQmxFEdT80Amznetj/Vl1GUcn5k3pHOL9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CzMTBIfobYry/9hKDhpWBXrUkIBRmTk9zCQ6sN8hXQ5nFq8aw6DqVxT7s5Zcz2aG9r+3v/rM9Y4QVlE6PP1aeNz50xt6ILSfiQMa1pd0IyzHP5FCJWdz0tQAShjmQ2d2yAfVOyFhlX4jJKlR/R5nf/1AXhVUxwyfKV75/eerkfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGa+e455; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441F6C4CEF1;
	Fri,  9 Jan 2026 07:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767945013;
	bh=Rj3x4q25lUQmxFEdT80Amznetj/Vl1GUcn5k3pHOL9k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uGa+e455nMoPgw/5qUmUq//pWQDLJutyOkQq+jBqCQ8NVrx6I5oQpBfb0t/iNMeAr
	 CYsLtTEXfY+VATwVKge+UNoeE6rOY2XdmaG4J5vuHoC6h6Vg1KctFXsimr5XJa3Lpn
	 YR8n41u8UC8PqK/8X6AgRwTRriSWBmi3WbvbBS0HpOawcheI7KyEjHXcvzgPIzVWBG
	 /kemSQjsIUR8/Osok2wEI09nDpQ95bU+ktF1gnX+aApIzrxjtmgR97jOGUnsE3rVhd
	 7wxQtr5WwEz7tXZAbhUgft7jZbWa8ySVIULTXZvTiso2cvCdQJ1X7qGZObkflGWMH0
	 kfg56yiHHS1+A==
Message-ID: <df1feb99-2996-4a84-8e04-2a850c05b602@kernel.org>
Date: Fri, 9 Jan 2026 08:50:03 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] can: kvaser_usb: kvaser_usb_leaf: Fix some info-leaks
 to USB devices
To: Jerry Wu <w.7erry@foxmail.com>, mkl@pengutronix.de
Cc: mailhol@kernel.org, extja@kvaser.com, eeodqql09@gmail.com,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jimmy Assarsson <extja@kvaser.com>
References: <tencent_B88CC7093F21BB59E7B4298209F208E02708@qq.com>
From: Vincent Mailhol <mailhol@kernel.org>
Content-Language: en-US
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <tencent_B88CC7093F21BB59E7B4298209F208E02708@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+CC: Jimmy

On 09/01/2026 at 02:36, Jerry Wu wrote:
> Uninitialized Kernel memory can leak to USB devices.

Please explain in your description which field(s) is(are) uninitialized
in cmd.

(or attach a report in which you can witness the information leak).

> Fix this by using kzalloc() instead of kmalloc().
> 
> Fixes: 7259124eac7d ("can: kvaser_usb: Split driver into kvaser_usb_core.c and kvaser_usb_leaf.c")
> Signed-off-by: Jerry Wu <w.7erry@foxmail.com>

Yours sincerely,
Vincent Mailhol


