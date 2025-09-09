Return-Path: <linux-can+bounces-4545-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A940B4A2BD
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 08:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E088D7B401F
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 06:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AF63009D5;
	Tue,  9 Sep 2025 06:57:53 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CE91FDA92;
	Tue,  9 Sep 2025 06:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401073; cv=none; b=bcjH1bk/xgQxjJhelGc7i6N7KW2rXs57v3bLupddH4YFC+eup9x0XfYc4Bhaj4Ny1khpQk7beR3m1pr3Z/ITQb5FW8EUebtGc6cNcqzpD3wuAez/kiABnzvhfuoJfBr8RqNU+h+AsTD2JzNnaSk106DVemAwp148bb00+z6N6dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401073; c=relaxed/simple;
	bh=mlPu/ssxerVfeYOecYB//EIkfnj3emtkG5skM4GqucI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WAxLIOBuenELaWNshSga8lfB2Sv9sB9DOz+k8n6qaAmOLjT03s2I6UeaGLTF7dtVCl5CV2fRpfLAUrO0XoN+jN29R8hue5L1ovxAZ0NW/2lPwD7EKwAZFoamNAS/f/TlW50VM6OkwGpXfGHtJFbqpI3emPavep/7RYB0GLWVF2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-8a00c77a62dso3067558241.1;
        Mon, 08 Sep 2025 23:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757401070; x=1758005870;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r1hFqDIm7POgA3jOMFP9hTmSfzmew7O3qrnj42UHXEc=;
        b=mso+6HNvoJKQopDYM1fY6z1LBQgAynWCFf08bc2yG+uKv1T+sT0RUZUYAo2DtAo4SA
         p7SoxFgGBaoEcQHk1yHS9VPetdDaodTu9E7+2LDQGP6okDZ7N4Kl022RqY+1ZGWNyQzK
         YNs6AQnzyFRUzwFawQ4wwkHFY7AarghQ1hC4VTw7T7O9KOFm/Jc2cGqqBNFbBkwKjOYH
         6ojtupdFizhLSpc25xsjyTSlIfka8tmR9Qd6bUpcpQZ+ODSZhiGU8/0s/UUik0nHaz8o
         /0AuRlGUCIzvLjUVjpznBbcNe6UN8k7wRovg5oob1THDsRoZCOuFKkV1s3L8hDodlst+
         MsaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUudZH0cpKVl3cMf8DuRtWJ2Hr2uQ1TDzgmD/FqpEs18Wsz7eRZP3Q3wULDwVBpq+RM2BNP2f9awb7acyBEOaVWkPA=@vger.kernel.org, AJvYcCVHMfIGm6Y6zDZeH8ePEejaZInHD88+9q4Y659AchcjCH+MP5xrCOjPQ5aC16YfWebNPCsz+QOqOyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSiKr550Vx3zpRo6CdSCZRAeTL4YrbfjQp8Jx0D+50bqQiEAQr
	QU47L1v2P4LVgRpZ0TBkz45FeUpGOo+FPPAYExWJe8t8hHGIuRyVb/55iBbQvfSH
X-Gm-Gg: ASbGncsEDX4ZRfS6MQ1yG//eG1V693DVE1Ipt3U5+ZAycr5ojenPYuvnlHBGkGRntmO
	8Dy4GqYeYVVYan1YzJQj+GHcMRHfiOOMk06A8U+81rRSxls4JoIMMq2nI1gkMlYUSHkh4cDudyE
	5pW0qXy7fmPo0Dq3POHsly/hbfVsOCCMRy7HYtlm4UdV1KPaQDGkmt4EDREle8zq0fa21a+Vn/C
	Z7f8YCYZAa3CuuI9EHpM5Skm1n2rpfrRzJHhjoYwFz68q7PZMyw5OS+1jOFQWXSDi/1MYHC2KuC
	FgTdvarNHKIn8mukqzEIQwvWfE6kqUUjcSHEAzLpzcWFxA/PvwhdnI5yCrZzeLFk8SNts4rTfog
	Q6dPLrfbLt+ncqnYnuLLkHuqURX5uFrQbkMVdLWB+TlJzgPMYKU4pqe8mWOpaLZ7NCIKmbH/85I
	BfvamkDQ==
X-Google-Smtp-Source: AGHT+IHqL9zYF/JX9MtE85VUHjUkPJX41jm+MS9uV0Vcj9iIiCGmFL2hiJ0Ro4hHCjN1qxg5clyU/w==
X-Received: by 2002:a05:6102:b11:b0:4e7:7787:1c2a with SMTP id ada2fe7eead31-53d231f9656mr3560609137.23.1757401069702;
        Mon, 08 Sep 2025 23:57:49 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-89608759c3bsm8681440241.9.2025.09.08.23.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 23:57:49 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-8a756436f44so1814392241.3;
        Mon, 08 Sep 2025 23:57:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfgbzRFYwj/tz9yQe7hCtyG5qBlvCkKqtAbzse1dq4AJpv6WcusDUwPUXZq3WSzJiESLg5QE1xJ1jucFP6vebJLmU=@vger.kernel.org, AJvYcCUutYNV3aevpisVFsh760cSAvbDymYXAFT1rMRoaSCWvPXp1VNeg1RbuJDNpPdLiD5hm+v/AcI5ttM=@vger.kernel.org
X-Received: by 2002:a05:6102:5cc2:b0:527:8b63:78fb with SMTP id
 ada2fe7eead31-53d249101abmr3653394137.34.1757401069182; Mon, 08 Sep 2025
 23:57:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755855779.git.geert+renesas@glider.be> <f48b37ece8058e0d94d79bfd9188fef046114c06.1755855779.git.geert+renesas@glider.be>
 <270d01d8-63a9-4e85-8193-51304e8f23cc@kernel.org>
In-Reply-To: <270d01d8-63a9-4e85-8193-51304e8f23cc@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 Sep 2025 08:57:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUdQtMrTjZ03CvD2nczhmRyw+yGj0hwvMdh3OdhZqJxag@mail.gmail.com>
X-Gm-Features: AS18NWDTH7lNfQk0hAnZJXAdjQHpj1KnxJM8jpEuDlUpH2wajOH4_hbMTshQHpE
Message-ID: <CAMuHMdUdQtMrTjZ03CvD2nczhmRyw+yGj0hwvMdh3OdhZqJxag@mail.gmail.com>
Subject: Re: [PATCH 1/6] can: rcar_canfd: Invert reset assert order
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vincent,

On Tue, 9 Sept 2025 at 08:36, Vincent Mailhol <mailhol@kernel.org> wrote:
> On 22/08/2025 at 18:50, Geert Uytterhoeven wrote:
> > The two resets are asserted during cleanup in the same order as they
> > were deasserted during probe.  Invert the order to restore symmetry.
>
> Question: is this only a cosmetic change or does it fix any problem?

Cosmetic only, TTBOMK.

> Reviewed-by: Vincent Mailhol <mailhol@kernel.org>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

