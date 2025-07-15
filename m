Return-Path: <linux-can+bounces-4003-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3E9B069BD
	for <lists+linux-can@lfdr.de>; Wed, 16 Jul 2025 01:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66171AA76C5
	for <lists+linux-can@lfdr.de>; Tue, 15 Jul 2025 23:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88662D0C62;
	Tue, 15 Jul 2025 23:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJW5H80o"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDD82BF3DB;
	Tue, 15 Jul 2025 23:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752620987; cv=none; b=WX8WATmHzQphOTUmCXTaOFU5mwCbEh1e/S71CvsNRkjZAjKJCQp9gxQstki971NdK6J5wOZ15w0n5CuacUwULlz+aDir0GkLAuFZIlTMmylm/H5BLTkivTZnAQ671+okARoRunTJAqfJC3e9vK3TEco8mIqsJCdPcuSfDo2e9JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752620987; c=relaxed/simple;
	bh=2RFYljIrtzF6EA9y3KeXlKkjmLPiGbpidXPF+wUUDpg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qmb6l4OrmVJ3q832wVj+OUzzB1EsvmICfARwnnAqxdTVtqfR6oY1lxoALSZRo0mjaXMnVbXOfJnc44XDYOxy2o9ZnZuW/S3f3TR6hM+6c6sTtxJgwKxPXkr4q2RMb9fc1iKGu7nqzEeFi0jdzKXOlisx+mozF0ThgSOc+mzkBOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJW5H80o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA2DC4CEE3;
	Tue, 15 Jul 2025 23:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752620987;
	bh=2RFYljIrtzF6EA9y3KeXlKkjmLPiGbpidXPF+wUUDpg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sJW5H80oH7xJFyW4Ir4MByxiIwqMpWTmrgPkeR7pjh3LzNJGWA3SeaG9qGMQMYpyQ
	 3cUqBGrJupgncZGUSznbujk/rGUX7HBw2KskEZyNkbW+KM5agOmwrGtUP7R4EMq5Fp
	 dtDZifgV6YM7l1xzkzLCQykQe8QoPCFZjBTXf1iGNsy0hjsYYpZg7fRV7L+ct5cJpF
	 5MrQcMGAcLT78c87zI+lyjIDb8YpvvbkTcyZrbqz04WzjW/2Z1qwAmZNI4lknT67/v
	 Ig/vpEhBFW6l0WOq/HY8bOI4g4tm+/GmkSFd9hPr2wQESwIvEJXk6t2dBGdEopSc4c
	 /S3yQOzcZbDQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEEB383BA30;
	Tue, 15 Jul 2025 23:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] can: tcan4x5x: fix reset gpio usage during probe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175262100776.609531.9996914746793816320.git-patchwork-notify@kernel.org>
Date: Tue, 15 Jul 2025 23:10:07 +0000
References: <20250715101625.3202690-2-mkl@pengutronix.de>
In-Reply-To: <20250715101625.3202690-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, brett.werling@garmin.com,
 msp@baylibre.com

Hello:

This patch was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Tue, 15 Jul 2025 12:13:39 +0200 you wrote:
> From: Brett Werling <brett.werling@garmin.com>
> 
> Fixes reset GPIO usage during probe by ensuring we retrieve the GPIO and
> take the device out of reset (if it defaults to being in reset) before
> we attempt to communicate with the device. This is achieved by moving
> the call to tcan4x5x_get_gpios() before tcan4x5x_find_version() and
> avoiding any device communication while getting the GPIOs. Once we
> determine the version, we can then take the knowledge of which GPIOs we
> obtained and use it to decide whether we need to disable the wake or
> state pin functions within the device.
> 
> [...]

Here is the summary with links:
  - [net] can: tcan4x5x: fix reset gpio usage during probe
    https://git.kernel.org/netdev/net/c/0f97a7588db7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



