Return-Path: <linux-can+bounces-1691-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B98FF99E05A
	for <lists+linux-can@lfdr.de>; Tue, 15 Oct 2024 10:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75CB9282660
	for <lists+linux-can@lfdr.de>; Tue, 15 Oct 2024 08:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47D71C2439;
	Tue, 15 Oct 2024 08:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lBf8oYZV"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAAD1AE006
	for <linux-can@vger.kernel.org>; Tue, 15 Oct 2024 08:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979634; cv=none; b=kleDjBM/aiW9vpNwaVRpZRrle+K9gpFTf/+cuW316XEn15yfmqxufK5rUIk06msIbxUZTaTBmjDK1wVq1YYeCyn7QSWolrVD0O9U9vpPLHX2+hXM5BHIHA9ND1iaUFHgl8DYtJv7DjGrfVnUUx9jAmuVDo6k8s47iYYzGMxC0oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979634; c=relaxed/simple;
	bh=Zag/22vR0E5bycRbAzbqrDdRuY2hCdrXsS9fBaFEbso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hd0sMji3izUWznVinWx1NtId/4d9aRJpWCX78DsZeUJJ/gMo9gkab+hFQT/238gZbQw/n6R+2WuQ9syOFHOlJ6r9qjqpmg07QyfNlOM82CPFtFcPGCJ+FmasPr4z7BYm4QcJM+U9a463EABIv4XpSqKmFNYiVO5WrAl9WZiuR0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lBf8oYZV; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso46061811fa.0
        for <linux-can@vger.kernel.org>; Tue, 15 Oct 2024 01:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728979631; x=1729584431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zag/22vR0E5bycRbAzbqrDdRuY2hCdrXsS9fBaFEbso=;
        b=lBf8oYZVU2x0O7TH4LDNj1wIZr05Ce4aKwOyF6w/+Cr5ohBeMIWwamGc0X4xRbgmg/
         mk/AGobg+odjj24HfSyye7Lx3zhjDJGwAzlP0Rp91uE0wf9eBsEqP/yk8CBdMbxdy+lB
         gVV5CcXhjgob2PiunhlqtCh7QL1BB0cH4KPFURrF2w+7hXTk/yyIwY5mAuv2Nd0U8OKA
         yBOWXxWABeJ5eiqywg/+XbUoESRGOpx6z7nbxg8c8eVHocK3tOmVVnbFn0K6FYJEvIkL
         d/khi3pukT/hW5ZzA0X/gJLNkoTYr4aw6ubJ6MyjR7Srwu9LUnLbMhuzvGdZGei03PRU
         QAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979631; x=1729584431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zag/22vR0E5bycRbAzbqrDdRuY2hCdrXsS9fBaFEbso=;
        b=ca29INxSWOnTM2lAJ0SczDZQIvyHQAq/w3RU6ygBie8UJt4qre3+tad5eDi/EIRH0V
         9NzimkQxFJkvgcatLpd9kDEUViDpDOb6njGgPyCtRa0bqz0miHjtA67b2Vas4liM3pwW
         wpssBODzSk4qZ7Y3SzZU2ZXhMCX0bVzdJiILO/z9zSCJ2ZhNif028L3z67rrpsFGMaJm
         0+dyZkkgD/bmxNWAsL9fnoIfr+BfG15+dj848l+ASnvDiWRI1KSHmwV+h7hMW/oVEMWq
         dackrRF+e3wGjFDH8jJwTuujiI5QkGUOHEVwHWdM3+TdoThZwd16hbvlzBvojDXO2Xf2
         pMzw==
X-Forwarded-Encrypted: i=1; AJvYcCWDh1shQCS3M6RD6acoiUaYb92eggCrTxzMWEQR9gVA1CECuudfMR4GdyKJNFQ/4yAl4ZJBdE4WJeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx24vtnzRzVvy1gBgKnstfxs5/afUAx/5g9qOum6YJukRHG4ADR
	JLZZeADl8vjEeGpJ4UVbVcG/vRik/4KmMfYRtwKjJIXuF+QfGvUnV/gi2kzsGahW5QUlFC0xli9
	uNoajp1VHh5vfDRvwp8nNHv2sNrglAzmWu56B
X-Google-Smtp-Source: AGHT+IGFuuMUaSu8sjkPV5hjsvFW85eickmkDlzq49hYmSEqD3ddm2UZJ3ZSEYU/LNXlLSVoWad9QtYE4tkFfCZVVtU=
X-Received: by 2002:a2e:1309:0:b0:2f6:6074:db71 with SMTP id
 38308e7fff4ca-2fb32729553mr44948811fa.17.1728979630968; Tue, 15 Oct 2024
 01:07:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014153808.51894-10-ignat@cloudflare.com> <20241014214236.99604-1-kuniyu@amazon.com>
In-Reply-To: <20241014214236.99604-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 10:06:59 +0200
Message-ID: <CANn89iJiic+opREJ3Q1nC6orXhJkSgAtSssOJeKip4ADYEsWPw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 9/9] Revert "net: do not leave a dangling sk
 pointer, when socket creation fails"
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

On Mon, Oct 14, 2024 at 11:42=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Ignat Korchagin <ignat@cloudflare.com>
> Date: Mon, 14 Oct 2024 16:38:08 +0100
> > This reverts commit 6cd4a78d962bebbaf8beb7d2ead3f34120e3f7b2.
> >
> > inet/inet6->create() implementations have been fixed to explicitly NULL=
 the
> > allocated sk object on error.
> >
> > A warning was put in place to make sure any future changes will not lea=
ve
> > a dangling pointer in pf->create() implementations.
> >
> > So this code is now redundant.
> >
> > Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

