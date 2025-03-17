Return-Path: <linux-can+bounces-3142-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F92A65247
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 15:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B2C167198
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 14:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FFF238145;
	Mon, 17 Mar 2025 14:05:53 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0715C78F43;
	Mon, 17 Mar 2025 14:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742220353; cv=none; b=mZ1/Y3L4qzuqpPuWuUEy2yc9i8fdgYI3GvkX5D++ts1XBxaDBzpRyQ8X/1cWYEacgwo74PQL8GuWSwUtheRplYHv3O1H/pDZ66oFY69oWjMYLJ+zRwxCgWUAacjW8s66ziJo8P1odeV52JCnyFvQcY7F8ZBFB5MNFw7HAX6dbK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742220353; c=relaxed/simple;
	bh=rYfqVu4WBPFNvwUOUtTZdeHHJFwyu5RaXwsRISQENyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vApK+9Hh3PhiFHEKv1pOi6CCfhKLU8QWqUXtz3OfTQj7UlbGbXSplSczaY0P8rSjpGZ9WXmGWxhhXI9QD/e8xznP0Ug+NYlN8Lm7vs7SsHwohwcjBopFByV8i9eRaNRLnC+PbE3lE3Mzh/bjoLLvJO6go8hFtzWbpWmdIHcupsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-476ae781d21so43822451cf.3;
        Mon, 17 Mar 2025 07:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742220350; x=1742825150;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6SYTLcX38F0BFJUEEZoShw2/gcOUnl6gM+9WiXsHvI=;
        b=DHVN3ruzCidKjx833QEoAPnOV/FCkXW/R/fjMfgKcrlJa2SzfLb3YhvlsezROCQ9f6
         sYJvBchRRiNm47uGsWK7FV5pEgGxMzRN+qoaMTeEyxBdGoRCB7AqLXZo+PHHoQvHZv5q
         SU6qietlaqvQW94h/LzvH3P895G2UBXqhCIgtfpITt3OV2gYVZXibiLCeiZY1ddpwLYU
         +DroQ2U+FnCCCa18K813cBpp8O64nlrbUObgRUeCSfgUJZ1skon6qhln8RT2l1krocEa
         jtY7RfBLaXEuO877xNR0v6+mLSP7Ua0uV0Ut7q4UI5gsBQvTezr0FKypfbHesG+ysLn0
         wGYg==
X-Forwarded-Encrypted: i=1; AJvYcCUlijVM4gUi2Oq8wVrezyvpvEb9N8v7xiYYCpOLlZ1OLZKSRsIrN8s2KEDboTN6kYdWKr2fPovp5uVXFzP4blArzlc=@vger.kernel.org, AJvYcCXm5kDyZrII8f4sauCfEEE7kRQsv9ikzHOhov52InqyyHmMmSzhSf/ccuW6XHZQyjk6Neb64Aimkr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1WqwZxrKcuGM002Q6e177V3qWYGzEyq4dIVQvpmi6znwDawun
	wAHSIPDhA9auTSIVSroVimw3c1qE3TbhZGEGgfTWHETX9HSrb4ywvpwefuqu
X-Gm-Gg: ASbGncvhiRMoLFm2fQ0r4FBviukbPBhKylEXQ+RSHDJaNn2FFVPaMiZckWiP1Xfcnrg
	TRl6pNFLNQEFqOraqP9hru4jbnVY907Bj1/qT49qb/54PzsrV6sQgLi9p73TtVtIGQHZH6jSxLC
	unlvu4ojV/1npn2S3DPxJGRnZ/AC3cHU4hrqE09DMqAGhYl9rn5ywwrLlYX7dM5xS+l3NETreLt
	PX3sNlfBUyIQmaErnpG9kk9gBUpP4J46M0dQHqkTZVbyCoxuxfmnIlY4y+wMPC0p7YjK/Wv+lBU
	RY9w9U4xUq8l6ngfYMbhqhclNAJfcveOS9XLXHApbfUFbGFZT7S6dnGFJkFtbf518NgimJAtUMa
	o+pdCs140D0c=
X-Google-Smtp-Source: AGHT+IEg62U6AB4YYUbLh1WS0SWJ7Eb69ODxqf1a4lSioBKI6rrOKj4Md1emkhaUyA4NNj4ZbtZsJQ==
X-Received: by 2002:a05:622a:199f:b0:476:afd2:5b5c with SMTP id d75a77b69052e-476c815fa69mr184253341cf.30.1742220350051;
        Mon, 17 Mar 2025 07:05:50 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb6370fesm54430301cf.18.2025.03.17.07.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 07:05:49 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-476ae781d21so43822021cf.3;
        Mon, 17 Mar 2025 07:05:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVLpgKFpTpZZAYH+mWV1YfTqfhC5fE+b9R/o25f1l+5FrDy/GaZ0h//z9dqVugjMawfyBfVrCwz5u8=@vger.kernel.org, AJvYcCX0OOro6fMmf1I22B5yWdlBtzBUfVqKVTokrLxWohi4zv3kNBeSEUDzQ8dz9adEYzoBsoP4kTHYECHrmFd5UcI01pQ=@vger.kernel.org
X-Received: by 2002:a05:622a:2b0d:b0:476:8eb5:1669 with SMTP id
 d75a77b69052e-476c81c84cemr201147951cf.32.1742220349443; Mon, 17 Mar 2025
 07:05:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317123619.70988-1-biju.das.jz@bp.renesas.com> <20250317123619.70988-8-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250317123619.70988-8-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Mar 2025 15:05:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWp=55hGtVz5u1LEJf4p-AfyrqkxP=MDH9ypwKSPkO1kg@mail.gmail.com>
X-Gm-Features: AQ5f1Jod6vsyPoLfuoBanwij4WIe9E6GDq9eZiIlTDsOzRyE-hTlmBUldB1DEkA
Message-ID: <CAMuHMdWp=55hGtVz5u1LEJf4p-AfyrqkxP=MDH9ypwKSPkO1kg@mail.gmail.com>
Subject: Re: [PATCH v5 07/16] can: rcar_canfd: Add rnc_field_width variable to
 struct rcar_canfd_hw_info
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-can@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Mar 2025 at 13:36, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> R-Car Gen4 packs 2 RNC values in a 32-bit word, whereas R-Car Gen3 packs
> up to 4 values in a 32-bit word. Handle this difference by adding
> rnc_field_width variable to struct rcar_canfd_hw_info and update the macro
> RCANFD_GAFLCFG.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

