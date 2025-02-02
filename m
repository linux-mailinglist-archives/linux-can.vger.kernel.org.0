Return-Path: <linux-can+bounces-2712-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC696A24D13
	for <lists+linux-can@lfdr.de>; Sun,  2 Feb 2025 09:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22FF81629F6
	for <lists+linux-can@lfdr.de>; Sun,  2 Feb 2025 08:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A723D4204E;
	Sun,  2 Feb 2025 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="iUGeOnBa"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-17.smtpout.orange.fr [193.252.22.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2EDAD27;
	Sun,  2 Feb 2025 08:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738485676; cv=none; b=XJIG3wQS5GXt2SvipjGDfg7craXOTXA8iu97PsF0GRl9Irf2leCyZhxs6ZtREoKoqbmk0nkngP2Nw02jpyyAGzcX3FWQhVNdsxs58xU/iiWYQ1FIjlTcZyuQGh2fhn1dDwF8oP6zEo0N3w/w7AR9FITw9o7USiJSZ4JMeYkLUXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738485676; c=relaxed/simple;
	bh=PGIckNwQvrxHNXDs9CbjolLyZxNq1KZ3k+rG3mbpYuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ogiXcxWfi3iGG/w3eSBPGtdFytUWxFVqV7QcoDmeqXl0fL5kwIsVpZzj1dOdvVNeloSCkDkmqdlB/Wy2r1OcNMlhsgkI+Yw58PxEHLT1rTjjqlX69Le2lckkHxF/faLO7k/g6bZsMuh6jfuZ5TJvAX4+oe6Lb9D4D/4XsFLZFU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=iUGeOnBa; arc=none smtp.client-ip=193.252.22.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id eVXDtu5JQkqEIeVXItCHn0; Sun, 02 Feb 2025 09:41:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1738485666;
	bh=sZQb6MrFxG2v6DwGah1RZNmhM8GHAqD1/zorNxpDMZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=iUGeOnBalAetbBNveOT+03mtq+0YcCbnKPy6JryjLItWQ+FrHSk+kxAzHfT3gRxS2
	 JejrqTC9wNlRuudNIE6ApwL8RyLSuqS4JflDrkz2bTLRb2LugxZyb7BGzSQMKeJq2M
	 sbZ1lovIfLT4sovtf6PEgnFJW0WNCLvWgguzvF9i/UcoQxhx3eZCB/4OlubDJLcAT4
	 4xlxZBfRgQujkltOArBKteQ9GPnkzvmHHjfSFKYMVKNI3saEzysUKXApJ9lrGzFAmj
	 ozYgIYyzZ6ANrkMhlax6m/OccOQqIHKEo9MIiSQcEYCBleJAa/CojmiwFce9nIVt05
	 10M5jNdmr7QMw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sun, 02 Feb 2025 09:41:06 +0100
X-ME-IP: 124.33.176.97
Message-ID: <78a3517d-7d9d-4f1c-b9bc-bc78d61fb810@wanadoo.fr>
Date: Sun, 2 Feb 2025 17:40:54 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: rcar_canfd: Use of_get_available_child_by_name()
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-can@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>, Sergey Shtylyov <s.shtylyov@omp.ru>
References: <20250201094642.16243-1-biju.das.jz@bp.renesas.com>
 <2cdfed6a-4461-4c57-96b8-a6c928f2f0ac@omp.ru>
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
In-Reply-To: <2cdfed6a-4461-4c57-96b8-a6c928f2f0ac@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/02/2025 at 03:52, Sergey Shtylyov wrote:
> On 2/1/25 12:46 PM, Biju Das wrote:
> 
>> Simplify rcar_canfd_probe() using of_get_available_child_by_name().
>>
>> Simplify rcar_canfd_probe() using of_get_available_child_by_name().
> 
>    Twice? :-)

+1

>> While at it, move of_node_put(child) inside the if block to avoid
>> additional check if of_child is NULL.
>>
>> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> [...]

Please remove the repetition. Aside from that, the patch is good.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>


Yours sincerely,
Vincent Mailhol


