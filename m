Return-Path: <linux-can+bounces-3804-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DEEAD46FE
	for <lists+linux-can@lfdr.de>; Wed, 11 Jun 2025 01:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14CB97A9D46
	for <lists+linux-can@lfdr.de>; Tue, 10 Jun 2025 23:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AA6260594;
	Tue, 10 Jun 2025 23:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sr8+eREN"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC781E835D;
	Tue, 10 Jun 2025 23:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749599411; cv=none; b=vEiGrUXJd2tiwDPfdHCGQKafnuSr3w9Uvw/hO2+LeuIX8kHV2NOcSA8GHEQuX28c6ovYcplyyiklwFCMCFrmPZ1ZGWBFiOWo7x3S600uLTSp0Kzh2P6Erh/OfQ7CLVJBqn8H0p1tpNE9xHLsbCMxvfLCcZkZJjZwMEojpg73vv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749599411; c=relaxed/simple;
	bh=7uxJYXHlvEIGdvjZzhEej163ONKnwVPW164pDB3BENE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dudhTWsa90W13hRbPegCbQ7TCD5Rc2xjGfXjpaoGVPPkU0ZkXpMx5wbz/tqdaOl00JAvQ1UClQYe1tj/V3Zn1fN1ygbQFEOUQn0LA4RE5hD8klhVVBhM2lFt8dKm3rmZMwRmwSG5cwZqe/1w3/wl78l/+VkNjDJ0WkbV5cuGh9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sr8+eREN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670FDC4CEED;
	Tue, 10 Jun 2025 23:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749599410;
	bh=7uxJYXHlvEIGdvjZzhEej163ONKnwVPW164pDB3BENE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sr8+eRENJyqX5eDROFkluV07FIzzKEBdtwsDgnc9kNgi/Solu0HxooTjQqjbXAVb2
	 MnGTlMwFq+bh3sq4ywg2rdvLrH5jgRYQLbIawnbj85H8B+hrRn1uLoYK+XRwpak74m
	 1BCz1sx5bak4XA/W6juvuSIs8tSPplwX6DripNum4cVkChiaxZqOdusnwdeTPMlpad
	 PqhqkX8bnanJgWSWSS/cKzLWNcOlQyNHhAX4pa3yqYluKFzo4LPXrYTAQtKXgnGNfn
	 crym70KlUib74Niw2Muf1EqgKhzhO9/TAuefpI5UPt/dLVs2zeqZ++NeWhHaUqlOjt
	 QWJwHoqR0kqrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEBE38111E3;
	Tue, 10 Jun 2025 23:50:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/7] can: netlink: replace tabulation by space in
 assignment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174959944075.2737769.15070024166565059236.git-patchwork-notify@kernel.org>
Date: Tue, 10 Jun 2025 23:50:40 +0000
References: <20250610094933.1593081-2-mkl@pengutronix.de>
In-Reply-To: <20250610094933.1593081-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, mailhol.vincent@wanadoo.fr

Hello:

This series was applied to netdev/net-next.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Tue, 10 Jun 2025 11:46:16 +0200 you wrote:
> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> 
> commit cfd98c838cbe ("can: netlink: move '=' operators back to
> previous line (checkpatch fix)") inadvertently introduced a tabulation
> between the IFLA_CAN_DATA_BITTIMING_CONST array index and the equal
> sign.
> 
> [...]

Here is the summary with links:
  - [net-next,1/7] can: netlink: replace tabulation by space in assignment
    https://git.kernel.org/netdev/net-next/c/d08ad6c8613b
  - [net-next,2/7] can: bittiming: rename CAN_CTRLMODE_TDC_MASK into CAN_CTRLMODE_FD_TDC_MASK
    https://git.kernel.org/netdev/net-next/c/bee7e3322a28
  - [net-next,3/7] can: bittiming: rename can_tdc_is_enabled() into can_fd_tdc_is_enabled()
    https://git.kernel.org/netdev/net-next/c/23c0dc95bfa8
  - [net-next,4/7] can: netlink: can_changelink(): rename tdc_mask into fd_tdc_flag_provided
    https://git.kernel.org/netdev/net-next/c/527b99f44def
  - [net-next,5/7] documentation: networking: can: Document alloc_candev_mqs()
    (no matching commit)
  - [net-next,6/7] can: add drop reasons in the receive path of AF_CAN
    https://git.kernel.org/netdev/net-next/c/127c49624a09
  - [net-next,7/7] can: add drop reasons in CAN protocols receive path
    https://git.kernel.org/netdev/net-next/c/81807451c2a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



