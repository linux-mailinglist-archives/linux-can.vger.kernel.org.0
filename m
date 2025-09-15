Return-Path: <linux-can+bounces-4701-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E90B57882
	for <lists+linux-can@lfdr.de>; Mon, 15 Sep 2025 13:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6C7F3A64E1
	for <lists+linux-can@lfdr.de>; Mon, 15 Sep 2025 11:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050F8303C87;
	Mon, 15 Sep 2025 11:30:51 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC182FE59B
	for <linux-can@vger.kernel.org>; Mon, 15 Sep 2025 11:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935850; cv=none; b=ptQhDEOLf84iapubUF/1WXqGjz73gG0vNQPZX6UYb3ebkcf8Ufs6INd60VLP+0Ha+R6/uMldQdosAoXKnd4WpmLCSXs/0znfS3lHbjy+ZCYAI1e2Z5JiUw7yBxXjzzArM7q1UjuCcK0dt9Rgy9oUGLxwE96cKWZFiVdrzShBoKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935850; c=relaxed/simple;
	bh=UrRBcNgc2GxQFH5pIfqBkMg5GVTDP+gL8ZcwdqJeQ14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b57cKaiNqHTB9iw3MuoX6WyPCjQ62xuAEBkstBrCN7bMSbjDjgzYt29hTELtl02an1T+eokHq06Gz7vSjIKSh+23ZS46kkk+8tVERo3wfR7Fri9XdXcgvnDNXLisQnEcNvDiuTFjUieBD/m2kFdZisYDa0Ec93QpCcQqPqiIFrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-890190d9f89so1987419241.2
        for <linux-can@vger.kernel.org>; Mon, 15 Sep 2025 04:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757935847; x=1758540647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQBIjgXfu6Gxi8be5ntWO50wYelw8C9JIsRhAGgfqf0=;
        b=F4V/AQhC1lQw4En+mllnrWBahQlx/ctIp+TcYz6hY53rJEd7IGWJ6Dtc6IAy1/nBpD
         Gq8iOqMhwNtkLScan3phsAiR95W661qLuQ2j6hzR5Ja38e+Lmk8NLU4ufagh6/z/AuXM
         BSnMe/AILsamwDyFiYay8ZvlyVzWt6YNdq8QeOp8aqcDfzA2VVWEivH3M92RhG+uZZOq
         IwjtE5Ugdq8Vm1zpCtT8plsOguOrg8RQj8Tb/jINKgjRLbcNFheW9S29O0D3ZhMvhpe1
         8nEQ0Cculz5e/J2JBEAjkfAOpYIzKXLGJEutz6M3ooOulPQoHEkical8S60Ote/xVTGv
         Uw4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzolKfLTgwksmG1PcWFQsrBGJI5s8YdLQ/ywP/bIYS83gRDPnZ9MJ9TcxkQyqGYs5pBV3hp80TlT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YylSExiqxKpK/Tz0BZ7sOGqB7CuyX52GfGDaUl48BjCusE4pRPZ
	Eb6fYS5+FogxSl+HYGTaw4hDFipYRksgPjLzxqd1gBGUrxBdYgDqaHwIcD3BWngR
X-Gm-Gg: ASbGncsMHLTE9U3rV8inltvWy3x0TcT4Bqg6XrRur5Ky2w4VJwSSX+rMJe42p5ySFMu
	+dgKCVENDokToQBhJw8WKyQQE5iWN9e+I+aqx4cZ2//BEEvOM4glrABebyBucmrv3jQHanHuTUM
	sZ4WSLqd0wxkccJ7rKxBd3BMKyT+3R0SX0O2Kzfcq2ixm0N3Qpdaz0JUBjxh8/Fq8znulmaSqmU
	w+fU1ZT+pvNA/vi4A6BDE94tdAogwCW9nvXLiFBeY2v6ul/zDN6u5VdqTwlamSI2ZTD75UlFktm
	cAkrYk/CsfzQaGqtr+DXVoCw5KNwn+LorMjiR2kD8KbdJ6UYz4/LnEerN7kRlqJyTOjTfAoYZUP
	d6PcWBx4TmydUSNJsPhXCNcXP4Z+aPgi19Gw3ZFDQRw6A9GEaPF01470xRLpnkDmXdtanof4=
X-Google-Smtp-Source: AGHT+IG2oz6dIqnUJoHB6z5v3zXFr4l6qlp8RKyuI90iNtnLTV10vx4w13W0ItB8Ea2NTOqyHsaMZg==
X-Received: by 2002:a05:6102:3e08:b0:521:f2f5:e444 with SMTP id ada2fe7eead31-5560c6e69bfmr5118068137.17.1757935847397;
        Mon, 15 Sep 2025 04:30:47 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-555bd4fe0a4sm2454307137.8.2025.09.15.04.30.46
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 04:30:46 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-50f8bf5c518so3398121137.3
        for <linux-can@vger.kernel.org>; Mon, 15 Sep 2025 04:30:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWF6hpy7CWh+S6B7a/nSL6ho9m/b7XelNieRwTA+Uslf42kO/c3IU2jjKrvukLohm/GLXAhIIv1rhk=@vger.kernel.org
X-Received: by 2002:a05:6102:290c:b0:526:f807:b90a with SMTP id
 ada2fe7eead31-55607e2b975mr4729860137.8.1757935846600; Mon, 15 Sep 2025
 04:30:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912104733.173281-1-biju.das.jz@bp.renesas.com> <20250912104733.173281-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250912104733.173281-4-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Sep 2025 13:30:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX4V7pG9X=sa8e+2oOT0HpR9FcD78c-e1x81g+qbUrypA@mail.gmail.com>
X-Gm-Features: AS18NWDvTIOpaxSS7-BC4gTDK_1rrdMWh5mlR7XCHFBxf0fUTl306c1znni9qEI
Message-ID: <CAMuHMdX4V7pG9X=sa8e+2oOT0HpR9FcD78c-e1x81g+qbUrypA@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] can: rcar_canfd: Move enabling of RAM clk from probe()
To: Biju <biju.das.au@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

Thanks for your patch!

On Fri, 12 Sept 2025 at 12:47, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> The RAM clk needs to be enabled in resume for proper operation in STR mode
> for RZ/G3E SoC. This change also result in less power consumption.

results

Note that after this patch, the amount of power consumption is
unchanged,  as the RAM clock is still enabled during probe, and disabled
during remove.

I suspect that on RZ/G3E the RAM clock was disabled after resume?

>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

For the code changes:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

