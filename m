Return-Path: <linux-can+bounces-3974-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C9AB03247
	for <lists+linux-can@lfdr.de>; Sun, 13 Jul 2025 19:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04164189BF90
	for <lists+linux-can@lfdr.de>; Sun, 13 Jul 2025 17:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EC3278142;
	Sun, 13 Jul 2025 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="h7RkGNKu"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (outm-52.smtpout.orange.fr [193.252.22.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABA6233701
	for <linux-can@vger.kernel.org>; Sun, 13 Jul 2025 17:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752427587; cv=none; b=T7/TS8L9C06gUa/gl6eACwyn4q6y3ZO24PX0CjsnfpMfKGYO+pQMRsHw3RzlksJ99aOf7lv1SfxJckTR5V/nI025YFZ0jZgJGLib6AGgwsGB1BXXq3pdJiDvPWl8WpCG1kw2y6epHXY+QHT2U9dJf6Oo0TvDyEJU9oU19eov72g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752427587; c=relaxed/simple;
	bh=QTqHJ1fzT6ogz5KuAK+NDziAPNgDsmOBCSVZJbGKZII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0+a0IF/3H6OANfO6G/uf5bw+KTHa/O7eGIQsH9UxhMtcag6nF0x01xygXVPcYERKDA6j4ksID6uTfPsCcsenxE2RFtyNGL8lUrNAB7GbkAYjMTmMhvVk/pEtm9oJvxSegIVE0DrKTV7dD1S+lHUeqRx9gQrAyE6NbbngBUeh4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=h7RkGNKu; arc=none smtp.client-ip=193.252.22.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ed1-f44.google.com ([209.85.208.44])
	by smtp.orange.fr with ESMTPA
	id b0RsupdfAMAoVb0Rsu4VBp; Sun, 13 Jul 2025 19:25:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1752427513;
	bh=biZ7R+eMPWO3eA8Ia2/YTqoSJKy51T6s9rsfM/FtXQ4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=h7RkGNKuHa1L6vtSvXOJaztdMpF59hpDabX7/VuLEueDcefEE3Bl2APQrmA4RiPXB
	 ZBVUn6vJVAOtX3JYnGP9vAtOIzxpdlT8UQhV0xBsh9Faxp3zOaR1TNAndiU2gkm6QX
	 EMQHIzX5GUiZVj+F8bBBrmxJ7W7EXRs4n7w4JRlyp6BdXzPFvMfeqiEk1Mip99bqMf
	 s6prVWihum57gxzMgbQCfHu7hu5kKmrYfuNFf07ewx2WhYDxsPZ835vmvt1n4TlKYT
	 xt9O6vras6bo+O9VPFXGdNamFvaC0GkglgCegSnpMO94+cvZ6vtE8Ll6LO/rKMfDtM
	 xMnseXv4ssI8g==
X-ME-Helo: mail-ed1-f44.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sun, 13 Jul 2025 19:25:13 +0200
X-ME-IP: 209.85.208.44
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60cc11b34f6so8215033a12.0
        for <linux-can@vger.kernel.org>; Sun, 13 Jul 2025 10:25:12 -0700 (PDT)
X-Gm-Message-State: AOJu0YwbOydsB5g7P9Id/+iS/eA2iuRTknItbok3jwEDzSKYn55U75tq
	W/StFvmWnmDdtwuiWwhpHwLxBhW7QujoCLtbJgwkodlCu/Mmtjgb0CIMbFKeBwXDI/nXI8hBU9E
	LSAGrJpjvTgz2TOCDlZw7CMTlXsYb7wk=
X-Google-Smtp-Source: AGHT+IFRwc5+Ti8LkglI328sgEiR0XeUHTYrrUvyj1XZ02ssKz9IBuGUbZX9FjwvaSPonLG4I+cPeG8ZilbH8IIYO2A=
X-Received: by 2002:a17:907:2d20:b0:ae6:d48e:f18d with SMTP id
 a640c23a62f3a-ae6e22e3f73mr1560342966b.12.1752427512620; Sun, 13 Jul 2025
 10:25:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250706133550.47369-1-socketcan@hartkopp.net> <20250706133550.47369-2-socketcan@hartkopp.net>
In-Reply-To: <20250706133550.47369-2-socketcan@hartkopp.net>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Mon, 14 Jul 2025 02:25:01 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqJaYY_ZDOo-V_+4mDPZvp0WU4K=iWL44sd0_hYhMLOP_A@mail.gmail.com>
X-Gm-Features: Ac12FXwoM0Erk9o4ebsnMn69rBPoiGKftE2mUGb8FPI8Ikl8kRKRDBUQ06KzUFQ
Message-ID: <CAMZ6RqJaYY_ZDOo-V_+4mDPZvp0WU4K=iWL44sd0_hYhMLOP_A@mail.gmail.com>
Subject: Re: [PATCH can-next/b4 2/2] dummyxl: print ctrlmode and PWM values
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun. 6 juil. 2025 at 22:36, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

(...)

> -static void dummyxl_print_config(struct net_device *dev)
> +static void dummyxl_print_ctrlmode(struct net_device *dev)
>  {
>         struct dummyxl_priv *priv = netdev_priv(dev);
>         struct can_priv *can_priv = &priv->can;
> +       char opts[300] = { 0 };
>
>         netdev_info(dev, "CAN control mode/supported : %08X/%08X\n",
>                     can_priv->ctrlmode, can_priv->ctrlmode_supported);
> +
> +       if (can_priv->ctrlmode & CAN_CTRLMODE_LOOPBACK)
> +               strcat(opts, " loopback");
> +
> +       if (can_priv->ctrlmode & CAN_CTRLMODE_LISTENONLY)
> +               strcat(opts, " listen-only");
> +
> +       if (can_priv->ctrlmode & CAN_CTRLMODE_3_SAMPLES)
> +               strcat(opts, " triple-sampling");
> +
> +       if (can_priv->ctrlmode & CAN_CTRLMODE_ONE_SHOT)
> +               strcat(opts, " one-shot");
> +
> +       if (can_priv->ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
> +               strcat(opts, " berr-reporting");
> +
> +       if (can_priv->ctrlmode & CAN_CTRLMODE_FD)
> +               strcat(opts, " fd");
> +
> +       if (can_priv->ctrlmode & CAN_CTRLMODE_PRESUME_ACK)
> +               strcat(opts, " presume-ack");
> +
> +       if (can_priv->ctrlmode & CAN_CTRLMODE_FD_NON_ISO)
> +               strcat(opts, " fd-non-iso");
> +
> +       if (can_priv->ctrlmode & CAN_CTRLMODE_CC_LEN8_DLC)
> +               strcat(opts, " cc-len8-dlc");
> +
> +       if (can_priv->ctrlmode & CAN_CTRLMODE_TDC_AUTO)
> +               strcat(opts, " tdc-mode-auto");
> +       else if (can_priv->ctrlmode & CAN_CTRLMODE_TDC_MANUAL)
> +               strcat(opts, " tdc-mode-manual");
> +       else
> +               strcat(opts, " tdc-mode-off");
> +
> +       if (can_priv->ctrlmode & CAN_CTRLMODE_XL)
> +               strcat(opts, " xl");
> +
> +       if (can_priv->ctrlmode & CAN_CTRLMODE_XL_TDC_AUTO)
> +               strcat(opts, " xltdc-mode-auto");
> +       else if (can_priv->ctrlmode & CAN_CTRLMODE_XL_TDC_MANUAL)
> +               strcat(opts, " xltdc-mode-manual");
> +       else
> +               strcat(opts, " xltdc-mode-off");
> +
> +       if (can_priv->ctrlmode & CAN_CTRLMODE_XL_RRS)
> +               strcat(opts, " xlrrs");
> +
> +       if (can_priv->ctrlmode & CAN_CTRLMODE_XL_TRX)
> +               strcat(opts, " xltrx");
> +
> +       if (can_priv->ctrlmode & CAN_CTRLMODE_XL_ERR_SIGNAL)
> +               strcat(opts, " xlerrsig");

I am not a big fan of having a fixed length buffer and then doing
several strcat() on it. I rewrote it as below:

  static void dummyxl_print_ctrlmode(struct net_device *dev)
  {
          static const char *names[] = {
                  [ilog2(CAN_CTRLMODE_LOOPBACK)] = "loopback",
                  [ilog2(CAN_CTRLMODE_LISTENONLY)] = "listen-only",
                  [ilog2(CAN_CTRLMODE_3_SAMPLES)] = "triple-sampling",
                  [ilog2(CAN_CTRLMODE_ONE_SHOT)] = "one-shot",
                  [ilog2(CAN_CTRLMODE_BERR_REPORTING)] = "berr-reporting",
                  [ilog2(CAN_CTRLMODE_FD)] = "fd",
                  [ilog2(CAN_CTRLMODE_PRESUME_ACK)] = "presume-ack",
                  [ilog2(CAN_CTRLMODE_FD_NON_ISO)] = "fd-non-iso",
                  [ilog2(CAN_CTRLMODE_CC_LEN8_DLC)] = "cc-len8-dlc",
                  [ilog2(CAN_CTRLMODE_TDC_AUTO)] = "fd-tdc-auto",
                  [ilog2(CAN_CTRLMODE_TDC_MANUAL)] = "fd-tdc-manual",
                  [ilog2(CAN_CTRLMODE_XL)] = "xl",
                  [ilog2(CAN_CTRLMODE_XL_TDC_AUTO)] = "xl-tdc-auto",
                  [ilog2(CAN_CTRLMODE_XL_TDC_MANUAL)] = "xl-tdc-manual",
                  [ilog2(CAN_CTRLMODE_XL_RRS)] = "xl-rrs",
                  [ilog2(CAN_CTRLMODE_XL_TRX)] = "xl-trx",
                  [ilog2(CAN_CTRLMODE_XL_ERR_SIGNAL)] = "xl-err-signal",
                  [ilog2(CAN_CTRLMODE_XL_PWM)] = "pmw",
          };
          struct dummyxl *priv = netdev_priv(dev);
          unsigned long ctrlmode = priv->can.ctrlmode;

          netdev_info(dev, "Control modes: 0x%08lx\n", ctrlmode);

          if (ctrlmode) {
                  u32 idx;

                  netdev_info(dev, "\tlist:");
                  for_each_set_bit(idx, &ctrlmode, ARRAY_SIZE(names))
                          netdev_info(dev, "\t\t%s\n", names[idx]);

                  if (ctrlmode >= BIT(ARRAY_SIZE(names)))
                          netdev_info(dev, "\tunknown: 0x%08lx\n",
                                      ctrlmode &
                                      ~(BIT(ARRAY_SIZE(names)) - 1));
          }
  }

It is a bit more concise and more scalable (if you forgot to update
the table, you still get the hexadecimal value listed under
"unknown").

> +       netdev_info(dev, "Enabled modes:%s\n", opts);
> +       netdev_info(dev, " \n");
> +}

I am moving forward with the PWM. Contrary to the last month which was
extra busy, I finally managed to liberate some time. I still need some
debugging here and there, I will keep you posted :)


Yours sincerely,
Vincent Mailhol

