Return-Path: <linux-can+bounces-5790-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74860C94A57
	for <lists+linux-can@lfdr.de>; Sun, 30 Nov 2025 02:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1885A3A1E82
	for <lists+linux-can@lfdr.de>; Sun, 30 Nov 2025 01:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F9D2153D8;
	Sun, 30 Nov 2025 01:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+aYmnJE"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D113B2A0;
	Sun, 30 Nov 2025 01:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764467585; cv=none; b=f00wDDEAd6i6W9fItXY8DlIgJ3KQJ+XwISwOJMO28xV+VgbIou0cUQ8PgSqyN2SIf4Poj3d53yUtec9UHuhAO/AV29e1cnV277GnmartqK/1BOTygd72AcmpQwxylhyUXW9UNy9Tln0GB9KJa1bQ9NyMfcjXpwJ552xkJRuG4pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764467585; c=relaxed/simple;
	bh=97QLNmAtJNGNwtkr5WeLOLnH7LV0rO4IDCqQcz2p7Bg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L4VkuFSNC9Siy9nDmAOGOIHUS7XsdtfOE8fEBVpmqcxv0ZEs6avDwaSiQCK4C58XHY0EzdK20zFwZyu79JtaiBlHFpmwN9hdPXLu7D5kMXebtpvlqv1ICTAVuBmEyPtf7DvU8BaggsJta1SjKvqwZnk/cOwugVbp8T2r9yahVSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+aYmnJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E88C4CEF7;
	Sun, 30 Nov 2025 01:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764467585;
	bh=97QLNmAtJNGNwtkr5WeLOLnH7LV0rO4IDCqQcz2p7Bg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u+aYmnJEwtlx6y2b7afzqqA29wJc2jeYFrxz2evhWN+bAizIZIIEmmPAamuEsN/Vf
	 /umIoMSZdAFKNFvP0RnD7mTFobcYgAmHONKOW9571MHU44MkLa637wQka9hV5ccZnR
	 bS+irjyBoM45X7xELSrHeU2+n7JeEFlIHHJ01WBmq+IPQ5tUZB/ISy2U+xZ9Qa3pIA
	 5SW2AZW0V8PjTyhXQV5JvtWCw4EKY6rBF8D8rSX4kMORisPDsxf2Wpve6j1wnpD9Yn
	 YBK0XniLcAeUpzKRMw0nKrZnprulyPPeDRmAQbeix2oJm9s0lJLwD99MAruYEyE0Az
	 wT1VzU+Ahq4mA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B7673806936;
	Sun, 30 Nov 2025 01:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] can: Kconfig: select CAN driver infrastructure
 by
 default
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176446740605.1148447.5623807742098177728.git-patchwork-notify@kernel.org>
Date: Sun, 30 Nov 2025 01:50:06 +0000
References: <20251129125036.467177-2-mkl@pengutronix.de>
In-Reply-To: <20251129125036.467177-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, socketcan@hartkopp.net,
 mailhol@kernel.org, lkp@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Sat, 29 Nov 2025 13:47:19 +0100 you wrote:
> From: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> The CAN bus support enabled with CONFIG_CAN provides a socket-based
> access to CAN interfaces. With the introduction of the latest CAN protocol
> CAN XL additional configuration status information needs to be exposed to
> the network layer than formerly provided by standard Linux network drivers.
> 
> [...]

Here is the summary with links:
  - [net-next] can: Kconfig: select CAN driver infrastructure by default
    https://git.kernel.org/netdev/net-next/c/cb2dc6d2869a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



