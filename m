Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC8875A175
	for <lists+linux-can@lfdr.de>; Thu, 20 Jul 2023 00:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjGSWKr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 19 Jul 2023 18:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjGSWKq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 19 Jul 2023 18:10:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2B62127
        for <linux-can@vger.kernel.org>; Wed, 19 Jul 2023 15:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DCB26185C
        for <linux-can@vger.kernel.org>; Wed, 19 Jul 2023 22:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF889C433CA;
        Wed, 19 Jul 2023 22:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689804622;
        bh=b1Jh+2XWSDzNJT1cGWQC4NXYhXR0setBy5OkZNgNgSA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Dkxhs9vj0EWDD0LZRlsIKi1wEV6JThp3Zoy8OtothRy9C//hjSWN33fasI791DnNw
         wMRjZkDmkpuy80IZ9TLgTbhYfJwE+pFQaoJ8EeTcT6NV/GvMFJeYdB4CZ5G9YCWdiN
         KacRcGf7KSFKH79xfprZw8HCHqfUoZ+0itIpb0BR4EQENPzPRYVbYIGgLqSCDyil2Z
         hKdvvarLJyNvosI52QiE4zBt9NQazwYjTsnv3uNqazuar3wBGxDo5tfJ/cAOF7kEOR
         WUWECn7A1eozhOxsoee7dyCeaxNlqMriZV/Z65Hc+k6DoFrD1076w7HzxndzxgpVdT
         Vh7lAujNYNvjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BF686C6445A;
        Wed, 19 Jul 2023 22:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/8] dt-bindings: net: can: Remove interrupt
 properties for MCAN
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168980462277.30545.412966680711424216.git-patchwork-notify@kernel.org>
Date:   Wed, 19 Jul 2023 22:10:22 +0000
References: <20230719072348.525039-2-mkl@pengutronix.de>
In-Reply-To: <20230719072348.525039-2-mkl@pengutronix.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-can@vger.kernel.org, kernel@pengutronix.de, jm@ti.com,
        tony@atomide.com, conor.dooley@microchip.com,
        krzysztof.kozlowski@linaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Wed, 19 Jul 2023 09:23:41 +0200 you wrote:
> From: Judith Mendez <jm@ti.com>
> 
> On AM62x SoC, MCANs on MCU domain do not have hardware interrupt
> routed to A53 Linux, instead they will use software interrupt by
> timer polling.
> 
> To enable timer polling method, interrupts should be
> optional so remove interrupts property from required section and
> add an example for MCAN node with timer polling enabled.
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] dt-bindings: net: can: Remove interrupt properties for MCAN
    https://git.kernel.org/netdev/net-next/c/bb410c03b999
  - [net-next,2/8] can: m_can: Add hrtimer to generate software interrupt
    https://git.kernel.org/netdev/net-next/c/b382380c0d2d
  - [net-next,3/8] dt-bindings: can: xilinx_can: Add reset description
    https://git.kernel.org/netdev/net-next/c/62bd0232d745
  - [net-next,4/8] can: xilinx_can: Add support for controller reset
    https://git.kernel.org/netdev/net-next/c/25000fc785b4
  - [net-next,5/8] can: Explicitly include correct DT includes
    https://git.kernel.org/netdev/net-next/c/22d8e8d6338d
  - [net-next,6/8] can: kvaser_pciefd: Move hardware specific constants and functions into a driver_data struct
    https://git.kernel.org/netdev/net-next/c/c2ad812956ae
  - [net-next,7/8] can: kvaser_pciefd: Add support for new Kvaser pciefd devices
    https://git.kernel.org/netdev/net-next/c/f33ad6776b2f
  - [net-next,8/8] can: ucan: Remove repeated word
    https://git.kernel.org/netdev/net-next/c/03df47c1bb39

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


