Return-Path: <linux-can+bounces-4542-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0799EB4A246
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 08:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE280188B3FB
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 06:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F081DE3B7;
	Tue,  9 Sep 2025 06:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogMr2WjH"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E7A18A93F
	for <linux-can@vger.kernel.org>; Tue,  9 Sep 2025 06:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757399502; cv=none; b=NTbqdyUwy1jbPA9cWF5TbN9fPtOFgaHs8w8zmEmSVxlMQ5FlkwHVssFT/5NZOExwzFI2+Ubz0P3sp1OVUqAsrMAPwOvFqRaN0mUOge+uecN2TsIcA/plCWtooKD3m5qrTyKmsRoDl1sK9cNm7AokSftJscE3L2tmMwQjzY8XU5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757399502; c=relaxed/simple;
	bh=T9qD8fcCWSk2WNmBPbTKUJuD4tm6i/8MV07OuS3awoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JgxGP34WfurZsIXNJA5eyfBWgtjeZEX4HAG9npwBETAfEH6b7XtTNYWzr1Vl6b+w8f9ErlahBlmLPHa4qgl/mv6tg75lT5Ju2eYn2d7sCQ57KRP+z5EfNkgfYePAetvP4odPt/kw++kY22iXfODFeIrIRCJdq93LuzZdDMVvmwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogMr2WjH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD48C4CEF4
	for <linux-can@vger.kernel.org>; Tue,  9 Sep 2025 06:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757399502;
	bh=T9qD8fcCWSk2WNmBPbTKUJuD4tm6i/8MV07OuS3awoQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ogMr2WjHjBFYLafYBxjIZC7uim+7UzGqek6fySEzI5P9PAW86OdT1K7W4a05w/5+L
	 WpP0T/GTf9mecXNbN/FafADZ+hV3eiYPshvH4rCaYIJddOv1LQM7b9C0kLl1V9ErCX
	 q8TpHDeVZxlZpIfjbCfvDYLAKErm25JnIgo6cRPQ/557a/e/CXZhlaMQE/iV45ptKF
	 9Jbk/z3YO+BnRTiPV4O/ZhbZkuViv3QmEd7H9KEs8Pb/+Ds6IDie3VK7Xhyvy1llr5
	 6NU9rZ33hoXSxrnmciklJzT59yA7fCutZe3nhxjdmh9cYtYYK9lRDhbRKZwfPl6Szr
	 DK9yJFff+9W1w==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b043a33b060so823891866b.1
        for <linux-can@vger.kernel.org>; Mon, 08 Sep 2025 23:31:42 -0700 (PDT)
X-Gm-Message-State: AOJu0Yze/KSM2Jkbc4DYbi3XLxqz5CCadpUXUgTOuxB2jEefdpG9erAM
	2/9bW+frDjtwGaArg5mwi1O6g5OJQUokWPypPnTUVDW+TavrfHPAxfvBCXgT57LJfbQajUxm/Lm
	kooK7FqbQnDe8up1pC5uU3ganZ84D1lg=
X-Google-Smtp-Source: AGHT+IF6d69wRlOBHyqQ1FZYVp2vF1LR4lPBk87/ehMNMDqTtkU0TAwWJaB+CDlDejFC3SQG9GeW4L6qESVoc0IQeUY=
X-Received: by 2002:a17:907:7e91:b0:b04:e44:4598 with SMTP id
 a640c23a62f3a-b04b140e19emr1085206566b.14.1757399501022; Mon, 08 Sep 2025
 23:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908184512.78449-1-socketcan@hartkopp.net> <20250908184512.78449-2-socketcan@hartkopp.net>
In-Reply-To: <20250908184512.78449-2-socketcan@hartkopp.net>
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 9 Sep 2025 15:31:29 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqLY6a2wd=xdBLx16YmhafawWCW2tV0Wzj4oRJJJ15Vfzg@mail.gmail.com>
X-Gm-Features: Ac12FXzPqq_Lb2JVXO3uSAbrGBs9YMlIyn3zg6XQO_YlsapL3Ob1sz_0kiQzCw4
Message-ID: <CAMZ6RqLY6a2wd=xdBLx16YmhafawWCW2tV0Wzj4oRJJJ15Vfzg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/2] can: support XL only content on real CAN XL interfaces
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue. 9 Sep. 2025 at 03:48, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> The CAN XL devices can be configured as CAN XL only with 'xl on fd off'
> which is currently not supported as the CAN XL sockopt on the CAN_RAW
> socket implicitly enables CAN FD support.
>
> This patch removes this XL/FD connection for real CAN XL interfaces and
> rejects CAN FD content on CAN XL interfaces with 'fd off'.
>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  include/linux/can/dev.h | 12 ++++++++++++
>  net/can/raw.c           | 32 ++++++++++++++------------------
>  2 files changed, 26 insertions(+), 18 deletions(-)
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
> +{
> +       struct can_priv *priv = safe_candev_priv(dev);
> +
> +       /* check ctrlmode on real CAN interfaces */
> +       if (priv)
> +               return (priv->ctrlmode & CAN_CTRLMODE_FD);
> +
> +       /* virtual CAN FD/XL interfaces always support CAN FD */
> +       return true;
> +}
> +
>  int open_candev(struct net_device *dev);
>  void close_candev(struct net_device *dev);
>  int can_change_mtu(struct net_device *dev, int new_mtu);
>  int can_eth_ioctl_hwts(struct net_device *netdev, struct ifreq *ifr, int cmd);
>  int can_ethtool_op_get_ts_info_hwts(struct net_device *dev,
> diff --git a/net/can/raw.c b/net/can/raw.c
> index f48b1f3fd6e8..6cd1f9cb050d 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -558,11 +558,10 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>         struct raw_sock *ro = raw_sk(sk);
>         struct can_filter *filter = NULL;  /* dyn. alloc'ed filters */
>         struct can_filter sfilter;         /* single filter */
>         struct net_device *dev = NULL;
>         can_err_mask_t err_mask = 0;
> -       int fd_frames;
>         int count = 0;
>         int err = 0;
>
>         if (level != SOL_CAN_RAW)
>                 return -EINVAL;
> @@ -698,33 +697,25 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>                         return -EFAULT;
>
>                 break;
>
>         case CAN_RAW_FD_FRAMES:
> -               if (optlen != sizeof(fd_frames))
> +               if (optlen != sizeof(ro->fd_frames))
>                         return -EINVAL;
>
> -               if (copy_from_sockptr(&fd_frames, optval, optlen))
> +               if (copy_from_sockptr(&ro->fd_frames, optval, optlen))
>                         return -EFAULT;
>
> -               /* Enabling CAN XL includes CAN FD */
> -               if (ro->xl_frames && !fd_frames)
> -                       return -EINVAL;
> -
> -               ro->fd_frames = fd_frames;
>                 break;
>
>         case CAN_RAW_XL_FRAMES:
>                 if (optlen != sizeof(ro->xl_frames))
>                         return -EINVAL;
>
>                 if (copy_from_sockptr(&ro->xl_frames, optval, optlen))
>                         return -EFAULT;
>
> -               /* Enabling CAN XL includes CAN FD */
> -               if (ro->xl_frames)
> -                       ro->fd_frames = ro->xl_frames;
>                 break;

I think this is a UAPI breaking change. Any previous code which would
have only set CAN_RAW_XL_FRAMES to implicitly also set
CAN_RAW_FD_FRAMES would now break. I think it is an acceptable
compromise, but, at least, we should make it crystal clear in the
patch description that this is an UAPI breakage and clarify what the
impacts are for the end user.

>         case CAN_RAW_XL_VCID_OPTS:
>                 if (optlen != sizeof(ro->raw_vcid_opts))
>                         return -EINVAL;
> @@ -879,24 +870,29 @@ static void raw_put_canxl_vcid(struct raw_sock *ro, struct sk_buff *skb)
>                 cxl->prio &= CANXL_PRIO_MASK;
>                 cxl->prio |= ro->tx_vcid_shifted;
>         }
>  }
>
> -static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb, int mtu)
> +static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb, struct net_device *dev)
>  {
>         /* Classical CAN -> no checks for flags and device capabilities */
>         if (can_is_can_skb(skb))
>                 return CAN_MTU;
>
> -       /* CAN FD -> needs to be enabled and a CAN FD or CAN XL device */
> -       if (ro->fd_frames && can_is_canfd_skb_set_fdf(skb) &&
> -           (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
> -               return CANFD_MTU;
> +       /* CAN FD -> needs to be enabled in a CAN FD or CAN XL device */
> +       if (ro->fd_frames && can_is_canfd_skb_set_fdf(skb)) {
> +               /* real/virtual CAN FD interface */
> +               if (dev->mtu == CANFD_MTU)
> +                       return CANFD_MTU;
> +               if (can_is_canxl_dev_mtu(dev->mtu) &&
> +                   can_dev_ctrlmode_fd_on(dev))
> +                       return CANFD_MTU;
> +       }
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
> @@ -948,11 +944,11 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
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

