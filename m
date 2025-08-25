Return-Path: <linux-can+bounces-4360-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F883B33D10
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 12:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6075D189CD8E
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 10:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E596C2D837C;
	Mon, 25 Aug 2025 10:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeNtsfDP"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2222D6E77;
	Mon, 25 Aug 2025 10:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756118562; cv=none; b=YisRkAHgRcyD7wp31RcKE51jOa50H1L804yg1wahl1ihCxpqbkKiHlVNZk6+1ziPvvKX2OfiA9Qp1TbJH1nkl7WtDdemHMnvOIeaNXTxdGI0OSKpT3sHCkTIRyj1/G/SKtuibjZHhTSPmnbxvzNjsJV/1zt3IZAy96W6t6j886E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756118562; c=relaxed/simple;
	bh=pniJ/OcojUgVvZXrEX6n31eOyKIk+rpx6+Y78e16r2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xo7AY/otSQn1JpoRH3nX+rMTe/GLGim6qAjBUr0oHJPnebhIBe3Q/+apyhdcpQQuW1xNotVMjiyoUVzMPWorhKPRxrBQmeySBBAH8KXpigLRvOymXpP6rPNbzM/hrZhriJAlCDx7y3Aw954a5bf/0WllC1Y1TgqYVDJD5i6cP6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeNtsfDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956D6C4CEED;
	Mon, 25 Aug 2025 10:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756118562;
	bh=pniJ/OcojUgVvZXrEX6n31eOyKIk+rpx6+Y78e16r2w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XeNtsfDPUFqg8Bk5Ts/JQbuBF+GFV4o9yF9Ki+P9ai9agDfeTHcXFMNOJzNiVuk+o
	 KneEjacxq3oz3H70wdEO4oLR5GupAW0r4OiscQCy+88U5EpPWaZXVbjFr/tOEjo2jf
	 iKNywt7aUpqCKJNIxs/Na8p2JCVrGNwEhHS6mPc0Kf3wrTSs0D3aEd7Xzqm/PpZ1Gz
	 cvp0FjIvvwuSHG96JYUJg7ardwQ53AAoWAu+o5vcAEfC1fCt9TCrNWFBtsRqhyKLB2
	 W/vxiXATT5Uu0q63k0ZCKzHlcI3hQzOPIcpaPKkS0w3BrYW7FEqzePxXoPJdIGkizt
	 sKwWjDfNWG0HQ==
Message-ID: <52655d24-f6ef-49e9-b527-42f9ed80a2ae@kernel.org>
Date: Mon, 25 Aug 2025 19:42:40 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: m_can: use us_to_ktime() where appropriate
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 rcsekar@samsung.com, mkl@pengutronix.de
References: <20250825090904.248927-1-zhao.xichao@vivo.com>
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
In-Reply-To: <20250825090904.248927-1-zhao.xichao@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Xichao,

Thanks for the patch!

On 25/08/2025 at 18:09, Xichao Zhao wrote:
> The tx_coalesce_usecs_irq are more suitable for using the
> us_to_ktime(). This can make the code more concise and
> enhance readability.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>

Reviewed-by: Vincent Mailhol <mailhol@kernel.org>


Yours sincerely,
Vincent Mailhol


