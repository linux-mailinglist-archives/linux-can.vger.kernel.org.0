Return-Path: <linux-can+bounces-1502-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B3E978D51
	for <lists+linux-can@lfdr.de>; Sat, 14 Sep 2024 06:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4327B1C22A6A
	for <lists+linux-can@lfdr.de>; Sat, 14 Sep 2024 04:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5D222071;
	Sat, 14 Sep 2024 04:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEOgavwY"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322E62107;
	Sat, 14 Sep 2024 04:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726288231; cv=none; b=NDD9NKHypH4saE+BtDj7S+Jh2xpoiAUmQRlH4O/8DuAlH+Go73t7BrJjMBcibXmsJtbfPGahTCfxcmfDTtPNiuqAE7Ppu+bXugTaeyWzfdxtflbOrfdZHKhsboqtOC/mZAjhHYht6gCeqfgWvCtsfKD+XG3EtyPKAUEg31Wskyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726288231; c=relaxed/simple;
	bh=mKKpup0F8bYOHaU2B17Z7QWik4+OUEerDwpFlkhJ+uk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ntU4DTHNIE1O2u74TCNvThq48wyNRVeZq/Q6Iw4hNlGorvh2NDWiM8+itpeOzojKT1gOjRMtjjDpwB01JAwABhnJlHiwP6AMfaG+ORuYJoHukNSDVYuuplXyV4KoAB6M8Pie03dvcRdU/ySJaGNHDs5lHLF1FVl12MNlVp0/IYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEOgavwY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26EEC4CEC4;
	Sat, 14 Sep 2024 04:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726288230;
	bh=mKKpup0F8bYOHaU2B17Z7QWik4+OUEerDwpFlkhJ+uk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cEOgavwYaI+Pdnt2apTzgnt0ohI7vG4aAvvexEuJmyP2YqHriV4xNODq6TM6jKHLE
	 6Ks9gsTLLKkCxzHTsFEK2HvCO+xADaD1ka08S0MbrAFOYv9XASZNE3r6CvVNtDxihT
	 OPBKN+w/Bx3AQW9NoP/5sEjabza7mxbLk56KUdHGq+gV1BgWfauelCWzfojan26cGa
	 YLfPIaA6cQI7TbviKWJ5+aez0hHg++BwhypTOyP4AYFwFAl47ZLHve+C5q4uqxRIVH
	 KAw84rMlb/G4uWTNHWvj5uV/QRHy6XL5Iw/TTJrL+L7yUUYD3UNVxbb79DtxoErPWf
	 esarRir0z9ovg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A4F3806655;
	Sat, 14 Sep 2024 04:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 4/5] can: m_can: enable NAPI before enabling interrupts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172628823175.2458848.13017470475266203453.git-patchwork-notify@kernel.org>
Date: Sat, 14 Sep 2024 04:30:31 +0000
References: <20240912075804.2825408-5-mkl@pengutronix.de>
In-Reply-To: <20240912075804.2825408-5-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, Jake.Hamby@Teledyne.com

Hello:

This patch was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Thu, 12 Sep 2024 09:50:53 +0200 you wrote:
> From: Jake Hamby <Jake.Hamby@Teledyne.com>
> 
> If an interrupt (RX-complete or error flag) is set when bringing up
> the CAN device, e.g. due to CAN bus traffic before initializing the
> device, when m_can_start() is called and interrupts are enabled,
> m_can_isr() is called immediately, which disables all CAN interrupts
> and calls napi_schedule().
> 
> [...]

Here is the summary with links:
  - [net,4/5] can: m_can: enable NAPI before enabling interrupts
    https://git.kernel.org/netdev/net/c/801ad2f87b0c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



