Return-Path: <linux-can+bounces-3190-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B99AA6AFBF
	for <lists+linux-can@lfdr.de>; Thu, 20 Mar 2025 22:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA398886B70
	for <lists+linux-can@lfdr.de>; Thu, 20 Mar 2025 21:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9E1227E9F;
	Thu, 20 Mar 2025 21:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rDezse0C"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D990213245
	for <linux-can@vger.kernel.org>; Thu, 20 Mar 2025 21:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742505591; cv=none; b=JTqTgEcUNeOLwMHty89LGuWmvFgLFIGZc5vl+O+C6rZ/5GXSyRyb/bDPEFVulxBs5sco2B76b6amFfdnOVEbTDUkq8fI9Jl9ozjtL53rjy3bbfeVoNGkD1NmcRywSezOv+3Jd1SGiBl6/11y9gWDBBFyCx/95LceRCEcQddPD1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742505591; c=relaxed/simple;
	bh=SeYsGh25r0ywhE/QvnvEtolHiHO3v9wHxs9KaINCRUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=skufpZljqjxwgPrbKGakBGUfhwG/sYoNziGJIaEFrLvj30KIOrABGBfl9GkKVM8AWdViEmp37+vZKOfOfbHOvzlLItgCEoR56+b2/q1CBVVDKT4GWkCNYDtCFwAtDJtur2hLCjjw2f5WUcgQU2Wuudf/W0Q35LzWkppLS/A107g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rDezse0C; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ff797f8f1bso2238014a91.3
        for <linux-can@vger.kernel.org>; Thu, 20 Mar 2025 14:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742505589; x=1743110389; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SeYsGh25r0ywhE/QvnvEtolHiHO3v9wHxs9KaINCRUo=;
        b=rDezse0C8M7QUC9X+OBK11eQH920lTQcutT/Q52SKaViHt7ouFq53F/saxC2vIAdE9
         3Dpw3uxG5vvwq28rWwCUhusebVDqGxK1rLcqv13yOK4eKwScHV1ASzsRaCYU6XmBaj8e
         k6hLrIHP+tdZRHQdSdQjCbSuZvZCyR8dYbqD1PNS8liDhkNSijquwnXPkZ62d3l/w7/V
         dPLlBRgcS2Tund+jQRoYymRxTdIK+XqsJTz8Y2euIzTJ0Dsd1LgQfLwhFLV7atwIJXzp
         N30odrIHPyBcb6gn5JoqKb6DRNpGb7UK0jyLuEMtWYg/+ExcFjy4xWU4eVa/AtMJiqBV
         L5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742505589; x=1743110389;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SeYsGh25r0ywhE/QvnvEtolHiHO3v9wHxs9KaINCRUo=;
        b=WVbbN9XcugC/nWWteX+dvRSyeA4INPzKzxmblaeT2VOwaAV5ZJwyznggr2L47dYxvM
         o9KMd6NAAj/vmqQ/5IGZ4cMhzKFlM2MjfZ9xXL8rPJnGd1NwLlOw+0pGK0UAy2R3ockm
         05i8JHe/oxe94C5f7ywRyOZtKyABNJlUUXc5/oIdqQ4VpGIneKLK++aGrZbCqyUg1AQf
         dDmbaN6EH95IFzCB24n4b1i8BYUzCwn5Dn2iDSD7IPkYm1UeT8SFUxEb8Ne71rtbD546
         0N2PMaR7U1PoFlXu5EvG1FmH1byiXV7R3PWIbRfc/AH6JKD9Lqo3TBcXZ4gQm9trQjv/
         t5VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWW96xJf19Mz/mDEnp//FSDf/qkI2FV691aQ21/rEByHN9RBoH7iocdUqL8KYsnJfFlyJrTQWLzw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOfjxLPiWhLTHPZ6iN2rWxrWDlNc+7m6wDALxLIjvz+h8imN2/
	FP8eM6wJyEXqu1sXTlkl/d6DafbVeSeb2NcJBGVP4+x8hacurHjfN052BakRuCBrDDs3q/s/iK3
	MxRJdnzhY6WqeDqgSSvsvFamWHlrr4nsnENHv
X-Gm-Gg: ASbGncv6faLO5JXhoKLELfUZz0VIC+CKODR+Av82lLC4Vp4dszB50zTNBZnp8MsxsAK
	xdjxSqJiN2oqGKuz7QGsUgnn3bZgE++DyZFbe+8hE938c2o1eJnVh863GfEEXy9usvy2RRsS4td
	ZfBPq09rlKA7/bEVYX5NQHcE5OJ0V0StdaFPJ7aFn1qj4Y53Vvs0uw7/465Q==
X-Google-Smtp-Source: AGHT+IG5UxLbD/zV9btCjR0yXp3YjG8T0d1HLUnOEWiogKiEAEYLj7jcwZRSsZGc2U9tFqcLLhKZ135161o8xG5oZ0c=
X-Received: by 2002:a17:90b:554e:b0:2fa:228d:5af2 with SMTP id
 98e67ed59e1d1-3030fea0d35mr1302957a91.15.1742505588652; Thu, 20 Mar 2025
 14:19:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67cd717d.050a0220.e1a89.0006.GAE@google.com> <c9047828-708a-42d8-97f6-fffb7d806679@hartkopp.net>
 <CAMZ6RqKyMreMfNDmYU=tLyaEcReopmGx2VkBWPB12LLzd5o7Pg@mail.gmail.com>
 <f8e7f845-253b-47b7-9e09-97a580ce0e5c@hartkopp.net> <CAMZ6RqKga=f=Xd33GF1zPwmiearrz3mg+ZiryVbJD_RE5MGjKA@mail.gmail.com>
 <b7cb5a2f-29a8-4174-8b0e-c9cbf7349531@hartkopp.net>
In-Reply-To: <b7cb5a2f-29a8-4174-8b0e-c9cbf7349531@hartkopp.net>
From: Marco Elver <elver@google.com>
Date: Thu, 20 Mar 2025 22:19:11 +0100
X-Gm-Features: AQ5f1JpihXOzjTzRKykL2TcmD5WiD1Urfdf6T7S2ftDirq7tmr_69RLvSySNM0w
Message-ID: <CANpmjNNMT6DNEB69dTySX61dSMHc2fqMWN1sA1fcvCWSXeRugA@mail.gmail.com>
Subject: Re: [syzbot] [can?] KCSAN: data-race in can_send / can_send (5)
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, mkl@pengutronix.de, 
	syzbot <syzbot+78ce4489b812515d5e4d@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Mar 2025 at 15:36, 'Oliver Hartkopp' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> Hi Vincent, Marc,
>
> I sent a patch to be reviewed:
> https://lore.kernel.org/linux-can/20250310143353.3242-1-socketcan@hartkopp.net/T/#u
>
> I've also tested this patch without any new issues.
>
> Best regards,
> Oliver
>
> On 10.03.25 10:55, Vincent Mailhol wrote:
> > On Mon. 10 Mar 2025 at 18:46, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> >> On 10.03.25 10:29, Vincent Mailhol wrote:
> >>> On Mon. 10 Mar 2025 at 03:59, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> >
> > (...)
> >
> >>>> Isn't there some lock-less per-cpu safe statistic handling within netdev
> >>>> we might pick for our use-case?
> >>>
> >>> I see two solutions. Either we use lock_sock(skb->sk) and
> >>> release_sock(skb->sk) or we can change the types of
> >>> can_pkg_stats->tx_frames and can_pkg_stats->tx_frames_delta from long
> >>> to atomic_long_t.
> >>>
> >>> The atomic_long_t is the closest solution to a lock-less. But my
> >>> preference goes to the lock_sock() which looks more natural in this
> >>> context. And look_sock() is just a spinlock which under the hood is
> >>> also an atomic, so no big penalty either.
> >>
> >> When we get skbs from the netdevice (and not from user space), we do not
> >> have a valid sk value. It is set to zero.
> >>
> >> See:
> >> https://elixir.bootlin.com/linux/v6.13.6/source/net/can/raw.c#L203
> >>
> >> And those skbs can also be forwarded by can-gw using can_send().
> >>
> >> Therefore there is no lock_sock() without a valid sk ;-)
> >>
> >> When 'atomic_long_t' would also fix this simple statistics handling, we
> >> should use that.
> >
> > I see, Thanks for the explanation. Then atomic_long_t seems the best
> > (and easiest).

While I would prefer atomic_long_t myself, just to point out an
alternative for "lossy" stats counters: could use __data_racy or
data_race(..), and just accept the data race if "approximate"
statistics can be lived with if the stats counting is happening from a
very performance sensitive hot path. See section "Data-Racy Reads for
Approximate Diagnostics" in
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/access-marking.txt

