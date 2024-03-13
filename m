Return-Path: <linux-can+bounces-383-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 752DC87A8E3
	for <lists+linux-can@lfdr.de>; Wed, 13 Mar 2024 14:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B10AB2833E2
	for <lists+linux-can@lfdr.de>; Wed, 13 Mar 2024 13:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC9945BED;
	Wed, 13 Mar 2024 13:59:26 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AFF45C10
	for <linux-can@vger.kernel.org>; Wed, 13 Mar 2024 13:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338366; cv=none; b=pI+vJ4TyageXV9EN1VqLjhoebUgrfmx2xTq3K1/ti1V/ar+dH0HgWsd1LBUHXHgN1J9Okh4a8Tc7cYOlxsSp7I3j2o6muemanoHuSQx4cVZmhe+27DGG/SGYf1GGISVcCcipBjn4DTJ8rN43zsVuforFRaEl48cUbfh/6JmG7cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338366; c=relaxed/simple;
	bh=iPjtTXtGBNqqHtpmj/RD96a/h3FsCnTbifhUxkUft74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPhGRq8lk+uo0b+AdZadyPx469LlwJUSIOo8GbR7WWok/F2T88yDS9ajFPnz9bUQX6Gqam4xvJdIG6ZokE7yQG1LBZ7EaYfQ6mFW/1ajUF/4eM35wQ9LRaVEf7OlkjsrdZxsK/bPgYTRWRivTXcLqxudELR/ifpeS+5jneQuwCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rkP8Q-0000WY-Vx; Wed, 13 Mar 2024 14:59:11 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rkP8K-0067ui-OF; Wed, 13 Mar 2024 14:59:04 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rkP8K-00FZqY-26;
	Wed, 13 Mar 2024 14:59:04 +0100
Date: Wed, 13 Mar 2024 14:59:04 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: syzbot <syzbot+3bd970a1887812621b4c@syzkaller.appspotmail.com>
Cc: astrajoan@yahoo.com, davem@davemloft.net, edumazet@google.com,
	hdanton@sina.com, kernel@pengutronix.de, kuba@kernel.org,
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@rempel-privat.de, mkl@pengutronix.de, netdev@vger.kernel.org,
	pabeni@redhat.com, robin@protonic.nl, socketcan@hartkopp.net,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [can?] possible deadlock in j1939_sk_queue_drop_all
Message-ID: <ZfGxKE126E_INT_w@pengutronix.de>
References: <00000000000095640f05cb78af37@google.com>
 <0000000000002755ce061389d67b@google.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0000000000002755ce061389d67b@google.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

#syz fix: can: j1939: prevent deadlock by changing j1939_socks_lock to rwlock

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

