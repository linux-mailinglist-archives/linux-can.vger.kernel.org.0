Return-Path: <linux-can+bounces-1611-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EA8994243
	for <lists+linux-can@lfdr.de>; Tue,  8 Oct 2024 10:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF1B290E07
	for <lists+linux-can@lfdr.de>; Tue,  8 Oct 2024 08:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA7B1F4FC5;
	Tue,  8 Oct 2024 08:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oARTCco1"
X-Original-To: linux-can@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBC71DACBE;
	Tue,  8 Oct 2024 08:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728375160; cv=none; b=lIDGfUEP7nwwDMuzdLL4dyX4uNq7Osp+MmHvsp/77bYcoLMHHsOzHrr6H2ZUUzoiWHq/81PtRJcAI8KkqtKSmhYwmSsZbPZbPhs8fthPIkG1Y6WAKqzgOl5JaucG0F3mc2t/zHrdGEzIriW4MHXa1Va9EQpIwqkNNR531m6TP08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728375160; c=relaxed/simple;
	bh=B3ysfxiqFRhVVNCstervNndWXGwXlQgXohHe/DyQ+g8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=titD5ljhx8i8PVLRQCjg/YUVG+IYadTXPd4RYgQpLMrtCoYg/0CgdIFcPC3B0ct4S+2PCG0nOT33gydu1YZgxe4EWw4bPpJm1DlM2n3elgHdegmz8LniextXNY9fQlyGmTe/Im3jZEIw3zF5uccG07nEO3ajl88pAuGR90CZy5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oARTCco1; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 56F2F40005;
	Tue,  8 Oct 2024 08:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728375155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WxOr0+Orzjei2/3t3Lr8z6xjWY7VkO+u4ngNgmdCxmk=;
	b=oARTCco1tu8VcZP2stCjjo6TSwMv7A8HWGKO2gATZmkeIp75C/KpMPHPZuFEIlq9DB7Cj1
	9uDVKYJD2XG3ktFd7MsS0R2dbXBBxbf6TJT8mRWgw0zZyE433PQ7CDYTYu7kplprzkYbdZ
	69ifxQMzF/M4jj6qbxv0Ta4vJkn2Jp3eYwWhjbKtroaob067OblmAa86jwxZ9JqgaKi0Xn
	0bXqR4Tz2REqsdWUP7VfsSD6aQGAMC9bz2qjMRs6KYN92luQEu64YE/UWjQ7nyaag/38Ct
	AkKFICym00WreIWFMgqqtSEfi42XGF/VCdxYh+ooK58fW5LNvERbf1ctEmstQQ==
Date: Tue, 8 Oct 2024 10:12:32 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
 <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Alexander Aring <alex.aring@gmail.com>, Stefan
 Schmidt <stefan@datenfreihafen.org>, David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org,
 linux-wpan@vger.kernel.org, kernel-team@cloudflare.com, kuniyu@amazon.com,
 alibuda@linux.alibaba.com
Subject: Re: [PATCH v2 6/8] net: ieee802154: do not leave a dangling sk
 pointer in ieee802154_create()
Message-ID: <20241008101232.123389e1@xps-13>
In-Reply-To: <20241007213502.28183-7-ignat@cloudflare.com>
References: <20241007213502.28183-1-ignat@cloudflare.com>
	<20241007213502.28183-7-ignat@cloudflare.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Ignat,

ignat@cloudflare.com wrote on Mon,  7 Oct 2024 22:35:00 +0100:

> sock_init_data() attaches the allocated sk object to the provided sock
> object. If ieee802154_create() fails later, the allocated sk object is
> freed, but the dangling pointer remains in the provided sock object, which
> may allow use-after-free.
>=20
> Clear the sk pointer in the sock object on error.
>=20
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

