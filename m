Return-Path: <linux-can+bounces-6037-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F364D039D3
	for <lists+linux-can@lfdr.de>; Thu, 08 Jan 2026 16:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 085F530779FD
	for <lists+linux-can@lfdr.de>; Thu,  8 Jan 2026 14:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA90D43E49C;
	Thu,  8 Jan 2026 10:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxnBbT8k"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C373D5D91
	for <linux-can@vger.kernel.org>; Thu,  8 Jan 2026 10:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868479; cv=none; b=LeX4kxTrZavHQo48r/9VqMYbboQEicY4tI3BLsvN2NEBrLHvJxFusifLcvt9IrpyaPiW6vtek1+6fSc+93DljqTVlOgVlWr7QrWki+m0q458SuZv7N3EF7nGeDlbymye055UURzyAeULpBswDKvQC9IAVDyj57Wwspc3nUg+sTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868479; c=relaxed/simple;
	bh=8J95CUqGQzbNe9RQYZIjmFvxGxZyyAKIOnUoA40FzOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dbk7NXkskf7eIX2r5YC4ygP/oay5J0SEOHH9CTrpVeSL7BhN2GAwGpeCQqYi+xVNDPZtMssHooOPzlI4vJyYVgvHLELrssqfOO8oNFypKsmAx2mh55XhwF+DjsRQY1sG/2iClAbYmo46sTpUhRBuy+ETw3mPDu7ulMsWmdkdADA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxnBbT8k; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-430f9ffd4e8so808570f8f.0
        for <linux-can@vger.kernel.org>; Thu, 08 Jan 2026 02:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767868473; x=1768473273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAy6hcda2ByjMGo0ZNUpa3upflcaSQJbAAFWGQO0oJA=;
        b=kxnBbT8kAbFH7DMm/Lu6qn+KElqC5IMDTQ+sGAqkY60m1yFk05kzfZu/h+kNpgNAQR
         KAd0p/e6UlvOWfMi8J1K4HZZz2Pfp814/S6/8MM2YpXtQThCyAs8yZ540JYxzl3ttReg
         F09NrV8OVc7pF1/9Tat8JyIgw9/5c/zhb3DKLtHTcuJtW1GZmtM74XQ0EPINd7LlXcNz
         7Sp2EdOh5YVWVRfUy8I3KQYp2ijfifaR2EDXBgbJQ8DfBS7Qetexu2UPi4YSmXeVj6S3
         14arHjjewtMUIOnjvv1wU30temYpSPCRlNIUcVXWzb6Mw0WiBkyLLihUk1AH7xb8ZOqW
         d8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767868473; x=1768473273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WAy6hcda2ByjMGo0ZNUpa3upflcaSQJbAAFWGQO0oJA=;
        b=uzIrmdshJ+YspS8XgngMj0uB7do2DjTBt+Uc9dc2p+88pG/WmZnU5ISkQKJsSD+SOV
         TzJZnMN095x/Gv3FOfLCgc6a3FzgVAWyjfyZjhHltZ+SkHmanBbkBSRe2qIrbOyBjnWN
         BVVDZcFWlNLVNRB4jH25PGPcpKyJTChEKIX6CT2GYFrGP2zmTI+9rpAfgAfRdJ2rq39U
         SxNyPdrHwuVu3HTqUQKdVo3bCoI7jSMYVNiFIjcWBH/Wh/obxfuwBseN4G/GJYoyV2BN
         1CMU7cYAxkv9WcpeuVSG5Bi+Nqu4xQu6yK2LGcDngwSu4nVZwUljZEGfExGgjKm7K/fJ
         JYoA==
X-Forwarded-Encrypted: i=1; AJvYcCWlQpmLAC55Gtc9OVPWojJ6rxpfXhirtbL8d7ky927Yv52VYBGrSXAYOJfl5yVVFULyBFYhlSek+Gk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc9UrlZM+5JguKY6PP/j0iJfQ3MKheNaijlpAp7KETAW8sZSR0
	WwC8O90esnS3GuidAnMQkuEYsXzol8I2D0wQI25i77nWFl4zjZpruRgKPX3xpqVUu3wm97rYrFh
	+loLRGyyg98tmWBuZkH+uV54uFJS9E9s=
X-Gm-Gg: AY/fxX7CrRB7bw16HgokpQAZn5WBYYZTf1VGfjG50KF7CKumr58rYvrvNcN4q/mscWr
	mdUATyyGDWN5lPGq6uDuUF5+Tn+SewJSfN+xrajMeFYzIhrpi63jK6JOMblelHM9QwaEnYhMOtG
	t8vIBQHptdpyTSVMapynby5FEt4Q+35NQMULTwGeWNZMBUIvGCNf/6DZY91jNiHQ8EK9LPndWoo
	lCgJnJDKrSKP/VDkqL+nzVblG6PeJfYk/eBTX+HxU/31a6DYmdg0J9brsRwxqZQcO1x3rBBCQk9
	CWNKjcDUZ0jGjXrVU+uzabFG7h/sjS+xaf37XPzy+LF6HUwKi77hI+FeyUVWx7ro8EeFC70SH58
	8Gq69H49v62b1tw==
X-Google-Smtp-Source: AGHT+IG/lLLmJ7tqQ48LbhbdSS6ekHFjJMW9NFEvYoJ3mgIa0icSTmZLc9yjQbv317Rt2eLWoD8wp+yF3Smx93c39Uw=
X-Received: by 2002:a05:6000:430d:b0:430:fdbe:cc4f with SMTP id
 ffacd0b85a97d-432bcfad0e3mr12151914f8f.13.1767868473270; Thu, 08 Jan 2026
 02:34:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230115814.53536-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251230115814.53536-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdX5_TkFmgqv29Nddo4bZzEWQrL87kwqTdiLwfq+qMtsXg@mail.gmail.com>
 <CA+V-a8to1W2xbA7LpzLa5RSy02hyUFG0AeDR4iSsj7jt36VKVQ@mail.gmail.com> <CAMuHMdUe6gkbgQj7cjeZ5w2Mn_HPDwiuh5yEp8nQEE-vQPLqQg@mail.gmail.com>
In-Reply-To: <CAMuHMdUe6gkbgQj7cjeZ5w2Mn_HPDwiuh5yEp8nQEE-vQPLqQg@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 8 Jan 2026 10:34:07 +0000
X-Gm-Features: AQt7F2qYwu7k2jqryxnQQ1-oDkkg98jFJTRBpMxesBcsc9xHPBIinmS0EUGvnI8
Message-ID: <CA+V-a8t+R3bfMJ2JY7NsGcX9b-tgz-aBkHrt7bF2Lh7eiyeniA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] can: rcar_canfd: Add RZ/T2H support
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Thu, Jan 8, 2026 at 10:21=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Thu, 8 Jan 2026 at 11:13, Lad, Prabhakar <prabhakar.csengg@gmail.com> =
wrote:
> > On Wed, Jan 7, 2026 at 4:37=E2=80=AFPM Geert Uytterhoeven <geert@linux-=
m68k.org> wrote:
> > > On Tue, 30 Dec 2025 at 12:58, Prabhakar <prabhakar.csengg@gmail.com> =
wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > The CAN-FD IP on the RZ/T2H SoC is similar to R-Car Gen4, but diffe=
rs in
> > > > the AFLPN and CFTML bits and supports two channels with eight inter=
rupts.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.c=
om>
> > >
> > > Thanks for your patch!
> > >
> > > LGTM, so
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > >
> > > However, compared to other SoCs, CFDCnNCFG.NSJW[6:0] has:
> > >
> > >     0x00: Setting prohibited
> > >
> > Sharp eye!
>
> I knew what I had to look for ;-)
>
;-)

> This one was indeed hard to compare with other SoCs, as the structure
> is completely different. For e.g. RZ/V2H and RZ/G3E, I could just use
> diffpdf, restricted to the pages I am interested in.
>
Yes, the T2H manual is different as compared to G3E/V2H.

> Still need to enhance diffpdf with shift up/down buttons, so I don't
> have to adjust the page numbers manually when a few lines are suddenly
> moved to a new page...
diffpdf was insightful, I wasn't aware such a tool existed this will
be quite handy. Thank you for the pointer.

Cheers,
Prabhakar

