Return-Path: <linux-can+bounces-1304-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE8E9692CF
	for <lists+linux-can@lfdr.de>; Tue,  3 Sep 2024 06:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598932842CF
	for <lists+linux-can@lfdr.de>; Tue,  3 Sep 2024 04:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566D61A4E6A;
	Tue,  3 Sep 2024 04:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCwunv0U"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBBC36C
	for <linux-can@vger.kernel.org>; Tue,  3 Sep 2024 04:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725336929; cv=none; b=NYEoGHb2lHNRM2htmA8WFC56M07M7atmv+pODkM5VQWR9rZ+0wUTRHqpMaohjSzuKgfujNbGElldQSISDamQpq8am07WZjxf8IcNMTtCvcoq+Jo1O4iQOW5j0kJAmvJH3kS2NgPhBazPr/QwkapgYq+mNtObOkTuKsUOhet8NB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725336929; c=relaxed/simple;
	bh=C3PQlwg/NUsVvP/+6bYpwm1Z9vZx8EePRuQez050NT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PTuLnk84AB4RT2A7wXdCsVBdhHkAq8xf03H1XJpeJWZ+UUfXICfSSlo2PJBfGTS7FqMg1G7aGph4t9i48iI3H3znF9/U3ecCC1Aeg4FIYlJBmL2tXO0y4NF0KO6vL7LXa2MKg2foL8V10aTcdKFnAsFCem4L/SWYWLxW1s/xiYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCwunv0U; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2055136b612so21667635ad.0
        for <linux-can@vger.kernel.org>; Mon, 02 Sep 2024 21:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725336927; x=1725941727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tekYTY8TPgVMT1+yuvXzR6Re3S/yEDCk3VgC2mxAuqc=;
        b=BCwunv0UUaBBImWyjUbBfLZiki9OuwH7oOF3ErGnRiESHKM4SWSD+eOvLH5molxheO
         LtRwMExKR12gT0Dso0ED5uJPB34vEW4Xju1mJ14SS1fUWMFy8GrG3Hd5Zf4MASXZI1hk
         6nvmu1Q7WEA8y7vSHtoNqtq3d/KoZu39MkZ4aQyq5JEz9bzmCB24gKsfemj4TmxTz3bt
         HtwkAH5nYlDVumMpGB7ha7Q3ys8rJrircsFuw4Qa2ZPrkzKPI7OquS74mQga2QRMV0/X
         CTdXgHtILeuX9GCJJYx1icYXkghoQCKhXZEYWZm1+qjrdWMrOXRUIFVaZEolpH++LijR
         G1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725336927; x=1725941727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tekYTY8TPgVMT1+yuvXzR6Re3S/yEDCk3VgC2mxAuqc=;
        b=GB75NHHQRZsTOwYPwEcS9/vthvMBcFaBZWCKYReSMrSO2EA1LB5kx2pu+LDiDJoSRR
         RGnuPtMgZuG0mOkmWHr06nXYcDKkefZxwl5qy06mieRWC0P2XWyQ3KsDTdWHivpDKVZB
         8AMeR0uVoz+WobMyrMB2Htkajg+GfpEFlk8C3rW2PJHAFekEBQ3wo1J3mjXfSnXYllbU
         kCitC6OFFF8pU8E8oP8WI6NGRkcDhgFsyMn4yJ79uNup+GmTuh9yYwZgTnJMuBmThPgb
         fN3xOWDBrZmhBNfRrVUoyObVVVgHxNJKSCigNBBOsLQ993mMm+7454RgsxRay76qf9mp
         C1gQ==
X-Gm-Message-State: AOJu0Yynmih/Y8dJVkpMDmUvu+FhpWnhP9Gk+Z/C/Th9s8AL/4+nXO2R
	clvOGaJLCAT3IkY2Xz6t0Fz0bbvRO2sfPMQ4j81c9v27zXXogq0bmJbjQstdoDjKzR9joE3gGly
	fnrmxFNiJ5wftAv28wZzX36UTg1c9M+eZ
X-Google-Smtp-Source: AGHT+IHKivPHE4Q9RFoDXkBxVE5SFUxlz3dSi9NzkvkXQZwzpIu2tNRFvtcScrozmKB9ipRfQWKo0c+DcM33qXJaSyo=
X-Received: by 2002:a17:903:2303:b0:202:100f:7b99 with SMTP id
 d9443c01a7336-20546132a1emr108614275ad.22.1725336926851; Mon, 02 Sep 2024
 21:15:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <mkl@pengutronix.de> <mailhol.vincent@wanadoo.fr>
 <davem@davemloft.net> <edumazet@google.com> <kuba@kernel.org>
 <pabeni@redhat.com> <20240831201643.331810-1-ak.alexander.kozhinov@gmail.com>
In-Reply-To: <20240831201643.331810-1-ak.alexander.kozhinov@gmail.com>
From: Vincent Mailhol <vincent.mailhol@gmail.com>
Date: Tue, 3 Sep 2024 13:15:15 +0900
Message-ID: <CAMZ6Rq+F5GLGo_uuCm1Bj7gA5LgH_NbRTLJJ=hWisgV1DWyNsQ@mail.gmail.com>
Subject: Re: [PATCH] can: gs_usb.c: add usb endpoint address detection at
 driver probe step
To: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
Cc: linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

Thank you for the patch.

On Sun. 1 Sept. 2024 at 05:17, Alexander Kozhinov
<ak.alexander.kozhinov@gmail.com> wrote:
>

From the discussion you had with Marc, it seems that this patch is a
bug fix, right? Then, it is important to put the Fixes tag so that
this patch gets picked by the stable team so that the stable releases
also get the fix. The fix tag syntax is also explained in the link
which Marc previously shared with you:

  https://www.kernel.org/doc/html/latest/process/submitting-patches.html#de=
scribe-your-changes

> Signed-off-by: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
> ---
>  drivers/net/can/usb/gs_usb.c | 36 ++++++++++++++++++++++++++++++------
>  1 file changed, 30 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index bc86e9b329fd..5f10cd9bced5 100644
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
> @@ -1421,6 +1421,26 @@ static int gs_usb_probe(struct usb_interface *intf=
,
>         struct gs_device_config dconf;
>         unsigned int icount, i;
>         int rc;
> +       struct usb_host_interface *host_iface;
> +       u8 ep_in =3D 0, ep_out =3D 0;
> +
> +       host_iface =3D intf->cur_altsetting;
> +
> +       /* check interface endpoint addresses */
> +       for (i =3D 0; i < host_iface->desc.bNumEndpoints; i++) {
> +               struct usb_endpoint_descriptor *ep =3D &host_iface->endpo=
int[i].desc;
> +
> +               if (usb_endpoint_is_bulk_in(ep)) {
> +                       ep_in =3D ep->bEndpointAddress;
> +               } else if (usb_endpoint_is_bulk_out(ep)) {
> +                       ep_out =3D ep->bEndpointAddress;
> +               }
> +       }

The usb_find_common_endpoints() and
usb_find_common_endpoints_reverse() helper functions do something
similar to what you are trying to achieve here:

  https://elixir.bootlin.com/linux/v6.10.7/source/drivers/usb/core/usb.c#L1=
18

Can you refactor your code to use these helpers instead?

> +       if (!ep_in || !ep_out) {
> +               dev_err(&intf->dev, "Required endpoints not found\n");
> +               return -ENODEV;
> +       }
>
>         /* send host config */
>         rc =3D usb_control_msg_send(udev, 0,
> @@ -1466,6 +1486,10 @@ static int gs_usb_probe(struct usb_interface *intf=
,
>         usb_set_intfdata(intf, parent);
>         parent->udev =3D udev;
>
> +       /* store the detected endpoints */
> +       parent->ep_in =3D ep_in;
> +       parent->ep_out =3D ep_out;
> +
>         for (i =3D 0; i < icount; i++) {
>                 unsigned int hf_size_rx =3D 0;
>
> --
> 2.43.0
>
>

