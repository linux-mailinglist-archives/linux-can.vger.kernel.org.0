Return-Path: <linux-can+bounces-8109-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EnXKFiZjTWrLzAEAu9opvQ
	(envelope-from <linux-can+bounces-8109-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 22:35:50 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BABE671F90F
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 22:35:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=PjJe3hdm;
	dmarc=pass (policy=none) header.from=asu.edu;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8109-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-8109-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7ACC301CC37
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 20:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200A73EB0E4;
	Tue,  7 Jul 2026 20:35:48 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E533E557C
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 20:35:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783456548; cv=pass; b=hPjLWvGCWDaS8yE33SF7h3uIwmnVWb53CuCnbWCzPhF8oWtdLpe9UaUtkqL2P2KiUzKnG1mzyOr9I8a7GDOSjz7AlhrNXxfa6AIijDrHIn5lXXc0APWAcs8dulTLXIavk5PqYf0I29wXEyCxHe40IliTB1bVcldmyn630zqE25Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783456548; c=relaxed/simple;
	bh=iiZfiNLvQe753e5CbGbo/rwkzNBEF4NJy9hV6bLGPQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bSFas8ez1u1nahDcKRcv2X2dVC9rDfCY27+LJfIe0c+Dou+OPQLuEX86p4vU2Unn5PEhRCnR3EjbCAfCrAyPl+8M6bR8Dwg8qUj+iJjVBaH5s6uDDIoyBQxpum/8pyPOTVp0yLKfwgj/m8GcO4kB/MkiggG/jKt4tWRf1x9qMZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=PjJe3hdm; arc=pass smtp.client-ip=209.85.216.49
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3811f512167so4422024a91.3
        for <linux-can@vger.kernel.org>; Tue, 07 Jul 2026 13:35:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783456546; cv=none;
        d=google.com; s=arc-20260327;
        b=Q1wNNL1dhQRwUYb+7O0RFFIHa34kvJxZsqNQCWOLEpaNAISQtTTBuffq2iT1bUaCqH
         /a7N4AQV0UvYktRyBZaJHHeSk1ZRtEd77snK/mTc3iCZVO3dcWAbrWma2daNd+HaCWCu
         C+T92CfjBDWqypWsf7y+TDGP9tzQw0KNQJvWx50gKomD14q0nigO/s9MtzCIMOn9QXzC
         mRrQdvxXqE3KbAI/agnD6LwX/gq42mk3aMU9qpcNOw0Zb/1bMKa1K1ioyCsab0q6okEu
         TPeJdE0S4pgWHfULQBqQr3mZWeModSYBQ7owdMURVUiBHTSrJomkIzrp0aee1dPQWVRH
         3z/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H6gF5hZRgMsv9HwOUXibH8yAddhJAsk4+IJHjYkOaeY=;
        fh=IDuPt37eTTW10sEFRdGi4ZpEMqnEEWT0w81Pi2AE8xQ=;
        b=dIEZKCgheUDn5c8XJiYN0pI4AybJ0x6aSpqK4e7hmc6wnsgjYuHN6z80JzrVklEpE7
         9jbBIzcS9PhQq9ogfhJOW6zZpSHxvoeccJGuZ63erG8KD5Jr39uqDr44etM0vJZNIjuU
         WGb+IXBX0DPv/htAa9nbmKu02aHADArz/aEJPjIPhzUR6BleO9fkrOjcKbkygoTy/Jfe
         tTPd6NtAwvvFIcunz0fV8qdZqfSGBoFRo/+AQ0Vdflyxc53BkzIWs8RzOM6YS//IHWJp
         Hg26WwovpoLnUq31xmso0SssozwfiHMMpINU7Jg8ArODCmkrxSiqEIlyilOLufdSSKC1
         NrWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783456546; x=1784061346; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H6gF5hZRgMsv9HwOUXibH8yAddhJAsk4+IJHjYkOaeY=;
        b=PjJe3hdm/HZk/U/BIZO2XoztkbxhkvtDQ5CuSxT+rSsn2Sf+USPurcqX96pRBUnS9H
         mrlBmvThziCt5xlvGQrpm5cGzQBp8KXyYs90D5oSsVgjNOww7dyany200xdAvCmc1CYh
         +SPIuFGoRx7aiUqDJ65xQBzTOqmKCfg7OG+OEF65a/OlmRi21bsHx0vn93w3xY1j9v+u
         vcjWQDGo7d6hWT+rBQPRXNqvgfLrLncgA9LDL+u3/neEJhDQRqVX+jEq/Z2r8eauPAij
         Sf2ifdDVJGAe28aQYaxrA8JaMTGZdH+iZo3MzLm5d8/t207ZB9T8S+Xk5Bisf3kleabs
         Y8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783456546; x=1784061346;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H6gF5hZRgMsv9HwOUXibH8yAddhJAsk4+IJHjYkOaeY=;
        b=S145ouGBCRfCsnlAtR+7+HQwi8SMvU2B4hJekuzManqoQNJRG6Y1sncudx7I/5yXjK
         lJ2XInwqAjhdr2qU9oBmA2XHOtkwDm6vaD+CvouPI735PM/bzqviuRAaHDm9/qSq5U25
         CmDGLiedCcsOn3JpdirDxXVgw8pnzcyLRGm3CJdeBgnuFTCzLLLRNeGX8XiVboHGUpEg
         hyOY26f1sXm5DyAIVvD9VkZyup6GAsIalNKatZYIu0/fzEET1qBCC9GNzoZKDHNxozPq
         wYJ6qWA9NyyeVtXw4FRf8mLzSGxJg5ndShfRch9wsCyncFIrPGu2dnK/QtllJ92XM1HP
         DaUA==
X-Forwarded-Encrypted: i=1; AHgh+RrXrkDOWXShKbI+LOPToAFa7PHP6ilyk7dZ/4WqjpTI1j+EH20/Y41Mt90RNgrpFkUI564TxgtR1rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YydWXy3eTkB+q71PrOjjdfXAbLS1e+F9CLqrmHaA0T0pFN5vFf6
	DVlG7AWWe3FeC/0ZqJ0oH+i9pBwI178cDzbHcI5DcPvjl5P9ZaGnw48qbDtE/X4oNFTX9FXYAJM
	ksnU16qk5VH5IZl71NKzPpICNEbBsnKE1hgwMaTjg
X-Gm-Gg: AfdE7cntgGrgDijSFecbSF3DPHQM3yyVZ+JhB36xny8IlZvi0JhrF+z5AgnI4xR+Uop
	XnLwGIQTBagFVTiO7xOvdT+pns3sQmT8yqgdgXk3qmY8Xke6LBghWMkv1s85dWkGaTYgfOBntTf
	68RAqotOxgpPv8znnpbo+R/Yb702SIYSvAiboYPiOx9No1yoFwUx8jQVkcJRGa4PSK5oxr7IPkL
	cYXkbRyR2Si0qBy0i5gGW1zEwpIR6b6wxlje8/hUalhCbv5RwVF9O8V5R+Mk6jnBCMSnI5Vw5Na
	/DqnkNKl9gLPyWtTj1y1hmT8EOwj
X-Received: by 2002:a17:90b:2604:b0:381:a766:efcb with SMTP id
 98e67ed59e1d1-387565086a8mr6741808a91.4.1783456545860; Tue, 07 Jul 2026
 13:35:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260705010005.1169943-1-xmei5@asu.edu> <20260705011358.6D2181F000E9@smtp.kernel.org>
In-Reply-To: <20260705011358.6D2181F000E9@smtp.kernel.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 7 Jul 2026 13:35:35 -0700
X-Gm-Features: AVVi8Cf5Fhcp-fmRuS4_CBozkIoQj-q5uUFd0omIdRZhH_1Kd3O9_nhaokPHsN8
Message-ID: <CAPpSM+TQv51ebrx_J2o3GKskGUUZP3G4-XAFj0mMSkZcH5-VDA@mail.gmail.com>
Subject: Re: [PATCH net] can: esd_usb: free_candev() after unlink_all_urbs()
 in disconnect
To: sashiko-reviews@lists.linux.dev
Cc: Vincent Mailhol <mailhol@kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:mailhol@kernel.org,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xmei5@asu.edu,linux-can@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8109-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BABE671F90F

On Sat, Jul 4, 2026 at 6:14=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Moving `unlink_all_urbs()` before `unregister_netdev()` introd=
uces a memory leak race with `esd_usb_open()` on the RX path.
> --
>
> commit f21a9588c02c39e2094757bcdada4fb7aca593c8
> Author: Xiang Mei <xmei5@asu.edu>
>
> can: esd_usb: free_candev() after unlink_all_urbs() in disconnect
>
> This commit fixes a slab-use-after-free issue by killing URBs before free=
ing
> the CAN devices.
>
> > diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_us=
b.c
> > index d257440fa01ff..34c0ca1872839 100644
> > --- a/drivers/net/can/usb/esd_usb.c
> > +++ b/drivers/net/can/usb/esd_usb.c
> > @@ -1385,6 +1385,7 @@ static void esd_usb_disconnect(struct usb_interfa=
ce *intf)
> >
> >       if (dev) {
> >               dev->in_usb_disconnect =3D 1;
> > +             unlink_all_urbs(dev);
>
> [Severity: Medium]
> Does moving unlink_all_urbs() before unregister_netdev() introduce a memo=
ry
> leak regression by racing with esd_usb_open() on the RX path?
>
> Previously, unregister_netdev() ran first, providing rtnl_lock
> synchronization. Now that unlink_all_urbs() runs before unregister_netdev=
(),
> esd_usb_open() could run concurrently if the interface is brought up at t=
he
> exact same time the device is disconnected.
>
> If this race occurs, unlink_all_urbs() could scan the buffers while they =
are
> still NULL:
>
> drivers/net/can/usb/esd_usb.c:unlink_all_urbs() {
>         ...
>         for (i =3D 0; i < ESD_USB_MAX_RX_URBS; ++i)
>                 usb_free_coherent(dev->udev, ESD_USB_RX_BUFFER_SIZE,
>                                   dev->rxbuf[i], dev->rxbuf_dma[i]);
>         ...
> }
>
> And concurrently, esd_usb_setup_rx_urbs() could allocate them immediately
> after the check:
>
> drivers/net/can/usb/esd_usb.c:esd_usb_setup_rx_urbs() {
>         ...
>         dev->rxbuf[i] =3D buf;
>         dev->rxbuf_dma[i] =3D buf_dma;
>         ...
> }
>
> Could these newly allocated DMA buffers be permanently leaked since
> unlink_all_urbs() has already completed its cleanup pass?
>
There is no leak race. RX buffers are only (re)allocated via
esd_usb_start() -> esd_usb_setup_rx_urbs(), but esd_usb_start() first
issues the IDADD control message. On a disconnecting device that
send fails with -ENODEV/-ESHUTDOWN and esd_usb_start() returns before
esd_usb_setup_rx_urbs() is reached, so nothing is allocated after
unlink_all_urbs().

This is also unchanged by the patch: the original order (unregister_netdev(=
)
first) has the same property against a racing open. The patch only moves th=
e
URB kill ahead of free_candev() to fix the UAF.

Xiang
> >               for (i =3D 0; i < dev->net_count; i++) {
> >                       if (dev->nets[i]) {
> >                               netdev =3D dev->nets[i]->netdev;
> >                               netdev_info(netdev, "unregister\n");
> >                               unregister_netdev(netdev);
> >                               free_candev(netdev);
> >                       }
> >               }
> > -             unlink_all_urbs(dev);
> >               kfree(dev);
> >       }
> >  }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705010005.11=
69943-1-xmei5@asu.edu?part=3D1

