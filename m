Return-Path: <linux-can+bounces-3935-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9DBAF1589
	for <lists+linux-can@lfdr.de>; Wed,  2 Jul 2025 14:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDF4B1BC5F2A
	for <lists+linux-can@lfdr.de>; Wed,  2 Jul 2025 12:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3E126F46C;
	Wed,  2 Jul 2025 12:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="F0SCA7CM"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-70.smtpout.orange.fr [193.252.22.70])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47C526B747;
	Wed,  2 Jul 2025 12:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751459053; cv=none; b=lRd0j7vjm9sK/RMrHyERGQEGK6F96W+d1P/Vpa5I8qSRmi/CGIkuZ3E318OmokpI2plrmENImxMB8UI2DNqOOVHgX3xbsVeU96kW41g5+P7cglz/AqRJL8J+eHQObvYlBEBdOtt5kkMQNl879Wp4aYynStghZL73R7TKVpHSGwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751459053; c=relaxed/simple;
	bh=FnTPS7XrucGy4Vkovkr4+yG8KSsot54yCzj6ft7QxKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ekEy5oqFL3CA6aWQYGdQbOGG/pVBwQrnBi7bibYcYpeSS63sfmrKCuZIf/ciuOKK65AvA/lR3u7jp3iPBWJneY3p3YsJvmh4GRu4M1xHHoAGfv4OUTLaxtoa78xkHR0j7VoblgY7+M1dAzebO564FNGxvEbygXoxLKx3PkgJAQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=F0SCA7CM; arc=none smtp.client-ip=193.252.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id WwUKuU4efLcVHWwULu3zCl; Wed, 02 Jul 2025 14:23:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1751458981;
	bh=6AUGzcNiTKnyYAvQQAMQveENbbz1AubdZ1CqkeZ4AEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=F0SCA7CMjk17ST1ESJdj+eX//PXF9chUocEUvBpjdh5rL4IVLdMtIia1TN5zJO63d
	 T6d61cwVkyQjCftcAhb2/Z2pCL8Q25tyb2g0DloaWReUEblvJ6V4/6ZwkQBLKy2/T5
	 c/5xiaMvxcHNfckmhGNqjRe/rSZrZOBLgSycwgjXlr3JHCMBugQ7g6uL4V0YplWDeq
	 2xmE8SL9z007D34L7dsonXCovBvg3PcCfxMkINQtOTBW0QYOJshJBx8jfqLOm6L9w3
	 jkyIOjUudFyA7areOCqSBZmb50djcikGZkxsC0zQAjXmli96rzwU6tCW3ExM7N6bI7
	 WQ4W8E0PPJHpQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 02 Jul 2025 14:23:01 +0200
X-ME-IP: 124.33.176.97
Message-ID: <23dbf1ed-543c-4765-91a6-b54db2d49150@wanadoo.fr>
Date: Wed, 2 Jul 2025 21:22:56 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] can: rcar_canfd: Drop unused macros
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>, Magnus Damm <magnus.damm@gmail.com>
References: <20250702120539.98490-1-biju.das.jz@bp.renesas.com>
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
In-Reply-To: <20250702120539.98490-1-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/07/2025 at 21:05, Biju Das wrote:
> Drop unused macros from the rcar_canfd.c.
> 
> Reported-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Closes: https://lore.kernel.org/all/7ff93ff9-f578-4be2-bdc6-5b09eab64fe6@wanadoo.fr/
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

> ---
> v1->v2:
>  * Dropped the Rb tags.
>  * Restored simple simple bit definitions as it serve as documentation.
>  * Restored register offsets will become anonymous gaps when the register
>    offsets are replaced by C structs.

When you refactor into the C structs, there is no problem to give a proper name
to a field which is unused. First, the struct clearly shows that this field is
part of a group whereas this relation is less obvious with the macros, second,
it takes little real estate: just one field name (less distraction when a human
parses the code compared to the macro) and finally, as a bonus point, you do not
get a W=2 warning spam.


Yours sincerely,
Vincent Mailhol


