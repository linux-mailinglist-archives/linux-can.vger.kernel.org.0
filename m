Return-Path: <linux-can+bounces-5290-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E709C21611
	for <lists+linux-can@lfdr.de>; Thu, 30 Oct 2025 18:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAF2E4EF31C
	for <lists+linux-can@lfdr.de>; Thu, 30 Oct 2025 17:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A32E366FC6;
	Thu, 30 Oct 2025 17:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MjStNRD8"
X-Original-To: linux-can@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936391DE8AF
	for <linux-can@vger.kernel.org>; Thu, 30 Oct 2025 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843920; cv=none; b=ir2OHMSnJobVEdN7XWqSx5ZAKFk5mzBz1ovrZpsbjdmSTLZ1QMAys8GDl+wNQqrou1QLM2Q1r5AEU/gr11pFkt7MDdi/jsLrEJyuhRSo3ip6A1C2YP05IAzdQY4+DDG4Sk+BB5UuSh/IgDPu+rys5EIxz2N/xsmAyHZhXqRYYtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843920; c=relaxed/simple;
	bh=8lWtldHLyzk7eRvcHyn73JYzwTGqrFwL998v54w/xGI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VMMgahVkdcVt2aUtDhshf3Py1xL9Rh158jvhe8WXXwdX8iK/8aC5NBx9Up1Lomp3q9dxJ6S94O6ZJhXIVGjqzWqSqrXWdzLazC8Gz4XGRuKDoKH7x53k5k59NbT8S8V9T6C2dlqSGbOehDD5DCqc9RxOACCBDlKIZHbVPKSWSU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MjStNRD8; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D791C4E413FD;
	Thu, 30 Oct 2025 17:05:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AE08B60331;
	Thu, 30 Oct 2025 17:05:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D8A8511808CCF;
	Thu, 30 Oct 2025 18:05:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761843914; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8lWtldHLyzk7eRvcHyn73JYzwTGqrFwL998v54w/xGI=;
	b=MjStNRD8PYvrsR+XWDlnZdrt/RgQTMEfpmVxVjml6TZS19NgRGKuq9nHohwN5vojzfeN4w
	0oAM6cZdwIbAQZBIlbUBmwzJDqnOc916dZ0E1nlMzpnQNRNvxUHm9K9O6d3DyuvXdw+214
	d2H28iYL4nue5dU1TGc0Q18cRy5v00BOjMhAsp3gE++gEM5ErQplyH6Mb0CFxLfZBy1gOW
	UPn0smFQ83j4q82yVqK2OtfktCCya+x24zn1b4VuqFbAPUQu5fBoSNMi54QtqM+lb93YN7
	s6bT/U20m+TLZpqta5EwJC+FGYkO5uQy0m0W/4rUd0lcbxHjlIDBw2PMpEgfpQ==
Date: Thu, 30 Oct 2025 18:05:11 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
 <mailhol@kernel.org>, Stefan =?UTF-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>,
 socketcan@esd.eu, Manivannan Sadhasivam <mani@kernel.org>, Thomas Kopp
 <thomas.kopp@microchip.com>, Oliver Hartkopp <socketcan@hartkopp.net>,
 Jimmy Assarsson <extja@kvaser.com>, Axel Forsman <axfo@kvaser.com>,
 linux-can@vger.kernel.org, netdev@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Jacob Keller
 <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next 3/3] can: peak_usb: convert to use ndo_hwtstamp
 callbacks
Message-ID: <20251030180511.13d6d4e8@kmaincent-XPS-13-7390>
In-Reply-To: <20251029231620.1135640-4-vadim.fedorenko@linux.dev>
References: <20251029231620.1135640-1-vadim.fedorenko@linux.dev>
	<20251029231620.1135640-4-vadim.fedorenko@linux.dev>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 29 Oct 2025 23:16:20 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> Convert driver to use ndo_hwtstamp_set()/ndo_hwtstamp_get() callbacks.
> ndo_eth_ioctl handler does nothing after conversion - remove it.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

