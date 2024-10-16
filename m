Return-Path: <linux-can+bounces-1714-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E7D9A0FB0
	for <lists+linux-can@lfdr.de>; Wed, 16 Oct 2024 18:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA4A02864A3
	for <lists+linux-can@lfdr.de>; Wed, 16 Oct 2024 16:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE9A210C37;
	Wed, 16 Oct 2024 16:28:48 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66430210C01
	for <linux-can@vger.kernel.org>; Wed, 16 Oct 2024 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729096128; cv=none; b=SiDWORh2KYtLQ9dQ0uyRr+yb/9hWSFJUjqzddQpTVpodEB5xSVK/lsOl25OcWaH5iaHsbLI9behFsXSIacyQpYpgmtOvQKDNW1ci3PSCjKNc3nSDsDx9+ijD8vSIP7GmAxwmoskjwX75yGWy1wPqDqjCvLFNPgqUzz4vMfDRnFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729096128; c=relaxed/simple;
	bh=16SJNwxcCQFEB5/dnI15ERqrTYudQo84XJpXwzRQE0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SB9ogSo7wFJiqob2BPnKSXFbyFKbwJxP9PP/LwOci4YRv8fkX+p6tBYasxEYEjH1SvPHwj0DLYy5NMZMjgCc0rQEh0NpyruwBdwcLkADBP4Ae1b+SeZQRSP50jtSy5+0wVPsei30TbVUE5nveV2NeR80aahACn4CixlVq3W2Zt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a99eb8b607aso566333966b.2
        for <linux-can@vger.kernel.org>; Wed, 16 Oct 2024 09:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729096125; x=1729700925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULO7HcebcGQCGbKshvrHtljSbEWhQ3IP0C63NtmlObs=;
        b=uOET605S0iwZck1PrvXY7Qch67JnXD9pa/GqUQmGeD5b9KdyIVHH7PLhP5RuRfQ4z3
         Gr8YLZmzYSoC2WPCfoxSn0vcVo3IYoXNCcstlDNs9fgbaQf5h8HUpFLSU3F1KXv9ijYk
         BPc1a4TytZHLSXXzrVxV0uGvIqzlpl1b5gY5A7OH3hUP4StXAL9Tf02umSLcMk6ISChw
         Fy1czmaQQR8WAAL/F6Q24Ngu+Z3VPkeTznR3oOWC24UELDOr1HWTJa7ZBe9KSpTHzMIq
         0YLxipf9FkYtsz/RduzorwFZPiPGQ0wz5abeUIB0D/fOtuOLmisUaRIwO0SEdptUqtz+
         bxtw==
X-Gm-Message-State: AOJu0YzZFyHIhHDaDkppCabcSLDdHucwTXtc3j3uqwjXe7bPqny4+P1p
	cqa2KPdjYHask8kTN8Aw84XF+yyF6Pbf0G6UtYdHjSgyOn36wapEMWAedoN99kzF9CaIq2VPs6A
	2WwyEWvWGSwqPjgqkGANs9SD3/Ck=
X-Google-Smtp-Source: AGHT+IHfwb/ZqDLevjdaDyjS4NhNH3kt8H2G/ORpJwi7JvSnTLJi0OtoLJ8vABN1TRxj2IlKz/1j6nJ1O3F2lTYz6Ac=
X-Received: by 2002:a17:907:f71c:b0:a8d:3d36:3169 with SMTP id
 a640c23a62f3a-a9a34e8c3f1mr366762266b.63.1729096124670; Wed, 16 Oct 2024
 09:28:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012212347.15141-1-ak.alexander.kozhinov@gmail.com>
In-Reply-To: <20241012212347.15141-1-ak.alexander.kozhinov@gmail.com>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Thu, 17 Oct 2024 01:28:33 +0900
Message-ID: <CAMZ6Rq+Lx5171bcshugrm7R=ipCKTGhdtmAQO=5M62e+e5zFiw@mail.gmail.com>
Subject: Re: [PATCH v5] can: gs_usb.c: add usb endpoint address detection at
 driver probe step
To: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maximilian Schneider <max@schneidersoft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun. 13 Oct. 2024 at 06:24, Alexander Kozhinov
<ak.alexander.kozhinov@gmail.com> wrote:
> There is an approach made to implement gs_usb firmware/driver based on
> Zephyr RTOS. It was found that USB stack of Zephyr RTOS overwrites USB
> EP addresses, if they have different last 4 bytes in absence of other
> endpoints.
>
> For example in case of gs_usb candlelight firmware EP-IN is 0x81 and
> EP-OUT 0x02. If there are no additional USB endpoints, Zephyr RTOS will
> overwrite EP-OUT to 0x01. More information can be found in the
> discussion with Zephyr RTOS USB stack maintainer here:
>
> https://github.com/zephyrproject-rtos/zephyr/issues/67812
>
> There are already two different gs_usb FW driver implementations based
> on Zephyr RTOS:
>
> 1. https://github.com/CANnectivity/cannectivity
>    (by: https://github.com/henrikbrixandersen)
> 2. https://github.com/zephyrproject-rtos/zephyr/compare/main...KozhinovAl=
exander:zephyr:gs_usb
>    (by: https://github.com/KozhinovAlexander)
>
> At the moment both Zephyr RTOS implementations use dummy USB endpoint,
> to overcome described USB stack behavior from Zephyr itself. Since
> Zephyr RTOS is intended to be used on microcontrollers with very
> constrained amount of resources (ROM, RAM) and additional endpoint
> requires memory, it is more convenient to update the gs_usb driver in
> the Linux kernel.
>
> To fix this problem, update the gs_usb driver from using hard coded
> endpoint numbers to evaluate the endpoint descriptors and use the
> endpoints provided there.
>
> To: linux-can@vger.kernel.org
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Maximilian Schneider <max@schneidersoft.net>
> Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devic=
es")
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Signed-off-by: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
>
> ---
> Changes in v3:
> - store pipe instead of endpoint address.
>         This change implements nitpick:
>         Instead of storing the ep_in and ep_out in your priv, you can
>         instead directly store the result of usb_rcvbulkpipe(parent->udev=
,
>         parent->ep_in) and usb_sndbulkpipe(dev->udev, dev->parent->ep_out=
).
> - use reverse xmas tree declaration.
>         This change implements request:
>         Move this declaration up (c.f. the Reverse christmas tree declara=
tions).
> - use forward usb endpoints search.
>         This change implements request:
>         Any specific reason for doing this in reverse? The previous
>         GS_USB_ENDPOINT_IN and GS_USB_ENDPOINT_OUT macros were respective=
ly 1
>         and 2, so at the beginning. And in such a case, the normal search
>         would find those quicker.
> - skip new variable declaration.
>         This change implements nipick:
>         no need to declare a new variable for host_iface which is used on=
ly once.
>
> Changes in v4:
> - put in CC most relevant mailing ist linux-can@vger.kernel.org
> - use one patch only since only one logical/contextual change were introd=
uced.
> - add quick changelog over multiple pathc versions.
>
> Changes in v5:
> - add fixes tag to commit message
> - add reviewed-by tag
> - remove comment on line 1425
> ---
>  drivers/net/can/usb/gs_usb.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index bc86e9b329fd..77bb8e197994 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -43,9 +43,6 @@
>  #define USB_XYLANTA_SAINT3_VENDOR_ID 0x16d0
>  #define USB_XYLANTA_SAINT3_PRODUCT_ID 0x0f30
>
> -#define GS_USB_ENDPOINT_IN 1
> -#define GS_USB_ENDPOINT_OUT 2
> -
>  /* Timestamp 32 bit timer runs at 1 MHz (1 =C2=B5s tick). Worker account=
s
>   * for timer overflow (will be after ~71 minutes)
>   */
> @@ -336,6 +333,9 @@ struct gs_usb {
>
>         unsigned int hf_size_rx;
>         u8 active_channels;
> +
> +       unsigned int pipe_in;
> +       unsigned int pipe_out;
>  };
>
>  /* 'allocate' a tx context.
> @@ -687,7 +687,7 @@ static void gs_usb_receive_bulk_callback(struct urb *=
urb)
>
>  resubmit_urb:
>         usb_fill_bulk_urb(urb, parent->udev,
> -                         usb_rcvbulkpipe(parent->udev, GS_USB_ENDPOINT_I=
N),
> +                         parent->pipe_in,
>                           hf, dev->parent->hf_size_rx,
>                           gs_usb_receive_bulk_callback, parent);
>
> @@ -819,7 +819,7 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *=
skb,
>         }
>
>         usb_fill_bulk_urb(urb, dev->udev,
> -                         usb_sndbulkpipe(dev->udev, GS_USB_ENDPOINT_OUT)=
,
> +                         dev->parent->pipe_out,
>                           hf, dev->hf_size_tx,
>                           gs_usb_xmit_callback, txc);
>
> @@ -925,8 +925,7 @@ static int gs_can_open(struct net_device *netdev)
>                         /* fill, anchor, and submit rx urb */
>                         usb_fill_bulk_urb(urb,
>                                           dev->udev,
> -                                         usb_rcvbulkpipe(dev->udev,
> -                                                         GS_USB_ENDPOINT=
_IN),
> +                                         dev->parent->pipe_in,
>                                           buf,
>                                           dev->parent->hf_size_rx,
>                                           gs_usb_receive_bulk_callback, p=
arent);
> @@ -1413,6 +1412,7 @@ static int gs_usb_probe(struct usb_interface *intf,
>                         const struct usb_device_id *id)
>  {
>         struct usb_device *udev =3D interface_to_usbdev(intf);
> +       struct usb_endpoint_descriptor *ep_in, *ep_out;
>         struct gs_host_frame *hf;
>         struct gs_usb *parent;
>         struct gs_host_config hconf =3D {
> @@ -1422,6 +1422,13 @@ static int gs_usb_probe(struct usb_interface *intf=
,
>         unsigned int icount, i;
>         int rc;
>
> +       rc =3D usb_find_common_endpoints(intf->cur_altsetting,
> +                                                                       &=
ep_in, &ep_out, NULL, NULL);

Arg, I forgot to point out the wrong indentation in my last message.
The second line should be aligned with the first one.

You can see the problem by using the checkpatch.pl tool on your patch:

  $ ./scripts/checkpatch.pl <path_to_your_patch>
  (...)
  CHECK: Alignment should match open parenthesis
  #217: FILE: drivers/net/can/usb/gs_usb.c:1426:
  +    rc =3D usb_find_common_endpoints(intf->cur_altsetting,
  +                                    &ep_in, &ep_out, NULL, NULL);

Maybe you set the tab length to 4 columns in your editor? Here, the
tabulation width is eight. If you need some different settings for
some different project, then I recommend you to configure your editor
to rely on the .editorconfig file:

  https://git.kernel.org/torvalds/c/5a602de99797


@Marc do you mind fixing this while applying or do we ask Alexander to
send a v6?

> +       if (rc) {
> +               dev_err(&intf->dev, "Required endpoints not found\n");
> +               return rc;
> +       }
> +
>         /* send host config */
>         rc =3D usb_control_msg_send(udev, 0,
>                                   GS_USB_BREQ_HOST_FORMAT,
> @@ -1466,6 +1473,10 @@ static int gs_usb_probe(struct usb_interface *intf=
,
>         usb_set_intfdata(intf, parent);
>         parent->udev =3D udev;
>
> +       /* store the detected endpoints */
> +       parent->pipe_in =3D usb_rcvbulkpipe(parent->udev, ep_in->bEndpoin=
tAddress);
> +       parent->pipe_out =3D usb_sndbulkpipe(parent->udev, ep_out->bEndpo=
intAddress);
> +
>         for (i =3D 0; i < icount; i++) {
>                 unsigned int hf_size_rx =3D 0;
>
> --
> 2.43.0
>
>

