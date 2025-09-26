Return-Path: <linux-can+bounces-5042-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78768BA4FE8
	for <lists+linux-can@lfdr.de>; Fri, 26 Sep 2025 21:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3A561BC1FF6
	for <lists+linux-can@lfdr.de>; Fri, 26 Sep 2025 19:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B243281526;
	Fri, 26 Sep 2025 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rD7nM/QC"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5314524466D;
	Fri, 26 Sep 2025 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758916229; cv=none; b=C4gA/XznQlLswKptuLIxsLy9iwPjL3bM1nS+nUBDxzIjer5zM4GrnFULRkpxPNB2H5oyTL2IYHmrQGNAOk4SO2DQzWD/cqaKdrmT3oKtfOtN0Tcx0w9YIrEeLEunCTCKPb4m2Zb6eeAXBO4mkZ8rQ07Hgz/Os/JOADrKleRy4fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758916229; c=relaxed/simple;
	bh=csiw64xW5C/E0DsaKqaPn9Wcwx1x0AGhHWipkJtCBh4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nQMvGK1N3Ry9eqAt2Ws23bUgnztUYY9ZJIKJ8+QcijN3NVNqJGEvd4JRS72v3nZtkeFC8+OF6zuB48Mhm/t+jWSVL+EXKo0Zd2M+10k0hlyGL4JPuz3PDmPMs5NLbU27gJVeX5WkGhJySFM+ww8naEsvpGDlZT0lYRtkYkkQyAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rD7nM/QC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552E3C4CEF7;
	Fri, 26 Sep 2025 19:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758916227;
	bh=csiw64xW5C/E0DsaKqaPn9Wcwx1x0AGhHWipkJtCBh4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rD7nM/QCLF8emzEr/lwemdx1flawp54YZWsVaxxInyfBlKXzn/poCIbHuSo7E7tEo
	 nIW6ugz2T5cGnzfAdFE/ZeinBv4GXMB7jIMmcvwEHoY/JkZuAVfft4dnFLfXBIlU1b
	 G3zgNF5DIkD2JD7t6nsp+d1g+xR2ZNBv91Lr058QMc3ol+5PYWEalKgzZebKTyfP0B
	 BjWEJcyZVmoEvatrioJ9UbZmtMRxsprNujh9TALK8qKTmhBp4PXDPG6ziRU5YrD7gX
	 WJfxG0jAtsLcgpfl81hN0d5x+dCRG7S67DYwWAruHoY7lkAqRdzdxAdoS4WCt7H+bA
	 bFJfzbohe2BDg==
Date: Fri, 26 Sep 2025 12:50:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefan =?UTF-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>
Cc: "mailhol@kernel.org" <mailhol@kernel.org>, "socketcan@hartkopp.net"
 <socketcan@hartkopp.net>, "davem@davemloft.net" <davem@davemloft.net>,
 "wg@grandegger.com" <wg@grandegger.com>, "linux-can@vger.kernel.org"
 <linux-can@vger.kernel.org>, socketcan <socketcan@esd.eu>, Frank Jungclaus
 <frank.jungclaus@esd.eu>, "mkl@pengutronix.de" <mkl@pengutronix.de>,
 "horms@kernel.org" <horms@kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] can: esd_usb: Add watermark handling for TX jobs
Message-ID: <20250926125026.49f20992@kernel.org>
In-Reply-To: <1b539003186430591736552a3922c441da63a336.camel@esd.eu>
References: <20250924173035.4148131-1-stefan.maetje@esd.eu>
	<20250924173035.4148131-4-stefan.maetje@esd.eu>
	<20250924172720.028102e4@kernel.org>
	<1b539003186430591736552a3922c441da63a336.camel@esd.eu>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Sep 2025 01:35:07 +0000 Stefan M=C3=A4tje wrote:
> Using the netif_txq_maybe_stop() / netif_txq_completed_wake() pair seem
> not the right thing for me because I don't understand the code completely
> and the netif_txq_completed_wake() should only called from NAPI poll
> context where I would need to call it from the USB callback handler
> possibly on IRQ level.

Ah, true, not NAPI, but you don't use BQL so we'd need a flavor of=20
the macro that doesn't picky back on the mb() in BQL.

The main point of the macro is that on one side you need to re-check
after a barrier. No matter how many barriers you put in place you
can still have:


 CPU 0                                 CPU 1
	used++
	if (used > threshold)
		/* long IRQ comes */
                                         used--
					 if (used <=3D threshold)
						wake();
		/* long IRQ ends */
		stop();

