Return-Path: <linux-can+bounces-4541-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92214B4A22E
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 08:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29D5D1882D77
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 06:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA62302740;
	Tue,  9 Sep 2025 06:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Emw6X4Mz"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81853019B1
	for <linux-can@vger.kernel.org>; Tue,  9 Sep 2025 06:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757399138; cv=none; b=LO2nkZZ4IMMfFpH/EaWhJvyCDKRkackD32ivS5QWbzRtj9B3DKB1KMv0Tu6Ratd65bRVAXpshnras1DGe308vbGiqgRdWMf71KXrlco3DBSKZm8tpC9OMiG355q6HiWcuMYp1hq1/MskI9sUc2+GnUarWSXLNi6rTVmBt0qI2eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757399138; c=relaxed/simple;
	bh=cxsEyxWZuI48qpvyous9SwgsOl38n0aJjbZT5MVL0cY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6734H5hpgiTlm3HDO87VKKWOpc9ts6wcq1np4jo+RofA1YvngXU68C2qGNUKc289Iaps79uZk4a3cf8j7A0pqo0l2dCXqOI5lN2Q8RnUa2tJKOdqoeXZYgTXPgol574Q4RocDDKrX6shUg3GV+XxJ6nn2c5pYauPliGxqWGRTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Emw6X4Mz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50872C4CEF4
	for <linux-can@vger.kernel.org>; Tue,  9 Sep 2025 06:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757399138;
	bh=cxsEyxWZuI48qpvyous9SwgsOl38n0aJjbZT5MVL0cY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Emw6X4MzEU7onBYbgg0BjW5CMWtw+G1mLhhJdqSTbImdR8LbkcHK0BixYGP8RpPdG
	 LBlLiMuQRheCO3RM2XsiokQ0LzZtK9GzvyA0gNMqyO0Sv8zZNTzkuWuzEZHL/kV09C
	 jcfKYnrvBD0kcAgI1JLanqNmvqDAMvNgc4ofhQLgF61xofa79ULzh+7pGFH92MFzgH
	 aMjRnvqCU3yHg+zLcwN122AIoqEMmdCbfrvyJrIQ33wukGduYANNQfFEeIG0g+jX03
	 Z62QyVFplW0F00C0i1wmIFIOGMTAr0lrMU5jO8s0f8vshF1OOk2L+dYdEmVzzuTp/p
	 8l0H0QtgozGuA==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b04679375f6so920314566b.2
        for <linux-can@vger.kernel.org>; Mon, 08 Sep 2025 23:25:38 -0700 (PDT)
X-Gm-Message-State: AOJu0YxVm0vQTi8iwTrDE7hRM007vkDRkso77i8Ar8R4JyP2aX0HiF1x
	czNQKMGE0mzB8w48Zf7KgrFXh/IJfktkb/fcVuJFuHaGqvrgKjJlMjojTA3ExqsnhkH0gXu4j5E
	bQkjA8mZDWr1W5MYKO45I5NdnC7Fimwg=
X-Google-Smtp-Source: AGHT+IEURoYM/2bOAdJEw37UT59lq02IxO30jiFsWsIyrpFQxxSvZR2Jaxb3sKd/AwC6A55nNfv5IwNoHjm9F03qy/A=
X-Received: by 2002:a17:907:1c8c:b0:afe:ed71:80aa with SMTP id
 a640c23a62f3a-b04b16d6406mr1160127666b.57.1757399137142; Mon, 08 Sep 2025
 23:25:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908184512.78449-1-socketcan@hartkopp.net>
In-Reply-To: <20250908184512.78449-1-socketcan@hartkopp.net>
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 9 Sep 2025 15:25:26 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqKiwmFzuFxxYvbLYr4-5AkDG7+W2zigqR8uvqSWv952JQ@mail.gmail.com>
X-Gm-Features: Ac12FXz8IaAPImWsJ6O7ksNGYBrt6AVARB0q_eMAZ6caKyS0vChYBQzxVRbevqg
Message-ID: <CAMZ6RqKiwmFzuFxxYvbLYr4-5AkDG7+W2zigqR8uvqSWv952JQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/2] can: skb: enforce CANFD_FDF check in can_is_canfd_skb()
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue. 9 Sep. 2025 at 03:45, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> The check in can_is_canfd_skb() is about a length check of skb->len and
> the CAN FD data length. As a skb length of CANFD_MTU can potentially be
> created with a CAN XL frame with a data length of 60, the length check of
> the CAN FD data length is used to detect CAN XL frames via its CANXL_XLF
> flag which exceeds valid CAN FD data length values.
>
> To make sure the CANFD_FDF flag can be safely used as a marker for CAN FD
> frame skbs the bit was set in can_send() and is now also set in
> raw_check_txframe() to re-use the indroduced can_is_canfd_skb_set_fdf()
> function. In the RX path alloc_canfd_skb() sets the CANFD_FDF flag.
>
> The enforced CANFD_FDF check in can_is_canfd_skb() clears up the potential
> uncertainty when using the skb->len check with the CANFD_MTU.
>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  include/linux/can/skb.h | 25 +++++++++++++++++++++++--
>  net/can/af_can.c        |  7 +------
>  net/can/raw.c           |  2 +-
>  3 files changed, 25 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
> index 1abc25a8d144..38d036b43280 100644
> --- a/include/linux/can/skb.h
> +++ b/include/linux/can/skb.h
> @@ -111,12 +111,33 @@ static inline bool can_is_can_skb(const struct sk_buff *skb)
>
>  static inline bool can_is_canfd_skb(const struct sk_buff *skb)
>  {
>         struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
>
> -       /* the CAN specific type of skb is identified by its data length */
> -       return (skb->len == CANFD_MTU && cfd->len <= CANFD_MAX_DLEN);
> +       if (skb->len != CANFD_MTU || cfd->len > CANFD_MAX_DLEN)
> +               return false;
> +
> +       return cfd->flags & CANFD_FDF;
> +}
> +
> +static inline bool can_is_canfd_skb_set_fdf(const struct sk_buff *skb)
> +{
> +       struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
> +
> +       /* The CAN specific type of skb is identified by its data length.
> +        * A CAN XL frame skb might have a skb->len of CANFD_MTU but the
> +        * skb would have the CANXL_XLF bit set (0x80 = 128) in the
> +        * cfd->len field position which would intentionally break the
> +        * CAN FD length check here. So we can surely tag it as CAN FD.
> +        */
> +       if (skb->len == CANFD_MTU && cfd->len <= CANFD_MAX_DLEN) {
> +               /* set CAN FD flag for CAN FD frames by default */
> +               cfd->flags |= CANFD_FDF;
> +               return true;
> +       }
> +
> +       return false;
>  }
>
>  static inline bool can_is_canxl_skb(const struct sk_buff *skb)
>  {
>         const struct canxl_frame *cxl = (struct canxl_frame *)skb->data;
> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index b2387a46794a..0caf75a9e27f 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -207,17 +207,12 @@ int can_send(struct sk_buff *skb, int loop)
>
>         if (can_is_canxl_skb(skb)) {
>                 skb->protocol = htons(ETH_P_CANXL);
>         } else if (can_is_can_skb(skb)) {
>                 skb->protocol = htons(ETH_P_CAN);
> -       } else if (can_is_canfd_skb(skb)) {
> -               struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
> -
> +       } else if (can_is_canfd_skb_set_fdf(skb)) {
>                 skb->protocol = htons(ETH_P_CANFD);
> -
> -               /* set CAN FD flag for CAN FD frames by default */
> -               cfd->flags |= CANFD_FDF;
>         } else {
>                 goto inval_skb;
>         }
>
>         /* Make sure the CAN frame can pass the selected CAN netdevice. */
> diff --git a/net/can/raw.c b/net/can/raw.c
> index 76b867d21def..f48b1f3fd6e8 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -886,11 +886,11 @@ static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb,

With this change, raw_check_txframe() now has a side effect. It will
set the CANFD_FDF under some conditions. This is weird for a function
named "check". When I read the code, I expected a check function to
not have such side effects.

I would suggest to set the flag in raw_sendmsg(), something like that:

         txmtu = raw_check_txframe(ro, skb, dev->mtu);
         if (!txmtu)
                 goto free_skb;

+        /* set CAN FD flag for CAN FD frames by default */
+        if (txmtu == CANFD_MTU) {
+                struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
+
+                cfd->flags |= CANFD_FDF;
+        }
+
         /* only CANXL: clear/forward/set VCID value */
         if (txmtu == CANXL_MTU)
                 raw_put_canxl_vcid(ro, skb);

>         /* Classical CAN -> no checks for flags and device capabilities */
>         if (can_is_can_skb(skb))
>                 return CAN_MTU;
>
>         /* CAN FD -> needs to be enabled and a CAN FD or CAN XL device */
> -       if (ro->fd_frames && can_is_canfd_skb(skb) &&
> +       if (ro->fd_frames && can_is_canfd_skb_set_fdf(skb) &&
>             (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
>                 return CANFD_MTU;
>
>         /* CAN XL -> needs to be enabled and a CAN XL device */
>         if (ro->xl_frames && can_is_canxl_skb(skb) &&

