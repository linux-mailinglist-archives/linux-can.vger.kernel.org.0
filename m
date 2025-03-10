Return-Path: <linux-can+bounces-3036-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E598A59022
	for <lists+linux-can@lfdr.de>; Mon, 10 Mar 2025 10:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CFD016C057
	for <lists+linux-can@lfdr.de>; Mon, 10 Mar 2025 09:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488902253E4;
	Mon, 10 Mar 2025 09:46:53 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E57192D83;
	Mon, 10 Mar 2025 09:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600013; cv=none; b=rVehZCl5DblsuicRruPiQD2qWLaMYH3xFgXWwgGZHcl/jeUQ69hXr12awaUCZXjJUQWM3lFruUpJfMzLv3kNaiUODbkjOKp+IzpxSEKB5RzjXYO7plo8mOUh4NH7IHDQ94g9MdJsURUerCFmjubJVpn6UaE9Ntd99oPZqWqrhAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600013; c=relaxed/simple;
	bh=anYCRcYyRRrek0KNlmuuEaoJDKOrAsXU52D/HjEJxBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DhKD6vaj4sIvbN6j5qwqD1JAGtjHljddl9An5f5Aex3pOsvq75CIzD1NY56Uu8WpW9IyzcCFm9uDHOv9VxktssJLnazLtHAUsiSgFnkJ/1MG26fzj4wk3NZjXwpav3DekgaxtqxNo0VrP7q7i48HLQL9SOSQdDT1PMzSEnm//7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abf615d5f31so785650266b.2;
        Mon, 10 Mar 2025 02:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741600006; x=1742204806;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Any+m7QILvqODsC+Atr0PhE/5U+BQGSuobkCo4tucCU=;
        b=v0bMujP9Ovz4V8xEqXglLO0KeJX4mGqsMB4PWMcozjILv7RUcOT+uh1HixdfMAWooB
         hWYYs6S2ZWVM0r+btQRXc+ug8CXTBrf+NqKFl0EAYvpOpN1eZmDDnNDC087sBvLmykW5
         igws02zm848NJh1rLtZVoi+/INmn9tn7gzrefrBwP0+8Wcat3Kt/uUsWpTzg75Sqwd+P
         yKNebimexV1ulejlLNxpnt2e3FutRz82pBTTVv2x6oCppWMJOd4SBpswoSKSl9CwM4+c
         fciBVTd0LKCMUoZhEIKEXso80IV0N+52NRnOzvQDsbCEPD2wuX6nZI2CBZz22B3VMIVi
         dNyw==
X-Forwarded-Encrypted: i=1; AJvYcCUEoRgwShZy+QQCHOsSGcZei06bWkw47/uyie/t2SIGJwaBp8g8cO+c/er9YZzlGE34w4V4a4UOhTM=@vger.kernel.org, AJvYcCUmu15Z9WSoVsm+xXPpYnAHYIVpD+UPOE7LnP1YRcRBMqdMv8/7I/qGkhDI+d+ZnTzLWLN5JlOXcONv5qoYEmBCQd4=@vger.kernel.org, AJvYcCXLpWiOmO7nW2tfT3H9nlTPx9lQ5E/BlrsW0JW1z9ang22QVUN+G7aBKimg6Rl/8pA4DqLK00IC@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5k6u2f5ItFDPBmI/9rFYAqOvE46wp0Y0o1XmWlwvl657ZO1aT
	lUNuClQsYO0GukLpzb9f+lVvZ24Upx1wZ99Gr4RXjcrk4r8pxAdQYxvbkF9FH6M=
X-Gm-Gg: ASbGncuJO/yV42r5C1yx+9gZJ6vba2ytnyDy0XRjlh+trvqlOGxdgu6e4zsHi/isKfv
	35E83/dMxA8Bv+Tua1LB1t+LzQ4CmmpPOiSAqkg+ih91sBZJQTmRm7AQST77AXSGllFMmoJ7f9h
	0qtREBWmRiTfmn1aAaRoQCzWyj57CIsXwSbYug5hN/6BB/Zxa/egvC+uB+wOlda+9r7tII0klxy
	6fhimZIVl7KmJ6l5PBMdxPuAB0li+FLhjRykBmvmG9XDR0ATp08GwB3OEWa0qF+ySVgqj35+iMb
	1dU0tQzksnlQnJ6SBgn/Ps5HV7xYd6awjtUtPqRcnUjWWopmdikwApkC2pEx9CKUAfVE6561wn+
	13XDGCjo=
X-Google-Smtp-Source: AGHT+IF4kXzo5ZLz2A4hR+Ne0Cn6BSGMt0MV4JwHVSy/FHUh+h+Dq2CVIqQg3ChwDmLbmXZJROrnmw==
X-Received: by 2002:a17:907:7f92:b0:abf:49de:36de with SMTP id a640c23a62f3a-ac2525b9adfmr1477829466b.1.1741600005968;
        Mon, 10 Mar 2025 02:46:45 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2a4ba2575sm118233266b.133.2025.03.10.02.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 02:46:45 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abf615d5f31so785635066b.2;
        Mon, 10 Mar 2025 02:46:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZCDT7ZuqxJkwHuYP9UPXirjIbgXel65zV7v7FRprVUYw6BZp4VFqXLxzQ+lGtsKVUHREU0hp1Lts=@vger.kernel.org, AJvYcCXbt2wc6tr5QJsvX5N/lp52stHGfbMLNRktUpl52HZ2fwSO5a26NrEB5agyY9lpnYkSOYBjC0V7vkd465QPwg/1PAE=@vger.kernel.org, AJvYcCXe2yqoi3hUUwW4ebGMxhvnMJTshgJieuc8BUZiYwjfSp79L/2IoPeXv1n8wOynrZLu1GU/cBK3@vger.kernel.org
X-Received: by 2002:a17:907:3604:b0:ac1:dc0f:e03e with SMTP id
 a640c23a62f3a-ac252628a87mr1545179666b.13.1741600004722; Mon, 10 Mar 2025
 02:46:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220094516.126598-1-biju.das.jz@bp.renesas.com>
 <20250220094516.126598-3-biju.das.jz@bp.renesas.com> <CAMuHMdUs=+niOyBW0us=UjZTnqeYjVsLWZSmROndCO8azER=3g@mail.gmail.com>
 <TY3PR01MB113462D6EF7BDDFE403FD0DC286D42@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMuHMdUyLLCdTHkhFJh9rK7Vv5S98anw8-Cc51MafzQ5DF+V_g@mail.gmail.com> <TY3PR01MB11346B8F2576A85B0006B9D6986D62@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB11346B8F2576A85B0006B9D6986D62@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Mar 2025 10:46:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWBh=neb6P4Mw1=EPGa-1Yju2m9bNBPvPEnBJg1zaTrCA@mail.gmail.com>
X-Gm-Features: AQ5f1JquJHFarnCtPjXDt3d-CsGfXWqk9PQy1QXjZfx-gKXGL3VhTR1ejwIYjxc
Message-ID: <CAMuHMdWBh=neb6P4Mw1=EPGa-1Yju2m9bNBPvPEnBJg1zaTrCA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] can: rcar_canfd: Fix page entries in the AFL list
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"biju.das.au" <biju.das.au@gmail.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Mon, 10 Mar 2025 at 10:28, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > Unfortunately, it does not fix CAN2 and CAN3 on the Gray Hawk Single
> > > > development board, which is based on R-Car V4M with 4 CAN channels.

> > > Q2) Does it by chance is in standby mode?
> >
> > You mean the transceiver?
>
> Yes, for some boards. we need to toggle GPIO to move it from stand by to normal mode, so that it
> can start communication.

CAN0 on White/Gray Hawk variants uses TJR1443AT transceivers,
which do have enable-gpios (and do work).

The other channels use MCP2558FD transceivers, and their
standby pin is always deasserted (except during system reset).

> > All channels but channel zero use the same type of transceiver, and similar wiring. There might still
> > be a pin control bug, though.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

