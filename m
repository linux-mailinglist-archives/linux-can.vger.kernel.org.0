Return-Path: <linux-can+bounces-3502-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A15F6AA03FA
	for <lists+linux-can@lfdr.de>; Tue, 29 Apr 2025 09:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25417188CD66
	for <lists+linux-can@lfdr.de>; Tue, 29 Apr 2025 07:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2D015B135;
	Tue, 29 Apr 2025 07:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ROKHQwOL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MpQEqn9V"
X-Original-To: linux-can@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3111C1F13
	for <linux-can@vger.kernel.org>; Tue, 29 Apr 2025 07:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745910185; cv=none; b=kAenuQ/feeHGphqdDXOsC4xx0/0ND3WibBuB1dEO3Y7L3YMa/7HxLx9WOljXWhxzuQVL251Y5G7MDU52+OydtqoqwQLvYIHVX2Whb/3U0MlDC9gjPRuKQ+6tslaJ3bWWl6IKqxI72ZcTi9M4K07ylkt7GrKqZl2jXH0CN4kOw6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745910185; c=relaxed/simple;
	bh=oksDA15aLKtaI4PBMr+CEivze2LFfsIUQFklfxFbSjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUg1kZ3wSsKo2vq1fhCddLybovW6FJG8zUdCPNqlBWdBYod00/yKC9l7yi3BwA1IwwxBTt3ucR/+pYIXeiUJgIkYBpTkJum963RK5nqLUT1wpswFWrnnMTIFkX5544pCmUUK+Bq29Ogq3gr+zwW8ngZsKLkaA1P+kpxHKpa6RxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ROKHQwOL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MpQEqn9V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 29 Apr 2025 09:03:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745910182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SxK2T4I/ppFYX2oHhBwEIZH2w2e/xCf/emx8evG9Mbo=;
	b=ROKHQwOLt6HNpRDBO5HjkStgNaDXeTPdKWCqgz95FkGYEtuql7FuB1GveeL34G0hrAYAn7
	y3H04DRHroc4R2qiUFzgoRF4kxeDKOghqPRFXUGKg49M2KY57qWEEkrImsUM+MLADVsJIZ
	/8I75bAd3DTa4Twc0CGPcsHbiopxGgqw6Ntc4h5NeeqsVbPUF/0EaghPlXQn2TRxz5nAQ9
	ppydulsOc+gkIb58U0/ffEkUNhAIKbMXlvsN4eIiZzRucr21+ZewvcAYEFaG+wRPaO0K0F
	Aqut45JUy/dDvT+I4GZAfiE+4/hLULSZc0n+YklqWweUotdBYes9LQbQvUc2xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745910182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SxK2T4I/ppFYX2oHhBwEIZH2w2e/xCf/emx8evG9Mbo=;
	b=MpQEqn9VImekvq6J7mhZ/PGnNVKAJi5PQJ9F0L8KnFkltabj+6CB68LfLpfz1CyUMdXzGd
	u2tw8D2cPFcOCpAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, tglx@linutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: gw: fix RCU/BH usage in cgw_create_job()
Message-ID: <20250429070301.AwIEDSN1@linutronix.de>
References: <20250417144122.LVyWdXXO@linutronix.de>
 <f7551463-1fe4-41e6-bd7c-1b99111a7e46@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f7551463-1fe4-41e6-bd7c-1b99111a7e46@hartkopp.net>

On 2025-04-28 22:11:48 [+0200], Oliver Hartkopp wrote:
> Hi Sebastian,
Hi Oliver,

> thanks for your interesting work!
> 
> I have one comment/question inline ...
> 
> On 17.04.25 16:41, Sebastian Andrzej Siewior wrote:
> 
> >   	err = cgw_register_filter(net, gwj);
> > -	if (!err)
> > +	if (!err) {
> >   		hlist_add_head_rcu(&gwj->list, &net->can.cgw_list);
> > +		mod = NULL;
> 
> I assume this assignment prevents to kfree() the assigned mod data some
> lines below, right?

Yes, that is the reason but I think I can do better.

> If so there should be a comment why this assignment was made.
> 
> > +	}
> >   out:
> >   	if (err)
> >   		kmem_cache_free(cgw_cache, gwj);
> > -
> > +out_free_cf:
> > +	kfree(mod);  <<<<<<<<<< HERE <<<<<<<<<<
> >   	return err;
> >   }
> 
> You can also add my
> 
> Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> Many thanks,
> Oliver

Sebastian

