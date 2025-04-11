Return-Path: <linux-can+bounces-3392-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5074CA85C90
	for <lists+linux-can@lfdr.de>; Fri, 11 Apr 2025 14:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A78447B88BB
	for <lists+linux-can@lfdr.de>; Fri, 11 Apr 2025 12:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618FF29AB0D;
	Fri, 11 Apr 2025 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWN2NuBd"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A8729AB04;
	Fri, 11 Apr 2025 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744373425; cv=none; b=Erq1e1WmQWVEF9XVrqQN0DgYrGaF5ZjbNkuDoOKO1FfMCekPOj96N9nh0p6Js3HL5HkxVTNXyM1Ddnx0jfWtAgcWU7MeJAbDEpffD/jmL7KBJw9oQFHYKsGXrfpY3kv8ylCS8LOZ+0dXuIo4C+u58oi+RNveghlm2quApFXBDJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744373425; c=relaxed/simple;
	bh=qXkPvfz3L7QpP8yVqLZ0PU/tFO/qVu8LhU3z4fOHiro=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZYxCVDggfUoY9a7JoBSTMAntEjstJymYvB5CWDsLtqzPVIc3z6laR1hi1PWVK+De8A/Z06hUgeItsa4vZnoqRN1KhH/Jyx2CYX9JyShfO0rv3EAD7Bq3bZM/eSgVCLWo2xh2T7jS8Bu3XcceVxLKehyhAxxjEb+33K2H94KpbYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWN2NuBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757CDC4CEE2;
	Fri, 11 Apr 2025 12:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744373424;
	bh=qXkPvfz3L7QpP8yVqLZ0PU/tFO/qVu8LhU3z4fOHiro=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TWN2NuBdVDDlw3kPSmU0YMURJZS1GCuKN7uiC7/aztJz0NLViIJIOmRq1+ficTjXL
	 bY+9dTyD5rvl1zPjLrS3+qqlQNFcqO1DMIqo6fqeU/pfYn/n4LYXAXteAnndXFtspL
	 d5s/7ZEBGSJjpb7nCCa1j3K+RDa6zDRbnU6z+MWORYiyzXLsMKYEko4tPJXmgorYMR
	 TMT/lXOP25xwZL6QUZX/c0aycsGcV9eCPdvqmtW37FnPHz/3cd1T8hZZjL4AdOowAv
	 exwd8vw0fz4J/e4iMp/tuNfiNckeOhdC/exsKeFDDKF/9Erkol7OCvZVFbsve/VJOD
	 ajDbGi0+0n/7w==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Peter Rosin <peda@axentia.se>, 
 Aswath Govindraju <a-govindraju@ti.com>, 
 Biju Das <biju.das.jz@bp.renesas.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <3d7e0d723908284e8cf06ad1f7950c03173178f3.1742483710.git.geert+renesas@glider.be>
References: <3d7e0d723908284e8cf06ad1f7950c03173178f3.1742483710.git.geert+renesas@glider.be>
Subject: Re: [PATCH v2] phy: can-transceiver: Re-instate "mux-states"
 property presence check
Message-Id: <174437342110.673813.5478003699967879937.b4-ty@kernel.org>
Date: Fri, 11 Apr 2025 17:40:21 +0530
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 20 Mar 2025 16:15:42 +0100, Geert Uytterhoeven wrote:
> On the Renesas Gray Hawk Single development board:
> 
>     can-transceiver-phy can-phy0: /can-phy0: failed to get mux-state (0)
> 
> "mux-states" is an optional property for CAN transceivers.  However,
> mux_get() always prints an error message in case of an error, including
> when the property is not present, confusing the user.
> 
> [...]

Applied, thanks!

[1/1] phy: can-transceiver: Re-instate "mux-states" property presence check
      commit: e153fdea9db04dd0e2e536e2eb125b16bbbc2af7

Best regards,
-- 
~Vinod



