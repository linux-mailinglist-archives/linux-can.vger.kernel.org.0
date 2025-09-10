Return-Path: <linux-can+bounces-4638-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD81B5160A
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 13:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23EDB1888DBE
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 11:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9255730E85A;
	Wed, 10 Sep 2025 11:44:50 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D4325FA1D;
	Wed, 10 Sep 2025 11:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757504690; cv=none; b=mJpUifLXtcC1aRPi4cQk0i7a0LwZYNgCncBneppI1WThuzBv4XZ9QHKOJkjRhSg+2iwze5qoGFAJDMWPPYStTW/Um90eTpg4Nf6HokSbjnywA9QvSWLkz8gAXVOwgZmiJvog6jBjzTNvEKrReL4KKNmtoLs0pduWzUdFg3z5PMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757504690; c=relaxed/simple;
	bh=qFOKzwSy4+/kMNuPnqqV/VxLFFXu9ArvHPf88847BXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXrPHeLBzZGg/JEOg+o4INfzStK0HPnxczWNxyEBK5tONFgl2BD3YIdhZ9z/Godw933YLI7mWk2Vz7DXFc751322YcvqTalmLXYtDPCRcvtpycyT1E1pgQfavTNhLOZviaZ5ZjeVryxtpacNetRQS8PfkFhJwsgbYAqxyWyhZK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-545f4b31600so1419963e0c.1;
        Wed, 10 Sep 2025 04:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757504687; x=1758109487;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hMxHFFLSbMKBh562LQ05IQOcfgi5loSAFXBEfhNF46E=;
        b=QlYSVnUWLwyXsB5p9M78S+BNfn+QHbGud6E4YZzI5uAm9m1qwd5QRDKCkPFf9Wr27c
         ilTeTT9fLZqDb3MGoNWX9zraAceSGXlzHUELeLQBcEvAyGL+ml3wwxbGFe0blwoEa8K9
         8ZYRBm8KO6isR5sHD546KOM87gSO6Mqou0EgTvyLkWaxYhTfouRRAy+YwEWl91j5be4x
         wj46uWq5cyBR9UMV5hiFlyB8XWgOjm5UlZ/tWLoMK78vhltIQmuBDcjrXYLKQn6gxNNf
         QPjyNqdWeo5oVmwOav8uFlwwSYecbidOdfvRrlR2v35tcys+fDXtXUX0DPxIEgyfSKJo
         zyGg==
X-Forwarded-Encrypted: i=1; AJvYcCUJeipF0LEylKNzG5tgU6Z3m3Bq12fKRJbLtRNUn5Z9A9RJ8DGkbqAQm9+CJTsE7AALeLxNJ0PQgEqtkgjKw0qBtOc=@vger.kernel.org, AJvYcCUVAq2Q1AUzkK/Lwkk9d+KJi5GBaViU0K0U1BL48gIpbBeWswSyqoFvBYWrXRdv/WNca8lEl8lj1SOVjOSx@vger.kernel.org, AJvYcCXBCGBaUlqP4+B+/hK71xXlBxUZgLdwOFYNxLKZqXHQy7ezbEnncOnT0L+DoYozza6jCqJ6yLnkTKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YylRWbaaToFC32fkJlP6su4r4ILdNt+wahupOhNUjB8a0NM95LU
	gMQP4vxCAsKk8I29NFPAprW0twLtm+Ho+Z/w6oSg23buufKTQQLWwDDWZbx/UAnG
X-Gm-Gg: ASbGnctF5nkW6VqlILhNP+iDgB2FeJGVsy57DjsjH4Lo01afxOtgq8jTU/ALXd9PNDG
	JRPkpY3sREUvem0Aq6EOl/lunQOSoVc7rpgHX5JiOflfrefKUMTlazvu6x1cZtT06yRIZqiACgD
	c9idM1re041IvfNnG6Pzm9LCDSKK8pnPFhf17zecXv4dUoB/MXm3oHlgkeLpNh+V+o/5WmmT3zi
	qxjmcQgynClvygijI7/N7moY8JzM0J6qBurGGny9Cq24SXFkWoGM/IWCx39HDuqvRg4XGWXbnek
	cRCkhdXpcOufSfzy12QibY4/BIuz0YnZcIA5ctaSjbpFq/QB4FYVi8KmghdWfZjIFZ+Iix2NWLe
	La5+xt/+d5QOqL0aljmKRPc3n5bmby+xmpBB5gno6KxrB8aZd6fyjZExX9srBR4SlIUlq3g0=
X-Google-Smtp-Source: AGHT+IGujZeqaM1OvPxB9FCumirrb+WtfTdoHmVJwgpGcx9DaxNwVsH6881radgG18HW/NpXjBvkAg==
X-Received: by 2002:a05:6122:8c06:b0:531:236f:1295 with SMTP id 71dfb90a1353d-5473aabff31mr3610774e0c.5.1757504687437;
        Wed, 10 Sep 2025 04:44:47 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-544912c7d07sm14080923e0c.4.2025.09.10.04.44.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 04:44:46 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-8980d75995dso1879191241.3;
        Wed, 10 Sep 2025 04:44:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCULDC8HHJjFMDNHTwMRWUK7xmNOrnIouhdzBqtA1i/IA9Ok72HVEzwC7dN1T/QvfZoLvH3LPg0QancKkK24@vger.kernel.org, AJvYcCVZMyx7isURuhuo/NnwSF4T74ELU/AwTTU9D++iiyEoBdf8NR10TsZWSphsAOipxs0p5RW9uU7ehxse0BDpCcFKk+4=@vger.kernel.org, AJvYcCWinZI8m/7zWGUJRJQtE+FgoAOoiLqzS5WC0t/e6jCGuHeD7vxpuzUiWYali/3NPAcV1FYXZniX1lU=@vger.kernel.org
X-Received: by 2002:a05:6102:5cc8:b0:522:4c98:17e with SMTP id
 ada2fe7eead31-53d0c98bd16mr4600297137.4.1757504686481; Wed, 10 Sep 2025
 04:44:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908120940.147196-1-biju.das.jz@bp.renesas.com>
 <20250908120940.147196-2-biju.das.jz@bp.renesas.com> <CAMuHMdWmMzZ0gCNVAsBOGKDTO4kAF5TTcSo4V+m-_MGfsTo63Q@mail.gmail.com>
 <TY3PR01MB11346BE5957318E1805CF9E7F860EA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB11346BE5957318E1805CF9E7F860EA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 10 Sep 2025 13:44:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU7oqTfpGr38FU6GcbaRjF_Ku5yPyFmA2PpVW-zSyVP4A@mail.gmail.com>
X-Gm-Features: AS18NWApLmcM5nGc9hI5H5IM6Rq4E_LNCl90o3m6Gh62XYg4OyMWJhX1g9RyiaM
Message-ID: <CAMuHMdU7oqTfpGr38FU6GcbaRjF_Ku5yPyFmA2PpVW-zSyVP4A@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] can: rcar_canfd: Update bit rate constants for
 RZ/G3E and R-Car Gen4
To: Biju Das <biju.das.jz@bp.renesas.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "biju.das.au" <biju.das.au@gmail.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"magnus.damm" <magnus.damm@gmail.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Wed, 10 Sept 2025 at 12:50, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
Mon, 8 Sept 2025 at 14:09, Biju <biju.das.au@gmail.com> wrote:
> > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > >
> > > The calculation formula for nominal bit rate of classical CAN is same
> > > as
> >
> > the same
>
> OK, will send new version fixing this.

I don't think you have to resend the series just for this. Marc?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

