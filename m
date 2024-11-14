Return-Path: <linux-can+bounces-2022-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F159C820F
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 05:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F7EC28461D
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 04:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFC8166F06;
	Thu, 14 Nov 2024 04:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="I7Ct5xV6"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF681632E7;
	Thu, 14 Nov 2024 04:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731559288; cv=none; b=KSd3BQHwQ89oO7s3satHCQZG7u0JI27K+P/bZFt9FahadCWsYGg0Llk5m+OVI3SznHCU2PN7+0EAP1D7qPIBOMCOUwC3i24q4tM3vvt//lI0Dh2Y4wm+M3WzhsM5NtxUe2o2Qs+TY0K7q00u3HsEdPLnrwV7kJwvqbw9FAnTqGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731559288; c=relaxed/simple;
	bh=jX+oHqcV9GXf5cBXur5GkiH1t0yYrzb1Qfiq7Pr6xD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQF3Ar0HTWf8AC8YDDSetfAlNP1ZqtGiItCUb8/+LnI6JzayVKEazm2yi66FSaFQbhHeYLFrFlVaZ75gPiFEJkp6Yf6hqqZviaigMNd04DSX6zyJmbQR3T/f2pu/tJ7reibcue5DYthFa1OLUY/0ekGNLPP6fPZ16JeYDGF21Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=I7Ct5xV6; arc=none smtp.client-ip=80.12.242.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ed1-f41.google.com ([209.85.208.41])
	by smtp.orange.fr with ESMTPSA
	id BRfXt2hQ5TH7uBRfXtWQQd; Thu, 14 Nov 2024 05:41:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731559283;
	bh=36eMzRhJkNGzqdLqDAJfsSRUD4cbLO0HzfYQznpBqQ0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=I7Ct5xV6J+x404uim86+fPNCftp0OK0yEYYJP0h5KQrNIyeDXIl4BQBEx0KDeLLBp
	 B+6/eEWcFy5mwgDECPdrJYjaUMUzezj2dcv0GMs4NnYJuOcIHXHLjzWKnsvuB8XGSo
	 RTpkZC09oYihgXvVajCzZiHYnP5RJhF3m5QiTjZQoJaENXRXlJ7VnBxdJSPbQl67dU
	 lOH78DbGapFVrr99Q4qDo/b+JL4v3JLQGpHzHmLz0uUOo/OhBqAi+bHMAsIOXhdEAn
	 iRqSVNX9WERBrhKa9/u+NpFM9EvlOiLGPZT/Vej0hXwsOfTXKeaEAn10YdBc/1uURd
	 CQQh2vo3wz+jA==
X-ME-Helo: mail-ed1-f41.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 14 Nov 2024 05:41:23 +0100
X-ME-IP: 209.85.208.41
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cef772621eso226136a12.3;
        Wed, 13 Nov 2024 20:41:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUWx4medF97y0lg9bGJhhtWDaYPlFDuVd9lHyhgGRxKkz2ed2MMWJflNBTnqKLNEgtQLdXrn87BpONuuSmm@vger.kernel.org, AJvYcCUyJj2Upg/z9/yyQ3x/4kOMKC6k6B7SzI3K4Yft3Oa9abMAy574uUnKyjIBTcexkAVv0hSD5dzrRx+Y@vger.kernel.org, AJvYcCVAGXzXcH7pXbHzIGJ+esa1Jjuz3s5KB+7WEXNkis+xLVcu1IEJG238frE+/oo4EJtjmymhB9lat0ku@vger.kernel.org, AJvYcCWzSWtTTUKvMDN6o2lSFmfj33+lYn9Xo3w2/DsVkxWtSo8tjfWUuzPfm8JWvzYDujJnQ0VZE8qq@vger.kernel.org
X-Gm-Message-State: AOJu0YxdyULWbcd9EKL4+Pii1qheoY+2MhgpYO0HU007Qtn28QjvxW4d
	23yzaU+0VITJmXWiSFADl5brBPKixVgsvA7XUrlTcAbZ04/JVTCKj1+RiVtPD2d51f144AeDy92
	JGZrY79jYY8TFIElXqQK70K+Lrc4=
X-Google-Smtp-Source: AGHT+IEh1S0H3lpm4/coF4vpnrnq8b7gRyqB3ly18vhAASE/ydOJVcOGKvqbPfHXkda/CpH9C5ArEdkfmLKcLjLZKZI=
X-Received: by 2002:a05:6402:5cb:b0:5c9:5665:8df5 with SMTP id
 4fb4d7f45d1cf-5cf6311114dmr4422144a12.34.1731559283068; Wed, 13 Nov 2024
 20:41:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111-tcan-wkrqv-v2-0-9763519b5252@geanix.com>
 <20241111101011.30e04701@kernel.org> <fatpdmg5k2vlwzr3nhz47esxv7nokzdebd7ziieic55o5opzt6@axccyqm6rjts>
 <20241112-hulking-smiling-pug-c6fd4d-mkl@pengutronix.de> <20241113193709.395c18b0@kernel.org>
In-Reply-To: <20241113193709.395c18b0@kernel.org>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Thu, 14 Nov 2024 13:41:12 +0900
X-Gmail-Original-Message-ID: <CAMZ6Rq+Z=UZaxbMeigWp7-=v5xgetguxOcLgsht2G56OR1jFPw@mail.gmail.com>
Message-ID: <CAMZ6Rq+Z=UZaxbMeigWp7-=v5xgetguxOcLgsht2G56OR1jFPw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] can: tcan4x5x: add option for selecting nWKRQ voltage
To: Jakub Kicinski <kuba@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Sean Nyekjaer <sean@geanix.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu. 14 Nov. 2024 at 12:37, Jakub Kicinski <kuba@kernel.org> wrote:
> My bad actually, I didn't realize we don't have an X: entries
> on net/can/ under general networking in MAINTAINERS.
>
> Would you mind if I added them?

OK for me. I guess you want to add the exclusion for both the

  CAN NETWORK DRIVERS

and the

  CAN NETWORK LAYER

entries in MAINTAINERS.


Yours sincerely,
Vincent Mailhol

