Return-Path: <linux-can+bounces-1526-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1996897E535
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 06:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 909441F21658
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 04:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44453FE4;
	Mon, 23 Sep 2024 04:01:00 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7617184
	for <linux-can@vger.kernel.org>; Mon, 23 Sep 2024 04:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727064060; cv=none; b=CwBk2YnkwIeWHHDHLIWuqSz9PTN0Xr3Cu4v4/t3oPJ+a+wDGsQCjf1f0+dJrqfCrR14CU6zdlCbFODWuRSdPkJxXkaHRZVrKwasbMOGMARnuKakiW4dbXjV5zIupvPXBph+NEsgYUciCa3e502p666NbnGX4IO6oXjykdWZFC2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727064060; c=relaxed/simple;
	bh=vQtDgWdVRcvacXQa/8I+NCpUHNSuvglWs2KoAdzOwoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ufNZhtGp3sYcyGrR285MXr++j+m+eiQOCXWmOdCkhYM4ksXe+jWWG3A9TevRy0vCo4PFCS64Xsmly47udvi9GzRAEds8asUH0tuoFogbf6lVR4QjCW2ADz/r2fB3s68f8eaoZujQ1+9ows9cAj3pXLqPNoX+Wpfo6/0DmDZG110=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-718e6299191so1956031b3a.2
        for <linux-can@vger.kernel.org>; Sun, 22 Sep 2024 21:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727064058; x=1727668858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BucS44OXA4HzaEqxUmau5a3yg+bEh2sR+7rj6AwQWaY=;
        b=eh3RP9NvQF5URZwJodDhRTbzgVMR0jcjYeboGiz0/4eHT1R+VlhhxtjW0pVzC3Fl5Y
         78w69iuWoc3z7//N83NC1o9z8BGScVlt9GQ2TRANAxgWt9WLe06viMiqaoLlCgkxDcDW
         5a32fjr0gjIzgmA9W3mJVAFz7cfFEZkdc4dc7I6Lvr3kBy2D9tblMPx8UZ3CtUsyln4S
         5gqiBEcc1qwFj9ee4CLEcE3q02xTr+5DMckqghLsOWF1SgfPud+Uep4IzsV9Oczv1rRJ
         eYRsFoVSCXy5Zzzkij20G03S9jc+IO55s8JzP/Javp07/aF2rRb6gymiSVTYpR17CMbI
         Fv5w==
X-Gm-Message-State: AOJu0YxW38vDXV2HfRRo5S4ES5OwYbrJVzHHIyg3HisCD5kEN9J3fh1V
	vCG3YiSEgH2LWcDid0Wy0zKMiox1Xu13ckMqXN/tuu2DJit712i/cfuxXB0h6F4qUBZegdJj/PA
	NWv7Lw4cn+t9kexeX4AE93oGrl34=
X-Google-Smtp-Source: AGHT+IHjOy8e6/zdJQG1XPuTRxK9Otu82bQJD3mxikwArAL+sivqgH8lmQ3cQRhljEKzwGTJfDErBaO35K3zERjoAUE=
X-Received: by 2002:a05:6a00:4612:b0:718:13bf:9a6e with SMTP id
 d2e1a72fcca58-7199ce5c261mr14896060b3a.28.1727064056678; Sun, 22 Sep 2024
 21:00:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913185156.123924-1-ak.alexander.kozhinov@gmail.com>
In-Reply-To: <20240913185156.123924-1-ak.alexander.kozhinov@gmail.com>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Mon, 23 Sep 2024 13:00:44 +0900
Message-ID: <CAMZ6RqLCqMTVSwi2Qbqje7LrO5z5deCHBkdqJhPYTaHUYdOnMw@mail.gmail.com>
Subject: Re: [PATCH v2] can: gs_usb.c: add usb endpoint address detection at
 driver probe step
To: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maximilian Schneider <max@schneidersoft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat. 14 Sep. 2024 at 03:57, Alexander Kozhinov
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
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Maximilian Schneider <max@schneidersoft.net>
> Signed-off-by: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
> ---
>  drivers/net/can/usb/gs_usb.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index bc86e9b329fd..f3eb447267f9 100644
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
> +       u8 ep_in;
> +       u8 ep_out;

Nitpick, instead of storing the ep_in and ep_out in your priv, you can
instead directly store the result of usb_rcvbulkpipe(parent->udev,
parent->ep_in) and usb_sndbulkpipe(dev->udev, dev->parent->ep_out).

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
> +                         usb_rcvbulkpipe(parent->udev, parent->ep_in),
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
> +                         usb_sndbulkpipe(dev->udev, dev->parent->ep_out)=
,
>                           hf, dev->hf_size_tx,
>                           gs_usb_xmit_callback, txc);
>
> @@ -926,7 +926,7 @@ static int gs_can_open(struct net_device *netdev)
>                         usb_fill_bulk_urb(urb,
>                                           dev->udev,
>                                           usb_rcvbulkpipe(dev->udev,
> -                                                         GS_USB_ENDPOINT=
_IN),
> +                                                         dev->parent->ep=
_in),
>                                           buf,
>                                           dev->parent->hf_size_rx,
>                                           gs_usb_receive_bulk_callback, p=
arent);
> @@ -1421,6 +1421,18 @@ static int gs_usb_probe(struct usb_interface *intf=
,
>         struct gs_device_config dconf;
>         unsigned int icount, i;
>         int rc;
> +       struct usb_host_interface *host_iface;
> +       struct usb_endpoint_descriptor *ep_in, *ep_out;

Move this declaration up (c.f. the Reverse christmas tree declarations).

> +
> +       host_iface =3D intf->cur_altsetting;
> +
> +       /* Find common bulk endpoints reverse */

Any specific reason for doing this in reverse? The previous
GS_USB_ENDPOINT_IN and GS_USB_ENDPOINT_OUT macros were respectively 1
and 2, so at the beginning. And in such a case, the normal search
would find those quicker.

> +       rc =3D usb_find_common_endpoints_reverse(host_iface, &ep_in, &ep_=
out, NULL,
> +                                                                        =
               NULL);

Nipick: no need to declare a new variable for host_iface which is used
only once. Just do:

        rc =3D usb_find_common_endpoints_reverse(intf->cur_altsetting,
                                               &ep_in, &ep_out, NULL, NULL)=
;

and remove this host_iface declaration.

> +       if (rc) {
> +               dev_err(&intf->dev, "Required endpoints not found\n");
> +               return rc;
> +       }
>
>         /* send host config */
>         rc =3D usb_control_msg_send(udev, 0,
> @@ -1466,6 +1478,10 @@ static int gs_usb_probe(struct usb_interface *intf=
,
>         usb_set_intfdata(intf, parent);
>         parent->udev =3D udev;

Maybe have the usb_find_common_endpoints() next to this? There is no
need to do the endpoint search earlier, so better to group this which
are related together.

> +       /* store the detected endpoints */
> +       parent->ep_in =3D ep_in->bEndpointAddress;
> +       parent->ep_out =3D ep_out->bEndpointAddress;
> +
>         for (i =3D 0; i < icount; i++) {
>                 unsigned int hf_size_rx =3D 0;
>
> --
> 2.43.0
>
>

