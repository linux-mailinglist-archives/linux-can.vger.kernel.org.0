Return-Path: <linux-can+bounces-1060-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F59940AAA
	for <lists+linux-can@lfdr.de>; Tue, 30 Jul 2024 10:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 820ECB20A75
	for <lists+linux-can@lfdr.de>; Tue, 30 Jul 2024 08:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB874187853;
	Tue, 30 Jul 2024 08:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zYxW//c7"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D18718732A
	for <linux-can@vger.kernel.org>; Tue, 30 Jul 2024 08:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722326600; cv=none; b=I5buFTQmatnDfDy23UM2WdMc/FfceDBaxpJZqncZNp9pw7EkSWJjYy/Nm5LKhae1acdVYBeAAeLv4hG/0v8lW+GU6U6EW5p11w2J3I7In2Lac0TBYTYqRjmxzTwzyZDGTsr+MHB76WONi6mbgE5iEAidP7FsAaqofRoinbNEVAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722326600; c=relaxed/simple;
	bh=iuWYblVrWEcYjEApW9LadfLdS4sDSEmXkXM6DtnfauE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmVEPRQY6NuPBuA5SIzM6x8XcBBGncPTax9okvwXeRapDnOY6R9XElCVUJn7jECdtahCudGfjRopHSH9p3XqJ9h0SA1FgVZ3oV9dPPIiV4hvXhZng8E2JCG6tfY36trN7GRjW7UVrD/Loe/9v3GYV0OCtx/pX234oWKGCBbsUYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zYxW//c7; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7d26c2297eso515546666b.2
        for <linux-can@vger.kernel.org>; Tue, 30 Jul 2024 01:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722326597; x=1722931397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IW8uREygydh+WVjTZAsSKWiFN9QORIHrEaVyhDdLu/k=;
        b=zYxW//c7DavkfM2jUq/+lztt7wZejIAfhV1NlywNNbKESesuwc1iQ6ptPpjFvjgs8/
         wdG/zh9H54+2Ysa6IPbI5Fe9iFUnd6doo/eaCkXmE+o2qHaMwEwi+HPI++kxWZ/ttS/e
         jB90RdKMsRmS/inbQt9A6Uy+KcFflyCyoLg0n3W/1A1B2HGonjp/o+LLYQcGiaLL41O8
         9o1EglWnbx6LXCi8+DHTmI0G2fga5CmHq6DQARaveZW9kSQlGci1281FTUjIs8mBCGvd
         DZcRBf8ZVUNAUbc0GHWpO1bRiP3e3Xvm4y+WdH6CzB3juLC3VWfU+4i5VPHPSv4fauCn
         dPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722326597; x=1722931397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IW8uREygydh+WVjTZAsSKWiFN9QORIHrEaVyhDdLu/k=;
        b=tAcT4rvnVPdNy+8cMiwbLzPDy/BLyuw2K0YRUSIoCNtfzBv3cHNyxj5pr9/RjMHa6C
         d/H+i+BMGUKHFezaenY1sn4n1d+fvRPpNN/QCErb2s3cRCful0uFfCxjpQ0+0uqjkJvL
         i8exI99Aa+TZ+PrsIpykyz3E0LpxgHbvvyGGDtvpkqgg/jCfk4d2bDRwxiPBJ0/pOlzp
         Z8g9HEz+H7lsLqS/PLPr9FUKTysxIp13JfH6/xq/DLOjjYD2k3BI44QhrteKn3AxOgge
         ZAddoAKfG8UxFS2m+DwWKCoZcIRXZHzl5VUU5sVHGLCRfZMxHQQMK4NMwFML8V0SIq7t
         UzUA==
X-Forwarded-Encrypted: i=1; AJvYcCV9+iNpTbpEEMQWMHYoG3+ZdbqrDsX9idIzPsqAmaD6LA9orntkFtHTkfahl1iB23b9vs/KEeNR/EvcgcB3GjAHpNMZ4jbdzP7B
X-Gm-Message-State: AOJu0YzkUm4RMDtC3XHlF8CpyFHAbyVVP8iCrUKtorRKqjUbEbcc4hD7
	4lBK8pshqFk+cPHunp6Vh5CaFoZ2+GKsM7yEtBlzuS+MmeuGfrngHYz/73Gsgxk=
X-Google-Smtp-Source: AGHT+IHp79UTcVyLjWuURCqePUuU9tOenk4nhILiDVU7tLQdZVQRMJTykxJtWkHE+7nvROZn7E72ew==
X-Received: by 2002:a17:907:c50a:b0:a6f:1443:1e24 with SMTP id a640c23a62f3a-a7d40092ceamr690827666b.34.1722326596613;
        Tue, 30 Jul 2024 01:03:16 -0700 (PDT)
Received: from blmsp ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab2302dsm611162766b.39.2024.07.30.01.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 01:03:16 -0700 (PDT)
Date: Tue, 30 Jul 2024 10:03:14 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	Michal Kubiak <michal.kubiak@intel.com>, Vibhore Vardhan <vibhore@ti.com>, 
	Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, Conor Dooley <conor@kernel.org>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/7] can: m_can: Map WoL to device_set_wakeup_enable
Message-ID: <mtlhnjzgpaxmtd4lwesga6qlba7vukxuj2mwyc75d7u2ea7fei@4xjuh4pjys4x>
References: <20240729074135.3850634-1-msp@baylibre.com>
 <20240729074135.3850634-3-msp@baylibre.com>
 <15424d0f-9538-402f-bc5d-cdd630c7c5e9@lunn.ch>
 <20240729-blue-cockle-of-vigor-7d7670-mkl@pengutronix.de>
 <3d2a2b51-356f-4a9c-940e-df58be8d2cf3@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3d2a2b51-356f-4a9c-940e-df58be8d2cf3@lunn.ch>

Hi,

On Mon, Jul 29, 2024 at 09:37:56PM GMT, Andrew Lunn wrote:
> > > > +static void m_can_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
> > > > +{
> > > > +	struct m_can_classdev *cdev = netdev_priv(dev);
> > > > +
> > > > +	wol->supported = device_can_wakeup(cdev->dev) ? WAKE_PHY : 0;
> > > > +	wol->wolopts = device_may_wakeup(cdev->dev) ? WAKE_PHY : 0;
> > > > +}
> > > 
> > > It is nice to see Ethernet WoL mapped to CAN :-)
> > > 
> > > So will any activity on the CAN BUS wake the device? Or does it need
> > > to be addresses to this device?
> > 
> > Unless you have a special filtering transceiver, which is the CAN
> > equivalent of a PHY, CAN interfaces usually wake up on the first
> > message on the bus. That message is usually lost.
> 
> Thanks for the info. WAKE_PHY does seem the most appropriate then.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thank you.

Just to extend on Marc's explanation specifically for m_can:

For this very low power mode 'Partial-IO' the m_can IP is not active.
The m_can pins will trigger a wakeup for any activity. Also as the SoC
needs to do a normal boot, I would guess there are more messages lost
when waking up from Partial-IO. Other low power modes that will be
upstreamed in the future will not need as much time to be able to
receive CAN messages again.

Best
Markus


