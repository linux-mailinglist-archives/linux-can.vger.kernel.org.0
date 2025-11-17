Return-Path: <linux-can+bounces-5462-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9995CC637C1
	for <lists+linux-can@lfdr.de>; Mon, 17 Nov 2025 11:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56D8F4EED43
	for <lists+linux-can@lfdr.de>; Mon, 17 Nov 2025 10:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C992B329E66;
	Mon, 17 Nov 2025 10:12:58 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C7F32937E
	for <linux-can@vger.kernel.org>; Mon, 17 Nov 2025 10:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763374378; cv=none; b=KlVsFwsYN3LVZrzwwm22/8Uug7eDXEC0p3jzk7akS1lFRB1Z3OtXDAnfhav56yD/epQ4rCWTIAiw5+hbzIaWmifEQJax3MrrVyGZtjimNh2tnl3mdxQmiJ65mcvzV1M6z7Tc6I0GdApgV1YdfBZ/TcHG9cDC1fxQu1Yocxdb8b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763374378; c=relaxed/simple;
	bh=GDOM+0gYiKkhyCkDjVnvHjHMXUKJ91og6WK5WoSGmVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BvN22phyCC/zcSt7GODxBeioIrgmpS+1UXyB6qmBU5NqfHLTsCa7+FYbB6/aXvSn7BtIlBpimlD57BLWy1ahYSbv+pIGju7NEmuR3znARduZ9GM2PfmYeUcu79teR3zM0APMNME6jbiJbecrpGrra8P0s7DpZRqpvMeEKlDRa0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-559748bcf99so3302464e0c.3
        for <linux-can@vger.kernel.org>; Mon, 17 Nov 2025 02:12:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763374375; x=1763979175;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwmIm0bgwineetBBRefqzkv/ZlLUD6Hn/jhQ8fYgpUo=;
        b=FjArrQqLTsdhOgh3thpjaL6kZRrsbBmSvh/bjDUvrJcjLVB6uSnFK2zTHpJrUqAhIY
         qsJlswY4Sr7hc4CZ5HL//Z6lblIDBScb1DC0Thq0+Av76fKFQYYAr8AL9zHSizVJW5n4
         8TWOhKKjBhFI6HfuQcJtWXkVXkryAxVGjASRj3rNIZtDCIvp3yyfP4+j3eips7ATGboE
         Bli4sjhFmJBrB5lGnsR1dHojVPgaPpNwYS1NcrQICJGuLDFmOvdeOmUY42qS/7NW5pPE
         oIm5etDRR7otq5rpq+0J39AFhNrDHjXfUkgT+pkiyzZRwUCYNxnYmhTA0MAZqb/n0iQZ
         rhmA==
X-Forwarded-Encrypted: i=1; AJvYcCXnau3yUHzvlPCS4MOu4EB/+tiH38NjSK7k9vr+3Pk7uCuNmcNGC8+fJaXIO+99E2UKas9hM1k6cjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzad4cuoZssxoAMbL/Deqo6rUy6zQ5fGiMrmOhy7jk7QWqRC13H
	1BkNuEj61D2YF1jV/b34Whe9ckhplUE31SACGkrzU0cMUd3bZBb1+tLC2Ru3JAFA
X-Gm-Gg: ASbGncuzd3ODdXXFkfJp/Q3qmoGgop3+WuBH2tkYW0JIjUzatDlNOfbyjNiCaoI9n6+
	Nm+bpUNYZREjNzvNGPWT2NQ1+h1vZcwBJaBU7KTRAIEFq7Zo7I5N2bJk8JxmBOuPQrAQr4/vvwz
	2HY8WX/ptZG9SYSRn0fpwReW61h5OtxdQSdBB18sw39+w98GEdhr8fZAXHuIEuuQsy2n3SpNstE
	iWa4rqTcZfqRRWQuNJHk1wmTFetHcTok1q9//t+nN2hkivwakBNxEHA970/plrYabui7viuDyUJ
	/02dvvLS5P9DYGbKMEFHK719bpRuJ3IMscg2y1YlwTWzwna+ib4W43wAtgPmHofcj4HwTj+1p8/
	LnTHVScAILmTUmoRMtBHta+RlRNoVayq1aF3fH3yGpHinfK0Sg3Os1fZVqkw8X6m6aWhrviCVJj
	zw/5slr5KhoeTZkHVu2Lgrg/OSZwRBxvIp3N4os7X3dKFZyszDlFIZ
X-Google-Smtp-Source: AGHT+IHmHHe5eT1ckiaqbLQDy9z3eDBpIvImt15KtBF/LndmfUh/Xl3ME1/eIxhJu3K2VTx+1/jccA==
X-Received: by 2002:a05:6122:8d6:b0:55b:305b:4e40 with SMTP id 71dfb90a1353d-55b305b7368mr1824509e0c.17.1763374375241;
        Mon, 17 Nov 2025 02:12:55 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b0f32e47asm4150930e0c.1.2025.11.17.02.12.54
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 02:12:54 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5dfccb35b10so1733054137.3
        for <linux-can@vger.kernel.org>; Mon, 17 Nov 2025 02:12:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVtUrYkEYuOP7OoaQoOrbG1qF94Ha99X/sGC9b1hxUI5szyJYWOaWZ+Axw6/07mxRhbcG7GZw3LkMg=@vger.kernel.org
X-Received: by 2002:a05:6102:290c:b0:5db:32dc:f05b with SMTP id
 ada2fe7eead31-5dfc5bf1b06mr4258951137.42.1763374374287; Mon, 17 Nov 2025
 02:12:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030120508.420377-1-biju.das.jz@bp.renesas.com>
 <20251112-warping-ninja-jaybird-22edde-mkl@pengutronix.de>
 <TY3PR01MB11346974232A057A7D5B6EBAD86CBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB1134632B48784F5D72721611D86C8A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB1134632B48784F5D72721611D86C8A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Nov 2025 11:12:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVXSaaoOaECmBQmPyWQA7Z30BVBLfVoF-Uz01GfbFZNGw@mail.gmail.com>
X-Gm-Features: AWmQ_blx-TSIXOAD1fL3P2E09fREtqUZGsBV4Ry1Ow-eJhOSBFBGV1F1fuwPF-E
Message-ID: <CAMuHMdVXSaaoOaECmBQmPyWQA7Z30BVBLfVoF-Uz01GfbFZNGw@mail.gmail.com>
Subject: Re: [PATCH] can: rcar_canfd: Fix controller mode setting for RZ/G2L SoCs
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	"magnus.damm" <magnus.damm@gmail.com>, Tranh Ha <tranh.ha.xb@renesas.com>, 
	Duy Nguyen <duy.nguyen.rh@renesas.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Sun, 16 Nov 2025 at 11:31, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > From: Biju Das
> > > Sent: 12 November 2025 08:47
> > > On 30.10.2025 12:05:04, Biju wrote:
> > > > The commit 5cff263606a1 ("can: rcar_canfd: Fix controller mode
> > > > setting") applies to all SoCs except the RZ/G2L family of SoCs. As
> > > > per RZ/G2L hardware manual "Figure 28.16 CAN Setting Procedure after
> > > > the MCU is Reset" CAN mode needs to be set before channel reset. Add
> > > > the mode_before_ch_rst variable to struct rcar_canfd_hw_info to
> > > > handle this difference.
> > > >
> > > > The above commit also breaks CANFD functionality on RZ/G3E. Adapt
> > > > this change to RZ/G3E, as well as it works ok by following the
> > > > initialisation sequence of RZ/G2L.
> > > >
> > > > Fixes: 5cff263606a1 ("can: rcar_canfd: Fix controller mode setting")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > >
> > > Applied to linux-can.
> >
> > There are 3 modes for CANFD on RZ/G3E
> >
> > 1) CAN-FD mode
> > 2) FD only mode
> > 3) Classical CAN only mode
> >
> > In the "FD only mode", the FDOE bit enables the reception and transmission of CAN-FD-only frames.
> > If enabled, communication in the Classical CAN frame format is disabled.
> >
> > On RZ/G2L, currently, CAN-FD mode is enabled by default and On RZ/G3E and R-Car Gen4, currently FD-
> > only mode is the default.
> >
> > Prior to commit 5cff263606a1010 ("can: rcar_canfd: Fix controller mode setting) RZ/G3E and R-Car Gen4
> > are using incorrect code for setting CAN-FD mode. But fortunately, it sets the mode as CAN-FD node, as
> > the channel reset was executed after setting the mode, that resets the registers to CAN-FD
> > mode.(Global reset, set mode, channel reset)
> >
> > The commit 5cff263606a1010 makes (Global reset, channel reset, set mode), now align with the flow
> > mentioned in the hardware manual for all SoCs except RZ/G2L.
> > But because of the earlier wrong code, it sets to FD-only mode instead of CAN-FD mode.
> >
> > Is it okay to drop this patch so I can send another patch to make CAN-FD mode as the default for
> > RZ/G3E and R-Car Gen4?
> >
> > As an enhancement, we need to define a device tree property to support FD-only mode for RZ/G2L, RZ/G3E
> > and R-Car Gen4. Please share your thoughts on this.

Hmm, Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml:

  renesas,no-can-fd:
    $ref: /schemas/types.yaml#/definitions/flag
    description:
      The controller can operate in either CAN FD only mode (default) or
      Classical CAN only mode.  The mode is global to all channels.
      Specify this property to put the controller in Classical CAN only mode.

> The patch I posted "can: rcar_canfd: Fix controller mode setting for RZ/G2L SoCs" and
> commit 5cff263606a1010 ("can: rcar_canfd: Fix controller mode setting) is wrong for
> R-Car Gen3.
>
> R-Car Gen3 has only 2 modes: CAN-FD and Classical CAN (there is no FD-only mode).
> All other SoCs has 3 modes, CAN-FD, Classical CAN and FD-only mode
>
> R-Can Gen3, RZ/G2L (CAN-FD and Classical modes): Modify the RSCFDnCFDGRMCFG register only in global reset mode.
> (Here the flow is global reset, set mode, channel reset)
>
> Selection of FD-only mode for RZ/G2L: Modify the FDOE bit in RSCFDnCFDCmFDCFG only in channel reset
>
> RZ/G3E and R-Car Gen4: Modify the FDOE/CLOE bit in CFDCnFDCFG only in channel reset
>                       (Here flow is global reset, set mode, channel reset)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

