Return-Path: <linux-can+bounces-3624-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F86AC05CC
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 09:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D2269E4C59
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 07:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8E3221FD6;
	Thu, 22 May 2025 07:33:59 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E40C3234;
	Thu, 22 May 2025 07:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747899239; cv=none; b=b66au5RPCMgE5UeGUTSnEQKA8kVD80ee5cGVJqU5xCH1SRF0w6jXESPsHhdun/x/R/Ow8PZaE/MBFKJBRIW2+7nA8y8nkpd2mjYiiG7m7QjMvtc3pguy09FCGGnT9XDlB0iUvVAU169RcdxUYOH9lykCCSFafGCq+15frLPX4F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747899239; c=relaxed/simple;
	bh=afyt6vYfbzReFuh6xX3pKfOpek+1H61IQUVeBZj8jEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eXypGXYQt+r/qfnmoqyO6424xK/GDIv1zLLEwLju0c8Kot9nGA/CymLCs6LgcJTz2ECZMaqUFIQClGfKqcuo5N9bCd8dsrPHd3dk81ZzSDYQ6WxjXiq/N2AiDqJWE9bbQU/E3j/aqmGRsrSl8/1hR7dxCN+IXT/qSQlSSf+d728=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5242f137a1eso2377987e0c.1;
        Thu, 22 May 2025 00:33:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747899235; x=1748504035;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X7KW42M2nPHRBzgnk6YsRbRV24Eym9REz3RjLED1wag=;
        b=I1OExxbLDyUAkVZhhoEZyCilMQkquKKGH+LI/QJArc5rQWkQSVx8AXYeGWxNkTb5oy
         jQgFQyNjQc0D+J7yQui+1/D12E1+azdMWI+PDsFJr2X1+I+sXPIiOQvh6OhyC6dXOHZp
         4vloLPdrzcBZQqqZbPtmnSD9aB7p6YV4XFoyGM7LSPyzDE7liZ21FhMjSp7oPCWYkQYC
         8sJpbhW1wYJpVA8xOdAt3AnnmT5UtZAeb1TP0uX0opSiTPjLOcXfDmxIKvhLicVBR2SP
         apxX3QKoxjibfj9LTFgMRMnciHSo9/tSo0x++9lsJRlqicLaa69mJQ8S/UHfIh+U3vNp
         OsZw==
X-Forwarded-Encrypted: i=1; AJvYcCWw7CsoLgcnJanHlpOs2YWXm2n1pOYOVvfTDUOkW1xAQZFj52fWFGEcWVoX+76DgQet5KCte6Ip@vger.kernel.org, AJvYcCX2dBlsx+hu7I6nDDCCzgXiVm4yll+BbuAEL90dHP5kKWyjzE2XuYKtiuppjHOAc374tbj/TYrsL7Y=@vger.kernel.org, AJvYcCXgJkzdDfR9BK426nRGmt8iK3l49IaTsn4HMdCzeqeb+go/9dw5zZwz+DBQCw2xjlLqLa45Zk1UzH4U@vger.kernel.org
X-Gm-Message-State: AOJu0YxiIKpWS1LsDdtG4Syg3DVtOaZUCr6QdoDT5C/Ecy/c4XMl5ahc
	9lFzEWRkK55xy8JgKr+DMsSoqNO1GbQJCRUC2wR6/60lyNQwQZ9Qyn/HzAxa2mNy
X-Gm-Gg: ASbGnctW+p3hBoTw05omx9MgU5hwKGqNOf46lh6qoxspkMLqKnjBaXJIhRdozFFAjU5
	js/y/NQw5EWKukl2pi2WTGyLWBOUuDBVZ+IzllaVUzs8LSG9pw3heQH7OUTg/DZaZibm89iz2ki
	kbDF8mepiynz9VT0uvFZ1GIQGEkjk5wl3gR7MpOuwxX4tZ7Jl6N5z8BAuFT1+8MmdX2f8nKkzu7
	c6hDUX++u4tZICVbMvdLSDLHbEPixOoYn/hWUg57ZuDoZ45gNgOxgT25jOHDn5zPnoMFbIyYRIa
	QdDRadtvTZCZJy9QezE6fpQWhcDmg0A54hYtJTBQLrMnOycI/X//D+tw8tcQHOtFjrL9DOqCX/Z
	3lzLLvOxDn+J/HA==
X-Google-Smtp-Source: AGHT+IHikIZLZ1dZSgH/RR2Hdv8CSv8vbOX08ARUI5So85blok34d0/WyJjUj46TinX6Rt76XAidYA==
X-Received: by 2002:a05:6122:a1f:b0:527:8771:2d39 with SMTP id 71dfb90a1353d-52dbcd6d66dmr19724074e0c.7.1747899235036;
        Thu, 22 May 2025 00:33:55 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52dba910901sm11367008e0c.2.2025.05.22.00.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 00:33:54 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4e14dd8abdaso2061520137.3;
        Thu, 22 May 2025 00:33:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQOsYvbTuRwXmLJS9UUXZGOsFd+L7QMvKR5welDqXnMH9wBqGnzpNKnCPe+pv5DfPBfO2+xHPpxfc=@vger.kernel.org, AJvYcCX+4R3Iz2nSf4Ps108yyz+lYgUSc47F2Cq/agLTUYYoG+iC1HOlFydgisr1QzA3W58uHXPgOEtH@vger.kernel.org, AJvYcCXI36llW902E4N2dEAsdFPZqUA5cO08XogZ3ovDmByput4ZFLitE4Hc+0fUW1/DrpvZ8/ObKaEzrA1X@vger.kernel.org
X-Received: by 2002:a05:6102:b06:b0:4e2:aafe:1bb7 with SMTP id
 ada2fe7eead31-4e2aafe1e8dmr8036440137.15.1747899234351; Thu, 22 May 2025
 00:33:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a679123dfa5a5a421b8ed3e34963835e019099b0.1747820705.git.geert+renesas@glider.be>
 <20250521-ancient-discreet-weasel-98b145-mkl@pengutronix.de>
In-Reply-To: <20250521-ancient-discreet-weasel-98b145-mkl@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 May 2025 09:33:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXVbBciPriF6wWBUE0FHs3ZfEHAodFOsACiaMCEbLKpeg@mail.gmail.com>
X-Gm-Features: AX0GCFthFAH_k5GLf92vZ0TJkMlPKuOGRFvQs0hIExouVBk96m2MS6fQ5ujhrd8
Message-ID: <CAMuHMdXVbBciPriF6wWBUE0FHs3ZfEHAodFOsACiaMCEbLKpeg@mail.gmail.com>
Subject: Re: [PATCH] documentation: networking: can: Document alloc_candev_mqs()
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Jonathan Corbet <corbet@lwn.net>, 
	Wolfgang Grandegger <wg@grandegger.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marc,

On Wed, 21 May 2025 at 12:07, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 21.05.2025 11:51:21, Geert Uytterhoeven wrote:
> > Since the introduction of alloc_candev_mqs() and friends, there is no
> > longer a need to allocate a generic network device and perform explicit
> > CAN-specific setup.  Remove the code showing this setup, and document
> > alloc_candev_mqs() instead.
>
> Makes sense.
>
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Dunno if this deserves
> > Fixes: 39549eef3587f1c1 ("can: CAN Network device driver and Netlink interface")
> >
> >  Documentation/networking/can.rst | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
> > index b018ce346392652b..784dbd19b140d262 100644
> > --- a/Documentation/networking/can.rst
> > +++ b/Documentation/networking/can.rst
> > @@ -1106,13 +1106,10 @@ General Settings
> >
> >  .. code-block:: C
>
> This breaks the rst rendering. I think you should remove the "..
> code-block:: C"...

Doh, how did I miss that? Will fix...

>
> >
> > -    dev->type  = ARPHRD_CAN; /* the netdevice hardware type */
> > -    dev->flags = IFF_NOARP;  /* CAN has no arp */
> > +CAN network device drivers can use alloc_candev_mqs() and friends instead of
> > +alloc_netdev_mqs(), to automatically take care of CAN-specific setup:
>
> and add a second ":" after "setup:"
>
> >
> > -    dev->mtu = CAN_MTU; /* sizeof(struct can_frame) -> Classical CAN interface */
> > -
> > -    or alternative, when the controller supports CAN with flexible data rate:
> > -    dev->mtu = CANFD_MTU; /* sizeof(struct canfd_frame) -> CAN FD interface */
> > +    dev = alloc_candev_mqs(...);
> >
> >  The struct can_frame or struct canfd_frame is the payload of each socket
> >  buffer (skbuff) in the protocol family PF_CAN.
=
Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

