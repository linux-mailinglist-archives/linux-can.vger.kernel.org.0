Return-Path: <linux-can+bounces-898-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B8991CBFF
	for <lists+linux-can@lfdr.de>; Sat, 29 Jun 2024 12:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA532829FD
	for <lists+linux-can@lfdr.de>; Sat, 29 Jun 2024 10:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1051D22086;
	Sat, 29 Jun 2024 10:02:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA628803
	for <linux-can@vger.kernel.org>; Sat, 29 Jun 2024 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719655327; cv=none; b=V/zYNT14rHCixLWmqBv2LLMFN07WwKYsZcfYx03uLysWZpzh6HavknhLL/hn6jLJUNOwxwpnX/M+x0F6dd5PSEBmYwkxtm/MnU+0SJ5/DzT8HLKh4oVP92IlTQm3QrCPdq4/Ak7bWOQKuhHi6mDdLGVJ+CIhV+Zg/Mrw+yEQ46o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719655327; c=relaxed/simple;
	bh=fa6ko9ytqedTjGXtS2LL7ZC0yIxXWTy99Esg3IHEFPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RtsFfxJ+Qx49vqkBhhUTpvBqSwDm+I1+YzhcjImpjv2QzTajhF2yQ2C5yJCbfOiAXLRapt2OeTycjiQtc0UOWTiKOd37M3GNQKDqukmLbI8wHW9ZO7CpiOZ6aJ2+ILqzFPb+4AQIl0kMYXoAo3WmB858y8J4J32CMRzG2xmthf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-706b14044cbso1126506b3a.2
        for <linux-can@vger.kernel.org>; Sat, 29 Jun 2024 03:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719655325; x=1720260125;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRaRpaV0Oa5WcihxIxK0jL4vArfe3mDFVnbBC2+IrVs=;
        b=aw2JA5diOkGKT6bQCwtK3xlMUOsaUch0vEUHeUIW5tzIVTaSaPTmJSFS40nD9AH/1Y
         I0pSQhoCNg9weARz//Lc7Dvz+GN8ApxiaFabhkXu4Ze8aS0IhbEY3D/38GvRcVAVmTr5
         zSDJlUrNi8IetpCq1l/Y1ACS78A25s+83wqu03WOpn4F82eL1qv8BcwCGnKQeltBpt/Y
         89I1UCivxewQkskLZtyOZH3R+Q8XqNx9207QVd95qSAPJcMIofV9uxH6Z5kxQPVd0+DJ
         NCsNPPoXiK4uXYM7u+AeeAH/227ZrUhKAjEEfqUvoqgSw182LIGRBzXdooO+cU+JGWxo
         C2ZQ==
X-Gm-Message-State: AOJu0Ywplbc9XQzLjmVa0lIPpB7HRTcIomeAUWG7ID1n9RPzrYEiaI4Y
	+S9VmdAqXcOUTFzQ4I6grEbKBFC3e4aWnq0JQpW828h0dzrRq3+MHRk2922JR8Bi5Bwi/D0ag1a
	IFMqFefqu/o6UkbltXszMzTbFMQE=
X-Google-Smtp-Source: AGHT+IExVD0eRKy/58QvnojR0GhRUTs/T7xKrvMzPKmI++saynHl94PxAEVxIbA1rjwzFxcVssivMCO5IYIGP1DUb/I=
X-Received: by 2002:a05:6a20:914f:b0:1bd:1a06:7ef3 with SMTP id
 adf61e73a8af0-1bef611e0admr695076637.3.1719655324846; Sat, 29 Jun 2024
 03:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628195514.316895-1-extja@kvaser.com> <20240628195514.316895-14-extja@kvaser.com>
In-Reply-To: <20240628195514.316895-14-extja@kvaser.com>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Sat, 29 Jun 2024 19:01:53 +0900
Message-ID: <CAMZ6RqKqpR+-UxYbM7kYxQF_+ECcEyH6_qDd2iK-uVagPh9hmQ@mail.gmail.com>
Subject: Re: [PATCH can-next 13/15] can: kvaser_usb: Remove KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP
To: Jimmy Assarsson <extja@kvaser.com>
Cc: linux-can@vger.kernel.org, Jimmy Assarsson <jimmyassarsson@gmail.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Sat. 29 June 2024 at 04:56, Jimmy Assarsson <extja@kvaser.com> wrote:
> Remove KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP, since all devices got
> hardware timestamp support.
>
> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
> ---
>  drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  1 -
>  .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 26 ++++++-------------
>  2 files changed, 8 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
> index 5552140c0869..9fa02d8f49f9 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
> @@ -41,7 +41,6 @@
>  #define KVASER_USB_QUIRK_HAS_SILENT_MODE       BIT(0)
>  #define KVASER_USB_QUIRK_HAS_TXRX_ERRORS       BIT(1)
>  #define KVASER_USB_QUIRK_IGNORE_CLK_FREQ       BIT(2)
> -#define KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP        BIT(3)
>
>  /* Device capabilities */
>  #define KVASER_USB_CAP_BERR_CAP                        0x01
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> index 576ddf932f47..a4f32d57173a 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> @@ -94,29 +94,26 @@
>  #define USB_MINI_PCIE_1XCAN_PRODUCT_ID 0x011B

(...)

>  static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leafimx = {
> -       .quirks = KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
> +       .quirks = 0,
>         .family = KVASER_LEAF,
>         .ops = &kvaser_usb_leaf_dev_ops,
>  };
> @@ -862,14 +858,8 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev, int channel)
>
>         netdev->flags |= IFF_ECHO;
>
> -       netdev->netdev_ops = &kvaser_usb_netdev_ops;

Ah, I missed this part. You can probably ignore this comment which I
made on patch 14:

  https://lore.kernel.org/linux-can/CAMZ6RqJ8dyc62Hj+ACV99BSuX3g3ARGCfY4HHUtiKmpmmotDJw@mail.gmail.com/

> -       if (driver_info->quirks & KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP) {
> -               netdev->netdev_ops = &kvaser_usb_netdev_ops_hwts;
> -               netdev->ethtool_ops = &kvaser_usb_ethtool_ops_hwts;
> -       } else {
> -               netdev->netdev_ops = &kvaser_usb_netdev_ops;
> -               netdev->ethtool_ops = &kvaser_usb_ethtool_ops;
> -       }
> +       netdev->netdev_ops = &kvaser_usb_netdev_ops_hwts;
> +       netdev->ethtool_ops = &kvaser_usb_ethtool_ops_hwts;
>         SET_NETDEV_DEV(netdev, &dev->intf->dev);
>         netdev->dev_id = channel;
>
> --
> 2.45.2
>
>

