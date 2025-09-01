Return-Path: <linux-can+bounces-4412-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C9AB3E5C2
	for <lists+linux-can@lfdr.de>; Mon,  1 Sep 2025 15:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26A527AE208
	for <lists+linux-can@lfdr.de>; Mon,  1 Sep 2025 13:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459913375AB;
	Mon,  1 Sep 2025 13:42:36 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB07335BD5;
	Mon,  1 Sep 2025 13:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756734156; cv=none; b=mXb689yVacouj3g4CKlws0s76HWCIF0ual59eKZDtmNQJ1sZu5M/JFgTED5hIqZjNXEM36lT5xqOBUCfrvPpM6w/OTdUoyGExdtXWtyXebNt6uSju9Xw21qO8+IfCDGaAWYHcil7+w/4/55geZozGoTr/K9tu0WyImF8Y66XWZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756734156; c=relaxed/simple;
	bh=RiR2llBXC0RIPKr7xaiaC53t2ZL4gXL/WiWADRkCq/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vo4bsNVnQbnEWISdHSd4c/CN/F5Hvj6yHVxPr7KeVhJWNgDg/CnQVNhWH3z2rasnNX0WkWaXRn2YfTLZzNRQ3FyEVjQEYhHoccpYMfLwYN/1hqknfrl58lcdz+DpOrb1qUh+irdSPvQ/54YI+hzQCMgBVVhViL+yhtfKBqz6PPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-52a73cc9f97so751344137.3;
        Mon, 01 Sep 2025 06:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756734153; x=1757338953;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vocq/+HcTHTmphWd6zOzklSWl3IX57j4LspmV5YVnH8=;
        b=FtTEsw3jw2ythJ4Rgnr/WsaL9JUK8tJ99wxS5f8E9fguzxcRj3w4fGJ9ECBmEN33y/
         u0+k+XbH/ozT3KLw1TVs8GI43LVbL9A+OY6t5EnhOQEGONzWhC1dIC1I2XcZTgTRcj01
         tiSdLJy5eR+EoCBgbbmYqZfDJcYGoT4UeKzt8qRaliCdjJu5FhzSPdLsVHL6wf/I6tAr
         ELFnD6yS4lFQMMo0aRmyF4o1M85bu3uzR0RJtvZGhfdkG9HwWLRsqlJjvnY1RJOTy/ru
         eulDBQXLy/Gv9RdP5cMig7p3VpMnagrKPMgjtY/nF8JE7W/EC/8wMO4enEbpCeRHfIRh
         fUaw==
X-Forwarded-Encrypted: i=1; AJvYcCUFSCBWWpTO9btlKaaRLyZdi5WlOKAXO4JnzLyzsV3upynN7e1UAR1SEWJKHcHthFb9hdLogKikFC0=@vger.kernel.org, AJvYcCUfusu1F1CGwdrdOE+aNt6ErWPz8wwgFwTT5/e66KkiLlukNrM8URiLx6kcLmJthxkKroS3oMmoNNZLQ+/7ipBEEXI=@vger.kernel.org, AJvYcCVWARpHhl2yndQsRAkD10602VvQRo8d+Bia3m490/1jK0YcM97vTOeqRhOXaiqIedseKxPEc6G9cpknl0SY@vger.kernel.org
X-Gm-Message-State: AOJu0YzWL57RbHlbjDUjnR9N5Q/5ClOrFO9eFcBoa4VJdpct9N/AiV5Q
	g+82aIKJCjriiuJGVFdfz8hUCvLUb4EWGZoAHT7uaL0jUjiYZwZOKuMjr7eZ54R8
X-Gm-Gg: ASbGnctVHjO83K50vW7EA9uCflmaijtTAzeLeCGJ0exUXl1u7s9caOLvpkU7kxrscrL
	+waskpgXRBF+EP4g4nQFV77dEC/1DfNYlrOeRP/YIx/mW/A7eF3ZUUZgyikjYsxJU67DoV60Xjh
	E0kG2D8KVMz50X1tkLJv63ymIA8l6F06+tINEXQ9UcmFaN/hFdGwn+rBcloyrYZB+ZjBU+3bxAo
	BnO/ue1UaBDfqTZjJ8UGL3v7YAxMDFw1yOOtyx1KIqsoqbMlgUABd0GqIAZQtHNx5oP7xPbeWjR
	+Q+mfrsn9GaxiUs5HfzR7SFbIau+yihU232rtVT6TgX1LdYkFlUhyvxTSCkF6HnyhfmJqIywyJQ
	4dEfpjjIvw9FkCh5csGWWbXPolRGao+uZvTYtdpQ1oSC5NjeUkG+FGHqp8gzwYtlgRoSQQTs=
X-Google-Smtp-Source: AGHT+IEbLs5kgSXJJUR9pdGBnxmcVEfqPOqKeIQWpSCeI0Zra1Jtu6uB0pm71eUifEmjjfyfZuKsAQ==
X-Received: by 2002:a05:6102:5127:b0:4e6:d911:dd84 with SMTP id ada2fe7eead31-52b1b6f5b9dmr1905877137.22.1756734153073;
        Mon, 01 Sep 2025 06:42:33 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8943b7c2c42sm3774794241.4.2025.09.01.06.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 06:42:32 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-890190c7912so855230241.2;
        Mon, 01 Sep 2025 06:42:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUj9C2ZrjxqzbAFdWHdaQdFwPQP6mcF9g49XViA/IBmRY0DoID9FKZZfHFeyyCJ6+sveM8wCN1WaFzHEXt0@vger.kernel.org, AJvYcCV0VLGNiFao/5v+uYS02iiuy+ffX1444nDCe547yjr2fXJ8nSxE1j8g3fsS1/Athfw6KRLQnwKc8U4=@vger.kernel.org, AJvYcCWZVD+yoWsoqDZlN3p9OdfFZnQqHBKBflPu7FNr2DV9+jHWrFhg64F3pj0Vlh1pPCg646PVr6SbzG8Yn5k2smL3zN0=@vger.kernel.org
X-Received: by 2002:a05:6102:5687:b0:523:95bb:b63a with SMTP id
 ada2fe7eead31-52b1b6fbbc8mr1571895137.21.1756734152397; Mon, 01 Sep 2025
 06:42:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821141429.298324-1-biju.das.jz@bp.renesas.com> <20250821141429.298324-5-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250821141429.298324-5-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 1 Sep 2025 15:42:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUNZag2kf9Dq_sv++6DtU-2tWAgQa5vi36duBx77=a+KA@mail.gmail.com>
X-Gm-Features: Ac12FXycAaiDbDiLCPFnnKNCCOpZihQqU0phzOqdDOsQ8ZbBu8u1JL5pNL2VgP8
Message-ID: <CAMuHMdUNZag2kf9Dq_sv++6DtU-2tWAgQa5vi36duBx77=a+KA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] can: rcar_canfd: Simplify data bit rate config
To: Biju <biju.das.au@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Thu, 21 Aug 2025 at 16:14, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Introduce rcar_canfd_compute_data_bit_rate_cfg() for simplifying data bit
> rate configuration by replacing function-like macros.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Split from patch#3 for computing data bit rate config separate.
>    separate.
>  * Replaced RCANFD_DCFG_DBRP->RCANFD_DCFG_DBRP_MASK and used FIELD_PREP to
>    extract value.

Thanks for your patch!

For correctness:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

But I have the same comments as for "[PATCH v2 3/4] can: rcar_canfd:
Simplify nominal bit rate config".

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

