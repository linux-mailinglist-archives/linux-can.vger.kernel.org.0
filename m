Return-Path: <linux-can+bounces-3486-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0019A9C3ED
	for <lists+linux-can@lfdr.de>; Fri, 25 Apr 2025 11:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2CB4C14FA
	for <lists+linux-can@lfdr.de>; Fri, 25 Apr 2025 09:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7942F2367A0;
	Fri, 25 Apr 2025 09:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="RQLJniSL"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-14.smtpout.orange.fr [193.252.22.14])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEB422ACF7;
	Fri, 25 Apr 2025 09:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745573825; cv=none; b=KHRgbYZbOFMd2ex3BUYqKzWgiKkPgqhS/bywGus9KuseeL8mOqLRaztx5yIq+Wwd8eEpX5xsktbXOvn1GY9E9a/Zra+lS2E2Oar+Fc/l/qVxu3t0X1wjXOuwqhzARvZvvFQ3DFHky6I5gC3TvrsPy1E/oIAkj+3irjRtxYcaASc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745573825; c=relaxed/simple;
	bh=qxMIvRrwFSrwiByZ0V/7xQ1TIaTORm9T/nkQQ3Gk+7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DaKD1XA1YlbfeQgfjyN9bayjsB9DZqpZCZibAhgAqiAiRhQfy40F3AIKSWpf7L2iR+aKDXwBix4+dnclzJWRq3XXiE5N+AIXZeYlREc8WRkBaJ+Q2CFLRwEXUEAG9n/1tHL/RJK7ly+AL1WQh4S8HPVke3lO+QYBEVS4HpvXG6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=RQLJniSL; arc=none smtp.client-ip=193.252.22.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ej1-f44.google.com ([209.85.218.44])
	by smtp.orange.fr with ESMTPSA
	id 8FUNuS358XKsE8FUQuLnVv; Fri, 25 Apr 2025 11:36:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1745573818;
	bh=p94lTC9dY0noK983SK5duM8chDMkVg8VF0K2Ki7dMNQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=RQLJniSLm+6VJOkUFDm0oESkD3O0Tk/cSCiHBcHe3oD8rNm9Fmr/g1w/QoVat0Q12
	 /+5YfmVwaVgY48TkI/qCbVQk/mMgAMuSHi4a3BhCLShRsMxO/SKFGmLlaBJKCYQWx9
	 nXpzWAklFgIeiTZg2FVew83X6B5b0s/SsvIEFBKWSuiuxZNNvTT4c6+7tDTUtVaZAM
	 L9d3ZVE30rzUQCxlsafwa/H3qIZrwDoZ265eCyjfCpphfsPoDdHMg6mGylUbDrBjrF
	 evZf0PjrQYvd0ZvhdE6A9RobboQowcsGi+n4lx/B3Y2mZlSgSXUaAzkI7Es9Rsoq7e
	 8NUWA6VIuB0XQ==
X-ME-Helo: mail-ej1-f44.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 25 Apr 2025 11:36:58 +0200
X-ME-IP: 209.85.218.44
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-acb39c45b4eso313618466b.1;
        Fri, 25 Apr 2025 02:36:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVUalbDuC7q61hi4xOJpacY1Mq0Esh1uEt25e2DpPjhaxC4GLBLf+uqW2cP4EG12ZrmtWa6BK0VXjYozRvt@vger.kernel.org, AJvYcCVldTHyNjmLeNJVylexVMSQoB4DkmEteC5zEEkBwOyMFaruFaGLLYTASilBE0YiiNcFZ0feozv534Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YypMXKlMHIn9rqhEJ2+UtQs69Pj/x+u16c7Q/naBGO8t+DMN8yK
	HQ+JdVvp0wibnFj23Z71/SKSQ2j50xShIkimnVUHE/lMe5Zt7+ekJyYSVMx6M6taRw50ozByVg5
	pK9wetuxIzLl5rOykagCep/h6oKs=
X-Google-Smtp-Source: AGHT+IHvPida6KsfMYAqrz6MwkQViIBFESJz9dYSFxGaMDG2BGtUJoo0r85rPSXfdHqxjr73VI/+ZSksEpIygrgJU0g=
X-Received: by 2002:a17:907:2d8a:b0:aca:d48f:4d48 with SMTP id
 a640c23a62f3a-ace73b65de4mr114092066b.60.1745573815189; Fri, 25 Apr 2025
 02:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424125219.47345-2-antonios@mwa.re> <20250424-industrious-rottweiler-of-attack-e7ef77-mkl@pengutronix.de>
 <a5684bfe-981e-4ba3-bbea-d713b5b83160@wanadoo.fr> <2fe59c0c7e0f7b9369976501790fce5beaea5bc7.camel@mwa.re>
 <CAMZ6Rq+QVHAh8HvWcn8rAYGE8VoJmhQUxOFNqBpijSQz10Dodg@mail.gmail.com> <1f4d6de1f452021511301070e76695d1e56a14a1.camel@mwa.re>
In-Reply-To: <1f4d6de1f452021511301070e76695d1e56a14a1.camel@mwa.re>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Fri, 25 Apr 2025 18:36:44 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqLXrdfS9sjaZaFcZtOyaP9Q8hHk8Wb+d7D1ovVEvK_OwA@mail.gmail.com>
X-Gm-Features: ATxdqUGamFUi_0otWzOoVf_yL7RYRfTZNoEfukjKv51ObIsPYOK9W2KIN9Qw-oQ
Message-ID: <CAMZ6RqLXrdfS9sjaZaFcZtOyaP9Q8hHk8Wb+d7D1ovVEvK_OwA@mail.gmail.com>
Subject: Re: [PATCH] can: m_can: initialize spin lock on device probe
To: Antonios Salios <antonios@mwa.re>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, rcsekar@samsung.com, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lukas@mwa.re, jan@mwa.re, 
	Markus Schneider-Pargmann <msp@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri. 25 Apr. 2025 =C3=A0 18:18, Antonios Salios <antonios@mwa.re> wrote:
> On Fri, 2025-04-25 at 16:18 +0900, Vincent Mailhol wrote:
> > I guess this is because your kernel has CONFIG_DEBUG_SPINLOCK:
>
> Indeed.
>
> > Without it, this would have been a more severe NULL pointer
> > dereference.
>
> Strangely, a NULL pointer dereference does not occur, when I try again
> with CONFIG_DEBUG_SPINLOCK disabled. The kernel does not crash, at
> least on rv64.
>
> Looking through the implementations of arch_spinlock_t, it seems that
> only PARISC's implementation would cause problems in this case since it
> uses an array.
>
> https://elixir.bootlin.com/linux/v6.15-rc3/source/arch/parisc/include/asm=
/spinlock_types.h#L11
>
> I think I'm missing something, why do you think a NULL pointer deref
> would occur in this case?

I see. Thanks for your test. I went a bit too quick in my analysis
when I saw things like:

  raw_spin_lock(&lock->rlock);

in

  https://elixir.bootlin.com/linux/v6.14/source/include/linux/spinlock.h#L3=
51

I thought about the NULL pointer dereference. But indeed, you are
right. The spinlock_t is just one attribute of a structure and will be
allocated anyway even if spin_lock_init is not called, so calling

  spin_lock_irqsave(&cdev->tx_handling_spinlock, irqflags);

will still pass a valid address.

The other thing which put me off guard is that some other "spinlock
bad magic" got assigned some CVE.

https://lore.kernel.org/linux-cve-announce/2025031217-CVE-2025-21862-e8a0@g=
regkh/

But here as well, that does not imply a NULL pointer dereference. I
think that the bug is only that the spin_lock is not working as
intended.

Regardless, just saying that it is a spinlock bad magic bug with the
dmesg trace is enough. Thanks again for your tests!


Yours sincerely,
Vincent Mailhol

