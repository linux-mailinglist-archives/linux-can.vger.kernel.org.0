Return-Path: <linux-can+bounces-3147-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 147D8A65501
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 16:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB88A171965
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 15:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005BA2459DD;
	Mon, 17 Mar 2025 15:04:10 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C754421C194;
	Mon, 17 Mar 2025 15:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223849; cv=none; b=ZhQotJtTzMv9UEaix+OR7WDQy/P8d/dHQhW2lz59qsE3u1vGh7cPGF7ePWqmuvGvlQLtecYBzjtkHCpfEmSBufwwo1VF6gzrg9AQX9ogMF/RjNtbOI0N1a7NKNjIBRgEj1vTWuLrGrbBYlMRECvmuSU0miK6UppOpRDv3bcGp1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223849; c=relaxed/simple;
	bh=dhH/Id0pu7bbQ4g/wNKM18ywLnQklaShXBh3uRD2XTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z2ghJ5yIHC9AwRmns3jd0mMtlk33/xDD+8O6KZ6tCstQU3Ci7EiIYEMdP/v1JDAtCIp8/rucMrGGwteNOUBgyBByEtxAf7iSJGnj4yAZ53pURKqjhpYa2vVzI/UAONb5WxS52UksTxHi25x5sDG1jsH8aiG0lNlJKQT9RBwRxFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c3bf231660so542448385a.0;
        Mon, 17 Mar 2025 08:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742223844; x=1742828644;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wYk7rUbV1AQGgwNQvYhtnikSWM5qBSUIOV3bM088vmo=;
        b=vLbkHYGgaymktvXHjwa9IBLHKf5wyVGF5ogRNHPMB9CaBEaUONqpgxJGJM5MwvXMgy
         +8s/eJ0huez6plXr9zGqxpze+APjwWYeqwkrjRNE90dRzlBl1vTLLxe+cBz5eWO754/L
         uU3rsYZb3kB0wPOveQ3WezBd+zVV5JfJF4L/pRFEo1f/b87amCWhKtWJpcjYPmwLBUp5
         JiumBXyFz2O3evnAOgVOMX09xNziR+GiULByX1r60SlBxHl2OYgNKmLbgZLo39VOm4Dv
         S8UZXWzX7Q0wEJfUb5DWbvmfOWUmpmEmauVC41+qQHgqQVkQb+5as//6UUHO6oMkClfM
         AMLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW44wIkoo5NzaBIxqGMPSyv0jO81DZA3Po2oeUHiYVTVKxzfz0QFR7adOfb/laOjWuXi/tdOmLLb2o=@vger.kernel.org, AJvYcCWLhMUIwNv2cK28g2/IJMacZoFdvNNipF99hW32CnrKqsU6ZlwUjtVf3kkIyz8mAlO9WkCycYPGrpFOYIfekIsdAjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWJsheslfF8vMocTtUxFY7QYSedltRJQrqqqwHAe7uFvHSAYfH
	E6WpIBk6ofsi349uw6EWiVi7IngJygx98+dfJjzEW4+vuddAawdEzpFZcVvX
X-Gm-Gg: ASbGncv0ue1T+VKOh2jZbjlgDO3imv8VLOFH0D/XgkxLBsfc/nsETXzvTtzDhl1s2Kv
	k2gFQom3K4KqVtBhUTszqGBQmjjmD+2kLK5VLQTA77GEJvVyUVijsPQplo2/r6GmmK9cGQ2rqp7
	w/pL0/f07UV79FvZYngLt7qedyByGJrY/wmY8CT8FVjwzLSuX9ltPbud4tul0yf6hsRG0Yc4RPA
	cRV4JCp+rL/0VsMcUMw5VH6pSEUHchkxQgL/FfxLr72qoMP58AG3vpJAmt49oZDlJY4ry35YTmC
	bnnjT78BqTs85R7XmGU4opfHa1HQieGUqmpYIMkWp78ckrPqrPzViFilXjK1kfK5KT/NUXBeqaF
	STszeLeY=
X-Google-Smtp-Source: AGHT+IGSsO4tM30uDrpas6YAUFi7TMNjIpVE3XK+5RbJuaEWyLY/KSrGRQO5ldPFmae2VSmcQBAeqQ==
X-Received: by 2002:a05:620a:2697:b0:7c5:5a97:f770 with SMTP id af79cd13be357-7c57c8c04c7mr1531969085a.41.1742223843969;
        Mon, 17 Mar 2025 08:04:03 -0700 (PDT)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com. [209.85.219.43])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c9a74fsm596798885a.51.2025.03.17.08.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 08:04:03 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e8ffa00555so38065756d6.0;
        Mon, 17 Mar 2025 08:04:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWjiDQIlNDEsg0ZSqPKbFFyLAG9ktA1k03VCAHhmV4JSnb06zREswP2EiJ7BFzmLohPOZISC13z6cg=@vger.kernel.org, AJvYcCXsZpyBkYhq6J8ROdF8kmwtkUdJpVbokbQwc2TSper3wtK+EETVobNaT84f5U9mh5mybySyuzc2I5bdPqDozIrSrG4=@vger.kernel.org
X-Received: by 2002:ad4:5aae:0:b0:6ea:d69c:a22e with SMTP id
 6a1803df08f44-6eaeaae36f5mr168169546d6.30.1742223842882; Mon, 17 Mar 2025
 08:04:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317123619.70988-1-biju.das.jz@bp.renesas.com>
 <20250317123619.70988-13-biju.das.jz@bp.renesas.com> <CAMuHMdVbcNqeNXnLRAhS-1g+VrTEwzfLiyNt+WCfuJDuF-Hacg@mail.gmail.com>
 <TY3PR01MB113466DCECC55DDE9913833F186DF2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB113466DCECC55DDE9913833F186DF2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Mar 2025 16:03:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXbk8gqhd4FFGmFNQRrEwbOToQvr-00LE2pZWoZq65GGg@mail.gmail.com>
X-Gm-Features: AQ5f1Jr4yPLIOXs0Wfe0Q4EA29Wimv8RMVdD_vomrUy6InT4b8ezDw-ZVH7MCZA
Message-ID: <CAMuHMdXbk8gqhd4FFGmFNQRrEwbOToQvr-00LE2pZWoZq65GGg@mail.gmail.com>
Subject: Re: [PATCH v5 12/16] can: rcar_canfd: Add mask table to struct rcar_canfd_hw_info
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"biju.das.au" <biju.das.au@gmail.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Mon, 17 Mar 2025 at 15:46, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > -----Original Message-----
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > Sent: 17 March 2025 14:13
> > Subject: Re: [PATCH v5 12/16] can: rcar_canfd: Add mask table to struct rcar_canfd_hw_info
> >
> > On Mon, 17 Mar 2025 at 13:37, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > R-Car Gen3 and Gen4 have some differences in the mask bits. Add a mask
> > > table to handle these differences.
> > >
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > ---
> > > v4->v5:
> > >  * Improved commit description by replacing has->have.
> > >  * Collected tag.
> > >  * Dropped RCANFD_EEF_MASK and RCANFD_RNC_MASK as it is taken
> > >    care by gpriv->channels_mask and info->num_supported_rules.
> >
> > Thanks for the update!
> >
> > All mask values are just the maximum values of various parameters.
> > Hence they could be replaced by the latter, like you already did for the RNC mask.
>
> But this will increase memory size, right? Currently we have rcar-gen3 and gen4 tables
> 2 tables used by 4 hardware info variants.
>
> If we drop tables and use variable with max values like RNC MASK, then this will be
> like 4 tables for 4 hardware info variants, right?
>
> Please correct me if my understanding is wrong.

It depends where you store the parameters: in the (two) tables, or in the (four)
hardware info structures...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

