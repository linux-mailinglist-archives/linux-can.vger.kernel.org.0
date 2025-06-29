Return-Path: <linux-can+bounces-3927-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00682AECE5A
	for <lists+linux-can@lfdr.de>; Sun, 29 Jun 2025 17:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B7E93B4EAF
	for <lists+linux-can@lfdr.de>; Sun, 29 Jun 2025 15:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985C21EFF92;
	Sun, 29 Jun 2025 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ZenjCMxU"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-74.smtpout.orange.fr [193.252.22.74])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2458D43147;
	Sun, 29 Jun 2025 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751211614; cv=none; b=lt5Rkrbq076uHCU4Ml2w8czGEmL3nTs2CZR0o8PomkzdbC9T/+6w2fUgS1wIKcMW2ji7ePEi5oZC13MwRo7Fx2k+unvNI2H11OKCAZ74fB2MPP7VzaGxXfzoZL9YnvM4S9vrlz/9L9a8ZuEsC1yAq5+CozEH+cGW6hhS1LenQVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751211614; c=relaxed/simple;
	bh=rT2lgqc9BKdMUJ0jypPlL1wSna+/d9C+a5HgXD5o6wM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LIIlx9SykiDwgO6o5v+qOu2ehpXn/5okPfx6QN15jYYYnuh1WzPzam1sNj/ipLanRXpMFRDHdKiYZHaS4XX5J02T1A/k7sTIGe6pSV1woO9qMgCq5gGYYK7Dtpx4/WHcxadD1+HmsJsif/3s2SfDSeYuLO4PV0h2BMoO7HabDng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ZenjCMxU; arc=none smtp.client-ip=193.252.22.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id Vu7juYYhtmEU9Vu8Su6Ic5; Sun, 29 Jun 2025 17:40:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1751211608;
	bh=63YVuvhNKhvutN+IZ6hlgh/2Cir4VaP+1GCWC48EJR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=ZenjCMxU18A2EvwWmZw0BJOE2z6kAW1p1y5R5g9WZ5eVErgvN8AQ3ZKFH9DkZ8CYZ
	 fuEmhnWbcj6+7rTgPyM+9qQqGSUo6TcXZmB8TjvLUy/kXoJtQKxm/RiBUd1OmSAeBR
	 /UU7jGXw9y/RrBE5yEWFVOR9TFbpdnpzlOtKz8cwJ7qEHXxpZDPAtXSMDBTDzj1/tW
	 7eSQoPxTFs3kIdpqEZOFP62Pik1OyXOZTF2DtJQd2shjapx2vTW9ZSKJ95dWodbx/n
	 LG7h9CX9SVDBn3sqIk7kZOrRoiAvjIT49x1/t8l2MKYkQJ5jvqtUAyp/Zj0pXlEf6h
	 idgNI0ZQMIPcQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sun, 29 Jun 2025 17:40:08 +0200
X-ME-IP: 124.33.176.97
Message-ID: <6c1ac003-6e79-45df-b172-5c01178ff6ed@wanadoo.fr>
Date: Mon, 30 Jun 2025 00:39:18 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: rcar_canfd: Drop unused macros
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
References: <20250629150417.97784-1-biju.das.jz@bp.renesas.com>
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
In-Reply-To: <20250629150417.97784-1-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/06/2025 at 00:04, Biju Das wrote:
> Drop unused macros from the rcar_canfd.c.
> 
> Reported-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Closes: https://lore.kernel.org/all/7ff93ff9-f578-4be2-bdc6-5b09eab64fe6@wanadoo.fr/
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks a lot for this clean-up!

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>


Yours sincerely,
Vincent Mailhol


