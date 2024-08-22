Return-Path: <linux-can+bounces-1207-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5046D95AF52
	for <lists+linux-can@lfdr.de>; Thu, 22 Aug 2024 09:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80B60B24ED3
	for <lists+linux-can@lfdr.de>; Thu, 22 Aug 2024 07:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254955674E;
	Thu, 22 Aug 2024 07:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=octiron.net header.i=@octiron.net header.b="sGv6qGIC";
	dkim=permerror (0-bit key) header.d=octiron.net header.i=@octiron.net header.b="1mKDYHgL";
	dkim=pass (3072-bit key) header.d=octiron.net header.i=@octiron.net header.b="slgtsiSd";
	dkim=permerror (0-bit key) header.d=octiron.net header.i=@octiron.net header.b="nDlqTNVr"
X-Original-To: linux-can@vger.kernel.org
Received: from ymitury.uuid.uk (ymitury.uuid.uk [95.179.232.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9975F125AC;
	Thu, 22 Aug 2024 07:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.179.232.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724311892; cv=none; b=gtq5Wnotg8PGKpwUT87nW0/PHdQ/U6weLJAY/JbkYxLY5fYi0WRt8WNm0jRUuHI1nsCM0hiYcMMylJW231556I0LLrtG5zGUAt4dKuLPpmrd6vFFk7YYB1DL19HLezvhr3IcSNtCJO7ruMksPBC2LG1NuBDy8iIxPVWQAeFUC/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724311892; c=relaxed/simple;
	bh=y5HJCLYriM2drLCjIHIBOA4aA48H7AbqkZYc0RWYEd0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=FI6xhsZJJkexKmlIXcTHLkO4ZVuAtwmQ0pJaQLXEvSZafxPftzmvLLgggPvN5PiXMCSlEGssNsSFhPqAop6apHlh3tG04CYEQyA1pbgtWFDI7dXUBxcECKSDC+nnPy21VGXSk/HfLMq/jdx95ahDZ+pMxa6nkNDW8lSarZJigZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=octiron.net; spf=pass smtp.mailfrom=octiron.net; dkim=pass (3072-bit key) header.d=octiron.net header.i=@octiron.net header.b=sGv6qGIC; dkim=permerror (0-bit key) header.d=octiron.net header.i=@octiron.net header.b=1mKDYHgL; dkim=pass (3072-bit key) header.d=octiron.net header.i=@octiron.net header.b=slgtsiSd; dkim=permerror (0-bit key) header.d=octiron.net header.i=@octiron.net header.b=nDlqTNVr; arc=none smtp.client-ip=95.179.232.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=octiron.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=octiron.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=octiron.net
	; s=20230424-rsa3072; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:
	From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:Bcc:MIME-Version:Content-Type:Content-Disposition:
	Content-Transfer-Encoding:In-Reply-To:References:Organization;
	bh=5EdaLcB016+00N+TOyi+k7VGW7m1HvknxhrUff810zY=; t=1724311886; b=sGv6qGIC9Ji9
	Faoz6B7xBga6Cw9A/0WGXqes0496EtfU8oAuwhp9uYd3O8wwFKJiQRVTc19HPn4IBQd1rF8iI5Rkh
	uBL4VfiMiYSmcne15sJSChDJpecC4iF5xWyz4+w+wDo8G4ewOuIVrJnBDcOzm/cx/7e/eA9uqVhwv
	VyHMPba8FOjZpamR5TYPxH5kavtL2RdqqxUOFnilKlPHBW8oFkdKPGIDZN3R4KZ943OE1BHbLrOl1
	Km5sqnr/oiahi6k/Vb5hStt698muXuEv1ljYUo8b3VeM/FRBI8PsqRyifueFgy+adscpiynkcxxCa
	1HfImrCLUXqUZJwPEPdtpYtwrx9rCplkdrzswdE//cCgsiRJSaiwZTorQGoCPTwMOBSNmHjkauByH
	/yBci+2Tj6u99jzfhGcBPWPUy1lsCsylwzJszuyB/23GrChcWsm5XxivdO2KK2BnIodc3m2voHny8
	ixqh8Qs25epDg2wx+W8fZ/Srfj8Q0pTxDWMZ7q;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=octiron.net; s=20230410-ed25519; h=Content-Transfer-Encoding:Content-Type:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:Bcc:MIME-Version:Content-Type:Content-Disposition:
	Content-Transfer-Encoding:In-Reply-To:References:Organization;
	bh=5EdaLcB016+00N+TOyi+k7VGW7m1HvknxhrUff810zY=; t=1724311886; b=1mKDYHgLXpWA
	Qy3Fq7ehiz7gWI8CkrpTKr1WziHegqc9dDZ8aJQZSj+DhJqtOB0mRrO0BIxRPl0XRrZJ+7QpDw==;
Received: by ymitury.uuid.uk with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	(envelope-from <simon@octiron.net>)
	id 1sh2C0-000zGS-3a; Thu, 22 Aug 2024 08:25:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=octiron.net
	; s=20230424-rsa3072; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:
	From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:Bcc:MIME-Version:Content-Type:Content-Disposition:
	Content-Transfer-Encoding:In-Reply-To:References:Organization;
	bh=5EdaLcB016+00N+TOyi+k7VGW7m1HvknxhrUff810zY=; t=1724311512; b=slgtsiSdnqE+
	Mqyxg206+L0FHUQd43rxDPQxGoWsmz4oBpUfQRtVD4MXQheBO56HHKJWFVdZWRtTn6mbA2LDBarCT
	PwhOdoGM2QIWz3xjoEWQPLP3rdpW51JpWFpcGi/R0TdGcoipjshuWDJvUDDeZgiPP2bHdJR1tkpL0
	f95/7e3yOWK+Z/YDSk8Fn+iZ+v0wDDzJ6e3CeSzvx2ccqYLJJcEEbHnpXcqdvAq1oa4EA4V9NJrmi
	BoE+3CRDMTv5uB53W3c0fXD86S8r6uwnFMspJzgq+qla1T8CjKsSkD/k0Om+aiUgJsg/XGUHXvER6
	Fu6OhTQSJPM7GzcMkXHhxjvn33ZaHIcuWecUQwbNmGpf6qEp2Jix/YqGUPYF0LyF5VIY3/aZLUmpx
	Qf/xw0jByM6oeR/YlrMXo7gwO3Heiv6LX/cNpw1MmtIvgAI5d+8PrM3gQmWMbiXuv6gE/pMl/ltQy
	CazVE0WQTmfF2dNU2UyYYYrXHp0ZpXBA0Yu76F;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=octiron.net; s=20230410-ed25519; h=Content-Transfer-Encoding:Content-Type:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:Bcc:MIME-Version:Content-Type:Content-Disposition:
	Content-Transfer-Encoding:In-Reply-To:References:Organization;
	bh=5EdaLcB016+00N+TOyi+k7VGW7m1HvknxhrUff810zY=; t=1724311512; b=nDlqTNVry6HL
	zsH32HB+1mZEESeAR5MGG+ACh928dy7PY11OW07dMIXRsgoQLwwA8dC+X33/E2KzrmL3ooxHBA==;
Received: by tsort.uuid.uk with esmtps (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	(Exim 4.93)
	(envelope-from <simon@octiron.net>)
	id 1sh2Bw-000Px2-CH; Thu, 22 Aug 2024 08:25:09 +0100
Message-ID: <4fc08687-1d80-43fe-9f0d-8ef8475e75f6@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
Date: Thu, 22 Aug 2024 08:25:07 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Simon Arlott <simon@octiron.net>
Subject: [PATCH net] can: mcp251x: fix deadlock if an interrupt occurs during
 mcp251x_open
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: linux-kernel@vger.kernel.org
Content-Language: en-GB
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

Fixes: 8ce8c0abcba3 ("can: mcp251x: only reset hardware as required")
Signed-off-by: Simon Arlott <simon@octiron.net>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: stable@vger.kernel.org
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

