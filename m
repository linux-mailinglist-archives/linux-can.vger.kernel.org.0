Return-Path: <linux-can+bounces-3279-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59623A74C27
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 15:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3D53A6C75
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 14:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530EE18FDAF;
	Fri, 28 Mar 2025 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="XLLM9OZ8"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-69.smtpout.orange.fr [193.252.22.69])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F3B19259E;
	Fri, 28 Mar 2025 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743170928; cv=none; b=AjNzoM1qEZ9SrytHS6zcAylIdgj24qkvMdhirFKLcecYEz83ovVctu8g0qK6uwbpbjXzQPXkuaoqhCKDqlkK+fZISAFHG0r7sXs+AZh89XA2ifSJ3+65EFe+RbCSXUlXXheWXrGRJUdEFaCJfEKLVnDs2nTjzTzEqFv8c8Zhm8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743170928; c=relaxed/simple;
	bh=sRKNEDZP/5ha6S9cwBLzKuAWLmEvaDx5/Nc5EGTMLIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JJsZ1qGOipOAa7U8DCzAhwUVTFqnk7iQJdLf7ixkIW5oqEmgJSPqkTjuf8bcR3doc7nCHoITWEVAu4FFj2fam874xt1apCu1x6++UIbQduTCmQdnsdvXOUcBQv/R2B54mzTlwZ0u7zUKjFByR+enI8swouhzGZXt/5QfIzhPe4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=XLLM9OZ8; arc=none smtp.client-ip=193.252.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id yANttGtXXRVBJyANytd1jW; Fri, 28 Mar 2025 15:08:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1743170921;
	bh=W1V6QyHxc46fqsl2RL/5I06ZF5ISqjB4pSFojTNxy8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=XLLM9OZ8cRztvhRIIV8WxYUxtAo4aCDmxGSrXoDpbkw2Qa6KkPGPmg/EY3+XJ+EQi
	 jX3fXAhXPCZhuR7x15GLHsoousgujYE+zFFOG1AT1jEnDxJsUvfotD4JJO9ScNaS0o
	 SicCfaK31/3l4x4JXGiWzqKIdAK9dXOxOARR8FQ8ul78ZA73JRRwSmEs9q+wxeTNhe
	 yAroYF+pXhYI/5k1zfZWIbG439REG/sxLt2vQ6gPtcKCJFPtfqM4r246dOnxAQkeXh
	 8RgDV4G6wRCBh7jUeHDKPcUdSaPzVbH5aFO5taPk7S2/Z9qsbnhi4pmeoj9NwdK1NU
	 EPibYR7xuHIow==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 28 Mar 2025 15:08:41 +0100
X-ME-IP: 124.33.176.97
Message-ID: <1479b076-9eff-4efe-bcd4-120a7537bbdb@wanadoo.fr>
Date: Fri, 28 Mar 2025 23:08:32 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/18] can: rcar_canfd: Add shared_can_regs variable to
 struct rcar_canfd_hw_info
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-can@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-14-biju.das.jz@bp.renesas.com>
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
In-Reply-To: <20250326122003.122976-14-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2025 at 21:19, Biju Das wrote:
> R-Car Gen4 has shared regs for both CAN-FD and Classical CAN operations.
> Add shared_can_regs variable to struct rcar_canfd_hw_info to handle this
> difference.
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>


