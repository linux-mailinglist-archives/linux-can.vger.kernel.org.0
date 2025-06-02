Return-Path: <linux-can+bounces-3759-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF18FACAFFB
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 15:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC5F9179D6A
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 13:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5C21F4165;
	Mon,  2 Jun 2025 13:58:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16121DE881;
	Mon,  2 Jun 2025 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872708; cv=none; b=UC9DgSBkXDcttjHO3S6JGatCiSTK4MscvFIsaPKjnzsv4oaRdXqLQoIL+DxOfYA1lkyzvljKci+iTArYPCAqnq8bicvr2CqpOp45hxHYpUy9uIeyHSmxzHVQIKAvuk6ffi0C9ETad5lQfEMhSA78eLLpTzwyrxB+w5ZfD9Kmefg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872708; c=relaxed/simple;
	bh=j1Kyh7bpHR7bM3I2FFBGGZCAUQJdK8qbI1tlLk2CKV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b2nNbyZ8NG/vrDcdrKLLrCxkYYst61lS8/D0aF4oCqIENeVis2ip4xdW4IR3Wn/7FRzcdu3wBmky6CegU+eX52MD8E2527BuqP9ivDod9l/cc/bHgKgZ++W/1EJYdwb/B70O7rA4mrbma6oM00BRIpVKJtNuortCpe/91zyqmjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-87df4fd380bso719371241.0;
        Mon, 02 Jun 2025 06:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748872705; x=1749477505;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BGY17wRBClxOrwG+1hR36k2GqK89U2bZ90HIAmNC5mE=;
        b=bLef9byX4aK9w+MXFiJmjhU3x/HkCVnSK22rDefzWLA//Jv4FDSf9GOD9eGsX7N8o7
         RumeQDKitbEMzeGTpYRVYTEIQI2M8AglQWTgrOipRHFjj3IVDzOpBH6i8gdTvj2hO0jf
         T73rYuMReWNibNRzdOqHz2+F1bi+VjcvM+3IkbTFWIlswc+iKX0yiLK02P/SxnywCowm
         /ohfNQyKqkjl260d31eJspw/tt1kt7HrJJSCVH3zRX57b12RXhMsZS4XtA1L7q6Ek4Wn
         pGJzZ67mxFowbadFW6ewlabEV1hX3XZ8Z+AzX3MRHdOYHucIgRyNeirHmzpUQ7+npQIL
         plFg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ3Ly0j1Ubrm6Hl4XrfDBmzKXNE+PTiy94yD7DcRjdKP8pmKCIRmWPuP2cIaviE89sQbTrpPkebWI=@vger.kernel.org, AJvYcCUilySRb3fjvG7w+yS9E9JHO2+HCnyWTrUEBAMob8P7fRUBHK7vsxduO2fv6kr1vGnclEbZNCoG5GXuKymav9JSs/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdcTaidpb0ntRNnE9Qer3W5N4NkzLYAMhvIutAiw8FS7lz1Qh4
	nsVM6IDY2cTt2bHodNwWocx+zny7hfXhysyHryOtEfOBOi3INifHb50niEyIdV+0
X-Gm-Gg: ASbGncuhd/cQRroLH0AaxKZ6J12qpUN14CxmTK+Re50kqygCmxdpMbwv79/8daT/nlL
	7cox5gjaIv95JwrAk4VlDG0wv/8S/+EkLo/2NxgvaPmBD10mxibdHf96nLQ1y0DeCz/H3Z8lvJb
	E6XeoDGY1Fv9JnN7qH7VJnDICw7CAWolBdwQ2BANRWCqTTHVddibJHBBSXOzxhkr6y5kYJ2frNg
	0JQsbFwU8+DwbGpuxhOC5eg1rrk85EIP3dyXm9WJi/IkQmcQsQuboweCYN8a5zkvCA4UXVsMz43
	+thDJw+Q/xzWKOi0RhRkO7T7iNH2Sh/IGCIwAgPdK/PF1d6M0PqaLmhwKXJB27JZym074YiTvQV
	tQtXVEbqzRCoiBw==
X-Google-Smtp-Source: AGHT+IEwIZ7bDo3Ia8QVscyd5rb48BVu0+oPSKpHkFZ323B+zxS1WRnT3f27sCLFoi7HkphueO+Wvw==
X-Received: by 2002:a05:6122:459f:b0:520:64ea:c479 with SMTP id 71dfb90a1353d-530937eb5d0mr4469012e0c.10.1748872705349;
        Mon, 02 Jun 2025 06:58:25 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53074c32088sm7466625e0c.42.2025.06.02.06.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 06:58:24 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-86fbb48fc7fso806030241.2;
        Mon, 02 Jun 2025 06:58:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWukkxXW3Dx9LVC8BdhliJXn0vCdZxAU4v3lluiXDWrrrlFvC1WC0I8rxP8l70SxmNgHIHs9SXYLfM=@vger.kernel.org, AJvYcCXwOJo48LqTHfUaWLZaD/xnA2geEb2DRRlTHXvwFFFZ9TZ/cwmMC4GVBEbG7K0jq77tmESJjxzQewkZTgsdYlZrqe0=@vger.kernel.org
X-Received: by 2002:a05:6102:41ab:b0:4e6:1a8c:13dd with SMTP id
 ada2fe7eead31-4e701bcd515mr4716073137.7.1748872703185; Mon, 02 Jun 2025
 06:58:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1748863848.git.geert+renesas@glider.be> <002c3ab28323210e83ab3d35462dad40d22128ff.1748863848.git.geert+renesas@glider.be>
 <3dccf669-3d09-4eaf-b4d4-09841d19bd84@wanadoo.fr>
In-Reply-To: <3dccf669-3d09-4eaf-b4d4-09841d19bd84@wanadoo.fr>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 2 Jun 2025 15:58:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWO7-T3GRrB7y+ukv_xEBmVVKi8AjcwDboG3AOunQMs5w@mail.gmail.com>
X-Gm-Features: AX0GCFvbiHjWNpD-GexzR-lG-Oju1RZmmtIgfTGehYshcr3oU1wVk6XiGDQc4Rk
Message-ID: <CAMuHMdWO7-T3GRrB7y+ukv_xEBmVVKi8AjcwDboG3AOunQMs5w@mail.gmail.com>
Subject: Re: [PATCH 2/9] can: rcar_canfd: Use ndev parameter in rcar_canfd_set_bittiming()
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Kazuhiro Takagi <kazuhiro.takagi.hh@hitachi-solutions.com>, 
	Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"

Hi Vincent,

On Mon, 2 Jun 2025 at 15:01, Vincent Mailhol <mailhol.vincent@wanadoo.fr> wrote:
> On 02/06/2025 at 20:54, Geert Uytterhoeven wrote:
> > There is no need to do a back-and-forth "priv = netdev_priv(ndev)" and
> > "priv->ndev" where the "ndev" parameter is available.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Are these still useful anyhow? You can get all the bittiming values through the
> netlink interface.

My first thought was "They are useful, when you are stuck with an
old initrd that only has an old ifconfig", but then I realized you
need a fairly recent iproute2 package anyway.

> Well, if you tell me these are still useful, then I trust you and OK to keep. If
> not, consider removing.

No, I will remove them.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

