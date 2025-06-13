Return-Path: <linux-can+bounces-3833-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A08AD8BEA
	for <lists+linux-can@lfdr.de>; Fri, 13 Jun 2025 14:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 832027AE8DD
	for <lists+linux-can@lfdr.de>; Fri, 13 Jun 2025 12:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919022DA77D;
	Fri, 13 Jun 2025 12:21:01 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7542727E8;
	Fri, 13 Jun 2025 12:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749817261; cv=none; b=SNLZ/kY8RpxV4UsLz5RIlnn726yKkevYKSpyumIpPCFky9s+jH3C/uBcJ5/Or/g5KR8rbMJ47ABNdC5ESrusNZ0gqPScXF0D5B31gfX88+TqS2mWx8gNB8lt5LzGnfoyuixXfrJff1E7JXKlg4oKpPCxi5oU2cIBcQAGBviz5ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749817261; c=relaxed/simple;
	bh=KpByp7oiBWsFlDo+6IBQoeHG+Db8xjMEtnJqoi+wkGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QeQ80E6ZkNKFKPhJRoaBxzofpazcY/3e8q93IKLC+FoG41X1cJm33JEugTXv9mlQFqB4fz4cu9RC2R6iCxTAY9nH5dvnNUpputgQk+IZSuDPTirs1+3KUJovBzkOaeeZEStAmfYN1NuKVGctGP1CD4ht7gH/8F90KqOz+/zrKlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4e7f367ea11so24760137.3;
        Fri, 13 Jun 2025 05:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749817258; x=1750422058;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NpeiDo8J6cAac0AiU7gPbcdtw/9jRIit5zL+pfPrVik=;
        b=iwFDkC2gvUId6N+EVw90LJcfYIu9OH8mSX9cMVj1patMxu0PpwdF5D0P2bc1EEF39J
         vsJ3pKRgNUN3x5K2LEF0Df7E+KUpHIoUnaNORASDRuZnAEBLfJp89BDRmeSB8a5dfIWY
         psLDLzp8BG8QopDAjwdfzb3H88UqNXOoabfmR/SNBMU0+dcbDtyp8/mwM1R9g3+mKcY9
         wey9vdNsVKkXr/G/wfI3KovQbVOF0zus0bya6OgCx0pbV7wCR+wyA9QH6M2qmYx6wOPe
         KgGwLDvB1JTHFm6YQTpbePZ0F393w3ZnLkjbYqaaGGOfGsyUn8ek0OC+5Bs17+KWBLex
         uc2w==
X-Forwarded-Encrypted: i=1; AJvYcCWm8IAipB1fcscvV0mEtLFc1T6KblrMtwP72XsE3UpyNbLR+yR/GZEVU+P7TUHps7f3KwjzcNIKkRM=@vger.kernel.org, AJvYcCXT6ONndMK+r6rh9qQlkg6UQ+F967XMVs4yi/+iesld7WJDm9c0M8ag+12iGD1M+mKZYr7aN/R3pFmyYuOouXH7iG8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6leBq93wFUmgOk5viMBRpQPuCwxd00+vVMVKcm8tz7DWjrqju
	6I8w1MTgHPWvpbDtuDRyruErPISnFzy00RPW2w0U5Q5xMIbVSM1818FHNMtwQ7pH
X-Gm-Gg: ASbGncspI1f19HoNGeeqAlNRLMzcn0vopjMZmHfk4sKmZ1iZKNx3EEzgsXHtQPRta4U
	SRhXtmvHTpFKe2qymle6kLpiZ7LQUq5uAPrzc2H7UfeWmdo0f+SX8KhrHrd69ThbzyJ+Hy9RyjS
	AxgMixAQy1Uvqb8KSRSMm/kfdQbS4HhVfO5ESL4ws6OKgRh4kOshRGMIezMVVZ6WJNj8qVJV/HP
	BO5Ea1wy9MrQcxdKfvHELQYtpOxFnDhPJAibe+iUlCgIwR9DqmDjpmur3Z+NHn2TMYOeYYU/ncy
	NXbYw5Hhy6BafapHBPLFw9ocqK14bf3W5V9QWTCZP+vjaoI6HvSBAOBUNh3SBxwbGMHR01eU31x
	FDaV1AQUb7XCJyimrZ6aIsc+k
X-Google-Smtp-Source: AGHT+IGxB3lIgc/6KjmypJUwpdag0y9asvj3+OX3RFpGn0NIhrePzzNvg8TTFapSQ/fI+FWFzUumDQ==
X-Received: by 2002:a05:6102:5717:b0:4e7:bf03:cd6f with SMTP id ada2fe7eead31-4e7e389207amr2104084137.2.1749817257607;
        Fri, 13 Jun 2025 05:20:57 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87f0f9e90c2sm203106241.10.2025.06.13.05.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 05:20:57 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4e7971effd6so571192137.1;
        Fri, 13 Jun 2025 05:20:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUl3rnp6XGZQnwz0T5Gb93PpSrGioNV7BA7/wqh7B6KbUr4aLpbAfJnjpIxWK8WFvTfweygcLmGPgk=@vger.kernel.org, AJvYcCVNxT9pUmg//kuudgL7ReQtw2r7eddS2d1polCFAPXHlRiG37qsHUA+ERCtQ62GAsRftzcUFAgbEMUSPo2cOG8Xlvg=@vger.kernel.org
X-Received: by 2002:a05:6102:c49:b0:4e5:aa1c:4f99 with SMTP id
 ada2fe7eead31-4e7e3c6b2f1mr1684264137.25.1749817256943; Fri, 13 Jun 2025
 05:20:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749655315.git.geert+renesas@glider.be> <20250613-misty-amethyst-swine-7bd775-mkl@pengutronix.de>
In-Reply-To: <20250613-misty-amethyst-swine-7bd775-mkl@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 13 Jun 2025 14:20:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWFHVh+8dpgKE4eyVOE_Q6Gyk451ZEw5ZqRk85Rzh1m_g@mail.gmail.com>
X-Gm-Features: AX0GCFv1Vw-v1TYWmUBZeeBjwZzJXK9jD59gq5zwP5PPl66J7W760lyydgrdxno
Message-ID: <CAMuHMdWFHVh+8dpgKE4eyVOE_Q6Gyk451ZEw5ZqRk85Rzh1m_g@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] can: rcar_canfd: Add support for Transceiver
 Delay Compensation
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Kazuhiro Takagi <kazuhiro.takagi.hh@hitachi-solutions.com>, 
	Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marc,

On Fri, 13 Jun 2025 at 13:42, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 11.06.2025 17:37:29, Geert Uytterhoeven wrote:
> > This patch series adds CAN-FD Transceiver Delay Compensation support to
> > the R-Car CAN-FD driver, after the customary cleanups and refactorings.
>
> There's no reference to footnote [1], as it refers to the v1, I'll add
> it here.

Sorry, my mistake.

> > Changes compared to v1:
>
> Changes compared to v1 [1]:

That was my intention, thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

