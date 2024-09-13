Return-Path: <linux-can+bounces-1496-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C929978230
	for <lists+linux-can@lfdr.de>; Fri, 13 Sep 2024 16:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB788B212AB
	for <lists+linux-can@lfdr.de>; Fri, 13 Sep 2024 14:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79DA1DC75C;
	Fri, 13 Sep 2024 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="WBWMSVOU"
X-Original-To: linux-can@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2841DC75E;
	Fri, 13 Sep 2024 14:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726236238; cv=none; b=YGkQVAuNKsuyFybjGeBZXxOmcTUwL7RU69gpe9IPC6JdZsZbmuTGaK+ktHAlMgK7iTWL8HBbNx/mGSmOm1Ggt+w0Z1GyG/qEDBQ6mN0o/C9t0sHFmSevf8oaUUBfkRHq8GZMVzTrTO2bvU3rU1hANCMYvSsmU1y67EF4GZ8GTPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726236238; c=relaxed/simple;
	bh=my7FXu/G1WDjdq5+yH5TAWpFIO2G9YS14A+L2Qkw4Is=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Fdbil5ukoxIzPrGrSFIw8h5FFyYvchFrP3cgSfZgaI9nDvykh0NAzTpdCR4dESVK5RWdofz4HRdHFz6e465NI+5d2Xb3jWH3BjdDPqF176HyenKfN4YKX5nLLt4QBRDxMq1qPlwifyVEl9CofMFV68C3L7bRBEMaMEE8N34y3rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=WBWMSVOU; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=bFBz4tDpc8fG1LDKKBWmQeiRnYgFe0jkd5sd4Tdoi9A=; b=WBWMSVOUl+UuLGq6
	xR3HVJf0QbEt34l7vpLuwo95JHvS9nN2Svpw/SB7At4jKdcEcoYOOGNUoDShZMZc6D53YLxJsexEb
	PysDamg7iz83mEghX+s3EPP9oOBn2YSeMmUiuqbVZawTAkQSDBAJG60G8YTJ6Pbxa+8WcRMAuHdSL
	52IGA1zI/OIBdQUhZgOe7DL3tP5b2krfT2rrjFCnmeQGKGtV3aNjupMFTUuMigWuTYNRkUPzXBSRS
	8iaVD1hAPYaYPNZYrNQBQf9IZQ5A/S/COOCHEibqKSlqFfjKk7MwAljvdBiJduTU6pa9ZeR3O35LC
	yikAn8TKN8ikMub3KQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sp6to-005b5d-0v;
	Fri, 13 Sep 2024 14:03:48 +0000
Date: Fri, 13 Sep 2024 14:03:48 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: socketcan@hartkopp.net, mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: of alloc_canxl_skb
Message-ID: <ZuRGRKU9bjgC52mD@gallifrey>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 14:00:46 up 128 days,  1:14,  1 user,  load average: 0.07, 0.06,
 0.02
User-Agent: Mutt/2.2.12 (2023-09-09)

Hi Oliver, Marc,
  I'm doing some deadcode hunting and noticed that

  alloc_canxl_skb in drivers/net/can/dev/skb.c

looks unused in the main kernel tree; is that expected?
I see it was added back in 2022 by
  fb08cba12b52 ("can: canxl: update CAN infrastructure for CAN XL frames")

I know almost exactly nothing about CAN, so I thought it best
to ask!

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

