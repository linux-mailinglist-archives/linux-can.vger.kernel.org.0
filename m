Return-Path: <linux-can+bounces-3249-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AECA745F9
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 10:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56AEF7A611D
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 09:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3A517A316;
	Fri, 28 Mar 2025 09:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="iQvh1pLP"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-69.smtpout.orange.fr [193.252.22.69])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156D717BA3;
	Fri, 28 Mar 2025 09:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743152826; cv=none; b=AFYkiIG6+UPlPNEjJV45rIQVNapZfVIz0aPxvZPQ+1D9MavBbEk9ZaaNQF1f77wHRWDqAn2FMb48qysW8fSOWyIAif+jcVBbEJlu6XZ6j4I7XDhS0TjBVyjseLJX0wskmTG+pKsqY9FYmsulWt2FOiZcJx9x3wY5suQccQBO8a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743152826; c=relaxed/simple;
	bh=LtZ+43tNPltor/hQLvlKa9xtp0akkSTcs2HFjBTVMrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HvttpONErK2hE1P9G1VPwVdjWowhXOG7Rlqs3C0Y0KaEQolA/kuCq3HqQ1TBRVt7eBZ64YsRpNNwOTU31zLNB/ZUz6usGMo5DTzkLmo7p0o0t169KE/JGWEue8AF23lcZKqXPdYm3qE9JUEq1+ApWvlLzwe+F6oRu41XaUmm47s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=iQvh1pLP; arc=none smtp.client-ip=193.252.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id y5eotc7X6Vylty5ertIXIm; Fri, 28 Mar 2025 10:05:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1743152749;
	bh=yA6rEOcbyc8u9cC2rqp009PfWyA4Q8Oph64ubuguqvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=iQvh1pLPbTflPuhPPqRmaOlJRK4F0PVdaL/GahMYTytjtwdDXveelXKEwd+051ycp
	 7SAxmRriRjjvqfHaYnz/wJoUdlOiTkniA7qbWE5jz1XuCzMzVQEaavG2C3OZdyxdlF
	 eA9wHA3HJ0L0m4/ct9iuq/+qXxw7PZNAbfGVVUS1L0O6nbG14y3f+t2DltGrofP6FN
	 sFpmJMh40/ovP2eTdq4rKLGYnMIt2QP+XOkzWArnYEgfCNM/RKW0rkSxIBsat7BIN8
	 Da6WDGE8Dd20ZxSZZCJdt6ok4xT94r7b86rAqYvjOtEqN4eEsScCzj0wMWfPTor163
	 4SZTjeAx4x/Jw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 28 Mar 2025 10:05:49 +0100
X-ME-IP: 124.33.176.97
Message-ID: <37aeda0e-ea47-4393-a9e2-25fffc8dcd26@wanadoo.fr>
Date: Fri, 28 Mar 2025 18:05:41 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/18] can: rcar_canfd: Add num_supported_rules
 variable to struct rcar_canfd_hw_info
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-can@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-7-biju.das.jz@bp.renesas.com>
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
In-Reply-To: <20250326122003.122976-7-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2025 at 21:19, Biju Das wrote:
> The RNC mask is the number of supported rules - 1. Add num_supported_rules
> variable to struct rcar_canfd_hw_info to replace RNC mask in
> RCANFD_GAFLCFG_SETRNC macro.
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Yours sincerely,
Vincent Mailhol


