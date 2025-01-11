Return-Path: <linux-can+bounces-2595-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DD3A0A423
	for <lists+linux-can@lfdr.de>; Sat, 11 Jan 2025 15:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 612B318878DE
	for <lists+linux-can@lfdr.de>; Sat, 11 Jan 2025 14:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EFA1ACEDA;
	Sat, 11 Jan 2025 14:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Lu12umaL"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-71.smtpout.orange.fr [193.252.22.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD27324B22D;
	Sat, 11 Jan 2025 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736605790; cv=none; b=qM8ZkKSaPTDwegCelDeRcPYvJMWksN4bxeayKCoYpLGFSDAvmXMf75q/vgZxwKHZvb1uGAgTzLiVWDrtGxwy3bNthu+jFC26ACx8BOMmB4hee2q8SIztSLCcK5CPl9r+MtyAGkzEldsNUzEoUaoptklro2CYAqWCu8EgqwnKqk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736605790; c=relaxed/simple;
	bh=TLWESpAt6i+RL1le7xlgqzHu9rsqzhATZ5qZDef8sjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/081fLzDBKvxoxejqNd7aiogoK4r5zvKTtQEpGFxvJJPbL9E4xRFu1jefAYL2sdFkpBaJYcQvyyvK0/YQ8L9iUG+66xxsP8l9aLZlOZKBwjpZ/i2CvorjcaROi8p+1UA1z66bukMOhGCRych9m/JuJBkvCtlmUNtrZwnEjNO3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Lu12umaL; arc=none smtp.client-ip=193.252.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id WcM2tn7VqBQudWcM7tS2ho; Sat, 11 Jan 2025 15:20:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1736605256;
	bh=WsiTbARFpM+ocPNvsTMcVs1wvSYGOoycim0x2JkkrKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Lu12umaL8equQxEn+uNWIWSG8TRAydlHzBrQsr5DGljZc33huiqJlp8VydEezNA32
	 FDfU3rYNCQSFkVTd3XVFypCwThImiFS325XsE0rJi4xxnoRcTXBW8/WYitFH5YVVB8
	 7XwcKdVQICh3Oqb0nkln69b9KY2kzUCC7vtwUgGqJ89cY8uf06pDscNRPUp+/stJ2/
	 ivkhjqRmohDIG9yG2f5K2aAe/8YJZdNb8nQZDBne65ci7k7JkSm+o10F6+U+mQ3Gjx
	 uyKsofSOU/f+0CP2wmDyhLCO2UZs6yD/cyXfn75VHqDasAw+uiHDJpdew0BOYW0avz
	 /0NMrhqjbhw4Q==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sat, 11 Jan 2025 15:20:56 +0100
X-ME-IP: 124.33.176.97
Message-ID: <5589a4e2-75b5-49ca-a8bf-5de892cc45c0@wanadoo.fr>
Date: Sat, 11 Jan 2025 23:20:45 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] can: grcan: move napi_enable() from under spin
 lock
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, mkl@pengutronix.de,
 linux-can@vger.kernel.org
References: <20250111024742.3680902-1-kuba@kernel.org>
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
In-Reply-To: <20250111024742.3680902-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/01/2025 at 11:47, Jakub Kicinski wrote:
> I don't see any reason why napi_enable() needs to be under the lock,
> only reason I could think of is if the IRQ also took this lock
> but it doesn't. napi_enable() will soon need to sleep.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

> ---
> Marc, if this is correct is it okay for me to take via net-next
> directly? I have a bunch of patches which depend on it.

Even if the question is not addressed to me, I am personally fine if
this directly goes into net-next.

> CC: mkl@pengutronix.de
> CC: mailhol.vincent@wanadoo.fr
> CC: linux-can@vger.kernel.org
> ---
>  drivers/net/can/grcan.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
> index cdf0ec9fa7f3..21a61b86f67d 100644
> --- a/drivers/net/can/grcan.c
> +++ b/drivers/net/can/grcan.c
> @@ -1073,9 +1073,10 @@ static int grcan_open(struct net_device *dev)
>  	if (err)
>  		goto exit_close_candev;
>  
> +	napi_enable(&priv->napi);
> +
>  	spin_lock_irqsave(&priv->lock, flags);
>  
> -	napi_enable(&priv->napi);
>  	grcan_start(dev);
>  	if (!(priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY))
>  		netif_start_queue(dev);


Yours sincerely,
Vincent Mailhol


