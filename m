Return-Path: <linux-can+bounces-1638-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B510D99B528
	for <lists+linux-can@lfdr.de>; Sat, 12 Oct 2024 15:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42AFB1F21455
	for <lists+linux-can@lfdr.de>; Sat, 12 Oct 2024 13:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3668F64;
	Sat, 12 Oct 2024 13:45:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9794A12CDB6
	for <linux-can@vger.kernel.org>; Sat, 12 Oct 2024 13:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728740756; cv=none; b=iaux6l9EkkX3N0CL5up32RLHVGmDEOiUogAH5GjXI1xK/6rcFr7O66YlI82w1dzFkC9h+IpSyxGDkdiTFB/RPHBdmTNn3vfCiahFR8NXxdw2Ia/wkIGCXvjUKBu2YuS3qMqIqIfJFwAKxt4xHW6Dsc949AyH8trbNuQb8MdwYmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728740756; c=relaxed/simple;
	bh=8iY8npVsZepXRdfM8eTzKPs1FNA7m4DiwE3+ttxDvl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYLBien/T8QfI7HyLrP3GTdvFp7ca1W0YebZSew55zQhcVY99QDOBYgMkPEBiW2q55em9HyN+WTYhl589Z306IU/zRls1domytUfb561RQCTQzRobe9Me9ZJQteN4fTzosJ9A14AAt887cDCAd+n0G+r3t3+wzmhFXiAA4HztLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c960af31daso417187a12.3
        for <linux-can@vger.kernel.org>; Sat, 12 Oct 2024 06:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728740751; x=1729345551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1wjIpR4C7SPKsbDL5URLLwl7qqCndGDh3ih4opyUpw=;
        b=ocPdOJyf4ZQQ0EtLzoGVZzkWWhM8Ill0bjq7zTYookeESb5aurWBcYWX+m/hBdt18Z
         iQOd2BvPrgWM3vZS2i5mAIP+HwjlqIvxR8kOjYBNXEp+JX2R2BDd0t6gbTM1gI/7hZnO
         QGe8w6O4BD4C506kr2MRqwGIVNfIb7XRtjzmU6HVEBf12scDqNqASzkLi79LBui5HE5+
         a2lfvnx45W8SJTN/0n2jbCd7RRJbPkaKvHO0s7HNcz+66xC3N1+C4dmN05/uf8pvhb5T
         S1YT0cmGPm5d8vCQkhsNvOcrl1X8Rz+ddUEZ5evYUJoMJ3KbnncjJhh5l8e4ZeBwmoEm
         nhUg==
X-Gm-Message-State: AOJu0Yx+MdPEQ//0XrbsPAalqTgdHAHfaK41na/aIorTrR9kxWhSX5fh
	g3XnhEZQpgJq5wJ87tbxQhAtVVLcSHbzys8H8mdMT1TMAAJw1bpiNM6I2lWlC1/Mufycv/2hqol
	FM1Io9p2kCnyNWvDEm5zsLVCBynE=
X-Google-Smtp-Source: AGHT+IFKopGMBMyhz5B78tEH0hJkmrtI3nHD29OdZeaTBYmW5wbzK6s2/WPU4mGZJaHfPpj69yzDCtbd8oYzf0Gmyvk=
X-Received: by 2002:a17:907:e65c:b0:a8d:fa3:bb24 with SMTP id
 a640c23a62f3a-a99b95a5b39mr476525466b.23.1728740750617; Sat, 12 Oct 2024
 06:45:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012112522.18464-1-ak.alexander.kozhinov@gmail.com>
In-Reply-To: <20241012112522.18464-1-ak.alexander.kozhinov@gmail.com>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Sat, 12 Oct 2024 22:45:39 +0900
Message-ID: <CAMZ6Rq+rAdyYKOpna1T7dhEV69cuTNFK+gHy4oCfSf0+AmGtyg@mail.gmail.com>
Subject: Re: [PATCH v4] can: gs_usb.c: add usb endpoint address detection at
 driver probe step
To: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maximilian Schneider <max@schneidersoft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

Thank you for this v4, the patch is overall good (there are two minor
comments left to address). With this, I think you are done with your
on boarding on understanding the patch submission process. Congrats
for your first patch on the mailing list!

On Sat. 12 Oct. 2024 at 20:25, Alexander Kozhinov
<ak.alexander.kozhinov@gmail.com> wrote:
>
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

If I understand correctly, this patch addresses a current issue. In
that case, it is good to add a Fixes: tag to inform the maintainers of
the stable branches how to back-port it.

Additional info:

  https://www.kernel.org/doc/html/latest/process/submitting-patches.html#us=
ing-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

For this patch, the code you are fixing is present since the
introduction of the gs-usb module, so you can add this tag:

Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices=
")

This way, the users of older kernel releases will also benefit from your pa=
tch!

> To: linux-can@vger.kernel.org
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Maximilian Schneider <max@schneidersoft.net>
> Signed-off-by: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>

Please address the last two comments (c.f. below), but meanwhile, you
can directly add my review tag to the v5:

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

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
> ---
>  drivers/net/can/usb/gs_usb.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index bc86e9b329fd..d93410682d4b 100644
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

Nitpick: by putting some integers after a u8, you are creating a hole
for 3 bytes between gs_usb->active_channels and gs_usb->pipe_in, as
shown by the pahole tool:

  $ pahole --class_name=3Dgs_usb drivers/net/can/usb/gs_usb.o
  struct gs_usb {
      struct gs_can *            canch[3];             /*     0    24 */
      struct usb_anchor          rx_submitted;         /*    24    56 */

      /* XXX last struct has 4 bytes of padding, 31 bits of padding */

      /* --- cacheline 1 boundary (64 bytes) was 16 bytes ago --- */
      struct usb_device *        udev;                 /*    80     8 */
      struct cyclecounter        cc;                   /*    88    24 */
      struct timecounter         tc;                   /*   112    40 */
      /* --- cacheline 2 boundary (128 bytes) was 24 bytes ago --- */
      spinlock_t                 tc_lock;              /*   152     4 */

      /* XXX 4 bytes hole, try to pack */

      struct delayed_work        timestamp;            /*   160    88 */

      /* XXX last struct has 4 bytes of padding */

      /* --- cacheline 3 boundary (192 bytes) was 56 bytes ago --- */
      unsigned int               hf_size_rx;           /*   248     4 */
      u8                         active_channels;      /*   252     1 */

      /* XXX 3 bytes hole, try to pack */

      /* --- cacheline 4 boundary (256 bytes) --- */
      unsigned int               pipe_in;              /*   256     4 */
      unsigned int               pipe_out;             /*   260     4 */

      /* size: 264, cachelines: 5, members: 11 */
      /* sum members: 257, holes: 2, sum holes: 7 */
      /* member types with bit paddings: 1, total: 31 bits */
      /* paddings: 2, sum paddings: 8 */
      /* last cacheline: 8 bytes */
  };

This 3 bytes hole will always exist even if you group the integers
together (because the padding also occurs at the end of the structure)
*but*, it is easier to maintain if the hole is at the end.

So, in summary, do it like this:

        unsigned int hf_size_rx;
+       unsigned int pipe_in;
+       unsigned int pipe_out;
        u8 active_channels;
 };

Note that there is also 2 other 4 bytes holes, so a packing
optimization could be done here, but this is out of scope of your
patch. If you want to address that, it must go in a different patch
because, this time, it is another "logical change".

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
> @@ -1422,6 +1422,14 @@ static int gs_usb_probe(struct usb_interface *intf=
,
>         unsigned int icount, i;
>         int rc;
>
> +       /* Find common bulk endpoints reverse */
                                        ^^^^^^^

You forget to update the comment.

Also, about the comments in general, have a look at this:

  https://www.kernel.org/doc/html/v4.10/process/coding-style.html#commentin=
g

Here, your comment: /* Find common bulk endpoints */ paraphrases the
function name: usb_find_common_endpoints(). So it does not add any
value. It is better to simply remove that comment and let the code
speak for itself.

> +       rc =3D usb_find_common_endpoints(intf->cur_altsetting,
> +                                                                       &=
ep_in, &ep_out, NULL, NULL);
> +       if (rc) {
> +               dev_err(&intf->dev, "Required endpoints not found\n");
> +               return rc;
> +       }
> +
>         /* send host config */
>         rc =3D usb_control_msg_send(udev, 0,
>                                   GS_USB_BREQ_HOST_FORMAT,
> @@ -1466,6 +1474,10 @@ static int gs_usb_probe(struct usb_interface *intf=
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

Yours sincerely,
Vincent Mailhol

