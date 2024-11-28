Return-Path: <linux-can+bounces-2249-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2926B9DB347
	for <lists+linux-can@lfdr.de>; Thu, 28 Nov 2024 08:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08132822A8
	for <lists+linux-can@lfdr.de>; Thu, 28 Nov 2024 07:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6531482E1;
	Thu, 28 Nov 2024 07:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Q3W2ovsL"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A233E83CC1;
	Thu, 28 Nov 2024 07:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732780157; cv=none; b=LKFlYcV0wlJ0LtuVRJw9g6jLs0lhjM5lVQA5bZBYfXBnS2Rfcl9LZqMDjYFcjfTgWojljT0CE1h7E7GeMHT2nmccOxEDohWnEDzUjE3bAaoIaGhI7Jy8K16opJwtwkmcMmxEAx/GXM75zCt3pJRs2db+mBc7ltgbcIDOkZiRWHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732780157; c=relaxed/simple;
	bh=+bd4a6+DFOFBrXLdrpOplG5RWtrPBzZ3NIgdLmxBxes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBAQICSABOmVO6xbSATFOZoVXTPaV8cLGwpgSZYz+R135vbG0V6lotIeFuhZdt7Rxl2O4rNwI8fHMMNfLgkZJuZ4OMe7m3b6MdRXY5SMTLX1ee1b4WDV+J7S3CPpLwW4Jlt2FxXmTLz7YZVso+qyfBelY2WMOHOA2KMm5UKfNsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Q3W2ovsL; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=jiEMyZmfgC3XbNOpoOlbsaA8s2QGOtBmPZHHCtVcqL8=; b=Q3W2ov
	sLR6FSoLWwvJKikGHsN6adAMpfoU0OmkWOPxKPDviKt8aAiAMVRYZiucLAaetU9S6YJ0ghUQCGbYQ
	iKSHoXgVd9PZjebZ2PHhVmqOJe/kFKCWdTHtPGnN0Ov2zrsvYCwavrJFhEOgeLVRg9cESZoFxM2Dc
	Iul5+WqVYnAD5wxbNUDziZDk9Xr1Ev0o6Rbqzh2RuB8tsBQh/r5iFRuKF4Q/w/lX2MJI2TSVGPD+T
	uNgFWGfWHTFWgFe3yUjOwnbdgQBOFighR7Oai5pHU76l7JzZ5U3upvEOt/vMrewi0+G1+oRSsECRN
	VbtxjsJ7mpVvzU0L3tEpa7YnSw6Q==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tGZGz-0008zW-B6; Thu, 28 Nov 2024 08:49:13 +0100
Received: from [185.17.218.86] (helo=Seans-MacBook-Pro.local)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tGZGx-000Btb-2y;
	Thu, 28 Nov 2024 08:49:12 +0100
Date: Thu, 28 Nov 2024 08:49:11 +0100
From: Sean Nyekjaer <sean@geanix.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH can-next v2] dt-bindings: can: tcan4x5x: add missing
 required clock-names
Message-ID: <tmu6inhqzkecgdrnv3yip6fjoelcyby5b7ascby54afcn5iune@jd4lk4p5kplt>
References: <20241128-tcancclk-v2-1-fbf07f1f1626@geanix.com>
 <87378b2f-80a0-4a35-9989-9b96910701e3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87378b2f-80a0-4a35-9989-9b96910701e3@kernel.org>
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27470/Wed Nov 27 10:59:44 2024)

Hi Krzysztof,

On Thu, Nov 28, 2024 at 08:31:41AM +0100, Krzysztof Kozlowski wrote:
> On 28/11/2024 08:09, Sean Nyekjaer wrote:
> > tcan4x5x requires an external clock called cclk, add it here.
> 
> Nothing improved. Device already has this clock, so your rationale is
> not correct.

Please explain, yes the device has this clock, but not the name. The
driver depends on the name.

> 
> Also, offending patch is not in the next for some reason, so it should
> be squashed there. Conversion which leads to incorrect binding is not a
> correct conversion.

"offending patch":
https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/commit/?h=testing&id=77400284f54b9a1f6b6127c08cb935fc05e5c3d2

"dt-bindings: can: convert tcan4x5x.txt to DT schema" did the
conversion no more or less.
The original txt file fails to mention the clock required,
therefore IMHO this patch should be as a seperate patch :)

/Sean

