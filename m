Return-Path: <linux-can+bounces-3284-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E5EA74DB2
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 16:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881A93ADD62
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 15:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B60923CB;
	Fri, 28 Mar 2025 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="tFG4ynpf"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-68.smtpout.orange.fr [193.252.22.68])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084C5E545;
	Fri, 28 Mar 2025 15:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743175685; cv=none; b=mCZQXIN3jXqsCwNCeO3WyR+BT9P+FjkYEcIAqmxgwEo4bYZa5XXg3wNYcpHWBfRc+dU0+pU6LIhvgJzadeU+SlBnNRiy0XSArF4NVp/mpFyqK1EeDiu+vvF6NK/RIpiRdQOVlmPnTvB6mwjakKVnp45VB4IGB1tuxoSmUwPDlN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743175685; c=relaxed/simple;
	bh=BG2Kf8NvB+d3XTlQ1S94V0HOvVMCa/1BXmrs52s4xig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I7m+NjHry1W2olJnMiNEcuY+1peTK9CO9gB/mIcIxNScyGdeDq2L68tA1CoSsrF89j/pRPINP6hRGPq2GpO7ex2fA95z3uk1F4+ETbMbqZxvWcES0HKK2/Q4CFg7+Bk2YcEi5DKzlxr7vrCf3H6ubwfUyy/F8mIM+ubPsAVesMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=tFG4ynpf; arc=none smtp.client-ip=193.252.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id yBcet8ceJZjv1yBcitv8Tt; Fri, 28 Mar 2025 16:28:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1743175680;
	bh=/l4aSeNyVAVvBojNbmj2IqSIsqrK0oBvxIoSUSDXiOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=tFG4ynpfeXRCBFL5Q9i+/AItdKHLYC37SQBifPhS1iBsQ1IFQiWwdi+tU1PpPXflf
	 BxUw7yPFQ3n2F0a7KqXUkWoXJH9xj7fH3GSBlRjMM7wGPzniABqbaSRYqX9v2yQlVk
	 F7BzWwKVSmP5jOAr0luf5wqYQcW8pkxQdDoNzB0jBJ40We4fQ3sIsh7STzzMxNgzi8
	 9sVPvdq5pnbDvf+GQyjeOfjSfIwSQ2ECdKezFiT8m0IOo72BLoDmXOyCHw+GYJgJLq
	 4xh6w7JEn4VeCudQ/tdwG1nNW36B+Zwi5z9cJn8ngpWe+rHTGQDiq76lOphDwe+RU8
	 5iFQvu12pIgOg==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 28 Mar 2025 16:28:00 +0100
X-ME-IP: 124.33.176.97
Message-ID: <6d23e8fb-9c97-41ae-bcb0-05a00a6d2172@wanadoo.fr>
Date: Sat, 29 Mar 2025 00:27:51 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 18/18] can: rcar_canfd: Add RZ/G3E support
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-can@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-19-biju.das.jz@bp.renesas.com>
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
In-Reply-To: <20250326122003.122976-19-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2025 at 21:19, Biju Das wrote:
> The CAN-FD IP found on the RZ/G3E SoC is similar to R-Car Gen4, but
> it has no external clock instead it has clk_ram, it has 6 channels
> and supports 20 interrupts. Add support for RZ/G3E CAN-FD driver.
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Yours sincerely,
Vincent Mailhol


