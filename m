Return-Path: <linux-can+bounces-1687-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F8E99E042
	for <lists+linux-can@lfdr.de>; Tue, 15 Oct 2024 10:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C341C21D36
	for <lists+linux-can@lfdr.de>; Tue, 15 Oct 2024 08:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A521CACEE;
	Tue, 15 Oct 2024 08:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hnQu98/6"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253EF1C2335
	for <linux-can@vger.kernel.org>; Tue, 15 Oct 2024 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979466; cv=none; b=R63+8g5yfCqGIE7YUl7fkqBJuGC9thSDBL1hU2wUZqjdQlfK1rPhv1YlvVPMjgetKfUle1dEBDD80hSpClD3dN44bMa5M1KzpY/Cd3LwgKX+y6JI/E/qoXHsqRQXu6HlqHfB8EwTfLGm/u5yVoTmc3+gnicQSvqWyvQdJHPDGDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979466; c=relaxed/simple;
	bh=jjdIGCXHtqrrmc4Zac1h6TFtk7ByfeGFj5BklO3jkIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I5LHpcp1q4TlkZYDKqAbS8PejNqLsk1ccw4Q+iV52Xge26/t14jmH404T9dn1w1FUEGfqVQj4/rQCR4WuiOZ64G/UZHTtLbTpRPYe3GobbcM91uPLjZ9VwaYBF6fixFu/RDA5CUAGE8/Tg9elgCIPL5Z1g5sbJmKAKsOqRcVWZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hnQu98/6; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c937b5169cso7341900a12.1
        for <linux-can@vger.kernel.org>; Tue, 15 Oct 2024 01:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728979461; x=1729584261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjdIGCXHtqrrmc4Zac1h6TFtk7ByfeGFj5BklO3jkIU=;
        b=hnQu98/6K8SfIZ+dZFCoVE4e3xhktR+KfmU5DsMYkyCurs6E//JqSiMA2A789KPzpe
         BG7ka08xP3QYQ4vgIhQNXCzJr+93S2xq9YTll6CfXlktnSbaKnQNn2pFS+nWPyk6k3hG
         Em65NimtywSQ34dbgDVQ/hYVA8K7ugXXPtSboyZyt/qEOQJposkJO5qAAq+4ADq0t7aD
         38EXzUyZEW+4D+SlhNZ5RrnaUzx9JZfl2sV2sHwRK469n8kHWM5TNydQi/z47zkysnI9
         jBea0/FDWp/BL0wVA1b+4b7Yl3pE14YOBqUFiCUKOgYJrjZ7EWJPvaexBhq+diT69fKt
         7/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979461; x=1729584261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjdIGCXHtqrrmc4Zac1h6TFtk7ByfeGFj5BklO3jkIU=;
        b=O2OT2+3i80xj4slBLnhMWy7OsnYrnmydUytpz9W1CPgMhkNZbLfS7MfINtr7lQgCbJ
         ojEsDdK4L1lfSGjuTV0GOWdsvo73rY+i0n8B4nv28D37EtlYg2+ka8bVNxb9Tw94OUSA
         yzvk79ACYr2UANVsV/CWYA3PeIgNQnYMAHDPVy6FY5ArBt5VdHhCUhYDXrwH8gJlWTH7
         cWqGSqjNE7Qc8PaEfxVbV6HHT9/s/2xWKmeKDrsqViGYBlVKu+lSCTpSRJ5MvzPb5ipX
         H61TpNgUQTbfYb2eQbWSEWGHeIDttWJNEaEJ/PwcR0buC4LEUAeoAm9Kh3xJDH5Zkyfk
         WnpA==
X-Forwarded-Encrypted: i=1; AJvYcCUoiP0bC287q1bfORIL0EdJLCJKxzzMbMI4poPPgsKAX7QVVneY0T/9X62t/ZrBk/SIohKl3R+sH8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4D+87fqJZbKVGVoHDFfLOzWNPNa9iUFVs1tEvTefHvJoTwDQP
	tv6HHpATjhSZfjPIAarNGQnJlGO4e9zF0ZWnylScGet7hpVbdKfixucwlEHor30RYBvYtW1BREB
	XOBjvOrQbn+qsYHYwREkuSyYWiE7rs07vZ3eT
X-Google-Smtp-Source: AGHT+IFVLMYXDjozz3EMts1UX9Vb6aOFr9R871a4tPL9AtIGRY0LFuArOfvBuHL22PThUNhjYOA3RaMjZm6fTzoit6o=
X-Received: by 2002:a05:6402:1ed0:b0:5c9:87a3:628f with SMTP id
 4fb4d7f45d1cf-5c987a3637dmr2709862a12.10.1728979461246; Tue, 15 Oct 2024
 01:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014153808.51894-4-ignat@cloudflare.com> <20241014212956.98604-1-kuniyu@amazon.com>
In-Reply-To: <20241014212956.98604-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 10:04:10 +0200
Message-ID: <CANn89iL7tdEr6_gpQCsLncNW4d2NonTVR0pTgxY4-O556ZQiJg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/9] Bluetooth: RFCOMM: avoid leaving dangling
 sk pointer in rfcomm_sock_alloc()
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: ignat@cloudflare.com, alex.aring@gmail.com, alibuda@linux.alibaba.com, 
	davem@davemloft.net, dsahern@kernel.org, johan.hedberg@gmail.com, 
	kernel-team@cloudflare.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	miquel.raynal@bootlin.com, mkl@pengutronix.de, netdev@vger.kernel.org, 
	pabeni@redhat.com, socketcan@hartkopp.net, stefan@datenfreihafen.org, 
	willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 11:30=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Ignat Korchagin <ignat@cloudflare.com>
> Date: Mon, 14 Oct 2024 16:38:02 +0100
> > bt_sock_alloc() attaches allocated sk object to the provided sock objec=
t.
> > If rfcomm_dlc_alloc() fails, we release the sk object, but leave the
> > dangling pointer in the sock object, which may cause use-after-free.
> >
> > Fix this by swapping calls to bt_sock_alloc() and rfcomm_dlc_alloc().
> >
> > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

