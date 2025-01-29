Return-Path: <linux-can+bounces-2704-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04810A21ADB
	for <lists+linux-can@lfdr.de>; Wed, 29 Jan 2025 11:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6C63A3D78
	for <lists+linux-can@lfdr.de>; Wed, 29 Jan 2025 10:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F6B19C54C;
	Wed, 29 Jan 2025 10:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r84xh+Ud";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h6RG1ZtE"
X-Original-To: linux-can@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400F316C854;
	Wed, 29 Jan 2025 10:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738145835; cv=none; b=t7mSP9P/yS3srQNsQqVAiiJTfkWPsGgAaB8NPSaKod7vtXNoouX7pg4NxxME6kUO91LGzCv9SC6JXYcnAPsho7XbHYeljYQ4IlNb20Pyw6oowOMYaCRsWhLmBUbKcBIli3XPiYdOiDnksN5D1jM9n4JOPlBcJo0DrDbMITPwvo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738145835; c=relaxed/simple;
	bh=MGIukBWatYke3GZ3xsRf8q/Msj+HxVj+/X/A029UuIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQ7bDehbRUgUNvZz1MxmoPKOOXwFh3tr5RVIdbE8xs89/jNpGukXgvgqFTBBq1ympHiPcOLLtMdPQV3ORPv1pJNAwIeIUSBxogrh7j+Dri5vzlQnJugj+rqRvuW/KyPd7IhUvN9lsT0V7nueihLZY2beFOveMIOCYPSNTNugZas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r84xh+Ud; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h6RG1ZtE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Jan 2025 11:17:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738145831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sc3jWSn17yLXXC2WEE0CpEi5wTTgZnG3eBhrxwp0SPs=;
	b=r84xh+Ud4gT+E62Z+mzOB8xdn9yXEc3TRBcM47TPLcz+SMO3jp6dikJ71pm25wvicfVrAp
	5pYLblumG7esnsx2Vt3uRY2mFdf8hO43NN65MzeFy2XshfL/B/Be1oPST1RMINku3O0exf
	dJsyN2D6Wkn6YKcKefeSWarQA1hjSQI6CBfsU0nCy1disPngnQFip/2cDl6dniJtKhBwyy
	I0FWDFbSyudOoClEqO90VQCL+PrPp9PsXbGVPGdDPTYrobx+i/nZF1oHAensoscbUAPnHh
	sP1XM2mTf5tpwXGS1j72AEdWoHlkXB2Z/1uq2kKpq6PPYljvcv1ulIl+q7DRKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738145831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sc3jWSn17yLXXC2WEE0CpEi5wTTgZnG3eBhrxwp0SPs=;
	b=h6RG1ZtETJPhl/y9gGznBX6PyVzqERYJD9rhstbduUfFIMij9nWFRAXm3bfBn8wGyTfJgX
	ahDKQs3pQJ+1VBBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Pavel Pisa <pisa@fel.cvut.cz>
Cc: linux-rt-users@vger.kernel.org, Carsten Emde <c.emde@osadl.org>,
	linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>,
	Jan Altenberg <Jan.Altenberg@osadl.org>
Subject: Re: Question for AMD/Xilinx Zynq PREEMP_RT configuration check, CAN
 latency measuremet and FOSDEM 2025
Message-ID: <20250129101709.XQuo8Jle@linutronix.de>
References: <202501281629.27139.pisa@fel.cvut.cz>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202501281629.27139.pisa@fel.cvut.cz>

On 2025-01-28 16:29:27 [+0100], Pavel Pisa wrote:
> Please check if you find some problematic choices.

I didn't find anything obviously wrong. Assuming your CPU is busy in
general you could remove NO_HZ in favour of PERIODIC. This is however
not to cause spikes you describe below.

> The cyclic test worked well, and we have even delivered two systems
> to OSADL QA real-time farm=20
>=20
>   https://www.osadl.org/?id=3D4109

It shows "IRQ work interrupts". Not sure what causes them.

> However, the CAN/CAN FD communication latency measured on the CTU CAN FD =
IP
> core is far from optimal. Some runs under load with
> 10 msec latency. Our own CAN FD stack for RTEMS keeps with no exception
> under 60 usec on the same hardware.
>=20
> I understand that the Linux socket layer and networking
> stack are complex, and many optimizations are ahead.
> We will be happy to contribute where we can and find time
> and even some resources to engage more students etc...
>=20
> But I would like to be sure that the bad results are not
> caused by our mistakes in configuration.

You have CAN and "regular networking". My guess would be that regular
networking blocks blocks BH and so your CAN. You could try to have all
interrupts serviced on CPU0 and move CAN to CPU1. If so this should
improve then. Other than that, I would suggest to get some tracing to
see what delays your CAN interrupts and/ or handling in general.=20

> I will be happy to meet you and discuss Linux and other
> control and real-time areas at FOSDEM 2025.

I should be able to make it.

=E2=80=A6
> Slides in English which I want to update/correct for FOSDEM
>=20
>   https://talks.openalt.cz/media/openalt-2024/submissions/3XTMDF/resource=
s/openalt24_linux_for_rt-reduced_FbZPuS0.pdf

looks good. If you want additional history points, I have some at
	https://files.speakerdeck.com/presentations/0620b5b3a00b42fc91fba6cc4092d2=
78/KR_2024_PREEMPT_RT_over_the_years.pdf
	Slide 11 - 21.

However you have most of the pieces so.

> Best wishes,
>=20
>                 Pavel
>=20

Sebastian

