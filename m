Return-Path: <linux-can+bounces-3092-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C60BA61403
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 15:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEDDB7A5A76
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 14:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3392D1A83F2;
	Fri, 14 Mar 2025 14:48:18 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2DF200112;
	Fri, 14 Mar 2025 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963698; cv=none; b=jPNUoudEDQeJqnn3XUpd0QJF7K0ZsAFfYCspSunsvj+BJBww1vuNCsZvGzXPAynnq0AZDcBX9zYjSfcFdWMcko1Y0k/MivrCaUf+G2neZZE/kt3VY5Tgykk/e+gC2GK8jpF3idd2rGzyMcuRm3ma4xeFxUSj0L93fbw7MJBv+Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963698; c=relaxed/simple;
	bh=xjKbHiaZpXp6nnpq0rl4pW0DTVgVP6Ikn5FVapu+3RE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J2Rjwtv8xb/+PbvXIkujamRMEPSz8gUlDMRPpEcOfl7lpWJdsJJa2kvom40NNRPONb1JbOkF7Ss1kv9fV5azUQJyLn2g6QVvttZ0w93TVxMqxs8RNbgGabY1voY17nQn0J+ij2YdMkGmvXtBcIrdnzstwP9XRIZlb49WdVXfQ/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-86d30787263so952345241.1;
        Fri, 14 Mar 2025 07:48:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741963694; x=1742568494;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xLN17TQ/tH28oxI7r3AjdesOebqCVVNcNrQOUko2qQk=;
        b=GtVcPaG1G+B5vtw9BvoGWHawbCXCkWl5NK3mVmStlBs4yYcvrb3CPEQonvJuV7jfA2
         SfXkzPH2Q17lNAmApJ/jk5GE+1PZ3wuzB9jG4E9H6atHFM0/zw+v2wqECCmmEv4XHwNa
         9BLxcukbf6IcbjShcaLi+UwwX7maOdUXk1UQlBiXpb5zfQlmlmkp2DQOfTuY51PPozQk
         KLE5D1N6qf2sO5oxen7Ty2Nzu7OQO6LN7kUHqRoN+kx4p8RY2P4ddaleX7vcrpUxKqzh
         /92mqDv272lCb7TVqiqneZ9s0sSH4YviAYMhOK/8EVaG7ld23IAdP36M0skdy+8e9ch2
         wODA==
X-Forwarded-Encrypted: i=1; AJvYcCVzQ9irkY8yCrXpMroAc8yB73AMnIcYa+vhVuzsgMcHGTQmevEZQAU5buibPx1EgQ7Rk9f+2J74cMVqeN4QrLp+HZ4=@vger.kernel.org, AJvYcCWwb3QGs8lZfT+26ZtNiYYzoYyspIG4HIV82a4UmNswDADwmsUYBfhH0q3C9IwCV48Vz6wO7mden5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiwwJ3pdSI3/iI4F6CGMBMutD+ZHcmc4FNBTLwiNYJDm1PO27E
	kvABEDbnyhQ1hWOb3gUeH2NXJLJyVHjZoBiRq1iZ/gu26Oj36exfbj5jhOMZOkM=
X-Gm-Gg: ASbGncuFshDS6YrDPYCqCIX/LBWGLuLbOi1kDm8v7f0fDvIt6avv0x5SS85Y/E+CQ0N
	tZljMUqkK+kocynRoOvMQ/etaQdleizKXMIr3hmETtjV6Nrl60EDwvIhRfOH1AADv5JluO9HutE
	cG2Xm/qPiqA/ZV05MvVtihSVgC183QztDtQUSSUghnpVhXlO4LPAAr+pRQCXTNH2KRl35i7bGdF
	EmzDmoZIt/RUPiQv8bE1A9zPByPH6e8E/R052jsCajMuelIxzrF+mGgX3t1nDAWUUpQzo3dgaOg
	rC1DHi593aqrKq8t72hnej+6c6Jx2pA+b6uhC2SS8+wjdPTslCj+IgOrjhUuwoGq8uCRf8UALKv
	qGTRp58gSV8A=
X-Google-Smtp-Source: AGHT+IF8w+jhn/l4kgTsFb5pi5oWGoaUZhZZ10QY2VwM5ap90rsC9kAWf+OeBC4MxM3BXlGL/uH4ag==
X-Received: by 2002:a05:6102:3709:b0:4bb:d7f0:6e65 with SMTP id ada2fe7eead31-4c38310cef8mr2056633137.2.1741963693705;
        Fri, 14 Mar 2025 07:48:13 -0700 (PDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86d90e8c2f5sm556581241.33.2025.03.14.07.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 07:48:13 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-523eb86b31aso947773e0c.0;
        Fri, 14 Mar 2025 07:48:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkH1iVTJ50Xc4twTdc33c9BSFTU9kjUX9Z3f3ul75etSrgkFKZEJ8JOYe4Rc4jQPCi/GHZdIPuVc3PSjRGzMTgHwc=@vger.kernel.org, AJvYcCWWrvZXLyqsIeyEAly9e3f6gxLjHa3a8cyEzwGlSaAALdQwWS7Sj5GPm6ZN7FGpvyDza2N5qjtqNhA=@vger.kernel.org
X-Received: by 2002:a05:6102:3f0f:b0:4bb:eb4a:f9f2 with SMTP id
 ada2fe7eead31-4c38313efc3mr1959601137.9.1741963692695; Fri, 14 Mar 2025
 07:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306124256.93033-1-biju.das.jz@bp.renesas.com> <20250306124256.93033-11-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250306124256.93033-11-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Mar 2025 15:47:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVpcOE0M47HMVcFttd6oHPkAoUoK2eqCxbjnq_=uqwptw@mail.gmail.com>
X-Gm-Features: AQ5f1Jqgr_RzKQMe30RenUsoNPMzgHLFkNEL-BIBjSDtUB0oYy_M9Nl7WpnbCZI
Message-ID: <CAMuHMdVpcOE0M47HMVcFttd6oHPkAoUoK2eqCxbjnq_=uqwptw@mail.gmail.com>
Subject: Re: [PATCH v4 10/11] can: rcar_canfd: Enhance multi_channel_irqs handling
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-can@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Mar 2025 at 13:43, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Currently multi_channel_irqs has only 2 channels. But RZ/G3E has six
> channels. Enhance multi_channel_irqs handling to support more than two
> channels.
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

