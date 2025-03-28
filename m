Return-Path: <linux-can+bounces-3278-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BE3A74BED
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 15:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D79E116982A
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 13:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB643214;
	Fri, 28 Mar 2025 13:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="bu66nJ+J"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-72.smtpout.orange.fr [193.252.22.72])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC2F35971;
	Fri, 28 Mar 2025 13:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743170301; cv=none; b=kLOJfhyj5CxXs5QfHlLzW8yQi5ZCdB+ggsUjdc96kwU2uwpeP/CrJvViQHn3BfjecCzXKYXatjwtYDp8ViwGiEJfLISZAklhAYzOjoKGz8Fg7k+tZHFCycefFhZw0bnuM0NdsbH4Ftrg6DbI+9Oe3OhEukElIYg/VJrLOlx46NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743170301; c=relaxed/simple;
	bh=zfcrkbp0GmBqgXVxiJ7s1g9jakmw+ILpdGd4bgTPy9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZR5dLbkSxYrwEKMdCupjqHE6x3FpsLEDHkKZJE30ufOPUGPAwYIBmJdYaMBS3p+3rabGdmwxmmus2WrllQFuEW4htU9n26g/1uqZwInMKQSvOk2VsXncwfuL7ExT7iQGs6VK5r1RnjFDPsyxF78KN58VUSRlRjfuEsKghFLrwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=bu66nJ+J; arc=none smtp.client-ip=193.252.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id yADlt9FAK4o0iyADqtkiEf; Fri, 28 Mar 2025 14:58:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1743170293;
	bh=bmXuDXxZ8s94WlTlcnasLzDXdkF4e/HHjsyNoK/6VA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=bu66nJ+JaDOYjryQ/W8w7iIV8RSJZQHhkTM0RgSt91oVjtpdfCYykK7M3H7KGh4tL
	 PDP8Fogi4qEfRq/9t9Te12OthUsHFzrB5IhsTelKHtc2TJlhbVhwpQKm3mD38XdQPJ
	 jQfmS/QLhuPiNU3jMTU98maLEfmHtHNzkQMxwL40K5eKDA79aVmcJB9s8jqqaA4Adp
	 f3q6t0okMLO/Lozx2aMKonkZzwYpLJobkZhhg2aUvpXzCOoHyb9S+2CavPXenDAWI/
	 SOuCXFkVZocvokjJitKeveJEYCX8jN6YYL1ySBnqryCgDPgZMqaAfv1fVP0bx+Ql+L
	 mIXWkwCuViFdA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 28 Mar 2025 14:58:13 +0100
X-ME-IP: 124.33.176.97
Message-ID: <86d825f5-7090-46a6-9592-aa5ed6f92300@wanadoo.fr>
Date: Fri, 28 Mar 2025 22:58:05 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/18] can: rcar_canfd: Add ch_interface_mode variable
 to struct rcar_canfd_hw_info
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-can@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-13-biju.das.jz@bp.renesas.com>
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
In-Reply-To: <20250326122003.122976-13-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2025 at 21:19, Biju Das wrote:
> R-Car Gen4 has channel specific interface mode bit for setting CAN-FD or
> Classical CAN mode whereas on R-Car Gen3 it is global. Add a
> ch_interface_mode variable to struct rcar_canfd_hw_info to handle this
> difference.
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Yours sincerely,
Vincent Mailhol


