Return-Path: <linux-can+bounces-1689-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5274499E04F
	for <lists+linux-can@lfdr.de>; Tue, 15 Oct 2024 10:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F16D91F21BFF
	for <lists+linux-can@lfdr.de>; Tue, 15 Oct 2024 08:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BD33A1B6;
	Tue, 15 Oct 2024 08:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uIy00g5u"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EAF1AC450
	for <linux-can@vger.kernel.org>; Tue, 15 Oct 2024 08:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979559; cv=none; b=NHc/h2YxUMPTkBHPFd4SSgSZe6h84T66gL50fBrQCOM2JUIuK/7bhtJ6ZfpyFNUwHZ5HuqUP7Mm5xCsU1nV4Qw0zZRKsA0j9e/3Pe9nsh8ri56/Ejb89KGLBLew0ZuIRwx3J1z2tPUFf99oIoaRqAvE5Jr0Ir7NzR+y49WwRdoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979559; c=relaxed/simple;
	bh=Hf5sbom+1tJSI+T1tEa2calPUSzRvUp/AGZZU7Rgx/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZfWu1k24BtNHxRIi710yvdhhpSox9dOyOU5OkkofDXROC0B9d5cNmSx62qjHL1bmZbFHguityKoWwiq/OlN/l06wRQ6I5q+ZmCGYHvA/HXZWdnzXFl7EjNNWkg0hJL+wrGNkE4Yc1RMBx5qmPUIFniTwI6HUDlOaD2rSYqQG3yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uIy00g5u; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c42f406e29so6720170a12.2
        for <linux-can@vger.kernel.org>; Tue, 15 Oct 2024 01:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728979556; x=1729584356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hf5sbom+1tJSI+T1tEa2calPUSzRvUp/AGZZU7Rgx/4=;
        b=uIy00g5uc5/MNXBoMMXjv/FkTQ1e2ymwkzCw8jBH62o4ZHiIODDL+m6fGgbnWboRLB
         jxX6arD5E7wtF4tCumoAth6sQ85E8Gqna2bh71o23NDFzITPk7/P1MXWYYCY5ypkMBuB
         A0XfS4mObQ1jxr6aX0dCL3HkR6vx44zSut4FqLYFAqx9IU9nvLNjhjoS4IMAvp9P/UXx
         Ewt8HiLpOlUwz4bJ26VmBxRSeox6KxaC22AHY3Z249mGHo3e7MbPZfAKICQ7ZeFPJQPk
         wr5j+wbfWp89DquCFjB/z6CHFiIAYlTt8clpVCFq6yEY4Bf83H+y1OtpMGVC4L60arSS
         z4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979556; x=1729584356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hf5sbom+1tJSI+T1tEa2calPUSzRvUp/AGZZU7Rgx/4=;
        b=TjZ2Do5wlFmcvuEU2V0m81TuhSfHXPTfGvsIxTOYUuF56Djvj3QZaXxadZfjDJNFc6
         LrqZdAAVToRK0eshvOOvYMdhUlEmaAG3GWkohCWas9AkatZ5OhSezjC4aakoJGQ7/rGM
         yIZzK7/c+NGr3Eftm+rLvPKyWY2sjSBaZYcDrsRjznKbbM4M4ZwFYZ1aRcaIa4HuY6Uf
         BryURsdUQ6gNPitGcyR6LU98v4LgjreOk/YMRlloCK2BR2U3mSkbnGGjn62HE9AiS/iE
         R1/NwnXrwIA0ygg12m7bH0LgXxR7V0ht5MkWCmrU6Wq4IB0cxcDE6gqV6XbUMvKN1cmv
         UccA==
X-Forwarded-Encrypted: i=1; AJvYcCXXfUKHmaOIt2zDjuz/7c9LzuaHfCRTQUi7yxFVEDX9BU9HQbvBlUbC4fzSTj2CS8It0i0laNOvfI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrUeXF5NtTmqnCbFwul2/QIjRU3+nt0VuaKhKbU3EtaU8ZiTbb
	f26f4IL7zf2UJsSSlWs0f2PHTfY5qIOAfabMm1N3c1QlmWksw65iFJhAmlADE5EOmtJif+jrtvv
	SkwwFQkhxM29sVn7//KvXkw7cVz+izBF8GYkO
X-Google-Smtp-Source: AGHT+IF0xxh48FLIEsnDmDAKak+sCF3RjcMU7ZWLhjOUWb3x23/TajMFkARYnF26YLJz7ZmTIiE7WFXReASZlV8NFgM=
X-Received: by 2002:a05:6402:2690:b0:5c8:9f3d:391b with SMTP id
 4fb4d7f45d1cf-5c948d4faa2mr11526448a12.28.1728979556044; Tue, 15 Oct 2024
 01:05:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014153808.51894-7-ignat@cloudflare.com> <20241014213705.99272-1-kuniyu@amazon.com>
In-Reply-To: <20241014213705.99272-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 10:05:44 +0200
Message-ID: <CANn89iLMgdebS-EZHo4mcQtgrG1AmvK7xKTmPL4PNEmK1PzDVA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 6/9] net: inet: do not leave a dangling sk
 pointer in inet_create()
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

On Mon, Oct 14, 2024 at 11:37=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Ignat Korchagin <ignat@cloudflare.com>
> Date: Mon, 14 Oct 2024 16:38:05 +0100
> > sock_init_data() attaches the allocated sk object to the provided sock
> > object. If inet_create() fails later, the sk object is freed, but the
> > sock object retains the dangling pointer, which may create use-after-fr=
ee
> > later.
> >
> > Clear the sk pointer in the sock object on error.
> >
> > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

