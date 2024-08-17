Return-Path: <linux-can+bounces-1197-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 802C09558CD
	for <lists+linux-can@lfdr.de>; Sat, 17 Aug 2024 17:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9811C20C00
	for <lists+linux-can@lfdr.de>; Sat, 17 Aug 2024 15:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDB314F9EA;
	Sat, 17 Aug 2024 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=octiron.net header.i=@octiron.net header.b="Htkkf+Le";
	dkim=permerror (0-bit key) header.d=octiron.net header.i=@octiron.net header.b="i2PlxWYM";
	dkim=pass (3072-bit key) header.d=octiron.net header.i=@octiron.net header.b="mZKieQBu";
	dkim=permerror (0-bit key) header.d=octiron.net header.i=@octiron.net header.b="1KxZoK1m"
X-Original-To: linux-can@vger.kernel.org
Received: from papylos.uuid.uk (papylos.uuid.uk [209.16.157.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1136621;
	Sat, 17 Aug 2024 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.16.157.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723910002; cv=none; b=mE7XdnwgPN43muG9fDhZ4hJLapMF+v5GDIn57n1gETuhCIURFJ5o6yzfk4Z+ouOdlnngIqhcTKIxanF7znl/u+A7vJBVU+jOY3Ms5QkfcH7RlShkcvZYiJiV7F3JI+4L6Zl+pWt9jRp69fTZJHdvLmidVzpyRJtwO1HPNQgC+94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723910002; c=relaxed/simple;
	bh=44Gcg5gHo0SDzHcx2AbXaJijpGiE6ziXWTF+kBIM6xo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=jwzz0XL6Oo5RIll1F6eEPs3G0FJMDGUiji9S6uHEMjNjHb91UB7RVdhAUnV9SOujafmRqjPgzhAxT3wF/xv554VGGqfT/aW52KY254hNTPwjPHJwoQNC/SEeN7Ddlr3Bhg63IzhOkYEUxn4rNlrjrOydjwHOwWMX4aHPCeQ1/mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=octiron.net; spf=pass smtp.mailfrom=octiron.net; dkim=pass (3072-bit key) header.d=octiron.net header.i=@octiron.net header.b=Htkkf+Le; dkim=permerror (0-bit key) header.d=octiron.net header.i=@octiron.net header.b=i2PlxWYM; dkim=pass (3072-bit key) header.d=octiron.net header.i=@octiron.net header.b=mZKieQBu; dkim=permerror (0-bit key) header.d=octiron.net header.i=@octiron.net header.b=1KxZoK1m; arc=none smtp.client-ip=209.16.157.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=octiron.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=octiron.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=octiron.net
	; s=20230424-rsa3072; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:
	From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:Bcc:MIME-Version:Content-Type:Content-Disposition:
	Content-Transfer-Encoding:In-Reply-To:References:Organization;
	bh=g7qDpelvAGbFuX1Lj9/Vu9+S47+tSyG/wswyKe8fpSY=; t=1723909998; b=Htkkf+LepvSe
	BP13KVjDkg9iUcbFYHAfUeESi1vmxGMuLtaSHUJ3Fznda3tqRUMBJYVvrByUnPYkvQAV9hLg5qK3D
	JDKwYpLFG0Iv7X0TrwsOzaGXEAklDhKNZCxXtuADGmdDABpLdMcYL2QqS/uJDNj6qIfLVMm5i1BSW
	4altVE9bnNkRiAuPHRu2kFQwpBvmdNAQivphDiwlAvA0MTVhJszaEjggyMgb0n6SVFSbHGDdUiyvC
	n4oeqxSy1WcWvTYAwZ2QIrk3BrOGznbzX0UfSMXdjxU+KXD38GcDiu57N2zfEI9fjQ9lMRmGEZGp1
	HFHR9D/hdMjTWyRZ6IneE6a+XsNkougq77aQCyWnPmnhWhdcCcQ4EQutULKAOocWrdIZW1KECKwUk
	l9FjGxbIJ20W99YVZ3mDM9gjTgzKQw7CihPRwnYEChaP9oSqtOmQMyWLPLvdx1Nfw1GRwX2Wr2RyX
	hj4UW87WPtLPYjI64bu6sqR6dg/kvl45/gKY7C;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=octiron.net; s=20230410-ed25519; h=Content-Transfer-Encoding:Content-Type:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:Bcc:MIME-Version:Content-Type:Content-Disposition:
	Content-Transfer-Encoding:In-Reply-To:References:Organization;
	bh=g7qDpelvAGbFuX1Lj9/Vu9+S47+tSyG/wswyKe8fpSY=; t=1723909998; b=i2PlxWYMoAZE
	BpbaL3WpHPJFyn5BrgoYDAE0Iq+bN4s3kpTOLZEexu+/i9M/EXY1pZTwx/HnLHINuc6aUHehDQ==;
Received: by papylos.uuid.uk with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	(envelope-from <simon@octiron.net>)
	id 1sfLcL-0073lS-9K; Sat, 17 Aug 2024 16:45:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=octiron.net
	; s=20230424-rsa3072; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:
	From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:Bcc:MIME-Version:Content-Type:Content-Disposition:
	Content-Transfer-Encoding:In-Reply-To:References:Organization;
	bh=g7qDpelvAGbFuX1Lj9/Vu9+S47+tSyG/wswyKe8fpSY=; t=1723909525; b=mZKieQBuQo3y
	cAaV0Ug7/ip10Dfyd0ERjpfOgCflmzYTPu3c93bnSXocPLA60Zhso91HNWqlhmm2zSgu/sCQMvnYw
	VlQ3DwPp1+AmO/H8sBOA8JYXMAoxcqc9ysXVKCaAQFish4RSlKYjc59XUvkAxYmzqy+8KXtrxG6TB
	x7F2/DZuB+9/D2CjRsSjFDEig0wLVA/iAbXq+yaS8MfikokwkZwvmlcfGqi3hBGsOHxLsBjtFINht
	Ovn0SXg3egd8t9HBOFXiKza+4emoDdfr8UnZVgTVr4Ld/nVxeRYCCOHNuDn6qFSyr1PW6/ZPqWRTl
	Xgt1z1Lu8YjV3svYslxh0uVoepBv8Xamc6L02QCzFX7pC48pGHQWaW15vR/UL1GZYGE6f3YlCaZje
	J6M+JWFuM5t7SGK3YIjaJpl6BBr2dFUSYCxoxmqogYPKZzUCOI6hRhRTnA1Ukzx9EmN7W/nHbIinM
	3rnpLP8dSLTtW7Elcn21C4VjscMeHnW66VwTco;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=octiron.net; s=20230410-ed25519; h=Content-Transfer-Encoding:Content-Type:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:Bcc:MIME-Version:Content-Type:Content-Disposition:
	Content-Transfer-Encoding:In-Reply-To:References:Organization;
	bh=g7qDpelvAGbFuX1Lj9/Vu9+S47+tSyG/wswyKe8fpSY=; t=1723909525; b=1KxZoK1me+2o
	b+c+4T43CBM0wUN98Nc7fNH+8lfB7gGT2D7lgsuKGIb2kQJ+Au57q40EmfFQh85O3JsCcKjeDQ==;
Received: by tsort.uuid.uk with esmtps (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	(Exim 4.93)
	(envelope-from <simon@octiron.net>)
	id 1sfLcH-003504-H1; Sat, 17 Aug 2024 16:45:22 +0100
Message-ID: <ea44fb76-0a9d-4009-8eba-021f0928cc77@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
Date: Sat, 17 Aug 2024 16:45:21 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Simon Arlott <simon@octiron.net>
Subject: [PATCH] can: mcp251x: fix deadlock if an interrupt occurs during
 mcp251x_open
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
X-Face: -|Y&Xues/.'(7\@`_\lFE/)pw"7..-Ur1^@pRL`Nad5a()6r+Y)18-pi'!`GI/zGn>6a6ik
 mcW-%sg_wM:4PXDw:(;Uu,n&!8=;A<P|QG`;AMu5ypJkN-Sa<eyt,Ap3q`5Z{D0BN3G`OmX^8x^++R
 Gr9G'%+PNM/w+w1+vB*a($wYgA%*cm3Hds`a7k)CQ7'"[\C|g2k]FQ-f*DDi{pU]v%5JZm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The mcp251x_hw_wake() function is called with the mpc_lock mutex held and
disables the interrupt handler so that no interrupts can be processed while
waking the device. If an interrupt has already occurred then waiting for
the interrupt handler to complete will deadlock because it will be trying
to acquire the same mutex.

CPU0                           CPU1
----                           ----
mcp251x_open()
 mutex_lock(&priv->mcp_lock)
  request_threaded_irq()
                               <interrupt>
                               mcp251x_can_ist()
                                mutex_lock(&priv->mcp_lock)
  mcp251x_hw_wake()
   disable_irq() <-- deadlock

Use disable_irq_nosync() instead because the interrupt handler does
everything while holding the mutex so it doesn't matter if it's still
running.

Signed-off-by: Simon Arlott <simon@octiron.net>
---
 drivers/net/can/spi/mcp251x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 3b8736ff0345..ec5c64006a16 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -752,7 +752,7 @@ static int mcp251x_hw_wake(struct spi_device *spi)
 	int ret;
 
 	/* Force wakeup interrupt to wake device, but don't execute IST */
-	disable_irq(spi->irq);
+	disable_irq_nosync(spi->irq);
 	mcp251x_write_2regs(spi, CANINTE, CANINTE_WAKIE, CANINTF_WAKIF);
 
 	/* Wait for oscillator startup timer after wake up */
-- 
2.44.0

-- 
Simon Arlott

