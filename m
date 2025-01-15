Return-Path: <linux-can+bounces-2646-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA12A11629
	for <lists+linux-can@lfdr.de>; Wed, 15 Jan 2025 01:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB6177A228B
	for <lists+linux-can@lfdr.de>; Wed, 15 Jan 2025 00:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DA729A0;
	Wed, 15 Jan 2025 00:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="EKESuERc"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-12.smtpout.orange.fr [193.252.22.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD2BDF58;
	Wed, 15 Jan 2025 00:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736901684; cv=none; b=hrQsixDmxY9fGbv8ksQgtiM/4Zj3FX/+Cve6nUJT3DAWtiuS2DOrKOx557ZZOR/m2KlyMZxNDXXJVYxrnNZliZWZvCAuqjrJQh/R6HeYEFwcAueyv+EWfyPe/vNuiJS09WF3R3jdLVbVJ178nixBWTfbalo1hB6BD0ohTAGyF84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736901684; c=relaxed/simple;
	bh=gw0sEnFfF9yyUpFBF3pSCpeLmYQcTBuMeN1ndRR7Dg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dsM/T694z+N+Fx5fcjae4snU3pDu44Ds7/P8Ie3PUd0irewRCN/HhSmVpVi5PMctyT4/h1DXZ7tWlT+9IDQbCKAz4J7hiKmqsZQ1GeNTbrtsfVJyWgWqhroKXws2fDKkxTRHSFaa53TzDvkSZL7E49tEhAcP1QRhAv9pU1IUyg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=EKESuERc; arc=none smtp.client-ip=193.252.22.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id XrRxtAZHahEBsXrS1tWRaq; Wed, 15 Jan 2025 01:40:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1736901610;
	bh=Pzxurqw09BYbAy2gGmiRENRLKoCtz6h34lxM0ADabRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=EKESuERcPgvtjy16e/ke5QcgoCxZO2X/akoux/uZaU9OUxxImkyLF0e4KgjMeFxWV
	 XEdPLrvK+TGBn/Xbq/xu4s3YJvcjrYQe8LKXlVxGHmZTAIBq43cwt6yxb/3LmbTtmT
	 OV0LuSMQVocwX9Dq1cX7kc6iR/P4Vj4v7Tx7BTY1LDP9+5C5KyW0rEwD7fhLhAIjpJ
	 m8C2Dikn3k04u2jyCbb/KdpC3PWwdpFanwNUTkqf07B3TpmPmr3J/o52Lbpxt9fMSb
	 wOEtHxsBXWD+5GjcQbgdJyGfqQvjEZp9HqJBPHX4R6q/iTtCJkTJjdQS85tTg8iEPI
	 Lsf/vrLmPCrhA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 15 Jan 2025 01:40:10 +0100
X-ME-IP: 124.33.176.97
Message-ID: <319da2a9-b9a7-43bf-8cb4-bd87b2ebef92@wanadoo.fr>
Date: Wed, 15 Jan 2025 09:40:00 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: ctucanfd: handle skb allocation failure
To: Fedor Pchelkin <pchelkin@ispras.ru>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Ondrej Ille <ondrej.ille@gmail.com>,
 Martin Jerabek <martin.jerabek01@gmail.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 stable@vger.kernel.org
References: <20250114152138.139580-1-pchelkin@ispras.ru>
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
In-Reply-To: <20250114152138.139580-1-pchelkin@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/01/2025 at 00:21, Fedor Pchelkin wrote:
> If skb allocation fails, the pointer to struct can_frame is NULL. This
> is actually handled everywhere inside ctucan_err_interrupt() except for
> the only place.
> 
> Add the missed NULL check.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE static
> analysis tool.
> 
> Fixes: 2dcb8e8782d8 ("can: ctucanfd: add support for CTU CAN FD open-source IP core - bus independent part.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Yours sincerely,
Vincent Mailhol


