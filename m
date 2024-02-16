Return-Path: <linux-can+bounces-284-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CA285737D
	for <lists+linux-can@lfdr.de>; Fri, 16 Feb 2024 02:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167E4282BF0
	for <lists+linux-can@lfdr.de>; Fri, 16 Feb 2024 01:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78FAFBE5;
	Fri, 16 Feb 2024 01:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GC2i4piO"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E040FBE9
	for <linux-can@vger.kernel.org>; Fri, 16 Feb 2024 01:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708047482; cv=none; b=iRUN6UJLc9V8V4YCrAqj2w5jAo57e/b7nm1gSMELUkWoFp/KnbQ8VxNqNynt+tbLwZotEs3qIxU33/DM8engDnUFGscvxVW2VBdv3uFKK/zUlSDPMJffo2KdKsjM3R366m17M6RE8qNExoRyR8FxZRAWNSjFmLuNFj2UXmU/4Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708047482; c=relaxed/simple;
	bh=tDvB4cbSYafEGvBh1MhSfA+TvReQZIVYdgTxlFLMF/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KwZLnnJhFx+UUzrRMAB9kW7f6oOKnh/ScOgC3HCvNTB7rIUFbnH3yp2BcATa3mpbEf92228hoEl5fkLNCgvanW5nfW3jk40mDIpri8b+l6icjFxNHRTCZSH6xlMS27g40H6Ev60TRP37GkUKgTgSZgw2ixVjgvenPH0zbfK3Ndo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GC2i4piO; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-296df89efd2so211665a91.0
        for <linux-can@vger.kernel.org>; Thu, 15 Feb 2024 17:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708047480; x=1708652280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PqtbmtCI4E+mhoi05yD2aOO89O9jPfXSy8h1tKW6JQ=;
        b=GC2i4piOOWAHDNbJ9ndV75CyUwx7NYZehN3sBKNJnCEbm4FRXIA3QPfc7I27z2MFH6
         bAdxd90QWA8fqDLG9gKQxtj05PmFaiW65IovfFkO3mIWYF+43XWC2xJXmQX804Bws+4M
         ngaYZuATE+W0UTVY16/KFSE15LXF/ECzkIWeOhT8MdkXechkNTBDJ7B7hYjHPOIBMHcb
         6WfwiDqEnKfghJzJPYQwQNA+yc2eK4jdutR5IQmpUVL5hXIRza1C/wO2i3F5xE33x/E7
         Gw5ahyLqdDcM/5yGF+FZ7496/Hf8cTBDCLP2CI6THdSTciwYyBEQjyjOk9z0P10eIecA
         tTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708047480; x=1708652280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/PqtbmtCI4E+mhoi05yD2aOO89O9jPfXSy8h1tKW6JQ=;
        b=d9IGPVJvHsNyaND8C5Y2h1VoYtuqlW9ix+suWK27lqnP3inIGRhOh2AhgrNlZepZw5
         GnYOFbps+4Q9lVBxFoPwNZVlUIOwwVdVJq+Ts44BQsS748DU9bRMl02U8HI7CReyf6GJ
         0s53ORKYQMiOGkJIOmJn2VPat5wXJdaIwxgo9fKlpoqgUOWDHCXp2vIsP20qCpoJ4IfP
         z3YfTNDn3rx11U7pRA90SDXsEhWLI5a4oJPaeMIMLYoQ0qU+r2vhIDGh7lxRqqOMsTMR
         hlg+s27Uy7kBeFWieuddTlzW/mmKDPEzdPziwio3yNA4h+mUdLEz7i0aDHb4gaRpjDXh
         VOEw==
X-Gm-Message-State: AOJu0Yy00yp8j5wdpWpQBGzmK0CLbKOqwawXE/FffumQ48iJrAZmCYL4
	k3+qqAsqaUXBz8E+/zi//ZViX25nztIuz315BtLPzee20hG19vRbaTUkoKGm5lGnQ+t3vJvRiK7
	dkhDb3B49mxJaAPx8+B2hnETRBhWdyIF/9A4=
X-Google-Smtp-Source: AGHT+IE4oZIeWKx/D5J6d9Rh2x2Vb5LsFStKsc3SZkPpxxbG3Sio+uJppW4wgILuO91QGnlM9+wIf87p47liZ3k2xZ8=
X-Received: by 2002:a17:90b:f89:b0:299:b81:86fd with SMTP id
 ft9-20020a17090b0f8900b002990b8186fdmr2907217pjb.44.1708047480283; Thu, 15
 Feb 2024 17:38:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215152656.13883-1-s.grosjean@peak-system.com> <20240215152656.13883-3-s.grosjean@peak-system.com>
In-Reply-To: <20240215152656.13883-3-s.grosjean@peak-system.com>
From: Vincent Mailhol <vincent.mailhol@gmail.com>
Date: Fri, 16 Feb 2024 10:37:48 +0900
Message-ID: <CAMZ6RqL=qp9OHVny92Qt9wyY7eU=3dm2aQRChvCBkAfnj2jqng@mail.gmail.com>
Subject: Re: [PATCH 3/3] can: peak_usb: fix potential kernel log flooding
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi St=C3=A9phane,

On Fri. 16 Feb. 2024 at 00:27, Stephane Grosjean
<s.grosjean@peak-system.com> wrote:
> In rare cases of very high bus load, the firmware can generate messages
> warning that the receive cache capacity is about to be exceeded.
> This modification prevents the driver from flooding the kernel log with
> messages and memory dumps that are far too verbose in such cases,
> by limiting their production to once per session.
>
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---
>  drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 36 ++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can=
/usb/peak_usb/pcan_usb_fd.c
> index a1c339716776..d444ff0fa7cc 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> @@ -70,6 +70,7 @@ struct pcan_usb_fd_if {
>  struct pcan_usb_fd_device {
>         struct peak_usb_device  dev;
>         struct can_berr_counter bec;
> +       bool                    rx_cache_warn_handled;
>         struct pcan_usb_fd_if   *usb_if;
>         u8                      *cmd_buffer_addr;
>  };
> @@ -667,6 +668,28 @@ static int pcan_usb_fd_decode_error(struct pcan_usb_=
fd_if *usb_if,
>         return 0;
>  }
>
> +/* Handle uCAN Rx cache warning messages.
> + *
> + * Such messages SHOULD NOT occur. If they do, then this might come from
> + * massive PING host flooding that prevents PCAN-USB Pro FD HW v4 to han=
dle
> + * CAN traffic anymore. In this case, the driver itself manages the disp=
lay of
> + * the warning message.
> + */
> +static void pcan_usb_fd_handle_rx_cache_warn(struct peak_usb_device *dev=
,
> +                                            struct pucan_msg *rx_msg)
> +{
> +       struct pcan_usb_fd_device *pdev =3D
> +                       container_of(dev, struct pcan_usb_fd_device, dev)=
;
> +
> +       if (pdev->rx_cache_warn_handled)
> +               return;
> +
> +       netdev_warn(dev->netdev,
> +                   "Rx cache size warning! Possible loss of frames\n");

Did you consider using netdev_warn_once?

  https://elixir.bootlin.com/linux/v6.7/source/include/net/net_debug.h#L46

This seems to do pretty much what you want.

FYI, the net_ratelimit() may also be helpful here:

        if (net_ratelimit())
                netdev_warn(...);

> +       pdev->rx_cache_warn_handled =3D true;
> +}
> +
>  /* handle uCAN overrun message */
>  static int pcan_usb_fd_decode_overrun(struct pcan_usb_fd_if *usb_if,
>                                       struct pucan_msg *rx_msg)
> @@ -768,6 +791,14 @@ static int pcan_usb_fd_decode_buf(struct peak_usb_de=
vice *dev, struct urb *urb)
>                                 goto fail;
>                         break;
>
> +               case PUCAN_MSG_CACHE_CRITICAL:
> +                       pcan_usb_fd_handle_rx_cache_warn(dev, rx_msg);
> +
> +                       /* Rx cache warning means possible overrun cases =
in
> +                        * the device.
> +                        */
> +                       fallthrough;
> +
>                 case PCAN_UFD_MSG_OVERRUN:
>                         err =3D pcan_usb_fd_decode_overrun(usb_if, rx_msg=
);
>                         if (err < 0)
> @@ -885,6 +916,11 @@ static int pcan_usb_fd_start(struct peak_usb_device =
*dev)
>         pdev->bec.txerr =3D 0;
>         pdev->bec.rxerr =3D 0;
>
> +       /* warn of a cache problem only once per session, to avoid floodi=
ng
> +        * the kernel log.
> +        */
> +       pdev->rx_cache_warn_handled =3D false;
> +
>         return err;
>  }

