Return-Path: <linux-can+bounces-661-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FF88CB4C2
	for <lists+linux-can@lfdr.de>; Tue, 21 May 2024 22:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4413B1F22A57
	for <lists+linux-can@lfdr.de>; Tue, 21 May 2024 20:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982D21487CE;
	Tue, 21 May 2024 20:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bk0XI5tv"
X-Original-To: linux-can@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA248208D0;
	Tue, 21 May 2024 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716323868; cv=none; b=e8tXNBvi6rKRTHIZfp4aYZibK6PJW/dGJhGCqj8kJKurqY29pHaL0hsJbqdw3SJML2X7UopvNoUD38UzabmOWRy6M3SFX97Ov2n/6ukK2pxCN3l+I1XH1npNTxyIZPc10I+MjtD4u/5NVF/afe/RaFrSXaX2BtPUbI13cB1O1n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716323868; c=relaxed/simple;
	bh=B9ViOYqXgDpQjV19AK5VUQQ4TV/W0LZcZ1p/e/v3QyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTZqcmQBJ1+fXpZRHge+3YXpSDZGCQ6l6pt7p/QyVV0o2Pgp9/FeM7Z5bSTVdqNjIWI2E4uUy2BZ4fUOPcel6ZlmKQO2sKebjvALzN2WbUcs1H0yGsEHWNqTiMqiwzv1m+hW+U6aspEjQ5nxBXZ16Otq9B9BQM5mV/aW/aswjPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bk0XI5tv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9NLbNUDlzC2jcO08AefJjvDOuFA0wNb9S8kYwaE3wt4=; b=bk0XI5tv5egsQIv1BwYpYtr4T4
	62h+8SAf9m3BGEYEmvolS+Ux2TyeGE7hvRr8FslC7hEgdYQkkmzsWGi6JPeEI6OjFd5MZxwfuqg2r
	75fvqdxUc765PwSoAXJ2yZ+0OALvTGlPTz+0J5/mw0uX/e7C954wnI9xFM2YlUFhBW4s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s9WEn-00Fmf6-2T; Tue, 21 May 2024 22:37:33 +0200
Date: Tue, 21 May 2024 22:37:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Gregor Herburger <gregor.herburger@ew.tq-group.com>
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
Subject: Re: [PATCH v3 7/8] can: mcp251xfd: add gpio functionality
Message-ID: <e24b16a1-2a69-4aea-9ad0-135ed0a87547@lunn.ch>
References: <20240521-mcp251xfd-gpio-feature-v3-0-7f829fefefc2@ew.tq-group.com>
 <20240521-mcp251xfd-gpio-feature-v3-7-7f829fefefc2@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521-mcp251xfd-gpio-feature-v3-7-7f829fefefc2@ew.tq-group.com>

On Tue, May 21, 2024 at 03:04:57PM +0200, Gregor Herburger wrote:
> The mcp251xfd devices allow two pins to be configured as gpio. Add this
> functionality to driver.

I have a basic understanding of GPIO drivers, which is probably more
than average for netdev reviewers. This code looks O.K. to me, but i
would prefer you run it by the GPIO maintainers, since that is there
domain of expertise. I don't think any are in Cc:

    Andrew

---
pw-bot: cr

