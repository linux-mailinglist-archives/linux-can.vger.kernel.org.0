Return-Path: <linux-can+bounces-3931-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B75AF1102
	for <lists+linux-can@lfdr.de>; Wed,  2 Jul 2025 12:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4AD5188D799
	for <lists+linux-can@lfdr.de>; Wed,  2 Jul 2025 10:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8111E3775;
	Wed,  2 Jul 2025 10:01:28 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B65DF42;
	Wed,  2 Jul 2025 10:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751450488; cv=none; b=CNkwrHd0lpShynTAL+M11vw9yB47Lcdl11kWamTkLj7M/bIrA3H2crQA/QCjYKVtZD7Pc6U9FtPTSlySzaTcHp/cyT1iQ4CRbgSWaT+QmhIuplkPQHNrMx2xlKT2uExoa2BQSh+xWCJSxHCN9dlZOhhc16s0ORmiiKYuSDmVv6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751450488; c=relaxed/simple;
	bh=WWgjTbYmZoGnhpkjWEAze55dVkBL2mGCVKOkjtyo/6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjtZ4bgdDex9Ah1QrH+90GECt/+oH8qQF3Mr/2fbDMHw1i2LTads0ljTItTk+DO2DU7Uk2pZXU9WEL01fzJ1OhE+Csd7SzB97fRg26Xv8BK0tGm9c2Qj7P3dNcqHMruPDsVMgVaD2us7OgO8oaCUQ4ExH6yVu79eio7NohtrGPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5314b486207so1366124e0c.2;
        Wed, 02 Jul 2025 03:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751450484; x=1752055284;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LEr1iJohCGNsLPZlIt87oQ8gruL6FU9A7/YLok/d6QI=;
        b=Ief5jCVEi+e518zzhXn8xhelwXEej0ZvGIw95oe6Xi9XJdvgUB+NtVnX32Za9iQbR+
         OmTJ1cvYQJHOJLT72NxhtL9qNNIgZbfQIIN6z80LAiKt2lvk1jPUqGrQSQiJPagFDZHL
         2sPDpeuGaxDjOoKUG0B+qFzziYqn8I5gX+KMHN8FJsbzJaymWMnnaMm6lpOIXg1lLSkW
         Aqsdjz+YgrVCfvfRfLeGcdy/dNaWWGXwdpEhUrNRR9cponazcgV4rrBuq/B7ykpD/YDo
         XKKjn/JyELs4AKLYE+UulekF4I3jS5P75xqTmP24nEHmy3mgaaRf0qSuT7iq+qnU0xlA
         J7jA==
X-Forwarded-Encrypted: i=1; AJvYcCV8cXndl/b+FSwiQrufuPa4qrMFF/qZ341iojrpgwtFrOR+xN7EW9XAJOEJppk+pCAt/qgTOeh6JxwOQ2ykYeamUx4=@vger.kernel.org, AJvYcCXAfwwwyo/trKMsnU6t6u9AWqFEWKewbt+gNGbj4K0he8UZmHdq9LWedd9CYaVWvH59YNZWnmPhvt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzArGf8CHr2QwqDsd30a5akC6FvjPTqR/xjuLUOMfus3NlgejNB
	9jkmXomKEeTdot1u0ZnUdG+k8fhZSaBARELnxeMP6CcPL7nneMc3sAkurKYMmve4
X-Gm-Gg: ASbGncvo05AE5oxr27HW3PrPcUytcS/Emb+j02p1bFAKXyLH12h2v190PTOuw+6ah8N
	y1s6SVI8N1G6feO511ieaYNeiSJAiVmEHMeTxX5gf4HdsP4CNwygOOCY/jpVHmJwXq/5Zg6Po2y
	8i+BBXbilVh73VGlYnHyYYckZgKrUiOqr8uizeIHCvDASICXADfbgOvkwRb/UnTu65XOm/0Z47s
	k8ms9PeutGaOZeeAVEuJXaW0pu50Iwd9ebj0Ro19g+itKWLgrCscwJY5A07srTRGRsPLqphLNIe
	6PnLkhsNq5hsMfGq1ys9TFMhsNoZ37lo5g5YLF4G+WZ+r83k7MLU6RKKA5eMs1DiMHaXUXVMwqn
	qJ/oilH66zYK0rqXfk/gTtOKP
X-Google-Smtp-Source: AGHT+IHqn81ffMrXSUuMk8TEGNoT3uvIivTL4enwWdrifZryw0RjWteFtnY6GxXfNV1Gyx80kkl9gg==
X-Received: by 2002:a05:6122:1781:b0:520:60c2:3fd with SMTP id 71dfb90a1353d-53458093396mr1424680e0c.3.1751450483537;
        Wed, 02 Jul 2025 03:01:23 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-533090792b7sm2046665e0c.4.2025.07.02.03.01.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 03:01:22 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-884f2b3bc2eso848686241.2;
        Wed, 02 Jul 2025 03:01:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUL4rICOqQFViIszxraxgH6hk7/2ra8729TwccAevceJ1ZplQ992s03+8ThTzxLtEyEa3CJoBFFYicwvJTk9IBFiBs=@vger.kernel.org, AJvYcCUY8yXRVC7hUaSvgySi8X5ywAk4gyYRCHTTSr/n/NQ8NvxE4UTDk5A7XgwILZ5iti0fy4qQBVkEVy8=@vger.kernel.org
X-Received: by 2002:a05:6102:3f4e:b0:4e7:f3d3:a283 with SMTP id
 ada2fe7eead31-4f16136a54dmr633168137.25.1751450481993; Wed, 02 Jul 2025
 03:01:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250629150417.97784-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdXK9ZBpgPSE32Zya-nVBXQw25=2-g5pnixjFOoyOkrrvg@mail.gmail.com> <TY3PR01MB113463762D1EC916BDE1B7BA28640A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB113463762D1EC916BDE1B7BA28640A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 2 Jul 2025 12:01:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUcTbM_pbxmbb-kuWf7Kgb=94QtPzRVJZaUrezL3wwN6w@mail.gmail.com>
X-Gm-Features: Ac12FXyAGqFgRe82GCxfe0ExkpQMoQ_6pcjFo9ivcv-Q9isw0ietBLOkNlu7X-8
Message-ID: <CAMuHMdUcTbM_pbxmbb-kuWf7Kgb=94QtPzRVJZaUrezL3wwN6w@mail.gmail.com>
Subject: Re: [PATCH] can: rcar_canfd: Drop unused macros
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Magnus Damm <magnus.damm@gmail.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"biju.das.au" <biju.das.au@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Wed, 2 Jul 2025 at 11:46, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > On Sun, 29 Jun 2025 at 17:04, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > Drop unused macros from the rcar_canfd.c.
> > >
> > > Reported-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > > Closes:
> > > https://lore.kernel.org/all/7ff93ff9-f578-4be2-bdc6-5b09eab64fe6@wanad
> > > oo.fr/
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

> >     #define RCANFD_RFPTR_RFDLC    GENMASK(31, 28)
> >
> > > @@ -298,16 +256,10 @@
> > >  #define RCANFD_GSTS                    (0x008c)
> > >  /* RSCFDnCFDGERFL / RSCFDnGERFL */
> > >  #define RCANFD_GERFL                   (0x0090)
> > > -/* RSCFDnCFDGTSC / RSCFDnGTSC */
> > > -#define RCANFD_GTSC                    (0x0094)
> >
> > Note that removed register offsets will become anonymous gaps when the register offsets are replaced
> > by C structs, cfr. commit ab2aa5453bb83d05
> > ("can: rcar_canfd: Describe channel-specific FD registers using C struct").
>
> OK. But removing unused reg offset is not an issue at the moment, I guess??

No, it is not an issue at the moment, as they are unused.  Re-adding
register members to a C struct later is just more tedious, as you have
remove gaps or adjust their sizes (lol, mind the gap ;-).

IIRC Vincent's biggest gripe is the use of function-like macros,
not the definition of unused register offsets and bits?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

