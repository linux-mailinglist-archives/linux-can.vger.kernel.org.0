Return-Path: <linux-can+bounces-3869-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBA6AE0330
	for <lists+linux-can@lfdr.de>; Thu, 19 Jun 2025 13:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F24A57A7E89
	for <lists+linux-can@lfdr.de>; Thu, 19 Jun 2025 11:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8F3227BAD;
	Thu, 19 Jun 2025 11:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="t+XfUDuP"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-68.smtpout.orange.fr [193.252.22.68])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02BC226D09;
	Thu, 19 Jun 2025 11:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750331646; cv=none; b=VwWMB/D5TK+JqvzzOkQLeC4mWdFOHSdIom1DLqdW7tZ4sh1cAM/sJsoTUdggX8eeBoT9jl+0uK5dcJPSiJSodz3oCpnn6dXcKKHO6gf7SZga1vG25XdrxEdo4CIS8dAZz/PWFSFzwstuzqiJux0M0/hxjY0CVQ2XtJ9IR58EXzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750331646; c=relaxed/simple;
	bh=Ir12Ssgjmm+Db2m2mLWpiSb7No+ZNzezXL6QrEsyz7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AnuoHRqw43ttFpepJT9m0vqFncsHDECFYjvW+KDS+0Xen1gRfUAU5ozoCK3cxQV/eQ9QEwWTU+QFyFU3TKYgJ7lLR916AP/d3xT46CucqflhvbWwOfmEnoDb/6BWFHuneMrA+AtEd/pBdcOF7Yz0JAckpJa1h7mkixZOgzN9AvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=t+XfUDuP; arc=none smtp.client-ip=193.252.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id SDCEuaWyOZo3bSDCJufxIG; Thu, 19 Jun 2025 13:12:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1750331571;
	bh=nzO1C4CtcnTvS6n7XDCN/bT/rN8sTJAHKtCh/p2wEY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=t+XfUDuPEBlk2RN7y4GnFO4YE+Ylk1E/cNcntvJyJQ3BIB+sRuK/77cetL7OaKJXM
	 Ju8lmLb+L5fpEEkniNSnuvj59yYpk5b54HZlgaFGad4nSR6soEud5tmRA9XFvCJDbp
	 NH0TbYkfdtMO/q/TzzXojDuNmJJgDZtOpUIjdxXTErJZt+v+T3CkKpaoFgNDETbxGz
	 lm4/gp9uEWz2vcExToVB5fHDlNQQ9ryk6sDMN+ljm6FMn+bUxnR/MgE90wxKHy+LvI
	 v5KEqYiMQ1uuElooFub3YBh4rZrxzyzvKOEDAkBEwt4R8Pc6psw1U1qeGJ34AcqCEj
	 p2YHAEpr8JROA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 19 Jun 2025 13:12:51 +0200
X-ME-IP: 124.33.176.97
Message-ID: <88b0892f-5994-4b7a-9de3-eab39075acaa@wanadoo.fr>
Date: Thu, 19 Jun 2025 20:12:41 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: rcar_canfd: Describe channel-specific FD registers
 using C struct
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 "David S . Miller" <davem@davemloft.net>
References: <292b75b3bc8dd95f805f0223f606737071c8cf86.1750327217.git.geert+renesas@glider.be>
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
In-Reply-To: <292b75b3bc8dd95f805f0223f606737071c8cf86.1750327217.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geert,

Thanks for the patch.

On 19/06/2025 at 19:13, Geert Uytterhoeven wrote:
> The rcar_canfd_f_*() inline functions to obtain channel-specific CAN-FD
> register offsets really describe a memory layout.  Hence replace them by
> a C structure, to simplify the code, and reduce kernel size.
> 
> This also gets rid of warnings about unused rcar_canfd_f_*() inline
> functions, which are reported by recent versions of clang.
> 
> Suggested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/20250618183827.5bebca8f@kernel.org
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Fast-tracked because of the clang warnings.

Make sense.

@Jakub, OK for me if you want to directly pick this patch without going through
the linux-can tree.

> Changes compared to Vincent's original suggestion
> (https://lore.kernel.org/420d37b1-5648-4209-8d6f-1ac9d780eea2@wanadoo.fr):
>   - Move rcar_canfd_f to the old RCANFD_F_*() location,
>   - Update RSCFDnCFDCmXXX comment.
>   - Rename struct rcar_canfd_f to struct rcar_canfd_f,
                                           ^^^^^^^^^^^^
rcar_canfd_f_c ;)

>   - Rename cbase to fcbase,
>   - Drop static_assert(),
>   - Drop unused car_canfd_*_reg() functions.
>   - Drop simple wrappers around {read,write}l(),

Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>


Yours sincerely,
Vincent Mailhol


