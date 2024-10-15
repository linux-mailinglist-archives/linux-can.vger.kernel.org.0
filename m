Return-Path: <linux-can+bounces-1686-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA1399E035
	for <lists+linux-can@lfdr.de>; Tue, 15 Oct 2024 10:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACB461C21C74
	for <lists+linux-can@lfdr.de>; Tue, 15 Oct 2024 08:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4387E1AB512;
	Tue, 15 Oct 2024 08:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rgwLWW8o"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6E71714C4
	for <linux-can@vger.kernel.org>; Tue, 15 Oct 2024 08:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979425; cv=none; b=mDApHPS70Lv8LEbmhiKyDMqJIBXkZIwdWkMSBPCfYibZnnE4AlCyt0aLRHLUCTfl9p4kznq5T4Xr3uV+Ez5RzpFbtMkxr3PQ5KFs9SJ/vVnWA5LYu8TlRaXIcTRn7gjNCruTRiTq2fD61p5vCuSN9wSJxunZcCEbbrVazyO331o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979425; c=relaxed/simple;
	bh=NHIMEX9Rn0CtXiXdTCgdeC8hYKUgOcNh17M5gRhUhQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=psBrwrxc8ZFoezkrx+7DOey4oX0dLfQCZIG4gAd6MgSVOBokt7mLGBzRGhwPooAywXOaG6MIF8tGI+7IaXF/5dF5B3RhG+X4P3Y8ZF/tvQrNXsKGHkeopzK7k2MDn5aHoGFzK+uASeyOI4SW8VQZEtAAvCQNwWmXnvJTvcJY5to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rgwLWW8o; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c9362c26d8so8610445a12.1
        for <linux-can@vger.kernel.org>; Tue, 15 Oct 2024 01:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728979422; x=1729584222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHIMEX9Rn0CtXiXdTCgdeC8hYKUgOcNh17M5gRhUhQw=;
        b=rgwLWW8obX5/D8ekbqmJw1RM5yc9mvlc/1EyxnFFQ6VgXEKacO/VQ54EHr2jcyYGPg
         jhTO04zx8dgl6R35At0FQL42YsFhXLg3DPMhsXvvPw5L8jyD5qaB66Vo0LOzc8MwX838
         VSZjf5K21HGquS5YFsD1eumsRNGkBlE3Fmi9fyDx3+E8oyXV83YH06d/6YOOCdpAKBoH
         YLxW5uyO+hyRMi1r+XhRkzUL2mpaHy+8CcsxSFYSm+J2s/rzBx/6Wf4LfjfP0pMAKXnm
         xnJXSU9bmo8tcskXajmmEiSh7IJzMCbCq+cW1SFrTRn/6yjPZK+y/MD2kFvCR1Dhqm4e
         aSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979422; x=1729584222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHIMEX9Rn0CtXiXdTCgdeC8hYKUgOcNh17M5gRhUhQw=;
        b=vpQ4YhGt21NkwQ9LjoqbCgsV3aYd9snUkbZvyDgRGQ3r8mghV85sETJLIvziUhkWF9
         bkCk2V4+XaA7fLS2S7nM5xcYwrzXhBDP4w6f2yeIQnnigAcgOL8Fe4yPwB52ofvBBIBw
         qHJTnoLPLWEEOreZe7qJU3MZpnKKaQhVgqvS11+OrjO9yoTINidpbAyeawDER8+q3z0d
         qjHRBH3lEgVaeVcaKKwqLKz9yWGlkZvsaG0KUz+6GF1FR5cZECsTwjwBCR3gzR/3FOyT
         uRo7MdN9lqgx32TPdwjn5YSCtWk3xWUg/eMGfoEziwxuIrLWQeAoRWHP1ugDueppxfxx
         oSGA==
X-Forwarded-Encrypted: i=1; AJvYcCXmsj0A4pXcNZXoyTmWqTGnYnKeoIsB8HzMQ2/paP6p86J/6B/SuFC+Fj0u9ZHCCxGMjk7hipMZJIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLbOJyaDhoHhx7bsAnG97mtVlr0XwxW0sYvlyoqmulr6rpLPJh
	ZM5x8rXchBXvte8JOGExWjuYEuLpO8vX9D1g2yH9TcmDjHXYpr2qer7QoiDC0jZ1p3E1aJMkOf/
	ffLtDI8JYaA27pyeDb9JI+4WOaOBVLcHlXNgu
X-Google-Smtp-Source: AGHT+IGGpQl9m9/E1Fr7ZcAYtpdIcEgx/5d5LfRRQXmGVyQQGHN+I462L/CQw6mm0GwAP8S57x1YRqDAEYORq7y/6H0=
X-Received: by 2002:a05:6402:2688:b0:5c8:88f2:adf6 with SMTP id
 4fb4d7f45d1cf-5c94754c124mr13143943a12.13.1728979421740; Tue, 15 Oct 2024
 01:03:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014153808.51894-3-ignat@cloudflare.com> <20241014212328.97507-1-kuniyu@amazon.com>
In-Reply-To: <20241014212328.97507-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 10:03:30 +0200
Message-ID: <CANn89iLSebTHBz5k8GTS8+qMEn-tv66xanzypBbQBsxtDs69yQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/9] Bluetooth: L2CAP: do not leave dangling
 sk pointer on error in l2cap_sock_create()
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

On Mon, Oct 14, 2024 at 11:23=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Ignat Korchagin <ignat@cloudflare.com>
> Date: Mon, 14 Oct 2024 16:38:01 +0100
> > bt_sock_alloc() allocates the sk object and attaches it to the provided
> > sock object. On error l2cap_sock_alloc() frees the sk object, but the
> > dangling pointer is still attached to the sock object, which may create
> > use-after-free in other code.
> >
> > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>
> Checked all bt_sock_alloc() paths and confirmed only rfcomm and l2cap
> need changes.

Reviewed-by: Eric Dumazet <edumazet@google.com>

