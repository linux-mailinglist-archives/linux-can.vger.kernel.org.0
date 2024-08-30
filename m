Return-Path: <linux-can+bounces-1235-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D755965EE1
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 12:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C151F21160
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 10:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE44C18FDD2;
	Fri, 30 Aug 2024 10:18:58 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7872818FDA9;
	Fri, 30 Aug 2024 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013138; cv=none; b=s/x7d5uYIZtwf7QMVqTXlg3ARYnolUJHXtsAW/SW9h31GxWgeCdn1bzEJXoLkS6fJsDircmNsZC1wj2MXfOBA7wVA99jDLAzj7xhZr7/sGs4v8FXMnkE4uu7KEh5ewfRSdtlML79/8+REYgtZo50qr+l6pWjHV5xyAOkN+S9+xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013138; c=relaxed/simple;
	bh=BKM4Y8640YHOSxpYLdRchVJEVqdN78D/G8cjvnB1WNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8DNsHhWQV8vir+DYg0fe0O1cSwDvywePqfTtFs+3rN51SxB/6nvhSXXtHStAnwkAS/5Nn3YLt/qqhL7yY5nN0rnyRdK/ceNIL57C9l40sM0yEqraGX5WmX1x27AR/zyYZoRZr54xUY4c23BQp0UsG8PbzCnoKzJCpyfRy9tzdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6d3f017f80eso5435917b3.1;
        Fri, 30 Aug 2024 03:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725013134; x=1725617934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GGMKBcmbf1+MN7Za1nAGnUfJRRRTNcwjVDt2pFW88g=;
        b=Z+Z5sg0z6hcEzZ9t9TnqbDt20NJ0xmtaypTqi+3sdR6oF5p54nwHWfeIq/I1UDeVP9
         OzgPZssVZpZjYemk4Uvw5tWUJPql1iJYI8F9me5AUPJjfxA9pLT7nnMWnx8pzXeMyC/A
         Yd2Y9nrHWSGxiYPcJvNLU639zXXicH/1pNi1onH4GVsIMmYVjoteKHSLAMUybSg5HuTz
         jnkAl0jd1ZZ++oUWhfMt79YEWXE42lg4IHwbq/s77RG77VGwSt+a9e7+er1QtzqfCzGB
         ab0a35q4RqJfXgBmTNaUZVLZU9EJQ0H5YwsNCAcBQh0iLLyOUivB22zLu047GYwxNxrG
         4Qnw==
X-Forwarded-Encrypted: i=1; AJvYcCV8zb142hNjYLtqVqcE13kjqUU4MedHMPNSBeir39AAWPLbVkK3ahSWAaIr39uOvsPsJ7o0ilmQylQU@vger.kernel.org, AJvYcCVBDbolwh4hSpp42BRPFUs8lsE3/i3V+9CkQIU4BrBrEwL1BOU0o9MzBsOwsHc21Ftg5+dJLpr41NYl@vger.kernel.org, AJvYcCVavFw1PKKLXVTa4L817t5Ojp4ZcFIS3eJgWkS5xlAB8FjBP2FzO9DiYBCIKrGrrgk2dRZgrEyz2GvPoNC+xCZ+HDE=@vger.kernel.org, AJvYcCW4jvmDj21LuvjEuPxYKJJ9plEQPlaJv7KcN+QU6StyK/4I0EWwP9tNNSU63kqwYqTDCvLmEXzR@vger.kernel.org
X-Gm-Message-State: AOJu0YzWCD13Yr4XldAkxglQ0NKyMbwBozMjYb6gJzafaU3RGyv8IUxD
	NIouOwc8zF496SE+2LA1R8TXZwozy2w0mHYI2HAbYn99PsTeY4wefQPK05Sw
X-Google-Smtp-Source: AGHT+IFIcWTscoMaY9F5lW6e5cXl9IsGdZ8dGUKb9EUUK06g/tauOut0+cd1kBUS7dfeE6rQ7KDeYQ==
X-Received: by 2002:a05:690c:4dc2:b0:6c1:2b6d:197f with SMTP id 00721157ae682-6d410da9029mr11163797b3.36.1725013134221;
        Fri, 30 Aug 2024 03:18:54 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d2d40a7825sm5711267b3.55.2024.08.30.03.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 03:18:53 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6b0c5b1adfaso14828857b3.0;
        Fri, 30 Aug 2024 03:18:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgcuJi4AZyHLvbmaPkV6J96SzYIcfqLUAjuL07pxbM3wBw/cMc6k1mlfA+0mA1My7QKOJLtvPF@vger.kernel.org, AJvYcCVCdCKgwJ+q10ocikBZn911w+M25n2+eoNb6VPyk+8oQeIwKMkd7nX+vwI6B1V4c0Ts+fFSR8CvnSTk@vger.kernel.org, AJvYcCVgn6n77mpgbDfk+Iwj6xpmAVNW5aBtJ1aoXH9oHkpOxA22tOfa4q5w5BadyED8I7jPC4QMXJLKENkW@vger.kernel.org, AJvYcCWsR/5x/PvEATcx4M06mwNMeP+Nnu6/6y9pGRLcR80uFkgy74cBMKziUvjv/lZdhNWVeGEAY9/Sg9EUjUnvZWJx1NE=@vger.kernel.org
X-Received: by 2002:a05:690c:60c1:b0:62f:aaaa:187a with SMTP id
 00721157ae682-6d40f4393afmr17601517b3.14.1725013132771; Fri, 30 Aug 2024
 03:18:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68b5f910bef89508e3455c768844ebe859d6ff1d.1722520779.git.geert+renesas@glider.be>
 <20240806-fragrant-nimble-crane-c5a129-mkl@pengutronix.de>
In-Reply-To: <20240806-fragrant-nimble-crane-c5a129-mkl@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 Aug 2024 12:18:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXy09rrzB1sc9Soy5mUvMo=u=r_-Yf0iah_HTsYJ+fNDg@mail.gmail.com>
Message-ID: <CAMuHMdXy09rrzB1sc9Soy5mUvMo=u=r_-Yf0iah_HTsYJ+fNDg@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: can: renesas,rcar-canfd: Document R-Car
 V4M support
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Duy Nguyen <duy.nguyen.rh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marc,

On Tue, Aug 6, 2024 at 9:15=E2=80=AFPM Marc Kleine-Budde <mkl@pengutronix.d=
e> wrote:
> On 01.08.2024 16:03:17, Geert Uytterhoeven wrote:
> > From: Duy Nguyen <duy.nguyen.rh@renesas.com>
> >
> > Document support for the CAN-FD Interface on the Renesas R-Car V4M
> > (R8A779H0) SoC, which supports up to four channels.
> >
> > The CAN-FD module on R-Car V4M is very similar to the one on R-Car V4H,
> > but differs in some hardware parameters, as reflected by the Parameter
> > Status Information part of the Global IP Version Register.  However,
> > none of this parameterization should have any impact on the driver, as
> > the driver does not access any register that is impacted by the
> > parameterization (except for the number of channels).
> >
> > Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
> > [geert: Clarify R-Car V4M differences]
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Added to linux-can-next.

Looks like you are back from holidays, but haven't pushed linux-can-next
recently?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

