Return-Path: <linux-can+bounces-6115-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F967D14737
	for <lists+linux-can@lfdr.de>; Mon, 12 Jan 2026 18:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F6B53016707
	for <lists+linux-can@lfdr.de>; Mon, 12 Jan 2026 17:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5E329BDAB;
	Mon, 12 Jan 2026 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cV259BDL"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B881F36AB6B
	for <linux-can@vger.kernel.org>; Mon, 12 Jan 2026 17:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768239848; cv=none; b=Uf4yIxsscgsVh7OI6mcPpVX/aRX5rsBdOVNlh03vsKTlP73JSRgZ9A4faVhdREfYDiYhntdkULQL1vzfOP+7Rt85iznkuuZctlKzzZRTX+gOSxdD9FRhkziucmw/H3O3uMXHKPL5MzYoTjJpwwsj4IbptKK58RQjJ6vxW+7iogM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768239848; c=relaxed/simple;
	bh=ckuWa0hcl9zBmOGgxyGXZh35WwzxE05Qj5kMhP0yefE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q8aKWEd5DpZ6jBbam3eaD6Ks6PM37I7OZROvhuMQauL6AIIZTVIc+gJVex4eJ5zATabYo75Rv8+0NfSoHUrSrBUBC7mdhAQCM/Gwp362NYuxnEWzKf6gbID56F8En4yYfMQmNhKkyNFMejJPmF/zXVK4k67MgBUI/EoVTSFQz6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cV259BDL; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c026e074373so3157703a12.1
        for <linux-can@vger.kernel.org>; Mon, 12 Jan 2026 09:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768239846; x=1768844646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2PM847sZezm8qMDrlA/C+aIUOustWEHzoWUNlVlTog=;
        b=cV259BDLgViihtUr2aR3BuHi6K4wmrQYwTB9kVf0dCgpR6/T2/ERG5dtfBIPPYoOBV
         xEpChRBk7rhwcUq4nmQswDnxY5Dn7FZ0uDsduTvYZDkRQsMLdNK9LKDu8mhioNwQnto/
         05fqH3dgMy9Bh66c1jZnO8TeznUI3yjhQTwygi9M5IacgHi/HZhBC0ED/cboA7dr0aQF
         KthJvg1oygumppuOSzo+fa68mNqsxBNHDViEiQHS2z0Ov583/LGjLbH4N6T8yTlFb5rP
         JQzPoNlPVoH1ExFTxyS3ul3tSYsWgYSV9YU2Ga6jP5R0UStserkWkXQWrYP/Q0Cwr1ei
         FJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768239846; x=1768844646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R2PM847sZezm8qMDrlA/C+aIUOustWEHzoWUNlVlTog=;
        b=MQ0NyicZqJ/Oj/ClE75TX5NOqCnVPoV5y7fTaeXXxHY3PPrixCqhxYKP5KPg5g8uT1
         E+vHmwud/lCW7QRWtx+JKcusSeOKUCjveQHuj3uF8Xm6LUs+xTJ4UsDOrurZLwB355WB
         xvMyUOyGmgqHKeMb+OaEdOfWG0RsiZCKRxE7pPkozNLBro+KxaD9FkvnQc0lS5QeX6PZ
         lCXExa2KzZG3LavaZtttDST7arJrVTVZw16YYpshMWfC08emVFPjZAWkqQZSLa85y9jK
         xIMGqCoVrjPSL5VjLPobMPh75Yy/YOVeaHL1HvBwnu3nuD7Pszy6jllCBVFTsY4A1WPW
         JDAw==
X-Forwarded-Encrypted: i=1; AJvYcCXlFaUgbxBviysJWfid5xtJQ3DBbKkkYHwRgBOS9dfGNn1Gr0wplYjLKNXMA7/7xjEzoePD95HRi5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+89guGWP/Dz6GVgZb3/P/5pYG6/s6iJz9McNyUmetu11CSqtU
	IzvAl1cnxatoO2ers1RJHknl4gWBrZp4wx1wQD4xsNutWcHiPEIfkcZX
X-Gm-Gg: AY/fxX4Bj3gyKuwxKrUy6QXrgve+KsJ1gLTuXMPSOhLslhmBVlJjwv9zrI+e/ohtmzJ
	9YooDPNncZhL8veZLc6Ey0rJTsh/NDqsADdO2iIHPpb7QTiLpjmqPTOtCIAZtIwIsDmb80FAJE/
	lnnVt+rutVU4qIFxuBOipe20bIqJVtukXqgi3v4s+ouP5rIoDsGr2U48xh4h8nWy5omUgEctOo5
	lNSx2G2M3jMw4iHS04+cxmjnl30iNnUyxr1/wBVN87hUrkyVBMFWzvY7wQ2kNbYwXoRwDue7vsc
	dYhIdIsNtb3j2TVkZ0ETeV3X8eDrdqFBBxHDchUog5RQ13Gjh4CZ1Re+rSBhf5dKJ4Sm5x1TZFR
	wcfY2If36msrA0oFweAZz3fawE9obRT12VQhxM3VqrRuZZtmj4tOgGq1JPTDal9iSkki+nBoY6k
	gT4u3aXpVmaCKKd+b0
X-Google-Smtp-Source: AGHT+IGowUCnuSiMnioYOycVMCYNDWoins5qO8gM9NE7dzQF7NX5CSOPcjCucNoQ3IUz8H4VDDdlYQ==
X-Received: by 2002:a17:90b:1e05:b0:32e:528c:60ee with SMTP id 98e67ed59e1d1-34f68c00a7fmr18286724a91.24.1768239845962;
        Mon, 12 Jan 2026 09:44:05 -0800 (PST)
Received: from rakuram-MSI ([2405:201:d027:f096:5c52:f599:118c:bed2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c57a50da1a7sm7310733a12.36.2026.01.12.09.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 09:44:05 -0800 (PST)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: mailhol@kernel.org
Cc: corbet@lwn.net,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mkl@pengutronix.de,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	rakuram.e96@gmail.com,
	socketcan@hartkopp.net
Subject: Re: [PATCH 1/2] can: dummy_can: add CAN termination support
Date: Mon, 12 Jan 2026 23:13:55 +0530
Message-ID: <20260112174356.10358-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: d058f82b-2e2f-4353-8518-2cc9e15f7a98@kernel.org
References: <d058f82b-2e2f-4353-8518-2cc9e15f7a98@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 1 Jan 2026 at 17:42, Vincent Mailhol <mailhol@kernel.org> wrote:
>
> On 31/12/2025 at 19:13, Rakuram Eswaran wrote:
> > Add support for configuring bus termination in the dummy_can driver.
> > This allows users to emulate a properly terminated CAN bus when
> > setting up virtual test environments.
> >
> > Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
> > ---
> > Tested the termination setting using below iproute commands:
> >
> >   ip link set can0 type can termination 120
> >   ip link set can0 type can termination off
> >   ip link set can0 type can termination potato
> >   ip link set can0 type can termination 10000
> >  
> >  drivers/net/can/dummy_can.c | 25 +++++++++++++++++++++++--
> >  1 file changed, 23 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/can/dummy_can.c b/drivers/net/can/dummy_can.c
> > index 41953655e3d3c9187d6574710e6aa90fc01c92a7..418d9e25bfca1c7af924ad451c8dd8ae1bca78a3 100644
> > --- a/drivers/net/can/dummy_can.c
> > +++ b/drivers/net/can/dummy_can.c
> > @@ -86,6 +86,11 @@ static const struct can_pwm_const dummy_can_pwm_const = {
> >       .pwmo_max = 16,
> >  };
> >
> > +static const u16 dummy_can_termination_const[] = {
> > +     CAN_TERMINATION_DISABLED,       /* 0 = off */
> > +     120,                            /* 120 Ohms */
>
> Nitpick: no need to explain that disabled means "off", the first comment
> can be removed. Also, to be consistent with how the can.bitrate_max and
> can.clock.freq are declared, you can add the unit just next to the value.
>
>         static const u16 dummy_can_termination_const[] = {
>                 CAN_TERMINATION_DISABLED,
>                 120 /* Ohms */,
>         };
>
> (above comment is notwithstanding).
>

Yes, this looks better. 

> > +};
> > +
> >  static void dummy_can_print_bittiming(struct net_device *dev,
> >                                     struct can_bittiming *bt)
> >  {
> > @@ -179,6 +184,16 @@ static void dummy_can_print_bittiming_info(struct net_device *dev)
> >       netdev_dbg(dev, "\n");
> >  }
> >
> > +static int dummy_can_set_termination(struct net_device *dev, u16 term)
> > +{
> > +     struct dummy_can *priv = netdev_priv(dev);
> > +
> > +     netdev_dbg(dev, "set termination to %u Ohms\n", term);
> > +     priv->can.termination = term;
> > +
> > +     return 0;
> > +}
> > +
> >  static int dummy_can_netdev_open(struct net_device *dev)
> >  {
> >       int ret;
> > @@ -243,17 +258,23 @@ static int __init dummy_can_init(void)
> >       dev->ethtool_ops = &dummy_can_ethtool_ops;
> >       priv = netdev_priv(dev);
> >       priv->can.bittiming_const = &dummy_can_bittiming_const;
> > -     priv->can.bitrate_max = 20 * MEGA /* BPS */;
> > -     priv->can.clock.freq = 160 * MEGA /* Hz */;
>
> Don't add unrelated changes to your patch. Your patch should do one
> thing (here: add the resistance termination). If you want to reorder the
> existing lines, that should go in a separate clean-up patch. But here,
> there is no need to touch those lines, so just drop this reorder.
>

Ack. I will revert these unrelated changes.

> >       priv->can.fd.data_bittiming_const = &dummy_can_fd_databittiming_const;
> >       priv->can.fd.tdc_const = &dummy_can_fd_tdc_const;
> >       priv->can.xl.data_bittiming_const = &dummy_can_xl_databittiming_const;
> >       priv->can.xl.tdc_const = &dummy_can_xl_tdc_const;
> >       priv->can.xl.pwm_const = &dummy_can_pwm_const;
> > +     priv->can.bitrate_max = 20 * MEGA /* BPS */;
> > +     priv->can.clock.freq = 160 * MEGA /* Hz */;
> > +     priv->can.termination_const_cnt = ARRAY_SIZE(dummy_can_termination_const);
> > +     priv->can.termination_const = dummy_can_termination_const;
> > +
> >       priv->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
> >               CAN_CTRLMODE_FD | CAN_CTRLMODE_TDC_AUTO |
> >               CAN_CTRLMODE_RESTRICTED | CAN_CTRLMODE_XL |
> >               CAN_CTRLMODE_XL_TDC_AUTO | CAN_CTRLMODE_XL_TMS;
> > +
> > +     priv->can.do_set_termination = dummy_can_set_termination;
> > +
> >       priv->dev = dev;
> >
> >       ret = register_candev(priv->dev);
>
> Aside from the above remark this is OK. Please send a v2 with that last
> remark addressed. You can also add my review tag:
>
> Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
>

Thanks, Vincent. I will make the change as mentioned above and send v2.

Best Regards,
Rakuram

