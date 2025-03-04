Return-Path: <linux-can+bounces-2977-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26864A4D24B
	for <lists+linux-can@lfdr.de>; Tue,  4 Mar 2025 05:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B0C61897B9A
	for <lists+linux-can@lfdr.de>; Tue,  4 Mar 2025 04:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D82C14830C;
	Tue,  4 Mar 2025 04:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="iz3+p/6n"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-18.smtpout.orange.fr [193.252.22.18])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD84194080;
	Tue,  4 Mar 2025 04:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741061262; cv=none; b=JCNHNi1XMO4OtmmbhY/Akpcr1VuTrTqRP5PB0HqaO0D7r4pzSIdBNoPLv9NyTKgR3vmBMtoycpADZHUDG78p9UaJu0+riNhP/WmHCehGkwQahZ5kxoB6gr467fLuRv2rJ5UrdXjLZKgwpg4v2vULJ2OWxS7Zs2ylAC1ul1Kig9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741061262; c=relaxed/simple;
	bh=pXR/xSSiQ8OiYsRs7VJVz+9ZV0Jrv/LolYlJReK4gWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nEguEZt/UsWaIQvWvqPL+KXZVbN0+2Z+PoXaDmWTDvyuJq0596+0wGnSKskcL6D6BJWYNrSQ2giWjcydXWRrfidjkkAYg11BnUwlBtpizEuhv60iPj7Xx01FQL0DR7aqYqOVsKuMWIEct62Y7Czeof9lnjvoixZWdCfmOy9mvEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=iz3+p/6n; arc=none smtp.client-ip=193.252.22.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id pJXnt8bqn8w5DpJY0tmya7; Tue, 04 Mar 2025 05:06:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1741061187;
	bh=TOrNS9M96b4fPYPb1Uv33nLtzervbH+UYQV21TIlvE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=iz3+p/6nD5wKqf+HeU0+hpf4nzCj2SKEwOlqyV8SwbjQUTIywftj/PE+bQ18cmjFX
	 CegF5EfbifclxCvkyuGrNjzmKpGugSjHCszZUbUz2Gz3ZS9x6jpf+7v6lFbvRxJIkj
	 kgONH9o8c0R7+Efpxl9OeQsLzcHmKIfwjhC8FH4IVZynLffc+RRB164wvzpCLudSMF
	 C+9uhrWLjxyW+aGPCX/LoQ3sba5D3MsALWYT0D8cRHZAMufjsOhiOiSI32UbgJ2hKD
	 R8Rxn5j7LwI9qTkt5tU6X/NDpU2dKEN+zPv/Re4HRqk7QnOJc2lqDIUAhDKJ0MkHcT
	 dKfmDa628AOTQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 04 Mar 2025 05:06:27 +0100
X-ME-IP: 124.33.176.97
Message-ID: <01b6fbe7-6e49-4ac2-af2f-a512ae865eae@wanadoo.fr>
Date: Tue, 4 Mar 2025 13:06:10 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: flexcan: disable transceiver during system PM
To: haibo.chen@nxp.com, mkl@pengutronix.de
Cc: ciprianmarian.costea@oss.nxp.com, u.kleine-koenig@baylibre.com,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev
References: <20250304033731.1762899-1-haibo.chen@nxp.com>
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
In-Reply-To: <20250304033731.1762899-1-haibo.chen@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/03/2025 at 12:37, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> During system PM, if no wakeup requirement, disable transceiver to
> save power.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>> ---
>  drivers/net/can/flexcan/flexcan-core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
> index b347a1c93536..74f3137295fb 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -2292,6 +2292,7 @@ static int __maybe_unused flexcan_suspend(struct device *device)
>  				return err;
>  
>  			flexcan_chip_interrupts_disable(dev);
> +			flexcan_transceiver_disable(priv);

flexcan_transceiver_disable() may return an error. Can you check its
return value?

>  			err = pinctrl_pm_select_sleep_state(device);
>  			if (err)
> @@ -2325,6 +2326,10 @@ static int __maybe_unused flexcan_resume(struct device *device)
>  			if (err)
>  				return err;
>  
> +			err = flexcan_transceiver_enable(priv);
> +			if (err)
> +				return err;
> +
>  			err = flexcan_chip_start(dev);
>  			if (err)
>  				return err;

If flexcan_chip_start() fails, shouldn't you have a clean-up branch that
will flexcan_transceiver_disable()? Or do you consider that it is
acceptable to keep the transceiver enabled if an error occurs?

Speaking of which, if flexcan_resume() fails, priv->can.state would
still be set to CAN_STATE_ERROR_ACTIVE.


Yours sincerely,
Vincent Mailhol


