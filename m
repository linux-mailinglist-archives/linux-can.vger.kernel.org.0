Return-Path: <linux-can+bounces-5752-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5012CC90100
	for <lists+linux-can@lfdr.de>; Thu, 27 Nov 2025 20:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B1C24E423D
	for <lists+linux-can@lfdr.de>; Thu, 27 Nov 2025 19:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A8B306B3B;
	Thu, 27 Nov 2025 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbcWqHYk"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791BE3064BD
	for <linux-can@vger.kernel.org>; Thu, 27 Nov 2025 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764273002; cv=none; b=lZF/uVdFZrXewmESMvHof6hHFh3rSSBlpgtHqZW/nHvEQ50Ilh4WkL6Qezt0M4SaEvLRXVPiDP0L+b9iHn+chDl48IrQj94mmv33r25DeThJ/9CjfER+Qr/y+hRoHX+IVttTQbvZAw9WbegYkEUkIbdvRydBpbfD8AhpVr0SdvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764273002; c=relaxed/simple;
	bh=lR9j9VT5xySqV1WcTa7e8GksGr9IJ0vstDJkfrppDck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JvPp9dPdiBrxUDXgCBrdt+4tm3lChXgdFkJJEl/44+pFxitcZMfRLjWg5lcqFnZdcmgUXrVcFhxNEHUktPoOR/ZrVh3tKvb+yIwdWpHuTaGIhQjbAorTWkNVxiF4YUA3P5iNd5Vzz7s99jrXtT5/11pn3atkHClJ4dOjgBuyb5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbcWqHYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E683C4AF09
	for <linux-can@vger.kernel.org>; Thu, 27 Nov 2025 19:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764273002;
	bh=lR9j9VT5xySqV1WcTa7e8GksGr9IJ0vstDJkfrppDck=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rbcWqHYkQWWlGJxr7PXS3uW4F0v4cFBVOzWvjqqFsNo4P65xQgBkWq6x0ifAVFUWB
	 4JVXMTT4YdT5RIQzJUgczM2c4wZH2scBL6EcApcAvSmqVkBE2fY6EQk9+vhlZVPhi0
	 d1VATFQyaSh9d/+C/zxowQF8MhntPdxfaxF0DqP7XiQBM2hVhce8BC31QeXhz+Z16d
	 HXzrcBf4J6rJJNIiptkaXtkXoWfvu0Kz4FYn4xgg/p+LQas5KkYIXsBd9eiVUC5aQD
	 Yy18/XGzVOgWUYmQZ5UScX3BK6USfWwnlvpRTA2QicYGChowy8pjiAP8dj+vORdJfq
	 7Kbvk5gu+7BAg==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b728a43e410so209862866b.1
        for <linux-can@vger.kernel.org>; Thu, 27 Nov 2025 11:50:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU9oU5U76FbMUxj2LQXpUNMnd14t8hzhWzzpp12m01kUuaPGrO7tpiC2PVg2ozrtPQw+FsNcDkRvVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEmfOI0iwKN91CXGF2PFKUL50dgAwv8b3ksRF3jsi6PZkDZ0/a
	fil64OdIZiLL7YIf4yJQzlqdQOc1K5ujhOhF7NCwvmDai7Nzmdpeeq9QmtNwEo+SL/2bQ7TbuqD
	4gYjhTGpLKf1BdKmvx8I8QS5OIq0kLpA=
X-Google-Smtp-Source: AGHT+IESEZdD2WPoI7DYvq9/x6byjTEAW8M+/5BXtLgOaMXNOSsru8Bk14iEcIHUdNUmzVp6mz5/rWND5shAfzgyd3c=
X-Received: by 2002:a17:907:db16:b0:b73:6474:1ee8 with SMTP id
 a640c23a62f3a-b7671565a7cmr2594641466b.14.1764273000739; Thu, 27 Nov 2025
 11:50:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126120106.154635-1-mkl@pengutronix.de> <20251126120106.154635-17-mkl@pengutronix.de>
In-Reply-To: <20251126120106.154635-17-mkl@pengutronix.de>
From: Vincent Mailhol <mailhol@kernel.org>
Date: Thu, 27 Nov 2025 20:49:49 +0100
X-Gmail-Original-Message-ID: <CAMZ6RqL_nGszwoLPXn1Li8op-ox4k3Hs6p=Hw6+w0W=DTtobPw@mail.gmail.com>
X-Gm-Features: AWmQ_bmscd3eqawMOLQcGbguPABqjViH697zfTNGWCiPkeJriLKaIW0hTArKTWI
Message-ID: <CAMZ6RqL_nGszwoLPXn1Li8op-ox4k3Hs6p=Hw6+w0W=DTtobPw@mail.gmail.com>
Subject: Re: [PATCH net-next 16/27] can: raw: instantly reject unsupported CAN frames
To: Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	linux-can@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"

On Wed. 26 Nov. 2025 at 13:01, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> From: Oliver Hartkopp <socketcan@hartkopp.net>
>
> For real CAN interfaces the CAN_CTRLMODE_FD and CAN_CTRLMODE_XL control
> modes indicate whether an interface can handle those CAN FD/XL frames.
>
> In the case a CAN XL interface is configured in CANXL-only mode with
> disabled error-signalling neither CAN CC nor CAN FD frames can be sent.
>
> The checks are performed on CAN_RAW sockets to give an instant feedback
> to the user when writing unsupported CAN frames to the interface.
>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Link: https://patch.msgid.link/20251126-canxl-v8-16-e7e3eb74f889@pengutronix.de
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  net/can/raw.c | 54 +++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 46 insertions(+), 8 deletions(-)
>
> diff --git a/net/can/raw.c b/net/can/raw.c
> index f36a83d3447c..be1ef7cf4204 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -892,20 +892,58 @@ static void raw_put_canxl_vcid(struct raw_sock *ro, struct sk_buff *skb)
>         }
>  }
>
> -static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb, int mtu)
> +static inline bool raw_dev_cc_enabled(struct net_device *dev,
> +                                     struct can_priv *priv)
>  {
> -       /* Classical CAN -> no checks for flags and device capabilities */
> -       if (can_is_can_skb(skb))
> +       /* The CANXL-only mode disables error-signalling on the CAN bus
> +        * which is needed to send CAN CC/FD frames
> +        */
> +       if (priv)
> +               return !can_dev_in_xl_only_mode(priv);
> +
> +       /* virtual CAN interfaces always support CAN CC */
> +       return true;
> +}
> +
> +static inline bool raw_dev_fd_enabled(struct net_device *dev,
> +                                     struct can_priv *priv)
> +{
> +       /* check FD ctrlmode on real CAN interfaces */
> +       if (priv)
> +               return (priv->ctrlmode & CAN_CTRLMODE_FD);
> +
> +       /* check MTU for virtual CAN FD interfaces */
> +       return (READ_ONCE(dev->mtu) >= CANFD_MTU);
> +}
> +
> +static inline bool raw_dev_xl_enabled(struct net_device *dev,
> +                                     struct can_priv *priv)
> +{
> +       /* check XL ctrlmode on real CAN interfaces */
> +       if (priv)
> +               return (priv->ctrlmode & CAN_CTRLMODE_XL);
> +
> +       /* check MTU for virtual CAN XL interfaces */
> +       return can_is_canxl_dev_mtu(READ_ONCE(dev->mtu));
> +}
> +
> +static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb,
> +                                     struct net_device *dev)
> +{
> +       struct can_priv *priv = safe_candev_priv(dev);

Sorry for coming back to you too late after the series is already
merged in net-next.

This dependency on safe_candev_priv() can break the kernel build.
Indeed, when building the kernel with:

  CONFIG_CAN_RAW=y

and with CONFIG_CAN_DEV not set (or built as module) below build error occurs:

  ld: vmlinux.o: in function `raw_sendmsg':
  raw.c:(.text+0x101ac4b): undefined reference to `safe_candev_priv'

This is because, under the current design, the CAN network layer is
not supposed to depend on the CAN devices layer.

I do not have a fix for this, nor do I have time to work on such a
fix. All I can do for the moment is escalate the issue (but it is just
a matter of time before some build bot from linux-next would report
the same issue).

> +       /* Classical CAN */
> +       if (can_is_can_skb(skb) && raw_dev_cc_enabled(dev, priv))
>                 return CAN_MTU;
>
> -       /* CAN FD -> needs to be enabled and a CAN FD or CAN XL device */
> +       /* CAN FD */
>         if (ro->fd_frames && can_is_canfd_skb(skb) &&
> -           (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
> +           raw_dev_fd_enabled(dev, priv))
>                 return CANFD_MTU;
>
> -       /* CAN XL -> needs to be enabled and a CAN XL device */
> +       /* CAN XL */
>         if (ro->xl_frames && can_is_canxl_skb(skb) &&
> -           can_is_canxl_dev_mtu(mtu))
> +           raw_dev_xl_enabled(dev, priv))
>                 return CANXL_MTU;
>
>         return 0;
> @@ -961,7 +999,7 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>         err = -EINVAL;
>
>         /* check for valid CAN (CC/FD/XL) frame content */
> -       txmtu = raw_check_txframe(ro, skb, READ_ONCE(dev->mtu));
> +       txmtu = raw_check_txframe(ro, skb, dev);
>         if (!txmtu)
>                 goto free_skb;


Yours sincerely,
Vincent Mailhol

