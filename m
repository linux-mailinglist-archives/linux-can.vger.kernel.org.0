Return-Path: <linux-can+bounces-4596-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD8BB50CB9
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 06:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 569064E3B42
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 04:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A21D34CDD;
	Wed, 10 Sep 2025 04:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ul69yoVf"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238E94C81
	for <linux-can@vger.kernel.org>; Wed, 10 Sep 2025 04:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757477650; cv=none; b=rdgJr7DOqMgga9XGFMSPcOPI/it7vx+2XT2jxhcQYBodM5C/lUoTR/00rp+9TtOFmZ7K0OhRDstVMR87+4h1FTrMqL5a1MohjplNEuxLvXhQI0eHM3PMAiOKtU2RjJcBhLFxhgQ5g7h/C4yATdnKThCumZ2X8sij5uvs/Asclqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757477650; c=relaxed/simple;
	bh=C4ghCwsyW9yh+93uZ6K+fS2vUlGt+Vr2XbLbT3a74cI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xu1BBMoQKXl8eltgmuJcozRTDssgjfHL2SGnVggW0WIbwilUsbCa+qoDAxL4xJ0JVlHFFaSoVkpti+pt6D5FlH9XGFJKvx5JIOUzKsgaV7GrCR1MMQSFzBFDtfNZhy5js9rUnFxHJBbZvw6rIWAwTSr/MkNBp9bqXDgvQdjwV8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ul69yoVf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98DAC4CEF5
	for <linux-can@vger.kernel.org>; Wed, 10 Sep 2025 04:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757477649;
	bh=C4ghCwsyW9yh+93uZ6K+fS2vUlGt+Vr2XbLbT3a74cI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ul69yoVfsAMKWdttXg+eL0TeocqJ0Mubyp7bv6GwxHCb2t6nfzQ/rn7hZVW8HpVT9
	 7KFQxRO2RqM/BClBR/7VgbLnb4KxellilA1Fl180XVCqrZbSuHT1P2Lou8MyGbItcc
	 woRgRexk9H7g4Y3A21GMkcJUGm1BWEzmTT59olSdbAi9gD/JWnFcJjXH6idstpwB+V
	 0O0bSL8CW70xu2EpEnr0+VIynGWEvymORMMo/KLcdBhWEmKYwFfn17l0cTpO1DBy4z
	 YB0q0zZYp6Yio3i8EJsmAqRdX4KXlBDKsdJvPr/dMLDT2JhMDlOHxHmhwNaljy3GXr
	 DLqrL7d5njImw==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7ae31caso1054836266b.3
        for <linux-can@vger.kernel.org>; Tue, 09 Sep 2025 21:14:09 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy7x5Kd98amwWqjl5iInQbF53U908piDP5fAlN7C5Q4Sz6dl3sm
	18scNmaIO8l+T+wenSR2/nX5GlsFBP6S9R9Q8iGP4NVJXASCARyy7Px8XSSSa7hhpUHaIChNbIT
	pw05FZ1IpFhYuTu/0zLfKFRj17k2ugTE=
X-Google-Smtp-Source: AGHT+IFAbUqeDqk8TAc0bqklq5B1wzPM4HLdnB1DrVqMbDmfSoNUoYl4V7adywuUkaC9AB54QqkIx4qSUnvnaRFR6S0=
X-Received: by 2002:a17:907:1c93:b0:b04:3e15:7289 with SMTP id
 a640c23a62f3a-b04b15434ddmr1365382566b.33.1757477648590; Tue, 09 Sep 2025
 21:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909163702.17755-1-socketcan@hartkopp.net>
In-Reply-To: <20250909163702.17755-1-socketcan@hartkopp.net>
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 10 Sep 2025 13:13:57 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqK1cVT=xRhgFqCiUM4to2j37CoGq+uLrNt2tVPk+xTHhA@mail.gmail.com>
X-Gm-Features: Ac12FXzn4TDoBFwfyNeoz7c4gAGVrKFt_IxMb5PT8sLYrkNSekUL5uNP5hcipRA
Message-ID: <CAMZ6RqK1cVT=xRhgFqCiUM4to2j37CoGq+uLrNt2tVPk+xTHhA@mail.gmail.com>
Subject: Re: [RFC PATCH v6 1/2] can: skb: enforce CANFD_FDF check in can_is_canfd_skb()
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed. 10 sept. 2025 at 01:37, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> The check in can_is_canfd_skb() is about a length check of skb->len and
> the CAN FD data length. As a skb length of CANFD_MTU can potentially be
> created with a CAN XL frame with a data length of 60, the length check of
> the CAN FD data length is used to detect CAN XL frames via its CANXL_XLF
> flag which exceeds valid CAN FD data length values.
>
> To make sure the CANFD_FDF flag can be safely used as a marker for CAN FD
> frame skbs the bit is set in can_send() which is used by all PF_CAN
> protocols. In the RX path alloc_canfd_skb() sets the CANFD_FDF flag.
>
> The enforced CANFD_FDF check in can_is_canfd_skb() clears up the potential
> uncertainty when using the skb->len check with the CANFD_MTU.
>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  include/linux/can/skb.h | 19 +++++++++++++++++--
>  net/can/af_can.c        |  2 +-
>  net/can/raw.c           |  2 +-
>  3 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
> index 1abc25a8d144..09ab4dc83199 100644
> --- a/include/linux/can/skb.h
> +++ b/include/linux/can/skb.h
> @@ -107,18 +107,33 @@ static inline bool can_is_can_skb(const struct sk_buff *skb)
>
>         /* the CAN specific type of skb is identified by its data length */
>         return (skb->len == CAN_MTU && cf->len <= CAN_MAX_DLEN);
>  }
>
> -static inline bool can_is_canfd_skb(const struct sk_buff *skb)
> +static inline bool can_is_canfd_skb_mtu_len(const struct sk_buff *skb)
>  {
>         struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
>
> -       /* the CAN specific type of skb is identified by its data length */
> +       /* The CAN specific type of skb is identified by its data length.
> +        * A CAN XL frame skb might have a skb->len of CANFD_MTU but the
> +        * skb would have the CANXL_XLF bit set (0x80 = 128) in the
> +        * cfd->len field position which would intentionally break the
> +        * CAN FD length check here.
> +        */
>         return (skb->len == CANFD_MTU && cfd->len <= CANFD_MAX_DLEN);
>  }
>
> +static inline bool can_is_canfd_skb(const struct sk_buff *skb)
> +{
> +       struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
> +
> +       if (!can_is_canfd_skb_mtu_len(skb))
> +               return false;
> +
> +       return cfd->flags & CANFD_FDF;
> +}

How does this new can_is_canfd_skb() operate if a can frame is sent
through the PF_PACKET interface?

Wouldn't the frame bypass the can_send() and reach the driver's xmit()
function without the CANFD_FDF flag set?

>  static inline bool can_is_canxl_skb(const struct sk_buff *skb)
>  {
>         const struct canxl_frame *cxl = (struct canxl_frame *)skb->data;
>
>         if (skb->len < CANXL_HDR_SIZE + CANXL_MIN_DLEN || skb->len > CANXL_MTU)
> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index b2387a46794a..7fd2ed510440 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -207,11 +207,11 @@ int can_send(struct sk_buff *skb, int loop)
>
>         if (can_is_canxl_skb(skb)) {
>                 skb->protocol = htons(ETH_P_CANXL);
>         } else if (can_is_can_skb(skb)) {
>                 skb->protocol = htons(ETH_P_CAN);
> -       } else if (can_is_canfd_skb(skb)) {
> +       } else if (can_is_canfd_skb_mtu_len(skb)) {
>                 struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
>
>                 skb->protocol = htons(ETH_P_CANFD);
>
>                 /* set CAN FD flag for CAN FD frames by default */
> diff --git a/net/can/raw.c b/net/can/raw.c
> index 76b867d21def..e5e3952b0e09 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -886,11 +886,11 @@ static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb,
>         /* Classical CAN -> no checks for flags and device capabilities */
>         if (can_is_can_skb(skb))
>                 return CAN_MTU;
>
>         /* CAN FD -> needs to be enabled and a CAN FD or CAN XL device */
> -       if (ro->fd_frames && can_is_canfd_skb(skb) &&
> +       if (ro->fd_frames && can_is_canfd_skb_mtu_len(skb) &&
>             (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
>                 return CANFD_MTU;
>
>         /* CAN XL -> needs to be enabled and a CAN XL device */
>         if (ro->xl_frames && can_is_canxl_skb(skb) &&

