Return-Path: <linux-can+bounces-499-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA878B5473
	for <lists+linux-can@lfdr.de>; Mon, 29 Apr 2024 11:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60FFD1C216CA
	for <lists+linux-can@lfdr.de>; Mon, 29 Apr 2024 09:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8A2286AE;
	Mon, 29 Apr 2024 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h/Mz9YF/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="75woX5RR"
X-Original-To: linux-can@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB0524B34
	for <linux-can@vger.kernel.org>; Mon, 29 Apr 2024 09:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714384040; cv=none; b=npCk7wlSAoKar6H+VKLSC8YJEhS5y/UdPU6DtmTlNOK+ZrSTEr+/jgy3qsYxWwAMoTf9LWit9BdVTYA4fYg7syhrXl0ixtW5zizxsoXo1CK2hOWt1tEB67jn7ogUnbD4EinNGVwCjh/CYbf9FoINwIqv0XBLef7NXUxNX9lvzZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714384040; c=relaxed/simple;
	bh=qUtqnMwRtUNW+kNjDuRKurBVFoxhRIqw4sh412dj9Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5sJ9Y4PV2uvRQRLm6kIXv+hc47MmXcpCTAJAz5SPbuF2KSNNv18HBmGV/lXPZsQ3jDjbod62XVTrE9nm7KT5BQp3Pt5BAxWTlc2SVJekDnkYBT+nL79m5o3eo3LFQW7y45zB6FRHOcKbEDw3CztrVSKmwxIHC8l8TvShYE79Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h/Mz9YF/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=75woX5RR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Apr 2024 11:47:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714384037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fhb85wTYViVD9ZrYFv2BwJnLfudpIX1/T27znafZc88=;
	b=h/Mz9YF/J+r0s9Jal9I5U2H+3rsGfG56wQ2gicv3y8SsJMs1ZaJbjuT31D8ByJZJUvcPZz
	GhKITvlMtGspJNTb0NhqzA93SxBeUFlVyjEWD3PI23hzNtZPtCG36UJlEhpdNUiFJ/yRLS
	wIloCN8eYDeOqlv6dum3JllLaS6YUOlHA5fohsGfiAiA6nDBr0ay8I3KO5cbUvB7TOdyUk
	iZk+gscAkBjoWvSEHnuGw4qsLQuYtgwGU9pGRM4aVvUjttvUxS2L4Fu1rQQ5S6CbpRWahn
	dY5YaFQj0l1HJcjaqb5YzlNF6JwktstOD45Sr6N4ZWnOZci4r/V0g9AuTgvpqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714384037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fhb85wTYViVD9ZrYFv2BwJnLfudpIX1/T27znafZc88=;
	b=75woX5RR1nOBVRQPP7CDFFjFU3u5N4mH225PTsBGUtrdG4DBd7QLXBp4qtUFsokHI+6fM5
	BZUfOK7/r1CrSpCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, tglx@linutronix.de
Subject: Re: [RFC PATCH] can: gw: fix RCU/BH usage in cgw_create_job()
Message-ID: <20240429094716.rs5cj3Ts@linutronix.de>
References: <20231221123703.8170-1-socketcan@hartkopp.net>
 <20240111121402.xc9rmYfG@linutronix.de>
 <b42b9988-98b5-411a-8493-b9d3d534c7d7@hartkopp.net>
 <20240122101037.FnYaYf7_@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240122101037.FnYaYf7_@linutronix.de>

On 2024-01-22 11:10:38 [+0100], To Oliver Hartkopp wrote:
> > Would a spin_lock() or spin_lock_bh() be an alternative to lock this update
> > against the modification execution in can_can_gw_rcv()?
> 
> Yes, that is what locks are for. You would have to put the lock outside
> of ccgw and acquire it before reading or writting ccgw.

Hi :)

> > Best regards,
> > Oliver

Sebastian

