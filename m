Return-Path: <linux-can+bounces-4544-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 937F8B4A270
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 08:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB6A4E29E7
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 06:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510A0303A11;
	Tue,  9 Sep 2025 06:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnKchkhA"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DFA2E0B48;
	Tue,  9 Sep 2025 06:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757399915; cv=none; b=UtnB/MdvHUFg0LJ+yl3fxeI8+IXmGmso96fEq8BdLs1Y4QH4rzt6wZtN+OcUloelB2mxgNyoqn+mlldtU+/zh1eBPwElc+b8WTNGUMtI88Y5y8GVgzUVbKArzkpXutHw+9FLWK5TXXcLdOCN51ZNCZ3qQUSsbrG5MyloHPshdWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757399915; c=relaxed/simple;
	bh=AMS2il9je36kDyL7itAQ6lHYSz9wFN38lcE4DElNOFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3s/Avz0hJJCTEdkY5T5KD2ZnzIcVkXjGTxSVPAUC/bfNiEo2OZYQgxiPuIni0mhFume/pQsmhtFSzge9OtEkEnNtcbrAA8rRdpZZbaAZSg7t8zW7sc6b6wuXrD3YS+5LjevRYbzGabfVwnSY+O4qNXvpeqmyAbDwwUKwQlrSFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnKchkhA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E080FC4CEF4;
	Tue,  9 Sep 2025 06:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757399914;
	bh=AMS2il9je36kDyL7itAQ6lHYSz9wFN38lcE4DElNOFc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mnKchkhAR9/C+1wRR4Ey7i5nrcrPGOEXrS4OfmL64DjjPorsHIK8SS7hXbbLEJoz5
	 4kZnHcFBZW+3MqD23hjyXMgoitOb3lvHxIXB784Ul6PDaWpon8E/Kw+/iTVqxofOTF
	 +WH9gETRg5bvar/NIiVu+3vCJgHaSBUjyaOjjW6TGqLxFTtTPhOQBlNSFFm9RRPc/n
	 xhj+BWbrzId2MDW2OHhh8wkXLNZEebDTga8yQ4NoWPp8Ewc9shSduWUGHpgxWtMoiR
	 FpZpQcl5xX6tEEspa0eUx7xYeiHDB3CN5B/eBFUY6/uJkKAXzm+qv1AFVPAJw3lar1
	 yy0e9oguCmMtg==
Message-ID: <fa9a5a87-d91c-4d24-af76-432c0db59df8@kernel.org>
Date: Tue, 9 Sep 2025 15:38:32 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] can: rcar_canfd: Invert global vs. channel teardown
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Biju Das <biju.das.jz@bp.renesas.com>
Cc: linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <cover.1755855779.git.geert+renesas@glider.be>
 <00ff7a4ad18bb26a74c77134182b4efd380ecc84.1755855779.git.geert+renesas@glider.be>
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
In-Reply-To: <00ff7a4ad18bb26a74c77134182b4efd380ecc84.1755855779.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/08/2025 at 18:50, Geert Uytterhoeven wrote:
> Global state is initialized and torn down before per-channel state.
> Invert the order to restore symmetry.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Same comment as before. I assume this is only cosmetic, if not, Fixes: tag please!

Reviewed-by: Vincent Mailhol <mailhol@kernel.org>


Yours sincerely,
Vincent Mailhol


