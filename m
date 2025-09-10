Return-Path: <linux-can+bounces-4597-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC9AB50CF8
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 07:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C900D188F431
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 05:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06021DDDD;
	Wed, 10 Sep 2025 05:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNxMsK24"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8783C0C
	for <linux-can@vger.kernel.org>; Wed, 10 Sep 2025 05:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757480427; cv=none; b=I5ILNSzSj9To3R6N1be5IJ4dzcAJDyfeQZJkdmrV+jqRz4ZoOysfhKBW0+L5cQl+7jg+22BMPkW3HeMQ7RDLghKwm4DUVPim1K34Ixgpl7+aDvLPEMt0+MAgS82RSN7Jdz1jyx1TPXwrFBC6rkLD85P89UrAWJXlydLNyLwjLqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757480427; c=relaxed/simple;
	bh=zWW5HscU9TILRyX4THPEIQBWuQBRKkJ+5/iIvYICxRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gysD2jabfvMbxL00FpXRtO2AY3GYEEeI9bYZhXrpHOkMV6W50qyXLUEGhAlMKesKWFIBaHBCw6H6HUdx9nV2IvW8sFSjJKYen8Eb5EvenT7FMJ/wQWqqQo/ZcRgolfxavKwn2X/i8iwoBAybFl6VJDRZRXBi5ha7cLZtnPbVReQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNxMsK24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EE4C4CEF0
	for <linux-can@vger.kernel.org>; Wed, 10 Sep 2025 05:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757480427;
	bh=zWW5HscU9TILRyX4THPEIQBWuQBRKkJ+5/iIvYICxRA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DNxMsK24g1qMNeEhlsAzT/vAv19tvwC2BwFKzwM6JSwksbXhCq1LqbYZKGj+J+Jt4
	 8DDrdc5MsuDidAfHkJTEjemEbED7nhooXKPa9LnFXAbHE7IqGCT1BI3kNSTQqMgKsu
	 6zIIC7TUpI3n4ov/XOzBITsL1SYd+GmXQcKAWR4yzH0E0gBK4I97b0jn0+dHT61yJx
	 e+DrrB+W+jP3NVBstelxfAuvaJKBAHVDXvy8ffYex5WkrtKMN6j+wjo3wwB0f/2WjV
	 pGlREqZAvKx5EqGE0M234dPURmMBWmj9qwPmzbFd1bQMIO+eNp4fjjhxXZj6YL+rEN
	 CgqzmrZOij0rQ==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b046f6fb230so46163666b.1
        for <linux-can@vger.kernel.org>; Tue, 09 Sep 2025 22:00:27 -0700 (PDT)
X-Gm-Message-State: AOJu0YwEWI7oB1EK6xdd+lurbPUL0VFAUHry/tAb2ZqzlruNw/u5Jpzb
	y8Bck/oIFo2AYdSbzBd2Q51/ASHFTIxkqTtCE7F17JxCSxfI8zTenyVtBk67paLv9fiIGhT5bYy
	ROrtvK5RR3ruxwPTEqbK4D2hGTy+TPww=
X-Google-Smtp-Source: AGHT+IHp/LzYQRCRqaTcq16VeYk61ChBwrfe1UyyYkV2f1e09sNHwGV9EHqjirwCaREMDkIHpQCw4F4ezMDITXKlZ7g=
X-Received: by 2002:a17:907:6d0d:b0:b04:3b97:f972 with SMTP id
 a640c23a62f3a-b04b1dcb2bbmr1584735566b.3.1757480426061; Tue, 09 Sep 2025
 22:00:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909163702.17755-1-socketcan@hartkopp.net> <20250909163702.17755-2-socketcan@hartkopp.net>
In-Reply-To: <20250909163702.17755-2-socketcan@hartkopp.net>
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 10 Sep 2025 14:00:15 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqJyvSKLBNE1AY2bAhnOGOuVyi-N5mKKKuZWE+UFbUrUdg@mail.gmail.com>
X-Gm-Features: AS18NWB6qlSfo4-cGzIojDrp7OTmT5I8kFEjahMWQt3fUsiD-jVudNujywQsGYQ
Message-ID: <CAMZ6RqJyvSKLBNE1AY2bAhnOGOuVyi-N5mKKKuZWE+UFbUrUdg@mail.gmail.com>
Subject: Re: [RFC PATCH v6 2/2] can: reject CAN FD content when disabled on
 CAN FD/XL interfaces
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed. 10 Sep. 2025 at 01:37, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> The CAN XL devices can be configured as CAN XL only with 'xl on fd off'.
> Also CAN FD interfaces can be configured to only support CAN CC 'fd off'.
> Correctly reject CAN FD frames when FD is disabled for the outgoing CAN
> FD/XL interfaces.
>
> Virtual CAN interfaces (vcan, vxcan) are not affected as they have no such
> CAN CC/FD/XL content configuration option.
>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  include/linux/can/dev.h | 12 ++++++++++++
>  net/can/raw.c           | 12 +++++++-----
>  2 files changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 9a92cbe5b2cb..9fa139cc793e 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -183,10 +183,22 @@ struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
>  void free_candev(struct net_device *dev);
>
>  /* a candev safe wrapper around netdev_priv */
>  struct can_priv *safe_candev_priv(struct net_device *dev);
>
> +static inline bool can_dev_ctrlmode_fd_on(struct net_device *dev)

Nitpick: I would rather name this can_dev_fd_on() because this
function is meant to also work with virtual interfaces (seeing
ctrlmode in the name may fool the user into believing this is only for
"real" devices).

> +{
> +       struct can_priv *priv = safe_candev_priv(dev);
> +
> +       /* check ctrlmode on real CAN interfaces */
> +       if (priv)
> +               return (priv->ctrlmode & CAN_CTRLMODE_FD);
> +
> +       /* virtual CAN FD/XL interfaces always support CAN FD */
> +       return true;

Not always! It still requires the frame to fit in the MTU:

  dev->mtu == CANFD_MTU

> +}
> +
>  int open_candev(struct net_device *dev);
>  void close_candev(struct net_device *dev);
>  int can_change_mtu(struct net_device *dev, int new_mtu);
>  int can_eth_ioctl_hwts(struct net_device *netdev, struct ifreq *ifr, int cmd);
>  int can_ethtool_op_get_ts_info_hwts(struct net_device *dev,
> diff --git a/net/can/raw.c b/net/can/raw.c
> index e5e3952b0e09..d9df62e15ba4 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -879,24 +879,26 @@ static void raw_put_canxl_vcid(struct raw_sock *ro, struct sk_buff *skb)
>                 cxl->prio &= CANXL_PRIO_MASK;
>                 cxl->prio |= ro->tx_vcid_shifted;
>         }
>  }
>
> -static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb, int mtu)
> +static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb,
> +                                     struct net_device *dev)
>  {
>         /* Classical CAN -> no checks for flags and device capabilities */
>         if (can_is_can_skb(skb))
>                 return CAN_MTU;
>
> -       /* CAN FD -> needs to be enabled and a CAN FD or CAN XL device */
> +       /* CAN FD -> needs to be enabled in a CAN FD or CAN XL device */
>         if (ro->fd_frames && can_is_canfd_skb_mtu_len(skb) &&
> -           (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
> +           (dev->mtu == CANFD_MTU || can_is_canxl_dev_mtu(dev->mtu)) &&
> +           can_dev_ctrlmode_fd_on(dev))
>                 return CANFD_MTU;
>
>         /* CAN XL -> needs to be enabled and a CAN XL device */
>         if (ro->xl_frames && can_is_canxl_skb(skb) &&
> -           can_is_canxl_dev_mtu(mtu))
> +           can_is_canxl_dev_mtu(dev->mtu))
>                 return CANXL_MTU;
>
>         return 0;
>  }
>
> @@ -948,11 +950,11 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>                 goto free_skb;
>
>         err = -EINVAL;
>
>         /* check for valid CAN (CC/FD/XL) frame content */
> -       txmtu = raw_check_txframe(ro, skb, dev->mtu);
> +       txmtu = raw_check_txframe(ro, skb, dev);
>         if (!txmtu)
>                 goto free_skb;
>
>         /* only CANXL: clear/forward/set VCID value */
>         if (txmtu == CANXL_MTU)

So this is going in the right direction. More comments will follow in
my answer to the comments in the v5 thread.

