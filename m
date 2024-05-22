Return-Path: <linux-can+bounces-662-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3448CBCA6
	for <lists+linux-can@lfdr.de>; Wed, 22 May 2024 10:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AAEB282890
	for <lists+linux-can@lfdr.de>; Wed, 22 May 2024 08:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1F07E761;
	Wed, 22 May 2024 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ClT7YY9+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="mSm9zJ5k"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00FD770FB;
	Wed, 22 May 2024 08:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716365292; cv=none; b=IJ1K6+5NkY9N6erPaflo46lDhpPNMuAi/qNjzDSoWBqBBXf7soQ+8W0TQn4tdG5I/emJMYQ9rxi8JM8gptR/nIILZTuQd3MB/ptUcT26RiK3AUEIO9J3ZHN+nplt2Tv71VjFpmxBnwgNIzN3nkDUAIC/cGt8sKaBWIk7K352FqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716365292; c=relaxed/simple;
	bh=Kdse38lEoCzIDa5LclYD/dbJ1jVST51Gu79d5x8j6L8=;
	h=Subject:Date:From:To:Cc:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmfTYzBxRzAnCFuu7k1rDh0nXr9oMFc2RY/1o8dqbK0I2MxyjEVUZ8RluaM3SuP2x8YeUPh0QFl4KjNey+JvbVggjC318j/QR9W6EhQ3xgvLZ4i7oKR+MBiwWmNHVbXo+8LLzvKjo6DAoNXVuzGkMFE+r2UFO/9qT1x56OUR1po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=ClT7YY9+; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=mSm9zJ5k reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1716365288; x=1747901288;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject;
  bh=09Rm6E2T3nXPkfUBf2UBfoCcjD58pN6xKwuBm2Gg+UQ=;
  b=ClT7YY9+PpcQJOFEdOhAnluuMUrPEy/PnWkIocm6rmLF/p+fabSj68hW
   S6nSboTy/rmIZrOsXR5P/s7Q5ezdKgOvzQUwSFJrkrVN2T5ZBgn6gtV//
   WrKjt0d53IEaa0mbmnoLZt0cbTkMY8VR0ouyDG8/1tsCEghV5AYCxeDjz
   M0/A6vbJhNq176ss8MD/u0rKL7WvyynCrO2VGwKqEzKgD1wK2V5tHEKS7
   gwf16cNlQVXg3DkRWZlt2TQWgnuFTcrr2Jgly9ISM7O2X7mUyyMOcA7Ka
   85VgGWNdjJLUplz385FZTUr0QH0Fg+jCQRsHuCDWOTWHPgV0GjbYTlybQ
   w==;
X-CSE-ConnectionGUID: gFwN2NN1Qu6aWgszxRa3eQ==
X-CSE-MsgGUID: ECvYO5EFTpWPfIjRtpHF5A==
X-IronPort-AV: E=Sophos;i="6.08,179,1712613600"; 
   d="scan'208";a="37008058"
Subject: Re: Re: [PATCH v3 7/8] can: mcp251xfd: add gpio functionality
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 22 May 2024 10:08:04 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4BB97161199;
	Wed, 22 May 2024 10:07:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1716365280;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=09Rm6E2T3nXPkfUBf2UBfoCcjD58pN6xKwuBm2Gg+UQ=;
	b=mSm9zJ5kHiPXGPpCpULTKHgD7+Ji00sP0rwSz7TsJQRWfz/uBhM5BC6s7YoDElISW6ONHo
	VljszIj7NUpTDWFNV1fEuuCAPvh/2KsOMOXY5OVh5t/GaPXkeVmtmBh7H0MHJeav51JW7H
	HN4JRTZcBab8aQ3mvsaLzuPx6yEGx1j7tcRGri7RUZyOflbBq2t3PiThpXW6D35dub/62c
	BT1ykPaIPSddqJsdzGVSEm80jcvStsKl1jdI8PovuAJn/cEpx7UF4vaDTmcEu7jm6NmS2p
	940v2Pn8MrsM5vsbQkl5cnjUwNmm+giNBMOT/e7TsGkOJJNYRmBScroiyOcv5A==
Date: Wed, 22 May 2024 10:07:52 +0200
From: Gregor Herburger <gregor.herburger@ew.tq-group.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Thomas Kopp <thomas.kopp@microchip.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux@ew.tq-group.com
Message-ID: <Zk2n2JEzqbBkn9/7@herburgerg-w2>
References: <20240521-mcp251xfd-gpio-feature-v3-0-7f829fefefc2@ew.tq-group.com>
 <20240521-mcp251xfd-gpio-feature-v3-7-7f829fefefc2@ew.tq-group.com>
 <e24b16a1-2a69-4aea-9ad0-135ed0a87547@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e24b16a1-2a69-4aea-9ad0-135ed0a87547@lunn.ch>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, May 21, 2024 at 10:37:33PM +0200, Andrew Lunn wrote:
> On Tue, May 21, 2024 at 03:04:57PM +0200, Gregor Herburger wrote:
> > The mcp251xfd devices allow two pins to be configured as gpio. Add this
> > functionality to driver.
> 
> I have a basic understanding of GPIO drivers, which is probably more
> than average for netdev reviewers. This code looks O.K. to me, but i
> would prefer you run it by the GPIO maintainers, since that is there
> domain of expertise. I don't think any are in Cc:
Hi Andrew,

ok i will resend with the GPIO maintainers in Cc.

Best regards
Gregor
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

