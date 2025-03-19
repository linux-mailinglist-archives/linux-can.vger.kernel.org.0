Return-Path: <linux-can+bounces-3157-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4814BA68785
	for <lists+linux-can@lfdr.de>; Wed, 19 Mar 2025 10:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D31F3B45D8
	for <lists+linux-can@lfdr.de>; Wed, 19 Mar 2025 09:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74AB2512DE;
	Wed, 19 Mar 2025 09:10:16 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207832528EE
	for <linux-can@vger.kernel.org>; Wed, 19 Mar 2025 09:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742375416; cv=none; b=X5OvoMrfDOvifNfNoMlenCx8vCAW0cH6yhSHI1ujyAY78RrpF4JXRRtsj1hC9vUvKX5O+sbU8NT1TsaUFwFQX1ycLXDIpiJsggUtumZidRsiw1+eLueXSRtLFG959Vtl1h47fS0HmUTdnbFoXvAGGDGX9HyZNs5mesvdpyzW+jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742375416; c=relaxed/simple;
	bh=ZpZn+uIOIQF74W8rTWgg0rR1axiDKlQOiA9XD0eTXi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pp8USJ+XTxOLSH6LUP3jLISGqjs83POnb800zCNwhcLByZGW/Kump5PRzmL2GZvDmuCXKDSXohaqDgCEMW+HZ3UPTAbJrXP3usjxzwYxJfDgzy7CymfNAPptzLwiocmSi0dkUTBZWQxGMSnRBKtIooR4TmCZCyLSYuOnt4XnGUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tupRA-0003z1-Ak; Wed, 19 Mar 2025 10:10:08 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tupR9-000ZMy-1g;
	Wed, 19 Mar 2025 10:10:07 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tupR9-004ppL-2b;
	Wed, 19 Mar 2025 10:10:07 +0100
Date: Wed, 19 Mar 2025 10:10:07 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Davide Caratti <dcaratti@redhat.com>
Cc: Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Subject: Re: [PATCH] can: fix missing decrement of j1939_proto.inuse_idx
Message-ID: <Z9qJ7_MGJgzXlUcj@pengutronix.de>
References: <09ce71f281b9e27d1e3d1104430bf3fceb8c7321.1742292636.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <09ce71f281b9e27d1e3d1104430bf3fceb8c7321.1742292636.git.dcaratti@redhat.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

On Tue, Mar 18, 2025 at 11:21:41AM +0100, Davide Caratti wrote:
> Like other protocols on top of AF_CAN family, also j1939_proto.inuse_idx
> needs to be decremented on socket dismantle.
> 
> Fixes: 6bffe88452db ("can: add protocol counter for AF_CAN sockets")
> Reported-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Closes: https://lore.kernel.org/linux-can/7e35b13f-bbc4-491e-9081-fb939e1b8df0@hartkopp.net/
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

