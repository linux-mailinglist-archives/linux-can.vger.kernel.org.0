Return-Path: <linux-can+bounces-3936-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48576AF15EB
	for <lists+linux-can@lfdr.de>; Wed,  2 Jul 2025 14:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB723A7B7E
	for <lists+linux-can@lfdr.de>; Wed,  2 Jul 2025 12:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC442727E7;
	Wed,  2 Jul 2025 12:42:25 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796EA266B72;
	Wed,  2 Jul 2025 12:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751460145; cv=none; b=nFJHSfrb/dthPy9Yf+I7ZiSAMSt+woTSu4JStLjzlWCM7anPNiFi/JujjrdCWV95JrTdq7uJuj23b2a30BgLNGv9GmsOelQLq5A3MB17Kw+onxUsUw0fWJS8KfoIL0AroPk/M61L8sCvgk6efG/sh1ON8Mfu2t9JXhO4hvgdtE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751460145; c=relaxed/simple;
	bh=Wp/bPCZSWaK03f8Wauo7UJdWJ+RF3nKt7kYP5tEg7N4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nwibeCkiuOcNpWS1xM4/3xBR3CVMmSz/IG2SbjfXoqOlDKHV5fNUrYWvJd8CDo+wx6t2mh0Avpz1+glA8Oug7ktJ2b1e5NskIj+jMbrYx8ifMZU+OHPlBFIs2Fseaj/CdqAEafuA+VXiy3znpwLgg2Xm6fsbS4BSc5gAQoZbrHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-531b4407cfbso1221125e0c.1;
        Wed, 02 Jul 2025 05:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751460141; x=1752064941;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YJgLqOUo4bzsY26K6/CBMEPB4usC4u2n2nOEOmNiasM=;
        b=EDWDse2pRgy8WpZfuayur3n5cnmQ/71b/JTyKYpG8nXRhK8bMSVtlREVH64ejnmn+Y
         L4LjN3a1YAD1ZhtS+Asi4wkRVPGwAuPaHZoZ2V+XM1g6PwF3itLAndXCDEle9+7Px1ro
         uLx5bvO+YNHer79FhJJ88HfgDiYxryamoCWxG/M1B3aXpW6Tt5tShVBukibi5i56Hfnx
         Lo+xYACYs4F8m4A4T40KOXzlWuOHIBIvx4vdyDrhgBUeq+7vl8qu0u8E8s0gDPKqiZkA
         RGrkBSc75QOStcK2r8CkU2qT1BMkrSf8BwqNIGBnaeENpJ4PnJVpm6N8cPA+tkiEvD8Q
         iI1A==
X-Forwarded-Encrypted: i=1; AJvYcCU2qpcGSaEh7J9RqQP9Ly2CUfiU8woxaRZFVP4ISFZAB8w/yJX+KJ3+8SA0CE5bd8fJL9p82z98NZC6gbe7@vger.kernel.org, AJvYcCVZaaZ9Jf9hxrUZ0h9Vw+TiolKi0/UrQQP29+X2sT6zURw2WblrpeaG8n3r7cD+nGu4sWVfdsxWrYntYcsEkQS3XuA=@vger.kernel.org, AJvYcCVu7MOMDS2wwaiBbiHVZ3G7Sw43KNu03PkP7GbQoKGonqlrD7Rpy7XiFNFN0Gk2UA77SAEdXoaqwkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHwao5VdPb/WohZYQxbYSBCo/ed9Xs0YQ3qlU26rjx75gpZcve
	zI7JBT2Qy8YpFBAFEy6anHlk4vUNZy1IKEgZl16EKC3c54ucV+ximnfbHP+FnWxM
X-Gm-Gg: ASbGncsi4Huq8fYTT00h5TGEa1nGAe9pKHwG9xObYUMjRSHokobYFsAUd+P/R6dgzvl
	dyqCd9JlVVEk+YZ1mi11EUROIkrpLH3YYf6qSedb70z4IyTKx6dm+kpqYNTDcBy0MDU6MHltWCG
	KssNZtKL6Omz9XBRwv+gVeLwV5EDF8jYmy+PjVOFB55YSdRsXDgNznw3czudhQ3Ry8+CQtcSVcv
	5B3Y19lfGUM6+EPThB5EeJilfkvBL+6uyqK04OH0NRtVNmNdKIkqEJlGKzH0nrRxRvbepUgm8+G
	tmVRxKKqQJvOWQAe73ppHXtHNXEUPmeOAa4MwGZfgR4eQn97eQ0PaYSTL01wIa2zPYF+01hHzkg
	q6FHYF8HB2v0XEGy/bjqhnFGo
X-Google-Smtp-Source: AGHT+IHyyjYZFjH0BrLpbsdAH5yi4QQjEiYqwkouO3F15EAW2kBd5leXHDAJqsfrPzYppGvpzUPzig==
X-Received: by 2002:a05:6122:4682:b0:530:72da:d13d with SMTP id 71dfb90a1353d-53457fe128bmr1464791e0c.1.1751460141105;
        Wed, 02 Jul 2025 05:42:21 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53309079316sm2094632e0c.6.2025.07.02.05.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 05:42:20 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4e79de9da3fso1135747137.1;
        Wed, 02 Jul 2025 05:42:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0knzMme7B3om/ejXpKo4WmLLAEavD/AxUZZz+C3W0hdvVXDmtES/U/xVXV4oLwEait40Tv/WXtBs=@vger.kernel.org, AJvYcCVgIm2T2SGR2IYdBjR6QtD8+M9Iq9Nw5fVsUa4biRXtrcUwKQMUi3qpM5IrJiDBXtwmJYezUM9h71+0NOyH@vger.kernel.org, AJvYcCXDid1vu5PU10za73DaMr5PpfrdxuotAmRC6OAAmySlpQEgUxJ853zqWYNKY/6qOGQ5IEfKuLlPx5Ya3BRJ0CP2wjE=@vger.kernel.org
X-Received: by 2002:a05:6102:2b86:b0:4e5:9323:d2b9 with SMTP id
 ada2fe7eead31-4f160fbc067mr1302267137.2.1751460139870; Wed, 02 Jul 2025
 05:42:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702120539.98490-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250702120539.98490-1-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 2 Jul 2025 14:42:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXKoxsaq3y4aD6CY13LHZ5cOuZMXEKBGqthTxxm2EWhFw@mail.gmail.com>
X-Gm-Features: Ac12FXx0oWmYUpn6ud4HLq8dVewZuGgIKHGLmd7HxxYP_2inOB9rBWt5CLAlmz4
Message-ID: <CAMuHMdXKoxsaq3y4aD6CY13LHZ5cOuZMXEKBGqthTxxm2EWhFw@mail.gmail.com>
Subject: Re: [PATCH v2] can: rcar_canfd: Drop unused macros
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-can@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Jul 2025 at 14:05, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Drop unused macros from the rcar_canfd.c.
>
> Reported-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Closes: https://lore.kernel.org/all/7ff93ff9-f578-4be2-bdc6-5b09eab64fe6@wanadoo.fr/
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Dropped the Rb tags.
>  * Restored simple simple bit definitions as it serve as documentation.
>  * Restored register offsets will become anonymous gaps when the register
>    offsets are replaced by C structs.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

