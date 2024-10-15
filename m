Return-Path: <linux-can+bounces-1692-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90ED299E07D
	for <lists+linux-can@lfdr.de>; Tue, 15 Oct 2024 10:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C236C1C21A37
	for <lists+linux-can@lfdr.de>; Tue, 15 Oct 2024 08:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B80F1C302C;
	Tue, 15 Oct 2024 08:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gjeQi3FA"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7041BF804
	for <linux-can@vger.kernel.org>; Tue, 15 Oct 2024 08:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979913; cv=none; b=U8Vj5QbLxUZilxLX287dAiI1dr7b5Wr7g20PkKe0ICoKyM0tYkbSYVS/Yp/jfcT9dZRuBQTKp/wlBawhuomIDI5hHildQsbNKez7wKlWqKIGoCRdm1KPkDUJuagvoIednTdk1EPHlmxgK/BXb+wIP/5ZQZrECmhd3gJavoBWkgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979913; c=relaxed/simple;
	bh=9NcOTU6qq0FlGfURYtVioeJftguPvhg86hg1W7zVGMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQ8D6HGWbigkqqKTZmhHyoLkGs+witgTKVG4bBAhsoaZuRVZcsjieyOPw8g5UbDLsm36wyscfm3B6ClpSmue/zzGjtUvW2zPXJ7zbmGNlX7g0ldkWk+P24f2fhNWkZaKqYTQzO/XKENWrrnASX+i2vF/ZqEeuJz1Iqth4FUue4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gjeQi3FA; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso24374931fa.3
        for <linux-can@vger.kernel.org>; Tue, 15 Oct 2024 01:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728979910; x=1729584710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NcOTU6qq0FlGfURYtVioeJftguPvhg86hg1W7zVGMA=;
        b=gjeQi3FA1LPuIM9vKeLAPPz8FeCHW5chgYoutX887TPlfwBaFr6PFgE5Qh99SPunQO
         5e9noCgl4IDCfG6etdfnf1bF2tiUuiVqQr6LU9GV8uLJY3AWZBAGEqfu5ECzgtpn/idD
         YWPsSLKLMv3yVQDN9sPmrj50t/Y8RAFxZBHyX43/1sb0NdVLq5Y5YPgFmonh3usJaxGi
         ntUbcZtA7dFyqBNRT/2GWqGE1XCcxooSF6480H3b110sFgKLvviu8iAkTnwans0WM0XF
         qV++aCBee5vUGpL0NEtLmr0OTTS6IWwGx++DMe90KOoZcGgcI+/mA2CVl1iX32M5Z/5C
         NtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979910; x=1729584710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NcOTU6qq0FlGfURYtVioeJftguPvhg86hg1W7zVGMA=;
        b=m9o1uV8mIc59UhtaA1UACSCw4rAEtHEx59tVoiSJlAiglPdX+SWbBNPRbwjxXG6uBj
         GRG/cDut7Vno+xo3NZlIKq1R1g4qgtmKjtpVLyLvEcmNZ+slwodfQ+ZHIfxO1RGjZWY+
         4y0w1f4MYD7fRYlm4BjTWIhAZB2iRj0IFWEC8p06OxhD8RS95EV/+tqYGOqHNYMHJ61e
         bN4BdoZ2ANpG8lwItnSrqllScL8fT30s+AZK8SMVznprtkj2gpoNh9WskKEt+fX4G39U
         XUTnfW5iRLTjH4CiLdtO3jJxMuKbfIyVZefTX8RFuqOikoWFNoF5IEwK5VPpC/Z/CwdN
         mOYA==
X-Forwarded-Encrypted: i=1; AJvYcCV/UfMTziSnFfuI1mSBJcIndc418YDHhiCWGRKi1zzk/jlR24wOQHsDs7uapAgKLMCQFqRVbRJQ1IE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvFsi5dDd6enPTmmO5HsdIuQ5zBh3dd/z915Kcu52tnCaDuurd
	I29oP7TUMO6RL42nwfpJOVxmcl8eHKE2UUvNkMji8McW7GU7RZmeAcwQ+/7xHme7HqkvtOToJpg
	AGrL0AIIR842+SxdJLh+RbmQ2m0QtpX6d5yZg
X-Google-Smtp-Source: AGHT+IE7U1ZYMuHbOPDHIlOennm7tEkVNs4JgQdtOjRQ9FAo6Y4X7PA4zb2GEV3g2QArJvnXo+KXR6rAxY9lnX9/hZk=
X-Received: by 2002:a2e:be9c:0:b0:2fa:c5d9:105b with SMTP id
 38308e7fff4ca-2fb3f16fabcmr64166371fa.2.1728979909944; Tue, 15 Oct 2024
 01:11:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014153808.51894-8-ignat@cloudflare.com> <20241014213848.99389-1-kuniyu@amazon.com>
In-Reply-To: <20241014213848.99389-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 10:11:36 +0200
Message-ID: <CANn89iKhpjhwAqD9PXs2fw5PUDXejRz8S9VOn7Syubo1EQq9+A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 7/9] net: inet6: do not leave a dangling sk
 pointer in inet6_create()
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

On Mon, Oct 14, 2024 at 11:39=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Ignat Korchagin <ignat@cloudflare.com>
> Date: Mon, 14 Oct 2024 16:38:06 +0100
> > sock_init_data() attaches the allocated sk pointer to the provided sock
> > object. If inet6_create() fails later, the sk object is released, but t=
he
> > sock object retains the dangling sk pointer, which may cause use-after-=
free
> > later.
> >
> > Clear the sock sk pointer on error.
> >
> > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

