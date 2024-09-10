Return-Path: <linux-can+bounces-1456-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D97C197261F
	for <lists+linux-can@lfdr.de>; Tue, 10 Sep 2024 02:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65791B22B29
	for <lists+linux-can@lfdr.de>; Tue, 10 Sep 2024 00:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CB11CD29;
	Tue, 10 Sep 2024 00:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnWE0ZYW"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4935079D2;
	Tue, 10 Sep 2024 00:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725927641; cv=none; b=s1oOd0ZwEkc/RY2wHV/SLhBpIMtSydHbIZeelVC0lWb1kAWeOgDK9c8VwhMUj/5nna+y2ze3RvESM9N5ouK9q9DeTeuU/0wryMT3Z+FW/7y2Bcm1MSAnohEur39Q54rW9x9Uxh+GdL1wYEyr0+5DnoylQIEYlKSeViKAO1O8K4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725927641; c=relaxed/simple;
	bh=8YaZJftXQlJLKZQTe7GdEkgZEqnn9cYslRF0n3XgHSc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fUBr5m8RZCUMJPD8X3KBLgBJK9NoeihIlr1kdB3EgRHkrdsXyTDeoWdpHhNqExAJAfwvvVkySgpf+ha63zdOfD8u4EGSQSpdquSVpLvZAd+pMlSHlUfIQmWJnL0ZcvgJSKB7ZNjlGXDqqjGIiwoJOCTLGfw2cFHuy3G7syiSMqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnWE0ZYW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B443BC4CEC5;
	Tue, 10 Sep 2024 00:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725927640;
	bh=8YaZJftXQlJLKZQTe7GdEkgZEqnn9cYslRF0n3XgHSc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fnWE0ZYWvJISixlTkdJwpGCZvhPTzoRDHVjgIcEzAWj15lT5Pu6+xLfLgjDT6tC0W
	 Hyh5n8Ju9DwZ64QVjLnTrMpQWCWA6ohaaumrgPAIXQsJQ5GidNTbMeuN3f0nA5+lzj
	 Un1v54UHGPN5uqfyrf0iGtdyjLCl+M09R6un5uzJbI2VS8e9RY1eOhVyCDVAwRvZTq
	 vWxNdsoNwd/6AGqpwTfxrdCTrzuzvD31dDA1IugS3Puoy7Je5bjQAy2NsIYtlw7wcK
	 62Jlpug6WGN7yuIAt7OqwYYmxf4dUqSd/ymLoIMR6i1dgE4euveLtTCJPutZHO9UGa
	 RsCpk8PRgMPVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD863806654;
	Tue, 10 Sep 2024 00:20:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/3] net: can: cc770: Simplify parsing DT properties
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172592764178.3964840.7976503474349657993.git-patchwork-notify@kernel.org>
Date: Tue, 10 Sep 2024 00:20:41 +0000
References: <20240909063657.2287493-2-mkl@pengutronix.de>
In-Reply-To: <20240909063657.2287493-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, robh@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Mon,  9 Sep 2024 08:33:53 +0200 you wrote:
> From: "Rob Herring (Arm)" <robh@kernel.org>
> 
> Use of the typed property accessors is preferred over of_get_property().
> The existing code doesn't work on little endian systems either. Replace
> the of_get_property() calls with of_property_read_bool() and
> of_property_read_u32().
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: can: cc770: Simplify parsing DT properties
    (no matching commit)
  - [net-next,2/3] can: rockchip_canfd: fix return type of rkcanfd_start_xmit()
    https://git.kernel.org/netdev/net-next/c/9a0e4c18cdec
  - [net-next,3/3] can: rockchip_canfd: rkcanfd_timestamp_init(): fix 64 bit division on 32 bit platforms
    https://git.kernel.org/netdev/net-next/c/9c100bc3ec13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



