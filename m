Return-Path: <linux-can+bounces-7628-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0G4CI7z1BWpVdwIAu9opvQ
	(envelope-from <linux-can+bounces-7628-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 14 May 2026 18:18:04 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DB55448BA
	for <lists+linux-can@lfdr.de>; Thu, 14 May 2026 18:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 772DF3001FA1
	for <lists+linux-can@lfdr.de>; Thu, 14 May 2026 16:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17483314B96;
	Thu, 14 May 2026 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wfu6b5wa"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E852A223707;
	Thu, 14 May 2026 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778775479; cv=none; b=kXHrwJl3CGE0TrVJnz5iczgWRZ3qicmXS8IkId3rYLvkzJv1iC5U1fOFM3LWfpOqhNoShrTS/+FGkV3l7qlP+7r5Kymzz76Lu20aAbRTGarseGUNRLRvNQ5rgciF7iGuIWlXrunnF22naKiu3sPyve0NaU3uWGIsFwCNIF7fU40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778775479; c=relaxed/simple;
	bh=TLFuTPlEnspC4JO4RferxyIFfsNZM2YPrOrM7JZIa1s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FYKexC43w7jxUXOT2qJnbiYJxL804tiWpNc4enaZcmHbFmmUxt2BYNTP6rCMJNEqfKYTpUScaCx/RczmKQGRdmNeeGw0g9pJnwNmS5GKr6OsFniRRnK47f31aUKLoCVDOKvUqHEVvHd5567tIjZSuFZ8DL/VE0tB5yesO3XuTYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wfu6b5wa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A0FC2BCB3;
	Thu, 14 May 2026 16:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778775478;
	bh=TLFuTPlEnspC4JO4RferxyIFfsNZM2YPrOrM7JZIa1s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Wfu6b5wacOfbZ9MxpwH1DxxBTeGz1/rZ3W/JOP2cYiBMZpvG26bmYfKGerZ0II+W0
	 Mj0wC1imKC2W5I7mDFLwHM2TmfFKlJkJqatdPsc4c7G7j141hLD64jvNCwCA5IF8id
	 3CxKwsJJK/ALkd+CPcHtSi4+Os4ouMEOw5saZDOdRlGDVRQqAa5/1nJO0s1rHlc1Jz
	 9lKEJaAPVvLWnkwN0pwvUU8zhg6DyYmmkHDelqRV55mP6BB6UojAc/OTomPJqAdcZf
	 k/exmQe5JRoB+VWEluoLc7ZfXpiBAsbslR6HPCptkz7osjmLN0KiHbagSR/gWeaAIJ
	 6N8Wi1FiX3LyQ==
From: Vinod Koul <vkoul@kernel.org>
To: Peng Fan <peng.fan@nxp.com>, linux-can@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Josua Mayer <josua@solid-run.com>, Ulf Hansson <ulfh@kernel.org>
In-Reply-To: <20260513220336.369628-1-andriy.shevchenko@linux.intel.com>
References: <20260513220336.369628-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 0/6] phy: phy-can-transceiver: Ad-hoc cleanups and
 refactoring
Message-Id: <177877547531.1092446.6935849511482361375.b4-ty@kernel.org>
Date: Thu, 14 May 2026 21:47:55 +0530
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: 84DB55448BA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7628-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On Thu, 14 May 2026 00:01:25 +0200, Andy Shevchenko wrote:
> The driver does two things that need to be addressed:
> - includes subject to remove gpio.h
> - checks for error code from device property APIs when it can be done in
>   a robust way
> 
> This series addresses the above and adds a couple of additional refactoring.
> 
> [...]

Applied, thanks!

[1/6] phy: phy-can-transceiver: Check driver match and driver data against NULL
      commit: ebee9004cc0200b2b708ebf7ac625d35c71c049f
[2/6] phy: phy-can-transceiver: use device_get_match_data()
      commit: 23db9fd578ca3b446ceaa5c9a0157f0838f4df4e
[3/6] phy: phy-can-transceiver: Move OF ID table closer to their user
      commit: 62455f6be1256084cfff8690df416f418b6f0dd2
[4/6] phy: phy-can-transceiver: Don't check for specific errors when parsing properties
      commit: 79a5274fb39904f8a60bdd7bf7753ee1ba700210
[5/6] phy: phy-can-transceiver: Decouple assignment and definition in probe
      commit: 05c72fbff4ac18e9bbb0e4b3884dad1f833807f4
[6/6] phy: phy-can-transceiver: Drop unused include
      commit: 52ae64602394bc9a8e7b67f5e4e70c56e31699a7

Best regards,
-- 
~Vinod



