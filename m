Return-Path: <linux-can+bounces-1530-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A5197E74F
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 10:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA8F1F21886
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 08:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705E176056;
	Mon, 23 Sep 2024 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ioPB8iUO"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78462C9D
	for <linux-can@vger.kernel.org>; Mon, 23 Sep 2024 08:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727079128; cv=none; b=kvUGjuIUP6euF/g0KLQ4tT9mNpo3RukY9HBDDSlCZx+imHsI0wwI2PMGelkl798uI4MgtdnCu6xp6btXBHwQlS8GASR38jEoM9ka20IXTwKouBhRUbWYfyeU4QwmRfLBkCp5suNmYMoSWtZ75Emvq3OoBfjH7PpYpHb7dWJTanw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727079128; c=relaxed/simple;
	bh=AiGF/8OSi083BWf/+PHyVvxx5NeIHzd+1QlsFeZZvwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQd5jHFoBg5sOZ24CEXsA9lRFI82HSlLU5cKIwAXkFXaKwFSeNalYSe6UWx0uB2BFrgseBzkkJYjzD013O/X+7fXl0nHzMAC/Q7wtIud18qHEKY8OBqVUoQrPH/P9NqTK5H7fumSeMULpm8a0g1Y019rngmzn413HreAzeaLD+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ioPB8iUO; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cb2191107so31594755e9.1
        for <linux-can@vger.kernel.org>; Mon, 23 Sep 2024 01:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727079123; x=1727683923; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3gjbHPJoKqedubSBXHd39Fm+ElqRQN46xlLk23QoYic=;
        b=ioPB8iUO4+ltjiuEUiU59nNxVhEFomooLfMRRmMh0+v07ULSd36wE0TGwAtF1IRRD7
         c4vPodGddYbPGFMckuhGmsBDgFWh8Ka0lbnk+6pPqZPhK7H7qyjxkK3W1ApLOR/BJwMs
         ReqmqCfKQjCjwsWOCX82fNsbm/y6NC3Z0MIs3dSEh86ppU2NQDXcVzMhtqxpouksJiEk
         gcFYd6hbYPX5gYlxR3hY9iWNjVhlRYsf+f2G3m07dEfw7Hg3kcb3XaTRQtTXSbei3XWQ
         His4TZnKjq7ayRtS/LvSfF3Sr2MyO+R4Wk95Vs+Vbvnxq8zId28sKaJo5m6lR++DpqSJ
         /LAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727079123; x=1727683923;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3gjbHPJoKqedubSBXHd39Fm+ElqRQN46xlLk23QoYic=;
        b=JdTy8Wpdvhpy8PX07UBdB0KB3mhZOv7lnt9Lj6JItKt2HoCtxwORxcBg71TI8wT9vF
         FaqmVUSVQdU1HWtHmUrbFhU27+Z2s0i5u34nceJv1NAGwlAvVzDafcyc9BOmkaLBmLzm
         xS86S8LPJI8/oPSm1O+Yj0qlT10jk1fkMa82yKOP5gXSAneuEBOHe3qYb4Pg6mWyQW2f
         VL/40wRHlETfTbI9AgrZmAXC4XWqbEBIHh+aU180LF+GWl2+XLWiwSbjuQcv5bZ8PWOG
         4e5EGOi6ovVD29JBAXp4uSay2h0nmraBm0E0o/S2Rezbz33o72zApn07J3OsdtkSV1+v
         L3bA==
X-Forwarded-Encrypted: i=1; AJvYcCWvqe7x4J+yjfu6AQrFAG0UUFX4GSo+ddYDy4R1UK/EaZ0F2queTRcw9fRwPethfmUu4voJgdmhblw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9q7Zm/9Kv+jPcQeEKvGR4tibgIgFqstht6TMLN7j3BsTVtU7k
	MYwqtI8/+/H5r39amJiV3DWo73SnUDP65g3JWLhpte5hOh3H2ksJNQs+lUWpcFU=
X-Google-Smtp-Source: AGHT+IFCTMzSYCRN9wyg4jJGEvRCfYk8ba3b68pLdJTZ5C4ZJFE06ZrWNcTI6lqNc3I+z/+RmQf/lA==
X-Received: by 2002:a05:600c:1c95:b0:42c:de2f:da27 with SMTP id 5b1f17b1804b1-42e7c15b393mr79858795e9.2.1727079122928;
        Mon, 23 Sep 2024 01:12:02 -0700 (PDT)
Received: from blmsp ([2001:4091:a245:8155:f78b:11e0:5100:a478])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e71f06a4sm23718726f8f.23.2024.09.23.01.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 01:12:02 -0700 (PDT)
Date: Mon, 23 Sep 2024 10:12:01 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>, "Felipe Balbi (Intel)" <balbi@kernel.org>, 
	Raymond Tan <raymond.tan@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@ew.tq-group.com
Subject: Re: [PATCH v2 1/2] can: m_can: set init flag earlier in probe
Message-ID: <zqk3dsg6qdr7nvul34cv5qygtrcq3h2kpwojr7e4nsbgvo2i6a@xbmfcgtb3uad>
References: <ac8c49fffac582176ba1899a85db84e0f5d5c7a6.1726745009.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac8c49fffac582176ba1899a85db84e0f5d5c7a6.1726745009.git.matthias.schiffer@ew.tq-group.com>

On Thu, Sep 19, 2024 at 01:27:27PM GMT, Matthias Schiffer wrote:
> While an m_can controller usually already has the init flag from a
> hardware reset, no such reset happens on the integrated m_can_pci of the
> Intel Elkhart Lake. If the CAN controller is found in an active state,
> m_can_dev_setup() would fail because m_can_niso_supported() calls
> m_can_cccr_update_bits(), which refuses to modify any other configuration
> bits when CCCR_INIT is not set.
> 
> To avoid this issue, set CCCR_INIT before attempting to modify any other
> configuration flags.
> 
> Fixes: cd5a46ce6fa6 ("can: m_can: don't enable transceiver when probing")
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
> 
> v2: no changes
> 
>  drivers/net/can/m_can/m_can.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 012c3d22b01dd..47481afb9add3 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1681,6 +1681,14 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
>  		return -EINVAL;
>  	}
>  
> +	/* Forcing standby mode should be redundant, as the chip should be in
> +	 * standby after a reset. Write the INIT bit anyways, should the chip
> +	 * be configured by previous stage.
> +	 */

Could you please update the comment to reflect your findings?

Best
Markus

> +	err = m_can_cccr_update_bits(cdev, CCCR_INIT, CCCR_INIT);
> +	if (err)
> +		return err;
> +
>  	if (!cdev->is_peripheral)
>  		netif_napi_add(dev, &cdev->napi, m_can_poll);
>  
> @@ -1732,11 +1740,7 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
>  		return -EINVAL;
>  	}
>  
> -	/* Forcing standby mode should be redundant, as the chip should be in
> -	 * standby after a reset. Write the INIT bit anyways, should the chip
> -	 * be configured by previous stage.
> -	 */
> -	return m_can_cccr_update_bits(cdev, CCCR_INIT, CCCR_INIT);
> +	return 0;
>  }
>  
>  static void m_can_stop(struct net_device *dev)
> -- 
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> https://www.tq-group.com/
> 

