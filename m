Return-Path: <linux-can+bounces-5288-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C585DC215F0
	for <lists+linux-can@lfdr.de>; Thu, 30 Oct 2025 18:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A8DD3BBB47
	for <lists+linux-can@lfdr.de>; Thu, 30 Oct 2025 17:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C2A32E69C;
	Thu, 30 Oct 2025 17:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hshMB7zF"
X-Original-To: linux-can@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B39329C53
	for <linux-can@vger.kernel.org>; Thu, 30 Oct 2025 17:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843703; cv=none; b=TSmPHQ4koEfMXXHnmQ7dTlbMpMRCNkMY0h/14/0JaFHr1davRGKLVA05lS19jh+bm8CsE1lQZQPoF4QkNbsYrA/tKF8dhga4Usc93kpgBcyqP3TEsI4ylPV6MIhuf/CkkfIU3pMkcINCcoK3Z5+as+4bkfvutnOP4TL0XI5DCho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843703; c=relaxed/simple;
	bh=EMkTe5//7qv1XWV422KN8xspB0t/VQ1gSJlzCDctkaI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RVMYyW+l7Hl3fKVCADLBpgq9ca7BRjZoX4mhEJjs6gmKcX74CJ1lLlHUanO1LHhAcCxqk1lCzeIroM7ph0IGJAbJQN6f+JVb73Y+1QKqLF2IDeSQ3nO/SD6DfnEKN9xgdlQFNDvahTQu28ZcLoZDMzd2SCU5u7NzZ3Ek3U4Un/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hshMB7zF; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 891C01A177E;
	Thu, 30 Oct 2025 17:01:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5D55C60331;
	Thu, 30 Oct 2025 17:01:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0EE3511808C73;
	Thu, 30 Oct 2025 18:01:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761843676; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=EMkTe5//7qv1XWV422KN8xspB0t/VQ1gSJlzCDctkaI=;
	b=hshMB7zF+gkFqyq6bl9jykM2OeEhu6uin46xfXRg+nW6jD/EoyI86+Cevr0BlkVRA+IAPs
	r30qa5P3JR9EYdKoGgr6kayWE3GLKodepSWTzc7rENCsu4mFb9APSqieSPURvw8pS/3Wo8
	TVkZmttIn3xTa3rCBPQeDUzViFvEkCB4Iy4Gx38f5QFvqHwCgBuKR629lv0vp47gHxTPIi
	an0Ke6AB1GdPJr8RPmTshs+lVj1IXXj4VHLw6HKG3iThT2BNuVhoif8+XLMx1TUwILq+fs
	03mOMaLQre1GzwWW9H8oe5JT7O/bMS7Ta958iUDeTzqIPvQbTywUZCq7mV96vA==
Date: Thu, 30 Oct 2025 18:01:11 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
 <mailhol@kernel.org>, Stefan =?UTF-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>,
 socketcan@esd.eu, Manivannan Sadhasivam <mani@kernel.org>, Thomas Kopp
 <thomas.kopp@microchip.com>, Oliver Hartkopp <socketcan@hartkopp.net>,
 Jimmy Assarsson <extja@kvaser.com>, Axel Forsman <axfo@kvaser.com>,
 linux-can@vger.kernel.org, netdev@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Jacob Keller
 <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next 1/3] can: convert generic HW timestamp ioctl to
 ndo_hwtstamp callbacks
Message-ID: <20251030180111.0f95189c@kmaincent-XPS-13-7390>
In-Reply-To: <20251029231620.1135640-2-vadim.fedorenko@linux.dev>
References: <20251029231620.1135640-1-vadim.fedorenko@linux.dev>
	<20251029231620.1135640-2-vadim.fedorenko@linux.dev>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 29 Oct 2025 23:16:18 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> Can has generic implementation of ndo_eth_ioctl which implements only HW
> timestamping commands. Implement generic ndo_hwtstamp callbacks and use
> it in drivers instead of generic ioctl interface.
>=20
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

