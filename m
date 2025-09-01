Return-Path: <linux-can+bounces-4409-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E5DB3E4AE
	for <lists+linux-can@lfdr.de>; Mon,  1 Sep 2025 15:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A614D3BFE11
	for <lists+linux-can@lfdr.de>; Mon,  1 Sep 2025 13:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABF7273810;
	Mon,  1 Sep 2025 13:22:09 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4507D1DF25C;
	Mon,  1 Sep 2025 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756732929; cv=none; b=n4PDnNzrZ17lBDtZVpGmH6LAXDB+ccBlpeqC1v730qlZl6miD56Age3nhrC19j6/11Jf2j8H756ghcGMjVXfQsFjZoKwkYlr2ws1A5fHsTRqCyG9x2YDppjaDiS1gkiXN77Hjwg7XyDct1ZPZe8ATuw13H/jcQAp9yfYLzWIjM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756732929; c=relaxed/simple;
	bh=1g/A4Wv5mKf+v7+/QCStqvAm704nvGmVmNhs+BbGCT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KM1hufKzVi7HzKHa+vNzaUjDtUKsJYyt32lMYhKoqMqrIN+VdS6ScNgTMP3sKawu7YbjSwlvZ2LccQ6tNzjFAHhNa5X51N0YYN9wAl5CbfUU8OMx7oP3fVp94pZDIFtk6mlkTZLvyVwVv8/s8Z/COzQ13QeD/MUU+9ppi/JY8HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-541f5f63bc9so3248647e0c.1;
        Mon, 01 Sep 2025 06:22:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756732926; x=1757337726;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FkAvxCU70HoXuWxVwlgIiFldPk5hO8ZyOEAVQLM5S0g=;
        b=fBPDiwT2NHksLr+T2QeB0G6XjULi2tBzBGbJIkx1nvlEPhwR8k7Mq/fTvFyxhrKp9L
         aQlz4AGhlubP4XZZa+FF7vPanFG7w1MxKQTm3vmsgOHmZ0fnXiASIJMyK1TO9zrn2k4I
         uGJGgLObTLcheXhHNcsmtHINoXvlKGN+4ngp5BOrSkXAiRbtj45v7w/n8MgyBJZYNda/
         0FVfMTCwUfhzXu+0GWydJm9kSsMO2X6cUzu/nYiOl8fiP29S9z0bTnOGeLGQEILKLACE
         DNfqrRAHu2tFDuZdhlVcrwQF2c8RPQmf7V+fMlHSXCu5XRq+xrsCfFOyqAVKprcmWxcd
         lAlw==
X-Forwarded-Encrypted: i=1; AJvYcCW6iqfVSM+/1wmFa08Fckpd1JJvMCpeQtDy9E6bv6nOCGHc7lKOI0uy/efJFS1H2heZI/ARJIKKxlk=@vger.kernel.org, AJvYcCXPSpmOfFs8RJgw8K+lAsM7pc4+kVlrkTnbt88EborMjhn8WZIlSJPgXzTzy7cn9xcdKu/pqtgbrnrpC6rK@vger.kernel.org, AJvYcCXy2yhYJnckrd2w68y0XsmoCT0dkYU/dznEQhYGfP725yHU7IRItEM/7UpK71KSgKU18e7/z3RSa6x8C4WAgEqX5nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YywMN3T92iqIToW4vuZJkqdV0WpAcaesO7GBwSJElOcwer3Vl1/
	0FDOeHgV3tWm3QVK+5lEcUtyB3Uu/F1EbBk1OJtXsjf5GTDCFNMPTDjwR8Da1msN
X-Gm-Gg: ASbGnct60btjQMBGejsKMhB2vyRRAg7wfCqzIy/jmKu9ON70OvYbmahiC7A1mMm82vg
	lRjHfzdMQDoFRQskydZx140NHCyDlwr4zYW+WUceRuUI932wqMoWYtJyP45siYYyYWfj4PXLBbJ
	+cbTZEai2yRivZ1AiTSzRydojn3ptBS94IeJP0eQPwaryT88Brn6ThFZ3QFo7S+wF19+Y8i1bx5
	nkcgdkO27NFObK3nMYSMmqV7/hGRXu614O85PewGwfUyofTCIAndOl9GRksN6yoMPIPbXbpjApW
	ozI0jHNSyUUmK1wSEp8fSfRaSLzcxFmme4oT+YEg5lsPJdELEx4ByO66EcUTHPjsm8IHRmJ9xrd
	giRZNVUnbwv2xhVl6p+IzNRXBTyP0tJ5tpFucFCGdm48AAE4cjpti+Tzw4eSI2jqlTG+21ZM=
X-Google-Smtp-Source: AGHT+IGt9PiuJmy9AcoxZRYsMv/5bqvzujf8fg2iSjmaO3YkfJ0s6Cr31PgV4V0JCEE/ug7Vv1138Q==
X-Received: by 2002:a05:6122:1350:b0:539:3bb5:e4d6 with SMTP id 71dfb90a1353d-544a0196ec5mr1998907e0c.1.1756732926046;
        Mon, 01 Sep 2025 06:22:06 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-544912c6d3bsm4380059e0c.6.2025.09.01.06.22.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 06:22:05 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-8988b982245so266566241.1;
        Mon, 01 Sep 2025 06:22:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUK6kc7SpPsrD+xuaqgwA5NsXE4sDIMe5nFKRHqobsdzRmGDhMr6xUeY15KASkJspwRUD702WOwOlY528TXLnyiZjw=@vger.kernel.org, AJvYcCVgDKrMR+s+c/9tsVIXjoGwEMl3utyx7y2mgZCy0g4RD5bjVfhDtTIwA8WRNJ4VMQpHCN7Vg3w2nuNjT8TP@vger.kernel.org, AJvYcCWhczDfOkxMKd/dqKta/RWPrBDD9FQm90oSLMnzF6q3HPO5LfQNhk5UGqz5WmWOUB4IalNgnN+bGnM=@vger.kernel.org
X-Received: by 2002:a67:e702:0:b0:52a:f806:3545 with SMTP id
 ada2fe7eead31-52b19846044mr2352761137.5.1756732925245; Mon, 01 Sep 2025
 06:22:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821141429.298324-1-biju.das.jz@bp.renesas.com> <20250821141429.298324-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250821141429.298324-3-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 1 Sep 2025 15:21:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdULwzW94LFbs2o=RU-BSrJpdLcuhmrNqeJN4t29JNUSXA@mail.gmail.com>
X-Gm-Features: Ac12FXwd5dQpKam-6dEqwPDDrkcEmWNCW-XhjykSMpHV-sl6MdP1QUHHQA_7lwo
Message-ID: <CAMuHMdULwzW94LFbs2o=RU-BSrJpdLcuhmrNqeJN4t29JNUSXA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] can: rcar_canfd: Update RCANFD_CFG_* macros
To: Biju <biju.das.au@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Aug 2025 at 16:14, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Update RCANFD_CFG_* macros to give a meaning to the magic number using
> GENMASK macro and extract the values using FIELD_PREP macro.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Moved from patch#4 to patch#2.
>  * Updated commit header and description.
>  * Kept RCANFD_CFG* macro definitions to give a meaning to the magic
>    number using GENMASK macro and used FIELD_PREP to extract value.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

