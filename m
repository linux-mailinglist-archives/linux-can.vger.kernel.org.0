Return-Path: <linux-can+bounces-5948-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49520CE6948
	for <lists+linux-can@lfdr.de>; Mon, 29 Dec 2025 12:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEDF8300ACEE
	for <lists+linux-can@lfdr.de>; Mon, 29 Dec 2025 11:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CAB30C62E;
	Mon, 29 Dec 2025 11:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWCpoTWb"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EED30C363
	for <linux-can@vger.kernel.org>; Mon, 29 Dec 2025 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767008591; cv=none; b=Fno1erGFVo+3tDq4W+obfLtYSez4fbWhVrTh6ecTKo3ybxn72yDxuz/u/lS1QkKJuQ7ascl9nMaoTFFFCOEDaJ2eH8Qj+/2GHssTj93aA1NLBg0N1Hcs8SCRcLT6DnZhZMF6ncObeGtBHY0/2XuID97NQ+k0q+cUsXdQaATw/ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767008591; c=relaxed/simple;
	bh=eB3XsZRjJ1YFGjnvrsqrBm1/10oeK+YwC4DIQNxLcCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PiBInaN7sQCfz7dTuVJ3bJHFmEcZrxKVLSPy2RATB09IkJHql3Pii+2DnH9I1czuUSHAeUofy1+hyL8a6v0Z+R+AYE5+Jyh1ONGJKq+rjyOrJcmfU8bLMURY+P6t1j2X2hpDKXXjYzhmwU1ziQ8Hz9ks4K/nAtZ2edsWaiKw5Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWCpoTWb; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so4458657f8f.0
        for <linux-can@vger.kernel.org>; Mon, 29 Dec 2025 03:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767008587; x=1767613387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eB3XsZRjJ1YFGjnvrsqrBm1/10oeK+YwC4DIQNxLcCs=;
        b=YWCpoTWbjQNXHJtkkb4+FR+bpQ4qxPiECNSByzCf7V+UE6kEFumH+a0Iyw/jn3JbvK
         scP9MyxHRlwxhI1/0cdg+TDZO7+KRFIi/bSgXIeszh9tyt+J2433NVsOG0SJf60NJAG4
         WpkaN6cLlDnvcSO0NBX6Z+lDG7zWva3St34uLwHo88zxZWOQ8/nVhs33chCQ7guCi9zg
         eddwCn3W8YO8tpioL1p1HNz6jEEEu4QDdFzAi5Ssgd50O/JSXtgDYcgkTu8ZcaF9u/rO
         be4KIc+tz2ALFpB3K3A6/8nDoM2zVbDNQw+JpO0fmQeMg2I3zVDT2M4qhCSH8XCE0I6M
         gOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767008587; x=1767613387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eB3XsZRjJ1YFGjnvrsqrBm1/10oeK+YwC4DIQNxLcCs=;
        b=FzrM+LinTCs8QTddzsfJWLaZ/Cyn+QQ3V59I6E40M8O7P4Lnu6/JYg8JkP2UlppnwU
         AFNtJsfANAX194/Pe7dLzaY1c0jctRNUubtBv+m0beHx6Id8K8i99rVSJ7J0uNHjtlaW
         5cb8fps5AsA6GWsKK1tz0sguRuj8IiP5ONHRQ6kOM+EH8ob1pB/7cfT6Mc5NrgKjWc7B
         xNS6Lo6VS2fKyNFcSjsM5cnkL4PrOqFD6U0TsKPpPSr2DRj5cm+Ml4L9ymFfiQ9urW/i
         6HwXIHBQaFdZEdealP3lOe7f9FcQstuydRv10ShNyvz8ZiLM2jdxjxsx2P195IAhDrnu
         DNSA==
X-Forwarded-Encrypted: i=1; AJvYcCUzSOPgGb7QGbK0PZUVE/nx33e2q+o19O+ISoQsEfOTMlnA7+PF9I+UeKNGl1Oj8cpgV/lkCAYWLJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMuvMyJt53blpPg7FgmGnmV6EBSpA8VXXYdspqUax5EhUAM0gc
	FLjFXg4kKoj4AYxDWVWeoO9N/epWccxkWaKRhz5JmiHL0qvMmR+EpuRTHcPqmMXhmop2Hju5O5/
	Ke3LbrDhRDMvOv9fXxhc1jAae/BlykUg=
X-Gm-Gg: AY/fxX6mepvNef0iLvmaKZDeBmTv7MBXAjP4IqwFQdhnneT3KZHjd/yixLZUlCmilPX
	GDwqtVa+ZRnbmr+GPCCQoC2dnMAdwCGcbBnfsby38KWnlamcbXPztNHLfHTqnXZB0sbVP4QugOZ
	5ifr0I/VgVMlvJFJ+BX2GpUMfcEQt3757ShKZKih8ZBGgY/iceIwj6XYAfKIvgXTbxj82NQBY/L
	mtak6bgrwzr0nGQOM6G3V56f+RHX0g7Fsc7ZCjewaIvoE1ENuSsQfRFBvxW7Du1AV0jVNg8IsDG
	MNScbXMuvydQHQOf/CrWEw4Vu67w6oMaz7PQ0jhy2TbmWYhjyQqb0pj2y/7ExrN8WZid9tijufe
	2YXbK2Vbjrsf7VQ==
X-Google-Smtp-Source: AGHT+IGBZW6yTetvwnfGicrHJgS8HgNiMNHTIySH+8wEUsN70PrQ6mV0WydgwJ78qbVIDZx67ELX/OVuFUTj4cYkPUE=
X-Received: by 2002:a5d:4e01:0:b0:432:5ce4:6fed with SMTP id
 ffacd0b85a97d-4325ce47133mr21404075f8f.9.1767008586940; Mon, 29 Dec 2025
 03:43:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224173324.3393675-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251224173324.3393675-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251227-tacky-cordial-ostrich-263625@quoll>
In-Reply-To: <20251227-tacky-cordial-ostrich-263625@quoll>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 29 Dec 2025 11:42:41 +0000
X-Gm-Features: AQt7F2oSeBaKR2srEY0LF2FWkPeA63InFdu1sEluQEP7fjKOHxwpFhKhpOiS8To
Message-ID: <CA+V-a8vh5gEfozFzym_J+aE1zDXXVbQwq8OWpr2F6rxLZaWKYw@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: can: renesas,rcar-canfd: Specify reset-names
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Thank you for the review.

On Sat, Dec 27, 2025 at 1:11=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Wed, Dec 24, 2025 at 05:33:21PM +0000, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Specify the expected reset-names for the Renesas CAN-FD controller on
> > RZ/G2L and RZ/G3E SoCs.
>
> Instead this all mess should be fixed - you need to define all
> properties in top-level and only override them with specific constraints
> per variant.
>
Ok, I will define the reset-names in the top level and adjust accordingly.

Cheers,
Prabhakar

