Return-Path: <linux-can+bounces-3209-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA51A713DE
	for <lists+linux-can@lfdr.de>; Wed, 26 Mar 2025 10:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4063F1886630
	for <lists+linux-can@lfdr.de>; Wed, 26 Mar 2025 09:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D123A1AB52F;
	Wed, 26 Mar 2025 09:39:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF021A9B49;
	Wed, 26 Mar 2025 09:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742981946; cv=none; b=WZjGbeQ3CsnyH70bQDVZgKy1CqBEdZnF6h/XdIiD8ABvZm+8ryVZKoJSEgfnbc2bKPiKT/aizdXphPTbWSAglUNZNGhRpDUcvaZrapD+zgHVnM00+h8s4LD9m3oJaZuXpuk35j28MlL/1MFUXPLeltyfJ8jVpGY6Ps1YRSC/vvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742981946; c=relaxed/simple;
	bh=ci814z8Y1HJb8arQZx4y0Bq1vQLxi3UHtaE+dNLEH7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+OVliZxbRxeDfP42Auc9icd1d2Grrcpf1cabDpkiKHn1IONtB0AMaK/93+S/xxNve8rBj+jYRYCsnEEsjP/F9YtuKOJHmMWu5jMl8IFW+mhMCKImIIoeHE/aUb0AvVzAis7oVGm6Tx5Qr8TLYK0y42bDKuEU9JLLFYexYhwn3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86dde90e7a3so2818046241.1;
        Wed, 26 Mar 2025 02:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742981942; x=1743586742;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5RkkyHKbb8JfhuTD/ckCjfixoqIQtcc1tMY7qrTq+HU=;
        b=FTBCPGOyH6ah13wOoJhErdx6F/opQ75bg0eiYZRZcgJsr9/GVCDdAqsyw2Dv53ba41
         sDYnFzB5cXuNZH7Nc6eL9ZhTTxXfBUjgBUNpFly+DKnvNRwVN/paHii+cC2SNMel1f93
         sfzdNxYvfJYs2SCeV6Y+jNOcFCL7gWsShJdzMFZQXAXamPVGvgzbU/63jR5pmxu/2xKt
         ti9RcUIoYT6m7KqP+18KqJB0CDnw8u6q0+7EivmZ3Kp6EqZexpfVPsQsQyb81jzc6M7Y
         hX5IME5XR3AWANHgsD1l8SXN9IXLC3G9oCGgQKRjrbsp1EVk2A/vdQMBTxGxQJL8ZyjQ
         BgRA==
X-Forwarded-Encrypted: i=1; AJvYcCWbn1eHBL49o5ra4yjUGwWhYh5waByQCT5Ia36KGIODzBNnDuBuBPuii9TQKoZprD57LDHyYKpjl0w=@vger.kernel.org, AJvYcCXJLYXuDHquFI4mCUTX5muvI1xeFqgAAqGlsfvMJBqCKIGaaWXx75+7QsG5Wke93JrrO3GYc00hYfJe/W9iGx1qc9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbTJ9Z+NRviTBYyYxI7cynSd6N6nnheErk+R8Wf9xbvGpdStNS
	BPup6ru2MxIx5LpoILJScGpQTwQLihjBs20InZCipHvFNH3YXTH/tmpalv7SSu8=
X-Gm-Gg: ASbGncttvteDNWkupOHh+scFWkQ2/owZ6T+hdkUV22602WdVmCzZd4VB+fuLFlMZNI4
	1+8CNJGFvZ8uOeA6rlneQUVlOhaakbWXB1wliiBOJvgha3D6hWGpZWXqotRekEJybiNYamzU+s8
	G29iUFcnyDYwwfvNYTItoQ6z2DjqH9ndkHhvwvTiJIZ/GJ5nKx4lxbEIkAZQg+7nowt/0W6eoJy
	upS+aAGuSOqucseyWVw2vHTD+5khNH2p/sgtvcXEq/hSxNLXk9RYizmgR0+Q6PfShmqOKHAO4DK
	iOja6Li3SsmqWdsT8F0W2XyThLeOYwDnNWSJhTcsg149r7s4t6q8mZDDkoOtxcudNalOT9kTYGr
	OqQZWSwDYEjg=
X-Google-Smtp-Source: AGHT+IGYUSGot6pp0v7gZEQk/OZs90XqsSCcD7tzCaK+pplXcy5qZMxOQ38GN34toDfPoSjP2Js+3Q==
X-Received: by 2002:a05:6102:2910:b0:4bb:d062:438 with SMTP id ada2fe7eead31-4c50d4923c7mr14345100137.1.1742981942309;
        Wed, 26 Mar 2025 02:39:02 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c50bbb2afcsm2351896137.5.2025.03.26.02.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 02:39:01 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5259327a937so2576126e0c.0;
        Wed, 26 Mar 2025 02:39:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVA47/S+UkRkouD2yXueF6YwI/kkhsvmgvjaihbXh6c37zuoU2nu+H8Gd0gIo2wHppsYT6ZSPrHSbE=@vger.kernel.org, AJvYcCWPcaHH7f4iUpMVaeaeWVwHnUbOZ58G11QJ2fp/iCKIdDYLsljmdpOUuTqbQAsjkhpFuxNs1gsNaHRHbztY308NmLk=@vger.kernel.org
X-Received: by 2002:a05:6102:3748:b0:4b6:d108:cac1 with SMTP id
 ada2fe7eead31-4c50d4c9b86mr15652014137.9.1742981941484; Wed, 26 Mar 2025
 02:39:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320091101.33637-1-biju.das.jz@bp.renesas.com> <20250320091101.33637-10-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250320091101.33637-10-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 26 Mar 2025 10:38:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWwDOtfi=ia4FqBW5BjVSbOdX2aAa=tAbN9aKZ=FXPsug@mail.gmail.com>
X-Gm-Features: AQ5f1JqqZodrt6r572AfXFqiTDFmpei397wT7YCRcVpfJSaLDJ-lK6pkp6xpDfg
Message-ID: <CAMuHMdWwDOtfi=ia4FqBW5BjVSbOdX2aAa=tAbN9aKZ=FXPsug@mail.gmail.com>
Subject: Re: [PATCH v6 09/18] can: rcar_canfd: Add max_aflpn variable to
 struct rcar_canfd_hw_info
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-can@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Mar 2025 at 10:11, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> R-Car Gen3 has maximum acceptance filter list page number of 31 whereas on
> R-Car Gen4 it is 127. Add max_aflpn variable to struct rcar_canfd_hw_info
> in order to support RZ/G3E that has max AFLPN of 63.
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

