Return-Path: <linux-can+bounces-4524-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62516B490B2
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 16:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298FE189B4C2
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 14:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B351D30C609;
	Mon,  8 Sep 2025 14:06:22 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE02305E08;
	Mon,  8 Sep 2025 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340382; cv=none; b=YkBrCAlj2sjKlQjJvHFO9eSkhMemck2JgQf4B4nXFkI37uED2MaZ69pRdSzeLH8O+lfjNzGxzc389axTpNoELN655fGFgGnAx5yEZIWrPL8F8UuWtklbWk6z+VOPhnhOk3HTOPp/69mXD48zEoJkflQiiikTHDD3JbKOmtId4lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340382; c=relaxed/simple;
	bh=nsHHpYJhfoaQE+96FQ9vEdyAgK10r3TUb9rTZT4aEkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tEPKHIT4i4uzuSWykdTsYaDA4DaHT6iFYrd3jNWC9nLSzH2ntD/7MqdT2mX2mSHxv2kl+aO+cCzg096qx5FOBT4jvVskv6L+E0OhbfipuLSm91T9W/hgJ3eFClyWBN3+u6T66ThPREyWlQX5nSulyVz1DxVP3HLGuh+Cvuhh3GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5300b29615cso3044171137.0;
        Mon, 08 Sep 2025 07:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757340379; x=1757945179;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xqm94pKffQZoz70TtbaIogbnRj6qTp5eT6nUGqQViEE=;
        b=ss3LOlxvJf1VaUFeVa/8vCw2+YOBDlNvrXWudpK2w/L5ZkzLiXLYrGFJtxlvoKK96D
         zNR39G2BbnNMm7ZjMaAkTer1THAU9zP/eb1cKPPLs9JKf22vTvClglkCJGP2MbGDyFQZ
         CH4kdCsqJmJ46qBEmEnFuLyYxXQ8Gxss6XmGFR7wptdiihW+E8w2/+h5Wxma/Fxvd1XW
         7Sp48rS6DhWVLWi/jJeKYG0tjePwFMfl1KralxvBuyPHrgLzW9RCiQUgNAdbJzh4OVSK
         nx2SX7bATcyjqwS7+11AmcbGN8nkh5icGF8nQZNeg7Vf7eFNnDHTG+IhsHUyXezgonXA
         VFOw==
X-Forwarded-Encrypted: i=1; AJvYcCVHk4pjbTWE9LxQG3zgzQyiK8PWMiSY2cgtbqJ1psdjYR5A9X5NWweyM9VYaBHKpcGM2AztJFM8i28=@vger.kernel.org, AJvYcCWPrsJqJFEZG4195ITu45QQzdTWtsl6j7oFG99/sMwpKiAR+OYu/VeTUer1Ggq0hTLf6a7Tcl02WbUz0RXCPTfF/Rc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3y4DcC/7x/Gp81g05WN/qSePpCgQRHzw0MU8m0gNt3Bpx6bEP
	5Yn1hsmbBjCOrTLHwFrTXYBwUVGeH6HR7AnCng0tOosDZCQwVYaNzbZwwki23mYZ
X-Gm-Gg: ASbGncsoXeT+Q9ly/ULQObOvP8hQfUaioAZYHdMVg15u8RvFw9HQSyqrPro2IzgyMlI
	zgj6Tf8F5P5zFoRUZgSZUpwEU3+MG2IqGBSlB35Ho9hoDB88kbA6P9Z9msT4+MZPNbJ2sUeuCpx
	RUuYMH+cRZ6EiaRwkZy5hFsUcfAWhxaIEk6bwcPRxcjuTnOl6Fzgv1IRRYjWPbkG+7OimjpANlB
	RW68Gq/LMrR03FkC37WEAbgKoRAkeDaJGIjMGUQJH2RrDuWiK2JTI5d4jgovbBHYXp3ad8oYb5O
	EwfizKo9YneUmkXcWosFiQ+uGLBMnfZI44bjt6MB0F9mXm60ekJp0eBiWiv/mUWzYzC537bL7zL
	2Tw58j4PnsPbIabbm8zQQwo/DKpC9sp5pym5xhEdb/hcbjmBXBmKy6A55W9vcK7BXfLtOsdA=
X-Google-Smtp-Source: AGHT+IF/s/FjtC8Eu6Q5+qXjoqSPWvtwn2dJ+1ahH9K3RB6x054f51m2YoLzsBmo0gnHVKQ801GG0A==
X-Received: by 2002:a05:6102:f09:b0:4f3:1d:6b47 with SMTP id ada2fe7eead31-53d231f8e83mr2463433137.25.1757340378976;
        Mon, 08 Sep 2025 07:06:18 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-89608759c3bsm8127007241.9.2025.09.08.07.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 07:06:18 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-53042807be7so3463493137.3;
        Mon, 08 Sep 2025 07:06:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV1g4bHbmQcLq44wJQ1U6iuIMH0R51NAIDX3AGskptedmLCsBHwzVQrxFCdHSegA66BcFvN31nOEvc=@vger.kernel.org, AJvYcCXnvLojQJjyuiZFoXxuWN5p+DoWI1oqwKzOtFQoNreSq1+eu4OtSlfsgyayhEgwkz8qrHdHo4TVEn4aDjFdz1o8Q4E=@vger.kernel.org
X-Received: by 2002:a05:6102:809f:b0:4e4:5ed0:19b2 with SMTP id
 ada2fe7eead31-53d1c3d661cmr2639083137.9.1757340378447; Mon, 08 Sep 2025
 07:06:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755855779.git.geert+renesas@glider.be> <f9198ea3be46f1eb2e27d046e51293df7fb67f46.1755855779.git.geert+renesas@glider.be>
 <TY3PR01MB113463B58C2110A8BC108072A863DA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB113463800F4EBB1762FE96DBF863DA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMuHMdXJpJ7YOUJo1O9JqrQyevf=gZsFTbU9DZG8feHonuJ4LQ@mail.gmail.com> <TY3PR01MB1134626F5A623880365AFF246860CA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB1134626F5A623880365AFF246860CA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 8 Sep 2025 16:06:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXBfe3525dTmDdPzSuDfzEGGF-FyeQdRvVFt-r_bYPAJA@mail.gmail.com>
X-Gm-Features: AS18NWDP6yLg5H8QEcFZNsyxgwWZjOUkfQhMNYhWbADox3MoIkuTCzLHsNkFMxc
Message-ID: <CAMuHMdXBfe3525dTmDdPzSuDfzEGGF-FyeQdRvVFt-r_bYPAJA@mail.gmail.com>
Subject: Re: [PATCH/RFC 6/6] can: rcar_canfd: Add suspend/resume support
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Minh Le <minh.le.aj@renesas.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Mon, 8 Sept 2025 at 15:56, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > On Fri, 22 Aug 2025 at 18:19, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > > From: Biju Das
> > > > > From: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > > Sent: 22 August 2025 10:51
> > > > > To: Marc Kleine-Budde <mkl@pengutronix.de>; Vincent Mailhol
> > > > > <mailhol.vincent@wanadoo.fr>; Biju Das
> > > > > <biju.das.jz@bp.renesas.com>
> > > > > Cc: linux-can@vger.kernel.org; linux-renesas-soc@vger.kernel.org;
> > > > > Geert Uytterhoeven <geert+renesas@glider.be>
> > > > > Subject: [PATCH/RFC 6/6] can: rcar_canfd: Add suspend/resume
> > > > > support
> > > > >
> > > > > On R-Car Gen3 using PSCI, s2ram powers down the SoC.  After
> > > > > resume, the CAN-FD interface no longer works.  Trying to bring it up again fails:
> > > > >
> > > > >     # ip link set can0 up
> > > > >     RTNETLINK answers: Connection timed out
> > > > >
> > > > >     # dmesg
> > > > >     ...
> > > > >     channel 0 communication state failed
> > > > >
> > > > > Fix this by populating the (currently empty) suspend and resume
> > > > > callbacks, to stop/start the individual CAN-FD channels, and (de)initialize the CAN-FD
> > controller.
> > > > >
> > > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > > ---
> > > > > While this fixes CAN-FD after resume from s2ram on R-Car E3
> > > > > (Ebisu-4D), it does introduce a regression on R-Car V4H (White Hawk):
> > > > > after resume from s2idle (White Hawk does not support s2ram), CAN
> > > > > frames sent by other devices are no
> > > > longer received, and the other side sometimes reports a "bus-off".
> > > > >
> > > > > However, the underlying issue is pre-existing, and can be
> > > > > reproduced without this patch: the CAN-FD controller fails in the
> > > > > same way after driver unbind/rebind.  So something must be missing
> > > > > in the (de)initialization sequence for the R-Car
> > > > Gen4 CAN-FD register layout.
> > > > > Note that it keeps on working after ifdown/ifup, which does not reinitialize the full controller.
> > > > > ---
> > > > >  drivers/net/can/rcar/rcar_canfd.c | 53
> >
> > > STR is now working on G3E based on BSP code with the following
> > > modifications[1]
> >
> > Thanks for looking into this!
> > Unfortunately your changes do not fix s2idle on R-Car V4H.
>
> Is "bus-off" issue related to can transceiver, Maybe after s2idle transceiver may be down?

No, it also happens after unbind/rebind.
Both Ebisu and White Hawk ch3 use MCP2558FD transceivers, which
don't have standby lines (the silent signal is wired to reset).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

