Return-Path: <linux-can+bounces-1690-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F7799E054
	for <lists+linux-can@lfdr.de>; Tue, 15 Oct 2024 10:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59C11C21A90
	for <lists+linux-can@lfdr.de>; Tue, 15 Oct 2024 08:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7891B85EB;
	Tue, 15 Oct 2024 08:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lr94FdLR"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE6B1B4F0A
	for <linux-can@vger.kernel.org>; Tue, 15 Oct 2024 08:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979605; cv=none; b=nKVyfiV2DEPjotL15O0aIKUdxzRgwiKttArV48BMpw37zV++rClbIpnov0bbsgFYn9RzLlNoH5+h0U9pHMcQ/9+HOiX4YctKlvvrHjh2BJrMebtxan7vD/cqUEljTogR/YnvBN1oe//PjL0+F0m+vxF05hUMwzoMxlxKlvV1aS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979605; c=relaxed/simple;
	bh=MnUQlUTrmLKSN5pDHrMF08s+M/AmbbftkUAMLC0mhYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XMic/wTr6D944cRmvwHXc6221AAwK5DPB+msLkzjhZWu/HFksr2shhbsT9RF7BApnChShYch2AoHXDexUcezyFqDrD7blAGoUiKIZJ55sXQQE2LayuwaL++ZrfYjr8wbmhwdexZCutcFGTjHPP6gZGGyVi2pocC4ja+l7Wt7ikA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lr94FdLR; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so9655237a12.0
        for <linux-can@vger.kernel.org>; Tue, 15 Oct 2024 01:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728979602; x=1729584402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnUQlUTrmLKSN5pDHrMF08s+M/AmbbftkUAMLC0mhYI=;
        b=lr94FdLRow5MpDSV69VaIs5JmCt6yA3bF5N+2cuNzTNVxeZ5cyu9iFXK8Nuxr+0bS8
         m/rPR4N4bAYeelgljVzkabv/4WBXiEYO41dZT4lL0rSL986fAGiQ7hdx4gBY86etmC3O
         MnAVF2dAMR131qOR4+bu2E57CYPFXXTeH/Gj/n1/KjFm5eRI2SuHYPALwDHrbbxLqRxv
         zV64fsEI1GgVBIFeGqpxVGHQh5gVicixv2SoVUIxFrE6NKzTlE8ROEkWYVLqdKyVwlfL
         /XbTfKFF5GGMNKUlpUgI/0mH55vnol7kzJfxQTc9xW3qEKHaUfzotThbljaIE23TE5c5
         DKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979602; x=1729584402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MnUQlUTrmLKSN5pDHrMF08s+M/AmbbftkUAMLC0mhYI=;
        b=cRQtpdaV38hvDM8UrMFYg4Qb/rDoKuU5PiRHaZ5fFL3sjzZbzvFp6IZAESz1EgFn35
         HMRUZKD8pkqq/ABPQWPRJAvo+JsLlLdql3e74PiqQtcVHyfF2RF1KNq5GAHxGN5Zo7tD
         6dRxaL6/5R5cQo1FT29syXeefB352TAkwRsjV696OF1JZvimIvZmPu9KlkRoIcluxF4U
         Xi8wHDk5BEGP7KCYo5j0ysNLTvrK79RIl5wiu8yOzb5ZRtCOCVJ4HeEkOamPMXhtnKfz
         IuxbGYrqTn4extMHrjfvvWJVWWn9vUR23xxJLV+MZbQQ0rGYwZlJJJUye8Jl5L6lJi5p
         ML4w==
X-Forwarded-Encrypted: i=1; AJvYcCVVaVqT1qh0WU2VTwcC5K7ZMMeRU7MljRXErzLZGEUHN32Y8u5bgcnpFBw7qmBDWLnikWMzOKlPfMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhZB5g1sxbA2y4OVeK7fbIbcc/qacDms/v0+2tFpBNBP6PBCI8
	O0FzqcnlRDC/s4UasBM9VbffLf26DpItzwCfZa9qDGoYiguqiPtfjBVyVZ8axs301mhULpVb0mU
	ENb8Z1o43+YyHmd+epuUwKBo5FAZBfcd9FqrX
X-Google-Smtp-Source: AGHT+IHX6XMf3AiOgHYusjY2hNGSXpUuy0ABfjJ3dJvLGNh+47L9g5T2krprPD/SxUBg5s4JP85Vt3VKjMD2UkK3OMo=
X-Received: by 2002:a05:6402:5251:b0:5c8:9f3e:5efc with SMTP id
 4fb4d7f45d1cf-5c933544887mr15998193a12.6.1728979601480; Tue, 15 Oct 2024
 01:06:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014153808.51894-9-ignat@cloudflare.com> <20241014214046.99495-1-kuniyu@amazon.com>
In-Reply-To: <20241014214046.99495-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 10:06:30 +0200
Message-ID: <CANn89iJdmrOEYy3sH2A-1rBE8sVyDJq2yx3jVy1GmKoeqr8cTw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 8/9] net: warn, if pf->create does not clear
 sock->sk on error
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

On Mon, Oct 14, 2024 at 11:40=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Ignat Korchagin <ignat@cloudflare.com>
> Date: Mon, 14 Oct 2024 16:38:07 +0100
> > All pf->create implementations have been fixed now to clear sock->sk on
> > error, when they deallocate the allocated sk object.
> >
> > Put a warning in place to make sure we don't break this promise in the
> > future.
> >
> > Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

