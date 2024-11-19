Return-Path: <linux-can+bounces-2098-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 355ED9D1E86
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 04:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC6722836EE
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 03:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55803145A09;
	Tue, 19 Nov 2024 03:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5EGpenB"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7FE1A28C;
	Tue, 19 Nov 2024 03:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731985223; cv=none; b=prhFezcsspBSAaFNONd7plCxg5jTOeLjwOKjNDs857QSpOvdSRZ61VCnuARmEOEYXvSZJkoL9A+DhTJPuG4l4yN7bmFU7T2Pr4yirGdRRjKj1oE/KswCqULxEjPs43zA3iDdFwulX7DbdhUefG9q7cqegPG0YR4tsIQ3M4lTJcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731985223; c=relaxed/simple;
	bh=HRSm8FbXAddqPiftvjnkUJyUs2zRtISWFUZwjHfSjf8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I3trB6C7rv/FI40c0xxKD8wbe1ZWaYJtPaK3VJMTL5ZpPZw/wC5Zvheh1QWDyjJflZsFgN935/zx58rP/HFmkLQd240TorsVLGaf3zMTC0g/7+f5io9nO1OOD+VJ3QRRC/nkQ4Hh9srgc8C5FziKOrtjM5bjSdy/0LctCpWVTp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5EGpenB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BBBC4CED6;
	Tue, 19 Nov 2024 03:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731985222;
	bh=HRSm8FbXAddqPiftvjnkUJyUs2zRtISWFUZwjHfSjf8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p5EGpenB/+2G+Rezfd8J0qvOPxQjfa/O3CMCq+lXiMScq9+QIfXoOvhIROTJsnWKF
	 NGbLyYDzjFLDJt5jE3MdK0jKBg7uYr5adyKfnFOIe9QlRy0uqbZd4ZJS78z25wAAme
	 OEfLO/4aNZX67k+UNArDX+Y4p3hiv6yLV4BBIkHxqnNgWIdqg6llzloB2fWCvQWoya
	 tI2oioY0Kh1jWmgMYdKFzND/Tb+7e5wnc5IV+JwBbwXrk4rRX0OktLyVeFoY2ZTjGV
	 X1X5NKayAV+ZbJd7G2iIRJc8f0xQaN7UIxlMXkvLDGTOY7mcL8ZbxBaOx9PHdat8C7
	 zBT+LZXG5zZuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D673809A80;
	Tue, 19 Nov 2024 03:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: exclude can core,
 drivers and DT bindings from netdev ML
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173198523378.84991.13613749384566676729.git-patchwork-notify@kernel.org>
Date: Tue, 19 Nov 2024 03:00:33 +0000
References: <20241115195609.981049-1-kuba@kernel.org>
In-Reply-To: <20241115195609.981049-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, mailhol.vincent@wanadoo.fr, mkl@pengutronix.de,
 socketcan@hartkopp.net, linux-can@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 Nov 2024 11:56:09 -0800 you wrote:
> CAN networking and drivers are maintained by Marc, Oliver and Vincent.
> Marc sends us already pull requests with reviewed and validated code.
> Exclude the CAN patch postings from the netdev@ mailing list to lower
> the patch volume there.
> 
> Link: https://lore.kernel.org/20241113193709.395c18b0@kernel.org
> Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: exclude can core, drivers and DT bindings from netdev ML
    https://git.kernel.org/netdev/net/c/4262bacb748f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



