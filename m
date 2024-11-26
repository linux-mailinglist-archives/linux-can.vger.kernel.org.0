Return-Path: <linux-can+bounces-2223-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351179D92CD
	for <lists+linux-can@lfdr.de>; Tue, 26 Nov 2024 08:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E4228591D
	for <lists+linux-can@lfdr.de>; Tue, 26 Nov 2024 07:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E66194AF3;
	Tue, 26 Nov 2024 07:56:24 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0597E17C208
	for <linux-can@vger.kernel.org>; Tue, 26 Nov 2024 07:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732607784; cv=none; b=KHlFAKxGz3yRHcHjIxPtBsn0CvQkYVwsbPtRsUHhPBjCBn8W3OKPn0eOB38KkWpy/0ER07tiCGCQ/BegfOMg9zmoasllBlOr3AUA7SM+gExqjOkDSQPSPbph2Vl6L27PHd1VpxHJP0Ar9radhv6PYLzN3h0EgSXszIcBX8+awag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732607784; c=relaxed/simple;
	bh=M+6rZj90mgraIXojxx+krOYOlC6rSvVkLEnT1mbWOf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oetIdBGuYyKEXjxZlyf393nBG8Uk9Dao0V/52lIfMakwksNnkA5rSGqdfu2fNF2jzBeJFvuTU9nFGAbTNCxNoC9gNY+z5Wa83P7C4HQIDG+MWup07UfE/V0i7fexwIOvH/PGZ+nZTFKyuUGVGETUJfzNMkcq0uDLpGW6t9Si/uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <l.goehrs@pengutronix.de>)
	id 1tFqQi-0005yz-NQ; Tue, 26 Nov 2024 08:56:16 +0100
Message-ID: <cc76a1b4-d303-4c4a-be66-a0dbbe6d5ed7@pengutronix.de>
Date: Tue, 26 Nov 2024 08:56:15 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH can] can: dev: can_set_termination(): allow sleeping GPIOs
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de
References: <20241121-dev-fix-can_set_termination-v1-1-41fa6e29216d@pengutronix.de>
Content-Language: en-US
From: =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>
In-Reply-To: <20241121-dev-fix-can_set_termination-v1-1-41fa6e29216d@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.goehrs@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org



On 21.11.24 13:12, Marc Kleine-Budde wrote:
> In commit 6e86a1543c37 ("can: dev: provide optional GPIO based
> termination support") GPIO based termination support was added.
> 
> For no particular reason that patch uses gpiod_set_value() to set the
> GPIO. This leads to the following warning, if the systems uses a
> sleeping GPIO, i.e. behind an I2C port expander:
> 
> | WARNING: CPU: 0 PID: 379 at /drivers/gpio/gpiolib.c:3496 gpiod_set_value+0x50/0x6c
> | CPU: 0 UID: 0 PID: 379 Comm: ip Not tainted 6.11.0-20241016-1 #1 823affae360cc91126e4d316d7a614a8bf86236c
> 
> Replace gpiod_set_value() by gpiod_set_value_cansleep() to allow
> sleeping GPIO.
> 
> Reported-by: Leonard Göhrs <l.goehrs@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

I can't say if using `_cansleep` here is allowed or if it
would break any assumptions of the calling code.

But what I *can* say is that the patch gets rid of the
warning message I have seen before when toggling the
termination resistor. Thanks!

Tested-by: Leonard Göhrs <l.goehrs@pengutronix.de>

> ---
>   drivers/net/can/dev/dev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
> index 6792c14fd7eb009d551ac22bab1f0ee2cd0f0398..681643ab37804e9904cc4a899d44c55cefab7b6e 100644
> --- a/drivers/net/can/dev/dev.c
> +++ b/drivers/net/can/dev/dev.c
> @@ -468,7 +468,7 @@ static int can_set_termination(struct net_device *ndev, u16 term)
>   	else
>   		set = 0;
>   
> -	gpiod_set_value(priv->termination_gpio, set);
> +	gpiod_set_value_cansleep(priv->termination_gpio, set);
>   
>   	return 0;
>   }
> 
> ---
> base-commit: 66418447d27b7f4c027587582a133dd0bc0a663b
> change-id: 20241121-dev-fix-can_set_termination-f1a8412b22c5
> 
> Best regards,


