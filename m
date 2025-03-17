Return-Path: <linux-can+bounces-3145-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2C7A6529B
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 15:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891011891D97
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 14:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37720156236;
	Mon, 17 Mar 2025 14:15:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF8919D880;
	Mon, 17 Mar 2025 14:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742220944; cv=none; b=WlFehQ4cVNsBUFpq7S9NYvLbeOU2PrYQn2Y7ftRgtJirB7KcgmjC/nG4npT/m5nVDoilgRK4AOLWJGQN5psDs6rrDuUxg+wFVFNLVtVRXRpOeYBQopUcOxg8/ohvMJ4OXaNgl5nnWHCubvvKHjIf9kVi83B8pf+kd0D1fm0nKtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742220944; c=relaxed/simple;
	bh=OMZc0I63BYEg1BbWhVN1wyG+cCsB/OYlH2SKLlv4/vA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kl1ZiggTOoK+aREz9sCMQds0UU1GbMdV/Jzwu0YRvfNsDkg1ebxDf3VY/979I5WELOv4+FsMt+n79P+ZmJeJiroTJaxu5TZ3t3OHzuPjI/DIVI1spkHgpHq6ihF/UoAJOMtI2l9jSfcfy+eyN8G1XK3bxKQcAjN1txDPSDLakmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6dd01781b56so59497316d6.0;
        Mon, 17 Mar 2025 07:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742220940; x=1742825740;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4tezPVpe/3lf57s116y09EgYof6W7k3WcYX6W0Xe56Q=;
        b=ivW5woHC+WAZ3kb5f/ovPmEDQk8PmJoRAiWrDj9ZP2Rt2kynO8cGuYdAAFO/bawLW2
         rsHeSiTMdN/8vwAeULTl3vXCaiDT4vBh/MBeMqOxlPBOJhYUfBglHn0Oox1w0TZ8niOD
         8Sw6/zZf7MoymGFB1tAeR4MAHtS3/0IRMDn6hW06FbWduyCADKbznVKYG5VzaJ2R+Mhw
         6Aj3h39jD6oWFeJSKXHJuA1vtFu8K/tlxUy0Acu7zvPJ12p0UcQAULDDwUbBFqLGuop6
         i2WNAO1TKYAa3SDKb+tzhVjVv7yMLs9fhMGzqmGF8obDnMsEsjp71umTNSbhnGREYeQI
         bFpw==
X-Forwarded-Encrypted: i=1; AJvYcCUPBS0SranKC3XYifdX07VuZGh3ujfXOmN/UNxEWSdhOAGVoHd8wvPP1DN10pTl6RYrWmMhwCjcpu4=@vger.kernel.org, AJvYcCVLvFM00Vu349x9S2ViJOubscXT6RAFP3KNbUyKJxQJjPU/tL+JKqQ/dS5uiFh1k2eOZFljy6orKMp2jqaPyk8eFyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9CIsDLJyPuC8xzhljnOu8zkV1rHDtptGttZb2dFhjMzLkiFKG
	eJu5Sqi1Kp+LPrqDIwXkwfxOdFJPkRzdcpn2sbbbJWRvRStjpk2JyGSBOKFn
X-Gm-Gg: ASbGncvzO14PBgprmS4qDCsX4qwF/nU5XCqxC2OqCdLMjVNcnnrJeDa0q9mcRVMoUa9
	KYRA0krzvO9jxpU/xU8M7WhtaraIsCUDwkF7R3gHqTlGNOOqxoHMr4Sh2NAuB3XhRMFOWccnYEy
	eqGUtX7b77ib+KGjC59lC3qmiLHnuFx9qga9/ioVA85cY6MKCEFRJhJLJdLJo2yji+7T6fRvHlg
	kH4WaXbUaddL38qFDhOi6RVeR430/0yHNW8Ag6CBDV1g6CHjVaFQRy4jSCjoTi1qfNgeOTAX5Hg
	qHbHtoA62i/GIs+9gR2owSESvro5DUSsXFiwftJSIVscX+VuvTfaVODcYSO71qnucSnKprmJacW
	VE4e9GTPBkmI=
X-Google-Smtp-Source: AGHT+IGPGoUcnjtQVojDjGRINL8umAH0kuSgbjs6oA3RRjpIG3iQyMgd1yfllfNFWLKGBgh4k9rdmQ==
X-Received: by 2002:ad4:5aaf:0:b0:6e4:4393:de7 with SMTP id 6a1803df08f44-6eaea990e93mr212455986d6.2.1742220940053;
        Mon, 17 Mar 2025 07:15:40 -0700 (PDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade330cf4sm55159736d6.77.2025.03.17.07.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 07:15:39 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-476ab588f32so21608521cf.2;
        Mon, 17 Mar 2025 07:15:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7C1wOFgIPNZpn694cPc2u9riTTGtOownE+Svp9/uEUZ80l9enIfUe/pYnW/x8UM2qH9GJE9xUH+BGszEHRu2ZnlI=@vger.kernel.org, AJvYcCUYkalzSIUb/QvdRJk+BoymeXQwytarTMvcxYEtoMtI9fCYSeejoOWgIOvG+5+yhNW/vlUIVbzYUxc=@vger.kernel.org
X-Received: by 2002:ac8:5a4e:0:b0:476:add4:d2bf with SMTP id
 d75a77b69052e-476c8143482mr154183561cf.22.1742220939067; Mon, 17 Mar 2025
 07:15:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317123619.70988-1-biju.das.jz@bp.renesas.com> <20250317123619.70988-17-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250317123619.70988-17-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Mar 2025 15:15:26 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXqtk91Dfj9KNgK5UDx==+QLsXEfe7+0PPODtaqGmX1Pg@mail.gmail.com>
X-Gm-Features: AQ5f1JplSefAdyGXDtnXl6ck7eRVJ_t0LcfRe4Bsm5lTuFqHsd6R1tkAeX_CzcM
Message-ID: <CAMuHMdXqtk91Dfj9KNgK5UDx==+QLsXEfe7+0PPODtaqGmX1Pg@mail.gmail.com>
Subject: Re: [PATCH v5 16/16] can: rcar_canfd: Add RZ/G3E support
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-can@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Mar 2025 at 13:37, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> The CAN-FD IP found on the RZ/G3E SoC is similar to R-Car Gen4, but
> it has no external clock instead it has clk_ram, it has 6 channels
> and supports 20 interrupts. Add support for RZ/G3E CAN-FD driver.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v4->v5:
>  * Updated error description as "cannot get enabled ram clock"
>  * Updated r9a09g047_hw_info table.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

