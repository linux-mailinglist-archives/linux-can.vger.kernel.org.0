Return-Path: <linux-can+bounces-6001-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B30D3CF5ABA
	for <lists+linux-can@lfdr.de>; Mon, 05 Jan 2026 22:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A19B6302F2C6
	for <lists+linux-can@lfdr.de>; Mon,  5 Jan 2026 21:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2B6277037;
	Mon,  5 Jan 2026 21:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaSktb+O"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45372848A8
	for <linux-can@vger.kernel.org>; Mon,  5 Jan 2026 21:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767648626; cv=none; b=qfLpC0H/9xMbV+/XXMXuAOJZ6LXJFQxgrZunML9LzaVxT2G63paZMWL44o80gOAcF/xw7h8myQHDebRLRQ+vR5CMa6UHXC3oB8EZXRBRjoBczl1Tb5EKcI92joVa5Kr8KhdvZBbKRK4EytcrponSU8xiE4rj88DGLmZqIQv5ieI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767648626; c=relaxed/simple;
	bh=3n2vCisThVsOlragyGDay+6tW9w4bEoSHR5iRUS9Glw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBXiUt7ELyL0/77/aMJ4jwgEWFYzlPxeKMpQ1cFvIdrbEQezaAlPx/+xkQkC/lcjYAXwe944d0Pyew6Ky7AjKTAL34FYyfT3jDLZZM5bOGwBVK7zwiczbVM9XNTEhaO6ph6Hh4W+t30Z+o8+gt7TxcJ7UfyfMIWInRdnlV8AaYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaSktb+O; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso3177325ad.1
        for <linux-can@vger.kernel.org>; Mon, 05 Jan 2026 13:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767648624; x=1768253424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNQTNhTvb1y3r7Npal158k3hpZgaWnE9Tjsv4NEjAEw=;
        b=kaSktb+OJP6e5Z/3toUd+sSmSOlSNCL93jQuFV3yrlQ0CV7cgturJMM0BWhFgwashz
         jMTQ/4eY8JBBDKFchuubNoH+NmkAtmPMcaN7FR4c5c40SW3Ef2AJVgpl1QYiLL+Vk3aM
         N57R6rcOGTm2Gnf+LGNa0x63kRQirS7J2EK46czy98368ESGjbwIaM7BlS5B27dH+bpV
         8Hd4v8/EUsstTftlZ3Xre12EUkTaQP5S5sABlT6q+m5QBaqfNwiOYGqtI4Sn35GVQsr+
         ebmkU8iuszfXD/kHYZTd5B2U1FPnDom1VGbZxHxdxVEZit7fAJcWGvkoCqTqB8GmyM4U
         buWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767648624; x=1768253424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hNQTNhTvb1y3r7Npal158k3hpZgaWnE9Tjsv4NEjAEw=;
        b=p7L4Vx5BIFS4dSUi52WJZPYcaHJByc8Sy5xyhruP05iirZ4TtRU4oXcl/BfJMuNiH6
         tYbjilZrit00nqW6p/UJDkBjxfML97deGYl1Ui6DzjZ98Edy7qcklMZdNpnWwm+SPayn
         0XdeMwdBUER6TUvcWh+SIi6weg4J3h7Jrtae5SrdlJzUUmFRt4/bM1bZiLPTVcD6K69k
         puCldlC4X/L8+HA3Vm4hTAHD51oduNC2dvqLPWqENM5e5Tr2j93C5qQRFEYQRlSYy/HI
         xr9G0vlxwwIfaN1/f/N/OcMau5q0N3up/T/YQ7AKu7Cy8JlHvWWzkJrIYheyu7JV0GB8
         /EcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIP+whQejvbC531Ia2Zh1RNHhpM5Adp7Pyz2nM09l0haVycbBwWzVr3tYzrrjNLLRA/bwem9wulWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0I1WNS/KRKB+Ire+0fennoCtG96uFEO+3zQ5oI6eXsp5b89QG
	9zyQnxYQzkRyxc0+ATvncT0oAPFqoy/Vof55lqcLXxEHa60S15OB+SCjJYjrf0j7IJU9AVeccBY
	AQMbPFLXXKSUp81/ilaG0HeEC5lTzGT4=
X-Gm-Gg: AY/fxX7octcXaM23AGih5a21k1eVIpAtXTUnTap4DDhSHsWR/MS982ZpNWb3DYoZwVf
	1WlajCsVKjjeI3AnLNFKCqrW3dP9xAJ9hVgWe2lpE5hzbP7QDXiZlpTQYHGUwumLaEmBV5k21mQ
	Sf5tiNjf5fRvHCZVLXVG0g3cb6aPvmsyc6wM+AW24u2xySVMfxCuB9QRdsqJg9DFs0edGEF6P3a
	6Z7Dwkl97AtPgzUVBJ2o6ejXK1DWY+TaVT4b0kfG41WS//KyaNXYLJ+iVnBUkXmcLPzA26wH3NP
	utjUBSwmx34=
X-Google-Smtp-Source: AGHT+IGhvOS6mcpN4NPO0ujazhU5nslDD3kJzFAVysyKpRaxl9lOdq/Dh+NTy2Y+4Opk4T8XqoGTf22bJdbaV7lJ22s=
X-Received: by 2002:a17:90b:3843:b0:32e:a8b7:e9c with SMTP id
 98e67ed59e1d1-34f5f32c24bmr465278a91.29.1767648624076; Mon, 05 Jan 2026
 13:30:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117173012.230731-1-activprithvi@gmail.com>
 <0c98b1c4-3975-4bf5-9049-9d7f10d22a6d@hartkopp.net> <c2cead0a-06ed-4da4-a4e4-8498908aae3e@hartkopp.net>
 <aSx++4VrGOm8zHDb@inspiron> <d6077d36-93ed-4a6d-9eed-42b1b22cdffb@hartkopp.net>
 <20251220173338.w7n3n4lkvxwaq6ae@inspiron> <01190c40-d348-4521-a2ab-3e9139cc832e@hartkopp.net>
 <20260102153611.63wipdy2meh3ovel@inspiron> <20260102120405.34613b68@kernel.org>
 <63c20aae-e014-44f9-a201-99e0e7abadcb@hartkopp.net>
In-Reply-To: <63c20aae-e014-44f9-a201-99e0e7abadcb@hartkopp.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 5 Jan 2026 13:30:11 -0800
X-Gm-Features: AQt7F2qB98D05JFXrn5jIaSNXe0Wo-ByX8IsQT-ZSn0gRMHCve1bRDNsBexvBSA
Message-ID: <CAEf4BzaXNbzsVhLLk2brJn0duyRTjxoiofisEQOv=y43hxvFag@mail.gmail.com>
Subject: Re: [bpf, xdp] headroom - was: Re: Question about to KMSAN:
 uninit-value in can_receive
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Prithvi <activprithvi@gmail.com>, andrii@kernel.org, 
	mkl@pengutronix.de, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 3, 2026 at 4:21=E2=80=AFAM Oliver Hartkopp <socketcan@hartkopp.=
net> wrote:
>
> Hello Jakub,
>
> thanks for stepping in!
>
> On 02.01.26 21:04, Jakub Kicinski wrote:
>
> > You're asking the wrong person, IIUC Andrii is tangentially involved
> > in XDP (via bpf links?):
> >
> (..)
> >
> > Without looking too deeply - XDP has historically left the new space
> > uninitialized after push, expecting programs to immediately write the
> > headers in that space. syzbot had run into this in the past but I can't
> > find any references to past threads quickly :(
>
> To identify Andrii I mainly looked into the code with 'git blame' that

Hey, sorry for a late response, I've been out on vacation for the past
~2 weeks. But as Jakub correctly pointed out, I'm probably not the
right person to help with this, I touched XDP bits only superficially
to wire up some generic BPF infrastructure, while the issue at hand
goes deeper than that. I'll let you guys figure this out.

> led to this problematic call chain:
>
>    pskb_expand_head+0x226/0x1a60 net/core/skbuff.c:2275
>    netif_skb_check_for_xdp net/core/dev.c:5081 [inline]
>    netif_receive_generic_xdp net/core/dev.c:5112 [inline]
>    do_xdp_generic+0x9e3/0x15a0 net/core/dev.c:5180
>
> Having in mind that the syzkaller refers to
> 6.13.0-rc7-syzkaller-00039-gc3812b15000c I wonder if we can leave this
> report as-is, as the problem might be solved in the meantime??
>
> In any case I wonder, if we should add some code to re-check if the
> headroom of the CAN-related skbs is still consistent and not changed in
> size by other players. And maybe add some WARN_ON_ONCE() before dropping
> the skb then.
>
> When the skb headroom is not safe to be used we need to be able to
> identify and solve it.
>
> Best regards,
> Oliver
>

