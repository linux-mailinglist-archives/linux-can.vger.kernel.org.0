Return-Path: <linux-can+bounces-2706-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA13A21F63
	for <lists+linux-can@lfdr.de>; Wed, 29 Jan 2025 15:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7121884B97
	for <lists+linux-can@lfdr.de>; Wed, 29 Jan 2025 14:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9F11DA0E0;
	Wed, 29 Jan 2025 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NwWdYj60";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0rFf4gU3"
X-Original-To: linux-can@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C451B1D89F1;
	Wed, 29 Jan 2025 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738161634; cv=none; b=HD+2UlD7QE13CXpcQReb1hEVUmGXMujABJ/MPgS2ukjYtJ7PvFU5d3oBCCMaYUNFlWiDsKYDeVJPQ/TfDXGMzTVrP/TRQeRCgGiYcfL/P1CElAS+PKJc2zkw/TQ5ER0W1UmpE9mCzbcoQvXg6IwN5uhlLbwomvjSm/OstVuVYR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738161634; c=relaxed/simple;
	bh=p4QfTLeZJe0FqNorMQ98vlFmJd+oiOH2Mw64teFP4Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUFvP2595ehloNqYIpy5jfipcSsh/ZRvpM7Voas7pY4IlUBfO9dWnIo/nI6hT5sEFPdD42SItbWwJXWwdLGh47B8BGWCQpAACodcsvxDykopiCb0HUbGANazLJnVXfQcpX34adX9sbg60XJWm4+8Z28y3VhJM6zq8DB/eAtrXVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NwWdYj60; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0rFf4gU3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Jan 2025 15:40:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738161630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/Zfr30skfQ9X/KGxlz2Ff0JvnpJ0gm89QmSf9RgAlQ=;
	b=NwWdYj60wx+Iwom0yy5oR8gu3BlG2dE2yCCKE2tukX5Haklugc+6g9otjyJCYoavxidd3o
	cHbVDbzQjlUmeqT4Tg6NMqvphFxGZUDTXL/uYdW39wwfC8Qi07PIpoMa8sYY5f2k+kjRdF
	qRtqiiNDKKX5KbeqpiAeESIQpSNCDR0nIYNshB7hMt1ZWF8ksK7/iF8D1trdXIV0vm+Gw+
	TX3WpYA+VM7LoBqVdrxr9BvbuFnFL9jMoYmQzccJqIMSQTmAsP726BaGkz5KIzUQrjW1eI
	WHNS6qYsG4AMQNtOits8YpHz0jb6E6NZfUtF3Iyn7oYdSRYzWPLQwYtLZtBFhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738161630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/Zfr30skfQ9X/KGxlz2Ff0JvnpJ0gm89QmSf9RgAlQ=;
	b=0rFf4gU3TyrAEyv31egHao7A1lrid3uYmjTPpTsfS4Is58X7taYhagNpWiGv0gQ5kZYGMU
	w1PFCakWjZdupbDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Pavel Pisa <pisa@fel.cvut.cz>
Cc: linux-rt-users@vger.kernel.org, Carsten Emde <c.emde@osadl.org>,
	linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>,
	Jan Altenberg <Jan.Altenberg@osadl.org>,
	Pavel Hronek <hronepa1@fel.cvut.cz>
Subject: Re: Question for AMD/Xilinx Zynq PREEMP_RT configuration check, CAN
 latency measuremet and FOSDEM 2025
Message-ID: <20250129144029.snKWIeXA@linutronix.de>
References: <202501281629.27139.pisa@fel.cvut.cz>
 <20250129101709.XQuo8Jle@linutronix.de>
 <202501291304.15901.pisa@fel.cvut.cz>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202501291304.15901.pisa@fel.cvut.cz>

On 2025-01-29 13:04:15 [+0100], Pavel Pisa wrote:
> Hello Sebastian,
Hi Pavel,

> The actual one show none IRQ work interrupts
> after last reboot and overnigh test
>=20
> Linux mzapo 6.13.0-rc6-rt3-dut #1 SMP PREEMPT_RT
> Wed Jan 29 04:46:40 CET 2025 armv7l GNU/Linux
=E2=80=A6
>            CPU0       CPU1
>  48:     314697          0 GIC-0  61 Level     can2
>  49:     314597          0 GIC-0  62 Level     can3
>  50:     314759          0 GIC-0  63 Level     can4
>  51:     311516          0 GIC-0  64 Level     can5
> IPI0:          0          0  CPU wakeup interrupts
> IPI1:          0          0  Timer broadcast interrupts
> IPI2:      17849     292126  Rescheduling interrupts
> IPI3:       5923      11315  Function call interrupts
> IPI4:          0          0  CPU stop interrupts
> IPI5:     271078      74040  IRQ work interrupts
> IPI6:          0          0  completion interrupts
> Err:          0
>=20
> So this seems as no cause.

None you say? I see 271078 on CPU0 and 74040 on the other one.

> Yes, I think that design mixing regular networking packet
> processing with CAN is the problem. We test even with setup where
> CAN interrupts priority is boosted to 90
>=20
>     echo "-> Rise CAN irq priorities"
>     PIDS=3D$(ps -e | grep -E irq/[0-9]+-can[3-4] | tr -s ' ' | cut -d ' '=
 -f2)
>     TXPID=3D$(ps -e | grep -E irq/[0-9]+-can2 | tr -s ' ' | cut -d ' ' -f=
2)
>     chrt -f --pid 80 $TXPID
>     for pid in $PIDS ; do
>         chrt -f --pid 85 $pid
>     done

but boosting the prio does not help because lock contention leads to PI
and forces its way through. The problem is that networking will
continue.

You need to go to /proc/irq/${can_irq} and push the affinity to CPU1.

> Even this setup is problematic under load.

I would expect no change.

> to run daily testing. We can consider even something different,
> but this choice has been given by interest in something
> functional for each day and ahead of mainline merges to
> catch some problems in advance.

Oh okay.

> It is interesting than in kernel gateway is significantly worse
> now. It does not overhead of switching to userspace. But I am not
> sure if it is not invoked in some kernel worker which
> has lower or same real time priority than Ethenet networking.
>=20
> In general, I think that the problem is that incommin
> packets (CAN and Ethernet) load the same per CPU
> worker. There are even backlog_napi threads per CPU
>=20
>    46 TS       - S ?        00:00:00 [backlog_napi/0]
>    47 TS       - S ?        00:00:00 [backlog_napi/1]
>=20
> It has even TS priority. If I remember well, there has been
> added option to allocate separate RX packets processing
> therad (instead for default per CPU one) for given interface.
> But I have no experience with such configuration.

backlog NAPI is used by devices which don't bring their own NAPI.

> Do you have or somebody else have idea how to achieve
> that and if it is legal to boost such kernel therad
> priority. It could help, because my general experience
> with PREEMPT_RT even on this target is very positive
> for tasks mapping HW directly and doing RT control.
> Same for latency tester. No spikes under load over
> 250 usec or less.

I wouldn't boost it unconditionally. If you enable tracing with
sched_switch, interrupts and maybe net then you should see how the flow
of the CAN skb is. I don't know if it touches backlog_napi. Ideally it
shouldn't. There shouldn't be anything that could interfere with it such
ethernet traffic (say ssh) or local sockets.
Once you see the regular flow you should be able to what blocks it once
you step the trace during a spike.

> Best wishes,
>=20
>                 Pavel

Sebastian

