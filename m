Return-Path: <linux-can+bounces-4522-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 546F9B49062
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 15:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D2A3B3945
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 13:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C7E30DED4;
	Mon,  8 Sep 2025 13:50:27 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8993A30BBBF;
	Mon,  8 Sep 2025 13:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757339427; cv=none; b=d9UNvf7VNUyD98qL9Wp5g/45hnHx1AmUp8krrhl/7gMmQkBV28Y3qweQwVHPjB2BpUp6K+FG0ZWOBw1ZdnXYWK+AtlvoQN6Ro3kP8Tr5dhfl8yus4rFl1iAPjQnQLOq3Lb1bnhfSBGZ01ziyg2fi8/AhW6wnIw5yzX70HkSf4co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757339427; c=relaxed/simple;
	bh=V34JvDqHnn89NzOBpFWeJvdOmcenAISYq7m3Rr0xNtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCIEBhMLX4yt1P1ezo0aA2l7tOT1Xv60AilsW2a6GAIEANgHR2sfHVhTCN+FUFs76cLaejXeZwbMPvYv1aTitOQhsN7qBohcg1jlSJopvIB7sDUTkKWyFEDuQIxVW2zDdNYILmFPYGDkJaDmxAnbfIC+80yBG4/MssIQiaY6AkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-544a55b84d8so1366393e0c.2;
        Mon, 08 Sep 2025 06:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757339424; x=1757944224;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ml761WVy05tdScd/Dv5mha508YSOxsnNTPxMIr+13U=;
        b=fgGTvRuYYxJYEU4ZxAxagZpjlovy7bDYv1IKbyHAx4VBFvl47QDajpCZlGlL2xP8gD
         3D7q7qnhic2xOnuhzYMmsyv+yZvlU5/1qaad9ljOK+qpWhDTe65Oprj5RIa4032Hwldn
         msyHcolJ8ZSw5YJjXojkgMdxfLEHdjozVo2yl+2nsIYoWTWQIgPIgrwaANWVK/0M61HU
         oI6WTUDwDsjCnP/sx82Pvfe0CmRyIIPUQ0WasZVYecndICdMb8mLOX9jkTx5XvA+NnXx
         wq8iEEpel5KMwjarT+rAjw9GYR4qJhsbkIlpEZ9GkM+I4lP6kDZYyW89CVDA8vUr0YzB
         OCSg==
X-Forwarded-Encrypted: i=1; AJvYcCWCnPgwTgBmlO1cDBU35V05myFwYxulD7P9aoF5qOPi99k7C93V3AzRjX3gptJpK+geofESAngBElKU59KNqO5kDnY=@vger.kernel.org, AJvYcCXEVDjOoJJ6LI6sgbKsXZLmOXafKr3b6M9UFZmrXAD5Mzdb46nq57qgpdqFkN2pk3dax2Ohl9RHGng=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrlKt15Wazhs24wcWBRf9IVZ6YNT9mCxHvfpkCB/FQffZGH9TC
	tUAQD1Dxz3CFC1A3UQ8Eu8gU99mgOCfryCFbBi7l0RQeJhnRNSK2AdnvQKCWEdm1
X-Gm-Gg: ASbGncufr/5swQ/jXxwB2eBQXUNQXrkCQ4DYytUcfHNmrKmyLK1P3aXkWd6dOK7Sn/H
	w0pn4zxv2AiecwS0LfYLNEbMToRp+BE1czEF7AJBkvZazFme/aLm2+utocq5uX0c/sQoH3e7ew4
	I1ULwlQ7pWxPLrMe69NQqG640UlLoGwCcnQJad4Xcv1GKTZk0DdTWXJOwR/e8wmdC6YNUq7tV4b
	cITnya58h37Ebspo+tqXf7PJjxWUuFlxxEN2awghW9j2x5DguuoL+VDbsHC9bgGmCq2Q6avLcPo
	omm26q83SDWzphbrAMcB3uxyC8QSfemhXaGcQtL9bSRrNkZ1uNg8V/1nFtTynR2HLJxFu1awnWI
	sCfqanNix/tJR6aFsyvmn6wQcCZU7ACe+2nKmmldJQnslt+jRPzIKdzFQ/z7MuwjsW48Vr74=
X-Google-Smtp-Source: AGHT+IFLApw7Z1S663u6mmFAuyvzTMMRO0BP+wmyBxOT3lw6FIL86MI/nsNNUSErqdqQQ/uhCq6Liw==
X-Received: by 2002:a05:6122:251c:b0:539:3bb5:e4c8 with SMTP id 71dfb90a1353d-5473cbb0200mr1729942e0c.12.1757339424201;
        Mon, 08 Sep 2025 06:50:24 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-544a666da0csm10616129e0c.28.2025.09.08.06.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 06:50:24 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-89019079fbeso902904241.2;
        Mon, 08 Sep 2025 06:50:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSqteZYhtZdEdUi3/3/o/5Yx2rSgDRiHJgrJipECAl1QtgGxD+NEzkpyF092AKFK2a2C/6kef6m7s=@vger.kernel.org, AJvYcCWyjyQNK4/c+XB7wA73MU848qXs1BgOaSY1ZD8Yxnj7t34KVrDX+eJx12Re+OIBFhHsuuWntqPbFg6VV1vWKa53edk=@vger.kernel.org
X-Received: by 2002:a05:6102:5984:b0:52a:9223:1164 with SMTP id
 ada2fe7eead31-53d0ce6c32fmr2135421137.9.1757339423677; Mon, 08 Sep 2025
 06:50:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755855779.git.geert+renesas@glider.be> <f9198ea3be46f1eb2e27d046e51293df7fb67f46.1755855779.git.geert+renesas@glider.be>
 <TY3PR01MB113463B58C2110A8BC108072A863DA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB113463800F4EBB1762FE96DBF863DA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB113463800F4EBB1762FE96DBF863DA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 8 Sep 2025 15:50:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXJpJ7YOUJo1O9JqrQyevf=gZsFTbU9DZG8feHonuJ4LQ@mail.gmail.com>
X-Gm-Features: AS18NWDQMury6GO1Ec_q9rkKIHe_iPhFrO5ifmVaXX515qkBpR-PnK2JdNnOOog
Message-ID: <CAMuHMdXJpJ7YOUJo1O9JqrQyevf=gZsFTbU9DZG8feHonuJ4LQ@mail.gmail.com>
Subject: Re: [PATCH/RFC 6/6] can: rcar_canfd: Add suspend/resume support
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Fri, 22 Aug 2025 at 18:19, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > From: Biju Das
> > > From: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Sent: 22 August 2025 10:51
> > > To: Marc Kleine-Budde <mkl@pengutronix.de>; Vincent Mailhol
> > > <mailhol.vincent@wanadoo.fr>; Biju Das <biju.das.jz@bp.renesas.com>
> > > Cc: linux-can@vger.kernel.org; linux-renesas-soc@vger.kernel.org;
> > > Geert Uytterhoeven <geert+renesas@glider.be>
> > > Subject: [PATCH/RFC 6/6] can: rcar_canfd: Add suspend/resume support
> > >
> > > On R-Car Gen3 using PSCI, s2ram powers down the SoC.  After resume,
> > > the CAN-FD interface no longer works.  Trying to bring it up again fails:
> > >
> > >     # ip link set can0 up
> > >     RTNETLINK answers: Connection timed out
> > >
> > >     # dmesg
> > >     ...
> > >     channel 0 communication state failed
> > >
> > > Fix this by populating the (currently empty) suspend and resume
> > > callbacks, to stop/start the individual CAN-FD channels, and (de)initialize the CAN-FD controller.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > > While this fixes CAN-FD after resume from s2ram on R-Car E3
> > > (Ebisu-4D), it does introduce a regression on R-Car V4H (White Hawk):
> > > after resume from s2idle (White Hawk does not support s2ram), CAN frames sent by other devices are no
> > longer received, and the other side sometimes reports a "bus-off".
> > >
> > > However, the underlying issue is pre-existing, and can be reproduced
> > > without this patch: the CAN-FD controller fails in the same way after
> > > driver unbind/rebind.  So something must be missing in the (de)initialization sequence for the R-Car
> > Gen4 CAN-FD register layout.
> > > Note that it keeps on working after ifdown/ifup, which does not reinitialize the full controller.
> > > ---
> > >  drivers/net/can/rcar/rcar_canfd.c | 53

> STR is now working on G3E based on BSP code with the following modifications[1]

Thanks for looking into this!
Unfortunately your changes do not fix s2idle on R-Car V4H.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

