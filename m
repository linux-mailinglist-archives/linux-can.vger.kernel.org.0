Return-Path: <linux-can+bounces-63-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6387E7FF67A
	for <lists+linux-can@lfdr.de>; Thu, 30 Nov 2023 17:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1530E1F20F6A
	for <lists+linux-can@lfdr.de>; Thu, 30 Nov 2023 16:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F685100A;
	Thu, 30 Nov 2023 16:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wXvvp3Mt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zz8tW5nc"
X-Original-To: linux-can@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D05B1A3;
	Thu, 30 Nov 2023 08:43:33 -0800 (PST)
Date: Thu, 30 Nov 2023 17:43:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1701362611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=svXRDmLurhbU6j+xT+X3NziP98cVJ5amTyK/Pjzr9iM=;
	b=wXvvp3MtZD31Sv8p222DVTODp+0OfLh+e5Q+4C+KAS8OYZ9jbAU2xNe80NTn9unZIdPV1w
	VNYV+9Tyo/XSrQy+qlsrTmO1quAjYBScyLwvR+jHTgCopGiXEFwlNbN+mVsuQ0hd+2yCrF
	Xs46WNEL783cccFV0HwdmOmTQ0+qNO0QoZ2Vgxo+rEG2N2Iy9zKwnzUhH+sD6bLSyI4+2D
	9JHy+6ZKiAr3H6LyAAfMWE53cj1qTvDTEUy1wHozrzOpf+XTjrZC5QsRScT/5wVptxfyib
	bUEO54MXMmkHHdyItWxjWawBBqTFg2XJo3pvUUO7eaz6LrIdPfPC/YvLsPWjKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1701362611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=svXRDmLurhbU6j+xT+X3NziP98cVJ5amTyK/Pjzr9iM=;
	b=zz8tW5ncMU3xAXGc5E6VNMAb/aUlD6g42CVZ0DppZ0oF6NtPNn9UTw5/YleCA69ncsslQA
	8mj3qd3x3eDipKAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] Questionable RCU/BH usage in cgw_create_job().
Message-ID: <20231130164330.bYbMzPz7@linutronix.de>
References: <20231031112349.y0aLoBrz@linutronix.de>
 <ba5d5420-a3ef-4368-ba36-3a84ed1458cf@hartkopp.net>
 <20231031165245.-pTSiGsg@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231031165245.-pTSiGsg@linutronix.de>

On 2023-10-31 17:52:47 [+0100], To Oliver Hartkopp wrote:
> On 2023-10-31 17:14:01 [+0100], Oliver Hartkopp wrote:
> > Hi Sebastian,
Hi Oliver,

> The point is to replace/ update cf_mod at runtime while following RCU
> rules so always either new or the old object is observed. Never an
> intermediate step.

Do you want me to take care of it?

> > Best regards,
> > Oliver
> 
Sebastian

