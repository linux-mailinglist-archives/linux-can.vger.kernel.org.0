Return-Path: <linux-can+bounces-2481-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C569FA158
	for <lists+linux-can@lfdr.de>; Sat, 21 Dec 2024 16:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86693188A3BD
	for <lists+linux-can@lfdr.de>; Sat, 21 Dec 2024 15:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852501FBC9B;
	Sat, 21 Dec 2024 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aFpbNEI1"
X-Original-To: linux-can@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08241FA8D5;
	Sat, 21 Dec 2024 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734794427; cv=none; b=a3yV4qJUJ/G1P1KL2FpuwCnHdbhz3Eo2dhifKurFAh+tzmX7EXqeG639WR2SyTqpdktDMDuPLlhlFixVdRArVZ3PnXiupLurdxPjMJBM1thuLMI1L55UD7OpiEFR4vsQeMxTmvRIvDNfk/HVO0C1bsskb3PaO7lpvz/not9rVUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734794427; c=relaxed/simple;
	bh=ToF83HTtIoCOY6Pzw0wkEU932KTbSJwaJAD0tP/HMTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dX6uuA0uWmTirHkPweqTG4C4MYUuYCt/gtHYnsAiPkhx5OPrWiEAPGyjElRE4VnArO4SWO3sNJpT2qlfIdT498ytwyYtsFH3qwH4+r3hFJ9mnpS1fGpEnuotG0KZE6OCtVSaLgeMUoGtR5DlVbjGc8QikqpWCHXnFIJtoQzQrcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aFpbNEI1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Y+VeAO0oP+O1L8B/kvL6ul7+XIrk/anwCV8p7KFq03c=; b=aFpbNEI1ukK/S65RUV3T5ehfq6
	dwgTfPdumYfZF90KaThs0knUP9esRd3gygDoUFEAgSHuD/48yRBbIOL8DitbFP5maXyBv5iLJED38
	iyf+oJO8Lq2d/8erSpWJJVIHOJMnI0gIy9K/lo6oBSLFP510+6rwPYpWJbJgUYZZJ8tU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tP1HC-002KS4-VW; Sat, 21 Dec 2024 16:20:22 +0100
Date: Sat, 21 Dec 2024 16:20:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
Cc: linux-media@vger.kernel.org, linux-mips@vger.kernel.org,
	netdev@vger.kernel.org, linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH 3/3] net/can/dev: Remove dead code
Message-ID: <51551c6b-edf1-4c95-82b4-0158864c5d64@lunn.ch>
References: <20241221035352.1020228-1-ariel.otilibili-anieli@eurecom.fr>
 <20241221035352.1020228-4-ariel.otilibili-anieli@eurecom.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241221035352.1020228-4-ariel.otilibili-anieli@eurecom.fr>

On Sat, Dec 21, 2024 at 04:44:17AM +0100, Ariel Otilibili wrote:
> The default switch case ends with a return; meaning this return is never reached.

Not quite correct. It is the fact that all the case statement,
including the default, make a return, which makes this last return
unreachable.

    Andrew

---
pw-bot: cr

