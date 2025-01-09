Return-Path: <linux-can+bounces-2564-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44434A0758C
	for <lists+linux-can@lfdr.de>; Thu,  9 Jan 2025 13:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496BE1631A2
	for <lists+linux-can@lfdr.de>; Thu,  9 Jan 2025 12:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478E5216E20;
	Thu,  9 Jan 2025 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBTDpivS"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDCB20551B;
	Thu,  9 Jan 2025 12:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736425211; cv=none; b=YycPtU3d2QoUCBx+EGW5366YAD+Erv2zIN76XieugzLe8iaGdfACqp2MnfZ3Gpply2/Q7nmzjZ1FWQ6N5JH86uR5x+QySjGSTWQlKkvVF6NfJj4Vqzd0lnML/iLKwvz7XVou0Q+WBfM7jS7MYBhqALhgCoog1euJJdSQVhcRTPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736425211; c=relaxed/simple;
	bh=1y+/0y5Mn+3mmY+Rqdubf97qrdL5lDWfwQl+N0okVJU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PTyB+AcmlnwT9fUBunqe7qDx7xb17YJDNwuxxIEcMULg3L5s+1+UgHt8LYFm+xXeGDVNWxloN2+Dd8ztESv4r0wvLvuUCcqZjgQcgaB0++9+BB2EjYHEgrlBK6sCY+gr73WhRfYxgsQAaJ5eFXiE/G13HQzIoGHLZ1jJhnrp4UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBTDpivS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED65C4CED2;
	Thu,  9 Jan 2025 12:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736425210;
	bh=1y+/0y5Mn+3mmY+Rqdubf97qrdL5lDWfwQl+N0okVJU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bBTDpivSMWuijJnQh3u2XfH9P2b2E4ReENVkg276ScYNV8Ss+42DNVlNmjVmLQUr3
	 apQ2/amP9GMMjCFtqCT61NPIdITDXPY3uOrt3IiBSUrkpuAmcy0AvW1rEVOc+6oMLA
	 ML6onBd5rB0YzWtEyB5mMrqlq8WiKRlUfKdxN3y4+Ll6leBYD0RWQQi4rH3o/LhEJI
	 RjkHYtHLgkgOIxn7mk1Zv5WdZ9OkR/GN+tYej1kiYzelwtXhPIVn3q7RGwH5N3NfTl
	 5UJfKT0FaCYrZQ6CwtVlUj2LKCfvg1L7TLY0H/xKpSbZ3vOqp+CKpUsu6+e7STHpdg
	 6GZHN7Aa/zmTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DFA3805DB2;
	Thu,  9 Jan 2025 12:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dt-bindings: net: Correct indentation and style in
 DTS example
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173642523202.1303894.12707902460357622367.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jan 2025 12:20:32 +0000
References: <20250107125613.211478-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250107125613.211478-1-krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, neil.armstrong@linaro.org, khilman@baylibre.com,
 jbrunet@baylibre.com, martin.blumenstingl@googlemail.com, opendmb@gmail.com,
 florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 rjui@broadcom.com, sbranden@broadcom.com, mkl@pengutronix.de,
 mailhol.vincent@wanadoo.fr, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, kvalo@kernel.org, o.rempel@pengutronix.de,
 dariobin@libero.it, christophe.roullier@foss.st.com,
 grygorii.strashko@ti.com, s-vadapalli@ti.com, rogerq@kernel.org,
 briannorris@chromium.org, Frank.Li@nxp.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-wireless@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  7 Jan 2025 13:56:13 +0100 you wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces and
> aligned with opening '- |', so correct any differences like 3-spaces or
> mixtures 2- and 4-spaces in one binding.
> 
> No functional changes here, but saves some comments during reviews of
> new patches built on existing code.
> 
> [...]

Here is the summary with links:
  - [net-next] dt-bindings: net: Correct indentation and style in DTS example
    https://git.kernel.org/netdev/net-next/c/9d8c354a56e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



