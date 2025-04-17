Return-Path: <linux-can+bounces-3438-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAECA9163B
	for <lists+linux-can@lfdr.de>; Thu, 17 Apr 2025 10:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C6F6171301
	for <lists+linux-can@lfdr.de>; Thu, 17 Apr 2025 08:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE09822F160;
	Thu, 17 Apr 2025 08:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PsYn4Mzm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5klyDE8M"
X-Original-To: linux-can@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133E322E40E;
	Thu, 17 Apr 2025 08:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744877579; cv=none; b=q9DMSTwW7+lGENAfjfr6wMghRWPfCOR/Bk/GpqQSdl+oLmKYFjgfxfVwnqCnDI+QYLOzmAypKPa2wmGSkd5thm7mF+nqwuJ8kb6trDsY1waj2xTTfvfUZrBmLWFxmNGo477v1RSGjnrXL/pC8xmV/Lg100UiWHbBSZcyrAWyP0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744877579; c=relaxed/simple;
	bh=hp1b0XAcOQxXusMH+OhsL1oXc8BSXxDZGW5TGs0PlXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABpiFzg6s5VEd6TyhKA6jWSVTuiP3dA5f+/Z/fhtq4V75Ia3KKhhC0rmMTVJjW83hlUojSXhCbzJpGBYrKfZD965XHdSn6AFCRh/NN0YNHghJ00J+pHMwSCCpZjcQZwhVYz4B0kGnYmGDJLhnsz8rxuRyc3QW/PrdZyHzfPs+Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PsYn4Mzm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5klyDE8M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Apr 2025 10:12:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744877576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3FoTXXwrik+HMQzOAbeM6m9MlAGRLYeknXwGoF5uV+U=;
	b=PsYn4MzmTOOJBYV9DatvTtv5m9YXIlEGYCfVaX2ri6IGJm3DVi44d4vaSXJheuxnh2jXgS
	xPHi0dV6wLMQzIf5IPGC0KIzl3YEBPkfeb8x0hBRxxs9g58arvnvjN7KgSKevMQYrxNVfd
	PmFgd7eorqlh+79kK7rsd395I3XOsze6g+LGnTXND30+EwvL97uk1xWqT9XSZh2kibwKtw
	swVvHcb7osxaN72L7jSWnETfE8Ovmdj8vTpREkhT/jsqxnZVsYXW/fiIK8UFqhZhbY9m4F
	tBcyFLLyEJI7/CG51bmvfwaNAqZJ7j5R4BMYr2GXfB34rcIful95wwnJNOg7tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744877576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3FoTXXwrik+HMQzOAbeM6m9MlAGRLYeknXwGoF5uV+U=;
	b=5klyDE8MR3aA1DxL2Ct77nzYyz7blhWHCu7HrWv+St/3PwWDKbYG+w0cW7/7h1uoXavPAj
	kOE8q0rGdepGD/AA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Pavel Pisa <pisa@fel.cvut.cz>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-rt-users@vger.kernel.org,
	Carsten Emde <c.emde@osadl.org>, linux-can@vger.kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Jan Altenberg <Jan.Altenberg@osadl.org>,
	Pavel Hronek <hronepa1@fel.cvut.cz>
Subject: Re: CAN latency measuremet on AMD/Xilinx Zynq with PREEMP_RT - added
 threaded NAPI configuration
Message-ID: <20250417081254.EUqrBagT@linutronix.de>
References: <202501281629.27139.pisa@fel.cvut.cz>
 <20250129101709.XQuo8Jle@linutronix.de>
 <202501291304.15901.pisa@fel.cvut.cz>
 <202503281304.47808.pisa@fel.cvut.cz>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202503281304.47808.pisa@fel.cvut.cz>

On 2025-03-28 13:04:47 [+0100], Pavel Pisa wrote:
> Hello Marc and Sebastian,
>=20
Hi Pavel,

=E2=80=A6
> #!/bin/bash
>=20
> NAPI_PRIO=3D80
>=20
> if (( $# !=3D 1 )); then
>   echo "Need 1 argument (value 0 or 1)" >&2
>   exit 1
> fi
=E2=80=A6
> for ifc in can2 can3 can4 can5 ; do
>   echo $1 > /sys/class/net/$ifc/threaded
> done
>=20
> if [ $1 -eq 1 ] ; then
>   PIDS=3D$(ps -e | grep -E napi/can[0-9]+-[0-9] | tr -s ' ' | cut -d ' ' =
-f2)
>   for pid in $PIDS ; do
>     echo "Setting RT priority $NAPI_PRIO for $pid"
>     chrt -f --pid $NAPI_PRIO $pid
>   done
> fi

The IRQ thread should be limited to one CPU which is the same where the
IRQ it itself is set to. I don't think that this done the NAPI thread
automatically so it is probably free floating in the system.

Sebastian

