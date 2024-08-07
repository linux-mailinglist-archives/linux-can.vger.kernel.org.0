Return-Path: <linux-can+bounces-1157-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C001E949DE9
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2024 04:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1D861C2158D
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2024 02:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E20B18FDBA;
	Wed,  7 Aug 2024 02:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JB+rstZG"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272081392;
	Wed,  7 Aug 2024 02:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722998614; cv=none; b=rli6qPfxzPx6O/vvXwVH+mCeMYm+yiIsSLDShJH2UTSomlnent20bdgWyEXzXFGzCPlgNvrWfFSIPQHwV5tynrawZXc27kWlYvvXT26FYwy3Jp8mZRf6WVzOt/nTugBMoad3bC1x6HNAhDSbxsWwGpwl3MwlsyYGzvaa3m0BCig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722998614; c=relaxed/simple;
	bh=nDlo5YsTwypLXPuK657bOqRxOYhuMVutfPAuHxcOA/U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ux7h3ftYXTd+sCHutuncwhh0QU9NISyx9JAEJQylu/f+cKR9qltiuF/xYyo7Y5p1STqtz+C9tGVHxgRnbesdCslyRAuB95XbyQHdZD4y+oNHj69xE1ZURbJIXWw7j9H5lTI2r553DkahvwejPbg6nov0U1e7fwN6A6WWhydkvvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JB+rstZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C60C32786;
	Wed,  7 Aug 2024 02:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722998613;
	bh=nDlo5YsTwypLXPuK657bOqRxOYhuMVutfPAuHxcOA/U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JB+rstZG9TsTUQhnP8RwdTkrQWI2ZqN2tfRHKDO59w7AEF2hdJxyO2uiHrGBoiakU
	 2OC6uCguyE01aVl9SNrjKKU7trfxkm13KykF/botZA4RoN0M58B3xaMJebD9uf7zkL
	 HGke6GBPTje3vJPkmmaH8IAPqsLqAjfGFG+jfoBIQXd3lK7RWaqfofS1yNScfg2cKp
	 cERSEEGLQKayO/xm7EPsAyYw2A67GKFbygyxzKt71cJRKgBJv+UGKyHpUiALf/DhWF
	 QlURkeGk8kc9q/BB2n3P6DBB5uyFpfqfa3CT/JrNKekZEavr+APQ0WH37WO0NmlIiB
	 YiWyPjQUbAXmw==
Date: Tue, 6 Aug 2024 19:43:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org,
 kernel@pengutronix.de, Jimmy Assarsson <extja@kvaser.com>, Vincent Mailhol
 <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH net-next 19/20] can: kvaser_usb: Remove struct variables
 kvaser_usb_{ethtool,netdev}_ops
Message-ID: <20240806194332.28648126@kernel.org>
In-Reply-To: <20240806074731.1905378-20-mkl@pengutronix.de>
References: <20240806074731.1905378-1-mkl@pengutronix.de>
 <20240806074731.1905378-20-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Aug 2024 09:42:10 +0200 Marc Kleine-Budde wrote:
> From: Jimmy Assarsson <extja@kvaser.com>
> 
> Remove no longer used struct variables, kvaser_usb_ethtool_ops and
> kvaser_usb_netdev_ops.

The last three patches in this series should really be a single one.
I don't wanna make you redo the PR but it causes a transient warning
which prevents our CI from trusting this series and doing anything
beyond build testing on it.

