Return-Path: <linux-can+bounces-1725-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D539C9ACE76
	for <lists+linux-can@lfdr.de>; Wed, 23 Oct 2024 17:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96BCC282EE4
	for <lists+linux-can@lfdr.de>; Wed, 23 Oct 2024 15:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ACA1B4F13;
	Wed, 23 Oct 2024 15:18:16 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A48719DF53
	for <linux-can@vger.kernel.org>; Wed, 23 Oct 2024 15:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696696; cv=none; b=ngFANKum/HbbgkUbX1wGW0GkKGlgOQKy5nKM57tmwKnlgXsj/a26FqMgZPCs9KC+s1giVSRmniOi3QEy57NZVNOgsIngJ6YhhHZrDXxt4ugq+qtO7nSuTKNXogbub/3K6X1/AlW4Rh1YSjlgBEuvpLFc/c3EJxsk+bCQqhrwC48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696696; c=relaxed/simple;
	bh=v7/brf8hVH7OvHi0gnT+UZZAS8EhAovaZfkhsi86/10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nv3YMCT2Ni6EH9Hp7JSkT+w8qyPU0pe9NIDKX01lCUbQE2XWFf64/8mTHvmSEtTRODNfDdDI9bNfm+Gvcxjn8H973svgndJBq/mgHYhKxsCCl5Omc6ju6u37MlzObASv4yvtDsF3R0KPOdR5NuCdEdOmz3raxKSpYQmLgNPBElE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1t3d7S-00076P-BU; Wed, 23 Oct 2024 17:17:54 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t3d7R-0003QW-06;
	Wed, 23 Oct 2024 17:17:53 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t3d7Q-002gvC-35;
	Wed, 23 Oct 2024 17:17:52 +0200
Date: Wed, 23 Oct 2024 17:17:52 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Alexander =?utf-8?B?SMO2bHps?= <alexander.hoelzl@gmx.net>
Cc: robin@protonic.nl, socketcan@hartkopp.net, mkl@pengutronix.de,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, corbet@lwn.net, kernel@pengutronix.de,
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de
Subject: Re: [PATCH] Fix error in J1939 documentation.
Message-ID: <ZxkToLEe27qozEpl@pengutronix.de>
References: <20241023145257.82709-1-alexander.hoelzl@gmx.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241023145257.82709-1-alexander.hoelzl@gmx.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

On Wed, Oct 23, 2024 at 04:52:57PM +0200, Alexander Hölzl wrote:
> The description of PDU1 format usage mistakenly referred to PDU2 format.
>
> Signed-off-by: Alexander Hölzl <alexander.hoelzl@gmx.net>

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!

