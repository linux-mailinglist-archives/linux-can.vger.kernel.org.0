Return-Path: <linux-can+bounces-4001-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6537B061AB
	for <lists+linux-can@lfdr.de>; Tue, 15 Jul 2025 16:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B888E586AB4
	for <lists+linux-can@lfdr.de>; Tue, 15 Jul 2025 14:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CD91D79BE;
	Tue, 15 Jul 2025 14:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W42KgHv8"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B52174BE1;
	Tue, 15 Jul 2025 14:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589468; cv=none; b=MKPI6a+lEgOpY9uTmeDjpeej+3KRn1G2eq38rUzgu/4jF5D7teBV0WCBKGfkpVuUiysbj37Onk0vIM63kK79cwtQWep8BhoXKiP3Zkm2izD7kXzv2lahVyOVySbwvGZFACLIT/+kYO0/da7of8nsRAQcZ1gEoF/WryuImQhcuJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589468; c=relaxed/simple;
	bh=tvcG8BkIeDgNMPjNLaM4nJWMewFH5e7W4sw1HSgJiP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lR7S4+Si4P0KMeH9KpgwqU3vesbZoQm0Ofj6lQtK81Ke0NjI4PN52C4dR8NiCrcGpOgtGlaxzDRt5APRjombyN4XkHKys0/8FLZfuU5Bt+D0wQuPzEvgOMrtzBGoGf4B1HkP0qiLAuprZfTv9zxdjXZYjFjLKRp1ZjuqidNcl9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W42KgHv8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4537edf2c3cso57696605e9.3;
        Tue, 15 Jul 2025 07:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752589464; x=1753194264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iSxra2qSvkUH4C8FcWMO1mkXXQA40nE+NViMoOLJVjE=;
        b=W42KgHv8XtYici7/aduJs0DI6grBtrfLRX1Wy83pwGmG2Q7vBHaNqfEs7PBNIWDP4M
         dhP7rdUSuf70TvG6orNx6iEpLzVf1AfE/Oml9bL8YwUcd0v8zcMRwmwRYHZW15HqL9iF
         /yjj9GZB9ReuNgj6tv9e8JJekytViDRYJhhVD+sLaPTY8Upzyt1e9O2UPKqXxezPK7qf
         OwzO7vcy+UZl8HYOG6BIsh1gp55VTYc8Uc26bnZxXgbAStyssGDcnMB3ad/8R0fUVY9H
         QbNT/YS1FlIef35D3Xa1ponj+iD5unC21YkzN5nr8bINblKchdVt7zAywwQ6X5jLhVru
         d+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752589464; x=1753194264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iSxra2qSvkUH4C8FcWMO1mkXXQA40nE+NViMoOLJVjE=;
        b=b7RxTqIoGGCrb3IRQHpfAaAs46YtdW18bK3QqGzt7vwooj7dhohpVbcsL0cAjS7sRf
         1mYYNiZRuh5dx/iy+f3o011cFhATzsBm5xt5/nPEVE1EpcUhwnfaDf08yTZCsOyWKPKm
         c60R9p6GMAPE/P1CfoGlBmRy1D1uNfknI/SM65zVH4wZ9BahNH6e14HsyQR1aGIEc2g7
         Qn8RNstVYkT+Dh8NFz4wiw3WTia8GFPmmaaWc2h4OAGQ6LGb8Dpdx/lYr8tcu+GwYIcq
         XjgaqDAwVV+FPBH45W56H8UZ0KeqdsexH+X6UwLwfRgcnf57fe1Ppzu82n9QKSgA82Ck
         ArnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUconfW8OweJRXfpryjp4S24yAn8CfCHxh7+i3kLeaekoNmKsyCXafUpOQ4JSldA/miEBjA8ZZuiI8=@vger.kernel.org, AJvYcCWTj88oC7CX7qHEvoe6Jr2KLHNJkfUxT5nqmfWBJF6N43Vs5+2wcjgVB96KFF0avaVEsU6035BfMd0mBx6l@vger.kernel.org
X-Gm-Message-State: AOJu0YycjDHV16lxKAGmgl1Zei3UjQEAMLobmssiD7yZ3+dsgJZxKGri
	NlI+RsmwlsDv+5y29jyySsNKPKaRk+mXcajkcE6K8goUm6/OSwQrKx8DpXn+0SCA
X-Gm-Gg: ASbGncuUajhcHyFvtfMDA7Xtxez/cDQ5zr2qK/gNgnw2KRWNDlV7lpocwgshfT5tuIW
	mapLENKjRSgXvOQJHGrLAKwDRtTBDpWQ0weWq2kLSpDp18r+DniL1MUr+c5UM6Z788NBc+BZe3h
	gryU4TKYWqzfERJi+6uajJTWBhNafNRMCa1+YYmvjXtnDSFQ9nGwV2b/y41G0b77yzRkoQkNC0x
	+m90SoIdCBomFkk6jhHZyTf6WwZy15/sGCZrqfc8O8E3fH1SFok5KUZfKAWbUo8yG7g/+1p52At
	gsds/cJ5eJ4v9DJUzdd6BM1cJYEQibG8xn/qujf/NoGJWMsirRh622wYvSqk3N00AMgkDQCO8uZ
	yE5Hctx50PXqC5P3/2xawuyhHBdOuFJ4uQX4LS4JvtW7mS+j09ZpsZg13MqqQ1XMy2i5ELEpb0m
	IBik2PLroYVUcL2ukMqG+NXa+gSVPAZYBYCZ/1TNsYsEiwUQdfSxGYG4+zKJq/vGrBmqlr2GPL3
	s36P3KPkuoyxo+6hC70k0PteHidlDoxsoSfZQ==
X-Google-Smtp-Source: AGHT+IHyNbNP+Oa/8R9trX36pUDEdxOvlB4n47aAPoN7MLAqKPF0AeX4+tNgnxK4GCbkpt+1TiK1EQ==
X-Received: by 2002:a05:600c:8211:b0:455:f59e:fdaa with SMTP id 5b1f17b1804b1-45627417addmr26997435e9.21.1752589464282;
        Tue, 15 Jul 2025 07:24:24 -0700 (PDT)
Received: from ?IPV6:2a02:8388:e103:2700:a09a:f854:4544:3d0d? (2a02-8388-e103-2700-a09a-f854-4544-3d0d.cable.dynamic.v6.surfer.at. [2a02:8388:e103:2700:a09a:f854:4544:3d0d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45626cde7aasm13247185e9.1.2025.07.15.07.24.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 07:24:24 -0700 (PDT)
Message-ID: <b8221fe9-a167-4bcc-81bf-fb793712b48e@gmail.com>
Date: Tue, 15 Jul 2025 16:24:22 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] can: gs_usb: fix kernel oops during restart
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: mailhol.vincent@wanadoo.fr, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org
References: <20250714175520.307467-1-andrey.lalaev@gmail.com>
 <20250715-almond-zebra-of-perception-9d2e6c-mkl@pengutronix.de>
Content-Language: en-GB
From: Andrei Lalaev <andrey.lalaev@gmail.com>
In-Reply-To: <20250715-almond-zebra-of-perception-9d2e6c-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.07.2025 11:37, Marc Kleine-Budde wrote:
> On 14.07.2025 19:55:02, Andrei Lalaev wrote:
>> When CAN adapter in BUS_OFF state and "can_restart" is called,
>> it causes the following kernel oops:
> 
> Doh!
> 
> I wonder why no one stumbled over this before. That's a systematic
> problem for all CAN drivers that don't implement this callback.

Hi Mark,

I was also surprised because this callback isn't marked as mandatory
and that there are no additional checks.

> 
> What about this fix?
> 
> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> index 13826e8a707b..94603c9eb4aa 100644
> --- a/drivers/net/can/dev/netlink.c
> +++ b/drivers/net/can/dev/netlink.c
> @@ -285,6 +285,12 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
>          }
>  
>          if (data[IFLA_CAN_RESTART_MS]) {
> +                if (!priv->do_set_mode) {
> +                        NL_SET_ERR_MSG(extack,
> +                                       "device doesn't support restart from Bus Off");
> +                        return -EOPNOTSUPP;
> +                }
> +
>                  /* Do not allow changing restart delay while running */
>                  if (dev->flags & IFF_UP)
>                          return -EBUSY;
> @@ -292,6 +298,12 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
>          }
>  
>          if (data[IFLA_CAN_RESTART]) {
> +                if (!priv->do_set_mode) {
> +                        NL_SET_ERR_MSG(extack,
> +                                       "device doesn't support restart from Bus Off");
> +                        return -EOPNOTSUPP;
> +                }
> +
>                  /* Do not allow a restart while not running */
>                  if (!(dev->flags & IFF_UP))
>                          return -EINVAL;
> 
> regards,
> Marc
> 

Thanks for the patch. As expected, it fixes the kernel OOPS,
but the interface never leaves the BUS_OFF state.

-- 
Best regards,
Andrei Lalaev

