Return-Path: <linux-can+bounces-1500-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF060978946
	for <lists+linux-can@lfdr.de>; Fri, 13 Sep 2024 22:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 174D1B213D4
	for <lists+linux-can@lfdr.de>; Fri, 13 Sep 2024 20:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE97136E01;
	Fri, 13 Sep 2024 20:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="n8Dw7WDy"
X-Original-To: linux-can@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D545BA2E;
	Fri, 13 Sep 2024 20:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726257938; cv=none; b=a8gnWy9VGsQYVsPmU+8AznTSa1bEmi3P7ZZPJFh77ORj7vlYqxKPkwZ1h6A7FEN3lLI8oU7ylZws7DRtsYSu5PGQsfmYwmPNDANREfp5tWjYY+Qixq/11nqZNmBTbkgfm2uw2+J2pjJmBZOwYtHG9yD48CEC1gAT8qAmlqQxGSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726257938; c=relaxed/simple;
	bh=88+WbYUILBPnMzh6jPB4Mj7NyId5g8mRCRkbvrT/nQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eE1RPSXGSP1f+uySFpg32ewvczDCBc4LH4ZM5KVXGkC+XBYF7y2ep2X3IpoN/Dg4lcV2w8k/qmDiWPuL72xbF27ZssHaPGWFufrJI3iJ4J20CLjVuX5XypUe+SUb3lAHnYs5ea6PHR6ED+jZlC74LAsXpQLisJGw6k+HCW9thzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=n8Dw7WDy; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=fdTfQKY0qkCMjwrdmN0Fuu0YLCsZGwp56cFev5joVpI=; b=n8Dw7WDyb8qe/vPk
	zv/1LZwBTw68NIlZxHpBQEh4Oa7ShjOtFYOsru3+bCjk/h4lpiapemxcA2IQ/hfIwlTlDRwMPJTFK
	9pldfEKL0sMlQ4tjm9JD0pvZl4B5xrjTZgS9nYX/SmKYzTQ8AXuJSwWuEdKyH0H1TWcxN6dqv7kEy
	1+O9+KdqhyjZfD4NDHF05a4ej+P7upLyUztHVbXqb7RQfIPNkuUEKofjukBgjwp/HC8GsTHHBrewY
	dbV2qY7UdZLdes6Y9TaKiWTwd1RvDdGUanxLi60ulWLKzIIzKnpjYFGGWqsiO4LA1SZbGGYuEnESA
	AmLy17OzX6i0USUDtg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1spCXr-005fFw-0D;
	Fri, 13 Sep 2024 20:05:31 +0000
Date: Fri, 13 Sep 2024 20:05:31 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: mkl@pengutronix.de, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: of alloc_canxl_skb
Message-ID: <ZuSbC8iqeGcUnogC@gallifrey>
References: <ZuRGRKU9bjgC52mD@gallifrey>
 <2540406e-8da3-4cb8-bd1a-30271dd6cc67@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <2540406e-8da3-4cb8-bd1a-30271dd6cc67@hartkopp.net>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 20:04:08 up 128 days,  7:18,  1 user,  load average: 0.02, 0.02,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Oliver Hartkopp (socketcan@hartkopp.net) wrote:
> Hi David,

Hi Oliver,

> On 13.09.24 16:03, Dr. David Alan Gilbert wrote:
> 
> >    I'm doing some deadcode hunting and noticed that
> > 
> >    alloc_canxl_skb in drivers/net/can/dev/skb.c
> > 
> > looks unused in the main kernel tree; is that expected?
> > I see it was added back in 2022 by
> >    fb08cba12b52 ("can: canxl: update CAN infrastructure for CAN XL frames")
> > 
> > I know almost exactly nothing about CAN, so I thought it best
> > to ask!
> 
> I created some slides so that you can get an introduction to the different
> CAN protocols CAN CC (aka Classical CAN), CAN FD and CAN XL:
> 
> https://github.com/linux-can/can-doc/tree/master/presentations

Thanks!

> The introduction of the CAN XL support lead to some clean up and rework also
> for the former alloc_can_skb() and alloc_canfd_skb() helpers.
> 
> The function is currently not in use in net/can/raw.c as it is only needed
> when a CAN XL frame is received from read hardware. But the patch also
> contains the definition of ETH_P_CANXL to already handle CAN XL frames
> properly inside the Linux kernel and e.g. for WireShark 4.4.
> 
> There are currently some CAN XL IP cores in development (see attached
> picture with an FPGA based IP core) and I am working on the kernel
> infrastructure (e.g. bitrate configuration enhancements) on this board. So
> alloc_canxl_skb() is already in use on my desk and there will be some more
> stuff showing up soon ;-)

OK, great - I won't try and deadcode it then!

Thanks again for the reply,

Dave


> Best regards,
> Oliver


-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

